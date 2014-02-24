component table="alert" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true
    cache=false autowire=true {

	property name="id" column="alert_id" ormtype="integer" type="numeric" fieldtype="id" generator="native" generated="insert";

	
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
		name="hashkey"
		ormtype="string"
		type="string"
		update="false"
		notnull="true";


	property
		name="prop"
		ormtype="string"
		type="string"
		index="prop"
		notnull="true";

	property
		name="val"
		ormtype="integer"  
		type="numeric"
		index="val"
		notnull="true";

	property
		name="operator"
		ormtype="string"  
		type="string"
		index="operator"
		notnull="true";

	property
		name="sendinterval"
		ormtype="integer"   
		type="numeric"
		index="sendinterval"
		notnull="true";

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
		name="lastsent"
		ormtype="timestamp"
		formula="SELECT al.created FROM alertlog al WHERE al.alert_id = alert_id ORDER BY al.created DESC limit 1";  

	property
		name="pastdue"
		ormtype="org.hibernate.type.BooleanType"
		type="boolean"
		formula="SELECT COUNT(*) > 0 FROM alert a WHERE TIME_TO_SEC(TIMEDIFF(now(), IFNULL( (SELECT al.created FROM alertlog al WHERE al.alert_id = a.alert_id ORDER BY al.created DESC LIMIT 1),a.created) )) > a.sendinterval AND a.alert_id = alert_id";

	property
		name="sentcount"
		ormtype="integer"
		type="numeric"
		formula="SELECT COUNT(1) FROM alertlog al WHERE al.alert_id = alert_id";  

	public Alert function init() {
		if( !StructKeyExists(variables,'hashkey') || IsNull(hashkey) ) {
			variables.hashkey = Hash(CreateUUID());
		}
		if( !StructKeyExists(variables,'created') || IsNull(created) ) {
			variables.created = Now();
		}
		variables.updated = Now();
	}
	
	
	public boolean function getIsProven() {
		try {
			var statement = '';
			if( hasItem() ) {
				var _Item = getItem();
				switch( getProp() ) {
					case 'upgradecomponent_price_difference': {
						var propVal = _Item.getupgradecomponent_price_difference();
							break;
					}
					case 'last_min_sale': {
						var propVal = _Item.getlast_min_sale();
						break;
					}
						case 'last_max_offer': {
						var propVal = _Item.getlast_max_offer();
						break;
					}
					case 'supply': {
						var propVal = _Item.getsupply();
						break;
					}
					case 'demand': {
						var propVal = _Item.getdemand();
						break;
					}
					default: {
						return false;
					}
				}
				var statement = '( #propVal# #getOperator()# #getVal()# )';
				var result = Evaluate(statement);
					return result;
			}
			return false;
		} catch(any e) {
			return false;
		}
	}

	public string function getPropertyLabel() {
		switch( getProp() ) {
			case 'supply': {
				return 'Supply';
			}
			case 'demand': {
				return 'Demand';
			}
			case 'upgradecomponent_price_difference': {
				return 'Upgrade Component Diff';
			}
			case 'last_min_sale': {
				return 'Sale Price';
			}
			case 'last_max_offer': {
				return 'Buy Price';
			}
		}
		return '';
	}

	public string function getOperatorLabel() {
		switch( getOperator() ) {
			case 'eq': {
				return 'Equals';
			}
			case 'gt': {
				return 'Greater Than';
			}
			case 'lt': {
				return 'Less Than';
			}
			case 'gte': {
				return 'Greater Than or Equals';
			}
			case 'lte': {
				return 'Less Than or Equals';
			}
		}
		return '';
	}

	public string function getSendIntervalatorLabel() {
		switch( getSendInterval() ) {
			case 86400: {
				return 'Once Daily';
			}
			case 302400: {
				return 'Twice a week';
			}
			case 604800: {
				return 'Once a week';
			}
		}
		return '';
	}

	public boolean function isSendable() {
		if( !hasUser() ) {
			return false;
		}
		if( !hasItem() ) {
			return false;
		}
		if( IsNull(getUser().getEmail()) || !Len(getUser().getEmail()) || !IsValid('email',getUser().getEmail()) ) {
			return false;
		}
		return true;
	}

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