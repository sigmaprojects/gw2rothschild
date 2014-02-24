component table="itemtype" discriminatorcolumn="item_type" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true
    cache=false autowire=true {


	property name="itemtype_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	property
		name="Item"
		fieldtype="one-to-one"
		cfc="gw2rothchild.model.Item.Item.Item"
		cascade="all"
		mappedby="itemtype";

	property name="item_type" type="string" ormtype="string" insert="false" update="false";
	

	/*
	public void function setItem(Required ItemType, EntityID) {
		switch(Trim(ItemType)) {
			case 'yarn': {
				var Item = EntityLoadByPK(trim(ItemType),EntityID);
				setYarn(Item);
				break;
			}
			case 'publication': {
				var Item = EntityLoadByPK(trim(ItemType),EntityID);
				setPublication(Item);
				break;
			}
		}
	}
	*/


}