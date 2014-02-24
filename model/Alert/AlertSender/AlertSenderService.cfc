import coldbox.system.orm.hibernate.*;
component  singleton {

	
	property name="AlertService" inject="AlertService";
	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		variables.runCount = 0;
		return this;
	}
	
	public void function onDIComplete() {
		if( application.executorService.getStatus() neq 'started' ) { application.executorService.start(); }
		//application.AlertSenderTask = createObject("component", "gw2rothchild.model.Alert.AlertSender.AlertSenderTask").init( id="AlertSenderTask", AlertSenderService=THIS );
		//application.executorService.scheduleWithFixedDelay("AlertSenderTask", application.AlertSenderTask, 10, 10, application.executorService.getObjectFactory().MINUTES);
	}
	
	public any function run() {
		setting enablecfoutputonly="true" requesttimeout="0" showdebugoutput="no";
		variables.runCount++;
		
		var taskID = 'ASS-RUN-' & RandRange(100,100000);
		
		if( variables.runCount mod 10 && Logger.canInfo() ) { Logger.Info('AlertSenderService.run STARTED.  TaskID: #taskID#'); }
		
		try {
			
			AlertService.startAlertingWorker();
			
			if( variables.runCount mod 10 && Logger.canInfo() ) { Logger.Info('AlertSenderService.run FINISHED.  TaskID: #taskID#'); }
		} catch(Any e) {
			if( Logger.canError() ) { Logger.Error('AlertSenderService.run error.  TaskID: #taskID#', e); }
		}
	}



}
