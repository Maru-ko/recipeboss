DROP TABLE IF EXISTS public.ingredients;
DROP TABLE IF EXISTS public.steps;
DROP TABLE IF EXISTS public.filters_recipes;
DROP TABLE IF EXISTS public.filters;
DROP TABLE IF EXISTS public.recipes;

CREATE TABLE recipes (
  id serial PRIMARY KEY, 
  name text NOT NULL, 
  cook_time text
);

CREATE TABLE ingredients (
  id serial PRIMARY KEY, 
  name text, 
  recipe_id integer NOT NULL REFERENCES recipes (id) ON DELETE CASCADE
);

CREATE TABLE steps (
  id serial PRIMARY KEY, 
  name text, 
  recipe_id integer NOT NULL REFERENCES recipes (id) ON DELETE CASCADE
);

CREATE TABLE filters (
  id serial PRIMARY KEY,
  name text
);

CREATE TABLE filters_recipes (
  id serial PRIMARY KEY,
  filter_id integer NOT NULL REFERENCES filters (id) ON DELETE CASCADE,
  recipe_id integer NOT NULL REFERENCES recipes (id) ON DELETE CASCADE
);

-- INSERT INTO recipes (name, cook_time) VALUES('pasta', '30 mins');
-- INSERT INTO ingredients (name, recipe_id) VALUES ('olive oil', 1);
-- INSERT INTO ingredients (name, recipe_id) VALUES ('garlic', 1);
-- INSERT INTO ingredients (name, recipe_id) VALUES ('onion', 1);

-- INSERT INTO recipes (name, cook_time) VALUES('salad', '30 mins');
-- INSERT INTO ingredients (name, recipe_id) VALUES ('olive oil', 2);
-- INSERT INTO ingredients (name, recipe_id) VALUES ('garlic', 2);
-- INSERT INTO ingredients (name, recipe_id) VALUES ('onion', 2);

-- INSERT INTO recipes (name, cook_time) VALUES('soup', '30 mins');
-- INSERT INTO ingredients (name, recipe_id) VALUES ('olive oil', 3);
-- INSERT INTO ingredients (name, recipe_id) VALUES ('garlic', 3);
-- INSERT INTO ingredients (name, recipe_id) VALUES ('onion', 3);

-- INSERT INTO filters (name)
-- VALUES('Vegetarian'), ('Gluten Free'), ('Vegan'), ('Pescatarian');

-- INSERT INTO filters_recipes (filter_id, recipe_id)
-- VALUES(1, 1), (1, 2), (2, 2), (1, 4), (2, 4);

