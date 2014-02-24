import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="Logger" inject="logbox:logger:{this}";
	property name="Controller" inject="coldbox";
	property name="interceptorService" inject="coldbox:interceptorService";

	public any function init(){
		super.init("User", "User.query.cache", false );
		return this;
	}
	
	public boolean function processLogin(Required Struct UserData, Required String Source) {
		if( structKeyExists(arguments.UserData,'id') ) {
			if( super.exists(arguments.UserData.ID) ) {
				var User = super.get( arguments.UserData.ID );
			} else {
				var User = super.new();
				User.setID( arguments.UserData.id );
				User.setCreated( Now() );
				User.setUpdated( Now() );
			}
			User.setLastLogin( Now() );
			super.save( User );
			
			var SessionStorage = controller.getPlugin('SessionStorage');
			SessionStorage.setVar('_user', User.toJSON() );
			return true;
		} else {
			return false;
		}
		return false;
	}

	public struct function _search(
		Any			itemflag_id,
		Any			gametype_id,
		Any 		restriction_id,
		Any			rarity_id,
		Any			itemtype_name,
		Any			level_range,
		Any			keyword,
		any			hasUpgradeComponent,
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



		if( structKeyExists(arguments,'Keyword') ) {
			var KeywordArray = ( IsArray(arguments.Keyword) ? arguments.Keyword : listToArray(arguments.Keyword) );
			
			for(var RawWord in KeywordArray) {
				var Word = trim(RawWord);
				if( Len(Word) gt 1 ) {
					var NameorCriteria = [];
					
					ArrayAppend(NameorCriteria, r.ilike( 'name', '%#explodeKeyword(Word)#%' ));

					// append disjunction to main criteria
					c.disjunction( NameorCriteria );
				}
			}
		}




		var _ItemTypeNames = extractParamArray(arguments,'itemtype_name');
		if( arrayLen(_ItemTypeNames) ) {
			if( !arrayContains(Aliases,'itemtype') ) { arrayAppend(Aliases,'itemtype'); c.createAlias( 'itemtype', 'it'); }
			c.isin('it.item_type', JavaCast('java.lang.String[]', _ItemTypeNames ) );
		}

		var _RarityIDs = extractParamArray(arguments,'rarity_id');
		if( arrayLen(_RarityIDs) ) {
			if( !arrayContains(Aliases,'rarity') ) { arrayAppend(Aliases,'rarity'); c.createAlias( 'rarity', 'rarity'); }
			c.isin('rarity.id', JavaCast('java.lang.Integer[]', _RarityIDs ) );
		}
		
		if( structKeyExists(arguments,'level_range') ) {
			var _LevelRange = ( isSimpleValue(arguments.level_range) ? listToArray(arguments.level_range) : arguments.level_range );
			if( arrayLen(_LevelRange) eq 1 ) {
				c.eq( 'level', javaCast('int',_LevelRange[1]) );
			} else if( arrayLen(_LevelRange) eq 2 ) {
				c.between( 'level', javaCast('int',_LevelRange[1]), javaCast('int',_LevelRange[2]) );
			}
		}
		
		if( structKeyExists(arguments,'hasUpgradeComponent') && isBoolean(arguments.hasUpgradeComponent) ) {
			if( arguments.hasUpgradeComponent ) {
				c.IsNotNull('suffix_item_id');
			} else {
				c.IsNull('suffix_item_id');
			}
		}
		
		if(
			listContainsNoCase(arguments.sortOrder,'upgradecomponent_price_difference asc') ||
			listContainsNoCase(arguments.sortOrder,'upgradecomponent_price_difference desc') ||
			arguments.sortOrder contains 'upgradecomponent_price_difference'
		) {
			c.isGt('last_min_sale',javaCast('int',1));
			c.IsNotNull('upgradecomponent_price_difference');
		}
		/*
		writedump(c);
		writedump( c.getnativeCriteria().toString() );
		abort;
		*/
		c.cache(false);
		results['count'] = c.count();
		results['entries'] = c.list(max=max, offset=offset, timeout=timeout, sortOrder=sortOrder, ignoreCase=ignoreCase, asQuery=asQuery);
		return results;
	}




}