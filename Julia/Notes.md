### Some conversion gems

  https://github.com/mhuggins/ruby-measurement/blob/master/README.md
  only converts standardized unites such as yard, feet, grams; not cooking specific

### When to use conversion

adding all recipe ingredients to show the final shopping list

need to decide our own standardized units for each type;

for example, all veggies are counted by units,

- all herbs are counted by a bunch(2 bunch), or some? (common cookbook languages)
- How to count condiments? Can't buy 5 Tbsp of oil, can only buy one bottle

### Suggestions

####  Approach 1: Try to combine all ingredient quantities

create a hash of all_ingredients which includes nested hash of meat: {}, veggie: {}, condiments: {}, carbs:{}

iterate through recipes
    iterate through ingredients
        identify ingredient type
          check ingredient key exists? add the quantity as a string to the arrays of values: create key and then initialize value as an array of quantities
        end
      end
    end
    iterate through all_ingredients, remap quantities into a single value
    if condiments - nil
    if veggie/meat, convert lb/oz to grams/kg
    etc

####   Approach 2: show ingredient quantity details by link

​    create all_ingredients array with ingredient names
​    display all_ingredient array, each element with hyperlink
​    when link clicked it will show
​      1 cup flour for "recipe_name"
​      2 tbsp flour for "recipe_name"
​    user can add up themselves

  example code in for Approach 2
```
<!-- user clicked ingredient flour -->
if session[:show_ingredient_detail]
  recipes.each do |recipe|
    if ingredient matches session[:show_ingredient_detail]
      "#{ingredient.details} for #{recipe.name}"
    end
  end
end
```
