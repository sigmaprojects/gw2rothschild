component singleton {

	property name="cfGW2DBAPI" inject="cfGW2DBAPI";
	
	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		return this;
	}
	
	public void function onDIComplete() {
		if( application.executorService.getStatus() neq 'started' ) { application.executorService.start(); }
		application.GW2DBUpdateTask = createObject("component", "gw2rothchild.model.Item.GW2DBUpdate.GW2DBUpdateTask").init( id="GW2DBUpdateTask", GW2DBUpdateService=THIS );
		application.executorService.scheduleWithFixedDelay("ItemUpdateTask", application.GW2DBUpdateTask, 26, 24, application.executorService.getObjectFactory().HOURS);
	}
	
	
	public any function updateItems() {
		setting enablecfoutputonly="true" requesttimeout="0" showdebugoutput="no";
		
		var taskID = 'GW2DBUS-UI-' & RandRange(100,100000);
		if( Logger.canInfo() ) { Logger.Info("GW2DBUpdateService.updateItems STARTED.  ID: #taskID#"); }
		
		var ItemAPI = cfGW2DBAPI;
		
		var Items = ItemAPI.getAllItems();
		
		for(var ItemData in Items) {
			updateItemData( ItemData, TaskID );
		}
		
		if( Logger.canInfo() ) { Logger.Info("GW2DBUpdateService.updateItems FINISHED.  ID: #taskID#"); }
		
		return;
	}

	public boolean function updateItemData(Required ItemData, Required String TaskID) {
		try {
			var q = new Query(datasource='gw2rothchild');
			q.setSQL('UPDATE item SET gw2db_external_id = :ExternalID WHERE item_id = :DataID');
			q.addParam(name="DataID",		value=ItemData.DataID,		cfsqltype="cf_sql_integer");
			q.addParam(name="ExternalID",	value=ItemData.ExternalID,	cfsqltype="cf_sql_integer");
			q.execute();
			return true;
		} catch(Any e) {
			if( Logger.canError() ) { Logger.Error('GW2DBUpdateService.updateItems error.  ID: #taskID#', e); }
			return false;
		}
		return false;
	}

}
