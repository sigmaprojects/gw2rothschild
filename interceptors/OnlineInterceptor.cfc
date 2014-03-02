component name="AjaxEventInterceptor" extends="coldbox.system.interceptor" {
	
	void function configure() {
		//variables.UserService = getModel('UserService');
		return;
	}

	void function preProcess(Event, struct interceptData) {
		var rc = event.getCollection();
        var prc = event.getCollection(private=true);
        prc.isLoggedIn = false;

		var SessionStorage = getPlugin('SessionStorage');
		
		if( SessionStorage.exists('_user') ) {
			prc.isLoggedIn = true;
			prc._user = SessionStorage.getVar('_user');
		}

		return;
	}


	void function postProcess( event, interceptData ) {
		return;
	}


}