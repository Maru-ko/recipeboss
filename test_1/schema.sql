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

INSERT INTO recipes (name, cook_time) VALUES('pasta', '30 mins');
INSERT INTO ingredients (name, recipe_id) VALUES ('olive oil', 1); 
INSERT INTO ingredients (name, recipe_id) VALUES ('garlic', 1); 
INSERT INTO ingredients (name, recipe_id) VALUES ('onion', 1); 

INSERT INTO steps (name, recipe_id) VALUES ('do this thing 1', 1);
INSERT INTO steps (name, recipe_id) VALUES ('do this thing 2', 1);
INSERT INTO steps (name, recipe_id) VALUES ('do this thing 3', 1);


INSERT INTO recipes (name, cook_time) VALUES('salad', '30 mins');
INSERT INTO ingredients (name, recipe_id) VALUES ('olive oil', 2); 
INSERT INTO ingredients (name, recipe_id) VALUES ('garlic', 2); 
INSERT INTO ingredients (name, recipe_id) VALUES ('onion', 2); 

INSERT INTO steps (name, recipe_id) VALUES ('do this thing 1', 2);
INSERT INTO steps (name, recipe_id) VALUES ('do this thing 2', 2);
INSERT INTO steps (name, recipe_id) VALUES ('do this thing 3', 2);

INSERT INTO recipes (name, cook_time) VALUES('soup', '30 mins');
INSERT INTO ingredients (name, recipe_id) VALUES ('olive oil', 3); 
INSERT INTO ingredients (name, recipe_id) VALUES ('garlic', 3); 
INSERT INTO ingredients (name, recipe_id) VALUES ('onion', 3); 

INSERT INTO steps (name, recipe_id) VALUES ('do this thing 1', 3);
INSERT INTO steps (name, recipe_id) VALUES ('do this thing 2', 3);
INSERT INTO steps (name, recipe_id) VALUES ('do this thing 3',3);

