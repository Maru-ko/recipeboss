Some conversion gems:
  https://github.com/mhuggins/ruby-measurement/blob/master/README.md
  only converts standardized unites such as yard, feet, grams; not cooking specific
When to use conversion:
  adding all recipe ingredients to show the final shopping list
  need to decide our own standardized units for each type; for example, all veggies are counted by units,
  all herbs are counted by a bunch(2 bunch), or some? (common cookbook languages)
  How to count condiments? Can't buy 5 Tbsp of oil, can only buy one bottle
suggestions:
    don't count units for certain ingredients including: herbs, condiments, flour, rice
    Creating our own basic conversion methods
    Tsp to Tbsp to Cups (common cooking measurements), need to consider parsing strings that uses Tablespoon vs Tbsp
    people often uses grams for butter and flour; may need to convert them to cups/Tbsp at the end or the other way around
    will also include g, kg, oz, lb (can import from gem)
