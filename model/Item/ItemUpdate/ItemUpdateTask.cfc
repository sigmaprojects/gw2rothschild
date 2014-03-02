component persistent="false" {

	results = { created = now(), createTick = getTickCount(), error={}, runCount = 0, lastTick=0, lastTS = '', uuid = createUUID() };
	runStatus = "running";

	function init( id, ItemUpdateService ){
		results.id = arguments.id;
		variables.ItemUpdateService = arguments.ItemUpdateService;
		variables.Logger = arguments.ItemUpdateService.getLogger();
		return this;
	}

	function pause(){
		runStatus = "paused";
	}

	function unPause(){
		runStatus = "running";
	}

	function run(){
		if( runStatus eq "paused" ){
			return;
		}
		
		try{
			/*
			var fc = createObject("java", "coldfusion.filter.FusionContext").init();
			fc.getCurrent().setApplicationName("GW2Rothchild");
			*/
			
			ItemUpdateService.updateItems();
			results.runCount++;
			
			try {
				if( variables.Logger.canInfo() ) { variables.Logger.Info('ItemUpdateTask info.  ID: #results.id#, RunCount is now #results.runCount#'); }
			} catch(Any e) {
				writeLog("Inside run for id #results.id#! RunCount is now #results.runCount#.")
			}
			
		} catch( any e ){
			results.error = e;
			try {
				if( variables.Logger.canError() ) { variables.Logger.Error('ItemUpdateTask error.  ID: #results.id#', e); }
			} catch(any e) {
				writeLog("#results.id#!!!! #e.message#; #e.detail#");
			}
		}
		results.lastTick = getTickCount();
		results.lastTS = now();

	}

	function getResults(){
		return results;
	}
	
	function getRunStatus() {
		return runStatus;
	}

}