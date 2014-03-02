component persistent="false" {

	results = { created = now(), createTick = getTickCount(), error={}, runCount = 0, lastTick=0, lastTS = '', uuid = createUUID() };
	runStatus = "running";

	function init( id, MarketDataUpdateService ){
		results.id = arguments.id;
		variables.AlertSenderService = arguments.AlertSenderService;
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
			var fc = createObject("java", "coldfusion.filter.FusionContext").init();
			fc.getCurrent().setApplicationName("GW2Rothchild");
			
			AlertSenderService.run();
			results.runCount++;
			writeLog("Inside run for id #results.id#! RunCount is now #results.runCount#.")
		} catch( any e ){
			writeLog("#results.id#!!!! #e.message#; #e.detail#");
			results.error = e;
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