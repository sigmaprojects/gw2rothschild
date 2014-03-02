component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_craftingmaterial" joincolumn="itemtype_id" discriminatorvalue="CraftingMaterial" accessors=true
    cache=false autowire=true {

	
	public string function _getItem_Type() { return 'CraftingMaterial'; }
	

}