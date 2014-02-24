<cfscript>
//setting enablecfoutputonly="true" requesttimeout="0" showdebugoutput="no";
ItemService = getModel('ItemService');

Items = ItemService._search(max=9999999,itemtype_name='Armor,Back,Trinket,Weapon',hasUpgradeComponent=false);

for(Item in Items.Entries) {
	try {
		if( Item.hasItemType() ) {
			ItemType = Item.getItemType();
			if( structKeyExists(ItemType,'getsuffix_item_id') ) {
				suffix_item_id = ItemType.getSuffix_Item_ID();
				if( !IsNull(suffix_item_id) && IsNumeric(suffix_item_id) ) {
					Item.setSuffix_Item_ID( suffix_item_id );
					ItemService.save( Item );
				}
			}
		}
	} catcH(any e) {}
}

</cfscript>