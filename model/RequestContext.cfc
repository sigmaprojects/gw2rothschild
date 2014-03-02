component output=false name="RequestContextDecorator" extends="coldbox.system.web.context.requestContextDecorator" autowire=true {

	public void function configure() {
		buildAssetScaffold();
		return;
	}
	
	public void function addMeta(Required String nametype, String content='') {
		if( !len(trim(arguments.content)) ) { return; }
		var prc = getRequestContext().getCollection(private = true);
		for(var i=1; i lte arrayLen(prc.meta); i++) {
			if( prc.meta[i].name EQ trim(arguments.nametype) ) {
				arrayDeleteAt(prc.meta,i);
				i--;
			}
		}
		var meta = {
			name	= trim(arguments.nametype),
			content = trim(arguments.content)
		};
		arrayAppend(prc.meta,meta);
	}
	public array function getMeta() {
		var prc = getRequestContext().getCollection(private = true);
		return prc.meta;
	}


	public void function addAsset(required string path,string method='queue',boolean fullPathProvided=true) {
		// Grab the Request Context from within the Event Object
		var prc = getRequestContext().getCollection(private = true);
		// Organize by the file extention
		var type = listLast(path, '.');
		// Replace the following with the relative directories from your
		// web root
		if (!fullPathProvided) {
			path = (type == 'css') ? '/assets/style/' & path : '/assets/script/' & path;
		}
		
		if( left(path,1) neq '/' && len(path) gte 8 && left(path,8) is 'includes' ) {
			path = '/' & path;
		}
 
		// Prevent duplicates
		if (!arrayContains(prc.assets[method][type], path)) {
			arrayAppend(prc.assets[method][type], path);
		}
 
		return;
	}
    
	public void function addAssets(required string paths,string method='queue',boolean fullPathProvided=true) {
		var list = listToArray(paths, ',');
		// Add each path individually
		var n = arraylen(list);
		var i = 0;
		for (i=1; i <= n; i++) {
			addAsset(path=trim(list[i]),method=method,fullPathProvided=fullPathProvided);
		}
		return;
	}
 
	public array function getAssets(required string type,string method='queue') {
		var prc = getRequestContext().getCollection(private = true);
		return prc.assets[method][type];
	}

	public void function clearAssets() {
		buildAssetScaffold();
		return;
	}
 
	// Private ----------------------------------------------------------------------
 
	/** Used to help construct the foundation to manage assets. */
	private void function buildAssetScaffold() {
		var prc = getRequestContext().getCollection(private = true);
		prc.assets = {};
		// The queue allows the assets to be include by path into the page.
		prc.assets.queue = { js = [], css = []};
		// Includes allow the content of an asset to be injected into the page.
		prc.assets.include.js   = [];
		// meta tags
		prc.meta = [];
		addMeta('description','A community for all fiber artists who love to bring their colored strands to life.');
		return;
	}


	public numeric function getNumericValue(required string Name, any defaultValue=0) {
		var originalValue = '';
		//Check if the value exists
		if( valueExists(arguments.name) ){
			//Get the original value
			originalValue = getRequestContext().getValue(argumentCollection=arguments);
		} else {
			originalValue = arguments.defaultValue;
		}
		if(!IsNumeric(originalValue)) {
			originalValue = 0;
		}

		//Return either the value or an empty string.
		return originalValue; 
	}
	

	public string function generateMetaDescription(Required String input, Boolean Markdown=false) {
		var str = arguments.input;
		if( arguments.Markdown ) {
			str = getController().getPlugin(Plugin='Markdown',customPlugin=true).toHTML( str );
		}
		str = _stripHTML(str);
		return str;
	}


	public any function getReferrer(Boolean AppendQS=true) {
		try {
			if(arguments.AppendQS) {
				return cgi.HTTP_REFERER & '?' & CGI.QUERY_STRING;
			} else {
				return cgi.HTTP_REFERER;
			}
		} catch(e Any) {
			return '';
		}
	}


	public string function friendlyUrl(title) {
		title = replaceNoCase(title,"&amp;","and","all"); //replace &amp;
		title = replaceNoCase(title,"&","and","all"); //replace &
		title = replaceNoCase(title,"'","","all"); //remove apostrophe
		title = reReplaceNoCase(trim(title),"[^a-zA-Z]","-","ALL");
		title = reReplaceNoCase(title,"[\-\-]+","-","all");
		//Remove trailing dashes
		if(right(title,1) eq "-") {
			title = left(title,len(title) - 1);
		}
		if(left(title,1) eq "-") {
			title = right(title,len(title) - 1);
		}
    	return lcase(title);
	}

	private string function _stripHTML(String input) event=false {
		var str = arguments.input;
		str = reReplaceNoCase(str, "<*style.*?>(.*?)</style>"," ","all");
		str = reReplaceNoCase(str, "<*script.*?>(.*?)</script>"," ","all");

		str = reReplaceNoCase(str, "<.*?>"," ","all");
		//get partial html in front
		str = reReplaceNoCase(str, "^.*?>"," ");
		//get partial html at end
		str = reReplaceNoCase(str, "<.*$"," ");
		return trim(str);
	}

}
