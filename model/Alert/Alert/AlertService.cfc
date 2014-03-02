import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="Logger" inject="logbox:logger:{this}";
	property name="Controller" inject="coldbox";
	property name="interceptorService" inject="coldbox:interceptorService";
	property name="configBean" inject="coldbox:configBean";
	property name="Renderer" inject="coldbox:plugin:Renderer";
	property name="MailService" inject="coldbox:plugin:MailService";
	
	property name="ItemService" inject="ItemService";
	property name="UserService" inject="UserService";
	property name="WatchlistService" inject="WatchlistService";
	property name="AlertlogService" inject="AlertlogService";

	public any function init(){
		super.init("Alert", "Alert.query.cache", false );
		return this;
	}
	
	
	public array function getPastdueAlerts() {
		var result = _search(pastDue=true,max=999999);
		return result['entries'];
	}
	
	public array function getProvenAndPastDueAlerts() {
		var Alerts = [];
		var pastDues = getPastdueAlerts();
		for(var pastDue in pastDues) {
			if( pastDue.getIsProven() ) {
				arrayAppend(Alerts,pastDue);
			}
		}
		return Alerts;
	}
	
	public void function startAlertingWorker() {
		
		var Alerts = getProvenAndPastDueAlerts();

		for(var Alert in Alerts) {
			
			if( Alert.isSendable() ) {
				
				var Item = Alert.getItem();
			
				var MailObj = MailService.newMail().config(
					from	= "GW2 Rothschild <web@sigmaprojects.org>",
					to		= Alert.getUser().getEmail(),
					subject	= Item.getName() & ' Notification',
					useSSL	= true,
					charset	= "utf-8",
					type	= "text/html"
				);
				MailObj.setBody(Renderer.renderView(View='alerts/emails/notification'));
				MailObj.setBodyTokens({
					ALERTHREF	= 'https://gw2.sigmaprojects.org/alerts/editmyalert/#Alert.getHashKey()#',
					ITEMLINK	= '<a href="https://gw2.sigmaprojects.org/items/view/#Item.getID()#">#Item.getName()#</a>',
					SUPPLY		= Item.getSupply(),
					DEMAND		= Item.getDemand(),
					BUY			= Item.getLast_Max_Offer(),
					SALE		= Item.getLast_Min_Sale(),
					CDIFF		= Item.getupgradecomponent_price_difference()
				});
			
				send( MailObj, Alert );
			
			}
		}
	}	









	public struct function _search(
		Any			user_id,
		Any			item_id,
		Any			prop,
		Any			val,
		Any			operator,
		Any			interval,
		Any			lastsent,
		Any			lastsent_before,
		Any			lastsent_after,
		Any			pastdue,
		Numeric		Max					= 50,
		Numeric		Offset				= 0,
		Numeric		Timeout				= 0,
		String		sortOrder			= 'created desc',
		Boolean		ignoreCase			= true,
		Boolean		asQuery				= false
	) {
		var results = {};
		results['count'] = 0;
		results['entries'] = [];
		var c = newCriteria();
		var r = c.restrictions;
		
		var Aliases = [];

		var _ItemIDs = extractParamArray(arguments,'item_id');
		if( arrayLen(_ItemIDs) ) {
			if( !arrayContains(Aliases,'item') ) { arrayAppend(Aliases,'item'); c.createAlias( 'item', 'i'); }
			c.isin('i.id', JavaCast('java.lang.Integer[]', _ItemIDs ) );
		}

		var _UserIDs = extractParamArray(arguments,'user_id');
		if( arrayLen(_UserIDs) ) {
			if( !arrayContains(Aliases,'user') ) { arrayAppend(Aliases,'user'); c.createAlias( 'user', 'u'); }
			c.isin('u.id', JavaCast('java.lang.String[]', _UserIDs ) );
		}
		
		if( structKeyExists(arguments,'lastsent_before') ) {
			var _lastsentBefore = ( IsArray(arguments.lastsent_before) && ArrayLen(arguments.lastsent_before) ? arguments.lastsent_before[1] : arguments.lastsent_before );
			if(!IsNull(_lastsentbefore) && IsDate(_lastsentbefore)) {
				ArrayAppend(Criteria, Restrictions.lt( 'lastsent', createObject('java', 'java.util.Date').init( javaCast('long',dateDiff('s','January 1 1970 00:00',dateConvert('Local2utc', DateAdd('d',1,_lastsentbefore)))*1000) )  ));
			}
		}
		if( structKeyExists(arguments,'lastsent_after') ) {
			var _lastsentAfter = ( IsArray(arguments.lastsent_after) && ArrayLen(arguments.lastsent_after) ? arguments.lastsent_after[1] : arguments.lastsent_after );
			if(!IsNull(_lastsentAfter) && IsDate(_lastsentAfter)) {
				ArrayAppend(Criteria, Restrictions.gt( 'lastsent', createObject('java', 'java.util.Date').init( javaCast('long',dateDiff('s','January 1 1970 00:00',dateConvert('Local2utc', _lastsentAfter))*1000) )  ));
			}
		}
		
		if( structKeyExists(arguments,'pastdue') && isBoolean(arguments.pastdue) ) {
			c.eq( 'pastdue', javaCast('boolean',arguments.pastdue) );
		}

		if( sortOrder contains 'i.' && !ArrayContains(Aliases,'item') ) {
			c.createAlias( 'item', 'i');
		}

		c.cache(false);
		results['count'] = c.count();
		results['entries'] = c.list(max=max, offset=offset, timeout=timeout, sortOrder=sortOrder, ignoreCase=ignoreCase, asQuery=asQuery);
		return results;
	}

	
	public void function delete(Required Alert) {
		var c = {};
		c['alert_id'] = Alert.getID();
		var Logs = AlertlogService.list(criteria=c,asQuery=false);
		for(var Log in Logs) {
			AlertlogService.delete( Log );
		}
		super.delete(Alert);
	}

	public void function save(Required Alert) {
		var isNew = false;
		if( IsNull(Alert.getID()) || !IsNumeric(Alert.getID()) || Alert.getID() lte 0 ) {
			isNew = true;
		}
		super.save(Alert);
		if( isNew ) {
			var created = dateAdd('s', '-' & (Alert.getSendInterval()+60) , Now());
			Alert.setCreated( created );
			super.save(Alert);
		}
	}
	
	public Alert function getForUserByID(User,Alert) {
		var id = ( isSimpleValue(Alert) ? Alert : Alert.getID() );
		var user_id = ( isSimpleValue(User) ? User : User.getID() );
		if( super.countWhere(id=id,user_id=user_id) gt 0 ) {
			return super.get( alert_id );
		}
		return super.new();
	}
	
	public boolean function itemExistsForUser(Required Item, Required User) {
		var item_id = ( isSimpleValue(Item) ? Item : Item.getID() );
		var user_id = ( isSimpleValue(User) ? User : User.getID() );
		if( super.countWhere(item_id=item_id,user_id=user_id) gt 0 ) {
			return true;
		}
		return false;
	}
	
	public any function getByItemUser(Required Item, Required User) {
		var item_id = ( isSimpleValue(Item) ? Item : Item.getID() );
		var user_id = ( isSimpleValue(User) ? User : User.getID() );
		var c = {};
		c['user_id'] = user_id;
		c['item_id'] = item_id;
		var FoundAlert = super.findWhere(criteria=c);
		if( !IsNull(FoundAlert) ) {
			return FoundAlert;
		}
		var NewAlert = super.new();
		NewAlert.setItem( ItemService.get(item_id) );
		NewAlert.setUser( UserService.get(user_id) );
		return NewAlert;
	}

	private any function extractParamArray() {
		return ItemService.extractParamArray(argumentCollection=arguments);
	}


	private void function send(Required MailObj, Required Alert) {
		var mailResult = mailService.send( MailObj );
		
		var q = new Query(datasource='gw2rothchild');
		var SQL = "INSERT INTO alertlog (alert_id,email,body,created,updated) VALUES (:alert_id,:email,:body,:created,:updated)";
		q.setSQL( SQL );
		q.addParam(name="alert_id",				value=Alert.getID(),		cfsqltype="cf_sql_integer");
		q.addParam(name="email",				value=MailObj.getTo(),		cfsqltype="cf_sql_varchar");
		q.addParam(name="body",					value=MailObj.getBody(),	cfsqltype="cf_sql_varchar");
		q.addParam(name="created",				value=Now(),				cfsqltype="cf_sql_timestamp");
		q.addParam(name="updated",				value=Now(),				cfsqltype="cf_sql_timestamp");
		q.execute().getResult();
		
		/*
		var AlertLog = AlertlogService.new();
		
		AlertLog.setAlert( Alert );
		
		AlertLog.setEmail( MailObj.getTo() );
		
		AlertLog.setBody( MailObj.getBody() );
		
		if( structKeyExists(mailResult,'Error') && IsBoolean(mailResult.Error) && mailResult.Error eq false ) {
			Alertlog.setSuccessful( true );
		} else {
			Alertlog.setSuccessful( false );
		}
		if(structKeyExists(mailResult,'ErrorArray') && ArrayLen(mailResult.ErrorArray)) {
			Alertlog.setErrors(SerializeJson(mailResult.ErrorArray));
		}
		AlertlogService.save(Alertlog);
		*/

	}


}
