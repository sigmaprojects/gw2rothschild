component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_bag" joincolumn="itemtype_id" discriminatorvalue="Bag" accessors=true
    cache=false autowire=true {

	property
		name="no_sell_or_sort"
		ormtype="integer"
		type="numeric"
		index="no_sell_or_sort";

	property
		name="size"
		ormtype="integer"
		type="numeric"
		index="size";

	public string function _getItem_Type() { return 'Bag'; }
	

}