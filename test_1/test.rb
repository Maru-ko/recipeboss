require 'yaml'

recipe_book = RecipeBook.new
recipes = recipe_book.recipes

recipes.each_with_index do |recipe, index|
  p "#{index} - #{recipe.name} - Recipe ID = #{recipe.id}"
end

# Everytime we want to add a new recipe, we have to make sure we have
# - at least one ingredients created??
  # - to create the next ingredient we must have the next ingredient id
# - at least one step for the recipe?
  # - to create the next ingredient we must have the next id
# - the next id for recipe
# Or we can make sure that the recipe parameters optional so that
# we can add the stuff as we go, instead of having to create everything to create an
# instance of recipe

# Can we have a form in the route that captures all the data we need in one go?

next_recipe_id = recipes.last.id + 1
next_ingredient_id = recipes.last.ingredients.last.id + 1
next_step_id = recipes.last.steps.last.id + 1

# This is what it looks like to add a recipe to the recipes array
# At this point, the recipes is in the array but not saved to yaml yet.

new_recipe = Recipe.new(
        next_recipe_id,
        "Random new recipe",
        "Mom's secret recipe",
        "50 minutes",
        [Ingredient.new(next_ingredient_id, "random ingredient")],
        [Step.new(next_step_id, "Cook on the grill")]
      )
recipe_book.recipes << new_recipe

# After doing this we will have saved the file in YAML recipes database.

recipe_book.save_recipes
