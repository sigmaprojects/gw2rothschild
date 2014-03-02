component table="recipeingredient" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="recipeingredient_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	property
		name="item"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.Item.Item.Item"
		fkcolumn="item_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";

	property
		name="itemcount"
		ormtype="integer"
		type="numeric"
		index="itemcount";
		
	

}