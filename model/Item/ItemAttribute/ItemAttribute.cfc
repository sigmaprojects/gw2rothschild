component table="itemattribute" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="itemattribute_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";
	
	property
		name="attribute"
		ormtype="string"
		type="string"
		length="250"
		index="attribute";

	property
		name="modifier"
		ormtype="string"
		type="string"
		index="modifier";
	
}