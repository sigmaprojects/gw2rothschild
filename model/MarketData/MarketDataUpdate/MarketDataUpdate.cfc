component table="marketdataupdate" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="marketdataupdate_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	property
		name="updated_count"
		ormtype="integer"
		type="numeric"
		index="updated_count";

	property
		name="created_count"
		ormtype="integer"
		type="numeric"
		index="updated_count";

	property
		name="successful"
		ormtype="org.hibernate.type.BooleanType"
		type="boolean"
		dbdefault="0"
		default="false"
		index="successful";

	property
		name="created"
		ormtype="timestamp"
		type="date"
		index="created";

}