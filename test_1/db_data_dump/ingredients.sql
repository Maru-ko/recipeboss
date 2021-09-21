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
-- Name: ingredients; Type: TABLE; Schema: public; Owner: ainaasakinah
--

CREATE TABLE public.ingredients (
    id integer NOT NULL,
    name text,
    recipe_id integer NOT NULL
);


ALTER TABLE public.ingredients OWNER TO ainaasakinah;

--
-- Name: ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: ainaasakinah
--

CREATE SEQUENCE public.ingredients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ingredients_id_seq OWNER TO ainaasakinah;

--
-- Name: ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ainaasakinah
--

ALTER SEQUENCE public.ingredients_id_seq OWNED BY public.ingredients.id;


--
-- Name: ingredients id; Type: DEFAULT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.ingredients ALTER COLUMN id SET DEFAULT nextval('public.ingredients_id_seq'::regclass);


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: ainaasakinah
--

INSERT INTO public.ingredients VALUES (1, '4 tablespoons (1/2 stick) unsalted butter, plus more for baking dish', 1);
INSERT INTO public.ingredients VALUES (2, 'Coarse salt and freshly ground pepper', 1);
INSERT INTO public.ingredients VALUES (3, '3 cups elbow macaroni', 1);
INSERT INTO public.ingredients VALUES (4, '2 (12-ounce) cans evaporated milk', 1);
INSERT INTO public.ingredients VALUES (5, '1/3 cup skim milk', 1);
INSERT INTO public.ingredients VALUES (6, '2 large eggs', 1);
INSERT INTO public.ingredients VALUES (7, '1/2 teaspoon seasoned salt', 1);
INSERT INTO public.ingredients VALUES (8, '1/4 teaspoon garlic powder', 1);
INSERT INTO public.ingredients VALUES (9, '2 (8-ounce) packages extra-sharp cheddar cheese, grated', 1);
INSERT INTO public.ingredients VALUES (10, '1 (8-ounce) package Monterey Jack cheese, grated', 1);
INSERT INTO public.ingredients VALUES (11, 'Paprika, for sprinkling', 1);
INSERT INTO public.ingredients VALUES (12, '2 tablespoons extra-virgin olive oil', 2);
INSERT INTO public.ingredients VALUES (13, '1 large onion, finely diced', 2);
INSERT INTO public.ingredients VALUES (14, '2 carrots, peeled and thinly sliced', 2);
INSERT INTO public.ingredients VALUES (15, '2 celery stalks, thinly sliced', 2);
INSERT INTO public.ingredients VALUES (16, '10 ounces cremini mushrooms, trimmed and sliced', 2);
INSERT INTO public.ingredients VALUES (17, '1 tablespoon tomato paste', 2);
INSERT INTO public.ingredients VALUES (18, '1 tablespoon vegetarian Worcestershire sauce, such as Annie''s Naturals', 2);
INSERT INTO public.ingredients VALUES (19, '1 dried bay leaf', 2);
INSERT INTO public.ingredients VALUES (20, '1 cup French green lentils, picked over', 2);
INSERT INTO public.ingredients VALUES (21, 'Kosher salt and freshly ground pepper', 2);
INSERT INTO public.ingredients VALUES (22, '1 cup frozen peas', 2);
INSERT INTO public.ingredients VALUES (23, '2 pounds Yukon Gold potatoes, scrubbed and cut into 1 1/2-inch pieces', 2);
INSERT INTO public.ingredients VALUES (24, '4 cloves garlic', 2);
INSERT INTO public.ingredients VALUES (25, '4 tablespoons unsalted butter', 2);
INSERT INTO public.ingredients VALUES (26, '1/2 cup whole milk, warmed', 2);
INSERT INTO public.ingredients VALUES (27, '2 tablespoons extra-virgin olive oil, plus more for drizzling', 3);
INSERT INTO public.ingredients VALUES (28, '3 leeks, white and light-green parts only, chopped and well washed', 3);
INSERT INTO public.ingredients VALUES (29, '2 carrots, peeled and chopped', 3);
INSERT INTO public.ingredients VALUES (30, '2 celery stalks, chopped', 3);
INSERT INTO public.ingredients VALUES (31, '8 cups low-sodium chicken broth or water, or a combination', 3);
INSERT INTO public.ingredients VALUES (32, '1 pound dried split peas, picked over', 3);
INSERT INTO public.ingredients VALUES (33, '5 ounces baby spinach', 3);
INSERT INTO public.ingredients VALUES (34, 'Kosher salt and freshly ground pepper', 3);
INSERT INTO public.ingredients VALUES (35, '1/2 cup full-fat plain yogurt (not Greek), whisked, for serving', 3);
INSERT INTO public.ingredients VALUES (36, '2 cups <a href="http://www.marthastewart.com/1527738/how-cook-barley">cooked barley</a>, for serving', 3);
INSERT INTO public.ingredients VALUES (37, '2 tablespoons extra-virgin olive oil, plus more for drizzling', 4);
INSERT INTO public.ingredients VALUES (38, '1/2 cup chopped shallot', 4);
INSERT INTO public.ingredients VALUES (39, '1/2 cup chopped carrot', 4);
INSERT INTO public.ingredients VALUES (40, '1/2 cup chopped celery', 4);
INSERT INTO public.ingredients VALUES (41, '1/2 teaspoon ground cumin', 4);
INSERT INTO public.ingredients VALUES (42, '1/2 teaspoon ground coriander', 4);
INSERT INTO public.ingredients VALUES (43, 'Kosher salt and freshly ground pepper', 4);
INSERT INTO public.ingredients VALUES (44, '1 cup dried French lentils', 4);
INSERT INTO public.ingredients VALUES (45, '1 can (15 ounces) crushed tomatoes', 4);
INSERT INTO public.ingredients VALUES (46, '4 cups chopped broccoli rabe', 4);
INSERT INTO public.ingredients VALUES (47, '2 teaspoons red-wine vinegar', 4);
INSERT INTO public.ingredients VALUES (48, '1 pound sweet potatoes (2 to 3)', 5);
INSERT INTO public.ingredients VALUES (49, '1 1/2 cups unbleached all-purpose flour, plus more for dusting', 5);
INSERT INTO public.ingredients VALUES (50, '1 large egg, room temperature, beaten', 5);
INSERT INTO public.ingredients VALUES (51, '1 1/2 teaspoons kosher salt', 5);
INSERT INTO public.ingredients VALUES (52, '3 tablespoons pepitas', 5);
INSERT INTO public.ingredients VALUES (53, '1 tablespoon sesame seeds', 5);
INSERT INTO public.ingredients VALUES (54, '2 teaspoons poppy seeds', 5);
INSERT INTO public.ingredients VALUES (55, 'Kosher salt and freshly ground pepper', 5);
INSERT INTO public.ingredients VALUES (56, '1 stick unsalted butter', 5);
INSERT INTO public.ingredients VALUES (57, 'Handful of fresh sage leaves, sliced if large', 5);
INSERT INTO public.ingredients VALUES (58, '2 tablespoons Dijon mustard', 6);
INSERT INTO public.ingredients VALUES (59, '1 teaspoon finely grated lemon zest, plus 3 tablespoons fresh juice', 6);
INSERT INTO public.ingredients VALUES (60, 'Kosher salt and freshly ground pepper', 6);
INSERT INTO public.ingredients VALUES (61, '1/3 cup extra-virgin olive oil', 6);
INSERT INTO public.ingredients VALUES (62, '1 1/2 pounds carrots, peeled and cut on the bias into 1/4-inch-thick slices (4 1/2 cups)', 6);
INSERT INTO public.ingredients VALUES (63, '3 tablespoons unsalted butter', 6);
INSERT INTO public.ingredients VALUES (64, '12 ounces sugar snap peas, trimmed if stringy, halved on the bias', 6);
INSERT INTO public.ingredients VALUES (65, '3 tablespoons extra-virgin olive oil, plus more for drizzling', 7);
INSERT INTO public.ingredients VALUES (66, '3 pints red, orange, and yellow pear or cherry tomatoes (about 2 pounds), halved if large; plus a few more, still on the vine (optional)', 7);
INSERT INTO public.ingredients VALUES (67, 'Kosher salt', 7);
INSERT INTO public.ingredients VALUES (68, '2 cloves garlic, minced', 7);
INSERT INTO public.ingredients VALUES (69, 'Large pinch of red-pepper flakes, plus more for serving', 7);
INSERT INTO public.ingredients VALUES (70, '12 ounces spaghetti or bucatini', 7);
INSERT INTO public.ingredients VALUES (71, '2 ounces Parmigiano-Reggiano, finely grated (1/2 cup)', 7);
INSERT INTO public.ingredients VALUES (72, '1/2 cup fresh ricotta cheese', 7);
INSERT INTO public.ingredients VALUES (73, 'Small fresh basil leaves, for serving', 7);
INSERT INTO public.ingredients VALUES (74, '<a href="https://www.marthastewart.com/255832/saras-herb-cream-cheese">Sara''s Herb Cream Cheese</a>', 8);
INSERT INTO public.ingredients VALUES (75, '<a href="https://www.marthastewart.com/343697/saras-roasted-plum-tomatoes">Sara''s Roasted Plum Tomatoes</a>', 8);
INSERT INTO public.ingredients VALUES (76, '<a href="https://www.marthastewart.com/344222/saras-salad-greens-mixture">Sara''s Salad Greens Mixture</a>', 8);
INSERT INTO public.ingredients VALUES (77, '<a href="https://www.marthastewart.com/255365/saras-scrambled-eggs">Sara''s Scrambled Eggs</a>', 8);
INSERT INTO public.ingredients VALUES (78, '4 twelve-inch spinach tortillas', 8);
INSERT INTO public.ingredients VALUES (79, 'Extra-virgin olive oil', 8);
INSERT INTO public.ingredients VALUES (80, '8 ounces smoked salmon', 8);
INSERT INTO public.ingredients VALUES (81, '8 tablespoons alfalfa sprouts', 8);
INSERT INTO public.ingredients VALUES (82, '1 small bunch basil, minced, for garnish', 8);
INSERT INTO public.ingredients VALUES (83, '4 scallions, white part only, julienned, for garnish', 8);
INSERT INTO public.ingredients VALUES (84, '1/2 small red onion, thinly sliced, for garnish', 8);
INSERT INTO public.ingredients VALUES (85, '2 tablespoon olive oil', 9);
INSERT INTO public.ingredients VALUES (86, '1/2 yellow onion, chopped', 9);
INSERT INTO public.ingredients VALUES (87, '2 garlic cloves, minced', 9);
INSERT INTO public.ingredients VALUES (88, '2 celery stalks, diced', 9);
INSERT INTO public.ingredients VALUES (89, '2 carrots, peeled and diced', 9);
INSERT INTO public.ingredients VALUES (90, '1 cup chopped broccoli', 9);
INSERT INTO public.ingredients VALUES (91, '1 cup cooked chickpeas', 9);
INSERT INTO public.ingredients VALUES (92, '2 tablespoons white miso', 9);
INSERT INTO public.ingredients VALUES (93, 'Coarse salt', 9);
INSERT INTO public.ingredients VALUES (94, '2 medium red potatoes, scrubbed and cut into 1-inch pieces', 10);
INSERT INTO public.ingredients VALUES (95, '3 tablespoons canola oil', 10);
INSERT INTO public.ingredients VALUES (96, '1/2 teaspoon ground cumin', 10);
INSERT INTO public.ingredients VALUES (97, '1 jalapeno, seeded and finely diced', 10);
INSERT INTO public.ingredients VALUES (98, '3 scallions, cut into 1/4-inch slices (reserve 1 for garnish)', 10);
INSERT INTO public.ingredients VALUES (99, '8 ounces cherry tomatoes, halved', 10);
INSERT INTO public.ingredients VALUES (100, '1 can (15 ounces) black beans, drained and rinsed', 10);
INSERT INTO public.ingredients VALUES (101, '2 teaspoons nutritional yeast seasoning', 10);
INSERT INTO public.ingredients VALUES (102, '1 package (8 ounces) plain, pasteurized organic tempeh, crumbled', 10);
INSERT INTO public.ingredients VALUES (103, '1 medium avocado, coarsely chopped', 10);
INSERT INTO public.ingredients VALUES (104, 'Coarse salt and freshly ground black pepper', 10);
INSERT INTO public.ingredients VALUES (105, '8 ounces cherry tomatoes (1 1/4 cups)', 11);
INSERT INTO public.ingredients VALUES (106, '3 tablespoons extra-virgin olive oil, plus more for drizzling', 11);
INSERT INTO public.ingredients VALUES (107, 'Coarse salt and freshly ground pepper', 11);
INSERT INTO public.ingredients VALUES (108, '4 packed cups finely shredded stemmed kale (from 1 bunch)', 11);
INSERT INTO public.ingredients VALUES (109, '2 tablespoons minced garlic (from 2 cloves)', 11);
INSERT INTO public.ingredients VALUES (110, '3 cups <a href="https://www.marthastewart.com/1132756/cooked-hulled-barley">Cooked Hulled Barley</a>, such as Hayden Flour Mills Purple-and-Bronze', 11);
INSERT INTO public.ingredients VALUES (111, '4 large eggs', 11);
INSERT INTO public.ingredients VALUES (112, '2 ripe but firm small avocados, halved, pitted, and scooped from skins', 11);
INSERT INTO public.ingredients VALUES (113, '1/2 cup diced English cucumber', 11);
INSERT INTO public.ingredients VALUES (114, 'Plain Greek yogurt, for serving', 11);
INSERT INTO public.ingredients VALUES (115, '2 cups whole or low-fat milk, plus more for serving', 12);
INSERT INTO public.ingredients VALUES (116, '1 cup quinoa, rinsed', 12);
INSERT INTO public.ingredients VALUES (117, '3 tablespoons light-brown sugar, plus more for serving', 12);
INSERT INTO public.ingredients VALUES (118, '1/8 teaspoon ground cinnamon, plus more for serving', 12);
INSERT INTO public.ingredients VALUES (119, '1 cup (1/2 pint) fresh blueberries, plus more for serving', 12);
INSERT INTO public.ingredients VALUES (120, '<a href="https://www.marthastewart.com/856106/sausage-logs">1 frozen sausage log</a>', 13);
INSERT INTO public.ingredients VALUES (121, '2 large eggs', 13);
INSERT INTO public.ingredients VALUES (122, 'Unsalted butter, if needed', 13);
INSERT INTO public.ingredients VALUES (123, '1 piece (6 inches long) baguette', 14);
INSERT INTO public.ingredients VALUES (124, '2 slices cheddar cheese', 14);
INSERT INTO public.ingredients VALUES (125, '2 large eggs', 14);
INSERT INTO public.ingredients VALUES (126, '1 teaspoon butter', 14);
INSERT INTO public.ingredients VALUES (127, 'Coarse salt and freshly ground pepper', 14);
INSERT INTO public.ingredients VALUES (128, '2 large tomato slices', 14);
INSERT INTO public.ingredients VALUES (129, '1/4 cup fresh basil leaves', 14);
INSERT INTO public.ingredients VALUES (130, '1/2 cup uncooked rice blend (such as Rice Select Royal Blend, with quinoa and freekeh)', 15);
INSERT INTO public.ingredients VALUES (131, 'One 15-ounce can unsweetened coconut milk', 15);
INSERT INTO public.ingredients VALUES (132, '2 tablespoons pure maple syrup, plus more for serving', 15);
INSERT INTO public.ingredients VALUES (133, '1/8 teaspoon ground cinnamon', 15);
INSERT INTO public.ingredients VALUES (134, 'Kosher salt', 15);
INSERT INTO public.ingredients VALUES (135, '1 cup frozen raspberries', 15);
INSERT INTO public.ingredients VALUES (136, 'Fresh raspberries and toasted unsweetened coconut flakes, for serving', 15);
INSERT INTO public.ingredients VALUES (137, 'Butter, for pan', 16);
INSERT INTO public.ingredients VALUES (138, '6 large eggs', 16);
INSERT INTO public.ingredients VALUES (139, '1 1/2 cups heavy cream', 16);
INSERT INTO public.ingredients VALUES (140, '2 teaspoons coarse salt', 16);
INSERT INTO public.ingredients VALUES (141, '1/2 teaspoon ground pepper', 16);
INSERT INTO public.ingredients VALUES (142, '2 baking potatoes (about 1 1/4 pounds), peeled', 16);
INSERT INTO public.ingredients VALUES (143, '10 ounces sugar-baked ham, thinly sliced (less than 1/4 inch thick)', 16);
INSERT INTO public.ingredients VALUES (144, '1 package (10 ounces) frozen broccoli, thawed and squeezed dry with paper towels', 16);
INSERT INTO public.ingredients VALUES (145, '1/2 cup grated cheddar cheese (2 ounces)', 16);
INSERT INTO public.ingredients VALUES (146, '8 ounces strawberries, hulled and halved (quartered if large)', 17);
INSERT INTO public.ingredients VALUES (147, '8 ounces rhubarb, trimmed, cut into 1/2-inch pieces', 17);
INSERT INTO public.ingredients VALUES (148, '1/2 cup raw sugar', 17);
INSERT INTO public.ingredients VALUES (149, '1 tablespoon cornstarch', 17);
INSERT INTO public.ingredients VALUES (150, '1/4 teaspoon coarse salt', 17);
INSERT INTO public.ingredients VALUES (151, '1 cup rolled oats', 17);
INSERT INTO public.ingredients VALUES (152, '1/4 cup all-purpose flour', 17);
INSERT INTO public.ingredients VALUES (153, '1/4 cup unsalted butter (1/2 stick), melted', 17);
INSERT INTO public.ingredients VALUES (154, '1/4 cup brown sugar', 17);
INSERT INTO public.ingredients VALUES (155, '1/8 teaspoon coarse salt', 17);
INSERT INTO public.ingredients VALUES (156, 'Fresh basil leaves, torn if large', 17);
INSERT INTO public.ingredients VALUES (157, '3 tablespoons butter', 18);
INSERT INTO public.ingredients VALUES (158, '4 skinless, boneless chicken breast halves', 18);
INSERT INTO public.ingredients VALUES (159, '2 teaspoons garlic powder', 18);
INSERT INTO public.ingredients VALUES (160, '1 teaspoon seasoning salt', 18);
INSERT INTO public.ingredients VALUES (161, '1 teaspoon onion powder', 18);
INSERT INTO public.ingredients VALUES (162, 'Coarse salt and ground pepper', 19);
INSERT INTO public.ingredients VALUES (163, '1 pound linguine', 19);
INSERT INTO public.ingredients VALUES (164, '1 teaspoon extra-virgin olive oil', 19);
INSERT INTO public.ingredients VALUES (165, '2 shallots, minced', 19);
INSERT INTO public.ingredients VALUES (166, '1 cup heavy cream', 19);
INSERT INTO public.ingredients VALUES (167, '1 teaspoon grated lemon zest, plus 2 tablespoons lemon juice (from 1 lemon)', 19);
INSERT INTO public.ingredients VALUES (168, 'Coarse salt and ground pepper', 20);
INSERT INTO public.ingredients VALUES (169, '2 ounces linguine (about a 1/2-inch-wide handful)', 20);
INSERT INTO public.ingredients VALUES (170, '1 tablespoon cold butter, cut into pieces', 20);
INSERT INTO public.ingredients VALUES (171, '1 garlic clove, minced', 20);
INSERT INTO public.ingredients VALUES (172, 'Red-pepper flakes', 20);
INSERT INTO public.ingredients VALUES (173, '1/3 cup dry white wine', 20);
INSERT INTO public.ingredients VALUES (174, '1/4 pound large shrimp, peeled and deveined', 20);
INSERT INTO public.ingredients VALUES (175, '1/2 teaspoon fresh lemon juice', 20);
INSERT INTO public.ingredients VALUES (176, 'Fresh parsley leaves, for garnish', 20);
INSERT INTO public.ingredients VALUES (177, '12 ounces linguine', 21);
INSERT INTO public.ingredients VALUES (178, '12 ounces cherry or grape tomatoes, halved or quartered if large', 21);
INSERT INTO public.ingredients VALUES (179, '1 onion, thinly sliced (about 2 cups)', 21);
INSERT INTO public.ingredients VALUES (180, '4 cloves garlic, thinly sliced', 21);
INSERT INTO public.ingredients VALUES (181, '1/2 teaspoon red-pepper flakes', 21);
INSERT INTO public.ingredients VALUES (182, '2 sprigs basil, plus torn leaves for garnish', 21);
INSERT INTO public.ingredients VALUES (183, '2 tablespoons extra-virgin olive oil, plus more for serving', 21);
INSERT INTO public.ingredients VALUES (184, 'Coarse salt and freshly ground pepper', 21);
INSERT INTO public.ingredients VALUES (185, '4 1/2 cups water', 21);
INSERT INTO public.ingredients VALUES (186, 'Freshly grated Parmesan cheese, for serving', 21);
INSERT INTO public.ingredients VALUES (187, '1 tablespoon extra-virgin olive oil', 22);
INSERT INTO public.ingredients VALUES (188, '1 large shallot, minced', 22);
INSERT INTO public.ingredients VALUES (189, '1/4 cup red-wine vinegar', 22);
INSERT INTO public.ingredients VALUES (190, '1/4 cup whole-grain mustard', 22);
INSERT INTO public.ingredients VALUES (191, '1/4 cup packed dark-brown sugar', 22);
INSERT INTO public.ingredients VALUES (192, 'Coarse salt and ground pepper', 22);
INSERT INTO public.ingredients VALUES (193, '1 side salmon (about 3 pounds), skin removed, cut into 8 fillets', 22);
INSERT INTO public.ingredients VALUES (194, '1 bunch watercress (about 3/4 pound), thick stems trimmed', 22);
INSERT INTO public.ingredients VALUES (195, '1 lemon, cut into wedges, for serving', 22);
INSERT INTO public.ingredients VALUES (196, '2 tablespoons extra-virgin olive oil', 23);
INSERT INTO public.ingredients VALUES (197, '1 tablespoon fresh lemon juice', 23);
INSERT INTO public.ingredients VALUES (198, '2 teaspoons whole-grain mustard', 23);
INSERT INTO public.ingredients VALUES (199, 'Coarse salt and ground black pepper', 23);
INSERT INTO public.ingredients VALUES (200, '1 bulb fennel, cored and thinly sliced, plus 1/4 cup fronds', 23);
INSERT INTO public.ingredients VALUES (201, '5 radishes, thinly sliced', 23);
INSERT INTO public.ingredients VALUES (202, '3 tablespoons freshly shaved Parmesan', 23);
INSERT INTO public.ingredients VALUES (203, '4 tablespoons unsalted butter, plus more for toast', 24);
INSERT INTO public.ingredients VALUES (204, '1/4 cup unbleached all-purpose flour', 24);
INSERT INTO public.ingredients VALUES (205, '3 cups whole milk', 24);
INSERT INTO public.ingredients VALUES (206, 'Kosher salt and freshly ground pepper', 24);
INSERT INTO public.ingredients VALUES (207, '6 peeled hard-boiled eggs', 24);
INSERT INTO public.ingredients VALUES (208, '6 slices white sandwich bread', 24);
INSERT INTO public.ingredients VALUES (209, 'Chopped chives and smoked paprika, for serving', 24);


--
-- Name: ingredients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ainaasakinah
--

SELECT pg_catalog.setval('public.ingredients_id_seq', 1, false);


--
-- Name: ingredients ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_pkey PRIMARY KEY (id);


--
-- Name: ingredients ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

