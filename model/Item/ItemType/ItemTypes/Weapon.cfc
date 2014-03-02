component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_weapon" joincolumn="itemtype_id" discriminatorvalue="Weapon" accessors=true
    cache=false autowire=true {

	property
		name="type"
		ormtype="string"
		type="string"
		length="250"
		index="type";
		
	property
		name="damage_type"
		ormtype="string"
		type="string"
		length="250"
		index="damage_type";
		
	property
		name="min_power"
		ormtype="integer"
		type="numeric"
		index="min_power";

	property
		name="max_power"
		ormtype="integer"
		type="numeric"
		index="max_power";

	property
		name="defense"
		ormtype="integer"
		type="numeric"
		index="defense";

	property
		name="suffix_item_id"
		ormtype="integer"
		type="numeric"
		index="suffix_item_id";

	property name="itemattributes"
		singularname="itemattribute"
		cfc="gw2rothchild.model.Item.ItemAttribute.ItemAttribute"
		linktable="itemtype_weapon_itemattribute_jn"
		inversejoincolumn="itemattribute_id"
		fkcolumn="itemtype_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";

/*
	property
		name="itemattributes"
		singularname="itemattribute"
		type="array"
		fieldtype="one-to-many"
		cfc="gw2rothchild.model.Item.ItemAttribute.ItemAttribute"
		fkColumn="itemattribute_id"
		cascade="save-update"
		lazy="true"
		remotingfetch="false"
		orderby="attribute asc";
*/

	public string function _getItem_Type() { return 'Weapon'; }
	

}