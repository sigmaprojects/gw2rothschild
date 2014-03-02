component table="user" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true
    cache=false autowire=true {

	property name="id" column="user_id" ormtype="string" length="255" type="string" fieldtype="id" generator="assigned";
	
	property
		name="email"
		ormtype="string"
		type="string"
		length="250"
		index="email";

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

	property
		name="lastlogin"
		ormtype="timestamp"
		type="date"
		index="lastlogin";


	public struct function toJSON() {
		var j = {};
		j['id']				= getID();
		l['created']		= getCreated();
		l['updated']		= getUpdated();
		l['lastlogin']		= getLastLogin();
		if( !IsNull(getEmail()) && Len(Trim(getEmail())) && isValid('email',getEmail())) {
			j['email']		= getEmail();
		}
		return j;
	}

}