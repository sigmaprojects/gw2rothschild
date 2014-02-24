<cfscript>
setting enablecfoutputonly="true" requesttimeout="0" showdebugoutput="no";

us = getModel('RecipeUpdateService');

us.updateRecipes();


abort;
rf = new model.Craft.Recipe.RecipeFlag.RecipeFlag();
//rf = entityNew('RecipeFlag');
entitySave(rf);
EntityReload(rf);
writedump(rf);
	
abort;
	
api = new gw2rothchild.lib.cfGW2API.cfGW2API();
	
RecipieAPI = api.getRecipeAPI();	

RecipeIDs = RecipieAPI.getRecipes();
i=1;
for(RecipeID in RecipeIDs) {
	
	recipedata = RecipieAPI.getRecipeData( RecipeID );
	
	if( structKeyExists(recipedata,'flags') && isarray(recipedata.flags) && arrayLen(recipedata.flags) ) {
		i++;
	
		
	
	
		writedump(var=recipedata);
	}
	
	if( i gte 3 ) {
		writeoutput('aborted');
		break;
	}
}
	
	
	
	
	
	
	
	
	
	
	
	
abort;
</cfscript>