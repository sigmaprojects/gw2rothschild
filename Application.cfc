/**
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
*/
component{
	this.name = "GW2Rothchild";
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0,0,30,0);
	this.applicationTimeout = createTimeSpan(999,0,0,0);
	this.setClientCookies = true;

	
	COLDBOX_APP_ROOT_PATH	= getDirectoryFromPath(getCurrentTemplatePath());
	COLDBOX_APP_MAPPING		= "";
	COLDBOX_CONFIG_FILE		= "gw2rothchild.config.coldbox";
	COLDBOX_APP_KEY			= "";

	
	import coldbox.system.*;
	this.mappings["/gw2rothchild"] = COLDBOX_APP_ROOT_PATH;
	this.mappings["/cfconcurrent"] = COLDBOX_APP_ROOT_PATH & "lib/cfconcurrent";
	this.mappings["/model"] = COLDBOX_APP_ROOT_PATH & "model";
	this.mappings['/cfc']   = GetDirectoryFromPath(GetCurrentTemplatePath()) & "/lib/multilogin/cfc";
	//this.mappings["/"] = COLDBOX_APP_ROOT_PATH;
	
	this.javaSettings = {
		LoadPaths = ["/lib/java"],
		loadColdFusionClassPath = true,
		reloadOnChange = true,
		watchInterval = 100,
		watchExtensions = "jar,class,xml"
	};


	this.ormenabled = "true";
	this.datasource = "gw2rothchild";
	this.ormsettings = {
		datasource = "gw2rothchild",
		skipCFCWithError = false,
		autorebuild=true,
		dialect="org.hibernate.dialect.MySQL5InnoDBDialect",
		dbcreate="update",
		logSQL = false,
		flushAtRequestEnd = false,
		autoManageSession = false,
		eventHandling = true,
		cfclocation=["/gw2rothchild/model"],
		saveMapping = false,
		searchenabled = true,
		search = {
			autoindex = false,
			language = "English",
			indexDir = "/includes/cache/ormindex"
		}
	};
	this.ormsettings.secondarycacheenabled = false;



	// application start
	public boolean function onApplicationStart(){
		
		application.LexiconClient = new Lexicon.LexiconClient('39a02229c8ac585e21799a94f622a6cc21ddc365');
		
		//USED FOR TRACKING WHICH METHOD IS BEING USED TO LOGIN
		application.current_login_method = '';
		//USED FOR ALL INITIAL LOGIN CALLS
		application.login_state = '';
		//USED TO HOLD THE CURRENT ACCESS TOKEN
		application.current_access_token = '';
		//USED FOR ALL REDIRECTS BACK TO LOCAL PAGE
		application.redirect_uri = "https://gw2.sigmaprojects.org/multiLogin/processLogin";
		//FACEBOOK
		application.facebook_access_token = '';
		application.facebook_code = "";
		application.facebook_appid = application.LexiconClient.get("GW2RothChild_facebook_appid").data;
		application.facebook_secret = application.LexiconClient.get("GW2RothChild_facebook_secret").data;
		application.facebook_baseurl = "https://www.facebook.com/dialog/oauth";
		application.facebook_redirecturl = "https://gw2.sigmaprojects.org/multiLogin/processLogin";
		//GOOGLE
		application.google_access_token = "";
		application.google_code = "GW2Rothchild";
		application.google_client_id = application.LexiconClient.get("GW2RothChild_google_client_id").data;
		application.google_apikey = application.LexiconClient.get("GW2RothChild_google_apikey").data;
		application.google_secretkey = application.LexiconClient.get("GW2RothChild_google_secretkey").data;
		application.google_baseurl = "https://accounts.google.com/o/oauth2/auth";
		application.google_redirecturl = "https://gw2.sigmaprojects.org/multiLogin/processLogin";
		

		application.executorService = createObject("component", "gw2rothchild.lib.cfconcurrent.ScheduledThreadPoolExecutor")
			.init( serviceName = "ScheduledThreadPoolExecutorService", maxConcurrent = 50 );
		application.executorService.setLoggingEnabled( true );
		application.executorService.start();
		
		application.datasource = 'gw2rothchild';

		application.cbBootstrap = new Coldbox(COLDBOX_CONFIG_FILE,COLDBOX_APP_ROOT_PATH,COLDBOX_APP_KEY);
		application.cbBootstrap.loadColdbox();

		return true;
	}


	function onApplicationStop(){
		application.executorService.stop();
	}

	// request start
	public boolean function onRequestStart(String targetPage){
		
		application.datasource = 'gw2rothchild';
		
		if(structKeyExists(url,"ormreload")) {
			ORMReload();
		}

		// Bootstrap Reinit
		if( not structKeyExists(application,"cbBootstrap") or application.cbBootStrap.isfwReinit() ){
			try {
				application.executorService.stop();
			} catch(any e) {}
			
			lock name="coldbox.bootstrap_#this.name#" type="exclusive" timeout="5" throwonTimeout=true{
				structDelete(application,"cbBootStrap");
				application.cbBootstrap = new ColdBox(COLDBOX_CONFIG_FILE,COLDBOX_APP_ROOT_PATH,COLDBOX_APP_KEY,COLDBOX_APP_MAPPING);
			}
		}

		// ColdBox Reload Checks
		application.cbBootStrap.reloadChecks();

		//Process a ColdBox request only
		if( findNoCase('index.cfm',listLast(arguments.targetPage,"/")) ){
			application.cbBootStrap.processColdBoxRequest();
		}

		return true;
	}

	public void function onSessionStart(){
		application.cbBootStrap.onSessionStart();
	}

	public void function onSessionEnd(struct sessionScope, struct appScope){
		arguments.appScope.cbBootStrap.onSessionEnd(argumentCollection=arguments);
	}

	public boolean function onMissingTemplate(template){
		return application.cbBootstrap.onMissingTemplate(argumentCollection=arguments);
	}

}