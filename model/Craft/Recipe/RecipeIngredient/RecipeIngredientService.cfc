import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("RecipeIngredient", "RecipeIngredient.query.cache", true );
		return this;
	}


}