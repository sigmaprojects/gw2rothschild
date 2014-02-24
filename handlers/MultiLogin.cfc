component output="false" singleton{	function processLogin(event,rc,prc){		var ST = getPlugin('SessionStorage');		if( !ST.exists('ref') ) {			ST.setVar('ref',cgi.hTTP_REFERER);		}		Event.setView('multilogin/processLogin');	}		function success(event,rc,prc) {		var ST = getPlugin('SessionStorage');		var nextURL = Duplicate(ST.getVar('ref','/'));		ST.deleteVar('ref');		location(url=nextURL,addtoken=false);		event.noRender();
	}	function logout(event,rc,prc) {		var ST = getPlugin('SessionStorage');		ST.deleteVar('_user');		location(url='/',addtoken=false);		//setNextEvent('main.index');
	}	function error(event,rc,prc) {		Event.setView('multilogin/error');
	}		function test(event,rc,prc) {		Event.setView('multilogin/test');
	}}