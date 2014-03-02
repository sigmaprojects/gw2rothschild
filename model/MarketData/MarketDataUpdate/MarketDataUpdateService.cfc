import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="ItemService" inject="ItemService";
	property name="MarketDataService" inject="MarketDataService";
	property name="cfGW2SpidyAPI" inject="cfGW2SpidyAPI";
	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("MarketDataUpdate", "MarketDataUpdate.query.cache", true );
		return this;
	}
	
	public void function onDIComplete() {
		if( application.executorService.getStatus() neq 'started' ) { application.executorService.start(); }
		//application.MarketDataUpdateTask = createObject("component", "gw2rothchild.model.MarketData.MarketDataUpdate.MarketDataUpdateTask").init( id="MarketDataUpdateTask", MarketDataUpdateService=THIS );
		//application.executorService.scheduleWithFixedDelay("MarketDataUpdateTask", application.MarketDataUpdateTask, 20, 60, application.executorService.getObjectFactory().MINUTES);
	}
	
	public any function getLastUpdated() {
		var updates = ORMExecuteQuery('FROM MarketDataUpdate ORDER BY created DESC limit 1');
		if( isArray(updates) && arrayLen(updates) ) {
			var MarketDataUpdate = updates[1];
			return MarketDataUpdate.getCreated();
		}
		return;
	}
	
	public any function updateMarketData() {
		setting enablecfoutputonly="true" requesttimeout="2700" showdebugoutput="no";
		
		var taskID = 'MDUS-UMD-' & RandRange(100,100000);
		
		if( Logger.canInfo() ) { Logger.Info('MarketDataUpdateService.updateMarketData STARTED.  TaskID: #taskID#'); }
		
		try {

			var marketDataQueryService = new Query();
			marketDataQueryService.setDatasource( 'gw2rothchild' );
			
			var SQL = createObject("java","java.lang.StringBuffer");
			sql.append( "INSERT IGNORE INTO marketdata (item_id,max_offer_unit_price,min_sale_unit_price,offer_availability,offer_price_change_last_hour,price_last_changed,sale_availability,sale_price_change_last_hour) VALUES " );
			
			var Items = cfGW2SpidyAPI.getAllItems();
			var itemsLength = arrayLen(Items);

			for(var i=1; i lte itemsLength;i++) {
				try {
					var ItemData = Items[i];
					
					var price_last_changed_format = Trim(ReplaceNoCase(ItemData.price_last_changed,'UTC','','all'));
					
					
					if( i eq 1 ) {
						sql.append("(#ItemData.data_id#,#ItemData.max_offer_unit_price#,#ItemData.min_sale_unit_price#,#ItemData.offer_availability#,#ItemData.offer_price_change_last_hour#,'#price_last_changed_format#',#ItemData.sale_availability#,#ItemData.sale_price_change_last_hour#)");
					} else {
						sql.append(", (#ItemData.data_id#,#ItemData.max_offer_unit_price#,#ItemData.min_sale_unit_price#,#ItemData.offer_availability#,#ItemData.offer_price_change_last_hour#,'#price_last_changed_format#',#ItemData.sale_availability#,#ItemData.sale_price_change_last_hour#)");
					}
					
					/*
					var marketDataQueryService = new Query();
					marketDataQueryService.setDatasource( 'gw2rothchild' );
					var SQL = 'INSERT IGNORE INTO marketdata (item_id,max_offer_unit_price,min_sale_unit_price,offer_availability,offer_price_change_last_hour,price_last_changed,sale_availability,sale_price_change_last_hour) VALUES (:item_id,:max_offer_unit_price,:min_sale_unit_price,:offer_availability,:offer_price_change_last_hour,:price_last_changed,:sale_availability,:sale_price_change_last_hour)';
					marketDataQueryService.setSQL( SQL );
			
					marketDataQueryService.addParam(name="item_id",							value=ItemData.data_id,							cfsqltype="cf_sql_integer"); 
					marketDataQueryService.addParam(name="max_offer_unit_price",			value=ItemData.max_offer_unit_price,			cfsqltype="cf_sql_integer"); 
					marketDataQueryService.addParam(name="min_sale_unit_price",				value=ItemData.min_sale_unit_price,				cfsqltype="cf_sql_integer"); 
					marketDataQueryService.addParam(name="offer_availability",				value=ItemData.offer_availability,				cfsqltype="cf_sql_integer"); 
					marketDataQueryService.addParam(name="offer_price_change_last_hour",	value=ItemData.offer_price_change_last_hour,	cfsqltype="cf_sql_integer"); 
					marketDataQueryService.addParam(name="price_last_changed",				value=price_last_changed_format,				cfsqltype="cf_sql_timestamp"); 
					marketDataQueryService.addParam(name="sale_availability",				value=ItemData.sale_availability,				cfsqltype="cf_sql_integer"); 
					marketDataQueryService.addParam(name="sale_price_change_last_hour",		value=ItemData.sale_price_change_last_hour,		cfsqltype="cf_sql_integer"); 
			
					marketDataQueryService.execute();
					*/
					
				} catch(Any e) {
					if( Logger.canError() ) { Logger.Error('MarketDataUpateService.updateMarketData loop error.  TaskID: #taskID#', e); }
				}
			}

			marketDataQueryService.setSQL( SQL.toString() );
			marketDataQueryService.execute();
			
			
			var marketDataUpdateQueryService = new Query();
			marketDataUpdateQueryService.setDatasource( 'gw2rothchild' );
			marketDataUpdateQueryService.setSQL( 'INSERT INTO marketdataupdate (updated_count,created_count,successful) VALUES (0,0,true)' );
			var itemUpdateResult = marketDataUpdateQueryService.execute().getResult();
		
			if( Logger.canInfo() ) { Logger.Info('MarketDataUpdateService.updateMarketData FINISHED.  TaskID: #taskID#'); }
		} catch(any e) {
			if( Logger.canError() ) { Logger.Error('MarketDataUpateService.updateMarketData error.  TaskID: #taskID#', e); }
		}
	}


	public any function getLogger() {
		return Logger;
	}


}
