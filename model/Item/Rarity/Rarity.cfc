component table="rarity" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="rarity_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	property
		name="name"
		ormtype="string"  
		type="string"  
		index="name";

	property
		name="created"
		ormtype="timestamp"
		type="date"
		index="created";

}