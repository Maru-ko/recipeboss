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
-- Name: recipes; Type: TABLE; Schema: public; Owner: ainaasakinah
--

CREATE TABLE public.recipes (
    id integer NOT NULL,
    name text NOT NULL,
    cook_time text
);


ALTER TABLE public.recipes OWNER TO ainaasakinah;

--
-- Name: recipes_id_seq; Type: SEQUENCE; Schema: public; Owner: ainaasakinah
--

CREATE SEQUENCE public.recipes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recipes_id_seq OWNER TO ainaasakinah;

--
-- Name: recipes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ainaasakinah
--

ALTER SEQUENCE public.recipes_id_seq OWNED BY public.recipes.id;


--
-- Name: recipes id; Type: DEFAULT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.recipes ALTER COLUMN id SET DEFAULT nextval('public.recipes_id_seq'::regclass);


--
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: ainaasakinah
--

INSERT INTO public.recipes VALUES (1, 'John Legend''s Macaroni and Cheese', '60');
INSERT INTO public.recipes VALUES (2, 'Vegetarian Shepherd''s Pie', '60');
INSERT INTO public.recipes VALUES (3, 'Split-Pea Soup with Spinach and Barley', '60');
INSERT INTO public.recipes VALUES (4, 'Vegan Lentil Soup', '60');
INSERT INTO public.recipes VALUES (5, 'Brown-Butter Sweet-Potato Gnocchi with Seeds', '90');
INSERT INTO public.recipes VALUES (6, 'Quick Carrots and Snap Peas with Lemony Mustard Dressing', '30');
INSERT INTO public.recipes VALUES (7, 'Spaghetti with Tomato Saute', '120');
INSERT INTO public.recipes VALUES (8, 'Breakfast Burrito', '60');
INSERT INTO public.recipes VALUES (9, 'Breakfast Vegetable-Miso Soup with Chickpeas', '60');
INSERT INTO public.recipes VALUES (10, 'Southwestern Breakfast Hash', '90');
INSERT INTO public.recipes VALUES (11, 'Savory Breakfast Bowl', '120');
INSERT INTO public.recipes VALUES (12, 'Breakfast Quinoa', '30');
INSERT INTO public.recipes VALUES (13, 'Breakfast Sausage Patties with Fried Eggs', '120');
INSERT INTO public.recipes VALUES (14, 'Egg-and-Tomato Breakfast Sandwich To Go', '120');
INSERT INTO public.recipes VALUES (15, 'Coconut-Raspberry Breakfast Pudding', '90');
INSERT INTO public.recipes VALUES (16, 'Ham-and-Potato Bake', '30');
INSERT INTO public.recipes VALUES (17, 'Strawberry-Rhubarb Crisp', '30');
INSERT INTO public.recipes VALUES (18, 'A Good Easy Garlic Chicken', '45');
INSERT INTO public.recipes VALUES (19, 'Linguine with Lemon-Cream Sauce', '30');
INSERT INTO public.recipes VALUES (20, 'Linguine with Shrimp and White Wine', '30');
INSERT INTO public.recipes VALUES (21, 'One-Pan Pasta', '45');
INSERT INTO public.recipes VALUES (22, 'Salmon with Brown Sugar and Mustard Glaze', '45');
INSERT INTO public.recipes VALUES (23, 'Shaved Radish, Fennel, and Parmesan Salad', '45');
INSERT INTO public.recipes VALUES (24, 'Eggs Goldenrod', '30');


--
-- Name: recipes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ainaasakinah
--

SELECT pg_catalog.setval('public.recipes_id_seq', 1, false);


--
-- Name: recipes recipes_pkey; Type: CONSTRAINT; Schema: public; Owner: ainaasakinah
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT recipes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

