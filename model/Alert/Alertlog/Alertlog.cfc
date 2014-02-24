component table="alertlog" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true
    cache=false autowire=true {

	property name="id" column="alertlog_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	
	property
		name="alert"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.Alert.Alert.Alert"
		fkcolumn="alert_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";

	property
		name="alert_id"
		ormtype="integer"  
		type="numeric"
		update="false"
		insert="false";

	property
		name="email"
		ormtype="string"
		type="string"
		notnull="true"
		index="email";
	
	property
		name="body"
		ormtype="clob"
		type="string"
		notnull="true";

	property
		name="successful"
		ormtype="org.hibernate.type.BooleanType"
		type="boolean"
		dbdefault="1"
		default="true";
	
	property
		name="errors"
		ormtype="clob"
		type="string";	
	
	property
		name="created"
		ormtype="timestamp"
		type="date"
		index="created";
	
	property
		name="updated"
		ormtype="timestamp"
		type="date"
		index="updated";


	public Alert function init() {
		if( !StructKeyExists(variables,'hashkey') || IsNull(hashkey) ) {
			variables.hashkey = Hash(CreateUUID());
		}
		if( !StructKeyExists(variables,'created') || IsNull(created) ) {
			variables.created = Now();
		}
		variables.updated = Now();
	}



}