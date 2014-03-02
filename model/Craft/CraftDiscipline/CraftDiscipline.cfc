component table="craftdiscipline" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="craftdiscipline_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";
	
	property
		name="name"
		ormtype="string"
		type="string"
		length="250"
		index="name";
	



}