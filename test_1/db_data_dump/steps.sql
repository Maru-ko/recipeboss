--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: steps; Type: TABLE; Schema: public; Owner: ainaasakinah
--

CREATE TABLE public.steps (
    id integer NOT NULL,
    name text,
    recipe_id integer NOT NULL
);


ALTER TABLE public.steps OWNER TO ainaasakinah;

--
-- Name: steps_id_seq; Type: SEQUENCE; Schema: public; Owner: ainaasakinah
--

CREATE SEQUENCE public.steps_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.steps_id_seq OWNER TO ainaasakinah;

--
-- Name: steps_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ainaasakinah
--

ALTER SEQUENCE public.steps_id_seq OWNED BY public.steps.id;


--
-- Name: steps id; Type: DEFAULT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.steps ALTER COLUMN id SET DEFAULT nextval('public.steps_id_seq'::regclass);


--
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: ainaasakinah
--

INSERT INTO public.steps VALUES (1, 'Preheat oven to 375 degrees. Generously butter a 13-by-9-inch glass baking dish; set aside. Bring a large pot of water to a boil; add salt and macaroni. Cook until al dente according to package directions. Drain, and return to pot. Add butter, and toss until pasta is coated and butter has melted; set aside.', 1);
INSERT INTO public.steps VALUES (2, 'In a medium bowl, whisk together evaporated milk, skim milk, and eggs. Add seasoned salt, garlic powder, 1 teaspoon salt, and 1/2 teaspoon pepper; set aside. In another medium bowl, combine cheeses; set aside.', 1);
INSERT INTO public.steps VALUES (3, 'Place 1/3 macaroni in an even layer in the bottom of prepared baking dish; cover evenly with 1/3 cheese. Repeat with remaining macaroni and cheese mixture. Pour milk mixture evenly over contents of baking dish. Sprinkle with paprika. Bake until top layer is lightly browned, 35 to 45 minutes. Let stand 10 to 15 minutes before serving.', 1);
INSERT INTO public.steps VALUES (12, 'Heat oil in a medium pot over medium. Add onion, carrots, and celery and cook, stirring, until tender, 6 to 8 minutes. Add mushrooms and cook, stirring, until tender, 8 to 10 minutes. Add tomato paste and cook, stirring, 1 minute. Add Worcestershire, bay leaf, 4 cups water, and lentils; season with salt and pepper. Bring to a boil, then reduce to a simmer and cook until lentils are tender, 30 to 35 minutes. Stir in peas; remove from heat and season with salt and pepper.', 2);
INSERT INTO public.steps VALUES (13, 'Preheat oven to 400 degrees. Place potatoes and garlic in a medium saucepan; cover with 2 inches of cold water. Season generously with salt; bring to a boil, then reduce to a simmer and cook until a knife pierces potatoes easily, 10 to 12 minutes. Drain; return potatoes and garlic to pot. Add butter and milk; mash with a fork or potato masher until smooth. Season with salt and pepper.', 2);
INSERT INTO public.steps VALUES (14, 'Transfer lentil mixture to a 2-quart baking dish. Dollop with mashed potatoes; spread evenly to edges. Transfer to a baking sheet; bake until golden and bubbling around edges, about 15 minutes. Let stand 20 minutes; serve.', 2);
INSERT INTO public.steps VALUES (27, 'Heat oil in a large pot over medium. Add leeks, carrots, and celery; cook, stirring, until tender, 6 to 8 minutes. Add broth and peas; bring to a boil, then reduce to a simmer and cook, partially covered, until peas are creamy, 50 to 55 minutes. Stir in spinach; cook until just wilted, about 5 minutes. Let cool slightly.', 3);
INSERT INTO public.steps VALUES (28, 'Working in batches, puree soup in a blender until smooth. Return to pot; season with salt and pepper. (If too thick, add water, 1 tablespoon at a time.) Ladle soup into bowls, drizzle with yogurt and oil, top with barley, and serve.', 3);
INSERT INTO public.steps VALUES (37, 'Heat oil in a pot over medium-high. Add shallot, carrot, celery, cumin, coriander, and a pinch of salt. Cook, stirring, until vegetables have softened, 4 to 6 minutes.', 4);
INSERT INTO public.steps VALUES (38, 'Stir in lentils, tomatoes, and 4 1/2 cups water. Season with salt and pepper. Bring to a boil, then reduce heat to medium-low and simmer, partially covered, until lentils are tender, 40 to 45 minutes.', 4);
INSERT INTO public.steps VALUES (39, 'Stir in broccoli rabe (if soup is too thick, add up to 1/2 cup water); cook until tender, about 3 minutes more. Stir in red-wine vinegar, season with salt and pepper, and serve, with more pepper and a drizzle of oil.', 4);
INSERT INTO public.steps VALUES (48, 'Gnocchi: In a pot, cover potatoes with 2 inches of cold water. Bring to a boil and cook until easily pierced with the tip of a knife, 20 to 25 minutes. Drain and let sit until cool enough to handle. Peel and quarter potatoes and let cool completely.', 5);
INSERT INTO public.steps VALUES (49, 'Using a ricer or colander, press potatoes into a large bowl. Add flour, egg, and salt to bowl and gently stir until a ragged dough forms, being careful not to overwork. Transfer dough to a floured work surface and gently knead until dough just becomes uniform in color (sprinkling surface and hands with more flour as needed to prevent sticking).', 5);
INSERT INTO public.steps VALUES (50, 'Divide dough into 6 pieces; roll one out to an approximately 3/4-inch-diameter rope. Using a bench scraper or knife, cut crosswise into 1/2-inch-thick "pillows." Transfer in a single layer to a rimmed baking sheet generously dusted with flour. Repeat with remaining dough.', 5);
INSERT INTO public.steps VALUES (51, 'Sauce: Heat a large skillet over medium. Add pepitas and sesame and poppy seeds; cook, shaking frequently, until pepitas puff slightly and begin to pop, about 2 minutes. Transfer to a plate and season with salt and pepper.', 5);
INSERT INTO public.steps VALUES (52, 'Melt butter in skillet over medium heat, swirling occasionally, until dark golden brown, 8 to 10 minutes. Add sage leaves to brown butter and cook until darkened slightly, about 45 seconds. Remove skillet from heat. Using a fork, transfer sage to plate with seeds.', 5);
INSERT INTO public.steps VALUES (53, 'Meanwhile, cook gnocchi in a large pot of generously salted boiling water until they float and are al dente, 3 to 4 minutes; drain. Add to skillet with brown butter and return to medium heat. Cook, stirring occasionally, until gnocchi begin to crisp at edges, 3 to 4 minutes. Serve topped with seeds and sage.', 5);
INSERT INTO public.steps VALUES (58, 'Whisk together mustard and lemon zest and juice. Season generously with salt and pepper and slowly whisk in oil.', 6);
INSERT INTO public.steps VALUES (59, 'Combine carrots, butter, 1/2 cup water, and 1 1/2 teaspoons salt in a large straight-sided skillet or wide, shallow pot. Bring to a boil, then cover, reduce heat to medium, and simmer 5 minutes. Uncover and cook, stirring occasionally, until carrots are just tender but holding their shape, 5 to 7 minutes more.', 6);
INSERT INTO public.steps VALUES (60, 'Stir in snap peas and continue cooking just until peas have turned crisp-tender and bright green, about 2 minutes. Remove from heat and carefully drain any liquid remaining in skillet; toss with half of mustard dressing and season to taste. Serve, with remaining dressing on the side.', 6);
INSERT INTO public.steps VALUES (65, 'If you aren''t using any tomatoes on vine, skip to step 2. Otherwise, heat 1 tablespoon oil in a large skillet over medium. Add tomatoes on vine, season with salt, and cook, gently stirring, until skins begin to pucker, about 3 minutes, depending on size. Transfer to a plate.', 7);
INSERT INTO public.steps VALUES (66, 'Heat remaining 2 tablespoons oil in skillet over medium-high. Add garlic and remaining tomatoes and cook, stirring occasionally, until tomatoes are just beginning to break down, 3 to 5 minutes. Add red-pepper flakes and season with salt. Remove from heat.', 7);
INSERT INTO public.steps VALUES (67, 'Meanwhile, cook pasta in a large pot of salted boiling water 1 minute less than package directions. Reserve 1 cup pasta water, then drain pasta and return to pot. Add 1/3 cup pasta water, tomato mixture, and Parmigiano.', 7);
INSERT INTO public.steps VALUES (68, 'Cook over medium heat, tossing, until pasta is evenly coated, about 2 minutes, adding more pasta water as needed. To serve, top pasta with ricotta and sautéed tomatoes on the vine (if using); drizzle pasta with oil, then sprinkle with more red-pepper flakes and basil.', 7);
INSERT INTO public.steps VALUES (74, 'Prepare the herb cream cheese, roasted plum tomatoes, and salad-greens mixture. Prepare the scrambled eggs, and keep them warm.', 8);
INSERT INTO public.steps VALUES (75, 'Heat a grill pan over medium-high heat on the stove. Using a pastry brush, brush tortillas with olive oil. Grill each tortilla lightly on one side for no longer than 1 minute (the tortillas should be soft and easy to roll). Transfer tortillas, grilled side down, to work surface.', 8);
INSERT INTO public.steps VALUES (76, 'Divide herb cream cheese among the tortillas, spreading evenly and leaving a 1-inch border.', 8);
INSERT INTO public.steps VALUES (77, 'Divide the smoked salmon, scrambled eggs, and salad-green mixture evenly among tortillas. Top with alfalfa sprouts.', 8);
INSERT INTO public.steps VALUES (78, 'Fold in opposite sides of one tortilla, and roll it up; repeat with remaining tortillas. Slice each burrito in half diagonally, transfer to a platter, and garnish with roasted plum tomatoes, basil, scallions, and red onion.', 8);
INSERT INTO public.steps VALUES (85, 'Heat olive oil in a pot over medium heat. Cook onion, garlic, celery, and carrots until tender, 6 to 8 minutes.', 9);
INSERT INTO public.steps VALUES (86, 'Stir in broccoli and chickpeas; cook about 2 minutes.', 9);
INSERT INTO public.steps VALUES (87, 'Add 4 cups water. Bring to a boil; reduce heat and simmer until vegetables are tender, about 10 minutes. Remove from heat. Dissolve miso in 2 tablespoons cool water and stir into soup. Season with salt.', 9);
INSERT INTO public.steps VALUES (94, 'Bring potatoes to a boil in a pot of salted water. Cook until knife-tender, about 6 minutes. Drain and set aside.', 10);
INSERT INTO public.steps VALUES (95, 'Heat 2 tablespoons oil in a large saucepan over medium-high heat. Add cumin and cook until fragrant, about 30 seconds. Add potatoes and cook, stirring occasionally, until golden, 5 to 7 minutes. Transfer to a bowl; set aside.', 10);
INSERT INTO public.steps VALUES (96, 'Heat remaining oil over medium heat. Cook jalapeno, scallions, tomatoes, beans, yeast, and tempeh, stirring, until tomatoes begin to break down, 5 to 7 minutes. Add potatoes and cook until heatedthrough. Remove pan from heat and gently stir in avocado. Season with salt and pepper. Garnish with reserved scallion.', 10);
INSERT INTO public.steps VALUES (105, 'Heat broiler, with rack 5 inches from heat source. Drizzle tomatoes with oil in a large ovenproof skillet; toss with salt and pepper. Broil until charred and softened, 4 to 5 minutes. Transfer to a plate.', 11);
INSERT INTO public.steps VALUES (106, 'Place skillet over medium-high. Add 1 tablespoon oil, kale, and 3 tablespoons water. Cover and cook, stirring once, until wilted, 2 to 3 minutes. Season with salt and pepper; transfer to plate. Add 2 tablespoons oil and garlic to pan; cook, stirring frequently, until fragrant, about 30 seconds. Stir in barley; heat through. Season with salt and pepper.', 11);
INSERT INTO public.steps VALUES (107, 'Meanwhile, bring a small pot of water to a boil. Carefully add eggs, return to a boil, and cook 30 seconds. Turn off heat, cover, and let stand 6 minutes. Drain; run eggs under cold water until cool. Peel.', 11);
INSERT INTO public.steps VALUES (108, 'Divide barley, kale, eggs, tomatoes, avocados, and cucumber evenly among bowls. Dollop with yogurt, drizzle with oil, and season with salt and pepper; serve.', 11);
INSERT INTO public.steps VALUES (115, 'Bring milk to a boil in a small saucepan. Add quinoa, and return to a boil. Reduce heat to low, and simmer, covered, until three-quarters of the milk has been absorbed, about 15 minutes.', 12);
INSERT INTO public.steps VALUES (116, 'Stir in sugar and cinnamon. Cook, covered, until almost all the milk has been absorbed, about 8 minutes. Stir in blueberries, and cook for 30 seconds. Serve with additional milk, sugar, cinnamon, and blueberries.', 12);
INSERT INTO public.steps VALUES (120, 'Let frozen sausage log stand at room temperature for 20 minutes. Unwrap sausage, andslice crosswise into 1/2-inch-thick rounds using a serrated knife. Cook a few patties in a large heavy skillet, preferably cast iron, over medium-high heat until browned and cooked through, 3 to 5 minutes per side. Push patties to 1 side of skillet and cook eggs as desired, adding unsalted butter if needed.', 13);
INSERT INTO public.steps VALUES (123, 'Preheat oven to 350 degrees. Cut bread horizontally. Lightly toast in oven, cut sides up. Top with cheese (1 slice on each side), and continue to cook in oven until cheese melts, 1 to 2 minutes. Meanwhile, fry eggs in butter; season with salt and pepper.', 14);
INSERT INTO public.steps VALUES (124, 'Place eggs on bottom half of bread. Top with tomatoes and basil. Sandwich with top bread half, and press down slightly. Wrap tightly in parchment.', 14);
INSERT INTO public.steps VALUES (130, 'Bring uncooked rice blend and 1 cup water to a boil in a small saucepan. Reduce heat, cover, and simmer until tender and water is absorbed, about 18 minutes. Remove from heat; let stand, covered, 10 minutes. Fluff with a fork.', 15);
INSERT INTO public.steps VALUES (131, 'Add coconut milk, maple syrup, and 1/2 cup water; stir to combine. Stir in cinnamon and a pinch of kosher salt. Return to low heat and simmer until slightly thickened, about 5 minutes. Remove from heat; fold in frozen raspberries. Transfer mixture to a bowl set in an ice-water bath; stir occasionally until chilled. Serve with more maple syrup, fresh raspberries, and toasted unsweetened coconut flakes, if desired.', 15);
INSERT INTO public.steps VALUES (137, 'Preheat oven to 350 degrees. Butter a 9-inch-round cake pan (at least 2 inches deep). Line bottom of pan with a parchment-paper round.', 16);
INSERT INTO public.steps VALUES (138, 'In a large bowl, whisk together eggs and cream; season with salt and pepper. Thinly slice potatoes (less than 1/4 inch thick); drop into egg mixture.', 16);
INSERT INTO public.steps VALUES (139, 'Lifting potatoes out of egg mixture, arrange half the potatoes in pan. Layer with ham, broccoli, cheese, and remaining potatoes. Pour egg mixture over top. Press down firmly so that potatoes are fully submerged in egg mixture.', 16);
INSERT INTO public.steps VALUES (140, 'Cover with foil; bake until potatoes are tender, about 1 hour. Uncover; continue baking until golden and set, 30 to 45 minutes more.', 16);
INSERT INTO public.steps VALUES (141, 'Cool 15 to 20 minutes in pan. Run a knife around edge, and carefully invert onto a plate. Peel off parchment. Reinvert, top side up. Slice with a serrated knife.', 16);
INSERT INTO public.steps VALUES (146, 'Preheat oven to 375 degrees. In a large bowl, combine strawberries, rhubarb, raw sugar, cornstarch, and salt. Transfer to an 8-inch baking dish.', 17);
INSERT INTO public.steps VALUES (147, 'In a medium bowl, combine oats, flour, butter, brown sugar, and salt. Stir until combined and slightly clumpy. Sprinkle over fruit.', 17);
INSERT INTO public.steps VALUES (148, 'Bake until juices are bubbling in the center and topping is golden brown, about 45 minutes. Let cool slightly. Garnish with basil.', 17);
INSERT INTO public.steps VALUES (157, 'Melt butter in a large skillet over medium high heat. Add chicken and sprinkle with garlic powder, seasoning salt and onion powder. Saute about 10 to 15 minutes on each side, or until chicken is cooked through and juices run clear.', 18);
INSERT INTO public.steps VALUES (162, 'In a large pot of boiling salted water, cook pasta according to package instructions. Reserve 1 cup pasta water; drain pasta and return to pot. Meanwhile, in a small pot, heat oil over medium. Add shallots, season with salt and pepper, and cook, stirring, until tender, 4 minutes. Add cream and lemon zest. Bring to a boil and cook until slightly thickened, 8 minutes. Add lemon juice and season to taste with salt and pepper. Pour cream sauce over pasta and toss, adding enough pasta water to create a thin sauce that coats pasta.', 19);
INSERT INTO public.steps VALUES (168, 'In a large saucepan of boiling salted water, cook pasta until al dente.', 20);
INSERT INTO public.steps VALUES (169, 'Meanwhile, in a small nonstick skillet, melt half the butter over medium. Add garlic and pinch of red-pepper flakes; cook until fragrant, 1 minute. Raise heat to medium-high; add wine. Cook until reduced by 1/3, about 1 minute. Add shrimp and season with salt and pepper; cook until opaque throughout, 1 to 2 minutes. Remove skillet from heat; swirl in lemon juice and remaining butter. Add pasta and toss to combine. Serve topped with parsley.', 20);
INSERT INTO public.steps VALUES (177, 'Combine pasta, tomatoes, onion, garlic, red-pepper flakes, basil, oil, 2 teaspoons salt, 1/4 teaspoon pepper, and water in a large straight-sided skillet. Bring to a boil over high heat. Boil mixture, stirring and turning pasta frequently with tongs, until pasta is al dente and water has nearly evaporated, about 9 minutes.', 21);
INSERT INTO public.steps VALUES (178, 'Season to taste with salt and pepper, divide among 4 bowls, and garnish with basil. Serve with oil and Parmesan.', 21);
INSERT INTO public.steps VALUES (187, 'Heat broiler, with rack in top position. In a small saucepan, heat oil over medium-high. Add shallot and cook, stirring often until softened, 3 minutes. Add vinegar and cook until slightly evaporated, 1 minute. Add mustard and brown sugar; stir until warm and combined, 1 minute. Season with salt and pepper and remove from heat. (To store, refrigerate cooled glaze in an airtight container, up to 1 day.)', 22);
INSERT INTO public.steps VALUES (188, 'Place salmon fillets on a foil-lined rimmed baking sheet and season with salt and pepper. Transfer 1/2 cup glaze to a small dish and brush on top of salmon. Broil salmon until glaze is bubbling and fish is opaque throughout, 5 to 10 minutes, depending on thickness; brush remaining glaze over fillets. Serve salmon along with watercress and lemon wedges.', 22);
INSERT INTO public.steps VALUES (196, 'Whisk together oil, lemon juice, and mustard and season with salt and pepper.', 23);
INSERT INTO public.steps VALUES (197, 'Toss dressing with fennel bulb and radishes and adjust seasoning if necessary. Top with Parmesan and fennel fronds.', 23);
INSERT INTO public.steps VALUES (203, 'Melt butter in a medium saucepan over medium-high heat. Add flour; whisk until nutty and golden, 1 to 2 minutes. Whisk in milk; bring to a gentle boil, whisking constantly, until mixture thickens to consistency of gravy, 4 to 5 minutes. Remove from heat, season with salt and pepper, and cover to keep warm.', 24);
INSERT INTO public.steps VALUES (204, 'Cut eggs in half. Remove yolks and press through a medium-mesh sieve, or mince them. Chop whites; stir into bechamel. Toast and butter bread. Divide bechamel mixture evenly among toasts; sprinkle evenly with yolks. Top with chives, paprika, and pepper. Serve immediately.', 24);


--
-- Name: steps_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ainaasakinah
--

SELECT pg_catalog.setval('public.steps_id_seq', 1, false);


--
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (id);


--
-- Name: steps steps_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

