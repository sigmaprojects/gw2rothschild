import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("ItemType", "ItemType.query.cache", true );
		mapItemTypeLocations();
		return this;
	}

	public boolean function nameExists(Required String Name) {
		if( super.countWhere(name=trim(arguments.Name)) ) {
			return true;
		}
		return false;
	}
	
	public any function getByName(Required String Name) {
		var Obj = super.findWhere(criteria={name=trim(arguments.Name)});
		return Obj;
	}

	public any function getOrCreate(Required String Name) {
		if( nameExists(Name) ) {
			return getByName(Name);
		}
		var Obj = super.new();
		Obj.setName(Name);
		super.save(Obj);
		EntityReload(Obj);
		return Obj;
	}


	public any function newByItemType(Required String ItemType) {
		var t = trim(ItemType);
		if( structKeyExists(variables.itemtypelocations,t) ) {
			return createObject('component',variables.itemtypelocations[t]);
		}
		return super.new();
	}

	private void function mapItemTypeLocations() {
		variables.itemtypelocations = {
			Armor				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Armor',
			Back				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Back',
			Bag					= 'gw2rothchild.model.Item.ItemType.ItemTypes.Bag',
			Consumable			= 'gw2rothchild.model.Item.ItemType.ItemTypes.Consumable',
			Container			= 'gw2rothchild.model.Item.ItemType.ItemTypes.Container',
			CraftingMaterial	= 'gw2rothchild.model.Item.ItemType.ItemTypes.CraftingMaterial',
			Gathering			= 'gw2rothchild.model.Item.ItemType.ItemTypes.Gathering',
			Gizmo				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Gizmo',
			MiniPet				= 'gw2rothchild.model.Item.ItemType.ItemTypes.MiniPet',
			Tool				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Tool',
			Trinket				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Trinket',
			Trophy				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Trophy',
			UpgradeComponent	= 'gw2rothchild.model.Item.ItemType.ItemTypes.UpgradeComponent',
			Weapon				= 'gw2rothchild.model.Item.ItemType.ItemTypes.Weapon'
		};
	}

}