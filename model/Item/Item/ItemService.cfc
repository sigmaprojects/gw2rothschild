import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="WatchlistService" inject="WatchlistService";
	property name="cfGW2SpidyAPI" inject="cfGW2SpidyAPI";
	property name="Logger" inject="logbox:logger:{this}";
	

	public any function init(){
		super.init("Item", "Item.query.cache", true );
		return this;
	}
	
	public array function suggest(Required String Keyword, Numeric Max=30) {
		var KeywordArray = listToArray(arguments.Keyword,' ');
		var q = new Query();
		var sql = "SELECT i.item_id as value, i.name as label FROM item i";

		var i = 1; 
		for(var K in KeywordArray) {
			 if(i eq 1) {
				 sql = sql & " HAVING label like :" & i;
			 } else {
			 	sql = sql & " AND label like :" & i;
			 }
			 q.addParam(name=i,value="#k#%",cfsqltype='cf_sql_varchar');
			 i++;
		}
		if( isNumeric(Max) ) {
			sql = sql & " ORDER BY label asc LIMIT #Max#";
		} else {
			sql = sql & " ORDER BY label asc LIMIT 30";
		}
		
		q.setSQL(sql);
		var QueryResults = q.execute().getResult();

		var Items = [];
		for(var i=1; i lte QueryResults.RecordCount; i++) {
			var ItemData = {};
			ItemData['value']	= QueryResults['value'][i];
			ItemData['label']	= QueryResults['label'][i];
			arrayAppend( Items, ItemData );
		}
		
		return Items;
	}


	public struct function _search(
		Any			item_id,
		Any			itemflag_id,
		Any			gametype_id,
		Any 		restriction_id,
		Any			rarity_id,
		Any			itemtype_name,
		Any			level_range,
		Any			keyword,
		any			hasUpgradeComponent,
		any			user,
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


		var _ItemIDs = extractParamArray(arguments,'item_id');
		if( arrayLen(_ItemIDs) ) {
			c.isin('id', JavaCast('java.lang.Integer[]', _ItemIDs ) );
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
		//c.cache(false);
		results['count'] = c.count();
		results['entries'] = c.list(max=max, offset=offset, timeout=timeout, sortOrder=sortOrder, ignoreCase=ignoreCase, asQuery=asQuery);
		return results;
	}



	public array function extractParamArray(
		Required	Struct	Args,
		Required	String	Key
	) {
		var Values = [];
		if( structKeyExists(Args,Key) ) {
			if( isArray(Args[key]) ) {
				Values = Args[key];
			} else if( isSimpleValue(Args[Key]) ) {
				Values = listToArray(Args[Key]);
			}
		}
		return Values;
	}


	public string function explodeKeyword(Required String Keyword='') {
		var str = trim(keyword);
		str = replaceNoCase(str,' ','%','all');
		str = replaceNoCase(str,'-','%','all');
		str = replaceNoCase(str,'+','%','all');
		str = replaceNoCase(str,"'",'%','all');
		str = replaceNoCase(str,chr(35),'','all');
		return str;
	}



}