component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_minipet" joincolumn="itemtype_id" discriminatorvalue="MiniPet" accessors=true
    cache=false autowire=true {

	
	public string function _getItem_Type() { return 'MiniPet'; }
	

}