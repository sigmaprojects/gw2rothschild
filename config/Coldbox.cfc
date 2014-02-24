component{

	// Configure ColdBox Application
	function configure(){

		// coldbox directives
		coldbox = {
			//Application Setup
			appName 				= "GW2Rothchild",
			eventName 				= "event",

			//Development Settings
			debugMode				= false,
			debugPassword			= "debug",
			reinitPassword			= "1",
			handlersIndexAutoReload = false,

			//Implicit Events
			defaultEvent			= "",
			requestStartHandler		= "Main.onRequestStart",
			requestEndHandler		= "",
			applicationStartHandler = "Main.onAppInit",
			applicationEndHandler	= "",
			sessionStartHandler 	= "",
			sessionEndHandler		= "",
			missingTemplateHandler	= "",

			//Extension Points
			UDFLibraryFile 				= "includes/helpers/ApplicationHelper.cfm",
			coldboxExtensionsLocation 	= "",
			modulesExternalLocation		= [],
			pluginsExternalLocation 	= "",
			viewsExternalLocation		= "",
			layoutsExternalLocation 	= "",
			handlersExternalLocation  	= "",
			requestContextDecorator 	= "gw2rothchild.model.RequestContext",

			//Error/Exception Handling
			exceptionHandler		= "",
			onInvalidEvent			= "",
			customErrorTemplate		= "",

			//Application Aspects
			handlerCaching 			= false,
			eventCaching			= false,
			proxyReturnCollection 	= false
		};

		// custom settings
		settings = {
			javaloader_libpath = "/gw2rothchild/lib/java",
			
			jsmin_enable = false,
			jsmin_cachelocation = "/includes/cache",
			
			PagingMaxRows = 5,
			PagingBandGap = 3
		};


		// environment settings, create a detectEnvironment() method to detect it yourself.
		// create a function with the name of the environment so it can be executed if that environment is detected
		// the value of the environment is a list of regex patterns to match the cgi.http_host.
		environments = {
			//development = "^cf8.,^railo."
		};

		// Module Directives
		modules = {
			//Turn to false in production
			autoReload = false,
			// An array of modules names to load, empty means all of them
			include = [],
			// An array of modules names to NOT load, empty means none
			exclude = []
		};

		//LogBox DSL
		logBox = {
			// Define Appenders
			appenders = {
				coldboxTracer = { class="coldbox.system.logging.appenders.ColdboxTracerAppender" },
				
				AsyncDBAppender = {
					class="coldbox.system.logging.appenders.AsyncDBAppender",
					properties = {
						dsn = "gw2rothchild", table="logs", autocreate=true, textDBType="longtext"
					}
				}
			},
			// Root Logger
			root = { levelMin="FATAL", levelMax="WARN", appenders="AsyncDBAppender,coldboxTracer" },
			categories = {
				'model.Item.Item.ItemService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.Item.ItemUpdate.ItemUpdateService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.MarketData.MarketData.MarketDataService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.MarketData.MarketDataUpdate.MarketDataUpdateService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.Craft.Recipe.RecipeUpdate.RecipeUpdateService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.User.User.UserService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.Item.GW2DBUpdate.GW2DBUpdateService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.Alert.Alert.AlertService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" },
				'model.Alert.AlertSender.AlertSenderService' = { levelMin="FATAL", levelMax="INFO", appenders="AsyncDBAppender" }
			},
			// Implicit Level Categories
			OFF = ["coldbox.system"]
		};

		//Layout Settings
		layoutSettings = {
			defaultLayout = "",
			defaultView   = ""
		};
		
		
			mailSettings = Application.LexiconClient.get('GW2RothChild_mailSettings').data;
		try {
		} catch(any e) {
			
		}

		//Interceptor Settings
		interceptorSettings = {
			throwOnInvalidStates = false,
			customInterceptionPoints = ""
		};

		//Register interceptors as an array, we need order
		interceptors = [
			//SES
			{class="coldbox.system.interceptors.SES",
			 properties={}
			},
			{class="interceptors.OnlineInterceptor",
			 properties={}
			}
		];

		// Object & Form Validation
		validation = {
			// manager = "class path" or none at all to use ColdBox as the validation manager
			// The shared constraints for your application.
			sharedConstraints = {
				// EX
				// myForm = { name={required=true}, age={type="numeric",min="18"} }
			}
		};


		orm = {
			injection = {
				enabled = true,
				include = "",
				exclude = ""
			}
		};

		datasources = {
			gw2rothchild = {name="gw2rothchild", dbType="mysql"}
		};

	}

}