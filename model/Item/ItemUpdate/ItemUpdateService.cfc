import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="ItemService" inject="ItemService";
	
	property name="BonusService" inject="BonusService";
	property name="GameTypeService" inject="GameTypeService";
	property name="InfusionSlotService" inject="InfusionSlotService";
	property name="ItemAttributeService" inject="ItemAttributeService";
	property name="ItemFlagService" inject="ItemFlagService";
	property name="ItemTypeService" inject="ItemTypeService";
	property name="ItemUpdateService" inject="ItemUpdateService";
	property name="RarityService" inject="RarityService";
	property name="RestrictionService" inject="RestrictionService";
	
	
	property name="cfGW2SpidyAPI" inject="cfGW2SpidyAPI";
	property name="cfGW2API" inject="cfGW2API";
	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("ItemUpdate", "ItemUpdate.query.cache", true );
		return this;
	}
		
	public void function onDIComplete() {
		if( application.executorService.getStatus() neq 'started' ) { application.executorService.start(); }
		//application.ItemUpdateTask = createObject("component", "gw2rothchild.model.Item.ItemUpdate.ItemUpdateTask").init( id="ItemUpdateTask", ItemUpdateService=THIS );
		//application.executorService.scheduleWithFixedDelay("ItemUpdateTask", application.ItemUpdateTask, 24, 24, application.executorService.getObjectFactory().HOURS);
	}
	
	
	public any function updateItems() {
		setting enablecfoutputonly="true" requesttimeout="21600" showdebugoutput="no";
		
		var taskID = 'IUS-UI-' & RandRange(100,100000);
		if( Logger.canInfo() ) { Logger.Info("ItemService.updateItems STARTED at #DateFormat(Now(),'medium')# #TimeFormat(Now(),'medium')#.  ID: #taskID#"); }
		
		var ItemAPI = cfGW2API.getItemAPI();
		
		var ItemIDs = ItemAPI.getItems();
		
		for(var ItemID in ItemIDs) {
			updateItemFromAnet( ItemID, TaskID );
		}
		
		if( Logger.canInfo() ) { Logger.Info("ItemService.updateItems FINISHED at #DateFormat(Now(),'medium')# #TimeFormat(Now(),'medium')#.  ID: #taskID#"); }
		
		return;
	}

	public boolean function updateItemFromAnet(Required Numeric ItemID, Required String TaskID) {
			try {
				
				var ItemAPI = cfGW2API.getItemAPI();
				
				var ItemDetail = ItemAPI.getItemDetail( ItemID );
			
				var Item = ( ItemService.exists(ItemID) ? ItemService.get(ItemID) : ItemService.new() );
				Item.setID( ItemID );
			
				if( structKeyExists(ItemDetail,'description') && IsSimpleValue(ItemDetail.description) ) {
					Item.setDescription( ItemDetail.description );
				}
				if( structKeyExists(ItemDetail,'icon_file_id') && IsSimpleValue(ItemDetail.icon_file_id) ) {
					Item.setIcon_File_ID( ItemDetail.icon_file_id );
				}
				if( structKeyExists(ItemDetail,'icon_file_signature') && IsSimpleValue(ItemDetail.icon_file_signature) ) {
					Item.setIcon_File_Signature( ItemDetail.icon_file_signature );
				}
				if( structKeyExists(ItemDetail,'name') && IsSimpleValue(ItemDetail.name) ) {
					Item.setName( ItemDetail.name );
				}
				if( structKeyExists(ItemDetail,'level') && IsNumeric(ItemDetail.level) ) {
					Item.setLevel( ItemDetail.level );
				}
			
				Item.setRarity( RarityService.getOrCreate( ItemDetail.rarity ) );
			
				// Manage Item Flags
				var ItemFlags = [];
				if( structKeyExists(ItemDetail,'Flags') && IsArray(ItemDetail.Flags) ) {
					for(var Flag in ItemDetail.flags) {
						if( IsSimpleValue(Flag) && Len(Trim(Flag)) ) {
							var ItemFlag = ItemFlagService.getOrCreate(Flag);
							arrayAppend(ItemFlags,ItemFlag);
						}
					}
				}
				Item.setItemFlags( ItemFlags );
			
				// Manage Game Types
				var GameTypes = [];
				if( structKeyExists(ItemDetail,'game_types') && IsArray(ItemDetail.game_types) ) {
					for(var Type in ItemDetail.game_types) {
						if( IsSimpleValue(Type) && Len(Trim(Type)) ) {
							var GameType = GameTypeService.getOrCreate(Type);
							arrayAppend(GameTypes,GameType);
						}
					}
				}
				Item.setGameTypes( GameTypes );
			
				// Manage Restriction Flags
				var Restrictions = [];
				if( structKeyExists(ItemDetail,'restrictions') && IsArray(ItemDetail.restrictions) ) {
					for(var Name in ItemDetail.restrictions) {
						if( IsSimpleValue(Name) && Len(Trim(Name)) ) {
							var Restriction = RestrictionService.getOrCreate(Name);
							arrayAppend(Restrictions,Restriction);
						}
					}
				}
				Item.setRestrictions( Restrictions );
			
				var ItemType = ItemTypeService.newByItemType( ItemDetail.Type );
			
				switch( ItemType._getItem_Type() ) {
					case 'Armor': {
						var o = ItemDetail.armor;
						ItemType.setType( o.type );
						if( structKeyExists(o,'weight_class') && IsSimpleValue(o.weight_class) ) {
							ItemType.setWeight_Class( o.weight_class );
						}
						if( structKeyExists(o,'defense') && IsNumeric(o.defense) ) {
							ItemType.setDefense( o.defense );
						}
					
						if( structKeyExists(o,'suffix_item_id') && isNumeric(o.suffix_item_id) ) {
							Item.setSuffix_Item_ID( o.suffix_item_id );
							ItemType.setSuffix_Item_ID( o.suffix_item_id );
						}
					
						var ItemAttributes = [];
						if( structKeyExists(o,'infix_upgrade') && structKeyExists(o.infix_upgrade,'attributes') && IsArray(o.infix_upgrade.attributes) ) {
							for(var Attr in o.infix_upgrade.attributes) {
								var ItemAttribute = ItemAttributeService.new();
								ItemAttribute.setAttribute( Attr.attribute );
								ItemAttribute.setModifier( Attr.modifier );
								arrayAppend(ItemAttributes,ItemAttribute);
							}
						}
						ItemType.setItemAttributes(ItemAttributes);
					
						var InfusionSlots = [];
						if( structKeyExists(o,'infusion_slots') && isArray(o.infusion_slots) && arrayLen(o.infusion_slots) ) {
							if( structKeyExists(o.infusion_slots[1],'flags') && isArray(o.infusion_slots[1]['flags']) ) {
								for(var InfSlot in o.infusion_slots[1]['flags']) {
									var InfusionSlot = InfusionSlotService.getOrCreate(InfSlot);
									arrayAppend(InfusionSlots,InfusionSlot);
								}
							}
						}
						ItemType.setInfusionSlots( InfusionSlots );
					
						break;
					}
					case 'Back': {
						var o = ItemDetail.back;
						if( structKeyExists(o,'suffix_item_id') && isNumeric(o.suffix_item_id) ) {
							ItemType.setSuffix_Item_ID( o.suffix_item_id );
						}
					
						var ItemAttributes = [];
						if( structKeyExists(o,'infix_upgrade') && structKeyExists(o.infix_upgrade,'attributes') && IsArray(o.infix_upgrade.attributes) ) {
							for(var Attr in o.infix_upgrade.attributes) {
								var ItemAttribute = ItemAttributeService.new();
								ItemAttribute.setAttribute( Attr.attribute );
								ItemAttribute.setModifier( Attr.modifier );
								arrayAppend(ItemAttributes,ItemAttribute);
							}
						}
						ItemType.setItemAttributes(ItemAttributes);

						var InfusionSlots = [];
						if( structKeyExists(o,'infusion_slots') && isArray(o.infusion_slots) && arrayLen(o.infusion_slots) ) {
							if( structKeyExists(o.infusion_slots[1],'flags') && isArray(o.infusion_slots[1]['flags']) ) {
								for(var InfSlot in o.infusion_slots[1]['flags']) {
									var InfusionSlot = InfusionSlotService.getOrCreate(InfSlot);
									arrayAppend(InfusionSlots,InfusionSlot);
								}
							}
						}
						ItemType.setInfusionSlots( InfusionSlots );
					
						break;
					}
					case 'Bag': {
						var o = ItemDetail.bag;
						if( structKeyExists(o,'no_sell_or_sort') && IsNumeric(o.no_sell_or_sort) ) {
							ItemType.setNo_Sell_Or_Sort( o.no_sell_or_sort );
						}
						if( structKeyExists(o,'size') && IsNumeric(o.size) ) {
							ItemType.setSize( o.size );
						}
					
						break;
					}
					case 'Consumable': {
						var o = ItemDetail.consumable;
						ItemType.setType( o.type );
						if( structKeyExists(o,'duration_ms') ) {
							ItemType.setDuration_ms( o.duration_ms );
						}
						if( structKeyExists(o,'description') ) {
							ItemType.setDescription( o.description );
						}
						if( structKeyExists(o,'unlock_type') ) {
							ItemType.setUnlock_Type( o.unlock_type );
						}
						if( structKeyExists(o,'color_id') ) {
							ItemType.setColor_ID( o.color_id );
						}
						if( structKeyExists(o,'recipe_id') ) {
							ItemType.setRecipe_ID( o.recipe_id );
						}
						break;
					}
					case 'Container': {
						var o = ItemDetail.container;
						ItemType.setType( o.type );
						break;
					}
					case 'CraftingMaterial': {
						break;
					}
					case 'Gathering': {
						var o = ItemDetail.gathering;
						ItemType.setType( o.type );
						break;
					}
					case 'Gizmo': {
						var o = ItemDetail.gizmo;
						ItemType.setType( o.type );
						break;
					}
					case 'MiniPet': {
						break;
					}
					case 'Tool': {
						var o = ItemDetail.tool;
						ItemType.setType( o.type );
						if( structKeyExists(o,'charges') && IsNumeric(o.charges) ) {
							ItemType.setCharges( o.charges );
						}
						break;
					}
					case 'Trinket': {
						var o = ItemDetail.trinket;
						ItemType.setType( o.type );
						if( structKeyExists(o,'suffix_item_id') && isNumeric(o.suffix_item_id) ) {
							ItemType.setSuffix_Item_ID( o.suffix_item_id );
						}
						if( structKeyExists(o,'suffix') ) {
							ItemType.setSuffix( o.suffix );
						}
					
						var ItemAttributes = [];
						if( structKeyExists(o,'infix_upgrade') && structKeyExists(o.infix_upgrade,'attributes') && IsArray(o.infix_upgrade.attributes) ) {
							for(var Attr in o.infix_upgrade.attributes) {
								var ItemAttribute = ItemAttributeService.new();
								ItemAttribute.setAttribute( Attr.attribute );
								ItemAttribute.setModifier( Attr.modifier );
								arrayAppend(ItemAttributes,ItemAttribute);
							}
						}
						ItemType.setItemAttributes(ItemAttributes);
					
						var InfusionSlots = [];
						if( structKeyExists(o,'infusion_slots') && isArray(o.infusion_slots) && arrayLen(o.infusion_slots) ) {
							if( structKeyExists(o.infusion_slots[1],'flags') && isArray(o.infusion_slots[1]['flags']) ) {
								for(var InfSlot in o.infusion_slots[1]['flags']) {
									var InfusionSlot = InfusionSlotService.getOrCreate(InfSlot);
									arrayAppend(InfusionSlots,InfusionSlot);
								}
							}
						}
						ItemType.setInfusionSlots( InfusionSlots );
						break;
					}
					case 'Trophy': {
						break;
					}
					case 'UpgradeComponent': {
						var o = ItemDetail.upgrade_component;
						ItemType.setType( o.type );
						if( structKeyExists(o,'suffix') && IsSimpleValue(o.suffix) ) {
							ItemType.setSuffix( o.suffix );
						}
					
						var InfusionSlots = [];
						if( structKeyExists(o,'infusion_slots') && isArray(o.infusion_slots) && arrayLen(o.infusion_slots) ) {
							if( structKeyExists(o.infusion_slots[1],'flags') && isArray(o.infusion_slots[1]['flags']) ) {
								for(var InfSlot in o.infusion_slots[1]['flags']) {
									var InfusionSlot = InfusionSlotService.getOrCreate(InfSlot);
									arrayAppend(InfusionSlots,InfusionSlot);
								}
							}
						}
						ItemType.setInfusionSlots( InfusionSlots );

						var Bonuses = [];
						if( structKeyExists(o,'bonuses') && isArray(o.bonuses) ) {
							for(var BonusName in o.bonuses) {
								var Bonus = BonusService.getOrCreate(BonusName);
								arrayAppend(Bonuses,Bonus);
							}
						}
						ItemType.setBonuses( Bonuses );

						var ItemAttributes = [];
						if( structKeyExists(o,'infix_upgrade') && structKeyExists(o.infix_upgrade,'attributes') && IsArray(o.infix_upgrade.attributes) ) {
							for(var Attr in o.infix_upgrade.attributes) {
								var ItemAttribute = ItemAttributeService.new();
								ItemAttribute.setAttribute( Attr.attribute );
								ItemAttribute.setModifier( Attr.modifier );
								arrayAppend(ItemAttributes,ItemAttribute);
							}
						}
						ItemType.setItemAttributes(ItemAttributes);

						break;
					}
					case 'Weapon': {
						var o = ItemDetail.weapon;
						ItemType.setType( o.type );
						if( structKeyExists(o,'damage_type') && IsSimpleValue(o.damage_type) ) {
							ItemType.setDamage_Type( o.damage_type );
						}
						if( structKeyExists(o,'min_power') && IsNumeric(o.min_power) ) {
							ItemType.setMin_Power( o.min_power );
						}
						if( structKeyExists(o,'max_power') && IsNumeric(o.max_power) ) {
							ItemType.setMax_Power( o.max_power );
						}
						if( structKeyExists(o,'defense') && IsNumeric(o.defense) ) {
							ItemType.setDefense( o.defense );
						}
						if( structKeyExists(o,'suffix_item_id') && isNumeric(o.suffix_item_id) ) {
							ItemType.setSuffix_Item_ID( o.suffix_item_id );
						}

						var ItemAttributes = [];
						if( structKeyExists(o,'infix_upgrade') && structKeyExists(o.infix_upgrade,'attributes') && IsArray(o.infix_upgrade.attributes) ) {
							for(var Attr in o.infix_upgrade.attributes) {
								var ItemAttribute = ItemAttributeService.new();
								ItemAttribute.setAttribute( Attr.attribute );
								ItemAttribute.setModifier( Attr.modifier );
								arrayAppend(ItemAttributes,ItemAttribute);
							}
						}
						ItemType.setItemAttributes(ItemAttributes);
					
						break;
					}
				} // end switch
			
				ItemTypeService.save( ItemType );
				Item.setItemType( ItemType );
				ItemService.save( Item );
				return true;

			} catch(Any e) {
				if( Logger.canError() ) { Logger.Error('ItemService.updateItems error.  ID: #taskID#', e); }
				return false;
			}
		return false;
	}


	public any function getLogger() {
		return Logger;
	}

}