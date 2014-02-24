<cfscript>
itemService = getModel('ItemService');
RecipieService = getModel('RecipieService');
RecipeIngredientService = ('RecipeIngredientService');


Recipe = RecipeService.get(785);

public array function getAllIngredients(Required Recipe) {
	var z = 1;
	var x = 1;
	var isMore = true;
	
	var Recipes = [];
	var Ingredients = [];
	
	//arrayAppend(Recipes,Recipe);
	var currentRecipe = arguments.Recipe;
	while( isMore ) {
		
		
		if( !IsNull( currentRecipe.getOutput_Item_ID() ) && IsNumeric(currentRecipe.getOutput_Item_ID()) && ItemService.exists(currentRecipe.getOutput_Item_ID()) ) {
			var Item = ItemService.get( currentRecipe.getOutput_Item_ID() );
			
		}
		
		// hold he horses
		z++;
		if( z gte 10 ) {
			isMore = false;
			break;
		}
	}
	
	return Ingredients;
	
}


</cfscript>