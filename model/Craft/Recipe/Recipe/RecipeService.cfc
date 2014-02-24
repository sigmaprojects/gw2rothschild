import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="cfGW2SpidyAPI" inject="cfGW2SpidyAPI";
	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("Recipe", "Recipe.query.cache", true );
		return this;
	}



}