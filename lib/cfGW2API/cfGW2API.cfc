/**
********************************************************************************
ColdFusion implemenation of the ArenaNet GW2 Public API

Author:		Don Quist
Web:		www.sigmaprojects.org
Email:		don@sigmaprojects.org
Github:		https://github.com/sigmaprojects/

********************************************************************************
*/
component output=false  {

	variables.APIURL = 'https://api.guildwars2.com/v1/';
	variables.Version = 1;
	variables.Format = 'json';

	/**
	* Init
	* @URI The URL Endpoint for the API
	* @Version API Version
	* @Format the default return format for responses (json/xml)
	*/
	public cfGW2API function init(
		URI			= 'https://api.guildwars2.com/',
		Version		= 1,
		Format		= 'json'
	) {
		variables.APIURL = trim(arguments.URI) & 'v' & arguments.Version & '/';
		variables.Version = trim(arguments.Version);
		variables.Format = trim(arguments.Format);
		return this;
	}

	public string function getAPIURL() {
		return variables.APIURL;
	}
	public string function getVersion() {
		return variables.Version;
	}
	public string function getFormat() {
		return variables.Format;
	}
	
	public cfGW2RecipeAPI function getRecipeAPI() {
		if( !structKeyExists(variables,'cfGW2RecipeAPI') ) {
			variables.cfGW2RecipeAPI = new cfGW2RecipeAPI();
		}
		return variables.cfGW2RecipeAPI;
	}

	public cfGW2ItemAPI function getItemAPI() {
		if( !structKeyExists(variables,'cfGW2ItemAPI') ) {
			variables.cfGW2ItemAPI = new cfGW2ItemAPI();
		}
		return variables.cfGW2ItemAPI;
	}


	package struct function call(
		Required	String		Method,
					Struct		Args		= {},
					String		Verb		= 'GET',
					String		Format		= variables.format
	) {
		var httpService = new http();
		var _Verb = ( arguments.verb eq 'POST' && StructCount(arguments.Args) ? 'POST' : 'GET' );
		var paramType = ( _Verb eq 'GET' ? 'url' : 'formfield' );

		httpService.setURL( variables.APIURL & arguments.Method & '.' & arguments.Format );
		httpService.setMethod( _Verb );

		for(var Key in arguments.Args) {
			if( structKeyExists(arguments.Args,Key) && !IsNull(arguments.Args[Key]) ) {
				httpService.addParam(type=paramType,name=lcase(Key),value=arguments.Args[Key]);
			} 
		}

		var result = httpService.send().getPrefix();

		if( result.statuscode contains '200' && structKeyExists(result,'filecontent') && isJSON(result.filecontent) ) {
			
			return deserializeJSON( result.filecontent );
			
		} else {
			_throw(Detail='Unexpected Response from API',extendedInfo=result.filecontent);
		}
	}



	package void function _throw(
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