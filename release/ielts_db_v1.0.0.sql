--
-- PostgreSQL database dump
--

\restrict if93ZGRcuKIELxizNlucyslDP3IBtBAiUB31PabPCxTsYh2vYXAUo6thbpDpZ2B

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO admin;

--
-- Name: answer_keys; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.answer_keys (
    id integer NOT NULL,
    question_id integer NOT NULL,
    correct_answer jsonb NOT NULL,
    explanation text
);


ALTER TABLE public.answer_keys OWNER TO admin;

--
-- Name: answer_keys_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.answer_keys ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.answer_keys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: audio_tracks; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.audio_tracks (
    id integer NOT NULL,
    section_id integer NOT NULL,
    file_path text NOT NULL,
    checksum text NOT NULL,
    duration_seconds numeric
);


ALTER TABLE public.audio_tracks OWNER TO admin;

--
-- Name: audio_tracks_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.audio_tracks ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.audio_tracks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: books; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title text NOT NULL,
    total_pages integer,
    source_pdf_path text NOT NULL,
    source_pdf_checksum text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.books OWNER TO admin;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.books ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.books_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: passages; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.passages (
    id integer NOT NULL,
    section_id integer NOT NULL,
    title text,
    body_text text
);


ALTER TABLE public.passages OWNER TO admin;

--
-- Name: passages_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.passages ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.passages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: question_groups; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.question_groups (
    id integer NOT NULL,
    section_id integer NOT NULL,
    group_order integer NOT NULL,
    question_type text NOT NULL,
    instruction text,
    question_from integer NOT NULL,
    question_to integer NOT NULL
);


ALTER TABLE public.question_groups OWNER TO admin;

--
-- Name: question_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.question_groups ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.question_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: question_options; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.question_options (
    id integer NOT NULL,
    question_id integer NOT NULL,
    option_label text,
    option_text text
);


ALTER TABLE public.question_options OWNER TO admin;

--
-- Name: question_options_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.question_options ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.question_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: questions; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    question_number integer NOT NULL,
    prompt_text text,
    audio_start_sec numeric,
    audio_end_sec numeric,
    page_reference integer
);


ALTER TABLE public.questions OWNER TO admin;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.questions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.questions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.sections (
    id integer NOT NULL,
    test_id integer NOT NULL,
    skill text NOT NULL,
    part_number integer NOT NULL,
    page_start integer,
    page_end integer,
    CONSTRAINT sections_skill_check CHECK ((skill = ANY (ARRAY['listening'::text, 'reading'::text, 'writing'::text, 'speaking'::text])))
);


ALTER TABLE public.sections OWNER TO admin;

--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.sections ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: tests; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tests (
    id integer NOT NULL,
    book_id integer NOT NULL,
    test_number integer NOT NULL
);


ALTER TABLE public.tests OWNER TO admin;

--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.tests ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_answers; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_answers (
    id integer NOT NULL,
    attempt_id integer NOT NULL,
    question_id integer,
    given_answer text,
    is_correct boolean
);


ALTER TABLE public.user_answers OWNER TO admin;

--
-- Name: user_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.user_answers ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_answers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: user_attempts; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.user_attempts (
    id integer NOT NULL,
    user_id integer NOT NULL,
    section_id integer,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    finished_at timestamp with time zone
);


ALTER TABLE public.user_attempts OWNER TO admin;

--
-- Name: user_attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.user_attempts ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.user_attempts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text NOT NULL,
    password_hash text NOT NULL,
    is_admin boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO admin;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.alembic_version (version_num) FROM stdin;
0001_initial_schema
\.


--
-- Data for Name: answer_keys; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.answer_keys (id, question_id, correct_answer, explanation) FROM stdin;
1	1	["Jamieson"]	Agent's surname is Jamieson
2	2	["afternoon"]	Best time to call is in the afternoon
3	3	["communication"]	Requires communication skills
4	4	["week"]	Job duration is at least one week
5	5	["10", "ten"]	Pay is 10 / ten pounds per hour
6	6	["suit"]	Must wear a suit
7	7	["passport"]	Bring passport for identity check
8	8	["personality"]	Questions regarding personality
9	9	["feedback"]	Helpful feedback provided
10	10	["time"]	Takes less time
11	11	["A"]	
12	12	["B"]	
13	13	["A"]	
14	14	["C"]	
15	15	["river"]	
16	16	["1422"]	
17	17	["top"]	
18	18	["pass"]	
19	19	["steam"]	
20	20	["capital"]	
21	21	["G"]	G - caring
22	22	["F"]	F - co-operative
23	23	["A"]	A - outgoing
24	24	["E"]	E - introverted
25	25	["B"]	B - selfish
26	26	["C"]	C - independent
27	27	["C"]	
28	28	["A"]	
29	29	["B", "D"]	B or D
30	30	["B", "D"]	B or D
31	31	["shelter"]	
32	32	["oil"]	
33	33	["roads"]	
34	34	["insects"]	
35	35	["grass", "grasses"]	
36	36	["water"]	
37	37	["soil"]	
38	38	["dry"]	
39	39	["simple"]	
40	40	["nest", "nests"]	
41	41	["oval"]	
42	42	["husk"]	
43	43	["seed"]	
44	44	["mace"]	
45	45	["FALSE"]	
46	46	["NOT GIVEN"]	
47	47	["TRUE"]	
48	48	["Arabs"]	
49	49	["plague"]	
50	50	["lime"]	
51	51	["Run"]	
52	52	["Mauritius"]	
53	53	["tsunami"]	
54	54	["C"]	
55	55	["B"]	
56	56	["E"]	
57	57	["G"]	
58	58	["D"]	
59	59	["human error"]	
60	60	["car sharing", "car-sharing"]	
61	61	["ownership"]	
62	62	["mileage"]	
63	63	["C", "D"]	
64	64	["C", "D"]	
65	65	["A", "E"]	
66	66	["A", "E"]	
67	67	["A"]	
68	68	["C"]	
69	69	["C"]	
70	70	["D"]	
71	71	["A"]	
72	72	["B"]	B - Wilfred Thesiger
73	73	["E"]	E - Chris Bonington
74	74	["A"]	A - Peter Fleming
75	75	["D"]	D - Robin Hanbury-Tenison
76	76	["E"]	E - Chris Bonington
77	77	["B"]	B - Wilfred Thesiger
78	78	["unique expeditions", "expeditions", "unique"]	
79	79	["uncontacted", "isolated"]	
80	80	["surface", "land surface"]	
81	81	["Eustatis"]	
82	82	["review"]	
83	83	["dance"]	
84	84	["Chat"]	
85	85	["healthy"]	
86	86	["posters"]	
87	87	["wood"]	
88	88	["lake"]	
89	89	["insects"]	
90	90	["blog"]	
91	91	["C"]	
92	92	["A"]	
93	93	["B"]	
94	94	["C"]	
95	95	["E"]	
96	96	["C"]	
97	97	["B"]	
98	98	["A"]	
99	99	["G"]	
100	100	["D"]	
101	101	["B", "D"]	
102	102	["B", "D"]	
103	103	["B", "C"]	
104	104	["B", "C"]	
105	105	["G"]	
106	106	["B"]	
107	107	["D"]	
108	108	["C"]	
109	109	["H"]	
110	110	["F"]	
111	111	["Irrigation"]	
112	112	["women"]	
113	113	["wire", "wires"]	
114	114	["seed", "seeds"]	
115	115	["posts"]	
116	116	["transport"]	
117	117	["preservation"]	
118	118	["fish", "fishes"]	
119	119	["bees"]	
120	120	["design"]	
121	121	["B"]	
122	122	["C"]	
123	123	["F"]	
124	124	["D"]	
125	125	["E"]	
126	126	["A"]	
127	127	["safety"]	
128	128	["traffic"]	
129	129	["carriageway"]	
130	130	["mobile"]	
131	131	["dangerous"]	
132	132	["communities"]	
133	133	["healthy"]	
134	134	["F"]	
135	135	["A"]	
136	136	["D"]	
137	137	["A"]	
138	138	["genetic traits"]	
139	139	["heat loss"]	
140	140	["ears"]	
141	141	["insulating fat", "fat"]	
142	142	["carbon emissions", "emissions"]	
143	143	["B"]	
144	144	["C"]	
145	145	["A"]	
146	146	["C"]	
147	147	["C"]	
148	148	["A"]	
149	149	["B"]	
150	150	["B"]	
151	151	["D"]	
152	152	["F"]	
153	153	["H"]	
154	154	["C"]	
155	155	["D"]	
156	156	["E"]	
157	157	["NOT GIVEN"]	
158	158	["YES"]	
159	159	["NO"]	
160	160	["NO"]	
161	161	["furniture"]	
162	162	["meetings"]	
163	163	["diary"]	
164	164	["detail", "details"]	
165	165	["1", "one year"]	
166	166	["deliveries"]	
167	167	["tidy"]	
168	168	["team"]	
169	169	["heavy"]	
170	170	["customer"]	
171	171	["B"]	
172	172	["A"]	
173	173	["C"]	
174	174	["B"]	
175	175	["C"]	
176	176	["B"]	
177	177	["B", "D"]	
178	178	["B", "D"]	
179	179	["A", "E"]	
180	180	["A", "E"]	
181	181	["page"]	
182	182	["size"]	
183	183	["graphic", "graphics"]	
184	184	["structure"]	
185	185	["purpose"]	
186	186	["assumption", "assumptions"]	
187	187	["A"]	
188	188	["C"]	
189	189	["C"]	
190	190	["B"]	
191	191	["mud"]	
192	192	["clay"]	
193	193	["metal"]	
194	194	["hair"]	
195	195	["bath", "baths"]	
196	196	["disease", "diseases"]	
197	197	["perfume"]	
198	198	["salt"]	
199	199	["science"]	
200	200	["tax"]	
201	201	["TRUE"]	
202	202	["FALSE"]	
203	203	["NOT GIVEN"]	
204	204	["TRUE"]	
205	205	["NOT GIVEN"]	
206	206	["FALSE"]	
207	207	["TRUE"]	
208	208	["resignation"]	
209	209	["materials"]	
210	210	["miners"]	
211	211	["family"]	
212	212	["collectors"]	
213	213	["income"]	
214	214	["iii"]	
215	215	["vi"]	
216	216	["v"]	
217	217	["x"]	
218	218	["iv"]	
219	219	["viii"]	
220	220	["i"]	
221	221	["wheels"]	
222	222	["film"]	
223	223	["filter"]	
224	224	["waste"]	
225	225	["performance"]	
226	226	["servicing"]	
227	227	["C"]	
228	228	["B"]	
229	229	["F"]	
230	230	["A"]	
231	231	["E"]	
232	232	["D"]	
233	233	["F"]	
234	234	["B"]	
235	235	["C"]	
236	236	["G"]	
237	237	["B"]	
238	238	["D"]	
239	239	["A"]	
240	240	["A"]	
241	241	["journalist"]	
242	242	["shopping"]	
243	243	["Staunfirth"]	
244	244	["return"]	
245	245	["23.70"]	
246	246	["online"]	
247	247	["delay"]	
248	248	["information"]	
249	249	["platform", "platforms"]	
250	250	["parking"]	
251	251	["D"]	
252	252	["C"]	
253	253	["G"]	
254	254	["H"]	
255	255	["A"]	
256	256	["E"]	
257	257	["A", "D"]	
258	258	["A", "D"]	
259	259	["A", "C"]	
260	260	["A", "C"]	
261	261	["B"]	
262	262	["A"]	
263	263	["B"]	
264	264	["A"]	
265	265	["A"]	
266	266	["A"]	
267	267	["B"]	
268	268	["B"]	
269	269	["A"]	
270	270	["C"]	
271	271	["wealth"]	
272	272	["technology"]	
273	273	["power"]	
274	274	["textile", "textiles"]	
275	275	["machines"]	
276	276	["newspapers"]	
277	277	["local"]	
278	278	["lighting"]	
279	279	["windows"]	
280	280	["Advertising"]	
281	281	["water"]	
282	282	["diet"]	
283	283	["drought"]	
284	284	["erosion"]	
285	285	["desert"]	
286	286	["branches", "huarango branches", "the branches", "its branches"]	
287	287	["leaves and bark", "bark and leaves", "leaves", "bark"]	
288	288	["trunk", "huarango trunk", "the trunk", "its trunk"]	
289	289	["NOT GIVEN"]	
290	290	["FALSE"]	
291	291	["TRUE"]	
292	292	["FALSE"]	
293	293	["NOT GIVEN"]	
294	294	["NOT GIVEN"]	
295	295	["FALSE"]	
296	296	["TRUE"]	
297	297	["FALSE"]	
298	298	["FALSE"]	
299	299	["TRUE"]	
300	300	["words"]	
301	301	["finger"]	
302	302	["direction"]	
303	303	["commands"]	
304	304	["fires"]	
305	305	["technology"]	
306	306	["award"]	
307	307	["D"]	
308	308	["E"]	
309	309	["F"]	
310	310	["H"]	
311	311	["B"]	
312	312	["C"]	
313	313	["D"]	
314	314	["B"]	
315	315	["YES"]	
316	316	["NOT GIVEN"]	
317	317	["NO"]	
318	318	["YES"]	
319	319	["NOT GIVEN"]	
320	320	["D"]	
321	321	["Ardleigh"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
322	322	["newspaper"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
323	323	["theme"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
324	324	["tent"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
325	325	["castle"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
326	326	["beach", "beaches"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
327	327	["2020"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
328	328	["flight"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
329	329	["429"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
330	330	["dinner"]	Cambridge IELTS 10 Test 1 Part 1 Official Answer Key
331	331	["A", "C"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
332	332	["A", "C"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
333	333	["health problems"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
334	334	["safety rules"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
335	335	["plan"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
336	336	["joining"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
337	337	["free entry"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
338	338	["peak"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
339	339	["guests"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
340	340	["photo card", "photo cards"]	Cambridge IELTS 10 Test 1 Part 2 Official Answer Key
341	341	["C"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
342	342	["A"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
343	343	["B"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
344	344	["A"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
345	345	["C"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
346	346	["presentation"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
347	347	["model"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
348	348	["material", "materials"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
349	349	["grant"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
350	350	["technical"]	Cambridge IELTS 10 Test 1 Part 3 Official Answer Key
351	351	["gene"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
352	352	["power", "powers"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
353	353	["strangers"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
354	354	["erosion"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
355	355	["islands"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
356	356	["roads"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
357	357	["fishing"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
358	358	["reproduction"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
359	359	["method", "methods"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
360	360	["expansion"]	Cambridge IELTS 10 Test 1 Part 4 Official Answer Key
361	361	["FALSE"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
362	362	["TRUE"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
363	363	["NOT GIVEN"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
364	364	["NOT GIVEN"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
365	365	["TRUE"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
366	366	["pavilions"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
367	367	["drought"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
368	368	["tourists"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
369	369	["earthquake"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
370	370	["4", "four sides"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
371	371	["tank"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
372	372	["verandas", "verandahs"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
373	373	["underwater"]	Cambridge IELTS 10 Test 1 Passage 1 Official Answer Key
374	374	["viii"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
375	375	["iii"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
376	376	["xi"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
377	377	["i"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
378	378	["v"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
379	379	["x"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
380	380	["ii"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
381	381	["iv"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
382	382	["TRUE"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
383	383	["FALSE"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
384	384	["NOT GIVEN"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
385	385	["NOT GIVEN"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
386	386	["FALSE"]	Cambridge IELTS 10 Test 1 Passage 2 Official Answer Key
387	387	["C"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
388	388	["A"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
389	389	["D"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
390	390	["B"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
391	391	["G"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
392	392	["E"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
393	393	["A"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
394	394	["F"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
395	395	["B"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
396	396	["NO"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
397	397	["YES"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
398	398	["NOT GIVEN"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
399	399	["NOT GIVEN"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
400	400	["NO"]	Cambridge IELTS 10 Test 1 Passage 3 Official Answer Key
401	401	["Answer 1"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
402	402	["Answer 2"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
403	403	["Answer 3"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
404	404	["Answer 4"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
405	405	["Answer 5"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
406	406	["Answer 6"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
407	407	["Answer 7"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
408	408	["Answer 8"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
409	409	["Answer 9"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
410	410	["Answer 10"]	Cambridge IELTS 10 Test 2 Part 1 Official Answer Key
411	411	["Answer 11"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
412	412	["Answer 12"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
413	413	["Answer 13"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
414	414	["Answer 14"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
415	415	["Answer 15"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
416	416	["Answer 16"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
417	417	["Answer 17"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
418	418	["Answer 18"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
419	419	["Answer 19"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
420	420	["Answer 20"]	Cambridge IELTS 10 Test 2 Part 2 Official Answer Key
421	421	["Answer 21"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
422	422	["Answer 22"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
423	423	["Answer 23"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
424	424	["Answer 24"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
425	425	["Answer 25"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
426	426	["Answer 26"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
427	427	["Answer 27"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
428	428	["Answer 28"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
429	429	["Answer 29"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
430	430	["Answer 30"]	Cambridge IELTS 10 Test 2 Part 3 Official Answer Key
431	431	["Answer 31"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
432	432	["Answer 32"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
433	433	["Answer 33"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
434	434	["Answer 34"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
435	435	["Answer 35"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
436	436	["Answer 36"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
437	437	["Answer 37"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
438	438	["Answer 38"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
439	439	["Answer 39"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
440	440	["Answer 40"]	Cambridge IELTS 10 Test 2 Part 4 Official Answer Key
441	441	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
442	442	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
443	443	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
444	444	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
445	445	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
446	446	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
447	447	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
448	448	["Answer 8"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
449	449	["Answer 9"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
450	450	["Answer 10"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
451	451	["Answer 11"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
452	452	["Answer 12"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
453	453	["Answer 13"]	Cambridge IELTS 10 Test 2 Passage 1 Official Answer Key
454	454	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
455	455	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
456	456	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
457	457	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
458	458	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
459	459	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
460	460	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
461	461	["Answer 21"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
462	462	["Answer 22"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
463	463	["Answer 23"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
464	464	["Answer 24"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
465	465	["Answer 25"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
466	466	["Answer 26"]	Cambridge IELTS 10 Test 2 Passage 2 Official Answer Key
467	467	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
468	468	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
469	469	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
470	470	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
471	471	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
472	472	["FALSE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
473	473	["TRUE"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
474	474	["Answer 34"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
475	475	["Answer 35"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
476	476	["Answer 36"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
477	477	["Answer 37"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
478	478	["Answer 38"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
479	479	["Answer 39"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
480	480	["Answer 40"]	Cambridge IELTS 10 Test 2 Passage 3 Official Answer Key
481	481	["Answer 1"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
482	482	["Answer 2"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
483	483	["Answer 3"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
484	484	["Answer 4"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
485	485	["Answer 5"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
486	486	["Answer 6"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
487	487	["Answer 7"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
488	488	["Answer 8"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
489	489	["Answer 9"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
490	490	["Answer 10"]	Cambridge IELTS 10 Test 3 Part 1 Official Answer Key
491	491	["Answer 11"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
492	492	["Answer 12"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
493	493	["Answer 13"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
494	494	["Answer 14"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
495	495	["Answer 15"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
496	496	["Answer 16"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
497	497	["Answer 17"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
498	498	["Answer 18"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
499	499	["Answer 19"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
500	500	["Answer 20"]	Cambridge IELTS 10 Test 3 Part 2 Official Answer Key
501	501	["Answer 21"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
502	502	["Answer 22"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
503	503	["Answer 23"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
504	504	["Answer 24"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
505	505	["Answer 25"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
506	506	["Answer 26"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
507	507	["Answer 27"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
508	508	["Answer 28"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
509	509	["Answer 29"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
510	510	["Answer 30"]	Cambridge IELTS 10 Test 3 Part 3 Official Answer Key
511	511	["Answer 31"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
512	512	["Answer 32"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
513	513	["Answer 33"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
514	514	["Answer 34"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
515	515	["Answer 35"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
516	516	["Answer 36"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
517	517	["Answer 37"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
518	518	["Answer 38"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
519	519	["Answer 39"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
520	520	["Answer 40"]	Cambridge IELTS 10 Test 3 Part 4 Official Answer Key
521	521	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
522	522	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
523	523	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
524	524	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
525	525	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
526	526	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
527	527	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
528	528	["Answer 8"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
529	529	["Answer 9"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
530	530	["Answer 10"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
531	531	["Answer 11"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
532	532	["Answer 12"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
533	533	["Answer 13"]	Cambridge IELTS 10 Test 3 Passage 1 Official Answer Key
534	534	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
535	535	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
536	536	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
537	537	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
538	538	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
539	539	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
540	540	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
541	541	["Answer 21"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
542	542	["Answer 22"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
543	543	["Answer 23"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
544	544	["Answer 24"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
545	545	["Answer 25"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
546	546	["Answer 26"]	Cambridge IELTS 10 Test 3 Passage 2 Official Answer Key
547	547	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
548	548	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
549	549	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
550	550	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
551	551	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
552	552	["FALSE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
553	553	["TRUE"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
554	554	["Answer 34"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
555	555	["Answer 35"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
556	556	["Answer 36"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
557	557	["Answer 37"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
558	558	["Answer 38"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
559	559	["Answer 39"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
560	560	["Answer 40"]	Cambridge IELTS 10 Test 3 Passage 3 Official Answer Key
561	561	["Answer 1"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
562	562	["Answer 2"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
563	563	["Answer 3"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
564	564	["Answer 4"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
565	565	["Answer 5"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
566	566	["Answer 6"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
567	567	["Answer 7"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
568	568	["Answer 8"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
569	569	["Answer 9"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
570	570	["Answer 10"]	Cambridge IELTS 10 Test 4 Part 1 Official Answer Key
571	571	["Answer 11"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
572	572	["Answer 12"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
573	573	["Answer 13"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
574	574	["Answer 14"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
575	575	["Answer 15"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
576	576	["Answer 16"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
577	577	["Answer 17"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
578	578	["Answer 18"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
579	579	["Answer 19"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
580	580	["Answer 20"]	Cambridge IELTS 10 Test 4 Part 2 Official Answer Key
581	581	["Answer 21"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
582	582	["Answer 22"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
583	583	["Answer 23"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
584	584	["Answer 24"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
585	585	["Answer 25"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
586	586	["Answer 26"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
587	587	["Answer 27"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
588	588	["Answer 28"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
589	589	["Answer 29"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
590	590	["Answer 30"]	Cambridge IELTS 10 Test 4 Part 3 Official Answer Key
591	591	["Answer 31"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
592	592	["Answer 32"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
593	593	["Answer 33"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
594	594	["Answer 34"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
595	595	["Answer 35"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
596	596	["Answer 36"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
597	597	["Answer 37"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
598	598	["Answer 38"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
599	599	["Answer 39"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
600	600	["Answer 40"]	Cambridge IELTS 10 Test 4 Part 4 Official Answer Key
601	601	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
602	602	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
603	603	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
604	604	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
605	605	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
606	606	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
607	607	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
608	608	["Answer 8"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
609	609	["Answer 9"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
610	610	["Answer 10"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
611	611	["Answer 11"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
612	612	["Answer 12"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
613	613	["Answer 13"]	Cambridge IELTS 10 Test 4 Passage 1 Official Answer Key
614	614	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
615	615	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
616	616	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
617	617	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
618	618	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
619	619	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
620	620	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
621	621	["Answer 21"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
622	622	["Answer 22"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
623	623	["Answer 23"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
624	624	["Answer 24"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
625	625	["Answer 25"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
626	626	["Answer 26"]	Cambridge IELTS 10 Test 4 Passage 2 Official Answer Key
627	627	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
628	628	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
629	629	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
630	630	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
631	631	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
632	632	["FALSE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
633	633	["TRUE"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
634	634	["Answer 34"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
635	635	["Answer 35"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
636	636	["Answer 36"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
637	637	["Answer 37"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
638	638	["Answer 38"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
639	639	["Answer 39"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
640	640	["Answer 40"]	Cambridge IELTS 10 Test 4 Passage 3 Official Answer Key
641	641	["Charlton"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
642	642	["115", "a hundred and fifteen", "one hundred and fifteen"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
643	643	["cash"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
644	644	["parking"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
645	645	["music"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
646	646	["entry"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
647	647	["stage"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
648	648	["code"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
649	649	["floor", "floors"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
650	650	["decoration", "decorations"]	Cambridge IELTS 11 Test 1 Part 1 Official Answer Key
651	651	["animal", "animals"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
652	652	["tool", "tools"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
653	653	["shoes"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
654	654	["dog", "dogs"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
655	655	["insects"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
656	656	["B"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
657	657	["A"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
658	658	["C"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
659	659	["A"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
660	660	["C"]	Cambridge IELTS 11 Test 1 Part 2 Official Answer Key
661	661	["B"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
662	662	["A"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
663	663	["C"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
664	664	["B"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
665	665	["C"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
666	666	["A"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
667	667	["C"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
668	668	["A"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
669	669	["B"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
670	670	["A"]	Cambridge IELTS 11 Test 1 Part 3 Official Answer Key
671	671	["hard"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
672	672	["dry"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
673	673	["insects"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
674	674	["depth"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
675	675	["movement"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
676	676	["smell"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
677	677	["colour"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
678	678	["water"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
679	679	["egg", "eggs"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
680	680	["warm"]	Cambridge IELTS 11 Test 1 Part 4 Official Answer Key
681	681	["tomatoes"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
682	682	["urban centres", "urban centers"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
683	683	["energy"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
684	684	["fossil fuel"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
685	685	["artificial"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
686	686	["stacked trays", "trays"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
687	687	["urban rooftops", "rooftops"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
688	688	["NOT GIVEN"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
689	689	["TRUE"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
690	690	["FALSE"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
691	691	["TRUE"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
692	692	["FALSE"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
693	693	["TRUE"]	Cambridge IELTS 11 Test 1 Passage 1 Official Answer Key
694	694	["FALSE"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
695	695	["NOT GIVEN"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
696	696	["TRUE"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
697	697	["TRUE"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
698	698	["FALSE"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
699	699	["TRUE"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
700	700	["NOT GIVEN"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
701	701	["oil"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
702	702	["friendship"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
703	703	["confidence"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
704	704	["oxytocin"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
705	705	["positive"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
706	706	["genes"]	Cambridge IELTS 11 Test 1 Passage 2 Official Answer Key
707	707	["D"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
708	708	["B"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
709	709	["A"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
710	710	["B"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
711	711	["D"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
712	712	["F"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
713	713	["H"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
714	714	["C"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
715	715	["A"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
716	716	["YES"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
717	717	["NO"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
718	718	["NOT GIVEN"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
719	719	["YES"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
720	720	["NOT GIVEN"]	Cambridge IELTS 11 Test 1 Passage 3 Official Answer Key
721	721	["Answer 1"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
722	722	["Answer 2"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
723	723	["Answer 3"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
724	724	["Answer 4"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
725	725	["Answer 5"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
726	726	["Answer 6"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
727	727	["Answer 7"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
728	728	["Answer 8"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
729	729	["Answer 9"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
730	730	["Answer 10"]	Cambridge IELTS 11 Test 2 Part 1 Official Answer Key
731	731	["Answer 11"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
732	732	["Answer 12"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
733	733	["Answer 13"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
734	734	["Answer 14"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
735	735	["Answer 15"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
736	736	["Answer 16"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
737	737	["Answer 17"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
738	738	["Answer 18"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
739	739	["Answer 19"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
740	740	["Answer 20"]	Cambridge IELTS 11 Test 2 Part 2 Official Answer Key
741	741	["Answer 21"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
742	742	["Answer 22"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
743	743	["Answer 23"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
744	744	["Answer 24"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
745	745	["Answer 25"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
746	746	["Answer 26"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
747	747	["Answer 27"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
748	748	["Answer 28"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
749	749	["Answer 29"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
750	750	["Answer 30"]	Cambridge IELTS 11 Test 2 Part 3 Official Answer Key
751	751	["Answer 31"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
752	752	["Answer 32"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
753	753	["Answer 33"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
754	754	["Answer 34"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
755	755	["Answer 35"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
756	756	["Answer 36"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
757	757	["Answer 37"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
758	758	["Answer 38"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
759	759	["Answer 39"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
760	760	["Answer 40"]	Cambridge IELTS 11 Test 2 Part 4 Official Answer Key
761	761	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
762	762	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
763	763	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
764	764	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
765	765	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
766	766	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
767	767	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
768	768	["Answer 8"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
769	769	["Answer 9"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
770	770	["Answer 10"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
771	771	["Answer 11"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
772	772	["Answer 12"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
773	773	["Answer 13"]	Cambridge IELTS 11 Test 2 Passage 1 Official Answer Key
774	774	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
775	775	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
776	776	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
777	777	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
778	778	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
779	779	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
780	780	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
781	781	["Answer 21"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
782	782	["Answer 22"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
783	783	["Answer 23"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
784	784	["Answer 24"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
785	785	["Answer 25"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
786	786	["Answer 26"]	Cambridge IELTS 11 Test 2 Passage 2 Official Answer Key
787	787	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
788	788	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
789	789	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
790	790	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
791	791	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
792	792	["FALSE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
793	793	["TRUE"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
794	794	["Answer 34"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
795	795	["Answer 35"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
796	796	["Answer 36"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
797	797	["Answer 37"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
798	798	["Answer 38"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
799	799	["Answer 39"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
800	800	["Answer 40"]	Cambridge IELTS 11 Test 2 Passage 3 Official Answer Key
801	801	["Answer 1"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
802	802	["Answer 2"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
803	803	["Answer 3"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
804	804	["Answer 4"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
805	805	["Answer 5"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
806	806	["Answer 6"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
807	807	["Answer 7"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
808	808	["Answer 8"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
809	809	["Answer 9"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
810	810	["Answer 10"]	Cambridge IELTS 11 Test 3 Part 1 Official Answer Key
811	811	["Answer 11"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
812	812	["Answer 12"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
813	813	["Answer 13"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
814	814	["Answer 14"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
815	815	["Answer 15"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
816	816	["Answer 16"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
817	817	["Answer 17"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
818	818	["Answer 18"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
819	819	["Answer 19"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
820	820	["Answer 20"]	Cambridge IELTS 11 Test 3 Part 2 Official Answer Key
821	821	["Answer 21"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
822	822	["Answer 22"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
823	823	["Answer 23"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
824	824	["Answer 24"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
825	825	["Answer 25"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
826	826	["Answer 26"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
827	827	["Answer 27"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
828	828	["Answer 28"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
829	829	["Answer 29"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
830	830	["Answer 30"]	Cambridge IELTS 11 Test 3 Part 3 Official Answer Key
831	831	["Answer 31"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
832	832	["Answer 32"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
833	833	["Answer 33"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
834	834	["Answer 34"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
835	835	["Answer 35"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
836	836	["Answer 36"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
837	837	["Answer 37"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
838	838	["Answer 38"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
839	839	["Answer 39"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
840	840	["Answer 40"]	Cambridge IELTS 11 Test 3 Part 4 Official Answer Key
841	841	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
842	842	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
843	843	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
844	844	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
845	845	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
846	846	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
847	847	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
848	848	["Answer 8"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
849	849	["Answer 9"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
850	850	["Answer 10"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
851	851	["Answer 11"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
852	852	["Answer 12"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
853	853	["Answer 13"]	Cambridge IELTS 11 Test 3 Passage 1 Official Answer Key
854	854	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
855	855	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
856	856	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
857	857	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
858	858	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
859	859	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
860	860	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
861	861	["Answer 21"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
862	862	["Answer 22"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
863	863	["Answer 23"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
864	864	["Answer 24"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
865	865	["Answer 25"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
866	866	["Answer 26"]	Cambridge IELTS 11 Test 3 Passage 2 Official Answer Key
867	867	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
868	868	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
869	869	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
870	870	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
871	871	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
872	872	["FALSE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
873	873	["TRUE"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
874	874	["Answer 34"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
875	875	["Answer 35"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
876	876	["Answer 36"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
877	877	["Answer 37"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
878	878	["Answer 38"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
879	879	["Answer 39"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
880	880	["Answer 40"]	Cambridge IELTS 11 Test 3 Passage 3 Official Answer Key
881	881	["Answer 1"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
882	882	["Answer 2"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
883	883	["Answer 3"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
884	884	["Answer 4"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
885	885	["Answer 5"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
886	886	["Answer 6"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
887	887	["Answer 7"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
888	888	["Answer 8"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
889	889	["Answer 9"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
890	890	["Answer 10"]	Cambridge IELTS 11 Test 4 Part 1 Official Answer Key
891	891	["Answer 11"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
892	892	["Answer 12"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
893	893	["Answer 13"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
894	894	["Answer 14"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
895	895	["Answer 15"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
896	896	["Answer 16"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
897	897	["Answer 17"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
898	898	["Answer 18"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
899	899	["Answer 19"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
900	900	["Answer 20"]	Cambridge IELTS 11 Test 4 Part 2 Official Answer Key
901	901	["Answer 21"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
902	902	["Answer 22"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
903	903	["Answer 23"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
904	904	["Answer 24"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
905	905	["Answer 25"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
906	906	["Answer 26"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
907	907	["Answer 27"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
908	908	["Answer 28"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
909	909	["Answer 29"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
910	910	["Answer 30"]	Cambridge IELTS 11 Test 4 Part 3 Official Answer Key
911	911	["Answer 31"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
912	912	["Answer 32"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
913	913	["Answer 33"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
914	914	["Answer 34"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
915	915	["Answer 35"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
916	916	["Answer 36"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
917	917	["Answer 37"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
918	918	["Answer 38"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
919	919	["Answer 39"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
920	920	["Answer 40"]	Cambridge IELTS 11 Test 4 Part 4 Official Answer Key
921	921	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
922	922	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
923	923	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
924	924	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
925	925	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
926	926	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
927	927	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
928	928	["Answer 8"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
929	929	["Answer 9"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
930	930	["Answer 10"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
931	931	["Answer 11"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
932	932	["Answer 12"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
933	933	["Answer 13"]	Cambridge IELTS 11 Test 4 Passage 1 Official Answer Key
934	934	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
935	935	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
936	936	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
937	937	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
938	938	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
939	939	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
940	940	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
941	941	["Answer 21"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
942	942	["Answer 22"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
943	943	["Answer 23"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
944	944	["Answer 24"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
945	945	["Answer 25"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
946	946	["Answer 26"]	Cambridge IELTS 11 Test 4 Passage 2 Official Answer Key
947	947	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
948	948	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
949	949	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
950	950	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
951	951	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
952	952	["FALSE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
953	953	["TRUE"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
954	954	["Answer 34"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
955	955	["Answer 35"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
956	956	["Answer 36"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
957	957	["Answer 37"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
958	958	["Answer 38"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
959	959	["Answer 39"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
960	960	["Answer 40"]	Cambridge IELTS 11 Test 4 Passage 3 Official Answer Key
961	961	["Answer 1"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
962	962	["Answer 2"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
963	963	["Answer 3"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
964	964	["Answer 4"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
965	965	["Answer 5"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
966	966	["Answer 6"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
967	967	["Answer 7"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
968	968	["Answer 8"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
969	969	["Answer 9"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
970	970	["Answer 10"]	Cambridge IELTS 12 Test 1 Part 1 Official Answer Key
971	971	["Answer 11"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
972	972	["Answer 12"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
973	973	["Answer 13"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
974	974	["Answer 14"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
975	975	["Answer 15"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
976	976	["Answer 16"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
977	977	["Answer 17"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
978	978	["Answer 18"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
979	979	["Answer 19"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
980	980	["Answer 20"]	Cambridge IELTS 12 Test 1 Part 2 Official Answer Key
981	981	["Answer 21"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
982	982	["Answer 22"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
983	983	["Answer 23"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
984	984	["Answer 24"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
985	985	["Answer 25"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
986	986	["Answer 26"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
987	987	["Answer 27"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
988	988	["Answer 28"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
989	989	["Answer 29"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
990	990	["Answer 30"]	Cambridge IELTS 12 Test 1 Part 3 Official Answer Key
991	991	["Answer 31"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
992	992	["Answer 32"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
993	993	["Answer 33"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
994	994	["Answer 34"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
995	995	["Answer 35"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
996	996	["Answer 36"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
997	997	["Answer 37"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
998	998	["Answer 38"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
999	999	["Answer 39"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
1000	1000	["Answer 40"]	Cambridge IELTS 12 Test 1 Part 4 Official Answer Key
1001	1001	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1002	1002	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1003	1003	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1004	1004	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1005	1005	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1006	1006	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1007	1007	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1008	1008	["Answer 8"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1009	1009	["Answer 9"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1010	1010	["Answer 10"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1011	1011	["Answer 11"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1012	1012	["Answer 12"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1013	1013	["Answer 13"]	Cambridge IELTS 12 Test 1 Passage 1 Official Answer Key
1014	1014	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1015	1015	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1016	1016	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1017	1017	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1018	1018	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1019	1019	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1020	1020	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1021	1021	["Answer 21"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1022	1022	["Answer 22"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1023	1023	["Answer 23"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1024	1024	["Answer 24"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1025	1025	["Answer 25"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1026	1026	["Answer 26"]	Cambridge IELTS 12 Test 1 Passage 2 Official Answer Key
1027	1027	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1028	1028	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1029	1029	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1030	1030	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1031	1031	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1032	1032	["FALSE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1033	1033	["TRUE"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1034	1034	["Answer 34"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1035	1035	["Answer 35"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1036	1036	["Answer 36"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1037	1037	["Answer 37"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1038	1038	["Answer 38"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1039	1039	["Answer 39"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1040	1040	["Answer 40"]	Cambridge IELTS 12 Test 1 Passage 3 Official Answer Key
1041	1041	["Answer 1"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1042	1042	["Answer 2"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1043	1043	["Answer 3"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1044	1044	["Answer 4"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1045	1045	["Answer 5"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1046	1046	["Answer 6"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1047	1047	["Answer 7"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1048	1048	["Answer 8"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1049	1049	["Answer 9"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1050	1050	["Answer 10"]	Cambridge IELTS 12 Test 2 Part 1 Official Answer Key
1051	1051	["Answer 11"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1052	1052	["Answer 12"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1053	1053	["Answer 13"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1054	1054	["Answer 14"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1055	1055	["Answer 15"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1056	1056	["Answer 16"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1057	1057	["Answer 17"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1058	1058	["Answer 18"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1059	1059	["Answer 19"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1060	1060	["Answer 20"]	Cambridge IELTS 12 Test 2 Part 2 Official Answer Key
1061	1061	["Answer 21"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1062	1062	["Answer 22"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1063	1063	["Answer 23"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1064	1064	["Answer 24"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1065	1065	["Answer 25"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1066	1066	["Answer 26"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1067	1067	["Answer 27"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1068	1068	["Answer 28"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1069	1069	["Answer 29"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1070	1070	["Answer 30"]	Cambridge IELTS 12 Test 2 Part 3 Official Answer Key
1071	1071	["Answer 31"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1072	1072	["Answer 32"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1073	1073	["Answer 33"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1074	1074	["Answer 34"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1075	1075	["Answer 35"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1076	1076	["Answer 36"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1077	1077	["Answer 37"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1078	1078	["Answer 38"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1079	1079	["Answer 39"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1080	1080	["Answer 40"]	Cambridge IELTS 12 Test 2 Part 4 Official Answer Key
1081	1081	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1082	1082	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1083	1083	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1084	1084	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1085	1085	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1086	1086	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1087	1087	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1088	1088	["Answer 8"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1089	1089	["Answer 9"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1090	1090	["Answer 10"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1091	1091	["Answer 11"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1092	1092	["Answer 12"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1093	1093	["Answer 13"]	Cambridge IELTS 12 Test 2 Passage 1 Official Answer Key
1094	1094	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1095	1095	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1096	1096	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1097	1097	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1098	1098	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1099	1099	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1100	1100	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1101	1101	["Answer 21"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1102	1102	["Answer 22"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1103	1103	["Answer 23"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1104	1104	["Answer 24"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1105	1105	["Answer 25"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1106	1106	["Answer 26"]	Cambridge IELTS 12 Test 2 Passage 2 Official Answer Key
1107	1107	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1108	1108	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1109	1109	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1110	1110	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1111	1111	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1112	1112	["FALSE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1113	1113	["TRUE"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1114	1114	["Answer 34"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1115	1115	["Answer 35"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1116	1116	["Answer 36"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1117	1117	["Answer 37"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1118	1118	["Answer 38"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1119	1119	["Answer 39"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1120	1120	["Answer 40"]	Cambridge IELTS 12 Test 2 Passage 3 Official Answer Key
1121	1121	["Answer 1"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1122	1122	["Answer 2"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1123	1123	["Answer 3"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1124	1124	["Answer 4"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1125	1125	["Answer 5"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1126	1126	["Answer 6"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1127	1127	["Answer 7"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1128	1128	["Answer 8"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1129	1129	["Answer 9"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1130	1130	["Answer 10"]	Cambridge IELTS 12 Test 3 Part 1 Official Answer Key
1131	1131	["Answer 11"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1132	1132	["Answer 12"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1133	1133	["Answer 13"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1134	1134	["Answer 14"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1135	1135	["Answer 15"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1136	1136	["Answer 16"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1137	1137	["Answer 17"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1138	1138	["Answer 18"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1139	1139	["Answer 19"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1140	1140	["Answer 20"]	Cambridge IELTS 12 Test 3 Part 2 Official Answer Key
1141	1141	["Answer 21"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1142	1142	["Answer 22"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1143	1143	["Answer 23"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1144	1144	["Answer 24"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1145	1145	["Answer 25"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1146	1146	["Answer 26"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1147	1147	["Answer 27"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1148	1148	["Answer 28"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1149	1149	["Answer 29"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1150	1150	["Answer 30"]	Cambridge IELTS 12 Test 3 Part 3 Official Answer Key
1151	1151	["Answer 31"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1152	1152	["Answer 32"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1153	1153	["Answer 33"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1154	1154	["Answer 34"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1155	1155	["Answer 35"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1156	1156	["Answer 36"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1157	1157	["Answer 37"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1158	1158	["Answer 38"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1159	1159	["Answer 39"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1160	1160	["Answer 40"]	Cambridge IELTS 12 Test 3 Part 4 Official Answer Key
1161	1161	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1162	1162	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1163	1163	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1164	1164	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1165	1165	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1166	1166	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1167	1167	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1168	1168	["Answer 8"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1169	1169	["Answer 9"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1170	1170	["Answer 10"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1171	1171	["Answer 11"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1172	1172	["Answer 12"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1173	1173	["Answer 13"]	Cambridge IELTS 12 Test 3 Passage 1 Official Answer Key
1174	1174	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1175	1175	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1176	1176	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1177	1177	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1178	1178	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1179	1179	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1180	1180	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1181	1181	["Answer 21"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1182	1182	["Answer 22"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1183	1183	["Answer 23"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1184	1184	["Answer 24"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1185	1185	["Answer 25"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1186	1186	["Answer 26"]	Cambridge IELTS 12 Test 3 Passage 2 Official Answer Key
1187	1187	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1188	1188	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1189	1189	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1190	1190	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1191	1191	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1192	1192	["FALSE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1193	1193	["TRUE"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1194	1194	["Answer 34"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1195	1195	["Answer 35"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1196	1196	["Answer 36"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1197	1197	["Answer 37"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1198	1198	["Answer 38"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1199	1199	["Answer 39"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1200	1200	["Answer 40"]	Cambridge IELTS 12 Test 3 Passage 3 Official Answer Key
1201	1201	["Answer 1"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1202	1202	["Answer 2"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1203	1203	["Answer 3"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1204	1204	["Answer 4"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1205	1205	["Answer 5"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1206	1206	["Answer 6"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1207	1207	["Answer 7"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1208	1208	["Answer 8"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1209	1209	["Answer 9"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1210	1210	["Answer 10"]	Cambridge IELTS 12 Test 4 Part 1 Official Answer Key
1211	1211	["Answer 11"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1212	1212	["Answer 12"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1213	1213	["Answer 13"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1214	1214	["Answer 14"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1215	1215	["Answer 15"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1216	1216	["Answer 16"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1217	1217	["Answer 17"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1218	1218	["Answer 18"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1219	1219	["Answer 19"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1220	1220	["Answer 20"]	Cambridge IELTS 12 Test 4 Part 2 Official Answer Key
1221	1221	["Answer 21"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1222	1222	["Answer 22"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1223	1223	["Answer 23"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1224	1224	["Answer 24"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1225	1225	["Answer 25"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1226	1226	["Answer 26"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1227	1227	["Answer 27"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1228	1228	["Answer 28"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1229	1229	["Answer 29"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1230	1230	["Answer 30"]	Cambridge IELTS 12 Test 4 Part 3 Official Answer Key
1231	1231	["Answer 31"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1232	1232	["Answer 32"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1233	1233	["Answer 33"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1234	1234	["Answer 34"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1235	1235	["Answer 35"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1236	1236	["Answer 36"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1237	1237	["Answer 37"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1238	1238	["Answer 38"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1239	1239	["Answer 39"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1240	1240	["Answer 40"]	Cambridge IELTS 12 Test 4 Part 4 Official Answer Key
1241	1241	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1242	1242	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1243	1243	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1244	1244	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1245	1245	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1246	1246	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1247	1247	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1248	1248	["Answer 8"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1249	1249	["Answer 9"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1250	1250	["Answer 10"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1251	1251	["Answer 11"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1252	1252	["Answer 12"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1253	1253	["Answer 13"]	Cambridge IELTS 12 Test 4 Passage 1 Official Answer Key
1254	1254	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1255	1255	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1256	1256	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1257	1257	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1258	1258	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1259	1259	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1260	1260	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1261	1261	["Answer 21"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1262	1262	["Answer 22"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1263	1263	["Answer 23"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1264	1264	["Answer 24"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1265	1265	["Answer 25"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1266	1266	["Answer 26"]	Cambridge IELTS 12 Test 4 Passage 2 Official Answer Key
1267	1267	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1268	1268	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1269	1269	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1270	1270	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1271	1271	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1272	1272	["FALSE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1273	1273	["TRUE"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1274	1274	["Answer 34"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1275	1275	["Answer 35"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1276	1276	["Answer 36"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1277	1277	["Answer 37"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1278	1278	["Answer 38"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1279	1279	["Answer 39"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1280	1280	["Answer 40"]	Cambridge IELTS 12 Test 4 Passage 3 Official Answer Key
1281	1281	["Answer 1"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1282	1282	["Answer 2"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1283	1283	["Answer 3"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1284	1284	["Answer 4"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1285	1285	["Answer 5"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1286	1286	["Answer 6"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1287	1287	["Answer 7"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1288	1288	["Answer 8"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1289	1289	["Answer 9"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1290	1290	["Answer 10"]	Cambridge IELTS 13 Test 1 Part 1 Official Answer Key
1291	1291	["Answer 11"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1292	1292	["Answer 12"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1293	1293	["Answer 13"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1294	1294	["Answer 14"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1295	1295	["Answer 15"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1296	1296	["Answer 16"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1297	1297	["Answer 17"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1298	1298	["Answer 18"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1299	1299	["Answer 19"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1300	1300	["Answer 20"]	Cambridge IELTS 13 Test 1 Part 2 Official Answer Key
1301	1301	["Answer 21"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1302	1302	["Answer 22"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1303	1303	["Answer 23"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1304	1304	["Answer 24"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1305	1305	["Answer 25"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1306	1306	["Answer 26"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1307	1307	["Answer 27"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1308	1308	["Answer 28"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1309	1309	["Answer 29"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1310	1310	["Answer 30"]	Cambridge IELTS 13 Test 1 Part 3 Official Answer Key
1311	1311	["Answer 31"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1312	1312	["Answer 32"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1313	1313	["Answer 33"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1314	1314	["Answer 34"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1315	1315	["Answer 35"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1316	1316	["Answer 36"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1317	1317	["Answer 37"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1318	1318	["Answer 38"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1319	1319	["Answer 39"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1320	1320	["Answer 40"]	Cambridge IELTS 13 Test 1 Part 4 Official Answer Key
1321	1321	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1322	1322	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1323	1323	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1324	1324	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1325	1325	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1326	1326	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1327	1327	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1328	1328	["Answer 8"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1329	1329	["Answer 9"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1330	1330	["Answer 10"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1331	1331	["Answer 11"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1332	1332	["Answer 12"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1333	1333	["Answer 13"]	Cambridge IELTS 13 Test 1 Passage 1 Official Answer Key
1334	1334	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1335	1335	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1336	1336	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1337	1337	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1338	1338	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1339	1339	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1340	1340	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1341	1341	["Answer 21"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1342	1342	["Answer 22"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1343	1343	["Answer 23"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1344	1344	["Answer 24"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1345	1345	["Answer 25"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1346	1346	["Answer 26"]	Cambridge IELTS 13 Test 1 Passage 2 Official Answer Key
1347	1347	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1348	1348	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1349	1349	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1350	1350	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1351	1351	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1352	1352	["FALSE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1353	1353	["TRUE"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1354	1354	["Answer 34"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1355	1355	["Answer 35"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1356	1356	["Answer 36"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1357	1357	["Answer 37"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1358	1358	["Answer 38"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1359	1359	["Answer 39"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1360	1360	["Answer 40"]	Cambridge IELTS 13 Test 1 Passage 3 Official Answer Key
1361	1361	["Answer 1"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1362	1362	["Answer 2"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1363	1363	["Answer 3"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1364	1364	["Answer 4"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1365	1365	["Answer 5"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1366	1366	["Answer 6"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1367	1367	["Answer 7"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1368	1368	["Answer 8"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1369	1369	["Answer 9"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1370	1370	["Answer 10"]	Cambridge IELTS 13 Test 2 Part 1 Official Answer Key
1371	1371	["Answer 11"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1372	1372	["Answer 12"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1373	1373	["Answer 13"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1374	1374	["Answer 14"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1375	1375	["Answer 15"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1376	1376	["Answer 16"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1377	1377	["Answer 17"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1378	1378	["Answer 18"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1379	1379	["Answer 19"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1380	1380	["Answer 20"]	Cambridge IELTS 13 Test 2 Part 2 Official Answer Key
1381	1381	["Answer 21"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1382	1382	["Answer 22"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1383	1383	["Answer 23"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1384	1384	["Answer 24"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1385	1385	["Answer 25"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1386	1386	["Answer 26"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1387	1387	["Answer 27"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1388	1388	["Answer 28"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1389	1389	["Answer 29"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1390	1390	["Answer 30"]	Cambridge IELTS 13 Test 2 Part 3 Official Answer Key
1391	1391	["Answer 31"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1392	1392	["Answer 32"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1393	1393	["Answer 33"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1394	1394	["Answer 34"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1395	1395	["Answer 35"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1396	1396	["Answer 36"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1397	1397	["Answer 37"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1398	1398	["Answer 38"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1399	1399	["Answer 39"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1400	1400	["Answer 40"]	Cambridge IELTS 13 Test 2 Part 4 Official Answer Key
1401	1401	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1402	1402	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1403	1403	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1404	1404	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1405	1405	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1406	1406	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1407	1407	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1408	1408	["Answer 8"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1409	1409	["Answer 9"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1410	1410	["Answer 10"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1411	1411	["Answer 11"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1412	1412	["Answer 12"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1413	1413	["Answer 13"]	Cambridge IELTS 13 Test 2 Passage 1 Official Answer Key
1414	1414	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1415	1415	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1416	1416	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1417	1417	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1418	1418	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1419	1419	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1420	1420	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1421	1421	["Answer 21"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1422	1422	["Answer 22"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1423	1423	["Answer 23"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1424	1424	["Answer 24"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1425	1425	["Answer 25"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1426	1426	["Answer 26"]	Cambridge IELTS 13 Test 2 Passage 2 Official Answer Key
1427	1427	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1428	1428	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1429	1429	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1430	1430	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1431	1431	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1432	1432	["FALSE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1433	1433	["TRUE"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1434	1434	["Answer 34"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1435	1435	["Answer 35"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1436	1436	["Answer 36"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1437	1437	["Answer 37"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1438	1438	["Answer 38"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1439	1439	["Answer 39"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1440	1440	["Answer 40"]	Cambridge IELTS 13 Test 2 Passage 3 Official Answer Key
1441	1441	["Answer 1"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1442	1442	["Answer 2"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1443	1443	["Answer 3"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1444	1444	["Answer 4"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1445	1445	["Answer 5"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1446	1446	["Answer 6"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1447	1447	["Answer 7"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1448	1448	["Answer 8"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1449	1449	["Answer 9"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1450	1450	["Answer 10"]	Cambridge IELTS 13 Test 3 Part 1 Official Answer Key
1451	1451	["Answer 11"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1452	1452	["Answer 12"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1453	1453	["Answer 13"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1454	1454	["Answer 14"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1455	1455	["Answer 15"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1456	1456	["Answer 16"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1457	1457	["Answer 17"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1458	1458	["Answer 18"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1459	1459	["Answer 19"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1460	1460	["Answer 20"]	Cambridge IELTS 13 Test 3 Part 2 Official Answer Key
1461	1461	["Answer 21"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1462	1462	["Answer 22"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1463	1463	["Answer 23"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1464	1464	["Answer 24"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1465	1465	["Answer 25"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1466	1466	["Answer 26"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1467	1467	["Answer 27"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1468	1468	["Answer 28"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1469	1469	["Answer 29"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1470	1470	["Answer 30"]	Cambridge IELTS 13 Test 3 Part 3 Official Answer Key
1471	1471	["Answer 31"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1472	1472	["Answer 32"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1473	1473	["Answer 33"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1474	1474	["Answer 34"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1475	1475	["Answer 35"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1476	1476	["Answer 36"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1477	1477	["Answer 37"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1478	1478	["Answer 38"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1479	1479	["Answer 39"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1480	1480	["Answer 40"]	Cambridge IELTS 13 Test 3 Part 4 Official Answer Key
1481	1481	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1482	1482	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1483	1483	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1484	1484	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1485	1485	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1486	1486	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1487	1487	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1488	1488	["Answer 8"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1489	1489	["Answer 9"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1490	1490	["Answer 10"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1491	1491	["Answer 11"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1492	1492	["Answer 12"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1493	1493	["Answer 13"]	Cambridge IELTS 13 Test 3 Passage 1 Official Answer Key
1494	1494	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1495	1495	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1496	1496	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1497	1497	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1498	1498	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1499	1499	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1500	1500	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1501	1501	["Answer 21"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1502	1502	["Answer 22"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1503	1503	["Answer 23"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1504	1504	["Answer 24"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1505	1505	["Answer 25"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1506	1506	["Answer 26"]	Cambridge IELTS 13 Test 3 Passage 2 Official Answer Key
1507	1507	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1508	1508	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1509	1509	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1510	1510	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1511	1511	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1512	1512	["FALSE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1513	1513	["TRUE"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1514	1514	["Answer 34"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1515	1515	["Answer 35"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1516	1516	["Answer 36"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1517	1517	["Answer 37"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1518	1518	["Answer 38"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1519	1519	["Answer 39"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1520	1520	["Answer 40"]	Cambridge IELTS 13 Test 3 Passage 3 Official Answer Key
1521	1521	["Answer 1"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1522	1522	["Answer 2"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1523	1523	["Answer 3"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1524	1524	["Answer 4"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1525	1525	["Answer 5"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1526	1526	["Answer 6"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1527	1527	["Answer 7"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1528	1528	["Answer 8"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1529	1529	["Answer 9"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1530	1530	["Answer 10"]	Cambridge IELTS 13 Test 4 Part 1 Official Answer Key
1531	1531	["Answer 11"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1532	1532	["Answer 12"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1533	1533	["Answer 13"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1534	1534	["Answer 14"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1535	1535	["Answer 15"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1536	1536	["Answer 16"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1537	1537	["Answer 17"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1538	1538	["Answer 18"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1539	1539	["Answer 19"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1540	1540	["Answer 20"]	Cambridge IELTS 13 Test 4 Part 2 Official Answer Key
1541	1541	["Answer 21"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1542	1542	["Answer 22"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1543	1543	["Answer 23"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1544	1544	["Answer 24"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1545	1545	["Answer 25"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1546	1546	["Answer 26"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1547	1547	["Answer 27"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1548	1548	["Answer 28"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1549	1549	["Answer 29"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1550	1550	["Answer 30"]	Cambridge IELTS 13 Test 4 Part 3 Official Answer Key
1551	1551	["Answer 31"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1552	1552	["Answer 32"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1553	1553	["Answer 33"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1554	1554	["Answer 34"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1555	1555	["Answer 35"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1556	1556	["Answer 36"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1557	1557	["Answer 37"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1558	1558	["Answer 38"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1559	1559	["Answer 39"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1560	1560	["Answer 40"]	Cambridge IELTS 13 Test 4 Part 4 Official Answer Key
1561	1561	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1562	1562	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1563	1563	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1564	1564	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1565	1565	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1566	1566	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1567	1567	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1568	1568	["Answer 8"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1569	1569	["Answer 9"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1570	1570	["Answer 10"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1571	1571	["Answer 11"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1572	1572	["Answer 12"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1573	1573	["Answer 13"]	Cambridge IELTS 13 Test 4 Passage 1 Official Answer Key
1574	1574	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1575	1575	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1576	1576	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1577	1577	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1578	1578	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1579	1579	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1580	1580	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1581	1581	["Answer 21"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1582	1582	["Answer 22"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1583	1583	["Answer 23"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1584	1584	["Answer 24"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1585	1585	["Answer 25"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1586	1586	["Answer 26"]	Cambridge IELTS 13 Test 4 Passage 2 Official Answer Key
1587	1587	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1588	1588	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1589	1589	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1590	1590	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1591	1591	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1592	1592	["FALSE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1593	1593	["TRUE"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1594	1594	["Answer 34"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1595	1595	["Answer 35"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1596	1596	["Answer 36"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1597	1597	["Answer 37"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1598	1598	["Answer 38"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1599	1599	["Answer 39"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1600	1600	["Answer 40"]	Cambridge IELTS 13 Test 4 Passage 3 Official Answer Key
1601	1601	["Answer 1"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1602	1602	["Answer 2"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1603	1603	["Answer 3"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1604	1604	["Answer 4"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1605	1605	["Answer 5"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1606	1606	["Answer 6"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1607	1607	["Answer 7"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1608	1608	["Answer 8"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1609	1609	["Answer 9"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1610	1610	["Answer 10"]	Cambridge IELTS 14 Test 1 Part 1 Official Answer Key
1611	1611	["Answer 11"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1612	1612	["Answer 12"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1613	1613	["Answer 13"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1614	1614	["Answer 14"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1615	1615	["Answer 15"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1616	1616	["Answer 16"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1617	1617	["Answer 17"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1618	1618	["Answer 18"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1619	1619	["Answer 19"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1620	1620	["Answer 20"]	Cambridge IELTS 14 Test 1 Part 2 Official Answer Key
1621	1621	["Answer 21"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1622	1622	["Answer 22"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1623	1623	["Answer 23"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1624	1624	["Answer 24"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1625	1625	["Answer 25"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1626	1626	["Answer 26"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1627	1627	["Answer 27"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1628	1628	["Answer 28"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1629	1629	["Answer 29"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1630	1630	["Answer 30"]	Cambridge IELTS 14 Test 1 Part 3 Official Answer Key
1631	1631	["Answer 31"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1632	1632	["Answer 32"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1633	1633	["Answer 33"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1634	1634	["Answer 34"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1635	1635	["Answer 35"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1636	1636	["Answer 36"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1637	1637	["Answer 37"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1638	1638	["Answer 38"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1639	1639	["Answer 39"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1640	1640	["Answer 40"]	Cambridge IELTS 14 Test 1 Part 4 Official Answer Key
1641	1641	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1642	1642	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1643	1643	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1644	1644	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1645	1645	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1646	1646	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1647	1647	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1648	1648	["Answer 8"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1649	1649	["Answer 9"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1650	1650	["Answer 10"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1651	1651	["Answer 11"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1652	1652	["Answer 12"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1653	1653	["Answer 13"]	Cambridge IELTS 14 Test 1 Passage 1 Official Answer Key
1654	1654	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1655	1655	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1656	1656	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1657	1657	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1658	1658	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1659	1659	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1660	1660	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1661	1661	["Answer 21"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1662	1662	["Answer 22"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1663	1663	["Answer 23"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1664	1664	["Answer 24"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1665	1665	["Answer 25"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1666	1666	["Answer 26"]	Cambridge IELTS 14 Test 1 Passage 2 Official Answer Key
1667	1667	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1668	1668	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1669	1669	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1670	1670	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1671	1671	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1672	1672	["FALSE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1673	1673	["TRUE"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1674	1674	["Answer 34"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1675	1675	["Answer 35"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1676	1676	["Answer 36"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1677	1677	["Answer 37"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1678	1678	["Answer 38"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1679	1679	["Answer 39"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1680	1680	["Answer 40"]	Cambridge IELTS 14 Test 1 Passage 3 Official Answer Key
1681	1681	["Answer 1"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1682	1682	["Answer 2"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1683	1683	["Answer 3"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1684	1684	["Answer 4"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1685	1685	["Answer 5"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1686	1686	["Answer 6"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1687	1687	["Answer 7"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1688	1688	["Answer 8"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1689	1689	["Answer 9"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1690	1690	["Answer 10"]	Cambridge IELTS 14 Test 2 Part 1 Official Answer Key
1691	1691	["Answer 11"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1692	1692	["Answer 12"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1693	1693	["Answer 13"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1694	1694	["Answer 14"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1695	1695	["Answer 15"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1696	1696	["Answer 16"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1697	1697	["Answer 17"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1698	1698	["Answer 18"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1699	1699	["Answer 19"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1700	1700	["Answer 20"]	Cambridge IELTS 14 Test 2 Part 2 Official Answer Key
1701	1701	["Answer 21"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1702	1702	["Answer 22"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1703	1703	["Answer 23"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1704	1704	["Answer 24"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1705	1705	["Answer 25"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1706	1706	["Answer 26"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1707	1707	["Answer 27"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1708	1708	["Answer 28"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1709	1709	["Answer 29"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1710	1710	["Answer 30"]	Cambridge IELTS 14 Test 2 Part 3 Official Answer Key
1711	1711	["Answer 31"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1712	1712	["Answer 32"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1713	1713	["Answer 33"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1714	1714	["Answer 34"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1715	1715	["Answer 35"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1716	1716	["Answer 36"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1717	1717	["Answer 37"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1718	1718	["Answer 38"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1719	1719	["Answer 39"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1720	1720	["Answer 40"]	Cambridge IELTS 14 Test 2 Part 4 Official Answer Key
1721	1721	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1722	1722	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1723	1723	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1724	1724	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1725	1725	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1726	1726	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1727	1727	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1728	1728	["Answer 8"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1729	1729	["Answer 9"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1730	1730	["Answer 10"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1731	1731	["Answer 11"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1732	1732	["Answer 12"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1733	1733	["Answer 13"]	Cambridge IELTS 14 Test 2 Passage 1 Official Answer Key
1734	1734	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1735	1735	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1736	1736	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1737	1737	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1738	1738	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1739	1739	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1740	1740	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1741	1741	["Answer 21"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1742	1742	["Answer 22"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1743	1743	["Answer 23"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1744	1744	["Answer 24"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1745	1745	["Answer 25"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1746	1746	["Answer 26"]	Cambridge IELTS 14 Test 2 Passage 2 Official Answer Key
1747	1747	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1748	1748	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1749	1749	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1750	1750	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1751	1751	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1752	1752	["FALSE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1753	1753	["TRUE"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1754	1754	["Answer 34"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1755	1755	["Answer 35"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1756	1756	["Answer 36"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1757	1757	["Answer 37"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1758	1758	["Answer 38"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1759	1759	["Answer 39"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1760	1760	["Answer 40"]	Cambridge IELTS 14 Test 2 Passage 3 Official Answer Key
1761	1761	["Answer 1"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1762	1762	["Answer 2"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1763	1763	["Answer 3"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1764	1764	["Answer 4"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1765	1765	["Answer 5"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1766	1766	["Answer 6"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1767	1767	["Answer 7"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1768	1768	["Answer 8"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1769	1769	["Answer 9"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1770	1770	["Answer 10"]	Cambridge IELTS 14 Test 3 Part 1 Official Answer Key
1771	1771	["Answer 11"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1772	1772	["Answer 12"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1773	1773	["Answer 13"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1774	1774	["Answer 14"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1775	1775	["Answer 15"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1776	1776	["Answer 16"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1777	1777	["Answer 17"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1778	1778	["Answer 18"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1779	1779	["Answer 19"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1780	1780	["Answer 20"]	Cambridge IELTS 14 Test 3 Part 2 Official Answer Key
1781	1781	["Answer 21"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1782	1782	["Answer 22"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1783	1783	["Answer 23"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1784	1784	["Answer 24"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1785	1785	["Answer 25"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1786	1786	["Answer 26"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1787	1787	["Answer 27"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1788	1788	["Answer 28"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1789	1789	["Answer 29"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1790	1790	["Answer 30"]	Cambridge IELTS 14 Test 3 Part 3 Official Answer Key
1791	1791	["Answer 31"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1792	1792	["Answer 32"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1793	1793	["Answer 33"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1794	1794	["Answer 34"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1795	1795	["Answer 35"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1796	1796	["Answer 36"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1797	1797	["Answer 37"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1798	1798	["Answer 38"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1799	1799	["Answer 39"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1800	1800	["Answer 40"]	Cambridge IELTS 14 Test 3 Part 4 Official Answer Key
1801	1801	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1802	1802	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1803	1803	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1804	1804	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1805	1805	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1806	1806	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1807	1807	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1808	1808	["Answer 8"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1809	1809	["Answer 9"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1810	1810	["Answer 10"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1811	1811	["Answer 11"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1812	1812	["Answer 12"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1813	1813	["Answer 13"]	Cambridge IELTS 14 Test 3 Passage 1 Official Answer Key
1814	1814	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1815	1815	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1816	1816	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1817	1817	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1818	1818	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1819	1819	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1820	1820	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1821	1821	["Answer 21"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1822	1822	["Answer 22"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1823	1823	["Answer 23"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1824	1824	["Answer 24"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1825	1825	["Answer 25"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1826	1826	["Answer 26"]	Cambridge IELTS 14 Test 3 Passage 2 Official Answer Key
1827	1827	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1828	1828	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1829	1829	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1830	1830	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1831	1831	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1832	1832	["FALSE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1833	1833	["TRUE"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1834	1834	["Answer 34"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1835	1835	["Answer 35"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1836	1836	["Answer 36"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1837	1837	["Answer 37"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1838	1838	["Answer 38"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1839	1839	["Answer 39"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1840	1840	["Answer 40"]	Cambridge IELTS 14 Test 3 Passage 3 Official Answer Key
1841	1841	["Answer 1"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1842	1842	["Answer 2"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1843	1843	["Answer 3"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1844	1844	["Answer 4"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1845	1845	["Answer 5"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1846	1846	["Answer 6"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1847	1847	["Answer 7"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1848	1848	["Answer 8"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1849	1849	["Answer 9"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1850	1850	["Answer 10"]	Cambridge IELTS 14 Test 4 Part 1 Official Answer Key
1851	1851	["Answer 11"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1852	1852	["Answer 12"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1853	1853	["Answer 13"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1854	1854	["Answer 14"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1855	1855	["Answer 15"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1856	1856	["Answer 16"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1857	1857	["Answer 17"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1858	1858	["Answer 18"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1859	1859	["Answer 19"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1860	1860	["Answer 20"]	Cambridge IELTS 14 Test 4 Part 2 Official Answer Key
1861	1861	["Answer 21"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1862	1862	["Answer 22"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1863	1863	["Answer 23"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1864	1864	["Answer 24"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1865	1865	["Answer 25"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1866	1866	["Answer 26"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1867	1867	["Answer 27"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1868	1868	["Answer 28"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1869	1869	["Answer 29"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1870	1870	["Answer 30"]	Cambridge IELTS 14 Test 4 Part 3 Official Answer Key
1871	1871	["Answer 31"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1872	1872	["Answer 32"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1873	1873	["Answer 33"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1874	1874	["Answer 34"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1875	1875	["Answer 35"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1876	1876	["Answer 36"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1877	1877	["Answer 37"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1878	1878	["Answer 38"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1879	1879	["Answer 39"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1880	1880	["Answer 40"]	Cambridge IELTS 14 Test 4 Part 4 Official Answer Key
1881	1881	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1882	1882	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1883	1883	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1884	1884	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1885	1885	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1886	1886	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1887	1887	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1888	1888	["Answer 8"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1889	1889	["Answer 9"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1890	1890	["Answer 10"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1891	1891	["Answer 11"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1892	1892	["Answer 12"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1893	1893	["Answer 13"]	Cambridge IELTS 14 Test 4 Passage 1 Official Answer Key
1894	1894	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1895	1895	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1896	1896	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1897	1897	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1898	1898	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1899	1899	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1900	1900	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1901	1901	["Answer 21"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1902	1902	["Answer 22"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1903	1903	["Answer 23"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1904	1904	["Answer 24"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1905	1905	["Answer 25"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1906	1906	["Answer 26"]	Cambridge IELTS 14 Test 4 Passage 2 Official Answer Key
1907	1907	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1908	1908	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1909	1909	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1910	1910	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1911	1911	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1912	1912	["FALSE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1913	1913	["TRUE"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1914	1914	["Answer 34"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1915	1915	["Answer 35"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1916	1916	["Answer 36"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1917	1917	["Answer 37"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1918	1918	["Answer 38"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1919	1919	["Answer 39"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
1920	1920	["Answer 40"]	Cambridge IELTS 14 Test 4 Passage 3 Official Answer Key
\.


--
-- Data for Name: audio_tracks; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.audio_tracks (id, section_id, file_path, checksum, duration_seconds) FROM stdin;
1	1	cambridge-ielts-15/audio/ielts15_test1_audio1.m4a	c4f0efe14b9a8e3362e2cfee5f028dbc87c05758b078d4124213aea504a27362	460.25
5	8	cambridge-ielts-15/audio/ielts15_test2_audio1.m4a	b6038832cd2cccf0b6750541e817ef4da6827f65ae543bcdfe37f05a45ba935e	487
17	29	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 1.mp3	39c82e95f451177791d906ce4e71a825af51d8189bfea8069f6c8fe59ae364e6	300
18	30	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 2.mp3	9fcb8ec64bd54fbe4959c4b0fb8514f3ba70aa1b9e574ef7b46791474ec26461	300
19	31	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 3.mp3	66e59fd1ff69b32f19c53177d5862b223de15e8adc35da776a67871468c96569	300
20	32	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 4.mp3	efc23eefcf168e386b641cb7b78333777b6b4733b320ab2d34489d607620ae2d	300
21	36	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 1.mp3	6d2f974bcad007fa3e82a1f51178c3cd41ad33d549ef2c438e1565032cc84255	300
22	37	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 2.mp3	71b149b5f77342c6b2286a2d063f1b921261211807c7cd75cff78a3158074021	300
23	38	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 3.mp3	bb10976d6ed326f462d84b2c644d7a5facdc90b20be24e114f989ebdc13d712e	300
24	39	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 4.mp3	359b5837fd538a8967b4820ff63b3835ffa146455458a2cc18947e3cfa2ccb47	300
25	43	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 1.mp3	6516521325d66d23d3d43ddd00bf06f70e8ff766943565757664a7f410429574	300
26	44	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 2.mp3	a06d4be643fba3c93b74ee01b9e4cd7355febc41e59f3f132c35efc61b87d83f	300
27	45	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 3.mp3	4ddf7928b15293aecadd090fcc0ccca7dd71c4f2f8c4d39413bdbd955308f10c	300
28	46	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 4.mp3	700c5cb83ad86125a78d556479fcb75532b517ce02fa9281983d38e8981d3517	300
29	50	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 1.mp3	718d0e60f5993069b31984201ac7fe57a67e57ad9fd5eb4f760959c5e5549e05	300
30	51	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 2.mp3	769158231df1b766639998d4d650070dc74d826d6d9c269bae574168b1a3de12	300
31	52	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 3.mp3	c22d7ea54ce6fd0acdf3a6452dd8581c6fbbfca70e3e21145cd9fde220a1a703	300
33	113	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_01.mp3	ba1c79a6a8fbe1422aaddee4cc4764daa17b464003ca7818b82b53af6f5f0f08	448.29
34	114	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_02.mp3	e9c7364bdb768dc71f30bdf9aff7f2e6c59bf85c537acabf9bbaf042ef252956	405.6
35	115	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_03.mp3	43334d865fb8d0dc41499d869b3a27ccf341d3f1b3c64607237811564edf4c88	426.65
36	116	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_04.mp3	8a75ffd10f2c43462df31168cc231b6bdb404530dd06d78d0f204601e007c83e	419.11
37	120	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_05.mp3	0476f3c9c97aafa432a2ab85c4a812c7145c4b1777e3b38d8debf07f4bf05141	520.94
38	121	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_06.mp3	c97f4ff3b3d9322127f76a22f87524fc349d7f30f6ecfe3015c7f613fc563e71	439.84
39	122	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_07.mp3	90d5cd6015432e5570bdbb3c7a3328b67697ab1d1cd8a86ade71711e9510c091	428.44
40	123	cambridge-ielts-13/audio/IELTS13-Tests1-4CD1Track_08.mp3	e675e98dea85e28fa038d23a7e2cd75d4dedaaeadafc9ee827044aa64b60b0ff	543.39
41	127	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_01.mp3	c319b88430e2e1764005d3463ba8d1a58db84854df2ca00e382023891800a834	548.35
42	128	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_02.mp3	133658ee4fd7e06a61bf9d0c703f3c3331ced3bd7f9252690cc343365f26f60a	380.82
43	129	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_03.mp3	65e5e4e1bacc044d6621e474a157a329c16b48886c16cf6c4caa62fe95558203	397.95
44	130	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_04.mp3	c62a77fbeadfa5bc56ae64390cf08d56e8a0c2bf6c760d7b021d82e8abe39ca6	399
45	134	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_05.mp3	972d0bfd6f79ef89c00c7d98cd23095dd2e1bc9b5c9120ea1bf73141596a8dc7	466.16
46	135	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_06.mp3	45d23c251f06d5a51a20941d714c132542230b65990f977b71a19eae6df4b8d8	412.06
47	136	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_07.mp3	86b84c8003e08bde4ece692140f89c424eca07394d82b7846e83ba6ca834dd8e	450.2
32	53	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 4.mp3	c67bdad325135ddbeb1960649212cea1b7eb015d9061f44bb3212ed531540f4e	300
48	137	cambridge-ielts-13/audio/IELTS13-Tests1-4CD2Track_08.mp3	481c84c1b0250ac7f6eeeb3e3b9faa1207fa1f21bfd1106fbbcb28d7e63ac381	477.74
2	2	cambridge-ielts-15/audio/ielts15_test1_audio2.m4a	28ec443b3ca6a677424460cfd67fa946397ba616153f23a299a98df1b0349e0b	418.47
3	3	cambridge-ielts-15/audio/ielts15_test1_audio3.m4a	191e1abede32e56380b0aa32a7730c98c574e3b89e648f84bf31866719b1442e	432.85
4	4	cambridge-ielts-15/audio/ielts15_test1_audio4.m4a	61e80747260137fd728607c505fd066499a429d19d9a6792c6d100b005f47247	546.65
6	9	cambridge-ielts-15/audio/ielts15_test2_audio2.m4a	7e0e00f71e779ab7e884a17da10b10ba30c6eafefb43390d39ab001eeafe1c17	423.68
7	10	cambridge-ielts-15/audio/ielts15_test2_audio3.m4a	5852f1674584bf8abe566dfdec3439edfe36e2db5fbc52d7483429bef5f9c2f0	427.69
8	11	cambridge-ielts-15/audio/ielts15_test2_audio4.m4a	db19c5bfaedf9ead311102e78f00501bc14ce4ad6acc1a0e01561691784ec21c	524.84
9	15	cambridge-ielts-15/audio/ielts15_test3_audio1.m4a	ef7e14b87ab280ac03e41d0058eed6151ba52a3c84d582c497000316bbc78565	470.61
10	16	cambridge-ielts-15/audio/ielts15_test3_audio2.m4a	dd097156a2bf3f1f9a8c76019e8cbf3fd2edc5e97d14de553b1e652f7dacd173	424.53
11	17	cambridge-ielts-15/audio/ielts15_test3_audio3.m4a	23269aba3945fe32accf812a1ec3cdd21c1fa9091465583507161cf4e6bfd6c9	410.07
12	18	cambridge-ielts-15/audio/ielts15_test3_audio4.m4a	4e2cee2e3e6ede7716242aebd57f0701dd7ca4bdef0afa861a303ae7dadd1ba4	467.07
13	22	cambridge-ielts-15/audio/ielts15_test4_audio1.m4a	1ddaea93cfcf0fbe6aaba07be0bed5adbf7a968bb931265a93e6442349ae04fe	474.67
14	23	cambridge-ielts-15/audio/ielts15_test4_audio2.m4a	d7bcb0f88eef2b0c5f579eeca5f85744adbbd6b417a4e7b6d389889e0c697025	381.18
15	24	cambridge-ielts-15/audio/ielts15_test4_audio3.m4a	44ce12fd0e77d23a09fa5e0dec3a01b4020c025d61c90e469fed063f48d25303	418.86
16	25	cambridge-ielts-15/audio/ielts15_test4_audio3.m4a	44ce12fd0e77d23a09fa5e0dec3a01b4020c025d61c90e469fed063f48d25303	418.86
\.


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.books (id, title, total_pages, source_pdf_path, source_pdf_checksum, created_at) FROM stdin;
1	Cambridge IELTS 15	147	cambridge-ielts-15/source/book.pdf	a24469a4319bdff90088859b82850e2f986a88e2e3b13e6547db117a20783298	2026-08-31 22:31:49.601087+07
2	Cambridge IELTS 10	178	cambridge-ielts-10/source/book.pdf	a24469a4319bdff90088859b82850e2f986a88e2e3b13e6547db117a20783298	2026-08-31 23:10:16.037421+07
3	Cambridge IELTS 11	146	cambridge-ielts-11/source/book.pdf	a24469a4319bdff90088859b82850e2f986a88e2e3b13e6547db117a20783298	2026-08-31 23:10:16.722461+07
4	Cambridge IELTS 12	131	cambridge-ielts-12/source/book.pdf	a24469a4319bdff90088859b82850e2f986a88e2e3b13e6547db117a20783298	2026-08-31 23:10:17.463889+07
5	Cambridge IELTS 13	140	cambridge-ielts-13/source/book.pdf	a24469a4319bdff90088859b82850e2f986a88e2e3b13e6547db117a20783298	2026-08-31 23:10:18.279374+07
6	Cambridge IELTS 14	136	cambridge-ielts-14/source/book.pdf	a24469a4319bdff90088859b82850e2f986a88e2e3b13e6547db117a20783298	2026-08-31 23:10:19.118214+07
\.


--
-- Data for Name: passages; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.passages (id, section_id, title, body_text) FROM stdin;
1	5	Nutmeg – a valuable spice	The nutmeg tree, Myristica fragrans, is a large evergreen tree native to Southeast Asia. Until the late 18th century, it only grew in one place in the world: a small group of islands in the Banda Sea, part of the Moluccas – or Spice Islands – in northeastern Indonesia.\n\nNutmeg was a highly prized and costly ingredient in European cuisine in the Middle Ages, and was used as a flavouring, medicinal, and preservative agent. Throughout this period, the Arabs were the exclusive importers of the spice to Europe. They sold nutmeg for high prices to merchants based in Venice, but they never revealed the exact location of the source of this extremely valuable commodity.\n\nIn 1602, Dutch merchants founded the VOC, a trading corporation better known as the Dutch East India Company. By 1617, the VOC was the richest commercial operation in the world. The Banda Islands were ruled by local sultans who insisted on maintaining a neutral trading policy towards foreign powers. In 1621, the Dutch arrived and took over. One of the Banda Islands, a sliver of land called Run, was under the control of the British. In 1667, the Treaty of Breda was signed, trading Run for Manhattan (New Amsterdam).\n\nThen, in 1770, a Frenchman named Pierre Poivre successfully smuggled nutmeg plants to safety in Mauritius. In 1778, a volcanic eruption caused a tsunami that wiped out half the nutmeg groves.
2	6	Driverless cars	Automotive technology is advancing rapidly towards fully autonomous vehicles. Automated driving technology could revolutionize transportation, making roads safer by drastically reducing human error, lowering vehicle emissions, reducing congestion, and freeing up time for passengers.
3	7	What is exploration?	Exploration is an inherent human drive that defines our history and species. We are all explorers in the sense that we constantly investigate our surroundings and seek new frontiers. In this passage, the author examines what defines exploration in the modern era.
4	12	Could urban engineers learn from dance?	Understanding how human crowds move through urban spaces can benefit from choreographic and dance principles.
5	13	Should we try to bring extinct species back to life?	De-extinction technologies are opening up the possibility of reviving extinct species like the mammoth and passenger pigeon.
6	14	Having a laugh	The science of laughter and how humour is processed in the human brain.
7	19	Henry Moore (1898–1986)	Biographical passage about British sculptor Henry Moore, his life, inspirations, materials, and world-renowned artistic legacy.
8	20	The Desirable Plant	Botanical and agricultural history of crop cultivation, genetic modification, and human selection.
9	21	The future of work and artificial intelligence	An analysis of automation, economic impact, and future employment paradigms.
10	26	The huarango tree of Peru	The ecological and archaeological significance of the huarango tree in the Ica Valley on the south coast of Peru.
11	27	Silbo Gomero – the whistling language of La Gomera	The origins, phonetics, and revitalization of the whistled speech of the Canary Islands.
12	28	Environmental practices of big businesses	How market forces, public pressure, and regulatory frameworks influence multinational environmental responsibility.
13	33	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 1, Passage 1. Read the passage carefully to answer questions 1 to 13.
14	34	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 1, Passage 2. Read the passage carefully to answer questions 14 to 26.
15	35	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 1, Passage 3. Read the passage carefully to answer questions 27 to 40.
16	40	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 2, Passage 1. Read the passage carefully to answer questions 1 to 13.
17	41	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 2, Passage 2. Read the passage carefully to answer questions 14 to 26.
18	42	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 2, Passage 3. Read the passage carefully to answer questions 27 to 40.
19	47	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 3, Passage 1. Read the passage carefully to answer questions 1 to 13.
20	48	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 3, Passage 2. Read the passage carefully to answer questions 14 to 26.
21	49	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 3, Passage 3. Read the passage carefully to answer questions 27 to 40.
22	54	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 4, Passage 1. Read the passage carefully to answer questions 1 to 13.
23	55	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 4, Passage 2. Read the passage carefully to answer questions 14 to 26.
24	56	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 10, Test 4, Passage 3. Read the passage carefully to answer questions 27 to 40.
25	61	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 1, Passage 1. Read the passage carefully to answer questions 1 to 13.
26	62	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 1, Passage 2. Read the passage carefully to answer questions 14 to 26.
27	63	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 1, Passage 3. Read the passage carefully to answer questions 27 to 40.
28	68	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 2, Passage 1. Read the passage carefully to answer questions 1 to 13.
29	69	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 2, Passage 2. Read the passage carefully to answer questions 14 to 26.
30	70	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 2, Passage 3. Read the passage carefully to answer questions 27 to 40.
31	75	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 3, Passage 1. Read the passage carefully to answer questions 1 to 13.
32	76	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 3, Passage 2. Read the passage carefully to answer questions 14 to 26.
33	77	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 3, Passage 3. Read the passage carefully to answer questions 27 to 40.
34	82	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 4, Passage 1. Read the passage carefully to answer questions 1 to 13.
35	83	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 4, Passage 2. Read the passage carefully to answer questions 14 to 26.
36	84	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 11, Test 4, Passage 3. Read the passage carefully to answer questions 27 to 40.
37	89	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 1, Passage 1. Read the passage carefully to answer questions 1 to 13.
38	90	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 1, Passage 2. Read the passage carefully to answer questions 14 to 26.
39	91	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 1, Passage 3. Read the passage carefully to answer questions 27 to 40.
40	96	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 2, Passage 1. Read the passage carefully to answer questions 1 to 13.
41	97	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 2, Passage 2. Read the passage carefully to answer questions 14 to 26.
42	98	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 2, Passage 3. Read the passage carefully to answer questions 27 to 40.
43	103	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 3, Passage 1. Read the passage carefully to answer questions 1 to 13.
44	104	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 3, Passage 2. Read the passage carefully to answer questions 14 to 26.
45	105	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 3, Passage 3. Read the passage carefully to answer questions 27 to 40.
46	110	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 4, Passage 1. Read the passage carefully to answer questions 1 to 13.
47	111	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 4, Passage 2. Read the passage carefully to answer questions 14 to 26.
48	112	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 12, Test 4, Passage 3. Read the passage carefully to answer questions 27 to 40.
49	117	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 1, Passage 1. Read the passage carefully to answer questions 1 to 13.
50	118	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 1, Passage 2. Read the passage carefully to answer questions 14 to 26.
51	119	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 1, Passage 3. Read the passage carefully to answer questions 27 to 40.
52	124	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 2, Passage 1. Read the passage carefully to answer questions 1 to 13.
53	125	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 2, Passage 2. Read the passage carefully to answer questions 14 to 26.
54	126	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 2, Passage 3. Read the passage carefully to answer questions 27 to 40.
55	131	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 3, Passage 1. Read the passage carefully to answer questions 1 to 13.
56	132	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 3, Passage 2. Read the passage carefully to answer questions 14 to 26.
57	133	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 3, Passage 3. Read the passage carefully to answer questions 27 to 40.
58	138	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 4, Passage 1. Read the passage carefully to answer questions 1 to 13.
59	139	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 4, Passage 2. Read the passage carefully to answer questions 14 to 26.
60	140	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 13, Test 4, Passage 3. Read the passage carefully to answer questions 27 to 40.
61	145	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 1, Passage 1. Read the passage carefully to answer questions 1 to 13.
62	146	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 1, Passage 2. Read the passage carefully to answer questions 14 to 26.
63	147	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 1, Passage 3. Read the passage carefully to answer questions 27 to 40.
64	152	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 2, Passage 1. Read the passage carefully to answer questions 1 to 13.
65	153	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 2, Passage 2. Read the passage carefully to answer questions 14 to 26.
66	154	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 2, Passage 3. Read the passage carefully to answer questions 27 to 40.
67	159	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 3, Passage 1. Read the passage carefully to answer questions 1 to 13.
68	160	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 3, Passage 2. Read the passage carefully to answer questions 14 to 26.
69	161	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 3, Passage 3. Read the passage carefully to answer questions 27 to 40.
70	166	READING PASSAGE 1	You should spend about 20 minutes on Questions 1-13, which are based on Reading Passage 1 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 4, Passage 1. Read the passage carefully to answer questions 1 to 13.
71	167	READING PASSAGE 2	You should spend about 20 minutes on Questions 14-26, which are based on Reading Passage 2 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 4, Passage 2. Read the passage carefully to answer questions 14 to 26.
72	168	READING PASSAGE 3	You should spend about 20 minutes on Questions 27-40, which are based on Reading Passage 3 below.\n\nAcademic reading text from Cambridge IELTS 14, Test 4, Passage 3. Read the passage carefully to answer questions 27 to 40.
\.


--
-- Data for Name: question_groups; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.question_groups (id, section_id, group_order, question_type, instruction, question_from, question_to) FROM stdin;
1	1	1	notes_completion	Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
2	2	1	multiple_choice	Choose the correct letter, A, B or C.	11	14
3	2	2	table_completion	Complete the table below. Write ONE WORD AND/OR A NUMBER for each answer.	15	20
4	3	1	matching	What did findings of previous research claim about the personality traits a child is likely to have because of their position in the family? Choose SIX answers from the box (A-H).	21	26
5	3	2	multiple_choice	Choose the correct letter, A, B or C.	27	28
6	3	3	multiple_choice_multiple_answers	Choose TWO letters, A-E. Which TWO experiences of sibling rivalry do the speakers agree has been valuable for them?	29	30
7	4	1	notes_completion	Complete the notes below. Write ONE WORD ONLY for each answer.	31	40
8	5	1	notes_completion	Complete the notes below. Choose ONE WORD ONLY from the passage for each answer.	1	4
9	5	2	true_false_not_given	Do the following statements agree with the information given in Reading Passage 1? Write TRUE, FALSE, or NOT GIVEN.	5	7
10	5	3	table_completion	Complete the table below. Choose ONE WORD ONLY from the passage for each answer.	8	13
11	6	1	matching_information	Which section contains the following information? Write the correct letter, A-G.	14	18
12	6	2	summary_completion	Complete the summary below. Choose NO MORE THAN TWO WORDS from the passage for each answer.	19	22
13	6	3	multiple_choice_multiple_answers	Choose TWO letters, A-E. Which TWO benefits of automated transport are mentioned in the passage?	23	24
14	6	4	multiple_choice_multiple_answers	Choose TWO letters, A-E. Which TWO challenges to the introduction of driverless cars are discussed?	25	26
15	7	1	multiple_choice	Choose the correct letter, A, B, C or D.	27	31
16	7	2	matching_opinions	Look at the following statements (Questions 32-37) and the list of explorers below. Match each statement with the correct explorer, A-E.	32	37
17	7	3	summary_completion	Complete the summary below. Choose ONE WORD ONLY from the passage for each answer.	38	40
18	8	1	notes_completion	Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
19	9	1	multiple_choice	Choose the correct letter, A, B or C.	11	14
20	9	2	matching_map	Label the map below. Write the correct letter, A-H.	15	20
21	10	1	multiple_choice_multiple_answers	Choose TWO letters, A-E. (Questions 21-22)	21	22
22	10	2	multiple_choice_multiple_answers	Choose TWO letters, A-E. (Questions 23-24)	23	24
23	10	3	matching	What comment does the tutor make about each part of the presentation? Choose SIX answers from the box, A-H.	25	30
24	11	1	notes_completion	Complete the notes below. Write ONE WORD ONLY for each answer.	31	40
25	12	1	matching_paragraphs	Which paragraph contains the following information? (Questions 1-6)	1	6
26	12	2	notes_completion	Complete the notes below. Write ONE WORD ONLY.	7	13
27	13	1	matching_information	Which section contains the following information? (Questions 14-17)	14	17
28	13	2	summary_completion	Complete the summary below. Write NO MORE THAN TWO WORDS.	18	22
29	13	3	multiple_choice	Choose the correct letter, A, B, C or D.	23	26
30	14	1	multiple_choice	Choose the correct letter, A, B, C or D.	27	30
31	14	2	matching_opinions	Match each statement with the correct researcher, A-H.	31	36
32	14	3	yes_no_not_given	Do the following statements agree with the views of the writer? Write YES, NO, or NOT GIVEN.	37	40
33	15	1	notes_completion	Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
34	16	1	multiple_choice	Choose the correct letter, A, B or C.	11	16
35	16	2	multiple_choice_multiple_answers	Choose TWO letters, A-E. (Questions 17-18)	17	18
36	16	3	multiple_choice_multiple_answers	Choose TWO letters, A-E. (Questions 19-20)	19	20
37	17	1	notes_completion	Complete the flow-chart below. Write ONE WORD ONLY.	21	26
38	17	2	multiple_choice	Choose the correct letter, A, B or C.	27	30
39	18	1	notes_completion	Complete the notes below. Write ONE WORD ONLY for each answer.	31	40
40	19	1	true_false_not_given	Do the following statements agree with the information given? Write TRUE, FALSE, or NOT GIVEN.	1	7
41	19	2	notes_completion	Complete the notes below. Write ONE WORD ONLY.	8	13
42	20	1	matching_headings	Choose the correct heading for each section from the list of headings below. (Questions 14-20)	14	20
43	20	2	diagram_completion	Complete the diagram below. Write ONE WORD ONLY.	21	26
44	21	1	multiple_choice	Choose the correct letter, A, B, C or D.	27	30
45	21	2	matching_opinions	Match each statement with the correct economist/expert, A-G.	31	36
46	21	3	multiple_choice	Choose the correct letter, A, B, C or D.	37	40
47	22	1	notes_completion	Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
48	23	1	multiple_choice	Choose the correct letter, A, B or C.	11	16
49	23	2	multiple_choice_multiple_answers	Choose TWO letters, A-E. (Questions 17-18)	17	18
50	23	3	multiple_choice_multiple_answers	Choose TWO letters, A-E. (Questions 19-20)	19	20
51	24	1	multiple_choice	Choose the correct letter, A, B or C. (Questions 21-30)	21	30
52	25	1	notes_completion	Complete the notes below. Write ONE WORD ONLY for each answer.	31	40
53	26	1	notes_completion	Complete the notes below. Write NO MORE THAN TWO WORDS.	1	8
54	26	2	true_false_not_given	Do the following statements agree with the information given? Write TRUE, FALSE, or NOT GIVEN.	9	13
55	27	1	true_false_not_given	Do the following statements agree with the information given? Write TRUE, FALSE, or NOT GIVEN.	14	19
56	27	2	summary_completion	Complete the summary below. Write ONE WORD ONLY.	20	26
57	28	1	multiple_choice	Choose the correct letter, A, B, C or D. (Questions 27-34)	27	34
58	28	2	yes_no_not_given	Do the following statements agree with the claims of the writer? Write YES, NO, or NOT GIVEN.	35	39
59	28	3	multiple_choice	Choose the correct letter, A, B, C or D.	40	40
60	29	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
61	30	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
62	31	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
63	32	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
64	33	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
65	33	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
66	34	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
67	34	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
68	35	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
69	35	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
70	36	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
71	37	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
72	38	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
73	39	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
74	40	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
75	40	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
76	41	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
77	41	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
78	42	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
79	42	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
80	43	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
81	44	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
82	45	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
83	46	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
84	47	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
85	47	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
86	48	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
87	48	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
88	49	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
89	49	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
90	50	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
91	51	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
92	52	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
93	53	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
94	54	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
95	54	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
96	55	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
97	55	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
98	56	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
99	56	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
100	57	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
101	58	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
102	59	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
103	60	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
104	61	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
105	61	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
106	62	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
107	62	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
108	63	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
109	63	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
110	64	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
111	65	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
112	66	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
113	67	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
114	68	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
115	68	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
116	69	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
117	69	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
118	70	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
119	70	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
120	71	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
121	72	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
122	73	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
123	74	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
124	75	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
125	75	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
126	76	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
127	76	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
128	77	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
129	77	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
130	78	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
131	79	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
132	80	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
133	81	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
134	82	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
135	82	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
136	83	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
137	83	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
138	84	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
139	84	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
140	85	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
141	86	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
142	87	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
143	88	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
144	89	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
145	89	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
146	90	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
147	90	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
148	91	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
149	91	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
150	92	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
151	93	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
152	94	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
153	95	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
154	96	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
155	96	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
156	97	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
157	97	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
158	98	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
159	98	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
160	99	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
161	100	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
162	101	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
163	102	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
164	103	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
165	103	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
166	104	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
167	104	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
168	105	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
169	105	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
170	106	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
171	107	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
172	108	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
173	109	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
174	110	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
175	110	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
176	111	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
177	111	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
178	112	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
179	112	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
180	113	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
181	114	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
182	115	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
183	116	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
184	117	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
185	117	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
186	118	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
187	118	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
188	119	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
189	119	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
190	120	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
191	121	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
192	122	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
193	123	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
194	124	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
195	124	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
196	125	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
197	125	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
198	126	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
199	126	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
200	127	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
201	128	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
202	129	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
203	130	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
204	131	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
205	131	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
206	132	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
207	132	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
208	133	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
209	133	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
210	134	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
211	135	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
212	136	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
213	137	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
214	138	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
215	138	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
216	139	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
217	139	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
218	140	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
219	140	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
220	141	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
221	142	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
222	143	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
223	144	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
224	145	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
225	145	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
226	146	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
227	146	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
228	147	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
229	147	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
230	148	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
231	149	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
232	150	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
233	151	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
234	152	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
235	152	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
236	153	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
237	153	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
238	154	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
239	154	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
240	155	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
241	156	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
242	157	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
243	158	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
244	159	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
245	159	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
246	160	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
247	160	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
248	161	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
249	161	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
250	162	1	notes_completion	Questions 1-10. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	1	10
251	163	1	multiple_choice	Questions 11-20. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	11	20
252	164	1	multiple_choice	Questions 21-30. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	21	30
253	165	1	notes_completion	Questions 31-40. Complete the notes below. Write ONE WORD AND/OR A NUMBER for each answer.	31	40
254	166	1	true_false_not_given	Questions 1-7. Do the following statements agree with the information given in Reading Passage 1?\nIn boxes 1-7 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	1	7
255	166	2	sentence_completion	Questions 8-13. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	8	13
256	167	1	matching_headings	Questions 14-20. Do the following statements agree with the information given in Reading Passage 2?\nIn boxes 14-20 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	14	20
257	167	2	multiple_choice	Questions 21-26. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	21	26
258	168	1	matching_headings	Questions 27-33. Do the following statements agree with the information given in Reading Passage 3?\nIn boxes 27-33 on your answer sheet, write TRUE, FALSE, or NOT GIVEN.	27	33
259	168	2	multiple_choice	Questions 34-40. Complete the sentences below.\nChoose NO MORE THAN TWO WORDS from the passage for each answer.	34	40
\.


--
-- Data for Name: question_options; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.question_options (id, question_id, option_label, option_text) FROM stdin;
1	11	A	has been in business for longer than most of its competitors.
2	11	B	arranges holidays to more destinations than its competitors.
3	11	C	has more customers than its competitors.
4	12	A	Liverpool
5	12	B	Heysham
6	12	C	Luton
7	13	A	three
8	13	B	four
9	13	C	five
10	14	A	guaranteeing themselves a larger room.
11	14	B	booking at short notice.
12	14	C	transferring to another date.
13	27	A	There is conflicting evidence about whether oldest children perform best in intelligence tests.
14	27	B	There is little doubt that birth order has less influence on academic achievement than socio-economic status.
15	27	C	Some studies have neglected to include important factors such as family size.
16	28	A	It is mainly thanks to their roles as teachers for their younger siblings.
17	28	B	The advantages they have only lead to a slightly higher level of achievement.
18	28	C	The extra parental attention they receive at a young age makes little difference.
19	29	A	learning to share
20	29	B	learning to stand up for oneself
21	29	C	learning to be a good loser
22	29	D	learning to be tolerant
23	29	E	learning to say sorry
24	30	A	learning to share
25	30	B	learning to stand up for oneself
26	30	C	learning to be a good loser
27	30	D	learning to be tolerant
28	30	E	learning to say sorry
29	45	TRUE	TRUE
30	45	FALSE	FALSE
31	45	NOT GIVEN	NOT GIVEN
32	46	TRUE	TRUE
33	46	FALSE	FALSE
34	46	NOT GIVEN	NOT GIVEN
35	47	TRUE	TRUE
36	47	FALSE	FALSE
37	47	NOT GIVEN	NOT GIVEN
38	63	A	travelling in bad weather is easier
39	63	B	less fuel is needed for short journeys
40	63	C	older people will be able to travel independently
41	63	D	urban space will be used more efficiently
42	63	E	there will be less disruption to public transport
43	64	A	travelling in bad weather is easier
44	64	B	less fuel is needed for short journeys
45	64	C	older people will be able to travel independently
46	64	D	urban space will be used more efficiently
47	64	E	there will be less disruption to public transport
48	65	A	adapting the legal framework
49	65	B	educating users on autonomous systems
50	65	C	overcoming technical difficulties in manufacturing
51	65	D	coping with extreme traffic conditions
52	65	E	managing the transition period
53	66	A	adapting the legal framework
54	66	B	educating users on autonomous systems
55	66	C	overcoming technical difficulties in manufacturing
56	66	D	coping with extreme traffic conditions
57	66	E	managing the transition period
58	67	A	show that travel is no longer associated with exploration.
59	67	B	illustrate the wide variety of modern holiday destinations.
60	67	C	suggest that tourism is damaging delicate environments.
61	67	D	emphasise the desire of many people to undertake dangerous journeys.
62	68	A	exploration requires sophisticated equipment.
63	68	B	some areas remain inaccessible to modern explorers.
64	68	C	exploration can take place in familiar regions.
65	68	D	nature has the power to reclaim land from human settlements.
66	69	A	He believes it is too narrow to apply to modern expeditions.
67	69	B	He argues that it is irrelevant to today's travellers.
68	69	C	He accepts that it is a useful general principle.
69	69	D	He rejects it because it excludes certain types of explorer.
70	70	A	explorers need to be physically fit.
71	70	B	explorers often face harsh environmental conditions.
72	70	C	modern exploration requires specialist skills.
73	70	D	some parts of the planet remain largely unmapped.
74	71	A	Their accounts of their journeys were not entirely factual.
75	71	B	They lacked understanding of the indigenous people they met.
76	71	C	They were motivated by personal fame and financial gain.
77	71	D	They took unnecessary risks in unexplored regions.
78	91	A	Option A
79	91	B	Option B
80	91	C	Option C
81	92	A	Option A
82	92	B	Option B
83	92	C	Option C
84	93	A	Option A
85	93	B	Option B
86	93	C	Option C
87	94	A	Option A
88	94	B	Option B
89	94	C	Option C
90	101	A	A
91	101	B	B
92	101	C	C
93	101	D	D
94	101	E	E
95	102	A	A
96	102	B	B
97	102	C	C
98	102	D	D
99	102	E	E
100	103	A	A
101	103	B	B
102	103	C	C
103	103	D	D
104	103	E	E
105	104	A	A
106	104	B	B
107	104	C	C
108	104	D	D
109	104	E	E
110	143	A	A
111	143	B	B
112	143	C	C
113	143	D	D
114	144	A	A
115	144	B	B
116	144	C	C
117	144	D	D
118	145	A	A
119	145	B	B
120	145	C	C
121	145	D	D
122	146	A	A
123	146	B	B
124	146	C	C
125	146	D	D
126	147	A	A
127	147	B	B
128	147	C	C
129	147	D	D
130	148	A	A
131	148	B	B
132	148	C	C
133	148	D	D
134	149	A	A
135	149	B	B
136	149	C	C
137	149	D	D
138	150	A	A
139	150	B	B
140	150	C	C
141	150	D	D
142	157	YES	YES
143	157	NO	NO
144	157	NOT GIVEN	NOT GIVEN
145	158	YES	YES
146	158	NO	NO
147	158	NOT GIVEN	NOT GIVEN
148	159	YES	YES
149	159	NO	NO
150	159	NOT GIVEN	NOT GIVEN
151	160	YES	YES
152	160	NO	NO
153	160	NOT GIVEN	NOT GIVEN
154	171	A	A
155	171	B	B
156	171	C	C
157	172	A	A
158	172	B	B
159	172	C	C
160	173	A	A
161	173	B	B
162	173	C	C
163	174	A	A
164	174	B	B
165	174	C	C
166	175	A	A
167	175	B	B
168	175	C	C
169	176	A	A
170	176	B	B
171	176	C	C
172	177	A	A
173	177	B	B
174	177	C	C
175	177	D	D
176	177	E	E
177	178	A	A
178	178	B	B
179	178	C	C
180	178	D	D
181	178	E	E
182	179	A	A
183	179	B	B
184	179	C	C
185	179	D	D
186	179	E	E
187	180	A	A
188	180	B	B
189	180	C	C
190	180	D	D
191	180	E	E
192	187	A	A
193	187	B	B
194	187	C	C
195	188	A	A
196	188	B	B
197	188	C	C
198	189	A	A
199	189	B	B
200	189	C	C
201	190	A	A
202	190	B	B
203	190	C	C
204	201	TRUE	TRUE
205	201	FALSE	FALSE
206	201	NOT GIVEN	NOT GIVEN
207	202	TRUE	TRUE
208	202	FALSE	FALSE
209	202	NOT GIVEN	NOT GIVEN
210	203	TRUE	TRUE
211	203	FALSE	FALSE
212	203	NOT GIVEN	NOT GIVEN
213	204	TRUE	TRUE
214	204	FALSE	FALSE
215	204	NOT GIVEN	NOT GIVEN
216	205	TRUE	TRUE
217	205	FALSE	FALSE
218	205	NOT GIVEN	NOT GIVEN
219	206	TRUE	TRUE
220	206	FALSE	FALSE
221	206	NOT GIVEN	NOT GIVEN
222	207	TRUE	TRUE
223	207	FALSE	FALSE
224	207	NOT GIVEN	NOT GIVEN
225	227	A	A
226	227	B	B
227	227	C	C
228	227	D	D
229	228	A	A
230	228	B	B
231	228	C	C
232	228	D	D
233	229	A	A
234	229	B	B
235	229	C	C
236	229	D	D
237	230	A	A
238	230	B	B
239	230	C	C
240	230	D	D
241	237	A	A
242	237	B	B
243	237	C	C
244	237	D	D
245	238	A	A
246	238	B	B
247	238	C	C
248	238	D	D
249	239	A	A
250	239	B	B
251	239	C	C
252	239	D	D
253	240	A	A
254	240	B	B
255	240	C	C
256	240	D	D
257	251	A	A
258	251	B	B
259	251	C	C
260	251	D	D
261	252	A	A
262	252	B	B
263	252	C	C
264	253	A	A
265	253	B	B
266	253	C	C
267	253	G	G
268	254	A	A
269	254	B	B
270	254	C	C
271	254	H	H
272	255	A	A
273	255	B	B
274	255	C	C
275	256	A	A
276	256	B	B
277	256	C	C
278	256	E	E
279	257	A	A
280	257	B	B
281	257	C	C
282	257	D	D
283	257	E	E
284	258	A	A
285	258	B	B
286	258	C	C
287	258	D	D
288	258	E	E
289	259	A	A
290	259	B	B
291	259	C	C
292	259	D	D
293	259	E	E
294	260	A	A
295	260	B	B
296	260	C	C
297	260	D	D
298	260	E	E
299	261	A	A
300	261	B	B
301	261	C	C
302	262	A	A
303	262	B	B
304	262	C	C
305	263	A	A
306	263	B	B
307	263	C	C
308	264	A	A
309	264	B	B
310	264	C	C
311	265	A	A
312	265	B	B
313	265	C	C
314	266	A	A
315	266	B	B
316	266	C	C
317	267	A	A
318	267	B	B
319	267	C	C
320	268	A	A
321	268	B	B
322	268	C	C
323	269	A	A
324	269	B	B
325	269	C	C
326	270	A	A
327	270	B	B
328	270	C	C
329	289	TRUE	TRUE
330	289	FALSE	FALSE
331	289	NOT GIVEN	NOT GIVEN
332	290	TRUE	TRUE
333	290	FALSE	FALSE
334	290	NOT GIVEN	NOT GIVEN
335	291	TRUE	TRUE
336	291	FALSE	FALSE
337	291	NOT GIVEN	NOT GIVEN
338	292	TRUE	TRUE
339	292	FALSE	FALSE
340	292	NOT GIVEN	NOT GIVEN
341	293	TRUE	TRUE
342	293	FALSE	FALSE
343	293	NOT GIVEN	NOT GIVEN
344	294	TRUE	TRUE
345	294	FALSE	FALSE
346	294	NOT GIVEN	NOT GIVEN
347	295	TRUE	TRUE
348	295	FALSE	FALSE
349	295	NOT GIVEN	NOT GIVEN
350	296	TRUE	TRUE
351	296	FALSE	FALSE
352	296	NOT GIVEN	NOT GIVEN
353	297	TRUE	TRUE
354	297	FALSE	FALSE
355	297	NOT GIVEN	NOT GIVEN
356	298	TRUE	TRUE
357	298	FALSE	FALSE
358	298	NOT GIVEN	NOT GIVEN
359	299	TRUE	TRUE
360	299	FALSE	FALSE
361	299	NOT GIVEN	NOT GIVEN
362	307	A	A
363	307	B	B
364	307	C	C
365	307	D	D
366	308	A	A
367	308	B	B
368	308	C	C
369	308	E	E
370	309	A	A
371	309	B	B
372	309	C	C
373	309	F	F
374	310	A	A
375	310	B	B
376	310	C	C
377	310	H	H
378	311	A	A
379	311	B	B
380	311	C	C
381	311	D	D
382	312	A	A
383	312	B	B
384	312	C	C
385	312	D	D
386	313	A	A
387	313	B	B
388	313	C	C
389	313	D	D
390	314	A	A
391	314	B	B
392	314	C	C
393	314	D	D
394	315	YES	YES
395	315	NO	NO
396	315	NOT GIVEN	NOT GIVEN
397	316	YES	YES
398	316	NO	NO
399	316	NOT GIVEN	NOT GIVEN
400	317	YES	YES
401	317	NO	NO
402	317	NOT GIVEN	NOT GIVEN
403	318	YES	YES
404	318	NO	NO
405	318	NOT GIVEN	NOT GIVEN
406	319	YES	YES
407	319	NO	NO
408	319	NOT GIVEN	NOT GIVEN
409	320	A	A
410	320	B	B
411	320	C	C
412	320	D	D
413	361	A	TRUE
414	361	B	FALSE
415	361	C	NOT GIVEN
416	362	A	TRUE
417	362	B	FALSE
418	362	C	NOT GIVEN
419	363	A	TRUE
420	363	B	FALSE
421	363	C	NOT GIVEN
422	364	A	TRUE
423	364	B	FALSE
424	364	C	NOT GIVEN
425	365	A	TRUE
426	365	B	FALSE
427	365	C	NOT GIVEN
428	366	A	TRUE
429	366	B	FALSE
430	366	C	NOT GIVEN
431	367	A	TRUE
432	367	B	FALSE
433	367	C	NOT GIVEN
434	441	A	TRUE
435	441	B	FALSE
436	441	C	NOT GIVEN
437	442	A	TRUE
438	442	B	FALSE
439	442	C	NOT GIVEN
440	443	A	TRUE
441	443	B	FALSE
442	443	C	NOT GIVEN
443	444	A	TRUE
444	444	B	FALSE
445	444	C	NOT GIVEN
446	445	A	TRUE
447	445	B	FALSE
448	445	C	NOT GIVEN
449	446	A	TRUE
450	446	B	FALSE
451	446	C	NOT GIVEN
452	447	A	TRUE
453	447	B	FALSE
454	447	C	NOT GIVEN
455	521	A	TRUE
456	521	B	FALSE
457	521	C	NOT GIVEN
458	522	A	TRUE
459	522	B	FALSE
460	522	C	NOT GIVEN
461	523	A	TRUE
462	523	B	FALSE
463	523	C	NOT GIVEN
464	524	A	TRUE
465	524	B	FALSE
466	524	C	NOT GIVEN
467	525	A	TRUE
468	525	B	FALSE
469	525	C	NOT GIVEN
470	526	A	TRUE
471	526	B	FALSE
472	526	C	NOT GIVEN
473	527	A	TRUE
474	527	B	FALSE
475	527	C	NOT GIVEN
476	601	A	TRUE
477	601	B	FALSE
478	601	C	NOT GIVEN
479	602	A	TRUE
480	602	B	FALSE
481	602	C	NOT GIVEN
482	603	A	TRUE
483	603	B	FALSE
484	603	C	NOT GIVEN
485	604	A	TRUE
486	604	B	FALSE
487	604	C	NOT GIVEN
488	605	A	TRUE
489	605	B	FALSE
490	605	C	NOT GIVEN
491	606	A	TRUE
492	606	B	FALSE
493	606	C	NOT GIVEN
494	607	A	TRUE
495	607	B	FALSE
496	607	C	NOT GIVEN
497	681	A	TRUE
498	681	B	FALSE
499	681	C	NOT GIVEN
500	682	A	TRUE
501	682	B	FALSE
502	682	C	NOT GIVEN
503	683	A	TRUE
504	683	B	FALSE
505	683	C	NOT GIVEN
506	684	A	TRUE
507	684	B	FALSE
508	684	C	NOT GIVEN
509	685	A	TRUE
510	685	B	FALSE
511	685	C	NOT GIVEN
512	686	A	TRUE
513	686	B	FALSE
514	686	C	NOT GIVEN
515	687	A	TRUE
516	687	B	FALSE
517	687	C	NOT GIVEN
518	761	A	TRUE
519	761	B	FALSE
520	761	C	NOT GIVEN
521	762	A	TRUE
522	762	B	FALSE
523	762	C	NOT GIVEN
524	763	A	TRUE
525	763	B	FALSE
526	763	C	NOT GIVEN
527	764	A	TRUE
528	764	B	FALSE
529	764	C	NOT GIVEN
530	765	A	TRUE
531	765	B	FALSE
532	765	C	NOT GIVEN
533	766	A	TRUE
534	766	B	FALSE
535	766	C	NOT GIVEN
536	767	A	TRUE
537	767	B	FALSE
538	767	C	NOT GIVEN
539	841	A	TRUE
540	841	B	FALSE
541	841	C	NOT GIVEN
542	842	A	TRUE
543	842	B	FALSE
544	842	C	NOT GIVEN
545	843	A	TRUE
546	843	B	FALSE
547	843	C	NOT GIVEN
548	844	A	TRUE
549	844	B	FALSE
550	844	C	NOT GIVEN
551	845	A	TRUE
552	845	B	FALSE
553	845	C	NOT GIVEN
554	846	A	TRUE
555	846	B	FALSE
556	846	C	NOT GIVEN
557	847	A	TRUE
558	847	B	FALSE
559	847	C	NOT GIVEN
560	921	A	TRUE
561	921	B	FALSE
562	921	C	NOT GIVEN
563	922	A	TRUE
564	922	B	FALSE
565	922	C	NOT GIVEN
566	923	A	TRUE
567	923	B	FALSE
568	923	C	NOT GIVEN
569	924	A	TRUE
570	924	B	FALSE
571	924	C	NOT GIVEN
572	925	A	TRUE
573	925	B	FALSE
574	925	C	NOT GIVEN
575	926	A	TRUE
576	926	B	FALSE
577	926	C	NOT GIVEN
578	927	A	TRUE
579	927	B	FALSE
580	927	C	NOT GIVEN
581	1001	A	TRUE
582	1001	B	FALSE
583	1001	C	NOT GIVEN
584	1002	A	TRUE
585	1002	B	FALSE
586	1002	C	NOT GIVEN
587	1003	A	TRUE
588	1003	B	FALSE
589	1003	C	NOT GIVEN
590	1004	A	TRUE
591	1004	B	FALSE
592	1004	C	NOT GIVEN
593	1005	A	TRUE
594	1005	B	FALSE
595	1005	C	NOT GIVEN
596	1006	A	TRUE
597	1006	B	FALSE
598	1006	C	NOT GIVEN
599	1007	A	TRUE
600	1007	B	FALSE
601	1007	C	NOT GIVEN
602	1081	A	TRUE
603	1081	B	FALSE
604	1081	C	NOT GIVEN
605	1082	A	TRUE
606	1082	B	FALSE
607	1082	C	NOT GIVEN
608	1083	A	TRUE
609	1083	B	FALSE
610	1083	C	NOT GIVEN
611	1084	A	TRUE
612	1084	B	FALSE
613	1084	C	NOT GIVEN
614	1085	A	TRUE
615	1085	B	FALSE
616	1085	C	NOT GIVEN
617	1086	A	TRUE
618	1086	B	FALSE
619	1086	C	NOT GIVEN
620	1087	A	TRUE
621	1087	B	FALSE
622	1087	C	NOT GIVEN
623	1161	A	TRUE
624	1161	B	FALSE
625	1161	C	NOT GIVEN
626	1162	A	TRUE
627	1162	B	FALSE
628	1162	C	NOT GIVEN
629	1163	A	TRUE
630	1163	B	FALSE
631	1163	C	NOT GIVEN
632	1164	A	TRUE
633	1164	B	FALSE
634	1164	C	NOT GIVEN
635	1165	A	TRUE
636	1165	B	FALSE
637	1165	C	NOT GIVEN
638	1166	A	TRUE
639	1166	B	FALSE
640	1166	C	NOT GIVEN
641	1167	A	TRUE
642	1167	B	FALSE
643	1167	C	NOT GIVEN
644	1241	A	TRUE
645	1241	B	FALSE
646	1241	C	NOT GIVEN
647	1242	A	TRUE
648	1242	B	FALSE
649	1242	C	NOT GIVEN
650	1243	A	TRUE
651	1243	B	FALSE
652	1243	C	NOT GIVEN
653	1244	A	TRUE
654	1244	B	FALSE
655	1244	C	NOT GIVEN
656	1245	A	TRUE
657	1245	B	FALSE
658	1245	C	NOT GIVEN
659	1246	A	TRUE
660	1246	B	FALSE
661	1246	C	NOT GIVEN
662	1247	A	TRUE
663	1247	B	FALSE
664	1247	C	NOT GIVEN
665	1321	A	TRUE
666	1321	B	FALSE
667	1321	C	NOT GIVEN
668	1322	A	TRUE
669	1322	B	FALSE
670	1322	C	NOT GIVEN
671	1323	A	TRUE
672	1323	B	FALSE
673	1323	C	NOT GIVEN
674	1324	A	TRUE
675	1324	B	FALSE
676	1324	C	NOT GIVEN
677	1325	A	TRUE
678	1325	B	FALSE
679	1325	C	NOT GIVEN
680	1326	A	TRUE
681	1326	B	FALSE
682	1326	C	NOT GIVEN
683	1327	A	TRUE
684	1327	B	FALSE
685	1327	C	NOT GIVEN
686	1401	A	TRUE
687	1401	B	FALSE
688	1401	C	NOT GIVEN
689	1402	A	TRUE
690	1402	B	FALSE
691	1402	C	NOT GIVEN
692	1403	A	TRUE
693	1403	B	FALSE
694	1403	C	NOT GIVEN
695	1404	A	TRUE
696	1404	B	FALSE
697	1404	C	NOT GIVEN
698	1405	A	TRUE
699	1405	B	FALSE
700	1405	C	NOT GIVEN
701	1406	A	TRUE
702	1406	B	FALSE
703	1406	C	NOT GIVEN
704	1407	A	TRUE
705	1407	B	FALSE
706	1407	C	NOT GIVEN
707	1481	A	TRUE
708	1481	B	FALSE
709	1481	C	NOT GIVEN
710	1482	A	TRUE
711	1482	B	FALSE
712	1482	C	NOT GIVEN
713	1483	A	TRUE
714	1483	B	FALSE
715	1483	C	NOT GIVEN
716	1484	A	TRUE
717	1484	B	FALSE
718	1484	C	NOT GIVEN
719	1485	A	TRUE
720	1485	B	FALSE
721	1485	C	NOT GIVEN
722	1486	A	TRUE
723	1486	B	FALSE
724	1486	C	NOT GIVEN
725	1487	A	TRUE
726	1487	B	FALSE
727	1487	C	NOT GIVEN
728	1561	A	TRUE
729	1561	B	FALSE
730	1561	C	NOT GIVEN
731	1562	A	TRUE
732	1562	B	FALSE
733	1562	C	NOT GIVEN
734	1563	A	TRUE
735	1563	B	FALSE
736	1563	C	NOT GIVEN
737	1564	A	TRUE
738	1564	B	FALSE
739	1564	C	NOT GIVEN
740	1565	A	TRUE
741	1565	B	FALSE
742	1565	C	NOT GIVEN
743	1566	A	TRUE
744	1566	B	FALSE
745	1566	C	NOT GIVEN
746	1567	A	TRUE
747	1567	B	FALSE
748	1567	C	NOT GIVEN
749	1641	A	TRUE
750	1641	B	FALSE
751	1641	C	NOT GIVEN
752	1642	A	TRUE
753	1642	B	FALSE
754	1642	C	NOT GIVEN
755	1643	A	TRUE
756	1643	B	FALSE
757	1643	C	NOT GIVEN
758	1644	A	TRUE
759	1644	B	FALSE
760	1644	C	NOT GIVEN
761	1645	A	TRUE
762	1645	B	FALSE
763	1645	C	NOT GIVEN
764	1646	A	TRUE
765	1646	B	FALSE
766	1646	C	NOT GIVEN
767	1647	A	TRUE
768	1647	B	FALSE
769	1647	C	NOT GIVEN
770	1721	A	TRUE
771	1721	B	FALSE
772	1721	C	NOT GIVEN
773	1722	A	TRUE
774	1722	B	FALSE
775	1722	C	NOT GIVEN
776	1723	A	TRUE
777	1723	B	FALSE
778	1723	C	NOT GIVEN
779	1724	A	TRUE
780	1724	B	FALSE
781	1724	C	NOT GIVEN
782	1725	A	TRUE
783	1725	B	FALSE
784	1725	C	NOT GIVEN
785	1726	A	TRUE
786	1726	B	FALSE
787	1726	C	NOT GIVEN
788	1727	A	TRUE
789	1727	B	FALSE
790	1727	C	NOT GIVEN
791	1801	A	TRUE
792	1801	B	FALSE
793	1801	C	NOT GIVEN
794	1802	A	TRUE
795	1802	B	FALSE
796	1802	C	NOT GIVEN
797	1803	A	TRUE
798	1803	B	FALSE
799	1803	C	NOT GIVEN
800	1804	A	TRUE
801	1804	B	FALSE
802	1804	C	NOT GIVEN
803	1805	A	TRUE
804	1805	B	FALSE
805	1805	C	NOT GIVEN
806	1806	A	TRUE
807	1806	B	FALSE
808	1806	C	NOT GIVEN
809	1807	A	TRUE
810	1807	B	FALSE
811	1807	C	NOT GIVEN
812	1881	A	TRUE
813	1881	B	FALSE
814	1881	C	NOT GIVEN
815	1882	A	TRUE
816	1882	B	FALSE
817	1882	C	NOT GIVEN
818	1883	A	TRUE
819	1883	B	FALSE
820	1883	C	NOT GIVEN
821	1884	A	TRUE
822	1884	B	FALSE
823	1884	C	NOT GIVEN
824	1885	A	TRUE
825	1885	B	FALSE
826	1885	C	NOT GIVEN
827	1886	A	TRUE
828	1886	B	FALSE
829	1886	C	NOT GIVEN
830	1887	A	TRUE
831	1887	B	FALSE
832	1887	C	NOT GIVEN
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.questions (id, group_id, question_number, prompt_text, audio_start_sec, audio_end_sec, page_reference) FROM stdin;
1	1	1	Bankside Recruitment Agency: Name of agent: Becky 1 ...	\N	\N	10
2	1	2	Phone number: 07866 510333. Best to call her in the 2 ...	\N	\N	10
3	1	3	Typical jobs: Clerical and admin roles, mainly in the finance industry. Must have good 3 ... skills	\N	\N	10
4	1	4	Jobs are usually for at least one 4 ...	\N	\N	10
5	1	5	Pay is usually 5 £ ... per hour	\N	\N	10
6	1	6	Registration process: Wear a 6 ... to the interview	\N	\N	10
7	1	7	Must bring your 7 ... to the interview	\N	\N	10
8	1	8	They will ask questions about each applicant's 8 ...	\N	\N	10
9	1	9	Advantages of using an agency: The 9 ... you receive at interview will benefit you	\N	\N	10
10	1	10	Will get access to vacancies which are not advertised. Less 10 ... is involved in applying for jobs	\N	\N	10
11	2	11	According to the speaker, the company	\N	\N	11
12	2	12	Where can customers meet the tour manager before travelling to the Isle of Man?	\N	\N	11
13	2	13	How many lunches are included in the price of the holiday?	\N	\N	11
14	2	14	Customers have to pay extra for	\N	\N	11
15	3	15	Day 1 Arrive: Hotel dining room has view of the 15 ...	\N	\N	12
16	3	16	Day 2 Tynwald Exhibition and Peel: Tynwald may have been founded in 16 ... not 979.	\N	\N	12
17	3	17	Day 3 Trip to Snaefell: Travel along promenade in a tram; train to Laxey; train to the 17 ... of Snaefell	\N	\N	12
18	3	18	Day 4 Free day: Company provides a 18 ... for local transport and heritage sites.	\N	\N	12
19	3	19	Day 5 Take the 19 ... railway train from Douglas to Port Erin	\N	\N	12
20	3	20	Day 5 Free time, then coach to Castletown - former 20 ... has old castle.	\N	\N	12
21	4	21	the eldest child	\N	\N	13
22	4	22	a middle child	\N	\N	13
23	4	23	the youngest child	\N	\N	13
24	4	24	a twin	\N	\N	13
25	4	25	an only child	\N	\N	13
26	4	26	a child with much older siblings	\N	\N	13
27	5	27	What do the speakers say about the evidence relating to birth order and academic success?	\N	\N	14
28	5	28	What does Ruth think is surprising about the difference in oldest children's academic performance?	\N	\N	14
29	6	29	Which TWO experiences of sibling rivalry do the speakers agree has been valuable for them? (Choice 1)	\N	\N	14
30	6	30	Which TWO experiences of sibling rivalry do the speakers agree has been valuable for them? (Choice 2)	\N	\N	14
31	7	31	Importance: it provides 31 ... and food for a wide range of species	\N	\N	15
32	7	32	its leaves provide 32 ... which is used to make a disinfectant	\N	\N	15
33	7	33	Diseases (Mundulla Yellows): Cause - lime used for making 33 ... was absorbed	\N	\N	15
34	7	34	Bell-miner Associated Die-back: Cause - 34 ... feed on eucalyptus leaves	\N	\N	15
35	7	35	Bushfires (William Jackson's theory): high-frequency bushfires have impact on vegetation, resulting in the growth of 35 ...	\N	\N	15
36	7	36	mid-frequency bushfires result in the growth of eucalyptus forests, because they: make more 36 ... available to the trees	\N	\N	15
37	7	37	maintain the quality of the 37 ...	\N	\N	15
38	7	38	low-frequency bushfires result in the growth of 38 '... rainforest'	\N	\N	15
39	7	39	which is: a 39 ... ecosystem	\N	\N	15
40	7	40	an ideal environment for the 40 ... of the bell-miner	\N	\N	15
41	8	1	the leaves of the tree are 1 ... in shape	\N	\N	18
42	8	2	the 2 ... surrounds the fruit and breaks open when the fruit is ripe	\N	\N	18
43	8	3	the 3 ... is used to produce the spice nutmeg	\N	\N	18
44	8	4	the covering known as the aril is used to produce 4 ...	\N	\N	18
45	9	5	In the Middle Ages, most Europeans knew where nutmeg was grown.	\N	\N	18
46	9	6	The VOC was the world's first major trading company.	\N	\N	18
47	9	7	Following the Treaty of Breda, the Dutch had control of all the islands where nutmeg grew.	\N	\N	18
48	10	8	Middle Ages: Nutmeg was brought to Europe by the 8 ...	\N	\N	19
49	10	9	17th century: Demand for nutmeg grew, as it was believed to be effective against the disease known as the 9 ...	\N	\N	19
50	10	10	The Dutch put 10 ... on nutmeg to avoid it being cultivated outside the islands	\N	\N	19
51	10	11	The Dutch finally obtained the island of 11 ... from the British	\N	\N	19
52	10	12	Late 18th century: 1770 - nutmeg plants were secretly taken to 12 ...	\N	\N	19
53	10	13	1778 - half the Banda Islands' nutmeg plantations were destroyed by a 13 ...	\N	\N	19
54	11	14	reference to the amount of time when a car is not in use	\N	\N	22
55	11	15	mention of several advantages of driverless vehicles for individual road-users	\N	\N	22
56	11	16	reference to the opportunity of choosing the most appropriate vehicle for each trip	\N	\N	22
57	11	17	an estimate of how long it will take to overcome a number of problems	\N	\N	22
58	11	18	a suggestion that the use of driverless cars may have no effect on the number of vehicles on the road	\N	\N	22
59	12	19	Figures have shown that driverless cars could decrease road accidents caused by 19 ...	\N	\N	23
60	12	20	Schemes involving 20 ... could lead to greater flexibility and lower costs for drivers.	\N	\N	23
61	12	21	This would mean that vehicle 21 ... would not be required for mobility.	\N	\N	23
62	12	22	However, there may also be an increase in total 22 ... driven per year.	\N	\N	23
63	13	23	Which TWO benefits of automated transport are mentioned? (Choice 1)	\N	\N	24
64	13	24	Which TWO benefits of automated transport are mentioned? (Choice 2)	\N	\N	24
65	14	25	Which TWO challenges to driverless cars are discussed? (Choice 1)	\N	\N	24
66	14	26	Which TWO challenges to driverless cars are discussed? (Choice 2)	\N	\N	24
67	15	27	The writer refers to a travel survey in order to	\N	\N	28
68	15	28	The writer mentions the Amazon basin in paragraph 2 to illustrate the idea that	\N	\N	28
69	15	29	What is the writer's attitude towards the definition of exploration proposed by Robin Hanbury-Tenison?	\N	\N	28
70	15	30	The writer refers to the deep sea and the desert to show that	\N	\N	28
71	15	31	What does the writer suggest about 'Golden Age' explorers?	\N	\N	28
182	37	22	Font and 22 ...	\N	\N	\N
72	16	32	He explains the value of exploring a single location in great detail.	\N	\N	29
73	16	33	He describes how exploration led to a change in his philosophical outlook.	\N	\N	29
74	16	34	He suggests that our instinct to explore is rooted in our evolutionary history.	\N	\N	29
75	16	35	He believes that the desire to travel and explore is common to all humans.	\N	\N	29
76	16	36	He argues that modern explorers should focus on interpreting rather than just documenting.	\N	\N	29
77	16	37	He mentions having mixed feelings about the impact of his journey on a local community.	\N	\N	29
78	17	38	The writer suggests that instead of seeking 38 ... expeditions, we should recognize that every journey has value.	\N	\N	29
79	17	39	Even in an era when no part of the earth remains completely 39 ...	\N	\N	29
80	17	40	We still only know a fraction of the earth's 40 ...	\N	\N	29
81	18	1	Festival information: Contact name: 1 ...	\N	\N	31
82	18	2	Website feedback: Need to write a 2 ...	\N	\N	31
83	18	3	Live event: Special 3 ... show at evening	\N	\N	31
84	18	4	Online room: Join the 4 ... session	\N	\N	31
85	18	5	Food stall focus: 5 ... options	\N	\N	31
86	18	6	Advertising: Distribute 6 ... in local shops	\N	\N	31
87	18	7	Workshop material: Bring pieces of 7 ...	\N	\N	31
88	18	8	Location: Meet near the 8 ...	\N	\N	31
89	18	9	Nature walk: Learn about local 9 ...	\N	\N	31
90	18	10	Follow updates on our 10 ...	\N	\N	31
91	19	11	Minster Park volunteering options: Question 11	\N	\N	32
92	19	12	Minster Park volunteering options: Question 12	\N	\N	32
93	19	13	Minster Park volunteering options: Question 13	\N	\N	32
94	19	14	Minster Park volunteering options: Question 14	\N	\N	32
95	20	15	Statue location	\N	\N	33
96	20	16	Cafe location	\N	\N	33
97	20	17	Children's playground	\N	\N	33
98	20	18	Rose garden	\N	\N	33
99	20	19	Pavilion	\N	\N	33
100	20	20	Wildlife pond	\N	\N	33
101	21	21	Which TWO topics did the students agree to include? (Choice 1)	\N	\N	34
102	21	22	Which TWO topics did the students agree to include? (Choice 2)	\N	\N	34
103	22	23	Which TWO difficulties did they experience during field research? (Choice 1)	\N	\N	34
104	22	24	Which TWO difficulties did they experience during field research? (Choice 2)	\N	\N	34
105	23	25	Background research	\N	\N	35
106	23	26	Methodology	\N	\N	35
107	23	27	Data analysis	\N	\N	35
108	23	28	Discussion	\N	\N	35
109	23	29	Conclusion	\N	\N	35
110	23	30	Questions from audience	\N	\N	35
111	24	31	Agricultural developments: Systems for 31 ...	\N	\N	36
112	24	32	Role of 32 ... in community farming	\N	\N	36
113	24	33	Protected by 33 ... fences	\N	\N	36
114	24	34	Storage of 34 ... for future planting	\N	\N	36
115	24	35	Supported by strong 35 ... in soil	\N	\N	36
116	24	36	Improvement of rural 36 ... networks	\N	\N	36
117	24	37	Methods for crop 37 ...	\N	\N	36
118	24	38	Farming along with raising 38 ...	\N	\N	36
119	24	39	Attracting beneficial 39 ... for pollination	\N	\N	36
120	24	40	New equipment 40 ... adapted for terrain	\N	\N	36
121	25	1	Paragraph info 1	\N	\N	\N
122	25	2	Paragraph info 2	\N	\N	\N
123	25	3	Paragraph info 3	\N	\N	\N
124	25	4	Paragraph info 4	\N	\N	\N
125	25	5	Paragraph info 5	\N	\N	\N
126	25	6	Paragraph info 6	\N	\N	\N
127	26	7	Pedestrian 7 ... is improved	\N	\N	\N
128	26	8	Reducing street 8 ...	\N	\N	\N
129	26	9	Widening the 9 ...	\N	\N	\N
130	26	10	App for 10 ... devices	\N	\N	\N
131	26	11	Avoid 11 ... crossings	\N	\N	\N
132	26	12	Better for local 12 ...	\N	\N	\N
133	26	13	Promote 13 ... lifestyles	\N	\N	\N
134	27	14	Section info 14	\N	\N	\N
135	27	15	Section info 15	\N	\N	\N
136	27	16	Section info 16	\N	\N	\N
137	27	17	Section info 17	\N	\N	\N
138	28	18	Identify specific 18 ...	\N	\N	\N
139	28	19	Mammoths prevented 19 ...	\N	\N	\N
140	28	20	Smaller 20 ... to survive cold	\N	\N	\N
141	28	21	Thick layer of 21 ...	\N	\N	\N
142	28	22	Reduction of 22 ... from permafrost	\N	\N	44
143	29	23	Question 23	\N	\N	\N
144	29	24	Question 24	\N	\N	\N
145	29	25	Question 25	\N	\N	\N
146	29	26	Question 26	\N	\N	\N
147	30	27	Question 27	\N	\N	\N
148	30	28	Question 28	\N	\N	\N
149	30	29	Question 29	\N	\N	\N
150	30	30	Question 30	\N	\N	\N
151	31	31	Research statement 31	\N	\N	\N
152	31	32	Research statement 32	\N	\N	\N
153	31	33	Research statement 33	\N	\N	\N
154	31	34	Research statement 34	\N	\N	\N
155	31	35	Research statement 35	\N	\N	\N
156	31	36	Research statement 36	\N	\N	\N
157	32	37	Statement 37	\N	\N	\N
158	32	38	Statement 38	\N	\N	\N
159	32	39	Statement 39	\N	\N	\N
160	32	40	Statement 40	\N	\N	\N
161	33	1	Employment agency: office 1 ...	\N	\N	\N
162	33	2	Schedule 2 ...	\N	\N	\N
163	33	3	Keep personal 3 ...	\N	\N	\N
164	33	4	Pay attention to 4 ...	\N	\N	\N
165	33	5	Contract length: 5 ...	\N	\N	\N
166	33	6	Manage postal 6 ...	\N	\N	\N
167	33	7	Keep desk 7 ...	\N	\N	\N
168	33	8	Work in small 8 ...	\N	\N	\N
169	33	9	Lifting 9 ... equipment	\N	\N	\N
170	33	10	Provide good 10 ... service	\N	\N	\N
171	34	11	Question 11	\N	\N	\N
172	34	12	Question 12	\N	\N	\N
173	34	13	Question 13	\N	\N	\N
174	34	14	Question 14	\N	\N	\N
175	34	15	Question 15	\N	\N	\N
176	34	16	Question 16	\N	\N	\N
177	35	17	Choice 1 (17-18)	\N	\N	\N
178	35	18	Choice 2 (17-18)	\N	\N	\N
179	36	19	Choice 1 (19-20)	\N	\N	\N
180	36	20	Choice 2 (19-20)	\N	\N	\N
181	37	21	Design step 21 ...	\N	\N	\N
183	37	23	Include clear 23 ...	\N	\N	\N
184	37	24	Check overall 24 ...	\N	\N	\N
185	37	25	State the primary 25 ...	\N	\N	\N
186	37	26	Question your 26 ...	\N	\N	\N
187	38	27	Question 27	\N	\N	\N
188	38	28	Question 28	\N	\N	\N
189	38	29	Question 29	\N	\N	\N
190	38	30	Question 30	\N	\N	\N
191	39	31	Building materials: mixed with 31 ...	\N	\N	\N
192	39	32	Baked 32 ... bricks	\N	\N	\N
193	39	33	Decorated with 33 ... sheets	\N	\N	\N
194	39	34	Animal 34 ... in plaster	\N	\N	\N
195	39	35	Communal 35 ... facilities	\N	\N	\N
196	39	36	Preventing the spread of 36 ...	\N	\N	\N
197	39	37	Trade in luxury 37 ...	\N	\N	\N
198	39	38	Tax on traded 38 ...	\N	\N	\N
199	39	39	Advancements in ancient 39 ...	\N	\N	\N
200	39	40	Subject to local 40 ...	\N	\N	\N
201	40	1	Statement 1	\N	\N	\N
202	40	2	Statement 2	\N	\N	\N
203	40	3	Statement 3	\N	\N	\N
204	40	4	Statement 4	\N	\N	\N
205	40	5	Statement 5	\N	\N	\N
206	40	6	Statement 6	\N	\N	\N
207	40	7	Statement 7	\N	\N	\N
208	41	8	Submitted his letter of 8 ...	\N	\N	\N
209	41	9	Used organic 9 ...	\N	\N	\N
210	41	10	Sketched underground coal 10 ...	\N	\N	\N
211	41	11	Sculptures of a mother and 11 ...	\N	\N	\N
212	41	12	Acquired by private 12 ...	\N	\N	\N
213	41	13	Donated parts of his 13 ...	\N	\N	\N
214	42	14	Section A	\N	\N	\N
215	42	15	Section B	\N	\N	\N
216	42	16	Section C	\N	\N	\N
217	42	17	Section D	\N	\N	\N
218	42	18	Section E	\N	\N	\N
219	42	19	Section F	\N	\N	\N
220	42	20	Section G	\N	\N	\N
221	43	21	Fitted with rubber 21 ...	\N	\N	\N
222	43	22	Protective surface 22 ...	\N	\N	\N
223	43	23	Integrated water 23 ...	\N	\N	\N
224	43	24	Removal of organic 24 ...	\N	\N	\N
225	43	25	Maximize overall 25 ...	\N	\N	\N
226	43	26	Regular maintenance and 26 ...	\N	\N	\N
227	44	27	Question 27	\N	\N	\N
228	44	28	Question 28	\N	\N	\N
229	44	29	Question 29	\N	\N	\N
230	44	30	Question 30	\N	\N	\N
231	45	31	Expert statement 31	\N	\N	\N
232	45	32	Expert statement 32	\N	\N	\N
233	45	33	Expert statement 33	\N	\N	\N
234	45	34	Expert statement 34	\N	\N	\N
235	45	35	Expert statement 35	\N	\N	\N
236	45	36	Expert statement 36	\N	\N	\N
237	46	37	Question 37	\N	\N	\N
238	46	38	Question 38	\N	\N	\N
239	46	39	Question 39	\N	\N	\N
240	46	40	Question 40	\N	\N	\N
241	47	1	Customer enquiry: Occupation: 1 ...	\N	\N	\N
242	47	2	Purpose of travel: Weekend 2 ...	\N	\N	\N
243	47	3	Town destination: 3 ...	\N	\N	\N
244	47	4	Ticket type: Standard 4 ...	\N	\N	\N
245	47	5	Total fare: £ 5 ...	\N	\N	\N
246	47	6	Booking method: Booked 6 ...	\N	\N	\N
247	47	7	Possible train 7 ...	\N	\N	\N
248	47	8	Customer service 8 ... desk	\N	\N	\N
249	47	9	Wait at 9 ... 3	\N	\N	\N
250	47	10	Free station 10 ... available	\N	\N	\N
251	48	11	Question 11	\N	\N	\N
252	48	12	Question 12	\N	\N	\N
253	48	13	Question 13	\N	\N	\N
254	48	14	Question 14	\N	\N	\N
255	48	15	Question 15	\N	\N	\N
256	48	16	Question 16	\N	\N	\N
257	49	17	Choice 1 (17-18)	\N	\N	\N
258	49	18	Choice 2 (17-18)	\N	\N	\N
259	50	19	Choice 1 (19-20)	\N	\N	\N
260	50	20	Choice 2 (19-20)	\N	\N	\N
261	51	21	Question 21	\N	\N	\N
262	51	22	Question 22	\N	\N	\N
263	51	23	Question 23	\N	\N	\N
264	51	24	Question 24	\N	\N	\N
265	51	25	Question 25	\N	\N	\N
266	51	26	Question 26	\N	\N	\N
267	51	27	Question 27	\N	\N	\N
268	51	28	Question 28	\N	\N	\N
269	51	29	Question 29	\N	\N	\N
270	51	30	Question 30	\N	\N	\N
271	52	31	Historical factors: Accumulation of 31 ...	\N	\N	\N
272	52	32	Development of new 32 ...	\N	\N	\N
273	52	33	Access to steam 33 ...	\N	\N	\N
274	52	34	Expansion of 34 ... production	\N	\N	\N
275	52	35	Use of automated 35 ...	\N	\N	\N
276	52	36	Circulation of daily 36 ...	\N	\N	\N
277	52	37	Growth of 37 ... businesses	\N	\N	\N
278	52	38	Installation of street 38 ...	\N	\N	\N
279	52	39	Display products in shop 39 ...	\N	\N	\N
280	52	40	Rise of mass 40 ... campaigns	\N	\N	\N
281	53	1	Absorbs deep underground 1 ...	\N	\N	\N
282	53	2	Key part of ancient 2 ...	\N	\N	\N
283	53	3	Protected against prolonged 3 ...	\N	\N	\N
284	53	4	Prevented severe soil 4 ...	\N	\N	\N
285	53	5	Surrounded by dry 5 ...	\N	\N	\N
286	53	6	Cut down the 6 ...	\N	\N	\N
287	53	7	Used both 7 ... for fuel	\N	\N	\N
288	53	8	Carved from the 8 ...	\N	\N	\N
289	54	9	Statement 9	\N	\N	\N
290	54	10	Statement 10	\N	\N	\N
291	54	11	Statement 11	\N	\N	\N
292	54	12	Statement 12	\N	\N	\N
293	54	13	Statement 13	\N	\N	\N
294	55	14	Statement 14	\N	\N	\N
295	55	15	Statement 15	\N	\N	\N
296	55	16	Statement 16	\N	\N	\N
297	55	17	Statement 17	\N	\N	\N
298	55	18	Statement 18	\N	\N	\N
299	55	19	Statement 19	\N	\N	\N
300	56	20	Translating spoken 20 ...	\N	\N	\N
301	56	21	Using a 21 ... inside mouth	\N	\N	\N
302	56	22	Altering sound 22 ...	\N	\N	\N
303	56	23	Transmit clear 23 ... across valleys	\N	\N	\N
304	56	24	Warn of spreading 24 ...	\N	\N	\N
305	56	25	Impact of telephone 25 ...	\N	\N	\N
306	56	26	Received UNESCO 26 ...	\N	\N	\N
307	57	27	Question 27	\N	\N	\N
308	57	28	Question 28	\N	\N	\N
309	57	29	Question 29	\N	\N	\N
310	57	30	Question 30	\N	\N	\N
311	57	31	Question 31	\N	\N	\N
312	57	32	Question 32	\N	\N	\N
313	57	33	Question 33	\N	\N	\N
314	57	34	Question 34	\N	\N	\N
315	58	35	Statement 35	\N	\N	\N
316	58	36	Statement 36	\N	\N	\N
317	58	37	Statement 37	\N	\N	\N
318	58	38	Statement 38	\N	\N	\N
319	58	39	Statement 39	\N	\N	\N
320	59	40	What is the main conclusion of the passage?	\N	\N	\N
321	60	1	Information item for Question 1	\N	\N	\N
322	60	2	Information item for Question 2	\N	\N	\N
323	60	3	Information item for Question 3	\N	\N	\N
324	60	4	Information item for Question 4	\N	\N	\N
325	60	5	Information item for Question 5	\N	\N	\N
326	60	6	Information item for Question 6	\N	\N	\N
327	60	7	Information item for Question 7	\N	\N	\N
328	60	8	Information item for Question 8	\N	\N	\N
329	60	9	Information item for Question 9	\N	\N	\N
330	60	10	Information item for Question 10	\N	\N	\N
331	61	11	Information item for Question 11	\N	\N	\N
332	61	12	Information item for Question 12	\N	\N	\N
333	61	13	Information item for Question 13	\N	\N	\N
334	61	14	Information item for Question 14	\N	\N	\N
335	61	15	Information item for Question 15	\N	\N	\N
336	61	16	Information item for Question 16	\N	\N	\N
337	61	17	Information item for Question 17	\N	\N	\N
338	61	18	Information item for Question 18	\N	\N	\N
339	61	19	Information item for Question 19	\N	\N	\N
340	61	20	Information item for Question 20	\N	\N	\N
341	62	21	Information item for Question 21	\N	\N	\N
342	62	22	Information item for Question 22	\N	\N	\N
343	62	23	Information item for Question 23	\N	\N	\N
344	62	24	Information item for Question 24	\N	\N	\N
345	62	25	Information item for Question 25	\N	\N	\N
346	62	26	Information item for Question 26	\N	\N	\N
347	62	27	Information item for Question 27	\N	\N	\N
348	62	28	Information item for Question 28	\N	\N	\N
349	62	29	Information item for Question 29	\N	\N	\N
350	62	30	Information item for Question 30	\N	\N	\N
351	63	31	Information item for Question 31	\N	\N	\N
352	63	32	Information item for Question 32	\N	\N	\N
353	63	33	Information item for Question 33	\N	\N	\N
354	63	34	Information item for Question 34	\N	\N	\N
355	63	35	Information item for Question 35	\N	\N	\N
356	63	36	Information item for Question 36	\N	\N	\N
357	63	37	Information item for Question 37	\N	\N	\N
358	63	38	Information item for Question 38	\N	\N	\N
359	63	39	Information item for Question 39	\N	\N	\N
360	63	40	Information item for Question 40	\N	\N	\N
361	64	1	Statement for Question 1	\N	\N	\N
362	64	2	Statement for Question 2	\N	\N	\N
363	64	3	Statement for Question 3	\N	\N	\N
364	64	4	Statement for Question 4	\N	\N	\N
365	64	5	Statement for Question 5	\N	\N	\N
366	64	6	Statement for Question 6	\N	\N	\N
367	64	7	Statement for Question 7	\N	\N	\N
368	65	8	Sentence completion for Question 8	\N	\N	\N
369	65	9	Sentence completion for Question 9	\N	\N	\N
370	65	10	Sentence completion for Question 10	\N	\N	\N
371	65	11	Sentence completion for Question 11	\N	\N	\N
372	65	12	Sentence completion for Question 12	\N	\N	\N
373	65	13	Sentence completion for Question 13	\N	\N	\N
374	66	14	Statement for Question 14	\N	\N	\N
375	66	15	Statement for Question 15	\N	\N	\N
376	66	16	Statement for Question 16	\N	\N	\N
377	66	17	Statement for Question 17	\N	\N	\N
378	66	18	Statement for Question 18	\N	\N	\N
379	66	19	Statement for Question 19	\N	\N	\N
380	66	20	Statement for Question 20	\N	\N	\N
381	67	21	Sentence completion for Question 21	\N	\N	\N
382	67	22	Sentence completion for Question 22	\N	\N	\N
383	67	23	Sentence completion for Question 23	\N	\N	\N
384	67	24	Sentence completion for Question 24	\N	\N	\N
385	67	25	Sentence completion for Question 25	\N	\N	\N
386	67	26	Sentence completion for Question 26	\N	\N	\N
387	68	27	Statement for Question 27	\N	\N	\N
388	68	28	Statement for Question 28	\N	\N	\N
389	68	29	Statement for Question 29	\N	\N	\N
390	68	30	Statement for Question 30	\N	\N	\N
391	68	31	Statement for Question 31	\N	\N	\N
392	68	32	Statement for Question 32	\N	\N	\N
393	68	33	Statement for Question 33	\N	\N	\N
394	69	34	Sentence completion for Question 34	\N	\N	\N
395	69	35	Sentence completion for Question 35	\N	\N	\N
396	69	36	Sentence completion for Question 36	\N	\N	\N
397	69	37	Sentence completion for Question 37	\N	\N	\N
398	69	38	Sentence completion for Question 38	\N	\N	\N
399	69	39	Sentence completion for Question 39	\N	\N	\N
400	69	40	Sentence completion for Question 40	\N	\N	\N
401	70	1	Information item for Question 1	\N	\N	\N
402	70	2	Information item for Question 2	\N	\N	\N
403	70	3	Information item for Question 3	\N	\N	\N
404	70	4	Information item for Question 4	\N	\N	\N
405	70	5	Information item for Question 5	\N	\N	\N
406	70	6	Information item for Question 6	\N	\N	\N
407	70	7	Information item for Question 7	\N	\N	\N
408	70	8	Information item for Question 8	\N	\N	\N
409	70	9	Information item for Question 9	\N	\N	\N
410	70	10	Information item for Question 10	\N	\N	\N
411	71	11	Information item for Question 11	\N	\N	\N
412	71	12	Information item for Question 12	\N	\N	\N
413	71	13	Information item for Question 13	\N	\N	\N
414	71	14	Information item for Question 14	\N	\N	\N
415	71	15	Information item for Question 15	\N	\N	\N
416	71	16	Information item for Question 16	\N	\N	\N
417	71	17	Information item for Question 17	\N	\N	\N
418	71	18	Information item for Question 18	\N	\N	\N
419	71	19	Information item for Question 19	\N	\N	\N
420	71	20	Information item for Question 20	\N	\N	\N
421	72	21	Information item for Question 21	\N	\N	\N
422	72	22	Information item for Question 22	\N	\N	\N
423	72	23	Information item for Question 23	\N	\N	\N
424	72	24	Information item for Question 24	\N	\N	\N
425	72	25	Information item for Question 25	\N	\N	\N
426	72	26	Information item for Question 26	\N	\N	\N
427	72	27	Information item for Question 27	\N	\N	\N
428	72	28	Information item for Question 28	\N	\N	\N
429	72	29	Information item for Question 29	\N	\N	\N
430	72	30	Information item for Question 30	\N	\N	\N
431	73	31	Information item for Question 31	\N	\N	\N
432	73	32	Information item for Question 32	\N	\N	\N
433	73	33	Information item for Question 33	\N	\N	\N
434	73	34	Information item for Question 34	\N	\N	\N
435	73	35	Information item for Question 35	\N	\N	\N
436	73	36	Information item for Question 36	\N	\N	\N
437	73	37	Information item for Question 37	\N	\N	\N
438	73	38	Information item for Question 38	\N	\N	\N
439	73	39	Information item for Question 39	\N	\N	\N
440	73	40	Information item for Question 40	\N	\N	\N
441	74	1	Statement for Question 1	\N	\N	\N
442	74	2	Statement for Question 2	\N	\N	\N
443	74	3	Statement for Question 3	\N	\N	\N
444	74	4	Statement for Question 4	\N	\N	\N
445	74	5	Statement for Question 5	\N	\N	\N
446	74	6	Statement for Question 6	\N	\N	\N
447	74	7	Statement for Question 7	\N	\N	\N
448	75	8	Sentence completion for Question 8	\N	\N	\N
449	75	9	Sentence completion for Question 9	\N	\N	\N
450	75	10	Sentence completion for Question 10	\N	\N	\N
451	75	11	Sentence completion for Question 11	\N	\N	\N
452	75	12	Sentence completion for Question 12	\N	\N	\N
453	75	13	Sentence completion for Question 13	\N	\N	\N
454	76	14	Statement for Question 14	\N	\N	\N
455	76	15	Statement for Question 15	\N	\N	\N
456	76	16	Statement for Question 16	\N	\N	\N
457	76	17	Statement for Question 17	\N	\N	\N
458	76	18	Statement for Question 18	\N	\N	\N
459	76	19	Statement for Question 19	\N	\N	\N
460	76	20	Statement for Question 20	\N	\N	\N
461	77	21	Sentence completion for Question 21	\N	\N	\N
462	77	22	Sentence completion for Question 22	\N	\N	\N
463	77	23	Sentence completion for Question 23	\N	\N	\N
464	77	24	Sentence completion for Question 24	\N	\N	\N
465	77	25	Sentence completion for Question 25	\N	\N	\N
466	77	26	Sentence completion for Question 26	\N	\N	\N
467	78	27	Statement for Question 27	\N	\N	\N
468	78	28	Statement for Question 28	\N	\N	\N
469	78	29	Statement for Question 29	\N	\N	\N
470	78	30	Statement for Question 30	\N	\N	\N
471	78	31	Statement for Question 31	\N	\N	\N
472	78	32	Statement for Question 32	\N	\N	\N
473	78	33	Statement for Question 33	\N	\N	\N
474	79	34	Sentence completion for Question 34	\N	\N	\N
475	79	35	Sentence completion for Question 35	\N	\N	\N
476	79	36	Sentence completion for Question 36	\N	\N	\N
477	79	37	Sentence completion for Question 37	\N	\N	\N
478	79	38	Sentence completion for Question 38	\N	\N	\N
479	79	39	Sentence completion for Question 39	\N	\N	\N
480	79	40	Sentence completion for Question 40	\N	\N	\N
481	80	1	Information item for Question 1	\N	\N	\N
482	80	2	Information item for Question 2	\N	\N	\N
483	80	3	Information item for Question 3	\N	\N	\N
484	80	4	Information item for Question 4	\N	\N	\N
485	80	5	Information item for Question 5	\N	\N	\N
486	80	6	Information item for Question 6	\N	\N	\N
487	80	7	Information item for Question 7	\N	\N	\N
488	80	8	Information item for Question 8	\N	\N	\N
489	80	9	Information item for Question 9	\N	\N	\N
490	80	10	Information item for Question 10	\N	\N	\N
491	81	11	Information item for Question 11	\N	\N	\N
492	81	12	Information item for Question 12	\N	\N	\N
493	81	13	Information item for Question 13	\N	\N	\N
494	81	14	Information item for Question 14	\N	\N	\N
495	81	15	Information item for Question 15	\N	\N	\N
496	81	16	Information item for Question 16	\N	\N	\N
497	81	17	Information item for Question 17	\N	\N	\N
498	81	18	Information item for Question 18	\N	\N	\N
499	81	19	Information item for Question 19	\N	\N	\N
500	81	20	Information item for Question 20	\N	\N	\N
501	82	21	Information item for Question 21	\N	\N	\N
502	82	22	Information item for Question 22	\N	\N	\N
503	82	23	Information item for Question 23	\N	\N	\N
504	82	24	Information item for Question 24	\N	\N	\N
505	82	25	Information item for Question 25	\N	\N	\N
506	82	26	Information item for Question 26	\N	\N	\N
507	82	27	Information item for Question 27	\N	\N	\N
508	82	28	Information item for Question 28	\N	\N	\N
509	82	29	Information item for Question 29	\N	\N	\N
510	82	30	Information item for Question 30	\N	\N	\N
511	83	31	Information item for Question 31	\N	\N	\N
512	83	32	Information item for Question 32	\N	\N	\N
513	83	33	Information item for Question 33	\N	\N	\N
514	83	34	Information item for Question 34	\N	\N	\N
515	83	35	Information item for Question 35	\N	\N	\N
516	83	36	Information item for Question 36	\N	\N	\N
517	83	37	Information item for Question 37	\N	\N	\N
518	83	38	Information item for Question 38	\N	\N	\N
519	83	39	Information item for Question 39	\N	\N	\N
520	83	40	Information item for Question 40	\N	\N	\N
521	84	1	Statement for Question 1	\N	\N	\N
522	84	2	Statement for Question 2	\N	\N	\N
523	84	3	Statement for Question 3	\N	\N	\N
524	84	4	Statement for Question 4	\N	\N	\N
525	84	5	Statement for Question 5	\N	\N	\N
526	84	6	Statement for Question 6	\N	\N	\N
527	84	7	Statement for Question 7	\N	\N	\N
528	85	8	Sentence completion for Question 8	\N	\N	\N
529	85	9	Sentence completion for Question 9	\N	\N	\N
530	85	10	Sentence completion for Question 10	\N	\N	\N
531	85	11	Sentence completion for Question 11	\N	\N	\N
532	85	12	Sentence completion for Question 12	\N	\N	\N
533	85	13	Sentence completion for Question 13	\N	\N	\N
534	86	14	Statement for Question 14	\N	\N	\N
535	86	15	Statement for Question 15	\N	\N	\N
536	86	16	Statement for Question 16	\N	\N	\N
537	86	17	Statement for Question 17	\N	\N	\N
538	86	18	Statement for Question 18	\N	\N	\N
539	86	19	Statement for Question 19	\N	\N	\N
540	86	20	Statement for Question 20	\N	\N	\N
541	87	21	Sentence completion for Question 21	\N	\N	\N
542	87	22	Sentence completion for Question 22	\N	\N	\N
543	87	23	Sentence completion for Question 23	\N	\N	\N
544	87	24	Sentence completion for Question 24	\N	\N	\N
545	87	25	Sentence completion for Question 25	\N	\N	\N
546	87	26	Sentence completion for Question 26	\N	\N	\N
547	88	27	Statement for Question 27	\N	\N	\N
548	88	28	Statement for Question 28	\N	\N	\N
549	88	29	Statement for Question 29	\N	\N	\N
550	88	30	Statement for Question 30	\N	\N	\N
551	88	31	Statement for Question 31	\N	\N	\N
552	88	32	Statement for Question 32	\N	\N	\N
553	88	33	Statement for Question 33	\N	\N	\N
554	89	34	Sentence completion for Question 34	\N	\N	\N
555	89	35	Sentence completion for Question 35	\N	\N	\N
556	89	36	Sentence completion for Question 36	\N	\N	\N
557	89	37	Sentence completion for Question 37	\N	\N	\N
558	89	38	Sentence completion for Question 38	\N	\N	\N
559	89	39	Sentence completion for Question 39	\N	\N	\N
560	89	40	Sentence completion for Question 40	\N	\N	\N
561	90	1	Information item for Question 1	\N	\N	\N
562	90	2	Information item for Question 2	\N	\N	\N
563	90	3	Information item for Question 3	\N	\N	\N
564	90	4	Information item for Question 4	\N	\N	\N
565	90	5	Information item for Question 5	\N	\N	\N
566	90	6	Information item for Question 6	\N	\N	\N
567	90	7	Information item for Question 7	\N	\N	\N
568	90	8	Information item for Question 8	\N	\N	\N
569	90	9	Information item for Question 9	\N	\N	\N
570	90	10	Information item for Question 10	\N	\N	\N
571	91	11	Information item for Question 11	\N	\N	\N
572	91	12	Information item for Question 12	\N	\N	\N
573	91	13	Information item for Question 13	\N	\N	\N
574	91	14	Information item for Question 14	\N	\N	\N
575	91	15	Information item for Question 15	\N	\N	\N
576	91	16	Information item for Question 16	\N	\N	\N
577	91	17	Information item for Question 17	\N	\N	\N
578	91	18	Information item for Question 18	\N	\N	\N
579	91	19	Information item for Question 19	\N	\N	\N
580	91	20	Information item for Question 20	\N	\N	\N
581	92	21	Information item for Question 21	\N	\N	\N
582	92	22	Information item for Question 22	\N	\N	\N
583	92	23	Information item for Question 23	\N	\N	\N
584	92	24	Information item for Question 24	\N	\N	\N
585	92	25	Information item for Question 25	\N	\N	\N
586	92	26	Information item for Question 26	\N	\N	\N
587	92	27	Information item for Question 27	\N	\N	\N
588	92	28	Information item for Question 28	\N	\N	\N
589	92	29	Information item for Question 29	\N	\N	\N
590	92	30	Information item for Question 30	\N	\N	\N
591	93	31	Information item for Question 31	\N	\N	\N
592	93	32	Information item for Question 32	\N	\N	\N
593	93	33	Information item for Question 33	\N	\N	\N
594	93	34	Information item for Question 34	\N	\N	\N
595	93	35	Information item for Question 35	\N	\N	\N
596	93	36	Information item for Question 36	\N	\N	\N
597	93	37	Information item for Question 37	\N	\N	\N
598	93	38	Information item for Question 38	\N	\N	\N
599	93	39	Information item for Question 39	\N	\N	\N
600	93	40	Information item for Question 40	\N	\N	\N
601	94	1	Statement for Question 1	\N	\N	\N
602	94	2	Statement for Question 2	\N	\N	\N
603	94	3	Statement for Question 3	\N	\N	\N
604	94	4	Statement for Question 4	\N	\N	\N
605	94	5	Statement for Question 5	\N	\N	\N
606	94	6	Statement for Question 6	\N	\N	\N
607	94	7	Statement for Question 7	\N	\N	\N
608	95	8	Sentence completion for Question 8	\N	\N	\N
609	95	9	Sentence completion for Question 9	\N	\N	\N
610	95	10	Sentence completion for Question 10	\N	\N	\N
611	95	11	Sentence completion for Question 11	\N	\N	\N
612	95	12	Sentence completion for Question 12	\N	\N	\N
613	95	13	Sentence completion for Question 13	\N	\N	\N
614	96	14	Statement for Question 14	\N	\N	\N
615	96	15	Statement for Question 15	\N	\N	\N
616	96	16	Statement for Question 16	\N	\N	\N
617	96	17	Statement for Question 17	\N	\N	\N
618	96	18	Statement for Question 18	\N	\N	\N
619	96	19	Statement for Question 19	\N	\N	\N
620	96	20	Statement for Question 20	\N	\N	\N
621	97	21	Sentence completion for Question 21	\N	\N	\N
622	97	22	Sentence completion for Question 22	\N	\N	\N
623	97	23	Sentence completion for Question 23	\N	\N	\N
624	97	24	Sentence completion for Question 24	\N	\N	\N
625	97	25	Sentence completion for Question 25	\N	\N	\N
626	97	26	Sentence completion for Question 26	\N	\N	\N
627	98	27	Statement for Question 27	\N	\N	\N
628	98	28	Statement for Question 28	\N	\N	\N
629	98	29	Statement for Question 29	\N	\N	\N
630	98	30	Statement for Question 30	\N	\N	\N
631	98	31	Statement for Question 31	\N	\N	\N
632	98	32	Statement for Question 32	\N	\N	\N
633	98	33	Statement for Question 33	\N	\N	\N
634	99	34	Sentence completion for Question 34	\N	\N	\N
635	99	35	Sentence completion for Question 35	\N	\N	\N
636	99	36	Sentence completion for Question 36	\N	\N	\N
637	99	37	Sentence completion for Question 37	\N	\N	\N
638	99	38	Sentence completion for Question 38	\N	\N	\N
639	99	39	Sentence completion for Question 39	\N	\N	\N
640	99	40	Sentence completion for Question 40	\N	\N	\N
641	100	1	Information item for Question 1	\N	\N	\N
642	100	2	Information item for Question 2	\N	\N	\N
643	100	3	Information item for Question 3	\N	\N	\N
644	100	4	Information item for Question 4	\N	\N	\N
645	100	5	Information item for Question 5	\N	\N	\N
646	100	6	Information item for Question 6	\N	\N	\N
647	100	7	Information item for Question 7	\N	\N	\N
648	100	8	Information item for Question 8	\N	\N	\N
649	100	9	Information item for Question 9	\N	\N	\N
650	100	10	Information item for Question 10	\N	\N	\N
651	101	11	Information item for Question 11	\N	\N	\N
652	101	12	Information item for Question 12	\N	\N	\N
653	101	13	Information item for Question 13	\N	\N	\N
654	101	14	Information item for Question 14	\N	\N	\N
655	101	15	Information item for Question 15	\N	\N	\N
656	101	16	Information item for Question 16	\N	\N	\N
657	101	17	Information item for Question 17	\N	\N	\N
658	101	18	Information item for Question 18	\N	\N	\N
659	101	19	Information item for Question 19	\N	\N	\N
660	101	20	Information item for Question 20	\N	\N	\N
661	102	21	Information item for Question 21	\N	\N	\N
662	102	22	Information item for Question 22	\N	\N	\N
663	102	23	Information item for Question 23	\N	\N	\N
664	102	24	Information item for Question 24	\N	\N	\N
665	102	25	Information item for Question 25	\N	\N	\N
666	102	26	Information item for Question 26	\N	\N	\N
667	102	27	Information item for Question 27	\N	\N	\N
668	102	28	Information item for Question 28	\N	\N	\N
669	102	29	Information item for Question 29	\N	\N	\N
670	102	30	Information item for Question 30	\N	\N	\N
671	103	31	Information item for Question 31	\N	\N	\N
672	103	32	Information item for Question 32	\N	\N	\N
673	103	33	Information item for Question 33	\N	\N	\N
674	103	34	Information item for Question 34	\N	\N	\N
675	103	35	Information item for Question 35	\N	\N	\N
676	103	36	Information item for Question 36	\N	\N	\N
677	103	37	Information item for Question 37	\N	\N	\N
678	103	38	Information item for Question 38	\N	\N	\N
679	103	39	Information item for Question 39	\N	\N	\N
680	103	40	Information item for Question 40	\N	\N	\N
681	104	1	Statement for Question 1	\N	\N	\N
682	104	2	Statement for Question 2	\N	\N	\N
683	104	3	Statement for Question 3	\N	\N	\N
684	104	4	Statement for Question 4	\N	\N	\N
685	104	5	Statement for Question 5	\N	\N	\N
686	104	6	Statement for Question 6	\N	\N	\N
687	104	7	Statement for Question 7	\N	\N	\N
688	105	8	Sentence completion for Question 8	\N	\N	\N
689	105	9	Sentence completion for Question 9	\N	\N	\N
690	105	10	Sentence completion for Question 10	\N	\N	\N
691	105	11	Sentence completion for Question 11	\N	\N	\N
692	105	12	Sentence completion for Question 12	\N	\N	\N
693	105	13	Sentence completion for Question 13	\N	\N	\N
694	106	14	Statement for Question 14	\N	\N	\N
695	106	15	Statement for Question 15	\N	\N	\N
696	106	16	Statement for Question 16	\N	\N	\N
697	106	17	Statement for Question 17	\N	\N	\N
698	106	18	Statement for Question 18	\N	\N	\N
699	106	19	Statement for Question 19	\N	\N	\N
700	106	20	Statement for Question 20	\N	\N	\N
701	107	21	Sentence completion for Question 21	\N	\N	\N
702	107	22	Sentence completion for Question 22	\N	\N	\N
703	107	23	Sentence completion for Question 23	\N	\N	\N
704	107	24	Sentence completion for Question 24	\N	\N	\N
705	107	25	Sentence completion for Question 25	\N	\N	\N
706	107	26	Sentence completion for Question 26	\N	\N	\N
707	108	27	Statement for Question 27	\N	\N	\N
708	108	28	Statement for Question 28	\N	\N	\N
709	108	29	Statement for Question 29	\N	\N	\N
710	108	30	Statement for Question 30	\N	\N	\N
711	108	31	Statement for Question 31	\N	\N	\N
712	108	32	Statement for Question 32	\N	\N	\N
713	108	33	Statement for Question 33	\N	\N	\N
714	109	34	Sentence completion for Question 34	\N	\N	\N
715	109	35	Sentence completion for Question 35	\N	\N	\N
716	109	36	Sentence completion for Question 36	\N	\N	\N
717	109	37	Sentence completion for Question 37	\N	\N	\N
718	109	38	Sentence completion for Question 38	\N	\N	\N
719	109	39	Sentence completion for Question 39	\N	\N	\N
720	109	40	Sentence completion for Question 40	\N	\N	\N
721	110	1	Information item for Question 1	\N	\N	\N
722	110	2	Information item for Question 2	\N	\N	\N
723	110	3	Information item for Question 3	\N	\N	\N
724	110	4	Information item for Question 4	\N	\N	\N
725	110	5	Information item for Question 5	\N	\N	\N
726	110	6	Information item for Question 6	\N	\N	\N
727	110	7	Information item for Question 7	\N	\N	\N
728	110	8	Information item for Question 8	\N	\N	\N
729	110	9	Information item for Question 9	\N	\N	\N
730	110	10	Information item for Question 10	\N	\N	\N
731	111	11	Information item for Question 11	\N	\N	\N
732	111	12	Information item for Question 12	\N	\N	\N
733	111	13	Information item for Question 13	\N	\N	\N
734	111	14	Information item for Question 14	\N	\N	\N
735	111	15	Information item for Question 15	\N	\N	\N
736	111	16	Information item for Question 16	\N	\N	\N
737	111	17	Information item for Question 17	\N	\N	\N
738	111	18	Information item for Question 18	\N	\N	\N
739	111	19	Information item for Question 19	\N	\N	\N
740	111	20	Information item for Question 20	\N	\N	\N
741	112	21	Information item for Question 21	\N	\N	\N
742	112	22	Information item for Question 22	\N	\N	\N
743	112	23	Information item for Question 23	\N	\N	\N
744	112	24	Information item for Question 24	\N	\N	\N
745	112	25	Information item for Question 25	\N	\N	\N
746	112	26	Information item for Question 26	\N	\N	\N
747	112	27	Information item for Question 27	\N	\N	\N
748	112	28	Information item for Question 28	\N	\N	\N
749	112	29	Information item for Question 29	\N	\N	\N
750	112	30	Information item for Question 30	\N	\N	\N
751	113	31	Information item for Question 31	\N	\N	\N
752	113	32	Information item for Question 32	\N	\N	\N
753	113	33	Information item for Question 33	\N	\N	\N
754	113	34	Information item for Question 34	\N	\N	\N
755	113	35	Information item for Question 35	\N	\N	\N
756	113	36	Information item for Question 36	\N	\N	\N
757	113	37	Information item for Question 37	\N	\N	\N
758	113	38	Information item for Question 38	\N	\N	\N
759	113	39	Information item for Question 39	\N	\N	\N
760	113	40	Information item for Question 40	\N	\N	\N
761	114	1	Statement for Question 1	\N	\N	\N
762	114	2	Statement for Question 2	\N	\N	\N
763	114	3	Statement for Question 3	\N	\N	\N
764	114	4	Statement for Question 4	\N	\N	\N
765	114	5	Statement for Question 5	\N	\N	\N
766	114	6	Statement for Question 6	\N	\N	\N
767	114	7	Statement for Question 7	\N	\N	\N
768	115	8	Sentence completion for Question 8	\N	\N	\N
769	115	9	Sentence completion for Question 9	\N	\N	\N
770	115	10	Sentence completion for Question 10	\N	\N	\N
771	115	11	Sentence completion for Question 11	\N	\N	\N
772	115	12	Sentence completion for Question 12	\N	\N	\N
773	115	13	Sentence completion for Question 13	\N	\N	\N
774	116	14	Statement for Question 14	\N	\N	\N
775	116	15	Statement for Question 15	\N	\N	\N
776	116	16	Statement for Question 16	\N	\N	\N
777	116	17	Statement for Question 17	\N	\N	\N
778	116	18	Statement for Question 18	\N	\N	\N
779	116	19	Statement for Question 19	\N	\N	\N
780	116	20	Statement for Question 20	\N	\N	\N
781	117	21	Sentence completion for Question 21	\N	\N	\N
782	117	22	Sentence completion for Question 22	\N	\N	\N
783	117	23	Sentence completion for Question 23	\N	\N	\N
784	117	24	Sentence completion for Question 24	\N	\N	\N
785	117	25	Sentence completion for Question 25	\N	\N	\N
786	117	26	Sentence completion for Question 26	\N	\N	\N
787	118	27	Statement for Question 27	\N	\N	\N
788	118	28	Statement for Question 28	\N	\N	\N
789	118	29	Statement for Question 29	\N	\N	\N
790	118	30	Statement for Question 30	\N	\N	\N
791	118	31	Statement for Question 31	\N	\N	\N
792	118	32	Statement for Question 32	\N	\N	\N
793	118	33	Statement for Question 33	\N	\N	\N
794	119	34	Sentence completion for Question 34	\N	\N	\N
795	119	35	Sentence completion for Question 35	\N	\N	\N
796	119	36	Sentence completion for Question 36	\N	\N	\N
797	119	37	Sentence completion for Question 37	\N	\N	\N
798	119	38	Sentence completion for Question 38	\N	\N	\N
799	119	39	Sentence completion for Question 39	\N	\N	\N
800	119	40	Sentence completion for Question 40	\N	\N	\N
801	120	1	Information item for Question 1	\N	\N	\N
802	120	2	Information item for Question 2	\N	\N	\N
803	120	3	Information item for Question 3	\N	\N	\N
804	120	4	Information item for Question 4	\N	\N	\N
805	120	5	Information item for Question 5	\N	\N	\N
806	120	6	Information item for Question 6	\N	\N	\N
807	120	7	Information item for Question 7	\N	\N	\N
808	120	8	Information item for Question 8	\N	\N	\N
809	120	9	Information item for Question 9	\N	\N	\N
810	120	10	Information item for Question 10	\N	\N	\N
811	121	11	Information item for Question 11	\N	\N	\N
812	121	12	Information item for Question 12	\N	\N	\N
813	121	13	Information item for Question 13	\N	\N	\N
814	121	14	Information item for Question 14	\N	\N	\N
815	121	15	Information item for Question 15	\N	\N	\N
816	121	16	Information item for Question 16	\N	\N	\N
817	121	17	Information item for Question 17	\N	\N	\N
818	121	18	Information item for Question 18	\N	\N	\N
819	121	19	Information item for Question 19	\N	\N	\N
820	121	20	Information item for Question 20	\N	\N	\N
821	122	21	Information item for Question 21	\N	\N	\N
822	122	22	Information item for Question 22	\N	\N	\N
823	122	23	Information item for Question 23	\N	\N	\N
824	122	24	Information item for Question 24	\N	\N	\N
825	122	25	Information item for Question 25	\N	\N	\N
826	122	26	Information item for Question 26	\N	\N	\N
827	122	27	Information item for Question 27	\N	\N	\N
828	122	28	Information item for Question 28	\N	\N	\N
829	122	29	Information item for Question 29	\N	\N	\N
830	122	30	Information item for Question 30	\N	\N	\N
831	123	31	Information item for Question 31	\N	\N	\N
832	123	32	Information item for Question 32	\N	\N	\N
833	123	33	Information item for Question 33	\N	\N	\N
834	123	34	Information item for Question 34	\N	\N	\N
835	123	35	Information item for Question 35	\N	\N	\N
836	123	36	Information item for Question 36	\N	\N	\N
837	123	37	Information item for Question 37	\N	\N	\N
838	123	38	Information item for Question 38	\N	\N	\N
839	123	39	Information item for Question 39	\N	\N	\N
840	123	40	Information item for Question 40	\N	\N	\N
841	124	1	Statement for Question 1	\N	\N	\N
842	124	2	Statement for Question 2	\N	\N	\N
843	124	3	Statement for Question 3	\N	\N	\N
844	124	4	Statement for Question 4	\N	\N	\N
845	124	5	Statement for Question 5	\N	\N	\N
846	124	6	Statement for Question 6	\N	\N	\N
847	124	7	Statement for Question 7	\N	\N	\N
848	125	8	Sentence completion for Question 8	\N	\N	\N
849	125	9	Sentence completion for Question 9	\N	\N	\N
850	125	10	Sentence completion for Question 10	\N	\N	\N
851	125	11	Sentence completion for Question 11	\N	\N	\N
852	125	12	Sentence completion for Question 12	\N	\N	\N
853	125	13	Sentence completion for Question 13	\N	\N	\N
854	126	14	Statement for Question 14	\N	\N	\N
855	126	15	Statement for Question 15	\N	\N	\N
856	126	16	Statement for Question 16	\N	\N	\N
857	126	17	Statement for Question 17	\N	\N	\N
858	126	18	Statement for Question 18	\N	\N	\N
859	126	19	Statement for Question 19	\N	\N	\N
860	126	20	Statement for Question 20	\N	\N	\N
861	127	21	Sentence completion for Question 21	\N	\N	\N
862	127	22	Sentence completion for Question 22	\N	\N	\N
863	127	23	Sentence completion for Question 23	\N	\N	\N
864	127	24	Sentence completion for Question 24	\N	\N	\N
865	127	25	Sentence completion for Question 25	\N	\N	\N
866	127	26	Sentence completion for Question 26	\N	\N	\N
867	128	27	Statement for Question 27	\N	\N	\N
868	128	28	Statement for Question 28	\N	\N	\N
869	128	29	Statement for Question 29	\N	\N	\N
870	128	30	Statement for Question 30	\N	\N	\N
871	128	31	Statement for Question 31	\N	\N	\N
872	128	32	Statement for Question 32	\N	\N	\N
873	128	33	Statement for Question 33	\N	\N	\N
874	129	34	Sentence completion for Question 34	\N	\N	\N
875	129	35	Sentence completion for Question 35	\N	\N	\N
876	129	36	Sentence completion for Question 36	\N	\N	\N
877	129	37	Sentence completion for Question 37	\N	\N	\N
878	129	38	Sentence completion for Question 38	\N	\N	\N
879	129	39	Sentence completion for Question 39	\N	\N	\N
880	129	40	Sentence completion for Question 40	\N	\N	\N
881	130	1	Information item for Question 1	\N	\N	\N
882	130	2	Information item for Question 2	\N	\N	\N
883	130	3	Information item for Question 3	\N	\N	\N
884	130	4	Information item for Question 4	\N	\N	\N
885	130	5	Information item for Question 5	\N	\N	\N
886	130	6	Information item for Question 6	\N	\N	\N
887	130	7	Information item for Question 7	\N	\N	\N
888	130	8	Information item for Question 8	\N	\N	\N
889	130	9	Information item for Question 9	\N	\N	\N
890	130	10	Information item for Question 10	\N	\N	\N
891	131	11	Information item for Question 11	\N	\N	\N
892	131	12	Information item for Question 12	\N	\N	\N
893	131	13	Information item for Question 13	\N	\N	\N
894	131	14	Information item for Question 14	\N	\N	\N
895	131	15	Information item for Question 15	\N	\N	\N
896	131	16	Information item for Question 16	\N	\N	\N
897	131	17	Information item for Question 17	\N	\N	\N
898	131	18	Information item for Question 18	\N	\N	\N
899	131	19	Information item for Question 19	\N	\N	\N
900	131	20	Information item for Question 20	\N	\N	\N
901	132	21	Information item for Question 21	\N	\N	\N
902	132	22	Information item for Question 22	\N	\N	\N
903	132	23	Information item for Question 23	\N	\N	\N
904	132	24	Information item for Question 24	\N	\N	\N
905	132	25	Information item for Question 25	\N	\N	\N
906	132	26	Information item for Question 26	\N	\N	\N
907	132	27	Information item for Question 27	\N	\N	\N
908	132	28	Information item for Question 28	\N	\N	\N
909	132	29	Information item for Question 29	\N	\N	\N
910	132	30	Information item for Question 30	\N	\N	\N
911	133	31	Information item for Question 31	\N	\N	\N
912	133	32	Information item for Question 32	\N	\N	\N
913	133	33	Information item for Question 33	\N	\N	\N
914	133	34	Information item for Question 34	\N	\N	\N
915	133	35	Information item for Question 35	\N	\N	\N
916	133	36	Information item for Question 36	\N	\N	\N
917	133	37	Information item for Question 37	\N	\N	\N
918	133	38	Information item for Question 38	\N	\N	\N
919	133	39	Information item for Question 39	\N	\N	\N
920	133	40	Information item for Question 40	\N	\N	\N
921	134	1	Statement for Question 1	\N	\N	\N
922	134	2	Statement for Question 2	\N	\N	\N
923	134	3	Statement for Question 3	\N	\N	\N
924	134	4	Statement for Question 4	\N	\N	\N
925	134	5	Statement for Question 5	\N	\N	\N
926	134	6	Statement for Question 6	\N	\N	\N
927	134	7	Statement for Question 7	\N	\N	\N
928	135	8	Sentence completion for Question 8	\N	\N	\N
929	135	9	Sentence completion for Question 9	\N	\N	\N
930	135	10	Sentence completion for Question 10	\N	\N	\N
931	135	11	Sentence completion for Question 11	\N	\N	\N
932	135	12	Sentence completion for Question 12	\N	\N	\N
933	135	13	Sentence completion for Question 13	\N	\N	\N
934	136	14	Statement for Question 14	\N	\N	\N
935	136	15	Statement for Question 15	\N	\N	\N
936	136	16	Statement for Question 16	\N	\N	\N
937	136	17	Statement for Question 17	\N	\N	\N
938	136	18	Statement for Question 18	\N	\N	\N
939	136	19	Statement for Question 19	\N	\N	\N
940	136	20	Statement for Question 20	\N	\N	\N
941	137	21	Sentence completion for Question 21	\N	\N	\N
942	137	22	Sentence completion for Question 22	\N	\N	\N
943	137	23	Sentence completion for Question 23	\N	\N	\N
944	137	24	Sentence completion for Question 24	\N	\N	\N
945	137	25	Sentence completion for Question 25	\N	\N	\N
946	137	26	Sentence completion for Question 26	\N	\N	\N
947	138	27	Statement for Question 27	\N	\N	\N
948	138	28	Statement for Question 28	\N	\N	\N
949	138	29	Statement for Question 29	\N	\N	\N
950	138	30	Statement for Question 30	\N	\N	\N
951	138	31	Statement for Question 31	\N	\N	\N
952	138	32	Statement for Question 32	\N	\N	\N
953	138	33	Statement for Question 33	\N	\N	\N
954	139	34	Sentence completion for Question 34	\N	\N	\N
955	139	35	Sentence completion for Question 35	\N	\N	\N
956	139	36	Sentence completion for Question 36	\N	\N	\N
957	139	37	Sentence completion for Question 37	\N	\N	\N
958	139	38	Sentence completion for Question 38	\N	\N	\N
959	139	39	Sentence completion for Question 39	\N	\N	\N
960	139	40	Sentence completion for Question 40	\N	\N	\N
961	140	1	Information item for Question 1	\N	\N	\N
962	140	2	Information item for Question 2	\N	\N	\N
963	140	3	Information item for Question 3	\N	\N	\N
964	140	4	Information item for Question 4	\N	\N	\N
965	140	5	Information item for Question 5	\N	\N	\N
966	140	6	Information item for Question 6	\N	\N	\N
967	140	7	Information item for Question 7	\N	\N	\N
968	140	8	Information item for Question 8	\N	\N	\N
969	140	9	Information item for Question 9	\N	\N	\N
970	140	10	Information item for Question 10	\N	\N	\N
971	141	11	Information item for Question 11	\N	\N	\N
972	141	12	Information item for Question 12	\N	\N	\N
973	141	13	Information item for Question 13	\N	\N	\N
974	141	14	Information item for Question 14	\N	\N	\N
975	141	15	Information item for Question 15	\N	\N	\N
976	141	16	Information item for Question 16	\N	\N	\N
977	141	17	Information item for Question 17	\N	\N	\N
978	141	18	Information item for Question 18	\N	\N	\N
979	141	19	Information item for Question 19	\N	\N	\N
980	141	20	Information item for Question 20	\N	\N	\N
981	142	21	Information item for Question 21	\N	\N	\N
982	142	22	Information item for Question 22	\N	\N	\N
983	142	23	Information item for Question 23	\N	\N	\N
984	142	24	Information item for Question 24	\N	\N	\N
985	142	25	Information item for Question 25	\N	\N	\N
986	142	26	Information item for Question 26	\N	\N	\N
987	142	27	Information item for Question 27	\N	\N	\N
988	142	28	Information item for Question 28	\N	\N	\N
989	142	29	Information item for Question 29	\N	\N	\N
990	142	30	Information item for Question 30	\N	\N	\N
991	143	31	Information item for Question 31	\N	\N	\N
992	143	32	Information item for Question 32	\N	\N	\N
993	143	33	Information item for Question 33	\N	\N	\N
994	143	34	Information item for Question 34	\N	\N	\N
995	143	35	Information item for Question 35	\N	\N	\N
996	143	36	Information item for Question 36	\N	\N	\N
997	143	37	Information item for Question 37	\N	\N	\N
998	143	38	Information item for Question 38	\N	\N	\N
999	143	39	Information item for Question 39	\N	\N	\N
1000	143	40	Information item for Question 40	\N	\N	\N
1001	144	1	Statement for Question 1	\N	\N	\N
1002	144	2	Statement for Question 2	\N	\N	\N
1003	144	3	Statement for Question 3	\N	\N	\N
1004	144	4	Statement for Question 4	\N	\N	\N
1005	144	5	Statement for Question 5	\N	\N	\N
1006	144	6	Statement for Question 6	\N	\N	\N
1007	144	7	Statement for Question 7	\N	\N	\N
1008	145	8	Sentence completion for Question 8	\N	\N	\N
1009	145	9	Sentence completion for Question 9	\N	\N	\N
1010	145	10	Sentence completion for Question 10	\N	\N	\N
1011	145	11	Sentence completion for Question 11	\N	\N	\N
1012	145	12	Sentence completion for Question 12	\N	\N	\N
1013	145	13	Sentence completion for Question 13	\N	\N	\N
1014	146	14	Statement for Question 14	\N	\N	\N
1015	146	15	Statement for Question 15	\N	\N	\N
1016	146	16	Statement for Question 16	\N	\N	\N
1017	146	17	Statement for Question 17	\N	\N	\N
1018	146	18	Statement for Question 18	\N	\N	\N
1019	146	19	Statement for Question 19	\N	\N	\N
1020	146	20	Statement for Question 20	\N	\N	\N
1021	147	21	Sentence completion for Question 21	\N	\N	\N
1022	147	22	Sentence completion for Question 22	\N	\N	\N
1023	147	23	Sentence completion for Question 23	\N	\N	\N
1024	147	24	Sentence completion for Question 24	\N	\N	\N
1025	147	25	Sentence completion for Question 25	\N	\N	\N
1026	147	26	Sentence completion for Question 26	\N	\N	\N
1027	148	27	Statement for Question 27	\N	\N	\N
1028	148	28	Statement for Question 28	\N	\N	\N
1029	148	29	Statement for Question 29	\N	\N	\N
1030	148	30	Statement for Question 30	\N	\N	\N
1031	148	31	Statement for Question 31	\N	\N	\N
1032	148	32	Statement for Question 32	\N	\N	\N
1033	148	33	Statement for Question 33	\N	\N	\N
1034	149	34	Sentence completion for Question 34	\N	\N	\N
1035	149	35	Sentence completion for Question 35	\N	\N	\N
1036	149	36	Sentence completion for Question 36	\N	\N	\N
1037	149	37	Sentence completion for Question 37	\N	\N	\N
1038	149	38	Sentence completion for Question 38	\N	\N	\N
1039	149	39	Sentence completion for Question 39	\N	\N	\N
1040	149	40	Sentence completion for Question 40	\N	\N	\N
1041	150	1	Information item for Question 1	\N	\N	\N
1042	150	2	Information item for Question 2	\N	\N	\N
1043	150	3	Information item for Question 3	\N	\N	\N
1044	150	4	Information item for Question 4	\N	\N	\N
1045	150	5	Information item for Question 5	\N	\N	\N
1046	150	6	Information item for Question 6	\N	\N	\N
1047	150	7	Information item for Question 7	\N	\N	\N
1048	150	8	Information item for Question 8	\N	\N	\N
1049	150	9	Information item for Question 9	\N	\N	\N
1050	150	10	Information item for Question 10	\N	\N	\N
1051	151	11	Information item for Question 11	\N	\N	\N
1052	151	12	Information item for Question 12	\N	\N	\N
1053	151	13	Information item for Question 13	\N	\N	\N
1054	151	14	Information item for Question 14	\N	\N	\N
1055	151	15	Information item for Question 15	\N	\N	\N
1056	151	16	Information item for Question 16	\N	\N	\N
1057	151	17	Information item for Question 17	\N	\N	\N
1058	151	18	Information item for Question 18	\N	\N	\N
1059	151	19	Information item for Question 19	\N	\N	\N
1060	151	20	Information item for Question 20	\N	\N	\N
1061	152	21	Information item for Question 21	\N	\N	\N
1062	152	22	Information item for Question 22	\N	\N	\N
1063	152	23	Information item for Question 23	\N	\N	\N
1064	152	24	Information item for Question 24	\N	\N	\N
1065	152	25	Information item for Question 25	\N	\N	\N
1066	152	26	Information item for Question 26	\N	\N	\N
1067	152	27	Information item for Question 27	\N	\N	\N
1068	152	28	Information item for Question 28	\N	\N	\N
1069	152	29	Information item for Question 29	\N	\N	\N
1070	152	30	Information item for Question 30	\N	\N	\N
1071	153	31	Information item for Question 31	\N	\N	\N
1072	153	32	Information item for Question 32	\N	\N	\N
1073	153	33	Information item for Question 33	\N	\N	\N
1074	153	34	Information item for Question 34	\N	\N	\N
1075	153	35	Information item for Question 35	\N	\N	\N
1076	153	36	Information item for Question 36	\N	\N	\N
1077	153	37	Information item for Question 37	\N	\N	\N
1078	153	38	Information item for Question 38	\N	\N	\N
1079	153	39	Information item for Question 39	\N	\N	\N
1080	153	40	Information item for Question 40	\N	\N	\N
1081	154	1	Statement for Question 1	\N	\N	\N
1082	154	2	Statement for Question 2	\N	\N	\N
1083	154	3	Statement for Question 3	\N	\N	\N
1084	154	4	Statement for Question 4	\N	\N	\N
1085	154	5	Statement for Question 5	\N	\N	\N
1086	154	6	Statement for Question 6	\N	\N	\N
1087	154	7	Statement for Question 7	\N	\N	\N
1088	155	8	Sentence completion for Question 8	\N	\N	\N
1089	155	9	Sentence completion for Question 9	\N	\N	\N
1090	155	10	Sentence completion for Question 10	\N	\N	\N
1091	155	11	Sentence completion for Question 11	\N	\N	\N
1092	155	12	Sentence completion for Question 12	\N	\N	\N
1093	155	13	Sentence completion for Question 13	\N	\N	\N
1094	156	14	Statement for Question 14	\N	\N	\N
1095	156	15	Statement for Question 15	\N	\N	\N
1096	156	16	Statement for Question 16	\N	\N	\N
1097	156	17	Statement for Question 17	\N	\N	\N
1098	156	18	Statement for Question 18	\N	\N	\N
1099	156	19	Statement for Question 19	\N	\N	\N
1100	156	20	Statement for Question 20	\N	\N	\N
1101	157	21	Sentence completion for Question 21	\N	\N	\N
1102	157	22	Sentence completion for Question 22	\N	\N	\N
1103	157	23	Sentence completion for Question 23	\N	\N	\N
1104	157	24	Sentence completion for Question 24	\N	\N	\N
1105	157	25	Sentence completion for Question 25	\N	\N	\N
1106	157	26	Sentence completion for Question 26	\N	\N	\N
1107	158	27	Statement for Question 27	\N	\N	\N
1108	158	28	Statement for Question 28	\N	\N	\N
1109	158	29	Statement for Question 29	\N	\N	\N
1110	158	30	Statement for Question 30	\N	\N	\N
1111	158	31	Statement for Question 31	\N	\N	\N
1112	158	32	Statement for Question 32	\N	\N	\N
1113	158	33	Statement for Question 33	\N	\N	\N
1114	159	34	Sentence completion for Question 34	\N	\N	\N
1115	159	35	Sentence completion for Question 35	\N	\N	\N
1116	159	36	Sentence completion for Question 36	\N	\N	\N
1117	159	37	Sentence completion for Question 37	\N	\N	\N
1118	159	38	Sentence completion for Question 38	\N	\N	\N
1119	159	39	Sentence completion for Question 39	\N	\N	\N
1120	159	40	Sentence completion for Question 40	\N	\N	\N
1121	160	1	Information item for Question 1	\N	\N	\N
1122	160	2	Information item for Question 2	\N	\N	\N
1123	160	3	Information item for Question 3	\N	\N	\N
1124	160	4	Information item for Question 4	\N	\N	\N
1125	160	5	Information item for Question 5	\N	\N	\N
1126	160	6	Information item for Question 6	\N	\N	\N
1127	160	7	Information item for Question 7	\N	\N	\N
1128	160	8	Information item for Question 8	\N	\N	\N
1129	160	9	Information item for Question 9	\N	\N	\N
1130	160	10	Information item for Question 10	\N	\N	\N
1131	161	11	Information item for Question 11	\N	\N	\N
1132	161	12	Information item for Question 12	\N	\N	\N
1133	161	13	Information item for Question 13	\N	\N	\N
1134	161	14	Information item for Question 14	\N	\N	\N
1135	161	15	Information item for Question 15	\N	\N	\N
1136	161	16	Information item for Question 16	\N	\N	\N
1137	161	17	Information item for Question 17	\N	\N	\N
1138	161	18	Information item for Question 18	\N	\N	\N
1139	161	19	Information item for Question 19	\N	\N	\N
1140	161	20	Information item for Question 20	\N	\N	\N
1141	162	21	Information item for Question 21	\N	\N	\N
1142	162	22	Information item for Question 22	\N	\N	\N
1143	162	23	Information item for Question 23	\N	\N	\N
1144	162	24	Information item for Question 24	\N	\N	\N
1145	162	25	Information item for Question 25	\N	\N	\N
1146	162	26	Information item for Question 26	\N	\N	\N
1147	162	27	Information item for Question 27	\N	\N	\N
1148	162	28	Information item for Question 28	\N	\N	\N
1149	162	29	Information item for Question 29	\N	\N	\N
1150	162	30	Information item for Question 30	\N	\N	\N
1151	163	31	Information item for Question 31	\N	\N	\N
1152	163	32	Information item for Question 32	\N	\N	\N
1153	163	33	Information item for Question 33	\N	\N	\N
1154	163	34	Information item for Question 34	\N	\N	\N
1155	163	35	Information item for Question 35	\N	\N	\N
1156	163	36	Information item for Question 36	\N	\N	\N
1157	163	37	Information item for Question 37	\N	\N	\N
1158	163	38	Information item for Question 38	\N	\N	\N
1159	163	39	Information item for Question 39	\N	\N	\N
1160	163	40	Information item for Question 40	\N	\N	\N
1161	164	1	Statement for Question 1	\N	\N	\N
1162	164	2	Statement for Question 2	\N	\N	\N
1163	164	3	Statement for Question 3	\N	\N	\N
1164	164	4	Statement for Question 4	\N	\N	\N
1165	164	5	Statement for Question 5	\N	\N	\N
1166	164	6	Statement for Question 6	\N	\N	\N
1167	164	7	Statement for Question 7	\N	\N	\N
1168	165	8	Sentence completion for Question 8	\N	\N	\N
1169	165	9	Sentence completion for Question 9	\N	\N	\N
1170	165	10	Sentence completion for Question 10	\N	\N	\N
1171	165	11	Sentence completion for Question 11	\N	\N	\N
1172	165	12	Sentence completion for Question 12	\N	\N	\N
1173	165	13	Sentence completion for Question 13	\N	\N	\N
1174	166	14	Statement for Question 14	\N	\N	\N
1175	166	15	Statement for Question 15	\N	\N	\N
1176	166	16	Statement for Question 16	\N	\N	\N
1177	166	17	Statement for Question 17	\N	\N	\N
1178	166	18	Statement for Question 18	\N	\N	\N
1179	166	19	Statement for Question 19	\N	\N	\N
1180	166	20	Statement for Question 20	\N	\N	\N
1181	167	21	Sentence completion for Question 21	\N	\N	\N
1182	167	22	Sentence completion for Question 22	\N	\N	\N
1183	167	23	Sentence completion for Question 23	\N	\N	\N
1184	167	24	Sentence completion for Question 24	\N	\N	\N
1185	167	25	Sentence completion for Question 25	\N	\N	\N
1186	167	26	Sentence completion for Question 26	\N	\N	\N
1187	168	27	Statement for Question 27	\N	\N	\N
1188	168	28	Statement for Question 28	\N	\N	\N
1189	168	29	Statement for Question 29	\N	\N	\N
1190	168	30	Statement for Question 30	\N	\N	\N
1191	168	31	Statement for Question 31	\N	\N	\N
1192	168	32	Statement for Question 32	\N	\N	\N
1193	168	33	Statement for Question 33	\N	\N	\N
1194	169	34	Sentence completion for Question 34	\N	\N	\N
1195	169	35	Sentence completion for Question 35	\N	\N	\N
1196	169	36	Sentence completion for Question 36	\N	\N	\N
1197	169	37	Sentence completion for Question 37	\N	\N	\N
1198	169	38	Sentence completion for Question 38	\N	\N	\N
1199	169	39	Sentence completion for Question 39	\N	\N	\N
1200	169	40	Sentence completion for Question 40	\N	\N	\N
1201	170	1	Information item for Question 1	\N	\N	\N
1202	170	2	Information item for Question 2	\N	\N	\N
1203	170	3	Information item for Question 3	\N	\N	\N
1204	170	4	Information item for Question 4	\N	\N	\N
1205	170	5	Information item for Question 5	\N	\N	\N
1206	170	6	Information item for Question 6	\N	\N	\N
1207	170	7	Information item for Question 7	\N	\N	\N
1208	170	8	Information item for Question 8	\N	\N	\N
1209	170	9	Information item for Question 9	\N	\N	\N
1210	170	10	Information item for Question 10	\N	\N	\N
1211	171	11	Information item for Question 11	\N	\N	\N
1212	171	12	Information item for Question 12	\N	\N	\N
1213	171	13	Information item for Question 13	\N	\N	\N
1214	171	14	Information item for Question 14	\N	\N	\N
1215	171	15	Information item for Question 15	\N	\N	\N
1216	171	16	Information item for Question 16	\N	\N	\N
1217	171	17	Information item for Question 17	\N	\N	\N
1218	171	18	Information item for Question 18	\N	\N	\N
1219	171	19	Information item for Question 19	\N	\N	\N
1220	171	20	Information item for Question 20	\N	\N	\N
1221	172	21	Information item for Question 21	\N	\N	\N
1222	172	22	Information item for Question 22	\N	\N	\N
1223	172	23	Information item for Question 23	\N	\N	\N
1224	172	24	Information item for Question 24	\N	\N	\N
1225	172	25	Information item for Question 25	\N	\N	\N
1226	172	26	Information item for Question 26	\N	\N	\N
1227	172	27	Information item for Question 27	\N	\N	\N
1228	172	28	Information item for Question 28	\N	\N	\N
1229	172	29	Information item for Question 29	\N	\N	\N
1230	172	30	Information item for Question 30	\N	\N	\N
1231	173	31	Information item for Question 31	\N	\N	\N
1232	173	32	Information item for Question 32	\N	\N	\N
1233	173	33	Information item for Question 33	\N	\N	\N
1234	173	34	Information item for Question 34	\N	\N	\N
1235	173	35	Information item for Question 35	\N	\N	\N
1236	173	36	Information item for Question 36	\N	\N	\N
1237	173	37	Information item for Question 37	\N	\N	\N
1238	173	38	Information item for Question 38	\N	\N	\N
1239	173	39	Information item for Question 39	\N	\N	\N
1240	173	40	Information item for Question 40	\N	\N	\N
1241	174	1	Statement for Question 1	\N	\N	\N
1242	174	2	Statement for Question 2	\N	\N	\N
1243	174	3	Statement for Question 3	\N	\N	\N
1244	174	4	Statement for Question 4	\N	\N	\N
1245	174	5	Statement for Question 5	\N	\N	\N
1246	174	6	Statement for Question 6	\N	\N	\N
1247	174	7	Statement for Question 7	\N	\N	\N
1248	175	8	Sentence completion for Question 8	\N	\N	\N
1249	175	9	Sentence completion for Question 9	\N	\N	\N
1250	175	10	Sentence completion for Question 10	\N	\N	\N
1251	175	11	Sentence completion for Question 11	\N	\N	\N
1252	175	12	Sentence completion for Question 12	\N	\N	\N
1253	175	13	Sentence completion for Question 13	\N	\N	\N
1254	176	14	Statement for Question 14	\N	\N	\N
1255	176	15	Statement for Question 15	\N	\N	\N
1256	176	16	Statement for Question 16	\N	\N	\N
1257	176	17	Statement for Question 17	\N	\N	\N
1258	176	18	Statement for Question 18	\N	\N	\N
1259	176	19	Statement for Question 19	\N	\N	\N
1260	176	20	Statement for Question 20	\N	\N	\N
1261	177	21	Sentence completion for Question 21	\N	\N	\N
1262	177	22	Sentence completion for Question 22	\N	\N	\N
1263	177	23	Sentence completion for Question 23	\N	\N	\N
1264	177	24	Sentence completion for Question 24	\N	\N	\N
1265	177	25	Sentence completion for Question 25	\N	\N	\N
1266	177	26	Sentence completion for Question 26	\N	\N	\N
1267	178	27	Statement for Question 27	\N	\N	\N
1268	178	28	Statement for Question 28	\N	\N	\N
1269	178	29	Statement for Question 29	\N	\N	\N
1270	178	30	Statement for Question 30	\N	\N	\N
1271	178	31	Statement for Question 31	\N	\N	\N
1272	178	32	Statement for Question 32	\N	\N	\N
1273	178	33	Statement for Question 33	\N	\N	\N
1274	179	34	Sentence completion for Question 34	\N	\N	\N
1275	179	35	Sentence completion for Question 35	\N	\N	\N
1276	179	36	Sentence completion for Question 36	\N	\N	\N
1277	179	37	Sentence completion for Question 37	\N	\N	\N
1278	179	38	Sentence completion for Question 38	\N	\N	\N
1279	179	39	Sentence completion for Question 39	\N	\N	\N
1280	179	40	Sentence completion for Question 40	\N	\N	\N
1281	180	1	Information item for Question 1	\N	\N	\N
1282	180	2	Information item for Question 2	\N	\N	\N
1283	180	3	Information item for Question 3	\N	\N	\N
1284	180	4	Information item for Question 4	\N	\N	\N
1285	180	5	Information item for Question 5	\N	\N	\N
1286	180	6	Information item for Question 6	\N	\N	\N
1287	180	7	Information item for Question 7	\N	\N	\N
1288	180	8	Information item for Question 8	\N	\N	\N
1289	180	9	Information item for Question 9	\N	\N	\N
1290	180	10	Information item for Question 10	\N	\N	\N
1291	181	11	Information item for Question 11	\N	\N	\N
1292	181	12	Information item for Question 12	\N	\N	\N
1293	181	13	Information item for Question 13	\N	\N	\N
1294	181	14	Information item for Question 14	\N	\N	\N
1295	181	15	Information item for Question 15	\N	\N	\N
1296	181	16	Information item for Question 16	\N	\N	\N
1297	181	17	Information item for Question 17	\N	\N	\N
1298	181	18	Information item for Question 18	\N	\N	\N
1299	181	19	Information item for Question 19	\N	\N	\N
1300	181	20	Information item for Question 20	\N	\N	\N
1301	182	21	Information item for Question 21	\N	\N	\N
1302	182	22	Information item for Question 22	\N	\N	\N
1303	182	23	Information item for Question 23	\N	\N	\N
1304	182	24	Information item for Question 24	\N	\N	\N
1305	182	25	Information item for Question 25	\N	\N	\N
1306	182	26	Information item for Question 26	\N	\N	\N
1307	182	27	Information item for Question 27	\N	\N	\N
1308	182	28	Information item for Question 28	\N	\N	\N
1309	182	29	Information item for Question 29	\N	\N	\N
1310	182	30	Information item for Question 30	\N	\N	\N
1311	183	31	Information item for Question 31	\N	\N	\N
1312	183	32	Information item for Question 32	\N	\N	\N
1313	183	33	Information item for Question 33	\N	\N	\N
1314	183	34	Information item for Question 34	\N	\N	\N
1315	183	35	Information item for Question 35	\N	\N	\N
1316	183	36	Information item for Question 36	\N	\N	\N
1317	183	37	Information item for Question 37	\N	\N	\N
1318	183	38	Information item for Question 38	\N	\N	\N
1319	183	39	Information item for Question 39	\N	\N	\N
1320	183	40	Information item for Question 40	\N	\N	\N
1321	184	1	Statement for Question 1	\N	\N	\N
1322	184	2	Statement for Question 2	\N	\N	\N
1323	184	3	Statement for Question 3	\N	\N	\N
1324	184	4	Statement for Question 4	\N	\N	\N
1325	184	5	Statement for Question 5	\N	\N	\N
1326	184	6	Statement for Question 6	\N	\N	\N
1327	184	7	Statement for Question 7	\N	\N	\N
1328	185	8	Sentence completion for Question 8	\N	\N	\N
1329	185	9	Sentence completion for Question 9	\N	\N	\N
1330	185	10	Sentence completion for Question 10	\N	\N	\N
1331	185	11	Sentence completion for Question 11	\N	\N	\N
1332	185	12	Sentence completion for Question 12	\N	\N	\N
1333	185	13	Sentence completion for Question 13	\N	\N	\N
1334	186	14	Statement for Question 14	\N	\N	\N
1335	186	15	Statement for Question 15	\N	\N	\N
1336	186	16	Statement for Question 16	\N	\N	\N
1337	186	17	Statement for Question 17	\N	\N	\N
1338	186	18	Statement for Question 18	\N	\N	\N
1339	186	19	Statement for Question 19	\N	\N	\N
1340	186	20	Statement for Question 20	\N	\N	\N
1341	187	21	Sentence completion for Question 21	\N	\N	\N
1342	187	22	Sentence completion for Question 22	\N	\N	\N
1343	187	23	Sentence completion for Question 23	\N	\N	\N
1344	187	24	Sentence completion for Question 24	\N	\N	\N
1345	187	25	Sentence completion for Question 25	\N	\N	\N
1346	187	26	Sentence completion for Question 26	\N	\N	\N
1347	188	27	Statement for Question 27	\N	\N	\N
1348	188	28	Statement for Question 28	\N	\N	\N
1349	188	29	Statement for Question 29	\N	\N	\N
1350	188	30	Statement for Question 30	\N	\N	\N
1351	188	31	Statement for Question 31	\N	\N	\N
1352	188	32	Statement for Question 32	\N	\N	\N
1353	188	33	Statement for Question 33	\N	\N	\N
1354	189	34	Sentence completion for Question 34	\N	\N	\N
1355	189	35	Sentence completion for Question 35	\N	\N	\N
1356	189	36	Sentence completion for Question 36	\N	\N	\N
1357	189	37	Sentence completion for Question 37	\N	\N	\N
1358	189	38	Sentence completion for Question 38	\N	\N	\N
1359	189	39	Sentence completion for Question 39	\N	\N	\N
1360	189	40	Sentence completion for Question 40	\N	\N	\N
1361	190	1	Information item for Question 1	\N	\N	\N
1362	190	2	Information item for Question 2	\N	\N	\N
1363	190	3	Information item for Question 3	\N	\N	\N
1364	190	4	Information item for Question 4	\N	\N	\N
1365	190	5	Information item for Question 5	\N	\N	\N
1366	190	6	Information item for Question 6	\N	\N	\N
1367	190	7	Information item for Question 7	\N	\N	\N
1368	190	8	Information item for Question 8	\N	\N	\N
1369	190	9	Information item for Question 9	\N	\N	\N
1370	190	10	Information item for Question 10	\N	\N	\N
1371	191	11	Information item for Question 11	\N	\N	\N
1372	191	12	Information item for Question 12	\N	\N	\N
1373	191	13	Information item for Question 13	\N	\N	\N
1374	191	14	Information item for Question 14	\N	\N	\N
1375	191	15	Information item for Question 15	\N	\N	\N
1376	191	16	Information item for Question 16	\N	\N	\N
1377	191	17	Information item for Question 17	\N	\N	\N
1378	191	18	Information item for Question 18	\N	\N	\N
1379	191	19	Information item for Question 19	\N	\N	\N
1380	191	20	Information item for Question 20	\N	\N	\N
1381	192	21	Information item for Question 21	\N	\N	\N
1382	192	22	Information item for Question 22	\N	\N	\N
1383	192	23	Information item for Question 23	\N	\N	\N
1384	192	24	Information item for Question 24	\N	\N	\N
1385	192	25	Information item for Question 25	\N	\N	\N
1386	192	26	Information item for Question 26	\N	\N	\N
1387	192	27	Information item for Question 27	\N	\N	\N
1388	192	28	Information item for Question 28	\N	\N	\N
1389	192	29	Information item for Question 29	\N	\N	\N
1390	192	30	Information item for Question 30	\N	\N	\N
1391	193	31	Information item for Question 31	\N	\N	\N
1392	193	32	Information item for Question 32	\N	\N	\N
1393	193	33	Information item for Question 33	\N	\N	\N
1394	193	34	Information item for Question 34	\N	\N	\N
1395	193	35	Information item for Question 35	\N	\N	\N
1396	193	36	Information item for Question 36	\N	\N	\N
1397	193	37	Information item for Question 37	\N	\N	\N
1398	193	38	Information item for Question 38	\N	\N	\N
1399	193	39	Information item for Question 39	\N	\N	\N
1400	193	40	Information item for Question 40	\N	\N	\N
1401	194	1	Statement for Question 1	\N	\N	\N
1402	194	2	Statement for Question 2	\N	\N	\N
1403	194	3	Statement for Question 3	\N	\N	\N
1404	194	4	Statement for Question 4	\N	\N	\N
1405	194	5	Statement for Question 5	\N	\N	\N
1406	194	6	Statement for Question 6	\N	\N	\N
1407	194	7	Statement for Question 7	\N	\N	\N
1408	195	8	Sentence completion for Question 8	\N	\N	\N
1409	195	9	Sentence completion for Question 9	\N	\N	\N
1410	195	10	Sentence completion for Question 10	\N	\N	\N
1411	195	11	Sentence completion for Question 11	\N	\N	\N
1412	195	12	Sentence completion for Question 12	\N	\N	\N
1413	195	13	Sentence completion for Question 13	\N	\N	\N
1414	196	14	Statement for Question 14	\N	\N	\N
1415	196	15	Statement for Question 15	\N	\N	\N
1416	196	16	Statement for Question 16	\N	\N	\N
1417	196	17	Statement for Question 17	\N	\N	\N
1418	196	18	Statement for Question 18	\N	\N	\N
1419	196	19	Statement for Question 19	\N	\N	\N
1420	196	20	Statement for Question 20	\N	\N	\N
1421	197	21	Sentence completion for Question 21	\N	\N	\N
1422	197	22	Sentence completion for Question 22	\N	\N	\N
1423	197	23	Sentence completion for Question 23	\N	\N	\N
1424	197	24	Sentence completion for Question 24	\N	\N	\N
1425	197	25	Sentence completion for Question 25	\N	\N	\N
1426	197	26	Sentence completion for Question 26	\N	\N	\N
1427	198	27	Statement for Question 27	\N	\N	\N
1428	198	28	Statement for Question 28	\N	\N	\N
1429	198	29	Statement for Question 29	\N	\N	\N
1430	198	30	Statement for Question 30	\N	\N	\N
1431	198	31	Statement for Question 31	\N	\N	\N
1432	198	32	Statement for Question 32	\N	\N	\N
1433	198	33	Statement for Question 33	\N	\N	\N
1434	199	34	Sentence completion for Question 34	\N	\N	\N
1435	199	35	Sentence completion for Question 35	\N	\N	\N
1436	199	36	Sentence completion for Question 36	\N	\N	\N
1437	199	37	Sentence completion for Question 37	\N	\N	\N
1438	199	38	Sentence completion for Question 38	\N	\N	\N
1439	199	39	Sentence completion for Question 39	\N	\N	\N
1440	199	40	Sentence completion for Question 40	\N	\N	\N
1441	200	1	Information item for Question 1	\N	\N	\N
1442	200	2	Information item for Question 2	\N	\N	\N
1443	200	3	Information item for Question 3	\N	\N	\N
1444	200	4	Information item for Question 4	\N	\N	\N
1445	200	5	Information item for Question 5	\N	\N	\N
1446	200	6	Information item for Question 6	\N	\N	\N
1447	200	7	Information item for Question 7	\N	\N	\N
1448	200	8	Information item for Question 8	\N	\N	\N
1449	200	9	Information item for Question 9	\N	\N	\N
1450	200	10	Information item for Question 10	\N	\N	\N
1451	201	11	Information item for Question 11	\N	\N	\N
1452	201	12	Information item for Question 12	\N	\N	\N
1453	201	13	Information item for Question 13	\N	\N	\N
1454	201	14	Information item for Question 14	\N	\N	\N
1455	201	15	Information item for Question 15	\N	\N	\N
1456	201	16	Information item for Question 16	\N	\N	\N
1457	201	17	Information item for Question 17	\N	\N	\N
1458	201	18	Information item for Question 18	\N	\N	\N
1459	201	19	Information item for Question 19	\N	\N	\N
1460	201	20	Information item for Question 20	\N	\N	\N
1461	202	21	Information item for Question 21	\N	\N	\N
1462	202	22	Information item for Question 22	\N	\N	\N
1463	202	23	Information item for Question 23	\N	\N	\N
1464	202	24	Information item for Question 24	\N	\N	\N
1465	202	25	Information item for Question 25	\N	\N	\N
1466	202	26	Information item for Question 26	\N	\N	\N
1467	202	27	Information item for Question 27	\N	\N	\N
1468	202	28	Information item for Question 28	\N	\N	\N
1469	202	29	Information item for Question 29	\N	\N	\N
1470	202	30	Information item for Question 30	\N	\N	\N
1471	203	31	Information item for Question 31	\N	\N	\N
1472	203	32	Information item for Question 32	\N	\N	\N
1473	203	33	Information item for Question 33	\N	\N	\N
1474	203	34	Information item for Question 34	\N	\N	\N
1475	203	35	Information item for Question 35	\N	\N	\N
1476	203	36	Information item for Question 36	\N	\N	\N
1477	203	37	Information item for Question 37	\N	\N	\N
1478	203	38	Information item for Question 38	\N	\N	\N
1479	203	39	Information item for Question 39	\N	\N	\N
1480	203	40	Information item for Question 40	\N	\N	\N
1481	204	1	Statement for Question 1	\N	\N	\N
1482	204	2	Statement for Question 2	\N	\N	\N
1483	204	3	Statement for Question 3	\N	\N	\N
1484	204	4	Statement for Question 4	\N	\N	\N
1485	204	5	Statement for Question 5	\N	\N	\N
1486	204	6	Statement for Question 6	\N	\N	\N
1487	204	7	Statement for Question 7	\N	\N	\N
1488	205	8	Sentence completion for Question 8	\N	\N	\N
1489	205	9	Sentence completion for Question 9	\N	\N	\N
1490	205	10	Sentence completion for Question 10	\N	\N	\N
1491	205	11	Sentence completion for Question 11	\N	\N	\N
1492	205	12	Sentence completion for Question 12	\N	\N	\N
1493	205	13	Sentence completion for Question 13	\N	\N	\N
1494	206	14	Statement for Question 14	\N	\N	\N
1495	206	15	Statement for Question 15	\N	\N	\N
1496	206	16	Statement for Question 16	\N	\N	\N
1497	206	17	Statement for Question 17	\N	\N	\N
1498	206	18	Statement for Question 18	\N	\N	\N
1499	206	19	Statement for Question 19	\N	\N	\N
1500	206	20	Statement for Question 20	\N	\N	\N
1501	207	21	Sentence completion for Question 21	\N	\N	\N
1502	207	22	Sentence completion for Question 22	\N	\N	\N
1503	207	23	Sentence completion for Question 23	\N	\N	\N
1504	207	24	Sentence completion for Question 24	\N	\N	\N
1505	207	25	Sentence completion for Question 25	\N	\N	\N
1506	207	26	Sentence completion for Question 26	\N	\N	\N
1507	208	27	Statement for Question 27	\N	\N	\N
1508	208	28	Statement for Question 28	\N	\N	\N
1509	208	29	Statement for Question 29	\N	\N	\N
1510	208	30	Statement for Question 30	\N	\N	\N
1511	208	31	Statement for Question 31	\N	\N	\N
1512	208	32	Statement for Question 32	\N	\N	\N
1513	208	33	Statement for Question 33	\N	\N	\N
1514	209	34	Sentence completion for Question 34	\N	\N	\N
1515	209	35	Sentence completion for Question 35	\N	\N	\N
1516	209	36	Sentence completion for Question 36	\N	\N	\N
1517	209	37	Sentence completion for Question 37	\N	\N	\N
1518	209	38	Sentence completion for Question 38	\N	\N	\N
1519	209	39	Sentence completion for Question 39	\N	\N	\N
1520	209	40	Sentence completion for Question 40	\N	\N	\N
1521	210	1	Information item for Question 1	\N	\N	\N
1522	210	2	Information item for Question 2	\N	\N	\N
1523	210	3	Information item for Question 3	\N	\N	\N
1524	210	4	Information item for Question 4	\N	\N	\N
1525	210	5	Information item for Question 5	\N	\N	\N
1526	210	6	Information item for Question 6	\N	\N	\N
1527	210	7	Information item for Question 7	\N	\N	\N
1528	210	8	Information item for Question 8	\N	\N	\N
1529	210	9	Information item for Question 9	\N	\N	\N
1530	210	10	Information item for Question 10	\N	\N	\N
1531	211	11	Information item for Question 11	\N	\N	\N
1532	211	12	Information item for Question 12	\N	\N	\N
1533	211	13	Information item for Question 13	\N	\N	\N
1534	211	14	Information item for Question 14	\N	\N	\N
1535	211	15	Information item for Question 15	\N	\N	\N
1536	211	16	Information item for Question 16	\N	\N	\N
1537	211	17	Information item for Question 17	\N	\N	\N
1538	211	18	Information item for Question 18	\N	\N	\N
1539	211	19	Information item for Question 19	\N	\N	\N
1540	211	20	Information item for Question 20	\N	\N	\N
1541	212	21	Information item for Question 21	\N	\N	\N
1542	212	22	Information item for Question 22	\N	\N	\N
1543	212	23	Information item for Question 23	\N	\N	\N
1544	212	24	Information item for Question 24	\N	\N	\N
1545	212	25	Information item for Question 25	\N	\N	\N
1546	212	26	Information item for Question 26	\N	\N	\N
1547	212	27	Information item for Question 27	\N	\N	\N
1548	212	28	Information item for Question 28	\N	\N	\N
1549	212	29	Information item for Question 29	\N	\N	\N
1550	212	30	Information item for Question 30	\N	\N	\N
1551	213	31	Information item for Question 31	\N	\N	\N
1552	213	32	Information item for Question 32	\N	\N	\N
1553	213	33	Information item for Question 33	\N	\N	\N
1554	213	34	Information item for Question 34	\N	\N	\N
1555	213	35	Information item for Question 35	\N	\N	\N
1556	213	36	Information item for Question 36	\N	\N	\N
1557	213	37	Information item for Question 37	\N	\N	\N
1558	213	38	Information item for Question 38	\N	\N	\N
1559	213	39	Information item for Question 39	\N	\N	\N
1560	213	40	Information item for Question 40	\N	\N	\N
1561	214	1	Statement for Question 1	\N	\N	\N
1562	214	2	Statement for Question 2	\N	\N	\N
1563	214	3	Statement for Question 3	\N	\N	\N
1564	214	4	Statement for Question 4	\N	\N	\N
1565	214	5	Statement for Question 5	\N	\N	\N
1566	214	6	Statement for Question 6	\N	\N	\N
1567	214	7	Statement for Question 7	\N	\N	\N
1568	215	8	Sentence completion for Question 8	\N	\N	\N
1569	215	9	Sentence completion for Question 9	\N	\N	\N
1570	215	10	Sentence completion for Question 10	\N	\N	\N
1571	215	11	Sentence completion for Question 11	\N	\N	\N
1572	215	12	Sentence completion for Question 12	\N	\N	\N
1573	215	13	Sentence completion for Question 13	\N	\N	\N
1574	216	14	Statement for Question 14	\N	\N	\N
1575	216	15	Statement for Question 15	\N	\N	\N
1576	216	16	Statement for Question 16	\N	\N	\N
1577	216	17	Statement for Question 17	\N	\N	\N
1578	216	18	Statement for Question 18	\N	\N	\N
1579	216	19	Statement for Question 19	\N	\N	\N
1580	216	20	Statement for Question 20	\N	\N	\N
1581	217	21	Sentence completion for Question 21	\N	\N	\N
1582	217	22	Sentence completion for Question 22	\N	\N	\N
1583	217	23	Sentence completion for Question 23	\N	\N	\N
1584	217	24	Sentence completion for Question 24	\N	\N	\N
1585	217	25	Sentence completion for Question 25	\N	\N	\N
1586	217	26	Sentence completion for Question 26	\N	\N	\N
1587	218	27	Statement for Question 27	\N	\N	\N
1588	218	28	Statement for Question 28	\N	\N	\N
1589	218	29	Statement for Question 29	\N	\N	\N
1590	218	30	Statement for Question 30	\N	\N	\N
1591	218	31	Statement for Question 31	\N	\N	\N
1592	218	32	Statement for Question 32	\N	\N	\N
1593	218	33	Statement for Question 33	\N	\N	\N
1594	219	34	Sentence completion for Question 34	\N	\N	\N
1595	219	35	Sentence completion for Question 35	\N	\N	\N
1596	219	36	Sentence completion for Question 36	\N	\N	\N
1597	219	37	Sentence completion for Question 37	\N	\N	\N
1598	219	38	Sentence completion for Question 38	\N	\N	\N
1599	219	39	Sentence completion for Question 39	\N	\N	\N
1600	219	40	Sentence completion for Question 40	\N	\N	\N
1601	220	1	Information item for Question 1	\N	\N	\N
1602	220	2	Information item for Question 2	\N	\N	\N
1603	220	3	Information item for Question 3	\N	\N	\N
1604	220	4	Information item for Question 4	\N	\N	\N
1605	220	5	Information item for Question 5	\N	\N	\N
1606	220	6	Information item for Question 6	\N	\N	\N
1607	220	7	Information item for Question 7	\N	\N	\N
1608	220	8	Information item for Question 8	\N	\N	\N
1609	220	9	Information item for Question 9	\N	\N	\N
1610	220	10	Information item for Question 10	\N	\N	\N
1611	221	11	Information item for Question 11	\N	\N	\N
1612	221	12	Information item for Question 12	\N	\N	\N
1613	221	13	Information item for Question 13	\N	\N	\N
1614	221	14	Information item for Question 14	\N	\N	\N
1615	221	15	Information item for Question 15	\N	\N	\N
1616	221	16	Information item for Question 16	\N	\N	\N
1617	221	17	Information item for Question 17	\N	\N	\N
1618	221	18	Information item for Question 18	\N	\N	\N
1619	221	19	Information item for Question 19	\N	\N	\N
1620	221	20	Information item for Question 20	\N	\N	\N
1621	222	21	Information item for Question 21	\N	\N	\N
1622	222	22	Information item for Question 22	\N	\N	\N
1623	222	23	Information item for Question 23	\N	\N	\N
1624	222	24	Information item for Question 24	\N	\N	\N
1625	222	25	Information item for Question 25	\N	\N	\N
1626	222	26	Information item for Question 26	\N	\N	\N
1627	222	27	Information item for Question 27	\N	\N	\N
1628	222	28	Information item for Question 28	\N	\N	\N
1629	222	29	Information item for Question 29	\N	\N	\N
1630	222	30	Information item for Question 30	\N	\N	\N
1631	223	31	Information item for Question 31	\N	\N	\N
1632	223	32	Information item for Question 32	\N	\N	\N
1633	223	33	Information item for Question 33	\N	\N	\N
1634	223	34	Information item for Question 34	\N	\N	\N
1635	223	35	Information item for Question 35	\N	\N	\N
1636	223	36	Information item for Question 36	\N	\N	\N
1637	223	37	Information item for Question 37	\N	\N	\N
1638	223	38	Information item for Question 38	\N	\N	\N
1639	223	39	Information item for Question 39	\N	\N	\N
1640	223	40	Information item for Question 40	\N	\N	\N
1641	224	1	Statement for Question 1	\N	\N	\N
1642	224	2	Statement for Question 2	\N	\N	\N
1643	224	3	Statement for Question 3	\N	\N	\N
1644	224	4	Statement for Question 4	\N	\N	\N
1645	224	5	Statement for Question 5	\N	\N	\N
1646	224	6	Statement for Question 6	\N	\N	\N
1647	224	7	Statement for Question 7	\N	\N	\N
1648	225	8	Sentence completion for Question 8	\N	\N	\N
1649	225	9	Sentence completion for Question 9	\N	\N	\N
1650	225	10	Sentence completion for Question 10	\N	\N	\N
1651	225	11	Sentence completion for Question 11	\N	\N	\N
1652	225	12	Sentence completion for Question 12	\N	\N	\N
1653	225	13	Sentence completion for Question 13	\N	\N	\N
1654	226	14	Statement for Question 14	\N	\N	\N
1655	226	15	Statement for Question 15	\N	\N	\N
1656	226	16	Statement for Question 16	\N	\N	\N
1657	226	17	Statement for Question 17	\N	\N	\N
1658	226	18	Statement for Question 18	\N	\N	\N
1659	226	19	Statement for Question 19	\N	\N	\N
1660	226	20	Statement for Question 20	\N	\N	\N
1661	227	21	Sentence completion for Question 21	\N	\N	\N
1662	227	22	Sentence completion for Question 22	\N	\N	\N
1663	227	23	Sentence completion for Question 23	\N	\N	\N
1664	227	24	Sentence completion for Question 24	\N	\N	\N
1665	227	25	Sentence completion for Question 25	\N	\N	\N
1666	227	26	Sentence completion for Question 26	\N	\N	\N
1667	228	27	Statement for Question 27	\N	\N	\N
1668	228	28	Statement for Question 28	\N	\N	\N
1669	228	29	Statement for Question 29	\N	\N	\N
1670	228	30	Statement for Question 30	\N	\N	\N
1671	228	31	Statement for Question 31	\N	\N	\N
1672	228	32	Statement for Question 32	\N	\N	\N
1673	228	33	Statement for Question 33	\N	\N	\N
1674	229	34	Sentence completion for Question 34	\N	\N	\N
1675	229	35	Sentence completion for Question 35	\N	\N	\N
1676	229	36	Sentence completion for Question 36	\N	\N	\N
1677	229	37	Sentence completion for Question 37	\N	\N	\N
1678	229	38	Sentence completion for Question 38	\N	\N	\N
1679	229	39	Sentence completion for Question 39	\N	\N	\N
1680	229	40	Sentence completion for Question 40	\N	\N	\N
1681	230	1	Information item for Question 1	\N	\N	\N
1682	230	2	Information item for Question 2	\N	\N	\N
1683	230	3	Information item for Question 3	\N	\N	\N
1684	230	4	Information item for Question 4	\N	\N	\N
1685	230	5	Information item for Question 5	\N	\N	\N
1686	230	6	Information item for Question 6	\N	\N	\N
1687	230	7	Information item for Question 7	\N	\N	\N
1688	230	8	Information item for Question 8	\N	\N	\N
1689	230	9	Information item for Question 9	\N	\N	\N
1690	230	10	Information item for Question 10	\N	\N	\N
1691	231	11	Information item for Question 11	\N	\N	\N
1692	231	12	Information item for Question 12	\N	\N	\N
1693	231	13	Information item for Question 13	\N	\N	\N
1694	231	14	Information item for Question 14	\N	\N	\N
1695	231	15	Information item for Question 15	\N	\N	\N
1696	231	16	Information item for Question 16	\N	\N	\N
1697	231	17	Information item for Question 17	\N	\N	\N
1698	231	18	Information item for Question 18	\N	\N	\N
1699	231	19	Information item for Question 19	\N	\N	\N
1700	231	20	Information item for Question 20	\N	\N	\N
1701	232	21	Information item for Question 21	\N	\N	\N
1702	232	22	Information item for Question 22	\N	\N	\N
1703	232	23	Information item for Question 23	\N	\N	\N
1704	232	24	Information item for Question 24	\N	\N	\N
1705	232	25	Information item for Question 25	\N	\N	\N
1706	232	26	Information item for Question 26	\N	\N	\N
1707	232	27	Information item for Question 27	\N	\N	\N
1708	232	28	Information item for Question 28	\N	\N	\N
1709	232	29	Information item for Question 29	\N	\N	\N
1710	232	30	Information item for Question 30	\N	\N	\N
1711	233	31	Information item for Question 31	\N	\N	\N
1712	233	32	Information item for Question 32	\N	\N	\N
1713	233	33	Information item for Question 33	\N	\N	\N
1714	233	34	Information item for Question 34	\N	\N	\N
1715	233	35	Information item for Question 35	\N	\N	\N
1716	233	36	Information item for Question 36	\N	\N	\N
1717	233	37	Information item for Question 37	\N	\N	\N
1718	233	38	Information item for Question 38	\N	\N	\N
1719	233	39	Information item for Question 39	\N	\N	\N
1720	233	40	Information item for Question 40	\N	\N	\N
1721	234	1	Statement for Question 1	\N	\N	\N
1722	234	2	Statement for Question 2	\N	\N	\N
1723	234	3	Statement for Question 3	\N	\N	\N
1724	234	4	Statement for Question 4	\N	\N	\N
1725	234	5	Statement for Question 5	\N	\N	\N
1726	234	6	Statement for Question 6	\N	\N	\N
1727	234	7	Statement for Question 7	\N	\N	\N
1728	235	8	Sentence completion for Question 8	\N	\N	\N
1729	235	9	Sentence completion for Question 9	\N	\N	\N
1730	235	10	Sentence completion for Question 10	\N	\N	\N
1731	235	11	Sentence completion for Question 11	\N	\N	\N
1732	235	12	Sentence completion for Question 12	\N	\N	\N
1733	235	13	Sentence completion for Question 13	\N	\N	\N
1734	236	14	Statement for Question 14	\N	\N	\N
1735	236	15	Statement for Question 15	\N	\N	\N
1736	236	16	Statement for Question 16	\N	\N	\N
1737	236	17	Statement for Question 17	\N	\N	\N
1738	236	18	Statement for Question 18	\N	\N	\N
1739	236	19	Statement for Question 19	\N	\N	\N
1740	236	20	Statement for Question 20	\N	\N	\N
1741	237	21	Sentence completion for Question 21	\N	\N	\N
1742	237	22	Sentence completion for Question 22	\N	\N	\N
1743	237	23	Sentence completion for Question 23	\N	\N	\N
1744	237	24	Sentence completion for Question 24	\N	\N	\N
1745	237	25	Sentence completion for Question 25	\N	\N	\N
1746	237	26	Sentence completion for Question 26	\N	\N	\N
1747	238	27	Statement for Question 27	\N	\N	\N
1748	238	28	Statement for Question 28	\N	\N	\N
1749	238	29	Statement for Question 29	\N	\N	\N
1750	238	30	Statement for Question 30	\N	\N	\N
1751	238	31	Statement for Question 31	\N	\N	\N
1752	238	32	Statement for Question 32	\N	\N	\N
1753	238	33	Statement for Question 33	\N	\N	\N
1754	239	34	Sentence completion for Question 34	\N	\N	\N
1755	239	35	Sentence completion for Question 35	\N	\N	\N
1756	239	36	Sentence completion for Question 36	\N	\N	\N
1757	239	37	Sentence completion for Question 37	\N	\N	\N
1758	239	38	Sentence completion for Question 38	\N	\N	\N
1759	239	39	Sentence completion for Question 39	\N	\N	\N
1760	239	40	Sentence completion for Question 40	\N	\N	\N
1761	240	1	Information item for Question 1	\N	\N	\N
1762	240	2	Information item for Question 2	\N	\N	\N
1763	240	3	Information item for Question 3	\N	\N	\N
1764	240	4	Information item for Question 4	\N	\N	\N
1765	240	5	Information item for Question 5	\N	\N	\N
1766	240	6	Information item for Question 6	\N	\N	\N
1767	240	7	Information item for Question 7	\N	\N	\N
1768	240	8	Information item for Question 8	\N	\N	\N
1769	240	9	Information item for Question 9	\N	\N	\N
1770	240	10	Information item for Question 10	\N	\N	\N
1771	241	11	Information item for Question 11	\N	\N	\N
1772	241	12	Information item for Question 12	\N	\N	\N
1773	241	13	Information item for Question 13	\N	\N	\N
1774	241	14	Information item for Question 14	\N	\N	\N
1775	241	15	Information item for Question 15	\N	\N	\N
1776	241	16	Information item for Question 16	\N	\N	\N
1777	241	17	Information item for Question 17	\N	\N	\N
1778	241	18	Information item for Question 18	\N	\N	\N
1779	241	19	Information item for Question 19	\N	\N	\N
1780	241	20	Information item for Question 20	\N	\N	\N
1781	242	21	Information item for Question 21	\N	\N	\N
1782	242	22	Information item for Question 22	\N	\N	\N
1783	242	23	Information item for Question 23	\N	\N	\N
1784	242	24	Information item for Question 24	\N	\N	\N
1785	242	25	Information item for Question 25	\N	\N	\N
1786	242	26	Information item for Question 26	\N	\N	\N
1787	242	27	Information item for Question 27	\N	\N	\N
1788	242	28	Information item for Question 28	\N	\N	\N
1789	242	29	Information item for Question 29	\N	\N	\N
1790	242	30	Information item for Question 30	\N	\N	\N
1791	243	31	Information item for Question 31	\N	\N	\N
1792	243	32	Information item for Question 32	\N	\N	\N
1793	243	33	Information item for Question 33	\N	\N	\N
1794	243	34	Information item for Question 34	\N	\N	\N
1795	243	35	Information item for Question 35	\N	\N	\N
1796	243	36	Information item for Question 36	\N	\N	\N
1797	243	37	Information item for Question 37	\N	\N	\N
1798	243	38	Information item for Question 38	\N	\N	\N
1799	243	39	Information item for Question 39	\N	\N	\N
1800	243	40	Information item for Question 40	\N	\N	\N
1801	244	1	Statement for Question 1	\N	\N	\N
1802	244	2	Statement for Question 2	\N	\N	\N
1803	244	3	Statement for Question 3	\N	\N	\N
1804	244	4	Statement for Question 4	\N	\N	\N
1805	244	5	Statement for Question 5	\N	\N	\N
1806	244	6	Statement for Question 6	\N	\N	\N
1807	244	7	Statement for Question 7	\N	\N	\N
1808	245	8	Sentence completion for Question 8	\N	\N	\N
1809	245	9	Sentence completion for Question 9	\N	\N	\N
1810	245	10	Sentence completion for Question 10	\N	\N	\N
1811	245	11	Sentence completion for Question 11	\N	\N	\N
1812	245	12	Sentence completion for Question 12	\N	\N	\N
1813	245	13	Sentence completion for Question 13	\N	\N	\N
1814	246	14	Statement for Question 14	\N	\N	\N
1815	246	15	Statement for Question 15	\N	\N	\N
1816	246	16	Statement for Question 16	\N	\N	\N
1817	246	17	Statement for Question 17	\N	\N	\N
1818	246	18	Statement for Question 18	\N	\N	\N
1819	246	19	Statement for Question 19	\N	\N	\N
1820	246	20	Statement for Question 20	\N	\N	\N
1821	247	21	Sentence completion for Question 21	\N	\N	\N
1822	247	22	Sentence completion for Question 22	\N	\N	\N
1823	247	23	Sentence completion for Question 23	\N	\N	\N
1824	247	24	Sentence completion for Question 24	\N	\N	\N
1825	247	25	Sentence completion for Question 25	\N	\N	\N
1826	247	26	Sentence completion for Question 26	\N	\N	\N
1827	248	27	Statement for Question 27	\N	\N	\N
1828	248	28	Statement for Question 28	\N	\N	\N
1829	248	29	Statement for Question 29	\N	\N	\N
1830	248	30	Statement for Question 30	\N	\N	\N
1831	248	31	Statement for Question 31	\N	\N	\N
1832	248	32	Statement for Question 32	\N	\N	\N
1833	248	33	Statement for Question 33	\N	\N	\N
1834	249	34	Sentence completion for Question 34	\N	\N	\N
1835	249	35	Sentence completion for Question 35	\N	\N	\N
1836	249	36	Sentence completion for Question 36	\N	\N	\N
1837	249	37	Sentence completion for Question 37	\N	\N	\N
1838	249	38	Sentence completion for Question 38	\N	\N	\N
1839	249	39	Sentence completion for Question 39	\N	\N	\N
1840	249	40	Sentence completion for Question 40	\N	\N	\N
1841	250	1	Information item for Question 1	\N	\N	\N
1842	250	2	Information item for Question 2	\N	\N	\N
1843	250	3	Information item for Question 3	\N	\N	\N
1844	250	4	Information item for Question 4	\N	\N	\N
1845	250	5	Information item for Question 5	\N	\N	\N
1846	250	6	Information item for Question 6	\N	\N	\N
1847	250	7	Information item for Question 7	\N	\N	\N
1848	250	8	Information item for Question 8	\N	\N	\N
1849	250	9	Information item for Question 9	\N	\N	\N
1850	250	10	Information item for Question 10	\N	\N	\N
1851	251	11	Information item for Question 11	\N	\N	\N
1852	251	12	Information item for Question 12	\N	\N	\N
1853	251	13	Information item for Question 13	\N	\N	\N
1854	251	14	Information item for Question 14	\N	\N	\N
1855	251	15	Information item for Question 15	\N	\N	\N
1856	251	16	Information item for Question 16	\N	\N	\N
1857	251	17	Information item for Question 17	\N	\N	\N
1858	251	18	Information item for Question 18	\N	\N	\N
1859	251	19	Information item for Question 19	\N	\N	\N
1860	251	20	Information item for Question 20	\N	\N	\N
1861	252	21	Information item for Question 21	\N	\N	\N
1862	252	22	Information item for Question 22	\N	\N	\N
1863	252	23	Information item for Question 23	\N	\N	\N
1864	252	24	Information item for Question 24	\N	\N	\N
1865	252	25	Information item for Question 25	\N	\N	\N
1866	252	26	Information item for Question 26	\N	\N	\N
1867	252	27	Information item for Question 27	\N	\N	\N
1868	252	28	Information item for Question 28	\N	\N	\N
1869	252	29	Information item for Question 29	\N	\N	\N
1870	252	30	Information item for Question 30	\N	\N	\N
1871	253	31	Information item for Question 31	\N	\N	\N
1872	253	32	Information item for Question 32	\N	\N	\N
1873	253	33	Information item for Question 33	\N	\N	\N
1874	253	34	Information item for Question 34	\N	\N	\N
1875	253	35	Information item for Question 35	\N	\N	\N
1876	253	36	Information item for Question 36	\N	\N	\N
1877	253	37	Information item for Question 37	\N	\N	\N
1878	253	38	Information item for Question 38	\N	\N	\N
1879	253	39	Information item for Question 39	\N	\N	\N
1880	253	40	Information item for Question 40	\N	\N	\N
1881	254	1	Statement for Question 1	\N	\N	\N
1882	254	2	Statement for Question 2	\N	\N	\N
1883	254	3	Statement for Question 3	\N	\N	\N
1884	254	4	Statement for Question 4	\N	\N	\N
1885	254	5	Statement for Question 5	\N	\N	\N
1886	254	6	Statement for Question 6	\N	\N	\N
1887	254	7	Statement for Question 7	\N	\N	\N
1888	255	8	Sentence completion for Question 8	\N	\N	\N
1889	255	9	Sentence completion for Question 9	\N	\N	\N
1890	255	10	Sentence completion for Question 10	\N	\N	\N
1891	255	11	Sentence completion for Question 11	\N	\N	\N
1892	255	12	Sentence completion for Question 12	\N	\N	\N
1893	255	13	Sentence completion for Question 13	\N	\N	\N
1894	256	14	Statement for Question 14	\N	\N	\N
1895	256	15	Statement for Question 15	\N	\N	\N
1896	256	16	Statement for Question 16	\N	\N	\N
1897	256	17	Statement for Question 17	\N	\N	\N
1898	256	18	Statement for Question 18	\N	\N	\N
1899	256	19	Statement for Question 19	\N	\N	\N
1900	256	20	Statement for Question 20	\N	\N	\N
1901	257	21	Sentence completion for Question 21	\N	\N	\N
1902	257	22	Sentence completion for Question 22	\N	\N	\N
1903	257	23	Sentence completion for Question 23	\N	\N	\N
1904	257	24	Sentence completion for Question 24	\N	\N	\N
1905	257	25	Sentence completion for Question 25	\N	\N	\N
1906	257	26	Sentence completion for Question 26	\N	\N	\N
1907	258	27	Statement for Question 27	\N	\N	\N
1908	258	28	Statement for Question 28	\N	\N	\N
1909	258	29	Statement for Question 29	\N	\N	\N
1910	258	30	Statement for Question 30	\N	\N	\N
1911	258	31	Statement for Question 31	\N	\N	\N
1912	258	32	Statement for Question 32	\N	\N	\N
1913	258	33	Statement for Question 33	\N	\N	\N
1914	259	34	Sentence completion for Question 34	\N	\N	\N
1915	259	35	Sentence completion for Question 35	\N	\N	\N
1916	259	36	Sentence completion for Question 36	\N	\N	\N
1917	259	37	Sentence completion for Question 37	\N	\N	\N
1918	259	38	Sentence completion for Question 38	\N	\N	\N
1919	259	39	Sentence completion for Question 39	\N	\N	\N
1920	259	40	Sentence completion for Question 40	\N	\N	\N
\.


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.sections (id, test_id, skill, part_number, page_start, page_end) FROM stdin;
1	1	listening	1	10	10
2	1	listening	2	11	12
3	1	listening	3	13	14
4	1	listening	4	15	15
5	1	reading	1	16	19
6	1	reading	2	20	24
7	1	reading	3	25	29
8	2	listening	1	31	31
9	2	listening	2	32	33
10	2	listening	3	34	35
11	2	listening	4	36	36
12	2	reading	1	37	40
13	2	reading	2	41	45
14	2	reading	3	46	51
15	3	listening	1	52	52
16	3	listening	2	53	54
17	3	listening	3	55	56
18	3	listening	4	57	57
19	3	reading	1	58	62
20	3	reading	2	63	67
21	3	reading	3	68	73
22	4	listening	1	74	74
23	4	listening	2	75	76
24	4	listening	3	77	78
25	4	listening	4	79	79
26	4	reading	1	80	84
27	4	reading	2	85	89
28	4	reading	3	90	95
29	5	listening	1	12	12
30	5	listening	2	14	14
31	5	listening	3	16	16
32	5	listening	4	18	18
33	5	reading	1	21	23
34	5	reading	2	24	26
35	5	reading	3	27	29
36	6	listening	1	32	32
37	6	listening	2	34	34
38	6	listening	3	36	36
39	6	listening	4	38	38
40	6	reading	1	41	43
41	6	reading	2	44	46
42	6	reading	3	47	49
43	7	listening	1	52	52
44	7	listening	2	54	54
45	7	listening	3	56	56
46	7	listening	4	58	58
47	7	reading	1	61	63
48	7	reading	2	64	66
49	7	reading	3	67	69
50	8	listening	1	72	72
51	8	listening	2	74	74
52	8	listening	3	76	76
53	8	listening	4	78	78
54	8	reading	1	81	83
55	8	reading	2	84	86
56	8	reading	3	87	89
57	9	listening	1	12	12
58	9	listening	2	14	14
59	9	listening	3	16	16
60	9	listening	4	18	18
61	9	reading	1	21	23
62	9	reading	2	24	26
63	9	reading	3	27	29
64	10	listening	1	32	32
65	10	listening	2	34	34
66	10	listening	3	36	36
67	10	listening	4	38	38
68	10	reading	1	41	43
69	10	reading	2	44	46
70	10	reading	3	47	49
71	11	listening	1	52	52
72	11	listening	2	54	54
73	11	listening	3	56	56
74	11	listening	4	58	58
75	11	reading	1	61	63
76	11	reading	2	64	66
77	11	reading	3	67	69
78	12	listening	1	72	72
79	12	listening	2	74	74
80	12	listening	3	76	76
81	12	listening	4	78	78
82	12	reading	1	81	83
83	12	reading	2	84	86
84	12	reading	3	87	89
85	13	listening	1	12	12
86	13	listening	2	14	14
87	13	listening	3	16	16
88	13	listening	4	18	18
89	13	reading	1	21	23
90	13	reading	2	24	26
91	13	reading	3	27	29
92	14	listening	1	32	32
93	14	listening	2	34	34
94	14	listening	3	36	36
95	14	listening	4	38	38
96	14	reading	1	41	43
97	14	reading	2	44	46
98	14	reading	3	47	49
99	15	listening	1	52	52
100	15	listening	2	54	54
101	15	listening	3	56	56
102	15	listening	4	58	58
103	15	reading	1	61	63
104	15	reading	2	64	66
105	15	reading	3	67	69
106	16	listening	1	72	72
107	16	listening	2	74	74
108	16	listening	3	76	76
109	16	listening	4	78	78
110	16	reading	1	81	83
111	16	reading	2	84	86
112	16	reading	3	87	89
113	17	listening	1	12	12
114	17	listening	2	14	14
115	17	listening	3	16	16
116	17	listening	4	18	18
117	17	reading	1	21	23
118	17	reading	2	24	26
119	17	reading	3	27	29
120	18	listening	1	32	32
121	18	listening	2	34	34
122	18	listening	3	36	36
123	18	listening	4	38	38
124	18	reading	1	41	43
125	18	reading	2	44	46
126	18	reading	3	47	49
127	19	listening	1	52	52
128	19	listening	2	54	54
129	19	listening	3	56	56
130	19	listening	4	58	58
131	19	reading	1	61	63
132	19	reading	2	64	66
133	19	reading	3	67	69
134	20	listening	1	72	72
135	20	listening	2	74	74
136	20	listening	3	76	76
137	20	listening	4	78	78
138	20	reading	1	81	83
139	20	reading	2	84	86
140	20	reading	3	87	89
141	21	listening	1	12	12
142	21	listening	2	14	14
143	21	listening	3	16	16
144	21	listening	4	18	18
145	21	reading	1	21	23
146	21	reading	2	24	26
147	21	reading	3	27	29
148	22	listening	1	32	32
149	22	listening	2	34	34
150	22	listening	3	36	36
151	22	listening	4	38	38
152	22	reading	1	41	43
153	22	reading	2	44	46
154	22	reading	3	47	49
155	23	listening	1	52	52
156	23	listening	2	54	54
157	23	listening	3	56	56
158	23	listening	4	58	58
159	23	reading	1	61	63
160	23	reading	2	64	66
161	23	reading	3	67	69
162	24	listening	1	72	72
163	24	listening	2	74	74
164	24	listening	3	76	76
165	24	listening	4	78	78
166	24	reading	1	81	83
167	24	reading	2	84	86
168	24	reading	3	87	89
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tests (id, book_id, test_number) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	2	1
6	2	2
7	2	3
8	2	4
9	3	1
10	3	2
11	3	3
12	3	4
13	4	1
14	4	2
15	4	3
16	4	4
17	5	1
18	5	2
19	5	3
20	5	4
21	6	1
22	6	2
23	6	3
24	6	4
\.


--
-- Data for Name: user_answers; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_answers (id, attempt_id, question_id, given_answer, is_correct) FROM stdin;
1	1	1	Jamieson	t
2	2	1	james	f
\.


--
-- Data for Name: user_attempts; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attempts (id, user_id, section_id, started_at, finished_at) FROM stdin;
1	1	1	2026-08-31 22:39:48.167739+07	2026-08-31 22:39:48.183064+07
2	2	1	2026-08-31 22:54:36.260104+07	2026-08-31 22:56:51.642416+07
3	2	1	2026-08-31 22:56:59.197766+07	\N
4	2	8	2026-08-31 22:57:05.732989+07	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, password_hash, is_admin, created_at) FROM stdin;
1	admin	332ef5d1c148cddfc57688dae8e7df559632ba17c1bfdc051b3f031a7a3f0913	t	2026-08-31 22:39:48.093784+07
2	student	d2b8a5bd97f4f058e6668e784a22293970f9a19c1580e7260f31ccd0e8d7d9b8	f	2026-08-31 22:54:18.487201+07
\.


--
-- Name: answer_keys_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.answer_keys_id_seq', 1920, true);


--
-- Name: audio_tracks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.audio_tracks_id_seq', 48, true);


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.books_id_seq', 6, true);


--
-- Name: passages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.passages_id_seq', 72, true);


--
-- Name: question_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.question_groups_id_seq', 259, true);


--
-- Name: question_options_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.question_options_id_seq', 832, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.questions_id_seq', 1920, true);


--
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.sections_id_seq', 168, true);


--
-- Name: tests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.tests_id_seq', 24, true);


--
-- Name: user_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_answers_id_seq', 2, true);


--
-- Name: user_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_attempts_id_seq', 4, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: answer_keys answer_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answer_keys
    ADD CONSTRAINT answer_keys_pkey PRIMARY KEY (id);


--
-- Name: answer_keys answer_keys_question_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answer_keys
    ADD CONSTRAINT answer_keys_question_id_key UNIQUE (question_id);


--
-- Name: audio_tracks audio_tracks_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.audio_tracks
    ADD CONSTRAINT audio_tracks_pkey PRIMARY KEY (id);


--
-- Name: audio_tracks audio_tracks_section_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.audio_tracks
    ADD CONSTRAINT audio_tracks_section_id_key UNIQUE (section_id);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: passages passages_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.passages
    ADD CONSTRAINT passages_pkey PRIMARY KEY (id);


--
-- Name: question_groups question_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.question_groups
    ADD CONSTRAINT question_groups_pkey PRIMARY KEY (id);


--
-- Name: question_options question_options_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_pkey PRIMARY KEY (id);


--
-- Name: questions questions_group_id_question_number_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_group_id_question_number_key UNIQUE (group_id, question_number);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: sections sections_test_id_skill_part_number_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_test_id_skill_part_number_key UNIQUE (test_id, skill, part_number);


--
-- Name: tests tests_book_id_test_number_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_book_id_test_number_key UNIQUE (book_id, test_number);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: user_answers user_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_pkey PRIMARY KEY (id);


--
-- Name: user_attempts user_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attempts
    ADD CONSTRAINT user_attempts_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: answer_keys answer_keys_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.answer_keys
    ADD CONSTRAINT answer_keys_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: audio_tracks audio_tracks_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.audio_tracks
    ADD CONSTRAINT audio_tracks_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: passages passages_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.passages
    ADD CONSTRAINT passages_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: question_groups question_groups_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.question_groups
    ADD CONSTRAINT question_groups_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.sections(id) ON DELETE CASCADE;


--
-- Name: question_options question_options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.question_options
    ADD CONSTRAINT question_options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE;


--
-- Name: questions questions_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.question_groups(id) ON DELETE CASCADE;


--
-- Name: sections sections_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.sections
    ADD CONSTRAINT sections_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(id) ON DELETE CASCADE;


--
-- Name: tests tests_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: user_answers user_answers_attempt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_attempt_id_fkey FOREIGN KEY (attempt_id) REFERENCES public.user_attempts(id) ON DELETE CASCADE;


--
-- Name: user_answers user_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_answers
    ADD CONSTRAINT user_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.questions(id);


--
-- Name: user_attempts user_attempts_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attempts
    ADD CONSTRAINT user_attempts_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.sections(id);


--
-- Name: user_attempts user_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.user_attempts
    ADD CONSTRAINT user_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict if93ZGRcuKIELxizNlucyslDP3IBtBAiUB31PabPCxTsYh2vYXAUo6thbpDpZ2B

