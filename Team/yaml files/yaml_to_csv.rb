# From https://stackoverflow.com/questions/4306173/how-to-convert-the-yaml-to-spreadsheet/6476674

# HOW TO USE:
# - Change line X to the file you want to convert
# - Run this code "ruby yaml_to_csv.rb"
# - Upload to Airtable (+ icon to add a new table gives the "import data" option)
# - Within imported table on Airtable, change "ingredients" and "steps" field
      # type to "multiple select"
# - Copy and paste all the data from imported table to "recipes" table
# - Delete imported table

require 'yaml'
require 'csv'


yaml_txt = File.read('new_backup_recipes.yml')
yaml_data = YAML.load(yaml_txt)

# recipes
csv_table = [["name", "cook_time"]]

yaml_data.each do |recipe|
  formatted = []
  formatted << "#{recipe[:name]}" << recipe[:cook_time]
  csv_table << formatted
end

File.open('recipes.csv', 'w') do |f|
    f.puts( csv_table.map do |row|
        CSV.generate_line(row, col_sep: ",")
    end.join "" )
end

# ingredients
csv_table = [["name", "recipes"]]

yaml_data.each do |recipe|
  name = recipe[:name]
  recipe[:ingredients].each do |ingredient|
    formatted = []
    formatted << "#{ingredient[:name]}" << "#{name}"
    csv_table << formatted
  end
end

File.open('ingredients.csv', 'w') do |f|
    f.puts( csv_table.map do |row|
        CSV.generate_line(row, col_sep: ",")
    end.join "" )
end

# steps
csv_table = [["name", "recipes"]]

yaml_data.each do |recipe|
  name = recipe[:name]
  recipe[:steps].each do |step|
    formatted = []
    formatted << step[:name] << "#{name}"
    csv_table << formatted
  end
end

File.open('steps.csv', 'w') do |f|
    f.puts( csv_table.map do |row|
        CSV.generate_line(row, col_sep: ",")
    end.join "" )
end
# yaml_data.each do |recipe|
#   formatted = []
#   recipe.each do |key, value|
#     case key
#     when :name, :cook_time
#       formatted << value
#     when :ingredients, :steps
#       inner_formatted = []
#       value.each do |hsh|
#         inner_formatted << hsh[:name]
#       end
#       formatted << inner_formatted.join(", ")
#     end
#   end
#   csv_table << formatted
# end

# File.open('recipes.csv', 'w') do |f|
#     f.puts( csv_table.map do |row|
#         CSV.generate_line(row, col_sep: ",")
#     end.join "" )
# end
