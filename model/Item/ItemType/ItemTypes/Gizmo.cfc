component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_gizmo" joincolumn="itemtype_id" discriminatorvalue="Gizmo" accessors=true
    cache=false autowire=true {

	property
		name="type"
		ormtype="string"
		type="string"
		length="250"
		index="type";
	
	public string function _getItem_Type() { return 'Gizmo'; }
	

}