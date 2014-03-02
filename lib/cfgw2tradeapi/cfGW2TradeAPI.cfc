/**
********************************************************************************
ColdFusion implementation of the GuildWarsTrade Public API

Author:		Don Quist
Web:		www.sigmaprojects.org
Email:		don@sigmaprojects.org
Github:		https://github.com/sigmaprojects/

GuildWarsTrade:
	http://www.guildwarstrade.com/
	http://www.guildwarstrade.com/api

********************************************************************************
*/
component output=false  {

	/**
	* Init
	* @URI The URL Endpoint for the API
	* @Version API Version)
	*/
	public cfGW2SpidyAPI function init(
		URI			= 'http://api.guildwarstrade.com',
		Version		= 1
	) {
		variables.APIURL = trim(arguments.URI) & '/' & arguments.Version & '/';
		variables.Version = trim(arguments.Version);
	}


	private any function formatAPIReponse(
		Required	String		Method,
		Required	Struct		Args,
		Required	Any			Reponse
	) {
		var Result = [];
		
		switch(arguments.Method) {
			case 'items': {
				
				Result = [];
				var x = 1;

				for(var RawData in arguments.Reponse) {
					
					var Item = createObject('java', 'java.util.LinkedHashMap').init();
					Item['id'] = RawData[1];
					arrayDeleteAt(RawData,1);
					for(var Value in Duplicate(RawData)) {
						Item[ listGetAt(arguments.Args.Fields,x) ] = Value;
						x++;
					}
					arrayAppend(Result,Item);
					x=1;
				}
				
			}
			case 'bulk/items.json': {
				
				Result = {};
				Result['items'] = [];
				Result['updated'] = arguments.Reponse.updated;  
				var x = 1;
				
				var Keys = Duplicate(arguments.Reponse.columns);
				//arrayDeleteAt(arguments.Reponse.Items,1);
				for(var ItemData in arguments.Reponse.items) {
					
					var Item = createObject('java', 'java.util.LinkedHashMap').init();
					for(var Value in ItemData) {
						item[ Keys[x] ] = Value;
						x++;
					}
					arrayAppend(Result.items,Item);
					x=1;
				}

				break;
			}
			case 'abc': {
				break;
			}
		}
		
		return Result;
	}


	/**
	* Get Items by ID
	* Results are cached every 5 minutes
	* Only the fields you need are sent in order to increase speed and save bandwidth.
	* Returns: list of items ordered by fields
	* @ids list of item ids seperated by commas. Limit of 100.
	* @fields  list of fields seperated by commas.  (name,sell,buy,supply,demand,category,img)	
	*/
	public array function getItemsByID(
		Required	String		ids,
					String		fields		= 'name,sell,buy,supply,demand,category,img'
	) {
		var args = {};
		for(var key in arguments) {
			args[lcase(key)] = arguments[key];
		}
		var response = call(method='items',Args=args);
		if( structKeyExists(response,'results') ) {
			return FormatAPIReponse('items',Arguments,response.results);
		} else {
			_throw(Detail='Expected array of Results',extendedInfo=response);
		}
	}

	/**
	* Get all Items
	* Columns may be added or rearranged in the future so don't assume it will remain the same.
	* Returns:
	* updated - Time this report was generated. Milliseconds since epoch.
	* columns - Name of the columns for each item.
	* items - List of items with data in the same order as columns
	*/
	public any function getItems() {
		var response = call(method='bulk/items.json');
		if( structKeyExists(response,'columns') ) {
			return FormatAPIReponse('bulk/items.json',Arguments,response);
		} else {
			_throw(Detail='Expected array of Results',extendedInfo=response);
		}
	}
	
	/**
	* Get all Item Names
	* Returns: List of items in the form [id, name]
	*/
	public array function getItemNames() {
		var response = call(method='bulk/items-names.json');
		if( structKeyExists(response,'results') ) {
			return response.results;
		} else {
			_throw(Detail='Expected array of Results',extendedInfo=response);
		}
	}


	private struct function call(
		Required	String		Method,
					Struct		Args		= {}
	) {
		var httpService = new http();

		httpService.setURL( variables.APIURL & arguments.Method );
		httpService.setMethod( 'GET' );

		for(var Key in arguments.Args) {
			if( structKeyExists(arguments.Args,Key) && !IsNull(arguments.Args[Key]) ) {
				httpService.addParam(type='url',name=Key,value=arguments.Args[Key]);
				writedump('Key:' & Key & '   Value:' & arguments.Args[Key]);
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