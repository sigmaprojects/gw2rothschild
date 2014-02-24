component table="item" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true
    cache=false autowire=true {

	property name="id" column="item_id" ormtype="integer" type="numeric" fieldtype="id" generator="assigned";
	
	property
		name="name"
		ormtype="string"
		type="string"
		length="250"
		index="name";

	property
		name="description"
		ormtype="string"
		type="string"
		length="250"
		index="description";

	property
		name="icon_file_id"
		ormtype="integer"
		type="numeric"
		index="icon_file_id";

	property
		name="icon_file_signature"
		ormtype="string"
		type="string"
		length="250"
		index="icon_file_signature";

	property
		name="level"
		ormtype="integer"
		type="numeric"
		index="level";

	property
		name="vendor_value"
		ormtype="integer"
		type="numeric"
		index="vendor_value";

	property
		name="suffix_item_id"
		ormtype="integer"
		type="numeric"
		index="suffix_item_id";

	property
		name="upgradecomponent_price_difference"
		ormtype="integer"
		type="numeric"
		index="upgradecomponent_price_difference";

	property
		name="last_max_offer"
		ormtype="integer"
		type="numeric"
		index="last_max_offer";
		
	property
		name="last_min_sale"
		ormtype="integer"
		type="numeric"
		index="last_max_offer";

	property name="itemflags"
		singularname="itemflag"
		cfc="gw2rothchild.model.Item.ItemFlag.ItemFlag"
		linktable="item_itemflag_jn"
		fkcolumn="item_id"
		inversejoincolumn="itemflag_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";

	property name="gametypes"
		singularname="gametype"
		cfc="gw2rothchild.model.Item.GameType.GameType"
		linktable="item_gametype_jn"
		fkcolumn="item_id"
		inversejoincolumn="gametype_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";

	property name="restrictions"
		singularname="restriction"
		cfc="gw2rothchild.model.Item.Restriction.Restriction"
		linktable="item_restriction_jn"
		fkcolumn="item_id"
		inversejoincolumn="restriction_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";


	property
		name="rarity"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.Item.Rarity.Rarity"
		fkcolumn="rarity_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";


	property
		name="itemtype"
		fieldtype="one-to-one"
		cfc="gw2rothchild.model.Item.ItemType.ItemType"
		fkcolumn="itemtype_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";
	
	/*
	property
		name="suffix_item_id"
		ormtype="integer"  
		type="numeric"
		default="0"
		formula="SELECT it.suffix_item_id FROM itemtype_weapon it WHERE it.itemtype_id = v_itemtype_iditem_id)";
	*/
	/*
	property
		name="name_long"
		ormtype="text"  
		type="text"
		default=""
		formula="SELECT fn_getitem_full_name(item_id)";	
	*/


	/*
	property
		name="last_max_offer"
		ormtype="integer"  
		type="numeric"  
		default="0"
		formula="SELECT IFNULL(md.max_offer_unit_price,0) FROM marketdata md WHERE md.item_id = item_id ORDER BY created DESC LIMIT 1";
	
	property
		name="last_min_sale"
		ormtype="integer"  
		type="numeric"  
		default="0"
		formula="SELECT IFNULL(md.min_sale_unit_price,0) FROM marketdata md WHERE md.item_id = item_id ORDER BY created DESC LIMIT 1";
	*/
 
	property
		name="itemtype_name"
		ormtype="text"  
		type="text"
		default=""
		formula="SELECT IFNULL(it.item_type,'') FROM itemtype it WHERE it.itemtype_id = itemtype_id";

	property
		name="demand"
		ormtype="integer"  
		type="numeric"  
		default="0"
		formula="SELECT IFNULL(md.offer_availability,0) FROM marketdata md WHERE md.item_id = item_id ORDER BY created DESC LIMIT 1";

	property
		name="supply"
		ormtype="integer"  
		type="numeric"  
		default="0"
		formula="SELECT IFNULL(md.sale_availability,0) FROM marketdata md WHERE md.item_id = item_id ORDER BY created DESC LIMIT 1";
	/*
	property
		name="upgradecomponent_price_difference"
		ormtype="integer"
		type="numeric"
		default=""
		formula="SELECT (SELECT IFNULL(md.min_sale_unit_price,0) FROM marketdata md WHERE md.item_id = item_id ORDER BY created DESC LIMIT 1)-(SELECT IFNULL(md.max_offer_unit_price,0) FROM marketdata md WHERE md.item_id = suffix_item_id ORDER BY created DESC LIMIT 1)";
	*/

	/******** Start GW2 Spidy Specifc properties ******/
	property
		name="gw2db_external_id"
		ormtype="integer"
		type="numeric"
		index="gw2db_external_id"
		default="0"
		dbdefault="0";

	property
		name="img"
		ormtype="string"
		type="string"
		length="250"
		index="img";

	/*
	property
		name="rarity"
		ormtype="integer"
		type="numeric"
		index="rarity";
	*/

	property
		name="sub_type_id"
		ormtype="integer"
		type="numeric"
		index="sub_type_id"
		default="0"
		dbdefault="0";

	property
		name="type_id"
		ormtype="integer"
		type="numeric"
		index="type_id"
		default="0"
		dbdefault="0";
	/******** END GW2 Spidy Specifc properties ******/
	
	property
		name="created"
		ormtype="timestamp"
		type="date"
		index="created";
	
	property
		name="updated"
		ormtype="timestamp"
		type="date"
		index="updated";


	public boolean function hasUpgradeComponent() {
		if( !IsNull(getSuffix_Item_ID()) && IsNumeric(getSuffix_Item_ID()) && getSuffix_Item_ID() gt 0 ) {
			return true;
		}
		return false;
	}
	
	public gw2rothchild.model.Item.Item.Item function getUpgradeComponent() {
		try {
			return EntityLoadByPK('Item',getSuffix_Item_ID());
		} catch(Any e) {
			return new gw2rothchild.model.Item.Item.Item();
		}
	}

	public string function getImageSrc() {
		return "https://render.guildwars2.com/file/#getIcon_File_Signature()#/#getIcon_File_ID()#.png";
	}


	public date function getMarketUpdated() {
		try {
			var q = new Query(datasource='gw2rothchild',sql='SELECT md.created as created FROM marketdata md WHERE md.item_id = :item_id ORDER BY md.created DESC LIMIT 1');
			q.addParam(name="item_id",value=getID(),cfsqltype="cf_sql_integer");
			var r = q.execute().getResult();
			if( r.RecordCount eq 1 ) {
				return r['created'][1];
			} else {
				return now();
			}
		} catch(Any e) {
			return now();
		}
	}

	public string function getChatCode() {
		var Item_ID = javaCast('string',getID());
		var code = "[&" & 
			ToBase64(
				Chr(2) & 
				Chr(1) & 
				Chr(Item_ID % 256) & 
				Chr(Int(Item_ID / 256)) & 
				Chr(0) & 
				Chr(0)
			) &
			"]";
		code = replaceNoCase(code,'==','AA');
		return code;
	}

}