index page
```bash
<ul>
  <% @recipe_book.recipes.sort_by{|recipe| recipe.id}.each do |recipe| %>
    <li><a href="recipes/<%= recipe.name %>"><%= recipe.name %></a></li>
  <% end %>
</ul>
```

`line 10, 11`
```bash
<p><a href="/recipes/new">Add Recipe</a></p>
<p><a href="#">Generate Weekly Menu</a></p>
```






##Recommendations

Can we add if possible a description to the recipes?