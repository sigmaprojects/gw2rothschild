component name="BaseObject" cache=false accessors=true {

	property name="Controller" inject="coldbox";

	public string function getIDName() {
		var classname = ListLast( GetMetaData( This ).fullname, "." );
		return ORMGetSessionFactory().getClassMetadata( classname ).getIdentifierColumnNames()[1];
	}
	
	public any function setIDValue(Required ID) {
		return Evaluate( "set" & getIDName() & "(#ID#)" );
	}

	public any function getIDValue() {
		return Evaluate( "get" & getIDName() & "()" );
	}

	public boolean function isValidID() {
		var isvalid = false;
		if(IsNull(getIDValue())) {
			isvalid = false;
		}
		if(!IsNull(getIDValue()) && IsNumeric(getIDValue()) && getIDValue() NEQ 0) {
			isvalid = true;
		}
		return isvalid;
	}
	
	public string function getObjectName() {
		var objName = ListLast(getMetaData(this).fullname,'.');
		return objName;
	}
	
	public void function postInsert() {
		try {
			this.setCreated( Now() );
		} catch(Any e) {}
	}
	
}