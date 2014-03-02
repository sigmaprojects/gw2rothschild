import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="Logger" inject="logbox:logger:{this}";
	property name="Controller" inject="coldbox";
	property name="interceptorService" inject="coldbox:interceptorService";
	property name="ItemService" inject="ItemService";
	property name="UserService" inject="UserService";
	property name="WatchlistService" inject="WatchlistService";

	public any function init(){
		super.init("Alertlog", "Alertlog.query.cache", false );
		return this;
	}
	

	public struct function _search(
		Any			user_id,
		Any			item_id,
		Numeric		Max					= 50,
		Numeric		Offset				= 0,
		Numeric		Timeout				= 0,
		String		sortOrder			= 'created desc',
		Boolean		ignoreCase			= true,
		Boolean		asQuery				= false
	) {
		var results = {};
		results['count'] = 0;
		results['entries'] = [];
		var c = newCriteria();
		var r = c.restrictions;
		
		var Aliases = [];



		var _ItemIDs = extractParamArray(arguments,'item_id');
		if( arrayLen(_ItemIDs) ) {
			if( !arrayContains(Aliases,'item') ) { arrayAppend(Aliases,'item'); c.createAlias( 'item', 'i'); }
			c.isin('i.item_id', JavaCast('java.lang.Integer[]', _ItemIDs ) );
		}

		var _UserIDs = extractParamArray(arguments,'user_id');
		if( arrayLen(_UserIDs) ) {
			if( !arrayContains(Aliases,'user') ) { arrayAppend(Aliases,'user'); c.createAlias( 'user', 'u'); }
			c.isin('u.user_id', JavaCast('java.lang.Integer[]', _UserIDs ) );
		}
		
		c.cache(false);
		results['count'] = c.count();
		results['entries'] = c.list(max=max, offset=offset, timeout=timeout, sortOrder=sortOrder, ignoreCase=ignoreCase, asQuery=asQuery);
		return results;
	}




}