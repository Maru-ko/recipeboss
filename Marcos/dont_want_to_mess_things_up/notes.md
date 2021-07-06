# Recipe Data Structure

The current structure is similar to the Todo List app built in 175.

- It's an array of hashes.
- Recipes is an array.
- Recipe is a hash.
- Each recipe has a name, cook time, description, ingredients and steps and more can be added as needed.
- Each recipes has many ingredients.
- Each recipes has many steps (cooking directions)

In this sense, we can use OOP approach to create the app.

- RecipeBook has many recipes
- Recipe has many ingredients
- Recipe has many steps

- When we load the database, we should convert the recipes into recipe objects.
- When we save the recipes we should convert the ingredient and steps instances into a saveable format because we cannot save instances in YAML but we can save strings. Therefore, we reformat the recipes array into a array of recipes details in string instead of object instance.

```ruby
require 'yaml'

require_relative 'recipe'
require_relative 'ingredient'
require_relative 'step'

class RecipeBook
  attr_accessor :recipes

  def initialize
    @recipes = []
    load_recipes
  end

  # Recipes is an array
  def load_recipes
    recipes = Psych.load_file("./recipes.yaml")
    recipes.each do |recipe|
      recipe =  Recipe.new(
        recipe[:id],
        recipe[:name],
        recipe[:description],
        recipe[:cook_time],
        recipe[:ingredients].map do |ingredient|
          Ingredient.new(ingredient[:id], ingredient[:name])
        end,
        recipe[:steps].map do |step|
          Step.new(step[:id], step[:name])
        end
      )
      @recipes << recipe
    end
  end

  def save_recipes
    formatted_recipes = []

    @recipes.each do |recipe|
      new_recipe = {}


      new_recipe[:id] = recipe.id
      new_recipe[:name] = recipe.name
      new_recipe[:description] = recipe.description
      new_recipe[:cook_time] = recipe.cook_time

      new_recipe[:ingredients] = []

      recipe.ingredients.each do |ingredient|
        new_recipe[:ingredients] << { id: ingredient.id, name: ingredient.name }
      end

      new_recipe[:steps] = []

      recipe.steps.each do |step|
        new_recipe[:steps] << { id: step.id, name: step.name }
      end

      formatted_recipes << new_recipe
    end

    File.open('./recipes.yaml', 'w') do |file|
      file.write(Psych.dump(formatted_recipes))
    end
  end
end
```


