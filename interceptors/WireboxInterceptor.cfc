component{

	function configure(injector,properties){
		variables.injector = arguments.injector;
		variables.properties = arguments.properties;
		
		log = variables.injector.getLogBox().getLogger( this );
	}
	
	function beforeInjectorShutdown(event, interceptData){
		var injector = arguments.interceptData.injector;
	}
	
	function afterInstanceCreation(event, interceptData){
		var injector = arguments.interceptData.injector;
		var target = arguments.interceptData.target;
		var mapping = arguments.interceptData.mapping;
		
		//log.info("afterInstanceCreation: #mapping.getName()#.");
		
	}
	
	function afterInstanceInitialized(event, interceptData){
		var injector = arguments.interceptData.injector;
		var target = arguments.interceptData.target;
		var mapping = arguments.interceptData.mapping;


		//log.info("afterInstanceInitialized: #mapping.getName()#.");
	}

	function afterInstanceAutowire(event, interceptData){
		var injector = arguments.interceptData.injector;
		var target = arguments.interceptData.target;
		var mapping = arguments.interceptData.mapping;
		var targetID = arguments.interceptData.targetID;

		//log.info("afterInstanceInitialized: #mapping.getName()#.  ID: #targetID#");
		
		/*
		//schedule itemUpdateTask
		application.ItemUpdateTask = createObject("component", "model.Item.ItemUpdate.ItemUpdateTask").init( "ItemUpdateTask" );
		application.executorService.scheduleWithFixedDelay("ItemUpdateTask", application.ItemUpdateTask, 0, 30, application.executorService.getObjectFactory().SECONDS);
		*/
		
	}
	
}