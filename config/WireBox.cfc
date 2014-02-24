component extends="coldbox.system.ioc.config.Binder"{
	
	/**
	* Configure WireBox, that's it!
	*/
	function configure(){
		
		// The WireBox configuration structure DSL
		wireBox = {
			// Scope registration, automatically register a wirebox injector instance on any CF scope
			// By default it registeres itself on application scope
			scopeRegistration = {
				enabled = true,
				scope   = "application", // server, cluster, session, application
				key		= "wireBox"
			},

			// DSL Namespace registrations
			customDSL = {
				// namespace = "mapping name"
			},
			
			// Custom Storage Scopes
			customScopes = {
				// annotationName = "mapping name"
			},
			
			// Package scan locations
			scanLocations = [],
			
			// Stop Recursions
			stopRecursions = [],
			
			// Parent Injector to assign to the configured injector, this must be an object reference
			parentInjector = "",
			
			// Register all event listeners here, they are created in the specified order
			listeners = [
				{class="coldbox.system.aop.Mixer",
					properties={
						GenerationPath="/../coldbox/system/aop/tmp/",
						classMatchReload=false
					}
				}/*,
				{class="interceptors.WireboxInterceptor",
					properties={
					}
				}
				*/
			]
		};
		
		// Map Bindings below
		/*
		map("executorService").to("cfconcurrent.ScheduledThreadPoolExecutor")
			.initArg( name="serviceName",	value = "ScheduledThreadPoolExecutorService" )
			.initArg( name="maxConcurrent",	value = 0 )
			.into( this.SCOPES.APPLICATION )
			.asEagerInit();
		*/
		
		map("CFGW2SpidyAPI").to("lib.CFGW2SpidyAPI.CFGW2SpidyAPI").asSingleton();
		map("CFGW2TradeAPI").to("lib.CFGW2TradeAPI.CFGW2TradeAPI").asSingleton();
		map("CFGW2DBAPI").to("lib.CFGW2DBAPI.CFGW2DBAPI").asSingleton();
		map("CFGW2API").to("lib.CFGW2API.CFGW2API").asSingleton();
		
		//map("ItemService").to("model.Item.Item.ItemService").asSingleton();
		//map("ItemUpdateService").to("model.Item.ItemUpdate.ItemUpdateService").asSingleton().asEagerInit();
		
		/*
		*/
		map("BonusService").to("model.Item.Bonus.BonusService").asSingleton();
		map("GameTypeService").to("model.Item.GameType.GameTypeService").asSingleton();
		map("InfusionSlotService").to("model.Item.InfusionSlot.InfusionSlotService").asSingleton();
		map("ItemService").to("model.Item.Item.ItemService").into( this.scopes.request );
		map("ItemAttributeService").to("model.Item.ItemAttribute.ItemAttributeService").asSingleton();
		map("ItemFlagService").to("model.Item.ItemFlag.ItemFlagService").asSingleton();
		map("ItemTypeService").to("model.Item.ItemType.ItemTypeService").asSingleton();
		map("RarityService").to("model.Item.Rarity.RarityService").asSingleton();
		map("RestrictionService").to("model.Item.Restriction.RestrictionService").asSingleton();
		map("ItemUpdateService").to("model.Item.ItemUpdate.ItemUpdateService").asSingleton().asEagerInit();


		map("MarketDataService").to("model.MarketData.MarketData.MarketDataService").asSingleton();
		map("MarketDataUpdateService").to("model.MarketData.MarketDataUpdate.MarketDataUpdateService").asSingleton().asEagerInit();
		
		map("GW2DBUpdateService").to("model.Item.GW2DBUpdate.GW2DBUpdateService").asSingleton().asEagerInit();
		
		
		map("CraftDisciplineService").to("model.Craft.CraftDiscipline.CraftDisciplineService").asSingleton();
		map("RecipeService").to("model.Craft.Recipe.Recipe.RecipeService").asSingleton();
		map("RecipeFlagService").to("model.Craft.Recipe.RecipeFlag.RecipeFlagService").asSingleton();
		map("RecipeIngredientService").to("model.Craft.Recipe.RecipeIngredient.RecipeIngredientService").asSingleton();
		map("RecipeUpdateService").to("model.Craft.Recipe.RecipeUpdate.RecipeUpdateService").asSingleton().asEagerInit();
		
		map("UserService").to("model.User.User.UserService").asSingleton();
		
		map("WatchlistService").to("model.Watchlist.Watchlist.WatchlistService").asSingleton();
		
		map("AlertService").to("model.Alert.Alert.AlertService").into( this.scopes.request );
		map("AlertlogService").to("model.Alert.Alertlog.AlertlogService").into( this.scopes.request );

		map("AlertSenderService").to("model.Alert.AlertSender.AlertSenderService").asSingleton().asEagerInit();
		

		//writedump(application);
		//abort;
		/*
		application.executorService = createObject("component", "cfconcurrent.ScheduledThreadPoolExecutor")
			.init( serviceName = "ScheduledThreadPoolExecutorService", maxConcurrent = 0 );
		application.executorService.setLoggingEnabled( true );
		application.executorService.start();
		
		
		//schedule itemUpdateTask
		application.ItemUpdateTask = createObject("component", "model.Item.ItemUpdate.ItemUpdateTask").init( "ItemUpdateTask" );
		application.executorService.scheduleWithFixedDelay("ItemUpdateTask", application.ItemUpdateTask, 0, 30, application.executorService.getObjectFactory().SECONDS);
		*/

	}	

}