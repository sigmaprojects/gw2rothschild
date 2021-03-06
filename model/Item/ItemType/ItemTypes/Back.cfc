component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_back" joincolumn="itemtype_id" discriminatorvalue="Back" accessors=true
    cache=false autowire=true {

	property
		name="suffix_item_id"
		ormtype="integer"
		type="numeric"
		index="suffix_item_id";

	property name="infusionslots"
		singularname="infusionslot"
		cfc="gw2rothchild.model.Item.InfusionSlot.InfusionSlot"
		linktable="itemtype_back_infusionslot_jn"
		inversejoincolumn="infusionslot_id"
		fkcolumn="itemtype_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";

	property name="itemattributes"
		singularname="itemattribute"
		cfc="gw2rothchild.model.Item.ItemAttribute.ItemAttribute"
		linktable="itemtype_back_itemattribute_jn"
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
		name="infusionslots"
		singularname="infusionslot"
		type="array"
		fieldtype="one-to-many"
		cfc="gw2rothchild.model.Item.InfusionSlot.InfusionSlot"
		fkColumn="infusionslot_id"
		cascade="save-update"
		lazy="true"
		remotingfetch="false"
		orderby="name asc";

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
	public string function _getItem_Type() { return 'Back'; }
	

}