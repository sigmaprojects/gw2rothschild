component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_trophy" joincolumn="itemtype_id" discriminatorvalue="Trophy" accessors=true
    cache=false autowire=true {

	
	public string function _getItem_Type() { return 'Trophy'; }
	

}