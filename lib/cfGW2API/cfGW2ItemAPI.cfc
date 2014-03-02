/**
********************************************************************************
ColdFusion implemenation of the GW2 Public API

Author:		Don Quist
Web:		www.sigmaprojects.org
Email:		don@sigmaprojects.org
Github:		https://github.com/sigmaprojects/

********************************************************************************
*/
component output=false extends="cfGW2API" {

	/**
	* Init
	* @URI The URL Endpoint for the API
	* @Version API Version
	* @Format the default return format for responses (json/xml)
	*/
	public cfGW2ItemAPI function init() {
		return this;
	}


	public array function getItems() {
		var response = super.call(
			method	= 'items'
		);
		if( structKeyExists(response,'items') && isArray(response.items) ) {
			return response.items;
		} else {
			_throw(Detail='Expected array of Recipes',extendedInfo=response);
		}
	}

	public struct function getItemDetail(
		Required	Numeric		item_id
	) {
		var response = super.call(
			method	= 'item_details',
			args	= arguments
		);
		if( isStruct(response) && !StructKeyExists(response,'error') ) {
			return response;
		} else {
			_throw(Detail='Expected struct of Recipe Data',extendedInfo=response);
		}
	}


}