component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_tool" joincolumn="itemtype_id" discriminatorvalue="Tool" accessors=true
    cache=false autowire=true {

	property
		name="type"
		ormtype="string"
		type="string"
		length="250"
		index="type";

	property
		name="charges"
		ormtype="integer"
		type="numeric"
		index="charges";


	public string function _getItem_Type() { return 'Tool'; }
	

}