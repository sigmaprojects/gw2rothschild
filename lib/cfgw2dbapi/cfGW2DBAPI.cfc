/**
********************************************************************************
ColdFusion implemenation of the GW2 DB Public API

Author:		Don Quist
Web:		www.sigmaprojects.org
Email:		don@sigmaprojects.org
Github:		https://github.com/sigmaprojects/
********************************************************************************
*/
component output=false  {

	/**
	* Init
	* @URI The URL Endpoint for the API
	* @Version API Version
	* @Format the default return format for responses (json/xml)
	*/
	public cfGW2DBAPI function init(
		URI			= 'http://www.gw2db.com/json-api/',
		GUID		= 'test'//Application.LexiconClient.get('GW2RothChild_cfGW2DBAPI_GUID').data
	) {
		
		variables.APIURL = trim(arguments.URI);
		variables.GUID = trim(arguments.GUID);
		return this;
	}

	/**
	* Get all Items
	*/
	public array function getAllItems(
	) {
		var response = call(method='items');
		if( isArray(response) ) {
			return response;
		} else {
			_throw(Detail='Expected array of Results',extendedInfo=response);
		}
	}

	/**
	* Get Recipes
	* Results are cached server side for up to 24 hours
	* @type either an ID of a discipline or use *all*
	* @Page page offset
	*/
	public struct function getRecipes(
					String		type		= 'all',
					Numeric		Page		= 1
	) {
		var response = call(method='recipes',Args=arguments,URIAppend=URLEncodedFormat(arguments.type) & '/' & arguments.Page);
		if( IsStruct(response) && StructCount(response) && structKeyExists(response,'results') ) {
			return response;
		} else {
			_throw(Detail='Expected struct containing at least an Array of Results',extendedInfo=response);
		}
	}


	private any function call(
		Required	String		Method,
					Struct		Args		= {},
					String		Verb		= 'GET',
					String		URIAppend	= ''
	) {
		var httpService = new http();
		var _Verb = ( arguments.verb eq 'POST' && StructCount(arguments.Args) ? 'POST' : 'GET' );
		var paramType = ( _Verb eq 'GET' ? 'url' : 'formfield' );

		httpService.setURL( variables.APIURL & arguments.Method );
		httpService.setMethod( _Verb );
		
		arguments.Args['GUID'] = variables.GUID;
		
		for(var Key in arguments.Args) {
			if( structKeyExists(arguments.Args,Key) && !IsNull(arguments.Args[Key]) ) {
				httpService.addParam(type=paramType,name=Key,value=arguments.Args[Key]);
			} 
		}

		var result = httpService.send().getPrefix();

		if( result.statuscode contains '200' && structKeyExists(result,'filecontent') && isJSON(result.filecontent) ) {
			
			return deserializeJSON( result.filecontent );
			
		} else {
			_throw(Detail='Unexpected Response from API',extendedInfo=result.filecontent);
		}
	}


	private void function _throw(
		String		Message			= 'Unexpected Response',
		String		Type			= 'Application',
		String		Detail			= '',
		Any			extendedInfo	= ''
	) {
		throw(
			message			= arguments.Message,
			type			= arguments.Message,
			detail			= arguments.Detail,
			extendedInfo	= ( IsSimpleValue(arguments.ExtendedInfo) ? arguments.extendedInfo : serializeJson(arguments.extendedInfo) )
		);
	}


}