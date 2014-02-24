component table="watchlist" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true
    cache=false autowire=true {

	property name="id" column="watchlist_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	
	property
		name="user"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.User.User.User"
		fkcolumn="user_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";

	
	property
		name="user_id"
		ormtype="string"
		type="string"
		update="false"
		insert="false";
	
	property
		name="item"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.Item.Item.Item"
		fkcolumn="item_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";
		
	property
		name="item_id"
		ormtype="integer"
		type="numeric"
		update="false"
		insert="false";

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


/*
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
*/

}