import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("ItemFlag", "ItemFlag.query.cache", true );
		return this;
	}

	public boolean function nameExists(Required String Name) {
		if( super.countWhere(name=trim(arguments.Name)) ) {
			return true;
		}
		return false;
	}
	
	public any function getByName(Required String Name) {
		var Obj = super.findWhere(criteria={name=trim(arguments.Name)});
		return Obj;
	}

	public any function getOrCreate(Required String Name) {
		if( nameExists(Name) ) {
			return getByName(Name);
		}
		var Obj = super.new();
		Obj.setName(Name);
		super.save(Obj);
		EntityReload(Obj);
		return Obj;
	}

}