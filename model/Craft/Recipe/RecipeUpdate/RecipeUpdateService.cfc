import coldbox.system.orm.hibernate.*;
component extends="coldbox.system.orm.hibernate.VirtualEntityService" singleton {

	property name="RecipeService" inject="RecipeService";
	property name="RecipeFlagService" inject="RecipeFlagService";
	property name="CraftDisciplineService" inject="CraftDisciplineService";
	property name="RecipeIngredientService" inject="RecipeIngredientService";
	property name="ItemService" inject="ItemService";
	property name="ItemUpdateService" inject="ItemUpdateService";
	
	property name="cfGW2API" inject="cfGW2API";
	property name="Logger" inject="logbox:logger:{this}";

	public any function init(){
		super.init("ItemUpdate", "ItemUpdate.query.cache", true );
		return this;
	}
	
	public void function onDIComplete() {
		if( application.executorService.getStatus() neq 'started' ) { application.executorService.start(); }
		//application.RecipeUpdateTask = createObject("component", "gw2rothchild.model.Craft.Recipe.RecipeUpdate.RecipeUpdateTask").init( id="RecipeUpdateTask", RecipeUpdateService=THIS );
		//application.executorService.scheduleWithFixedDelay("RecipeUpdateTask", application.RecipeUpdateTask, 27, 24, application.executorService.getObjectFactory().HOURS);
	}
	
	
	public boolean function needsUpdate() {
		if( super.count() eq 0 ) {
			return true;
		}
		
		return false;
	}
	
	public any function updateRecipes() {
		setting enablecfoutputonly="true" requesttimeout="2700" showdebugoutput="no";
		
		var taskID = 'RUS-UR-' & RandRange(100,100000);
		
		if( Logger.canInfo() ) { Logger.Info('RecipeUpdateService.updateRecipes STARTED.  TaskID: #taskID#'); }
		
		try {
			
			var RecipeAPI = cfGW2API.getRecipeAPI();
			
			var RecipeIDs = RecipeAPI.getRecipes();
			
			for(var RecipeID in RecipeIDs) {
				try {
						var RecipeData = RecipeAPI.getRecipeData( RecipeID );

						// sanity checks
						var skipLoop = false;
						if( !structKeyExists(RecipeData,'output_item_id') || !IsNumeric(RecipeData.output_item_id) ) {
							skipLoop = true;
						}
						var itemExistsResult = new Query(datasource='gw2rothchild',sql='SELECT * FROM item WHERE item_id = #RecipeData.output_item_id#').execute().getResult();
						if( !itemExistsResult.RecordCount ) {
							if( Logger.canWarn() ) { Logger.Warn('RecipeUpdateService.updateRecipes item not found ID: #RecipeData.output_item_id#', RecipeData); }
							var successfulImport = ItemUpdateService.updateItemFromAnet(RecipeData.output_item_id,taskID);
							if( !successfulImport ) {
								continue;
							}
						}

						for(var Ingredient in RecipeData.ingredients) {
							if( !structKeyExists(Ingredient,'item_id') || !IsNumeric(Ingredient.item_id) ) {
								skipLoop = true;
							}
							var itemIngredientExistsResult = new Query(datasource='gw2rothchild',sql='SELECT * FROM item WHERE item_id = #Ingredient.item_id#').execute().getResult();
							if( !itemIngredientExistsResult.RecordCount ) {
								if( Logger.canWarn() ) { Logger.Warn('RecipeUpdateService.updateRecipes Ingredient item not found ID: #Ingredient.item_id#', RecipeData); }
								var successfulImport = ItemUpdateService.updateItemFromAnet(Ingredient.item_id,taskID);
								if( !successfulImport ) {
									skipLoop = true;
								}
							}
						}
						
						if( skipLoop ) {
							continue;
						}

						
						// Check for Craft Disciplines, if none found, insert them, if they exist, grab the id's
						var CraftDisciplineIDs = [];
						for(var DisciplineName in RecipeData.disciplines) {
							var getDisciplinesQuery = new Query(datasource='gw2rothchild');
							getDisciplinesQuery.setSQL('SELECT * FROM craftdiscipline WHERE name = :name');
							getDisciplinesQuery.addParam(name="name",			value=Trim(DisciplineName),	cfsqltype="cf_sql_varchar");
							var getDisciplinesResult = getDisciplinesQuery.execute().getResult();
							if( getDisciplinesResult.RecordCount ) {
								arrayAppend(CraftDisciplineIDs,getDisciplinesResult['craftdiscipline_id'][1]);
							} else {
								var insertDisciplineQuery = new Query(datasource='gw2rothchild');
								insertDisciplineQuery.setSQL('INSERT INTO craftdiscipline (name) VALUES (:name)');
								insertDisciplineQuery.addParam(name="name",		value=Trim(DisciplineName),	cfsqltype="cf_sql_varchar");
								var insertDisciplineResult = insertDisciplineQuery.execute();
								var CraftDisciplineID = insertDisciplineResult.getPrefix().generatedkey;
								arrayAppend(CraftDisciplineIDs,CraftDisciplineID);
							}
						}

						// Check for Recipe Flags, if none found, insert them, if they exist, grab the id's
						var RecipeFlagIDs = [];
						for(var FlagName in RecipeData.flags) {
							var getFlagQuery = new Query(datasource='gw2rothchild');
							getFlagQuery.setSQL('SELECT * FROM recipeflag WHERE name = :name');
							getFlagQuery.addParam(name="name",			value=trim(FlagName),		cfsqltype="cf_sql_varchar");
							var getFlagResult = getFlagQuery.execute().getResult();
							if( getFlagResult.RecordCount ) {
								arrayAppend(RecipeFlagIDs,getFlagResult['recipeflag_id'][1]);
							} else {
								var insertFlagQuery = new Query(datasource='gw2rothchild');
								insertFlagQuery.setSQL('INSERT INTO recipeflag (name) VALUES (:name)');
								insertFlagQuery.addParam(name="name",	value=trim(FlagName),		cfsqltype="cf_sql_varchar");
								var insertFlagResult = insertFlagQuery.execute();
								var RecipeFlagID = insertFlagResult.getPrefix().generatedkey;
								arrayAppend(RecipeFlagIDs,RecipeFlagID);
							}
						}


						// Replace Insert recipe data into database.
						var recipeQuery = new Query(datasource='gw2rothchild');
						recipeQuery.setSQL('REPLACE INTO recipe (recipe_id,output_item_id,min_rating,type,output_item_count) VALUES (:recipe_id,:output_item_id,:min_rating,:type,:output_item_count)');
						recipeQuery.addParam(name="recipe_id",			value=trim(RecipeID),						cfsqltype="cf_sql_integer");
						recipeQuery.addParam(name="output_item_id",		value=trim(RecipeData.output_item_id),		cfsqltype="cf_sql_integer");
						recipeQuery.addParam(name="min_rating",			value=trim(RecipeData.min_rating),			cfsqltype="cf_sql_integer");
						recipeQuery.addParam(name="type",				value=trim(RecipeData.type),				cfsqltype="cf_sql_varchar");
						recipeQuery.addParam(name="output_item_count",	value=trim(RecipeData.output_item_count),	cfsqltype="cf_sql_integer");
						recipeQuery.execute().getResult();


						// Delete & Create Discilines
						for(var CraftDisciplineID in CraftDisciplineIDs) {
							new Query(datasource='gw2rothchild',sql="DELETE FROM craftdiscipline_recipe_jn WHERE recipe_id = #RecipeID#").execute().getResult();
							var craftQuery = new Query(datasource='gw2rothchild');
							craftQuery.setSQL('INSERT INTO craftdiscipline_recipe_jn (craftdiscipline_id,recipe_id) VALUES (:craftdiscipline_id,:recipe_id)');
							craftQuery.addParam(name="craftdiscipline_id",	value=trim(CraftDisciplineID),		cfsqltype="cf_sql_integer");
							craftQuery.addParam(name="recipe_id",			value=trim(RecipeID),				cfsqltype="cf_sql_integer");
							craftQuery.execute().getResult();
						}
						
						// Delete & Create Recipe Flags
						for(var RecipeFlagID in RecipeFlagIDs) {
							new Query(datasource='gw2rothchild',sql="DELETE FROM recipeflag_recipe_jn WHERE recipe_id = #RecipeID#").execute().getResult();
							var flagQuery = new Query(datasource='gw2rothchild');
							flagQuery.setSQL('INSERT INTO recipeflag_recipe_jn (recipeflag_id,recipe_id) VALUES (:recipeflag_id,:recipe_id)');
							flagQuery.addParam(name="recipeflag_id",	value=trim(RecipeFlagID),		cfsqltype="cf_sql_integer");
							flagQuery.addParam(name="recipe_id",		value=trim(RecipeID),			cfsqltype="cf_sql_integer");
							flagQuery.execute().getResult();
						}
						
						
						for(var Ingredient in RecipeData.ingredients) {
							new Query(datasource='gw2rothchild',sql="DELETE FROM recipeingredient WHERE recipe_id = #RecipeID#").execute().getResult();
							var ingQuery = new Query(datasource='gw2rothchild');
							ingQuery.setSQL('INSERT INTO recipeingredient (item_id,itemcount,recipe_id) VALUES (:item_id,:itemcount,:recipe_id)');
							ingQuery.addParam(name="item_id",	value=trim(Ingredient.item_id),		cfsqltype="cf_sql_integer");
							ingQuery.addParam(name="itemcount",	value=trim(Ingredient.count),		cfsqltype="cf_sql_integer");
							ingQuery.addParam(name="recipe_id",	value=trim(RecipeID),				cfsqltype="cf_sql_integer");
							ingQuery.execute().getResult();
						}

				} catch(Any e) {
					if( Logger.canError() ) { Logger.Error('RecipeUpdateService.updateRecipes loop error.  TaskID: #taskID#', e); }
				}
				
			}

			if( Logger.canInfo() ) { Logger.Info('RecipeUpdateService.updateRecipes FINISHED.  TaskID: #taskID#'); }
		} catch(Any e) {
			if( Logger.canError() ) { Logger.Error('RecipeUpdateService.updateRecipes error.  TaskID: #taskID#', e); }
		}
	}




}

