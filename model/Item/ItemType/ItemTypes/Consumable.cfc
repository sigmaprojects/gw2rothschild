component persistent=true extends="gw2rothchild.model.Item.ItemType.ItemType" table="itemtype_consumable" joincolumn="itemtype_id" discriminatorvalue="Consumable" accessors=true
    cache=false autowire=true {

	property
		name="type"
		ormtype="string"
		type="string"
		length="250"
		index="type";
	
	property
		name="duration_ms"
		ormtype="integer"
		type="numeric"
		index="duration_ms";

	property
		name="description"
		ormtype="string"
		type="string"
		length="250"
		index="description";

	property
		name="unlock_type"
		ormtype="string"
		type="string"
		length="250"
		index="unlock_type";

	property
		name="color_id"
		ormtype="integer"
		type="numeric"
		index="color_id";
		
	property
		name="recipe_id"
		ormtype="integer"
		type="numeric"
		index="recipe_id";

	public string function _getItem_Type() { return 'Consumable'; }
	

}