component table="marketdata" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="marketdata_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	property
		name="item_id"
		ormtype="integer"
		type="numeric"
		index="item_id";

/*
	property
		name="item"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.Item.Item.Item"
		fkcolumn="item_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";
*/
	property
		name="max_offer_unit_price"
		ormtype="integer"
		type="numeric"
		index="max_offer_unit_price";

	property
		name="min_sale_unit_price"
		ormtype="integer"
		type="numeric"
		index="min_sale_unit_price";

	property name="offer_availability"
		ormtype="integer"
		type="numeric"
		index="offer_availability";

	property
		name="offer_price_change_last_hour"
		ormtype="integer"
		type="numeric"
		index="offer_price_change_last_hour";

	property name="price_last_changed"
		ormtype="date"
		type="date"
		index="price_last_changed";

	property
		name="sale_availability"
		ormtype="integer"
		type="numeric"
		index="sale_availability";

	property
		name="sale_price_change_last_hour"
		ormtype="integer"
		type="numeric"
		index="sale_price_change_last_hour";

	property
		name="created"
		ormtype="timestamp"
		type="date"
		index="created";


}