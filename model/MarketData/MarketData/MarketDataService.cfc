import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="ItemService" inject="ItemService";
	property name="cfGW2SpidyAPI" inject="cfGW2SpidyAPI";
	property name="Logger" inject="logbox:logger:{this}";


	public any function init(){
		super.init("MarketData", "MarketData.query.cache", true );
		return this;
	}


	public array function getDataForChart(
		Required	Numeric		Item_ID
	) {
		var MarketData = [];
		
		var marketQuery = new Query(datasource='gw2rothchild');
		//CAST(RPAD( UNIX_TIMESTAMP(md.created),13,'0') AS UNSIGNED) as created,
		var SQL = "
			SELECT
				CAST(RPAD( UNIX_TIMESTAMP(md.created),13,'0') AS SIGNED) as created,
				md.max_offer_unit_price as offer,
				md.min_sale_unit_price as sale,
				md.sale_availability as supply,
				md.offer_availability as demand
			FROM marketdata md
			WHERE md.item_id = :item_id
			AND md.created >= (NOW() - INTERVAL 3 MONTH)
		";
		marketQuery.addParam(name="item_id", value=arguments.Item_ID, cfsqltype="cf_sql_integer");
		marketQuery.setSQL( SQL );
		var marketResults = marketQuery.execute().getResult();
		
		for(var i=1; i lte marketResults.RecordCount; i++) {
			var n = [
				val(marketResults['created'][i]),
				marketResults['sale'][i],
				marketResults['offer'][i],
				marketResults['supply'][i],
				marketResults['demand'][i]
			];
			arrayAppend(MarketData,n);
		}
		/*
		writedump(marketResults);
		writedump(marketdata);
		abort;
		*/
		return MarketData;
	}


}