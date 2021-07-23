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


yaml_txt = File.read('recipes.yml')
yaml_data = YAML.load(yaml_txt)

csv_table = [["name", "cook_time", "ingredients", "steps"]]

yaml_data.each do |recipe|
  formatted = []
  recipe.each do |key, value|
    case key
    when :name, :cook_time
      formatted << value
    when :ingredients, :steps
      inner_formatted = []
      value.each do |hsh|
        inner_formatted << hsh[:name]
      end
      formatted << inner_formatted.join(", ")
    end
  end
  csv_table << formatted
end

File.open('output.csv', 'w') do |f|
    f.puts( csv_table.map do |row|
        CSV.generate_line(row, col_sep: ",")
    end.join "" )
end