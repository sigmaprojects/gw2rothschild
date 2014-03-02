component table="recipe" persistent=true extends="gw2rothchild.model.BaseObject" accessors=true cacheuse="transactional"
    cache=false autowire=true {

	property name="id" column="recipe_id" ormtype="integer" type="numeric" fieldtype="id" generator="assigned";
	
	property name="craftdisciplines"
		singularname="craftdiscipline"
		cfc="gw2rothchild.model.Craft.CraftDiscipline.CraftDiscipline"
		linktable="craftdiscipline_recipe_jn"
		fkcolumn="recipe_id"
		inversejoincolumn="craftdiscipline_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";

	property name="recipeflags"
		singularname="recipeflag"
		cfc="gw2rothchild.model.Craft.Recipe.RecipeFlag.RecipeFlag"
		linktable="recipeflag_recipe_jn"
		fkcolumn="recipe_id"
		inversejoincolumn="recipeflag_id"
		type="array"
		persistent="true"
		fieldtype="many-to-many"
		lazy="true"
		remotingfetch="false"
		cascade="save-update";

	property
		name="recipeingredients"
		singularname="recipeingredient"
		type="array"
		fieldtype="one-to-many"
		cfc="gw2rothchild.model.Craft.Recipe.RecipeIngredient.RecipeIngredient"
		fkColumn="recipe_id"
		cascade="save-update"
		lazy="true"
		remotingfetch="false"
		orderby="itemcount desc";

	property
		name="item"
		fieldtype="many-to-one"
		cfc="gw2rothchild.model.Item.Item.Item"
		fkcolumn="output_item_id"
		missingRowIgnored="true"
		lazy="true"
		remotingfetch="false";
	
	property
		name="min_rating"
		ormtype="integer"
		type="numeric"
		index="min_rating";

	property
		name="type"
		ormtype="string"
		type="string"
		length="250"
		index="type";
	
	property
		name="output_item_count"
		ormtype="integer"
		type="numeric"
		index="output_item_count";
	
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


}