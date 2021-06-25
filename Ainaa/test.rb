require 'yaml'

recipes = Psych.load_file("./recipes.yaml")

recipes.each do |recipe|
  p recipe[:id]
  p recipe[:name]
  p recipe[:description]
  p recipe[:ingredients].join(" & ")
  p recipe[:steps].join(" & ")
end

new_recipe = {}
new_recipe[:id] = recipes.last[:id] + 1
new_recipe[:name] = "Random recipe #{new_recipe[:id]}"
new_recipe[:description] = "rand recipe description"
new_recipe[:ingredients] = ["random ingredients", "random ingredient"]
new_recipe[:steps] = ["do random", "do random stuff"]

recipes << new_recipe

p recipes

File.open('./recipes.yaml', 'w') do |file|
  file.write(Psych.dump(recipes))
end
