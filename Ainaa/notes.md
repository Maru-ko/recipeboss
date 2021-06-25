# Recipe Data Structure

The current structure is similar to the Todo List app built in 175.

- It's an array of hashes.
- Recipes is an array.
- Recipe is a hash.
- Each recipes has many ingredients.
- Ingredients can be an array but I think a hash would be better.
- Cooking steps can be an array or hash as well but probably hash.

In this sense, we can use OOP approach to create the app.

- RecipeBook has many recipes
- Recipe has many ingredients
- Recipe has many steps

```ruby
require Recipe

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
        recipe[:id]
        recipe[:name]
        # Finish code here
      )
      @recipes << recipe
    end
  end

  def save_recipes
  end

  def find_by(id)
  end
end
```

