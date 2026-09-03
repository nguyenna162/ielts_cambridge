--
-- PostgreSQL database dump
--

\restrict 2Sg5cFuOwH70agoaBgxceldgQTok85HH6tQZFW5ATY63wVCGFqqeib2kWdR72mS

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
26	44	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 2.mp3	a06d4be643fba3c93b74ee01b9e4cd7355febc41e59f3f132c35efc61b87d83f	300
17	29	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 1.mp3	39c82e95f451177791d906ce4e71a825af51d8189bfea8069f6c8fe59ae364e6	300
18	30	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 2.mp3	9fcb8ec64bd54fbe4959c4b0fb8514f3ba70aa1b9e574ef7b46791474ec26461	300
19	31	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 3.mp3	66e59fd1ff69b32f19c53177d5862b223de15e8adc35da776a67871468c96569	300
20	32	cambridge-ielts-10/audio/IELTS 10 Test 1 Section 4.mp3	efc23eefcf168e386b641cb7b78333777b6b4733b320ab2d34489d607620ae2d	300
21	36	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 1.mp3	6d2f974bcad007fa3e82a1f51178c3cd41ad33d549ef2c438e1565032cc84255	300
22	37	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 2.mp3	71b149b5f77342c6b2286a2d063f1b921261211807c7cd75cff78a3158074021	300
23	38	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 3.mp3	bb10976d6ed326f462d84b2c644d7a5facdc90b20be24e114f989ebdc13d712e	300
24	39	cambridge-ielts-10/audio/IELTS 10 Test 2 Section 4.mp3	359b5837fd538a8967b4820ff63b3835ffa146455458a2cc18947e3cfa2ccb47	300
25	43	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 1.mp3	6516521325d66d23d3d43ddd00bf06f70e8ff766943565757664a7f410429574	300
27	45	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 3.mp3	4ddf7928b15293aecadd090fcc0ccca7dd71c4f2f8c4d39413bdbd955308f10c	300
28	46	cambridge-ielts-10/audio/IELTS 10 Test 3 Section 4.mp3	700c5cb83ad86125a78d556479fcb75532b517ce02fa9281983d38e8981d3517	300
29	50	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 1.mp3	718d0e60f5993069b31984201ac7fe57a67e57ad9fd5eb4f760959c5e5549e05	300
30	51	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 2.mp3	769158231df1b766639998d4d650070dc74d826d6d9c269bae574168b1a3de12	300
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
1	1	cambridge-ielts-15/audio/ielts15_test1_audio1.m4a	c4f0efe14b9a8e3362e2cfee5f028dbc87c05758b078d4124213aea504a27362	460.25
5	8	cambridge-ielts-15/audio/ielts15_test2_audio1.m4a	b6038832cd2cccf0b6750541e817ef4da6827f65ae543bcdfe37f05a45ba935e	487
31	52	cambridge-ielts-10/audio/IELTS 10 Test 4 Section 3.mp3	c22d7ea54ce6fd0acdf3a6452dd8581c6fbbfca70e3e21145cd9fde220a1a703	300
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
2	Cambridge IELTS 10	178	cambridge-ielts-10/source/book.pdf	0aeed1819673c6eedf6dcf77ab4e82ae097af17310b40b5ac0c64421d0f824f6	2026-08-31 23:10:16.037421+07
3	Cambridge IELTS 11	146	cambridge-ielts-11/source/book.pdf	2249e9db6a14822f5508ea2b2014712a9b716ce69a6672430ce5f690ab141f3f	2026-08-31 23:10:16.722461+07
4	Cambridge IELTS 12	131	cambridge-ielts-12/source/book.pdf	8ef4aa53dfb50dd17f89f5c9ec545b12ace34681967d553ff459311f44935300	2026-08-31 23:10:17.463889+07
5	Cambridge IELTS 13	140	cambridge-ielts-13/source/book.pdf	96fe590ec5cd371a9ff1a8cd962552eb89cd48022cbc5c82df2e1c67e36e8259	2026-08-31 23:10:18.279374+07
6	Cambridge IELTS 14	136	cambridge-ielts-14/source/book.pdf	f3b720cb1a975c412196cb55432067c33ec0c5b3cf5bae588c985aada861721c	2026-08-31 23:10:19.118214+07
\.


--
-- Data for Name: passages; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.passages (id, section_id, title, body_text) FROM stdin;
2	6	Driverless cars	riverless cars\n\nThe automotive sector is well used to adapting to automation in manufacturing. The implementation of robotic car manufacture from the 1970s onwards led to significant cost savings and improvements in the reliability and flexibility of vehicle mass production. A new challenge to vehicle production is now on the horizon and, again, it comes from automation. However, this time it is not to do with the manufacturing process, but with the vehicles themselves.\n\nResearch projects on vehicle automation are not new. Vehicles with limited self- driving capabilities have been around for more than 50 years, resulting in significant contributions towards driver assistance systems. But since Google announced in 2010 that it had been trialling self-driving cars on the streets of California, progress in this field has quickly gathered pace.\n\nThere are many reasons why technology is advancing so fast. One frequently cited motive is safety; indeed, research at the UK's Transport Research Laboratory has demonstrated that more than 90 percent of road collisions involve human error as a contributory factor, and it is the primary cause in the vast majority. Automation may help to reduce the incidence of this.\n\nAnother aim is to free the time people spend driving for other purposes. If the vehicle can do some or all of the driving, it may be possible to be productive, to socialise or simply to relax while automation systems have responsibility for safe control of the vehicle. If the vehicle can do the driving, those who are challenged by existing mobility models - such as older or disabled travellers - may be able to enjoy significantly greater travel autonomy.\n\nBeyond these direct benefits, we can consider the wider implications for transport and society, and how manufacturing processes might need to respond as a result. At present, the average car spends more than 90 percent of its life parked. Automation means that initiatives for car-sharing become much more viable, particularly in urban areas with significant travel demand. If a significant proportion of the population choose to use shared automated vehicles, mobility demand can be met by far fewer vehicles.\n\nThe Massachusetts Institute of Technology investigated automated mobility in Singapore, finding that fewer than 30 percent of the vehicles currently used would be required if fully automated car sharing could be implemented. If this is the case, it might mean that we need to manufacture far fewer vehicles to meet demand.\n\n**Section E**\n\n**Section F**\n\nG However, the number of trips being taken would probably increase, partly because empty vehicles would have to be moved from one customer to the next.\n\nModelling work by the University of Michigan Transportation Research Institute suggests automated vehicles might reduce vehicle ownership by 43 percent, but that vehicles' average annual mileage would double as a result. As a consequence, each vehicle would be used more intensively, and might need replacing sooner. This faster rate of turnover may mean that vehicle production will not necessarily decrease.\n\nAutomation may prompt other changes in vehicle manufacture. If we move to a model where consumers are tending not to own a single vehicle but to purchase access to a range of vehicles through a mobility provider, drivers will have the freedom to select one that best suits their needs for a particular journey, rather than making a compromise across all their requirements.\n\nSince, for most of the time, most of the seats in most cars are unoccupied, this may boost production of a smaller, more efficient range of vehicles that suit the needs of individuals. Specialised vehicles may then be available for exceptional journeys, such as going on a family camping trip or helping a son or daughter move to university.\n\nThere are a number of hurdles to overcome in delivering automated vehicles to our roads. These include the technical difficulties in ensuring that the vehicle works reliably in the infinite range of traffic, weather and road situations it might encounter; the regulatory challenges in understanding how liability and enforcement might change when drivers are no longer essential for vehicle operation; and the societal changes that may be required for communities to trust and accept automated vehicles as being a valuable part of the mobility landscape.\n\nIt's clear that there are many challenges that need to be addressed but, through robust and targeted research, these can most probably be conquered within the next 10 years. Mobility will change in such potentially significant ways and in association with so many other technological developments, such as telepresence and virtual reality, that it is hard to make concrete predictions about the future. However, one thing is certain: change is coming, and the need to be flexible in response to this will be vital for those involved in manufacturing the vehicles that will deliver future mobility.
3	7	What is exploration?	We are all explorers. Our desire to discover, and then share that new-found knowledge, is part of what makes us human - indeed, this has played an important part in our success as a species. Long before the first caveman slumped down beside the fire and grunted news that there were plenty of wildebeest over yonder, our ancestors had learnt the value of sending out scouts to investigate the unknown. This questing nature of ours undoubtedly helped our species spread around the globe, just as it nowadays no doubt helps the last nomadic Penan maintain their existence in the depleted forests of Borneo, and a visitor negotiate the subways of New York.\n\nOver the years, we've come to think of explorers as a peculiar breed - different from the rest of us, different from those of us who are merely 'well travelled', even; and perhaps there is a type of person more suited to seeking out the new, a type of caveman more inclined to risk venturing out. That, however, doesn't take away from the fact that we all have this enquiring instinct, even today; and that in all sorts of professions - whether artist, marine biologist or astronomer - borders of the unknown are being tested each day.\n\nThomas Hardy set some of his novels in Egdon Heath, a fictional area of uncultivated land, and used the landscape to suggest the desires and fears of his characters. He is delving into matters we all recognise because they are common to humanity. This is surely an act of exploration, and into a world as remote as the author chooses. Explorer and travel writer Peter Fleming talks of the moment when the explorer returns to the existence he has left behind with his loved ones. The traveller 'who has for weeks or months seen himself only as a puny and irrelevant alien crawling laboriously over a country in which he has no roots and no background, suddenly encounters his other self, a relatively solid figure, with a place in the minds of certain people'\n\nIn this book about the exploration of the earth's surface, I have confined myself to those whose travels were real and who also aimed at more than personal discovery. But that still left me with another problem: the word 'explorer' has become associated with a past era. We think back to a golden age, as if exploration peaked somehow in the 19th century - as if the process of discovery is now on the decline, though the truth is that we have named only one and a half million of this planet's species, and there may be more than I () million - and that's not including bacteria. We have studied only 5 per cent of the species we know. We have scarcely mapped the ocean floors, and know even less about ourselves; we fully understand the workings of only 10 per cent of our brains.\n\nHere is how some of today's 'explorers' define the word. Ran Fiennes, dubbed the 'greatest living explorer' said, 'An explorer is someone who has done something that no human has done before - and also done something scientifically useful.' Chris Bonington, a leading mountaineer, felt exploration was to be found in the act of physically touching the unknown: 'You have to have gone somewhere new.' Then Robin Hanbury-Tenison, a campaigner on behalf of remote so-called 'tribal' peoples, said, 'A traveller simply records information about some far-off world, and reports back; but an explorer changes the world.' Wilfred Thesiger, who crossed Arabia's Empty Quarter in 1946, and belongs to an era of unmechanised travel now lost to the rest of us, told me, 'If I'd gone across by camel when I could have gone by car, it would have been a stunt.' To him, exploration meant bringing back information from a remote place regardless of any great self-discovery.\n\nEach definition is slightly different and tends to reflect the field of endeavour of each pioneer. It was the same whoever I asked: the prominent historian would say exploration was a thing of the past, the cutting-edge scientist would say it was of the present. And so on. They each set their own particular criteria; the common factor in their approach being that they all had, unlike many of us who simply enjoy travel or discovering new things, both a very definite objective from the outset and also a desire to record their findings.\n\nI'd best declare my own bias. As a writer, I'm interested in the exploration of ideas. I've done a great many expeditions and each one was unique. I've lived for months alone with isolated groups of people all around the world, even two 'uncontacted tribes'. But none of these things is of the slightest interest to anyone unless, through my books, I've found a new slant, explored a new idea. Why? Because the world has moved on. The time has long passed for the great continental voyages - another walk to the poles, another crossing of the Empty Quarter. We know how the land surface of our planet lies; exploration of it is now down to the details - the habits of microbes, say, or the grazing behaviour of buffalo. Aside from the deep sea and deep underground, it's the era of specialists. However, this is to disregard the role the human mind has in conveying remote places; and this is what interests me: how a fresh interpretation, even of a well-travelled route, can give its readers new insights.
4	12	Could urban engineers learn from dance?	ould urban engineers learn from dance?\n\nThe way we travel around cities has a major impact on whether they are sustainable. Transportation is estimated to account for 30% of energy consumption in most of the world's most developed nations, so lowering the need for energy-using vehicles is essential for decreasing the environmental impact of mobility. But as more and more people move to cities, it is important to think about other kinds of sustainable travel too. The ways we travel affect our physical and mental health, our social lives, our access to work and culture, and the air we breathe. Engineers are tasked with changing how we travel round cities through urban design, but the engineering industry still works on the assumptions that led to the creation of the energy-consuming transport systems we have now: the emphasis placed solely on efficiency, speed, and quantitative data. We need radical changes, to make it healthier, more enjoyable, and less environmentally damaging to travel around cities.\n\nDance might hold some of the answers. That is not to suggest everyone should dance their way to work, however healthy and happy it might make us, but rather that the techniques used by choreographers to experiment with and design movement in dance could provide engineers with tools to stimulate new ideas in city-making. Richard Sennett, an influential urbanist and sociologist who has transformed ideas about the way cities are made, argues that urban design has suffered from a separation between mind and body since the introduction of the architectural blueprint.\n\nWhereas medieval builders improvised and adapted construction through their intimate knowledge of materials and personal experience of the conditions on a site, building designs are now conceived and stored in media technologies that detach the designer from the physical and social realities they are creating. While the design practices created by these new technologies are essential for managing the technical complexity of the modern city, they have the drawback of simplifying reality in the process.\n\nTo illustrate, Sennett discusses the Peachtree Center in Atlanta, USA, a development typical of the modernist approach to urban planning prevalent in the 1970s. Peachtree created a grid of streets and towers intended as a new pedestrian-friendly downtown for Atlanta. According to Sennett, this failed because its designers had invested too much faith in computer-aided design to tell them how it would operate. They failed to take into account that purpose-built street cafés could not operate in the hot sun without the protective awnings common in older buildings, and would need energy-consuming air conditioning instead, or that its giant car park would feel so unwelcoming that it would put people off getting out of their cars. What seems entirely predictable and controllable on screen has unexpected results when translated into reality.\n\n**Section E**\n\n**Section F**\n\nG The same is true in transport engineering, which uses models to predict and shape the way people move through the city. Again, these models are necessary, but they are built on specific world views in which certain forms of effciency and safety are considered and other experiences of the city ignored. Designs that seem logical in models appear counter-intuitive in the actual experience of their users. The guard rails that will be familiar to anyone who has attempted to cross a British road, for example, were an engineering solution to pedestrian safety based on models that prioritise the smooth flow of traffc. On wide major roads, they often guide pedestrians to specific crossing points and slow down their progress across the road by using staggered access points to divide the crossing into two - one for each carriageway. In doing so they make crossings feel longer, introducing psychological barriers greatly impacting those that are the least mobile, and encouraging others to make dangerous crossings to get around the guard rails. These barriers don't just make it harder to cross the road: they divide communities and decrease opportunities for healthy transport. As a result, many are now being causing disruption, cost, and waste.\n\nIf their designers had had the tools to think with their bodies - like dancers - and imagine how these barriers would feel, there might have been a better solution. In order to bring about fundamental changes to the ways we use our cities, engineering will need to develop a richer understanding of why people move in certain ways, and how this movement affects them. Choreography may not seem an obvious choice for tackling this problem. Yet it shares with engineering the aim of designing patterns of movement within limitations of space. It is an art form developed almost entirely by trying out ideas with the body, and gaining instant feedback on how the results feel. Choreographers have deep understanding of the psychological, aesthetic, and physical implications of different ways of moving.\n\nObserving the choreographer Wayne McGregor, cognitive scientist David Kirsh described how he 'thinks with the body'. Kirsh argues that by using the body to simulate outcomes, McGregor is able to imagine solutions that would not be possible using purely abstract thought. This kind of physical knowledge is valued in many areas of expertise, but currently has no place in formal engineering design processes. A suggested method for transport engineers is to improvise design solutions and get instant feedback about how they would work from their own experience of them, or model designs at full scale in the way choreographers experiment with groups of dancers. Above all, perhaps, they might learn to design for emotional as well as functional effects.
5	13	Should we try to bring extinct species back to life?	The passenger pigeon was a legendary species. Flying in vast numbers across North America, with potentially many millions within a single flock, their migration was once one of nature's great spectacles. Sadly, the passenger pigeon's existence came to an end on 1 September 1914, when the last living specimen died at Cincinnati Zoo. Geneticist Ben Novak is lead researcher on an ambitious project which now aims to bring the bird back to life through a process known as 'de- extinction'. The basic premise involves using cloning technology to turn the DNA of extinct animals into a fertilised embryo, which is carried by the nearest relative still in existence - in this case, the abundant band-tailed pigeon - before being born as a living, breathing animal. Passenger pigeons are one of the pioneering species in this field, but they are far from the only ones on which this cutting-edge technology is being trialled.\n\nIn Australia, the thylacine, more commonly known as the Tasmanian tiger, is another extinct creature which genetic scientists are striving to bring back to life. 'There is no carnivore now in Tasmania that fills the niche which thylacines once occupied,' explains Michael Archer of the University of New South Wales. He points out that in the decades since the thylacine went extinct, there has been a spread in a 'dangerously debilitating' facial tumour syndrome which threatens the existence of the Tasmanian devils, the island's other notorious resident. Thylacines would have prevented this spread because they would have killed significant numbers of Tasmanian devils. 'If that contagious cancer had popped up previously, it would have burned out in whatever region it started. The return of thylacines to Tasmania could help to ensure that devils are never again subjected to risks of this kind.'\n\nIf extinct species can be brought back to life, can humanity begin to correct the damage it has caused to the natural world over the past few millennia? 'The idea of de-extinction is that we can reverse this process, bringing species that no longer exist back to life,' says Beth Shapiro of University of California Santa Cruz's Genomics Institute. 'l don't think that we can do this. There is no way to bring back something that is 100 per cent identical to a species that went extinct a long time ago.' A more practical approach for long-extinct species is to take the DNA of existing species as a template, ready for the insertion of strands of extinct animal DNA to create something new; a hybrid, based on the living species, but which looks and/or acts like the animal which died out.\n\n**Section D**\n\n**Section E**\n\nF This complicated process and questionable outcome begs the question: what is the actual point of this technology? For us, the goal has always been replacing the extinct species with a suitable replacement,' explains Novak. 'When it comes to breeding, band-tailed pigeons scatter and make maybe one or two nests per hectare, whereas passenger pigeons were very social and would make 10,000 or more nests in one hectare.' Since the disappearance of this key species, ecosystems in the eastern US have suffered, as the lack of disturbance caused by thousands of passenger pigeons wrecking trees and branches means there has been minimal need for regrowth. This has left forests stagnant and therefore unwelcoming to the plants and animals which evolved to help regenerate the forest after a disturbance. According to Novak, a hybridised band-tailed pigeon, with the added nesting habits of a passenger pigeon, could, in theory, re-establish that forest disturbance, thereby creating a habitat necessary for a great many other native species to thrive.\n\nAnother popular candidate for this technology is the woolly mammoth. George Church, professor at Harvard Medical School and leader of the Woolly Mammoth Revival Project, has been focusing on cold resistance, the main way in which the extinct woolly mammoth and its nearest living relative, the Asian elephant, differ. By pinpointing which genetic traits made it possible for mammoths to survive the icy climate of the tundra, the project's goal is to return mammoths, or a mammoth- like species, to the area. 'My highest priority would be preserving the endangered Asian elephant,' says Church, 'expanding their range to the huge ecosystem of the tundra. Necessary adaptations would include smaller ears, thicker hair, and extra insulating fat, all for the purpose of reducing heat loss in the tundra, and all traits found in the now extinct woolly mammoth.' This repopulation of the tundra and boreal forests of Eurasia and North America with large mammals could also be a useful factor in reducing carbon emissions - elephants punch holes through snow and knock down trees, which encourages grass growth. This grass growth would reduce temperatures, and mitigate emissions from melting permafrost.\n\nWhile the prospect of bringing extinct animals back to life might capture imaginations, it is, of course, far easier to try to save an existing species which is merely threatened with extinction. 'Many of the technologies that people have in mind when they think about de-extinction can be used as a form of "genetic rescue",' explains Shapiro. She prefers to focus the debate on how this emerging technology could be used to fully understand why various species went extinct in the first place, and therefore how we could use it to make genetic modifications which could prevent mass extinctions in the future. 'l would also say there's an incredible moral hazard to not do anything at all,' she continues. 'We know that what we are doing today is not enough, and we have to be willing to take some calculated and measured risks.'
6	14	Having a laugh	The findings of psychological scientists reveal the importance of humour\n\nHumans start developing a sense of humour as early as six weeks old, when babies begin to laugh and smile in response to stimuli. Laughter is universal across all human cultures and even exists in some form in rats, chimps, and bonobos. Like other human emotions and expressions, laughter and humour provide psychological scientists with rich resources for studying human psychology, ranging from the development of language to the neuroscience of social perception.\n\nTheories focusing on the evolution of laughter point to it as an important adaptation for social communication. Take, for example, the recorded laughter in TV comedy shows. Back in 1950, US sound engineer Charley Douglass hated dealing with the unpredictable laughter of live audiences, so started recording his own 'laugh tracks'. These were intended to help people at home feel like they were in a social situation, such as a crowded theatre. Douglass even recorded various types of laughter, as well as mixtures of laughter from men, women, and children. In doing so, he picked up on a quality of laughter that is now interesting researchers: a simple 'haha' communicates a remarkable amount of socially relevant information.\n\nIn one study conducted in 2016, samples of laughter from pairs of English-speaking students were recorded at the University of California, Santa Cruz. A team made up of more than 3() psychological scientists, anthropologists, and biologists then played these recordings to listeners from 24 diverse societies, from indigenous tribes in New Guinea to city-dwellers in India and Europe. Participants were asked whether they thought the people laughing were friends or strangers. On average, the results were remarkably consistent: worldwide, people's guesses were correct approximately 60% of the time.\n\nResearchers have also found that different types of laughter serve as codes to complex human social hierarchies. A team led by Christopher Oveis from the University of California, San Diego, found that high-status individuals had different laughs from low-status individuals, and that strangers' judgements of an individual's social status were influenced by the dominant or submissive quality of their laughter. In their study, 48 male college students were randomly assigned to groups of four, with each group composed of two Iow-status members, who had just joined their college fraternity group, and two high-status members, older students who had been active in the fraternity for at least two years. Laughter was recorded as each student took a turn at being teased by the others, involving the use of mildly insulting nicknames. Analysis revealed that, as expected, high-status individuals produced more dominant laughs and fewer submissive laughs relative to the low-status individuals. Meanwhile, low-status individuals were more likely to change their laughter based on their position of power; that is, the newcomers produced more dominant laughs when they were in the 'powerful' role of teasers. Dominant laughter was higher in pitch, louder, and more variable in tone than submissive laughter.\n\nA random group of volunteers then listened to an equal number of dominant and submissive laughs from both the high- and low-status individuals, and were asked to estimate the social status of the laugher. In line with predictions, laughers producing dominant laughs were perceived to be significantly higher in status than laughers producing submissive laughs. 'This was particularly true for low-status individuals, who were rated as significantly higher in status when displaying a dominant versus submissive laugh,' Oveis and colleagues note. 'Thus, by strategically displaying more dominant laughter when the context allows, low-status individuals may achieve higher status in the eyes of others.' However, high-status individuals were rated as high-status whether they produced their natural dominant laugh or tried to do a submissive one.\n\nAnother study, conducted by David Cheng and Lu Wang ofAustralian National University, was based on the hypothesis that humour might provide a respite from tedious situations in the workplace. This 'mental break' might facilitate the replenishment of mental resources. To test this theory, the researchers recruited 74 business students, ostensibly for an experiment on perception. First, the students performed a tedious task in which they had to cross out every instance of the letter 'e' over two pages of text. The students then were randomly assigned to watch a video clip eliciting either humour, contentment, or neutral feelings. Some watched a clip of the BBC comedy Mr. Bean, others a relaxing scene with dolphins swimming in the ocean, and others a factual video about the management profession.\n\nThe students then completed a task requiring persistence in which they were asked to guess the potential performance of employees based on provided profiles, and were told that making 10 correct assessments in a row would lead to a win. However, the software was programmed such that it was nearly impossible to achieve 10 consecutive correct answers. Participants were allowed to quit the task at any point. Students who had watched the Mr. Bean video ended up spending significantly more time working on the task, making twice as many predictions as the other two groups.\n\nCheng and Wang then replicated these results in a second study, during which they had participants complete long multiplication questions by hand. Again, participants who watched the humorous video spent significantly more time working on this tedious task and completed more questions correctly than did the students in either of the other groups.\n\n'Although humour has been found to help relieve stress and facilitate social relationships, the traditional view of task performance implies that individuals should avoid things such as humour that may distract them from the accomplishment of task goals,' Cheng and Wang conclude. 'We suggest that humour is not only enjoyable but more importantly, energising.'
8	20	The Desolenator: Producing clean water	tting the finance for production\n\nAn unexpected benefit\n\nFrom initial inspiration to new product\n\nThe range of potential customers for the device\n\nWhat makes the device different from alternatives\n\nCleaning water from a range of sources\n\nOvercoming production difficulties\n\nProfit not the primary goal\n\nA warm welcome for the device\n\nThe number of people affected by water shortages\n\n**Section A**\n\n**Section B**\n\n**Section C**\n\nD The Desolenator: producing clean water\n\nTravelling around Thailand in the 1990s, William Janssen was impressed with the basic rooftop solar heating systems that were on many homes, where energy from the sun was absorbed by a plate and then used to heat water for domestic use. decades later Janssen developed that basic idea he saw in Southeast Asia into a portable device that uses the power from the sun to purify water.\n\nThe Desolenator operates as a mobile desalination unit that can take water from different places, such as the sea, rivers, boreholes and rain, and purify it for human consumption. It is particularly valuable in regions where natural groundwater reserves have been pollutecL or where seawater is the only water source available.\n\nJanssen saw that there was a need for a sustainable way to clean water in both the developing and the developed countries when he moved to the United Arab Emirates and saw large-scale water processing. 'I was confronted with the enormous carbon footprint that the Gulf nations have because of all of the desalination that they do,' he says.\n\nThe Desolenator can produce 1 5 litres of drinking water per day, enough to sustain a family for cooking and drinking. Its main selling point is that unlike standard desalination techniques, it doesn 't require a generated power supply: just sunlight. It measures 120 cm by 90 cm, and is easy to transport, thanks to its two wheels. Water enters through a pipe, and flows as a thin film between a sheet of double glazing and the surface of a solar panel, where it is heated by the sun. The warm water flows into a small boiler (heated by a solar-powered battery) where it is converted to steam. When the steam cools, it becomes distilled water. The device has a very simple filter to trap particles, and this can easily be shaken to remove them. There are two tubes for liquid coming out: one for the waste - salt from seawater, fluoride, etc. - and another for the distilled water. The performance of the unit is shown on an LCD screen and transmitted to the company which provides servicing when necessary. A recent analysis found that at least two-thirds of the world's population lives with severe water scarcity for at least a month every year. Janssen says that by 2030 half of the world's population will be living with water stress - where the demand exceeds the supply over a certain period of time. 'It is really important that a sustainable solution is brought to the market that is able to help these people,' he says. Many countries 'don't have the money for desalination plants, which are very expensive to build. They don't have the money to operate them, they are very maintenance intensive, and they don 't have the money to buy the diesel to run the desalination plants, so it is a really bad situation.'\n\n**Section E**\n\n**Section F**\n\nG The device is aimed at a wide variety of users - from homeowners in the developing world who do not have a constant supply of water to people living off the grid in rural parts of the US. The first commercial versions of the Desolenator are expected to be in operation in India early next year, after field tests are carried out. The market for the self-sumcient devices in developing countries is twofold - those who cannot afford the money for the device outright and pay through microfinance, and middle- income homes that can lease their own equipment. 'People in India don't pay for a fridge outright; they pay for it over six months. They would put the Desolenator on their roof and hook it up to their municipal supply and they would get very reliable drinking water on a daily basis,' Janssen says. In the developed world, it is aimed at niche markets where tap water is unavailable - for camping, on boats, or for the military, for instance.\n\nPrices will vary according to where it is bought. In the developing world, the price will depend on what deal aid organisations can negotiate. In developed countries, it is likely to come in at $1,000 (C685) a unit, said Janssen. 'We are a venture with a social mission. We are aware that the product we have envisioned is mainly finding application in the developing world and humanitarian sector and that this is the way we will proceed. We do realise, though, that to be a viable company there is a bottom line to keep in mind,' he says.\n\nThe company itself is based at Imperial College London, although Janssen, its chief executive, still lives in the UAE. It has raised €340,000 in funding so far. Within two years, he says, the company aims to be selling 1,000 units a month, mainly in the humanitarian field. They are expected to be sold in areas such as Australia, northern Chile, Peru, Texas and California.
9	21	Plant 'intelligence'	Why fairy tales are really scary tales\n\nSome people think that fairy tales are just stories to amuse children, but their universal and enduring appeal may be due to more serious reasons\n\nPeople of every culture tell each other fairy tales but the same story often takes a variety of forms in different parts of the world. In the story of Little Red Riding Hood that European children are familiar with, a young girl on the way to see her grandmother meets a wolf and tells him where she is going. The wolf runs on ahead and disposes of the grandmother, then gets into bed dressed in the grandmother's clothes to wait for Little Red Riding Hood. You may think you know the story - but which version? In some versions, the wolf swallows up the grandmother, while in others it locks her in a cupboard. In some stories Red Riding Hood gets the better of the wolf on her own, while in others a hunter or a woodcutter hears her cries and comes to her rescue.\n\nThe universal appeal of these tales is frequently attributed to the idea that they contain cautionary messages: in the case of Little Red Riding Hood, to listen to your mother, and avoid talking to strangers. 'It might be what we find interesting about this story is that it's got this survival- relevant information in it,' says anthropologist Jamie Tehrani at Durham University in the UK. But his research suggests otherwise. 'We have this huge gap in our knowledge about the history and prehistory of storytelling, despite the fact that we know this genre is an incredibly ancient one,' he says. That hasn't stopped anthropologists, folklorists and other academics devising theories to explain the importance of fairy tales in human society. Now Tehrani has found a way to test these ideas, borrowing a technique from evolutionary biologists.\n\nTo work out the evolutionary history, development and relationships among groups of organisms, biologists compare the characteristics of living species in a process called 'phylogenetic analysis'. Tehrani has used the same approach to compare related versions of fairy tales to discover how they have evolved and which elements have survived longest.\n\nTehrani 's analysis focused on Little Red Riding Hood in its many forms, which include another Western fairy tale known as The Wolf and the Kids, Checking for variants of these two tales and similar stories from Africa, East Asia and other regions, he ended up with 58 stories recorded from oral traditions. Once his phylogenetic analysis had established that they were indeed related, he used the same methods to explore how they have developed and altered over time.\n\nFirst he tested some assumptions about which aspects of the story alter least as it evolves, indicating their importance. Folklorists believe that what happens in a story is more central to the story than the characters init that visiting a relative, only to bemet by a scary animal in disguise, is\n\nFolklorists: those who Study traditional stories more fundamental than whether the visitor is a little girl or three siblings, or the animal is a tiger instead of a wolf.\n\nHowever, Tehrani found no significant difference in the rate of evolution of incidents compared with that of characters. 'Certain episodes are very stable because they are crucial to the story, but there are lots of other details that can evolve quite freely,' he says. Neither did his analysis support the theory that the central section of a story is the most conserved part. He found no significant difference in the flexibility of events there compared with the beginning or the end.\n\nBut the really big surprise came when he looked at the cautionary elements of the story. 'Studies on hunter-gatherer folk tales suggest that these narratives include really important information about the environment and the possible dangers that may be faced there - stuff that's relevant to survival,' he says. Yet in his analysis such elements were just as flexible as seemingly trivial details. What, then, is important enough to be reproduced from generation to generation?\n\nThe answer, it would appear, is fear - blood-thirsty and gruesome aspects of the story, such as the eating of the grandmother by the wolf, turned out to be the best preserved of all. Why are these details retained by generations of storytellers, when other features are not? Tehrani has an idea: 'In an oral context, a story won't survive because of one great teller. It also needs to be interesting when it's told by someone who's not necessarily a great storyteller.' Maybe being swallowed whole by a wolf, then cut out of its stomach alive is so gripping that it helps the story remain popular, no matter how badly it's told.\n\nJack Zipes at the University of Minnesota, Minneapolis, is unconvinced by Tehrani's views on fairy tales. 'Even if they're gruesome, they won't stick unless they matter,' he says. He believes the perennial theme of women as victims in stories like Little Red Riding Hood explains why they continue to feel relevant. But Tehrani points out that although this is often the case in Western versions, it is not always true elsewhere. In Chinese and Japanese versions, often known as The Tiger Grandmother, the villain is a woman, and in both Iran and Nigeria, the victim is a boy.\n\nMathias Clasen at Aarhus University in Denmark isn't surprised by Tehrani's findings. 'Habits and morals change, but the things that scare us, and the fact that we seek out entertainment that's designed to scare us - those are constant,' he says. Clasen believes that scary stories teach us what it feels like to be afraid without having to experience real danger, and so build up resistance to negative emotions.
10	26	The return of the huarango	The arid valleys of southern Peru are welcoming the return of a native plant\n\nThe south coast of Peru is a narrow, 2,000-kilometre-long strip of desert squeezed between the Andes and the Pacific Ocean. It is also one of the most fragile ecosystems on Earth. It hardly ever rains there, and the only year-round source of water is located tens of metres below the surface. This is why the huarango tree is so suited to life there: it has the longest roots of any tree in the world. They stretch down 50-80 metres and, as well as sucking up water for the tree, they bring it into the higher subsoil, creating a water source for other plant life.\n\nDr David Beresford-Jones, archaeobotanist at Cambridge University, has been studying the role of the huarango tree in landscape change in the Lower Ica Valley in southern Peru. He believes the huarango was key to the ancient people's diet and, because it could reach deep water sources, it allowed local people to withstand years of drought when their other crops failed. But over the centuries huarango trees were gradually replaced with crops. Cutting down native woodland leads to erosion, as there is nothing to keep the soil in place. So when the huarangos go, the land turns into a desert. Nothing grows at all in the Lower Ica Valley now.\n\nFor centuries the huarango tree was vital to the people of the neighbouring Middle Ica Valley too. They grew vegetables under it and ate products made from its seed pods. Its leaves and bark were used for herbal remedies, while its branches were used for charcoal for cooking and heating, and its trunk was used to build houses. But now it is disappearing rapidly. The majority of the huarango forests in the valley have already been cleared for fuel and agriculture - initially, these were smallholdings, but now they're huge farms producing crops for the international market.\n\n'Of the forests that were here 1,000 years ago, 99 per cent have already gone,' says botanist Oliver Whaley from Kew Gardens in London, who, together with ethnobotanist Dr William Milliken, is running a pioneering project to protect and restore the rapidly disappearing habitat. In order to succeed, Whaley needs to get the local people on board, and that has meant overcoming local prejudices. 'Increasingly aspirational comrnunities think that if you plant food trees in your home or street, it shows you are poor, and still need to grow your own fooct' he says. In order to stop the Middle Ica Valley going the same way as the Lower Ica Valley, Whaley is encouraging locals to love the huarangos again. 'It's a process of cultural resuscitation,' he says. He has already set up a huarango festival to reinstate a sense ofpride in their eco-heritage, and has helped local schoolchildren plant thousands of trees.\n\n'In order to get people interested in habitat restoration, you need to plant a tree that is useful to them,' says Whaley. So, he has been working with local families to attempt to create a sustainable income from the huarangos by turning their products into foodstuffs. 'Boil up the beans and you get this thick brown syrup like molasses. You can also use it in drinks, soups or stews.' The pods can be ground into flour to make cakes, and the seeds roasted into a sweet, chocolatey 'coffee'. 'It's packed full of vitamins and minerals,' Whaley says.\n\nAnd some farmers are already planting huarangos. Alberto Benevides, owner of Ica Valley's only certified organic farm, which Whaley helped set up, has been planting the tree for 13 years. He produces syrup and flour, and sells these products at an organic farmers' market in Lima. His farm is relatively small and doesn't yet provide him with enough to live on, but he hopes this will change. 'The organic market is growing rapidly in Peru,' Benevides says. 'I am investing in the future.'\n\nBut even if Whaley can convince the local people to fall in love with the huarango again, there is still the threat of the larger farms. Some of these cut across the forests and break up the corridors that allow the essential movement of mammals, birds and pollen up and down the narrow forest strip. In the hope of counteracting this, he's persuading farmers to let him plant forest corridors on their land. He believes the extra woodland will also benefit the farms by reducing their water usage through a lowering of evaporation and providing a refuge for bio-control insects.\n\n'If we can record biodiversity and see how it all works, then we're in a good position to move on from there. Desert habitats can reduce down to very little,' Whaley explains. 'It's not like a rainforest that needs to have this huge expanse. Life has always been confined to corridors and islands here. If you just have a few trees left, the population can grow up quickly because it's used to exploiting water when it arrives.' He sees his project as a model that has the potential to be rolled out across other arid areas around the world. 'If we can do it here, in the most fragile system on Earth, then that's a real message of hope for lots of places, including Africa, where there is drought and they just can't afford to wait for rain.'
12	28	Environmental practices of big businesses	The environmental practices of big businesses are shaped by a fundamental fact that for many of us offends our sense of justice. Depending on the circumstances, a business may maximize the amount of money it makes, at least in the short term, by damaging the environment and hurting people. That is still the case today for fishermen in an unmanaged fishery without quotas, and for international logging companies with short-term leases on tropical rainforest land in places with corrupt officials and unsophisticated landowners. When government regulation is effective, and when the public is environmentally aware, environmentally clean big businesses may out-compete dirty ones, but the reverse is likely to be true if government regulation is ineffective and if the public doesn't care.\n\nIt is easy for the rest of us to blame a business for helping itself by hurting other people. But blaming alone is unlikely to produce change. It ignores the fact that businesses are not charities but profit-making companies, and that publicly owned companies with shareholders are under obligation to those shareholders to maximize profits, provided that they do so by legal means. US laws make a company's directors legally liable for something termed 'breach of fiduciary responsibility' if they knowingly manage a company in a way that reduces profits. The car manufacturer Henry Ford was in fact successfully sued by shareholders in 1919 for raising the minimum wage of his workers to $5 per day: the courts declared that, while Ford's humanitarian sentiments about his employees were nice, his business existed to make profits for its stockholders.\n\nOur blaming of businesses also ignores the ultimate responsibility of the public for creating the conditions that let a business profit through destructive environmental policies. In the long run, it is the public, either directly or through its politicians, that has the power to make such destructive policies unprofitable and illegal, and to make sustainable environmental policies profitable.\n\nThe public can do that by suing businesses for harming them, as happened after the Exxon Valdez disaster, in which over 40,000m3 of oil were spilled off the coast of Alaska. The public may also make their opinion felt by preferring to buy sustainably harvested products; by making employees of companies with poor track records feel ashamed of their company and complain to their own management; by preferring their governments to award valuable contracts to businesses with a good environmental track record; and by pressing their governments to pass and enforce laws and regulations requiring good environmental practices.\n\nIn turn, big businesses can exert powerful pressure on any suppliers that might ignore public or government pressure. For instance, after the US public became concerned about the spread of a disease known as BSE, which was transmitted to humans through infected meat, the US government's Food and Drug Administration introduced rules demanding that the meat industry abandon practices associated with the risk of the disease spreading. But for five years the meat packers refused to follow these, claiming that they would be too expensive to obey. However, when a major fast-food company then made the same demands after customer purchases of its hamburgers plummeted, the meat industry complied within weeks. The public's task is therefore to identify which links in the supply chain are sensitive to public pressure: for instance, fast-food chains or jewelry stores, but not meat packers or gold miners.\n\nSome readers may be disappointed or outraged that I place the ultimate responsibility for business practices harming the public on the public itself. I also believe that the public must accept the necessity for higher prices for products to cover the added costs, if any, of sound environmental practices. My views may seem to ignore the belief that businesses should act in accordance with moral principles even if this leads to a reduction in their profits. But I think we have to recognize that, throughout human history, in all politically complex human societies, government regulation has arisen precisely because it was found that not only did moral principles need to be made explicit, they also needed to be enforced.\n\nTo me, the conclusion that the public has the ultimate responsibility for the behavior of even the biggest businesses is empowering and hopeful, rather than disappointing. My conclusion is not a moralistic one about who is right or wrong, admirable or selfish, a good guy or a bad guy. In the past, businesses have changed when the public came to expect and require different behavior, to reward businesses for behavior that the public wanted, and to make things difficult for businesses practicing behaviors that the public didn't want. I predict that in the future, just as in the past, changes in public attitudes will be essential for changes in businesses' environmental practices.
13	33	Stepwells	A millennium ago, stepwells were fundamental to life in the driest parts of India. Richard Cox travelled to north-western India to document these spectacular monuments from a bygone era\n\nDuring the sixth and seventh centuries, the inhabitants of the modern-day states of Gujarat and Rajasthan in north-western India developed a method of gaining access to clean, fresh groundwater during the dry season for drinking, bathing, watering animals and eirrigation. However, the significance of this invention - the stepwell - goes beyond its utilitarian application. Unique to this region, stepwells are often architecturally complex and vary Widely in size and shape. During their heyday, they were places of gathering, of leisure and relaxation and of worship for villagers of all but the lowest classes. Most stepwells are found dotted round the desert areas of Gujarat (where they are called vav) and Rajasthan (where they are called baori), while a few also survive in Delhi. Some were located in or near villages as public spaces for the community; others were positioned beside roads as resting places for travellers.\n\nAs their name suggests, stepwells comprise a series of stone steps descending from ground level to the water source (normally an underground aquifer) as it recedes following the rains. When the water level was high, the user needed only to descend a few steps to reach it: when it was Iow, several levels would have to be negotiated.\n\nSome wells are vast, open craters with hundreds of steps paving each sloping side, often in tiers. Others are more elaborate, with long stepped passages leading to the water via several Storeys. Built from stone and supported by pillars, they also included pavilions that sheltered visitors from the relentless heat. But perhaps the most impressive features are the intricate decorative sculptures that embellish many stepwells, showing activities from fighting and dancing to everyday acts such as women combing their hair or churning butter.\n\nDown the centuries, thousands of wells were constructed throughout north- western India, but the majority have now fallen into disuse; many are derelict and dry. as groundwater has been diverted for industrial use and the wells no longer reach the water table. Their condition hasn't been helped by recent dry spells: southern Rajasthan suffered an eight-year drought between 1996 and 2004.\n\nHowever, some important sites in Gujarat have recently undergone major restoration, and the state government announced in June last year that it plans to restore the stepwells throughout the state. In Patan, the state's ancient capital, the stepwell of Rani Ki Vav (Queen's Stepwell) is perhaps the finest current example. It was built by Queen Udayamati during the late 11th century, but became silted up following a flood during the 13th century. But the Archaeological Survey of India began restoring it in the 1960s, and today it is in pristine condition. At 65 metres long, 20 metres wide and 27 metres deep, Rani Ki Vav features 500 sculptures carved into niches throughout the monument. Incredibly, in January 2001, this ancient structure survived an earthquake that measured 7.6 on the Richter scale.\n\nAnother example is the Surya Kund in Modhera, northern Gujarat, next to the Sun Temple, built by King Bhima I in 1026 to honour the sun god Surya. It actually resembles a tank (kund means reservoir or pond) rather than a well, but displays the hallmarks of stepwell architecture, including four sides of steps that descend to the bottom in a stunning geometrical formation. The terraces house 108 small, intricately carved shrines between the sets of steps.\n\nRajasthan also has a wealth of wells. The ancient city of Bundi, 200 kilometres south of Jaipur, is renowned for its architecture, including its stepwells. One of the larger examples is Raniji Ki Baori, which was built by the queen of the region, Nathavatji, in 1699. At 46 metres deep, 20 metres wide and 40 metres long, the intricately carved monument is one of 21 baoris commissioned in the Bundi area by Nathavatji.\n\nIn the old ruined town of Abhaneri, about 95 kilometres east of Jaipur, is Chand Baori, one of India's oldest and deepest wells; aesthetically it's perhaps one of the most dramatic. Built in around 850 AD next to the temple of Harshat Mata, the baori comprises hundreds of zigzagging steps that run along three of its sides. steeply descending 11 storeys, resulting in a striking pattern when seen from afar. On the fourth side, verandas which are supported by ornate pillars overlook the steps.\n\nStill in public use is Neemrana Ki Baori, located just off the Jaipur-Delhi highway. Constructed in around 1700, it is nine storeys deep, with the last two being underwater. At ground level, there are 86 colonnaded openings from where the visitor descends 170 steps to the deepest water source.\n\nToday, following years of neglect, many of these monuments to medieval engineering have been saved by the Archaeological Survey of India, which has recognised the importance of preserving them as part of the country's rich history. Tourists flock to wells in far-flung corners of north- western India to gaze in wonder at these architectural marvels from hundreds of years ago, which serve as a reminder of both the ingenuity and artistry of ancient civilisations and of the value of water to human existence.
25	61	Crop-growing skyscrapers	By the year 2050, nearly 80% of the Earth's population will live in urban centres. Applying the most conservative estimates to current demographic trends, the human population will increase by about three billion aeople by then. An estimated 10 hectares of new land (about 20% larger than Brazil) will be needed to grow enoµgh food to feed them, if traditional farming methods continue as they are practised today. At present, throughout the world, over 80% of the land that is suitable for raising crops is in use. Historically, some 15% of that has been laid waste by poor management practices. What can be done to ensure enough food for the worid's population to live on?\n\nThe concept of indoor farming is not new, since hothouse production of tomatoes and other produce has been in vogue for some time. What is new is the urgent need to scale up this technology to accommodate another three billion people. Many believe an entirely new approach to indoor farming is required, employing cutting-edge technologies. One such proposal is for the 'Vertical Farm'. The concept is of multi-storey buildings in which food crops are grown in environmentally controlled conditions. Situated in the heart of urban centres, they would drastically reduce the amount of transportation required to bring food to consumers. Vertical farms would need to be efficient, cheap to construct and safe to operate. If successfully implemented, proponents claim, vertical farms offer the promise of urban renewal, sustainable production of a safe and varied food supply (through year-round production of all crops), and the eventual repair of ecosystems that have been sacrificed for horizontal farming.\n\nIt took humans 10,000 years to learn how to grow most of the crops we now take for granted. Along the way, we despoiled most of the land we worked, often turning verdant, natural ecozones into semi-arid deserts. Within that same time frame, we evolved into an urban species, in which 60% of the human population\n\nnow lives vertically in cities. This means that, for the majority, we humans have shelter from the elements, yet we subject our food- bearing plants to the rigours of the great outdoors and can do no more than hope for a good weather year. However, more often than not now, due to a rapidly changing climate, that is not what happens. Massive floods, long droughts, hurricanes and severe monsoons take their toll each year, destroying millions of tons of valuable crops.\n\nThe supporters of vertical farming claim many potential advantages for the system. For instance, crops would be produced all year round, as they would be kept in artificially controlled, optimum growing conditions. There would be no weather-related crop failures due to droughts, floods or pests. All the food could be grown organically, eliminating the need for herbicides, pesticides and fertilisers. The system would gre9tly reduce the incidence of many infectious diseases that are acquired at the agricultural interface. Although the system would consume energy, it would return energy to the grid via methane generation from composting non­ edible parts of plants. It would also dramatically reduce fossil fuel use, by cutting out the need for tractors, ploughs and shipping.\n\nA major drawback of vertical farming, however, is that the plants would require artificial light. Without it, those plants nearest the windows would be exposed to more sunlight and grow more quickly, reducing the efficiency of the system. Single­ storey greenhouses have the benefit of natural overhead light: even so, many still need artificial lighting. A multi-storey facility with no natural overhead light would require far more. Generating enough light could be prohibitively expensive, unless cheap, renewable energy is available, and this appears to be rather a future aspiration than a likelihood for the near future.\n\nOne variation on vertical farming that has been developed is to grow plants in stacked trays that move on rails. Moving the trays allows the plants to get enough sunlight. This system is already in operation. and works well within a single-storey greenhouse with light reaching it from above: it is not certain, however, that it can be made to work without that overhead natural light.\n\nVertical farming is an attempt to address the undoubted problems that we face in producing enough food for a growing population. At the moment, though, more needs to be done to reduce the detrimental impact it would have on the environment, particularly as regards the use of energy. While it is possible that much of our food will be grown in skyscrapers in future, most experts currently believe it is far more likely that we will simply use the space available on urban rooftops.
26	62	The Falkirk Wheel	A unique engineering achievement The Falkirk Wheel in Scotland is the world's first and only rotating boat lift. Opened in 2002, it is central to the ambitious £84.5m Millennium Link project to restore navigability across Scotland by reconnecting the historic waterways of the\n\nForth & Clyde and Union Canals. The major challenge of the project lay in the fact that the Forth & Clyde Canal is situated 35 metres below the level of the Union Canal. Historically, the two canals had been joined near the town of Falkirk by a sequence of 11 locks - enclosed sections of canal in which the water level could be raised or lowered - that stepped down across a distance of 1.5 km. This had been dismantled in 1933, thereby breaking the link. When the project was launched in 1994, the British Waterways authority were keen to create a dramatic twenty-first­ century landmark which would not only be a fitting commemoration of the Millennium, but also a lasting symbol of the economic regeneration of the region.\n\nNumerous ideas were submitted for the project, including concepts ranging from rolling eggs to tilting tanks, from giant see­ saws to overhead monorails. The eventual winner was a plan for the huge rotating steel boat lift which was to become The\n\nFalkirk Wheel. The unique shape of the structure is claimed to have been inspired by various sources, both manmade and natural, most notably a Celtic double- headed axe, but also the vast turning propeller of a ship, the ribcage of a whale or the spine of a fish.\n\nThe various parts of The Falkirk Wheel were all constructed and assembled, like one giant toy building set, at Butterley Engineering's Steelworks in Derbyshire, some 400 km from Falkirk. A team there carefully assembled the 1,200 tonnes of steel, painstakingly fitting the pieces together to an accuracy of just 10 mm to ensure a perfect final fit. In the summer of 2001, the structure was then dismantled and transported on 35 lorries to Falkirk, before all being bolted back together again on the ground, and finally lifted into position in five large sections by crane. The Wheel would need to withstand immense\n\nand constantly changing stresses as it rotated, so to make the structure more robust, the steel sections were bolted rather than welded together. Over 45,000 bolt holes were matched with their bolts, and each bolt was hand-tightened.\n\nThe Wheel consists of two sets of opposing axe-shaped arms, attached about 25 metres apart to a fixed central spine. Two diametrically opposed water-filled\n\n' gondolas', each with a capacity of 360,000 litres, are fitted between the ends of the arms. These gondolas always weigh the same, whether or not they are carrying boats. This is because, according to Archimedes' principle of displacement, floating objects displace their own weight in water. So when a boat enters a gondola, the amount of water leaving the gondola weighs exactly the same as the boat. This\n\nkeeps the Wheel balanced and so, despite its enormous mass, it rotates through 180° in five and a half minutes while using very little power. It takes just 1.5 kilowatt-hours (5.4 MJ) of energy to rotate the Wheel - roughly the same as boiling eight small domestic kettles of water.\n\nBoats needing to be lifted up enter the canal basin at the level of the Forth & Clyde Canal and then enter the lower gondola of the Wheel. Two hydraulic steel gates are raised, so as to seal the gondola off from the water in the canal basin. The water between the gates is then pumped out. A hydraulic clamp, which prevents the arms of the Wheel moving while the gondola is docked, is removed, allowing the Wheel to turn. In the central machine room an array of ten hydraulic motors then begins to rotate the central axle. The axle connects to the outer arms of the Wheel, which begin to rotate at a speed of 1/8 of a revolution per minute. As the wheel rotates, the gondolas are kept in the upright position by a simple gearing system. Two eight-metre-wide cogs orbit a fixed inner cog of the same width, connected by two smaller cogs travelling in the opposite direction to the outer cogs so ensuring that the gondolas always remain level. When the gondola reaches the top, the boat passes straight onto the aqueduct situated 24 metres above the canal basin.\n\nT he remaining 11 metres of lift needed to reach the Union Canal is achieved by means of a pair of locks. The Wheel could not be constructed to elevate boats over the full 35-metre difference between the two canals, owing to the presence of the historically important Antonine Wall, which was built by the Romans in the second century AD. Boats travel under this wall via a tunnel, then through the locks, and finally on to the Union Canal.
27	63	Reducing the Effects of Climate Change	Mark Rowe reports on the increasingly ambitious geo-engi.neering projects being explored by scientists\n\nA Such is our dependence on fossil fuels, and such is the volume of carbon dioxide already released into the atmosphere, that many experts agree that significant global warming is now inevitable. They believe that the best we can do is keep it at a reasonable level, and at present the only serious option for doing this is cutting back on our carbon emissions. But while a few\n\ncountries are making major strides in this regard, the majority are having great difficulry even stemming the race of increase, lee alone reversing it. Consequently, an increasing number of scientists are beginning to explore the alternative of geo-engineering - a term which generally refers co the intentional large-scale manipulation of the environment. According to its proponents, geo-engineering is the equivalent of a backup generator: if Plan A - reducing our dependency on fossil fuels - fails, we require a Plan B, employing grand schemes to slow down or reverse the process of global warming.\n\nB Geo-engineering has ben shown to work, at lease on a small localised scale. For decades, May Day parades in Moscow have taken place under clear blue skies, aircraft having deposited dry ice, silver iodide and cement powder to disperse clouds. Many of the schemes now suggested look to do the opposite, and reduce the amount of sunlight reaching the planet. The most eye-catching idea of all is suggested by Professor Roger Angel of the University of Ariwna. His scheme would employ up co 16 trillion minute spacecraft, each weighing about one gram, to form a transparent, sunlight-refracting sunshade in an orbit 1.5 million km above the Earth. This could, argues Angel, reduce the amount of light reaching the Earth by two per cent.\n\nC The majority of geo-engineering projects so far carried out - which include planting forests in deserts and depositing iron in the ocean to stimulate the growth of algae - have focused on achieving a general cooling of the Earth. But some look specifically at reversing the melting at the poles, particularly the Arctic. The reasoning is that if you replenish the ice sheets and frozen waters of the high latitudes, more light will be reflected back into space, so reducing the warming of the oceans and atmosphere.\n\nD The concept of releasing aerosol sprays into the stratosphere above the Arctic has been proposed by several scientists. This would involve using sulphur or hydrogen sulphide aerosols so that sulphur dioxide would form clouds, which would, in turn, lead to a global dimming. The idea is modelled on historic volcanic explosions, such as that of Mount Pinatubo in the Philippines in 1991, which led co a shore-term cooling of global temperatures by 0.5 °C. Scientists have also scrutinised whether it's possible to preserve the ice sheets of Greenland with reinforced high-tension cables, preventing icebergs from moving into the sea. Meanwhile in the Russian Arctic, geo-engineering plans include the planting of millions of birch trees. Whereas the\n\nregion's native evergreen pines shade the snow and absorb radiation, birches would shed their\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH leaves in winter, thus enabling radiation ro be reflected by che snow. Re-routing Russian rivers co increase cold water flow ro ice-forming areas could also be used ro slow down warming, say some climate scientists. Bue will such schemes ever be implemented? Generally speaking, those who are most cautious about geo-engineering are the scientists involved in che research. Angel says that his plan is 'no substitute for developing renewable energy: the only permanent solution'. And Dr Phil Rasch of the US-based Pacific Northwest National Laborarory is equally guarded about che role of geo­ engineering: 'I chink all of us agree that if we were ro end geo-engineering on a given day, then the planet would return ro its pre-engineered condition very rapidly, and probably within ten ro cwency years. Thar's certainly something to worry about.'\n\nThe US National Center for Atmospheric Research has already suggested that the proposal co inject sulphur into the atmosphere might affect rainfall patterns across the tropics and the Southern Ocean. 'Geo-engineering plans co inject scrarospheric aerosols or co seed clouds would ace ro cool the planet, and ace co increase the extent of sea ice,' says Rasch. 'Bue all the models suggest some impact on the distribution of precipitation.'\n\n'A further risk with geo-engineering projects is that you can "overshoot",' says Dr Dan Lunt, from the University of Bristol's School of Geophysical Sciences, who has studied the likely impacts of the sunshade and aerosol schemes on the climate. 'You may bring global temperatures back co pre-industrial levels, buc the risk is that the poles will still be warmer than they should be and the tropics will be cooler than before industrialisation.' To avoid such a scenario, Lum says Angel's project would have to operate ac half strength; all of which reinforces his view that the best option is co avoid the need for geo-engineering altogether.\n\nThe main reason why geo-engineering is supported by many in che scientific community is that most researchers have lictle Faith in the ability of politicians to agree - and then bring in - the necessary carbon cues. Even leading conservation organisations see the value of investigating the potential of geo-engineering. According ro Dr Martin Sommerkorn, climate change advisor for the World Wildlife Fund's International Arctic Programme, 'Human-induced climate change has brought humanity to a position where we shouldn't exclude chinking thoroughly about this topic and ics possibilities.'\n\nulI uj e:_?.>4
66	154	How to make clever decisions under pressure	Organisation is big business. Whether it is of our lives - all those inboxes and calendars - or how companies are structured, a multi-billion dollar industry helps to meet this need. We have more strategies for time management, project management and self-organisation than at any other time in human history. We are told that we ought to organise our company, our home life, our week, our day and even our sleep, all as a means to becoming more productive. Every week, countless seminars and workshops take place around the world to tell a paying public that they ought to structure their lives in order to achieve this. This rhetoric has also crept into the thinking of business leaders and entrepreneurs, much to the delight of self-proclaimed perfectionists with the need to get everything right. The number of business schools and graduates has massively increased over the past 50 years, essentially teaching people how to organise well. Ironically, however, the number of businesses that fail has also steadily increased. Work-related stress has increased. A large proportion ofworkers from all demographics claim to be dissatisfied with the way their work is structured and the way they are managed. This begs the question: what has gone wrong? Why is it that on paper the drive for organisation seems a sure shot for increasing productivity, but in reality falls well short of what is expected? This has been a problem for a while now. Frederick Taylor was one of the forefathers of scientific management. Writing in the first half of the 20th century, he designed a number of principles to improve the emciency of the work process, which have since become widespread in modern companies. So the approach has been around for a while. New research suggests that this obsession with emciency is misguided. The problem is not necessarily the management theories or strategies we use to organise our work; it's the basic assumptions we hold in approaching how we work. Here it's the assumption that order is a necessary condition for productivity. This assumption has also fostered the idea that disorder must be detrimental to organisational productivity. The result is that businesses and people spend time and money organising themselves for the sake of organising, rather than actually looking at the end goal and usefulness of such an effort. What's more, recent studies show that order actually has diminishing returns. Order does increase productivity to a certain extent, but eventually the usefulness of the process of organisation, and the benefit it yields, reduce until the point where any further increase in order reduces productivity. Some argue that in a business, if the cost of formally structuring something outweighs the benefit of doing it, then that thing ought not to be formally structured. Instead, the resources involved can be better used elsewhere.\n\nc_p...ui\n\n**Section F**\n\n**Section G**\n\nH In fact, research shows that, when innovating, the best approach is to create an environment devoid of structure and hierarchy and enable everyone involved to engage as one organic group. These environments can iead to new soiutions that, under convenåonaiiy siruciured environments (filled with bottlenecks in terms of information flow, power structures, rules, and routines) would never be reached. In recent times companies have slowly started to embrace this disorganisation. Many of them embrace it in terms of perception (embracing the idea of disorder, as opposed to fearing it) and in terms of process (putting mechanisms in place to reduce structure). For example, Oticon, a large Danish manufacturer of hearing aids, used what it called a 'spaghetti' structure in order to reduce the organisation's rigid hierarchies. This involved scrapping formal job titles and giving staff huge amounts of ownership over their own time and projects. This approach proved to be highly successful initially, with clear improvements in worker productivity in all facets of the business. In similar fashion, the former chairman of General Electric embraced disorganisation, putting forward the idea of the 'boundaryless' organisation. Again, it involves breaking down the barriers between different parts of a company and encouraging virtual collaboration and flexible working. Google and a number of other tech companies have embraced (at least in part) these kinds of flexible structures, facilitated by technology and strong company values which glue people together. A word of warning to others thinking of jumping on this bandwagon: the evidence so far suggests disorder, much like order, also seems to have diminishing utility, and can also have detrimental effects on performance if overused. Like order, disorder should be embraced only so far as it is useful. But we should not fear it - nor venerate one over the other. This research also shows that we should continually question whether or not our existing assumptions work.
67	159	The Concept of Intelligence	Looked at in one way, everyone knows what intelligence is; looked at in another way, no one does. In other words, people all have unconscious notions - known as 'implicit theories' - of intelligence, but no one knows for certain what it actually is. This chapter addresses how people conceptualize intelligence, whatever it may actually be. But why should we even care what people think intelligence is, as opposed only to valuing whatever it actually is? There are at least four reasons people's conceptions of intelligence matter. First, implicit theories of intelligence drive the way in which people perceive and evaluate their own intelligence and that of others. To better understand the judgments people make about their own and others' abilities, it is useful to learn about people's implicit theories. For example, parents' implicit theories of their children's language development will determine at what ages they will be willing to make various corrections in their children's speech. More generally, parents' implicit theories of intelligence will determine at what ages they believe their children are ready to perform various cognitive tasks. Job interviewers will make hiring decisions on the basis of their implicit theories of intelligence. People will decide who to be friends with on the basis of such theories. In sum, knowledge about implicit theories of intelligence is important because this knowledge is so often used by people to make judgments in the course of their everyday lives. Second, the implicit theories of scientific investigators ultimately give rise to their explicit theories. Thus it is useful to find out what these implicit theories are. Implicit theories provide a framework that is useful in defining the general scope ofa phenomenon - especially a not-well-understood phenomenon. These implicit theories can suggest what aspects of the phenomenon have been more or less attended to in previous investigations. Third, implicit theories can be useful when an investigator suspects that existing explicit theories are wrong or misleading. If an investigation of implicit theories reveals little correspondence between the extant implicit and explicit theories, the implicit theories may be wrong. But the possibility also needs to be taken into account that the explicit theories are wrong and in need of correction or supplementation. For example, some implicit theories of intelligence suggest the need for expansion of some of our explicit theories of the construct.\n\n**Section E**\n\n**Section F**\n\n**Section H**\n\nJ Finally, understanding implicit theories of intelligence can help elucidate developmental and cross-cultural differences. As mentioned earlier, people have expectations for intellectual performances that differ for chiidren of different ages. How Lhese expectations differ is in part a function of culture. For example, expectations for children who participate in Western-style schooling are almost certain to be different from those for children who do not participate in such schooling. I have suggested that there are three major implicit theories of how intelligence relates to society as a whole (Sternberg, 1997). These might be called Hamiltonian, Jeffersonian, and Jacksonian. These views are not based strictly, but rather, loosely, on the philosophies of Alexander Hamilton, Thomas Jefferson, and Andrew Jackson, three great statesmen in the history of the United States. The Hamiltonian view, which is similar to the Platonic view, is that people are born with different levels of intelligence and that those who are less intelligent need the good offices of the more intelligent to keep them in line, whether they are called government officials or, in Plato's term, philosopher-kings. Herrnstein and Murray (1994) seem to have shared this belief when they wrote about the emergence of a cognitive (high-IQ) elite, which eventually would have to take responsibility for the largely irresponsible masses of non-elite (low-IQ) people who cannot take care of themselves. Left to themselves, the unintelligent would create, as they always have created, a kind of chaos. The Jeffersonian view is that people should have equal opportunities, but they do not necessarily avail themselves equally of these opportunities and are not necessarily equally rewarded for their accomplishments. People are rewarded for what they accomplish, if given equal opportunity. Low achievers are not rewarded to the same extent as high achievers. In the Jeffersonian view, the goal of education is not to favor or foster an elite, as in the Hamiltonian tradition, but rather to allow children the opportunities to make full use of the skills they have. My own views are similar to these (Sternberg, 1997). The Jacksonian view is that all people are equal, not only as human beings but in terms of their competencies - that one person would serve as well as another in government or on a jury or in almost any position of responsibility. In this view of democracy, people are essentially intersubstitutable except for specialized skills, all of which can be learned. In this view, we do not need or want any institutions that might lead to favoring one group over another. Implicit theories of intelligence and of the relationship of intelligence to society perhaps need to be considered more carefully than they have been because they often serve as underlying presuppositions for explicit theories and even experimental designs that are then taken as scientific contributions. Until scholars are able to discuss their implicit theories and thus their assumptions, they are likely to miss the point of what others are saying when discussing their explicit theories and their data.
68	160	Saving Bugs to Find New Drugs	Zoologist Ross Piper looks at the potential of insects in pharmaceutical research\n\nMore drugs than you might think are derived from, or inspired by, compounds found in living things. Looking to nature for the soothing and curing of our ailments is nothing new - we have been doing it for tens of thousands of years. You only have to look at other primates - such as the capuchin monkeys who rub themselves with toxin-oozing millipedes to deter mosquitoes, or the chimpanzees who use noxious forest plants to rid themselves of intestinal parasites - to realise that our ancient ancestors too probably had a basic grasp of medicine.\n\nPharmaceutical science and chemistry built on these ancient foundations and perfected the extraction, characterisation, modification and testing of these natural products. Then, for a while, modern pharmaceutical science moved its focus away from nature and into the laboratory, designing chemical compounds from scratch. The main cause of this shift is that although there are plenty of promising chemical compounds in nature, finding them is far from easy. Securing sufficient numbers of the organism in question, isolating and characterising the compounds of interest, and producing large quantities of these compounds are all significant hurdles.\n\nLaboratory-based drug discovery has achieved varying levels of success, something which has now prompted the development of new approaches focusing once again on natural products. With the ability to mine genomes for useful compounds, it is now evident that we have barely scratched the surface of nature's molecular diversity. This realisation, together with several looming health crises, such as antibiotic resistance, has put bioprospecting - the search for useful compounds in nature - firmly back on the map.\n\nInsects are the undisputed masters of the terrestrial domain, where they occupy every possible niche. Consequently, they have a bewildering array of interactions with other organisms, something which has driven the evolution of an enormous range of very interesting compounds for defensive and offensive purposes. Their remarkable diversity exceeds that of every other group of animals on the planet combined. Yet even though insects are far and away the most diverse animals in existence, their potential as sources of therapeutic compounds is yet to be realised.\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH From the tiny proportion of insects that have been investigated, several promising compounds have been identified. For example, alloferon, an antimicrobial compound produced by biow ily iarvae, is used as an anüvicai and aniiiumof ageni in South Korea and Russia. The larvae of a few other insect species are being investigated for the potent antimicrobial compounds they produce. Meanwhile, a compound from the venom of the wasp Polybia paulista has potential in cancer treatment. Why is it that insects have received relatively little attention in bioprospecting? Firstly, there are so many insects that, without some manner of targeted approach, investigating this huge variety of species is a daunting task. Secondly, insects are generally very small, and the glands inside them that secrete potentially useful compounds are smaller still. This can make it difficult to obtain sufficient quantities of the compound for subsequent testing. Thirdly, although we consider insects to be everywhere, the reality of this ubiquity is vast numbers of a few extremely common species. Many insect species are infrequently encountered and very difficult to rear in captivity, which, again, can leave us with insufficient material to work with. My colleagues and I at Aberystwyth University in the UK have developed an approach in which we use our knowledge of ecology as a guide to target our efforts. The creatures that particularly interest us are the many insects that secrete powerful poison for subduing prey and keeping it fresh for future consumption. There are even more insects that are masters of exploiting filthy habitats, such as faeces and carcasses, where they are regularly challenged by thousands of micro- organisms. These insects have many antimicrobial compounds for dealing with pathogenic bacteria and fungi, suggesting that there is certainly potential to find many compounds that can serve as or inspire new antibiotics. Although natural history knowledge points us in the right direction, it doesn't solve the problems associated with obtaining useful compounds from insects. Fortunately, it is now possible to snip out the stretches of the insect's DNA that carry the codes for the interesting compounds and insert them into cell lines that allow larger quantities to be produced. And although the road from isolating and characterising compounds with desirable qualities to developing a commercial product is very long and full of pitfalls, the variety of successful animal-derived pharmaceuticals on the market demonstrates there is a precedent here that is worth exploring. With every bit of wilderness that disappears, we deprive ourselves of potential medicines. As much as I'd love to help develop a groundbreaking insect-derived medicine, my main motivation for looking at insects in this way is conservation. I sincerely believe that all species, however small and seemingly insignificant, have a right to exist for their own sake. If we can shine a light on the darker recesses of nature's medicine cabinet, exploring the useful chemistry of the most diverse animals on the planet, I believe we can make people think differently about the value of nature.
69	161	The power of play in early development	The power of play\n\nVirtually every child, the world over, plays. The drive to play is so intense that children will do so in any circumstances, for instance when they have no real toys, or when parents do not actively encourage the behavior. In the eyes ofa young chilcL running, pretending, and building are fun. Researchers and educators know that these playful activities benefit the development of the whole child across social, cognitive, physical, and emotional domains. IndeecL play is such an instrumental component to healthy child development that the United Nations High Commission on Human Rights (1989) recognized play as a fundamental right of every child.\n\nYet, while experts continue to expound a powerful argument for the importance of play in children's lives, the actual time children spend playing continues to decrease. Today, children play eight hours less each week than their counterparts did two decades ago (Elkind 2008). Under pressure of rising academic standards, play is being replaced by test preparation in kindergartens and grade schools, and parents who aim to give their preschoolers a leg up are led to believe that flashcards and educational 'toys' are the path to success. Our society has created a false dichotomy between play and learning.\n\nThrough play, children learn to regulate their behavior, lay the foundations for later learning in science and mathematics, figure out the complex negotiations of social relationships, build a repertoire of creative problem-solving skills, and so much more. There is also an important role for adults in guiding children through playful learning opportunities.\n\nFull consensus on a formal definition of play continues to elude the researchers and theorists who study it. Definitions range from discrete descriptions of various types of play such as physical, construction, language, or symbolic play (Miller & Almon 2009), to lists of broad criteria, based on observations and attitudes, that are meant to capture the essence of all play behaviors (e.g. Rubin et al. 1983).\n\nA majority of the contemporary definitions of play focus on several key criteria. The founder of the National Institute for Play, Stuart Brown, has described play as 'anything that spontaneously is done for its own sake'. More specifically, he says it 'appears purposeless, produces pleasure and joy, [and] leads one to the next stage of mastery' (as quoted in Tippett 2008). Similarly, Miller and Almon (2009) say that play includes 'activities that are freely chosen and directed by children and arise from intrinsic motivation'. Often, play is defined along a continuum as more or less playful using the following set of behavioral and dispositional criteria (e.g. Rubin et al. 1983):\n\nPlay is pleasurable: Children must enjoy the activity or it is not play. It is intrinsically motivated: Children engage in play simply for the satisfaction the behavior itself brings. It has no extrinsically motivated function or goal. Play is process oriented: When children play, the means are more important than the ends. It is freely chosen, spontaneous and voluntary. If a child is pressurect they will likely not think of the activity as play. Play is actively engaged: Players must be physically and/or mentally involved in the activity. Play is non-literal. It involves make-believe.\n\nAccording to this view, children's playful behaviors can range in degree from 0% to 100% playful. Rubin and colleagues did not assign greater weight to any one dimension in determining playfulness; however, other researchers have suggested that process orientation and a lack of obvious functional purpose may be the most important aspects of play (e.g. Pellegrini 2009).\n\nFrom the perspective of a continuum, play can thus blend with other motives and attitudes that are less playful, such as work. Unlike play, work is typically not viewed as enjoyable and it is extrinsically motivated (i.e. it is goal oriented). Researcher Joan Goodman (1994) suggested that hybrid forms of work and play are not a detriment to learning; rather, they can provide optimal contexts for learning. For example, a child may be engaged in a diffcult, goal-directed activity set up by their teacher, but they may still be actively engaged and intrinsically motivated. At this mid-point between play and work, the child's motivation, coupled with guidance from an adult, can create robust opportunities for playful learning.\n\nCritically, recent research supports the idea that adults can facilitate childrerfi learning while maintaining a playful approach in interactions known as 'guided play' (Fisher et al. 2011). The adult's role in play varies as a function of their educational goals and the child's developmental level (Hirsch-Pasek et al. 2009).\n\nGuided play takes two forms. At a very basic level, adults can enrich the child's environment by providing objects or experiences that promote aspects of a curriculum. In the more direct form of guided play, parents or other adults can support childrenk play by joining in the fun as a co-player, raising thoughtful questions, commenting on childrerB discoveries, or encouraging further exploration or new facets to the child's activity. Although playful learning can be somewhat structurect it must also be child-centered (Nicolopolou et al. 2006). Play should stem from the child's own desire.\n\nBoth free and guided play are essential elements in a child-centered approach to playful learning. Intrinsically motivated free play provides the child with true autonomy, while guided play is an avenue through which parents and educators can provide more targeted learning experiences. In either case, play should be actively engaged, it should be predominantly child-directed, and it must be fun.
70	166	The secret of staying young	The secret of staying young\n\nPheidole dentata, a native ant of the south-eastern U.S., isn't immortal. But scientists have found that it doesn't seem to show any signs of aging. Old worker ants can do everything just as well as the youngsters, and their brains appear just as sharp. 'We get a picture that these ants really don't decline,' says Ysabel Giraldo, who studied the ants for her doctoral thesis at Boston University.\n\nSuch age-defying feats are rare in the animal kingdom. Naked mole rats can live for almost 30 years and stay fit for nearly their entire lives. They can still reproduce even when old, and they never get cancer. But the vast majority of animals deteriorate with age just like people do. Like the naked mole rat, ants are social creatures that usually live in highly organised colonies. 'Ift this social complexity that makes P dentata useful for studying aging in people,' says Giraldo, now at the California Institute of Technology. Humans are also highly social, a trait that has been connected to healthier aging. By contrast, most animal studies of aging use mice, worms or fruit flies, which all lead much more isolated lives.\n\nIn the lab, R dentata worker ants typically live for around 140 days. Giraldo focused on ants at four age ranges: 20 to 22 days, 45 to 47 days, 95 to 97 days and 120 to 122 days. Unlike all previous studies, which only estimated how old the ants were, her work tracked the ants from the time the pupae became adults, so she knew their exact ages. Then she put them through a range of tests.\n\nGiraldo watched how well the ants took care of the young of the colony, recording how often each ant attended to, carried and fed them. She compared how well 20-day-old and 95-day-old ants followed the telltale scent that the insects usually leave to mark a trail to food. She tested how ants responded to light and also measured how active they were by counting how often ants in a small dish walked across a line. And she experimented with how ants react to live prey: a tethered fruit fly. Giraldo expected the older ants to perform poorly in all these tasks. But the elderly insects were all good caretakers and trail-followers-the 95-day-oldants could track the scent even longer than their younger counterparts. They all responded to light well, and the older ants were more active. And when it came to reacting to prey, the older ants attacked the poor fruit fly just as aggressively as the young ones did, flaring their mandibles or pulling at the fly's legs.\n\nThen Giraldo compared the brains of 20-day-old and 95-day-old ants, identifying any cells that were close to death. She saw no major differences with age, nor was there any difference in the location of the dying cells, showing that age didn't seem to affect specific brain functions. Ants and other insects have structures in their brains called mushroom bodies, which are important for processing information, learning and memory. She also wanted to see if aging affects the density of synaptic complexes within these structures-regions where neurons come together. Again, the answer was no. What was more, the old ants didn't experience any drop in the levels of either serotonin or dopamine-brain chemicals whose decline often coincides with aging. In humans, for example, a decrease in serotonin has been linked to Alzheimer's disease.\n\n'This is the first time anyone has looked at both behavioral and neural changes in these ants so thoroughly,' says Giraldo, who recently published the findings in the Proceedings of the Royal Society B. Scientists have looked at some similar aspects in bees, but the results ofrecent bee studies were mixed-some studies showed age-related declines, which biologists call senescence, and others didn't. 'For now, the study raises more questions than it answers,' Giraldo says, 'including how P dentata stays in such good shape.'\n\nAlso, if the ants don't deteriorate with age, why do they die at all? Out in the wiu the ants probably don't live for a full 140 days thanks to predators, disease and just being in an environment that's much harsher than the comforts of the lab. 'The lucky ants that do live into old age may suffer a steep decline just before dying,' Giraldo says, but she can't say for sure because her study wasn't designed to follow an ant's final moments.\n\n'It will be important to extend these findings to other species of social insects,' says Gene E. Robinson, an entomologist at the University of Illinois at Urbana-Champaign. This ant might be unique, or it might represent a broader pattern among other social bugs with possible clues to the science of aging in larger animals. Either way, it seems that for these ants, age really doesn't matter.
71	167	Why zoos are good	Why zoos are good\n\nScientist David Hone makes the case for zoos In my view, it is perfectly possible for many species of animals living in zoos or wildlife parks to have a quality of life as high as, or higher than, in the wild. Animals in good zoos get a varied and high-quality dietvith all the supplements required, and any illnesses they might have will be treated. Their movement might be somewhat restricted, but they have a safe environment in which to live, and they are spared bullying and social ostracism by others of their kind. They do not suffer from the threat or stress of predators, or the irritation and pain of parasites or injuries. The average captive animal will have a greater life expectancy compared with its wild counterpart, and will not die of drought, of starvation or in the jaws of a predator. A lot of very nasty things happen to truly 'wild' animals that simply don't happen in good zoos, and to view a life that is 'free' as one that is automatically 'good' is, I think, an error. Futthermore, zoos serve several key purposes. Firstly, zoos aid conservation. Colossal numbers of species are becoming extinct across the world, and many more are increasingly threatened and therefore risk extinction. Moreover, some of these collapses have been sudden, dramatic and unexpected, or were simply discovered very late in the day. A species protected in captivity can be bred up to provide a reservoir population against a population crash or extinction in the wild. A good number of species only exist in captivity, with many of these living in zoos. Still more only exist in the wild because they have been reintroduced from zoos, or have wild populations that have been boosted by captive bred animals. Without these efforts there would be fewer species alive today. Although reintroduction successes are few and far between, the numbers are increasing, and the very fact that species have been saved or reintroduced as a result of captive breeding proves the value of such initiatives. Zoos also provide education. Many children and adults, especially those in cities, will never see a wild animal beyond a fox or pigeon. While it is true that television documentaries are becoming ever more detailed and impressive, and many natural history specimens are on display in museums, there really is nothing to compare with seeing a living creature in the flesh, hearing it, smelling it, watching what it does and having the time to absorb details. That alone will bring a greater understanding and perspective to many, and hopefully give them a greater appreciation for wildlife, conservation efforts and how they can contribute.\n\n**Section D**\n\n**Section E**\n\nF In addition to this, there is also the education that can take place in zoos through signs, talks and presentations which directly communicate information to visitors about the animals they are seeing and their place in the world. This was an area where zoos used to be lacking, but they are now increasingly sophisticated in their communication and outreach work. Many zoos also work directly to educate conservation workers in other countries, or send their animal keepers abroad to contribute their knowledge and skills to those working in zoos and reserves, thereby helping to improve conditions and reintroductions all over the world. Zoos also play a key role in research. If we are to save wild species and restore and repair ecosystems we need to know about how key species live, act and react. Being able to undertake research on animals in zoos where there is less risk and fewer variables means real changes can be effected on wild populations. Finding out about, for example, the oestrus cycle of an animal or its breeding rate helps us manage wild populations. Procedures such as capturing and moving at-risk or dangerous individuals are bolstered by knowledge gained in zoos about doses for anaesthetics, and by experience in handling and transporting animals. This can make a real difference to conservation efforts and to the reduction of human-animal conflicts, and can provide a knowledge base for helping with the increasing threats of habitat destruction and other problems. In conclusion, considering the many ongoing global threats to the environment, it is hard for me to see zoos as anything other than essential to the long-term survival of numerous species. They are vital not just in terms of protecting animals, but as a means of learning about them to aid those still in the wild, as well as educating and informing the general population about these animals and their world so that they can assist or at least accept the need to be more environmentally conscious. Without them, the world would be, and would increasingly become, a much poorer place.
72	168	Ocean Clean-up: Chelsea Rochman	lsea Rochman, an ecologist at the University of California, Davis, has been trying to answer a dismal question: Is everything terrible, or are things just very, very bad?\n\nRochman is a member ofthe National Center for Ecological Analysis and Synthesis's marine-debris working group, a collection of scientists who study, among other things, the growing problem of marine debris, also known as ocean trash. Plenty of studies have sounded alarm bells about the state of marine debris; in a recent paper published in the journal Ecology, Rochman and her colleagues set out to determine how many of those perceived risks are real.\n\nOften, Rochman says, scientists will end a paper by speculating about the broader impacts of what they've found. For example, a study could show that certain seabirds eat plastic bags, and go on to warn that whole bird populations are at risk of dying out. 'But the truth was that nobody had yet tested those perceived threats,' Rochman says. 'There wasn't a lot of information.'\n\nRochman and her colleagues examined more than a hundred papers on the impacts of marine debris that were published through 2013. Within each paper, they asked what threats scientists had studied - 366 perceived threats in all - and what they'd actually found.\n\nIn 83 percent of cases, the perceived dangers of ocean trash were proven true. In the remaining cases, the working group found the studies had weaknesses in design and content which affected the validity of their conclusions - they lacked a control group, for example, or used faulty statistics.\n\nStrikingly, Rochman says, only one well-designed study failed to find the effect it was looking for, an investigation of mussels ingesting microscopic plastic bits. The plastic moved from the mussels' stomachs to their bloodstreams, scientists found, and stayed there for weeks - but didn't seem to stress out the shellfish.\n\nWhile mussels may be fine eating trash, though, the analysis also gave a clearer picture of the many ways that ocean debris is bothersome.\n\nWithin the studies they looked at, most of the proven threats came from plastic debris, rather than other materials like metal or wood. Most of the dangers also involved large pieces of debris - animals getting entangled in trash, for example, or eating it and severely injuring themselves.\n\nBut a lot of ocean debris is 'microplastic', or pieces smaller than five millimeters. These may be ingredients used in cosmetics and toiletries, fibers shed by synthetic clothing in the wash, or eroded remnants of larger debris. Compared to the number of studies investigating large-scale debris, Rochman's group found little research on the effects of these tiny bits. 'There are a lot of open questions still for microplastic,' Rochman says, though she notes that more papers on the subject have been published since 2013, the cutoff point for the group's analysis.\n\nThere are also, she adds, a lot of open questions about the ways that ocean debris can lead to sea-creature death. Many studies have looked at how plastic affects an individual animal, or that animal's tissues or cells, rather than whole populations. And in the lab, scientists often use higher concentrations of plastic than what's really in the ocean. None of that tells us how many birds or fish or sea turtles could die from plastic pollution - or how deaths in one species could affect that animal's predators, or the rest of the ecosystem.\n\n'We need to be asking more ecologically relevant questions,' Rochman says. Usually, scientists don't know exactly how disasters such as a tanker accidentally spilling its whole cargo of oil and polluting huge areas of the ocean will affect the environment until after they've happened. 'We don't ask the right questions early enough,' she says. But if ecologists can understand how the slow-moving effect of ocean trash is damaging ecosystems, they might be able to prevent things from getting worse.\n\nAsking the right questions can help policy makers, and the public, figure out where to focus their attention. The problems that look or sound most dramatic may not be the best places to start. For example, the name of the 'Great Pacific Garbage Patch' - a collection of marine debris in the northern Pacific Ocean - might conjure up a vast, floating trash island. In reality though, much of the debris is tiny or below the surface; a person could sail through the area without seeing any trash at all. A Dutch group called 'The Ocean Cleanup' is currently working on plans to put mechanical devices in the Pacific Garbage Patch and similar areas to suck up plastic. But a recent paper used simulations to show that strategically positioning the cleanup devices closer to shore would more effectively reduce pollution over the long term.\n\n'I think clearing up some of these misperceptions is really important,' Rochman says. Among scientists as well as in the media, she says, 'A lot of the images about strandings and entanglement and all of that cause the perception that plastic debris is killing everything in the ocean.' Interrogating the existing scientific literature can help ecologists figure out which problems really need addressing, and which ones they'd be better off- like the mussels - absorbing and ignoring.
1	5	Nutmeg - a valuable spice	a valuable spice\n\nThe nutmeg tree, Myristica fragrans, is a large evergreen tree native to Southeast Asia. Until the late 18th century, it only grew in one place in the world: a small group of islands in the Banda Sea, part of the Moluccas - or Spice Islands - in northeastern Indonesia. The tree is thickly branched with dense foliage of tough, dark green oval leaves, and produces small, yellow, bell-shaped flowers and pale yellow pear-shaped fruits. The fruit is encased in a fleshy husk. When the fruit is me, this husk splits into two halves along a ridge running the length of the fruit. Inside is a purple-brown shiny seed, 2-3 cm long by about 2 cm across, surrounded by a lacy red or crimson covering called an 'aril'. These are the sources of the two spices nutmeg and mace, the former being produced from the dried seed and the latter from the aril.\n\nNutmeg was a highly prized and costly ingredient in European cuisine in the Middle Ages, and was used as a flavouring, medicinal, and preservative agent. Throughout this period, the Arabs were the exclusive importers of the spice to Europe. They sold nutmeg for high prices to merchants based in Venice, but they never revealed the exact location of the source of this extremely valuable commodity. The Arab-Venetian dominance of the trade finally ended in 1512, when the Portuguese reached the Banda Islands and began exploiting its precious resources.\n\nAlways in danger of competition from neighbouring Spain, the Portuguese began subcontracting their spice distribution to Dutch traders. Profits began to flow into the Netherlands, and the Dutch commercial fleet swiftly grew into one of the largest in the world. The Dutch quietly gamed control of most of the shipping and trading of spices in Northem Europe. Then, in 1580, Portugal fell under Spanish rule, and by the end of the 16th century the Dutch found themselves locked out of the market. As prices for pepper, nutmeg, and other spices soared across Europe, they decided to fight back.\n\nIn 1602, Dutch merchants founded the VOC, a trading corporation better known as the Dutch East India Company. By 1617, the VOC was the richest commercial operation in the world. The company had 50,000 employees worldwide, with a private army of 30,000 men and a fleet of 200 ships. At the sume üme, thousands of people across Europe were dying of the plague, a highly contagious and deadly disease. Doctors were desperate for a way to stop the spread of this disease, and they decided nutmeg held the cure. Everybody wanted nutmeg, and many were willing to spare no expense to have it. Nutmeg bought for a few pennies in Indonesia could be sold for 68,000 times its original cost on the streets of London. The only problem was the short supply. And that's where the Dutch found their opportunity.\n\nThe Banda Islands were ruled by local sultans who insisted on maintaining a neutral trading policy towards foreign powers. This allowed them to avoid the presence of Portuguese or Spanish troops on their soil, but it also left them unprotected from other invaders. In 1621, the Dutch arrived and took over. Once securely in control of the Bandas, the Dutch went to work protecting their new investment. They concentrated all nutmeg production into a few easily guarded areas, uprooting and destroying any trees outside the plantation zones. Anyone caught growing a nutmeg seedling or carrying seeds without the proper authority was severely punished. In addition, all exported nutmeg 's,vas covered with lime to make sure there was no chance a fertile seed which could be grown elsewhere would leave the islands. There was only one obstacle to Dutch domination. One of the Banda Islands, a sliver of land called Run, only 3 km long by less than I km wide, was under the control of the British. After decades of fighting for control of this tiny island, the Dutch and British arrived at a compromise settlement, the Treaty of Breda, in 1667. Intent on securing their hold over every nutmeg-producing island, the Dutch offered a trade: if the British would give them the island of Run, they would in turn give Britain a distant and much less valuable island in North America. The British agreed. That other island was Manhattan, which is how New Amsterdam became New York. The Dutch now had a monopoly over the nutmeg trade which would last for another century.\n\nThen, in 1770, a Frenchman named Pierre Poivre successfully smuggled nutmeg plants to safety in Mauritius, an island off the coast of Africa. Some of these were later exported to the Caribbean where they thrived, especially on the island of Grenada. Next, in 1778, a volcanic eruption in the Banda region caused a tsunami that wiped out half the nutmeg groves. Finally, in 1809, the British returned to Indonesia and seized the Banda Islands by force. They returned the islands to the Dutch in 1817, but not before transplanting hundreds of nutmeg seedlings to plantations in several locations across southern Asia. The Dutch nutmeg monopoly was over.\n\nToday, nuttneg is grown in Indonesia, the Caribbean, India, Malaysia, Papua New Guinea and Sri Lanka, and world nutmeg production is estimated to average between I and 12,000 tonnes per year.\n\nQuestions
7	19	Henry Moore (1898-1986)	Henry Moore (1898-1986)\n\nThe British sculptor Henry Moore was a leading figure in the 20th-century art world\n\nHenry Moore was born in Castleford, a small town near Leeds in the north of England. He was the seventh child of Raymond Moore and his wife Mary Baker. He studied at Castleford Grammar School from 1909 to 1915, where his early interest in art was encouraged by his teacher Alice Gostick. After leaving school, Moore hoped to become a sculptor, but instead he complied with his father's wish that he train as a schoolteacher. He had to abandon his training in 1917 when he was sent to France to fight in the First World War.\n\nAfter the war, Moore enrolled at the Leeds School of Art, where he studied for two years. In his first year, he spent most of his time drawing. Although he wanted to study sculpture, no teacher was appointed until his second year. At the end of that year, he passed the sculpture examination and was awarded a scholarship to the Royal College ofArt in London. In September 1921, he moved to London and began three years of advanced study in sculpture.\n\nAlongside the instruction he received at the Royal College, Moore visited many of the London museums, particularly the British Museum, which had a wide-ranging collection of ancient sculpture. During these visits, he discovered the power and beauty of ancient Egyptian and African sculpture. As he became increasingly interested in these 'primitive' forms of art, he turned away from European sculptural traditions.\n\nAfter graduating, Moore spent the first six months of 1925 travelling in France. When he visited the Trocadero Museum in Paris, he was impressed by a cast ofa Mayan sculpture of the rain spirit. It was a male reclining figure with its knees drawn up together, and its head at a right angle to its body. Moore became fascinated with this stone sculpture, which he thought had a power and originality that no other stone sculpture possessed. He himself started carving a variety of subjects in stone, including depictions of reclining women, mother-and-child groups, and masks.\n\nMoore's exceptional talent soon gained recognition, and in 1926 he started work as a sculpture instructor at the Royal College. In 1933, he became a member of a group of young artists called Unit One. The aim of the group was to convince the English public of the merits of the emerging international movement in modern art and architecture.\n\ne Mayan: belonging to an ancient civilisation that inhabited parts of current-day Mexico, Guatemala, Belize, El Salvador and Honduras.\n\nAround this time, Moore moved away from the human figure to experiment with abstract shapes. In 1931, he held an exhibition at the Leicester Galleries in London. His work was enthusiastically welcomed by fellow sculptors, but the reviews in the press were extremely negative and turned Moore into a notorious figure. There were calls for his resignation from the Royal College, and the following year, when his contract expired, he left to start a sculpture department at the Chelsea School of Art in London.\n\nThroughout the 1930s, Moore did not show any inclination to please the British public. He became interested in the paintings of the Spanish artist Pablo Picasso, whose work inspired him to distort the human body in a radical way. At times, he seemed to abandon the human figure altogether. The pages of his sketchbooks from this period show his ideas for abstract sculptures that bore little resemblance to the human form.\n\nIn 1940, during the Second World War, Moore stopped teaching at the Chelsea School and moved to a farmhouse about 20 miles north of London. A shortage of materials forced him to focus on drawing. He did numerous small sketches of Londoners, later turning these ideas into large coloured drawings in his studio. In 1942, he returned to Castleford to make a series of sketches of the miners who worked there.\n\nIn 1944, Harlow, a town near London, offered Moore a commission for a sculpture depicting a family. The resulting work signifies a dramatic change in Moore's style, away from the experimentation of the 1930s towards a more natural and humanistic subject matter. He did dozens of studies in clay for the sculpture, and these were cast in bronze and issued in editions of seven to nine copies each. In this way, Moore's work became available to collectors all over the world. The boost to his income enabled him to take on ambitious projects and start working on the scale he felt his sculpture demanded.\n\nCritics who had begun to think that Moore had become less revolutionary were proven wrong by the appearance, in 1950, of the first of Moore's series of standing figures in bronze, with their harsh and angular pierced forms and distinct impression of menace. Moore also varied his subject matter in the 1950s with such works as Warrior with Shield and Falling Warrior. These were rare examples of Moore's use of the male figure and owe something to his visit to Greece in 1951, when he had the opportunity to study ancient works of art.\n\nIn his final years, Moore created the Henry Moore Foundation to promote art appreciation and to display his work. Moore was the first modern English sculptor to achieve international critical acclaim and he is still regarded as one of the most important sculptors of the 20th century.
11	27	Silbo Gomero - the whistle 'language' of the Canary Islands	the whistle 'language' of\n\nthe Canary Islands\n\nLa Gomera is one of the Canary Islands situated in the Atlantic Ocean off the northwest coast of Africa. This small volcamc island is mountainous, with steep rocky slopes and deep, wooded ravines, rising to 1,487 metres at its highest peak. It is also home to the best known of the world's whistle 'languages' a means of transmitting information over long distances which is perfectly adapted to the extreme terrain of the island.\n\nThis 'language' known as 'Silbo' or 'Silbo Gomero' - from the Spanish word for 'whistle' - is now shedding light on the language-processing abilities of the human brain, according to scientists. Researchers say that Silbo activates parts of the brain normally associated with spoken language, suggesting that the brain is remarkably flexible in its ability to interpret sounds as language.\n\n'Science has developed the idea of brain areas that are dedicated to language, and we are starting to understand the scope of signals that can be recognised as language,' says David Corina, co-author of a recent study and associate professor of psychology at the University of Washington in Seattle.\n\nSilbo is a substitute for Spanish, with individual words recoded into whistles which have high- and low-frequency tones. A whistler - or silbador - puts a finger in his or her mouth to increase the whistle's pitch, while the other hand can be cupped to adjust the direction of the sound. 'There is much more ambiguity in the whistled signal than in the spoken signal,' explains lead researcher Manuel Carreiras, psychology professor at the University of La Laguna on the Canary island of Tenerife. Because whistled 'words' can be hard to distinguish, silbadores rely on repetition, as well as awareness of context, to make themselves understood,\n\nThe silbadores of Gomera are traditionally shepherds and other isolated mountain folk, and their novel means of staying in touch allows them to communicate over distances of up to I O kilometres. Carreiras explains that silbadores are able to pass a surprising amount of information via their whistles. 'In daily life they use whistles to communicate short commands, but any Spanish sentence could be whistled.' Silbo has proved particularly useful when fires have occurred on the island and rapid communication across large areas has been vital.\n\nThe study team used neuroimaging equipment to contrast the brain activity of silbadores while listening to whistled and spoken Spanish. Results showed the left temporal lobe of the brain, which is usually associated with spoken language, was engaged during the processing of Silbo. The researchers found that other key regions in the brain's frontal lobe also responded to the whistles, including those activated in response to sign language among deaf people. When the experiments were repeated with non-whistlers, however, activation was observed in all areas of the brain.\n\n'Our results provide more evidence about the flexibility of human capacity for language in a variety of forms,' Corina says. 'These data suggest that left-hemisphere language regions are uniquely adapted for communicative purposes, independent of the modality of signal. The non- Silbo speakers were not recognising Silbo as a language. They had nothing to grab onto, so multiple areas of their brains were activated.'\n\nCarreiras says the origins of Silbo Gomero remain obscure, but that indigenous Canary Islanders, who were of North African origin, already had a whistled language when Spain conquered the volcanic islands in the 15th century. Whistled languages survive-today in Papua New Guinea, Mexico, Vietnam, Guyana, China, Nepal, Senegal, and a few mountainous pockets in southern Europe. There are thought to be as many as 70 whistled languages still in use, though only 12 have been described and studied scientifically. This form of communication is an adaptation found among cultures where people are often isolated from each other, according to Julien Meyer, a researcher at the Institute of Human Sciences in Lyon, France. 'They are mostly used in mountains or dense forests,' he says. 'Whistled languages are quite clearly defined and represent an original adaptation of the spoken language for the needs of isolated human groups.'\n\nBut with modern communication technology now widely available, researchers say whistled languages like Silbo are threatened with extinction. With dwindling numbers of Gomera islanders still fluent in the language, Canaries' authorities are taking steps to try to ensure its survival. Since 1999, Silbo Gomero has been taught in all of the island's elementary schools. In addition, locals are seeking assistance from the United Nations Educational, Scientific and Cultural Organization (UNESCO). 'The local authorities are trying to get an award from the organisation to declare [Silbo Gomero] as something that should be preserved for humanity,' Carreiras adds.
14	34	European Transport Systems 1990-2010	**Paragraph G**\n\n**Paragraph H**\n\nParagraph I EUROPEAN TRANSPORT SYSTEMS\n\n1990-2010\n\nWhat have been the trends and what are the prospects for European transport systems?\n\nA It is difficult to conceive of vigorous economic growth without an efficient transport system. Although modern information technologies can reduce the demand for physical transport by facilitating teleworking and teleservices, the requirement for transport continues to increase. There are two key factors behind this trend. For passenger transport, the determining factor is the spectacular growth in car use. The number of cars on European Union (ELJ) roads saw an increase of three million cars each year from 1990 to 2010, and in the next decade the EU will see a further substantial increase in its fleet.\n\nB As far as goods transport is concerned, growth is due to a large extent to changes in the European economy and its system of production. In the last 20 years, as internal frontiers have been abolished, the EIJ has moved from a 'stock' economy to a 'flow' economy. This phenomenon has been emphasised by the relocation of some industries, particularly those which are labour intensive, to reduce production costs, even though the production site is hundreds or even thousands of kilometres away from the final assembly plant or away from users.\n\nC The strong economic growth expected in countries which are candidates for entry to the EIJ will also increase transport flows, in particular road haulage traffic, In 1998. some of these countries already exported more than twice their I ggo volumes and imported more than five times their 1990 volumes. And although many candidate countries inherited a transport system which encourages rail, the distribution between modes has tipped sharply in favour of road transport since the 1 ggos. Between 1990 and 1 998, road haulage increased by 19.4%, while during the same period rail haulage decreased by 43.5%, although - and this could benefit the enlarged ELJ - it is still on average at a much higher level than in existing member states. D However, a new imperative - sustainable development - offers an opportunity for adapting the EUs common transport policy. This objective, agreed by the Gothenburg European Council, has to be achieved by integrating environmental considerations into Community policies, and shifting the balance between modes of transport lies at the heart of its strategy. The ambitious objective can only be fully achieved by 2020, but proposed measures are nonetheless a first essential step towards a sustainable transport system which will ideally be in place in 30 years' time, that is by 2040.\n\nE In 1 998, energy consumption in the transport sector was to blame for 28% of emissions of C02, the leading greenhouse gas. According to the latest estimates, if nothing is done to reverse the traffic growth trend, C02 emissions from transport can be expected to increase by around 50% to I 113 billion tonnes by 2020, compared with the 739 billion tonnes recorded in 1990. Once again, road transport is the main culprit since it alone accounts for 84% of the C02 emissions attributable to transport. Using alternative fuels and improving energy efficiency is thus both an ecological necessity and a technological challenge. F At the same time greater efforts must be made to achieve a modal shift. Such a change cannot be achieved overnight, all the less so after over half a century of constant deterioration in favour of road. This has reached such a pitch that today rail freight services are facing marginalisation, with just 8% of market share, and with international goods trains struggling along at an average speed of 18km/h. Three possible options have emerged. G The first approach would consist of focusing on road transport solely through pricing. This option would not be accompanied by complementary measures in the other modes of transport. In the short term it might curb the growth in road transport through the better loading ratio of goods vehicles and occupancy rates of passenger vehicles expected as a result of the increase in the price of transport. However, the lack of measures available to revitalise other modes of transport would make it impossible for more sustainable modes of transport to take up the baton. H The second approach also concentrates on road transport pricing but is accompanied by measures to increase the efficiency of the other modes (better quality of services. logistics, technology). However, this approach does not include investment in new infrastructure, nor does it guarantee better regional cohesion. It could help to achieve greater uncoupling than the first approach, but road transport would keep the lion's share of the market and continue to concentrate on saturated arteries, despite being the most polluting of the modes. It is therefore not enough to guarantee the necessary shift of the balance. I The third approach, which is not new, comprises a series of measures ranging from pricing to revitalising alternative modes of transport and targeting investment in the trans-European network. This integrated approach would allow the market shares of the other modes to return to their I gg8 levels and thus make a shift of balance. It is far more ambitious than it looks, bearing in mind the historical imbalance in favour of roads for the last fifty years, but would achieve a marked break in the link between road transport growth and economic growth, without placing restrictions on the mobility of people and goods.
28	68	Raising the Mary Rose	How a sixteenth-century warship was recovered from the seabed On 19 July 1545, English and French fleets were engaged in a sea battle off the coast of southern England in the area of water called the Solent, between Portsmouth and the Isle of Wight. Among the English vessels was a warship by the name of Mary Rose. Built in Portsmouth some 35 years earlier, she had had a long and successful fighting career, and was a favourite of King Henry VIII. Accounts of what happened to the ship vary: while witnesses agree that she was not hit\n\nby the French, some maintain that she was outdated, overladen and sailing too low in the water, others that she was mishandled by undisciplined crew. What is undisputed, however, is that the Mary Rose sank into.the Solent that day, taking at least 500 men with her. After the battle, attempts were made to recover the ship, but these failed.\n\nThe Mary Rose came to rest on the seabed, lying on her starboard (right) side at an angle of approximately 60 degrees. The hull (the body of the ship) acted as a trap for the sand and mud carried by Solent currents. As a result, the starboard side filled rapidly, leaving the exposed port (left) side to be eroded by marine organisms and mechanical degradation. Because of the way the ship sank, nearly all of the starboard half survived intact. During the seventeenth and eighteenth centuries, the entire site became covered with a layer of hard grey clay, which minimised further erosion.\n\nThen, on 16 June 1836, some fishermen in the Solent found that their equipment was caught on an underwater obstruction, which turned out to be the Mary Rose. Diver John Deane happened to be exploring another sunken ship nearby, and the fishermen approached him, asking him to free their gear. Deane dived down, and found the equipment caught on a timber protruding slightly from the seabed. Exploring further, he uncovered several other timbers and a bronze gun. Deane continued diving on the site intermittently until 1840, recovering several more guns, two bows, various timbers, part of a pump and various other small finds.\n\nThe Mary Rose then faded into obscurity for another hundred years. But in 1965, military historian and amateur diver Alexander McKee, in conjunction with the British Sub-Aqua Club, initiated a project called 'Solent Ships'. While on paper this was a plan to examine a number of known wrecks in the Solent, what McKee really hoped for was to find the Mary Rose. Ordinary search techniques proved unsatisfactory, so McKee entered into collaboration with Harold E. Edgerton, professor of electrical engineering at the Massachusetts Institute of Technology. In 1967, Edgerton's side-scan sonar systems revealed a large, unusually\n\nshaped object, which McKee believed was the Mary Rose. Further excavations revealed stray pieces of timber and an iron gun. But the climax to the operation came when, on 5 May 1971, part of the ship's frame was uncovered. McKee and his team now knew for certain that they had found the wreck, but were as yet unaware that it also housed a treasure trove of beautifully preserved artefacts. Interest in the project grew. and in 1979, The Mary Rose Trust was formed, with Prince Charles as its President and Dr Margaret\n\nRule its Archaeological Director. The decision whether or not to salvage the wreck was not an easy one, although an excavation in 1978 had shown that it might be possible to raise the hull. While the original aim was to raise the hull if at all feasible, the operation was not given the go-ahead _until January 1982, when all the necessary information was available.\n\nAn important factor in trying to salvage the Mary Rose was that the remaining hull was an open shell. This led to an important decision being taken: namely to carry out the lifting operation in three very distinct stages. The hull was attached to a lifting frame via a network of bolts and lifting wires. The problem of the hull being sucked back downwards into the mud was overcome by using 12 hydraulic jacks. These raised it a few centimetres over a\n\nperiod of several days, as the lifting frame rose slowly up its four legs. It was only when the hull was hanging freely from the lifting frame, clear of the seabed and the suction effect of the surrounding mud, that the salvage operation progressed to the second stage. In this stage, the lifting\n\nframe was fixed to a hook attached to a crane, and the hull was lifted completely clear of the seabed and transferred underwater into the lifting cradle. This required precise positioning to locate the legs into the 'stabbing guides' of the lifting cradle. The lifting cradle was designed to fit the hull using archaeological survey drawings, and was fitted with air bags to provide additional cushioning for the hull's delicate timber framework. The third and final stage was to lift the entire structure into the air, by which time the hull was also supported from below. Finally, on 11 October 1982, millions of people around the world held their breath as the timber skeleton of the Mary Rose was lifted clear of the water, ready to be returned home to Portsmouth.
29	69	What destroyed the civilisation of Easter Island?	A theory which supports a local belief v The future of Easter Island vi Two opposing views about the Rapanui people vii Destruction outside the inhabitants' control viii How the statues made a situation worse ix Diminishing food resources\n\n**Paragraph A**\n\n**Paragraph B**\n\n**Paragraph C**\n\n**Paragraph D**\n\n**Paragraph E**\n\n**Paragraph F**\n\n**Paragraph G**\n\nul>.!I (Jj {!;?.J-0 What destroyed the civilisation of Easter Island?\n\nA Easter Island, or Rapu Nui as it is known locally, is home to several hundred ancient human statues - the moai. After this remote Pacific island was settled by the Polynesians. it remained isolated for centuries. All the energy and resources that went into the moai - some of which are ten metres tall and weigh over 7,000 kilos - came from the island itself. Yet when Dutch explorers landed in 1722, they met a Stone Age culture. The moai were carved with stone tools, then transported for many kilometres, without the use of animals or wheels, to massive stone platforms. The identity of the moai builders was in doubt until well into the twentieth century. Thor Heyerdahl, the Norwegian ethnographer and adventurer, thought the statues had been created by pre-Inca peoples from Peru. Bestselling Swiss author Erich von Daniken believed they were built by stranded extraterrestrials. Modern science - linguistic, archaeological and genetic evidence - has definitively proved the moai builders were Polynesians, but not how they moved their creations.\n\nLocal folklore maintains that the statues walked, while researchers have tended to assume the ancestors dragged the statues somehow, using ropes and logs.\n\nB When the Europeans arrived, Rapa Nui was grassland, with only a few scrawny trees. In the 1970s and 1980s, though, researchers found pollen preserved in lake sediments, which proved the island had been covered in lush palm forests for thousands of years. Only after the Polynesians arrived did those forests disappear. US scientist Jared Diamond believes that the Rapanui people - descendants of Polynesian settlers - wrecked their own environment. They had unfortunately settled on an extremely fragile island - dry, cool, and too remote to be properly fertilised by windblown volcanic ash. When the islanders cleared the forests for firewood and farming, the forests didn't grow back. As trees became scarce and they could no longer construct wooden canoes for fishing, they ate birds. Soil erosion decreased their crop yields. Before Europeans arrived, the Rapanui had descended into civil war and cannibalism, he maintains. The collapse of their isolated civilisation, Diamond writes, is a 'worst-case scenario for what may lie ahead of us in our own future'.\n\nC The moai, he thinks, accelerated the self-destruction. Diamond interprets them as power displays by rival chieftains who, trapped on a remote little island, lacked other ways of asserting their dominance. They competed by building ever bigger figures. Diamond thinks they laid the moai on wooden sledges, hauled over log rails, but that required both a lot of wood and a lot of people. To feed the people, even more land had to be cleared. When the wood was gone and civil war began, the islanders began toppling the moai. By the nineteenth century none were standing.\n\nD Archaeologists Terry Hunt of the University of Hawaii and Carl Lipo of California State University agree that Easter Island lost its lush forests and that it was an 'ecological catastrophe' - but they believe the islanders themselves weren't to blame. And the moai certainly weren't. Archaeological excavations indicate that the Rapanui went to heroic efforts to protect the resources of their wind-lashed, infertile fields. They built thousands of circular stone windbreaks and gardened inside them, and used broken volcanic rocks to keep the soil moist. In short, Hunt and Lipo argue, the prehistoric Rapanui were pioneers of sustainable farming.\n\nE Hunt and Lipo contend that moai-building was an activity that helped keep the peace between islanders. They also believe that moving the moai required few people and no wood, because they were walked upright. On that issue, Hunt and Lipo say, archaeological evidence backs up Rapanui folklore. Recent experiments indicate that as few as 18 people could, with three strong ropes and a bit of practice, easily manoeuvre a 1,000 kg moai replica a few hundred metres. The figures' fat bellies tilted them forward, and a D-shaped base allowed handlers to roll and rock them side to side.\n\nF Moreover, Hunt and Lipo are convinced that the settlers were not wholly responsible for the loss of the island's trees. Archaeological finds of nuts from the extinct Easter Island palm show tiny grooves, made by the teeth of Polynesian rats. The rats arrived along with the settlers, and in just a few years, Hunt and Lipo calculate, they would have overrun the island. They would have prevented the\n\nreseeding of the slow-growing palm trees and thereby doomed Rapa Nui's forest, even without the settlers' campaign of deforestation. No doubt the rats ate birds' eggs too. Hunt and Lipo also see no evidence that Rapanui civilisation collapsed when the palm forest did. They think its population grew rapidly and then remained more or less stable until the arrival of the Europeans, who introduced deadly diseases to which islanders had no immunity. Then in the nineteenth century slave traders decimated the population, which shrivelled to 111 people by 1877.\n\nG Hunt and Lipo's vision, therefore, is one of an island populated by peaceful and ingenious nioai builders and careful stewards of the land, rather than by reckless destroyers ruining their own environment and society. 'Rather than a case of abject failure, Rapu Nui is an unlikely story of success', they claim. Whichever is the case, there are surely some valuable lessons which the world at large can learn from the story of Rapa Nui.
37	89	Cork	DIN9c\n\nPassage 1 below.\n\nCork\n\nCork - the thick bark of the, cork oak\n\ntree (Quercus suber) is a remarkable\n\nmaterial. It is tough, elastic, buoyant,\n\nand fire-resistant, and suitable for a\n\nwide range of purposes. It has also\n\nbeen used for millennia: the ancient\n\nEgyptians sealed their sarcophagi\n\n(stone coffins) with cork, while the\n\nancient Greeks and Romans used it\n\nfor anything from beehives to sandals.\n\nAnd the cork oak itself is an\n\nextraordinary tree. Its bark grows\n\nup to 20 cm in thickness, insulating\n\nthe tree like a coat wrapped around\n\nthe trunk and branches and keeping\n\nthe inside at a constant 200C all year\n\nround. Developed most probably as\n\na defence against forest fires, the\n\nbark of the cork oak has a particular\n\ncellular structure - with about\n\n40 million cells per cubic centimetre\n\nthat technology has never succeeded\n\nin replicating. The cells are filled with\n\nair, which is why cork is so buoyant.\n\nIt also has an elasticity that means\n\nyou can squash it and watch it spring\n\nback to its original size and shape\n\nwhen you release the pressure.\n\nCork oaks grow in a number of\n\nMediterranean countries, including Portugal, Spain, Italy, Greece and\n\nMorocco. "I hey flourish in warm, sunny\n\nclimates where there is a minimum of\n\n400 millimetres of rain per year, and\n\nnot more than 800 millimetres. Like\n\ngrape vines, the trees thrive in poor\n\nsoil, putting down deep roots in search\n\nof moisture and nutrients. Southern\n\nPortugal's Alentejo region meets all of\n\nthese requirements, which explains\n\nwhy, by the early 20th century, this\n\nregion had become the world's largest\n\nproducer of cork, and why today it\n\naccounts for roughly half of all cork\n\nproduction around the world.\n\nMost cork forests are family-owned.\n\nMany of these family businesses, and\n\nindeed many of the trees themselves,\n\nare around 200 years old. Cork\n\nproduction is, above all, an exercise in\n\npatience. From the planting of a cork\n\nsapling to the first harvest takes 25\n\nyears, and a gap of approximately a\n\ndecade must separate harvests from\n\nan individual tree. And for top-quality\n\ncork, it's necessary to wait a further\n\n15 or 20 years. You even have to wait\n\nfor the right kind of summer's day to\n\nharvest cork. If the bark is stripped on\n\na day when it's too cold - or when the\n\nair is damp - the tree will be damaged.\n\nCork harvesting is a very specialised\n\nprofession. No mechanical means\n\nof stripping cork bark has been\n\ninvented, so the job is done by teams\n\nof highly skilled workers. First, they\n\nmake vertical cuts down the bark\n\nusing small sharp axes, then lever\n\nit away in pieces as large as they\n\ncan manage. The most skilful cork-\n\nstrippers prise away a semi-circular\n\nhusk that runs the length of the trunk\n\nfrom just above ground level to the\n\nfirst branches. It is then dried on the\n\nground for about four months, before\n\nbeing taken to factories, where it is\n\nboiled to kill any insects that might\n\nremain in the cork. Over 60% of\n\ncork then goes on to be made into\n\ntraditional bottle stoppers, with most\n\nof the remainder being used in the\n\nconstruction trade. Corkboard and\n\ncork tiles are ideal for thermal and\n\nacoustic insulation, while granules of\n\ncork are used in the manufacture of\n\nconcrete.\n\nRecent years have seen the end of\n\nthe virtual monopoly of cork as the\n\nmaterial for bottle stoppers, due to\n\nconcerns about the effect it may have\n\non the contents of the bottle. This is caused by a chemical compound\n\ncalled 2,4,6-trichloroanisole (TCA),\n\nwhich forms through the interaction\n\nof plant phenols, chlorine and mould.\n\nThe tiniest concentrations - as little\n\nas three or four parts to a trillion\n\ncan spoil the taste of the product\n\ncontained in the bottle. The result\n\nhas been a gradual yet steady move\n\nfirst towards plastic stoppers and,\n\nmore recently, to aluminium screw\n\ncaps. These substitutes are cheaper to\n\nmanufacture and, in the case of screw\n\ncaps, more convenient for the user.\n\nThe classic cork stopper does\n\nhave several advantages, however.\n\nFirstly, its traditional image is more\n\nin keeping with that of the type of\n\nhigh quality goods with which it has\n\nlong been associated. Secondly\n\nand very importantly - cork is a\n\nsustainable product that can be\n\nrecycled without difficulty. Moreover,\n\ncork forests are a resource which\n\nsupport local biodiversity, and prevent\n\ndesertification in the regions where\n\nthey are planted. So, given the current\n\nconcerns about environmental issues,\n\nthe future of this ancient material\n\nonce again looks promising.
38	90	Collecting as a hobby	Collecting must be one of the most varied\n\nof human activities, and it's one that many\n\nof us psychologists find fascinating. Many\n\nforms of collecting have been dignified\n\nwith a technical name: an archtophilist\n\ncollects teddy bears, a philatelist collects\n\npostage stamps, and a deltiologist\n\ncollects postcards. Amassing hundreds or\n\neven thousands of postcards, chocolate\n\nwrappers or whatever, takes time, energy\n\nand money that could surely be put to\n\nmuch more productive use. And yet there\n\nare millions of collectors around the world.\n\nWhy do they do it?\n\nThere are the people who collect because\n\nthey want to mal<e money - this could be\n\ncalled an instrumental reason for collecting;\n\nthat is, collecting as a means to an end.\n\nThey'll look for, say, antiques that they\n\ncan buy cheaply and expect to be able\n\nto sell at a profit. But there may well be a\n\npsychological element, too - buying cheap\n\nand selling dear can give the collector a\n\nsense of triumph. And as selling online is so\n\neasy, more and more people are joining in.\n\nMany collectors collect to develop their\n\nsocial lifet attending meetings of a group\n\nof collectors and exchanging information\n\non items. This is a variant on joining a\n\nbridge club or a gym, and similarly brings\n\nthem into contact with lil<e-minded people.\n\nAnother motive for collecting is the desire\n\nto find something special, or a particular\n\nexample of the collected item, such as a\n\nrare early recording by a particular singer. Some may spend their whole lives in a\n\nhunt for this. Psychologically, this can give\n\na purpose to a life that otherwise feels\n\naimless. There is a danger, though, that\n\nif the individual is ever lucky enough to\n\nfind what they're looking for, rather than\n\ncelebrating their success, they may feel\n\nempty/ now that the goal that drove them\n\non has gone.\n\nIf you thinl< about collecting postage\n\nstamps, another potential reason for\n\nit or, perhaps, a result of collecting - is\n\nits educational value. Stamp collecting\n\nopens a window to other countries, and\n\nto the plants, animals, or famous people\n\nshown on their stamps. Similarly, in the\n\n19th century, many collectors amassed\n\nfossils, animals and plants from around\n\nthe globe, and their collections provided\n\na vast amount of information about the\n\nnatural world. Without those collections,\n\nour understanding would be greatly inferior\n\nto what it is.\n\nIn the past - and nowadays, too, though\n\nto a lesser extent - a popular form of\n\ncollecting, particularly among boys\n\nand men, was trainspotting. This might\n\ninvolve trying to see every locomotive of a\n\nparticular type, using published data that\n\nidentifies each one, and ticking off each\n\nengine as it is seen. Trainspotters exchange\n\ninformation, these days often by mobile\n\nphone, so they can work out where to go\n\nto, to see a particular engine. As a by-\n\nproduct, many practitioners of the hobby\n\nbecome very knowledgeable about railway operations, or the technical specifications\n\nof different engine types.\n\nSimilarly, people who collect dolls may go\n\nbeyond simply enlarging their collection,\n\nand develop an interest in the way that\n\ndolls are made, or the materials that\n\nare used. These have changed over the\n\ncenturies from the wood that was standard\n\nin 16th century Europe, through the wax\n\nand porcelain of later centuries, to the\n\nplastics of today's dolls. Or collectors\n\nmight be inspired to study how dolls\n\nreflect notions of what children like, or\n\nought to like.\n\nNot all collectors are interested in learning\n\nfrom their hobby, though, so what we\n\nmight call a psychological reason for\n\ncollecting is the need for a sense of\n\ncontrol, perhaps as a way of dealing with\n\ninsecurity. Stamp collectors, for instance,\n\narrange their stamps in albums, usually very\n\nneatly; organising their collection according\n\nto certain commonplace principles perhaps by country in alphabetical order,\n\nor grouping stamps by what they depict\n\npeople, birds, maps, and so on.\n\nOne reason, conscious or not, for what\n\nsomeone chooses to collect is to show\n\nthe collector's individualism. Someone\n\nwho decides to collect something as\n\nunexpected as dog collars, for instance,\n\nmay be conveying their belief that they\n\nmust be interesting themselves. And\n\nbelieve it or not, there is at least one dog\n\ncollar museum in existence, and it grew out\n\nof a personal collection.\n\nOf course, all hobbies give pleasure, but\n\nthe common factor in collecting is usually\n\npassion: pleasure is putting it far too\n\nmildly. More than most other hobbies,\n\ncollecting can be totally engrossing,\n\nand can give a strong sense of personal\n\nfulfilment. To non-collectors it may appear\n\nan eccentric, if harmless, way of spending\n\ntime, but potentially, collecting has a lot\n\ngoing for it.
39	91	What's the purpose of gaining knowledge?	subject.' That was the founder's Inotto for Cornell University, and it seems an apt\n\ncharacterization of the different university, also in the USA, where I currently teach\n\nphilosophy. A student can prepare for a career in resort managenrnt, engineering,\n\ninterior design, accounting, nutsic, law enforcement, you name it. But what would\n\nthe founders of these two institutions have thought ofa course called 'Arson for Profit'?\n\nI kid you not: we have it on the books. Any undergraduates who have Inet the academic\n\nrequirements can sign up for the course in our prograrn in 'fire science.\n\nNaturally, the course is intended for prospective arson investioators, who can learn all\n\nthe tricks of the trade for detecting whether a fire was deliberately set, discovering who\n\ndid it, and establishing a chain of evidence for effective prosecution in a court of law.\n\nBut wouldn't this also be the perfect course for prospective arsonists to sign up for? My\n\npoint is not to criticize academic progralns in fire science: they are highly welcome as\n\npart of the increasing professionalization of this and many other occupations. However,\n\nit's not unknown for a firefighter to torch a buildino. exarnple suggests how\n\ndishonest and illegal behavior, with the help of higher education, can creep into every\n\naspect of public and business life.\n\nI realized this anew when I was invited to speak before a class in marketing, which is\n\nanother of our degree programs. The regular instructor is a colleague who appreciates\n\nthe kind of ethical perspective I can bring as a philosopher. %ere are endless ways\n\nI could have approached this assignment, but I took my cue from the title of the\n\ncourse: 'Principles of Marketing'. It made me think to ask the students, (Is marketing\n\nprincipled?' After all, a subject matter can have principles in the sense of being codified,\n\nhaving rules, as with football or chess, without being principled in the sense of being\n\nethical. Many of the students immediately assumed that the answer to my question\n\nabout marketing principles was obvious: no. Just look at the ways in which everything\n\nunder the sun has been marketed; obviously it need not be done in a principled\n\n(=ethical) fashion.\n\nIs that obvious? I made the suggestion, which may sound downright crazy in light of\n\nthe evidence, that perhaps marketing is by definition principled. My inspiration for this\n\njudgement is the philosopher Immanuel Kant, who argued that any body of knowledge\n\nconsists of an end (or purpose) and a means.\n\n**Section E**\n\nF Let us apply both the terms 'means' and 'end' to marketing. Tie students have signed\n\nup for a course in order to learn how to market effectively. But to what end? There seem\n\nto be two main attitudes toward that question. One is that the answer is obvious: the\n\npurpose of marketing is to sell things and to make money. The other attitude is that the\n\npurpose of marketing is irrelevant: Each person comes to the program and course with\n\nhis or her own plans, and these need not even concern the acquisition of marketing\n\nexpertise as such. My proposal, which I believe would also be Kant's, is that neither of\n\nthese attitudes captures the significance of the end to the means for marketing. A field\n\nof knowledge or a professional endeavor is defined by both the means and the end;\n\nhence both deserve scrutiny. Students need to study both how to achieve X, and also\n\nwhat X is.\n\nIt is at this point that 'Arson for Profit' becomes supremely relevant. Tlat course is\n\npresumably all about means: how to detect and prosecute criminal activity. It is therefore\n\nassumed that the end is good in an ethical sense. When I ask fire science students to\n\narticulate the end, or purpose, of their field, they eventually generalize to something like,\n\n'The safety and welfare of society,' which seems right. As we have seen, someone could\n\nuse the very same knowledge of means to achieve a much less noble end, such as personal\n\nprofit via destructive, dangerous, reckless activity. But we would not call that firefighting.\n\nWe have a separate word for it: arson. Similarly, if you employed the 'principles of\n\nmarketing' in an unprincipled way, you would not be doing marketing. We have another\n\nterm for it: fraud. Kant gives the example ofa doctor and a poisoner, who use the\n\nidentical knowledge to achieve their divergent ends. We would say that one is practicing\n\nmedicine, the other, murder.
40	96	The Risk of Disease in Domesticated Animals	The risks agriculture faces in developing countries\n\nSynthesis of an online debate\n\nTwo things distinguish food production from all other productive activities: first,\n\nevery single person needs food each day and has a right to it; and second, it is\n\nhugely dependent on nature. These two unique aspects, one political, the other\n\nnatural, make food production highly vulnerable and different from any other\n\nbusiness. At the same time, cultural values are highly entrenched in food and\n\nagricultural systems worldwide.\n\nFarmers everywhere face major risks, including extreme weather, long-term\n\nclimate change, and price volatility in input and product markets. However,\n\nsmallholder farmers in developing countries must in addition deal with adverse\n\nenvironments, both natural, in terms of soil quality, rainfall, etc., and human, in\n\nterms of infrastructure, financial systems, markets, knowledge and technology.\n\nCounter-intuitively, hunger is prevalent among many smallholder farmers in the\n\ndeveloping world.\n\nParticipants in the online debate argued that our biggest challenge is to address the\n\nunderlying causes of the agricultural system's inability to ensure sufficient food for\n\nall, and they identified as drivers of this problem our dependency on fossil fuels and\n\nunsupportive government policies.\n\nOn the question of mitigating the risks farmers face, most essayists called for\n\ngreater state intervention. In his essay, Kanayo F. Nwanze, President of the\n\nInternational Fund for Agricultural Development, argued that governments can\n\nsignificantly reduce risks for farmers by providing basic services like roads to get\n\nproduce more efficiently to markets, or water and food storage facilities to reduce\n\nlosses. Sophia Murphy, senior advisor to the Institute for Agriculture and Trade\n\nPolicy, suggested that the procurement and holding of stocks by governments\n\ncan also help mitigate wild swings in food prices by alleviating uncertainties about\n\nmarket supply.\n\nThe personal names in the text refer to the authors of written contributions to the online debate.\n\n**Section E**\n\n**Section F**\n\nG Shenggen Fan, Director General of the International Food Policy Research\n\nInstitute, held up social safety nets and public welfare programmes in Ethiopia,\n\nBrazil and Mexico as valuable ways to address poverty among farming families\n\nand reduce their vulnerability to agriculture shocks. However, some commentators\n\nresponded that cash transfers to poor families do not necessarily translate into\n\nincreased food security, as these programmes do not always strengthen food\n\nproduction or raise incomes. Regarding state subsidies for agriculture, Rokeya\n\nKabir, Executive Director of Bangladesh Nari Progati Sangha, commented in her\n\nessay that these 'have not compensated for the stranglehold exercised by private\n\ntraders. In fact, studies show that sixty percent of beneficiaries of subsidies are not\n\npoor, but rich landowners and non-farmer traders.'\n\nNwanze, Murphy and Fan argued that private risk management tools, like private\n\ninsurance, commodity futures markets, and rural finance can help small-scale\n\nproducers mitigate risk and allow for investment in improvements. Kabir warned\n\nthat financial support schemes often encourage the adoption of high-input\n\nagricultural practices, which in the medium term may raise production costs\n\nbeyond the value of their harvests. Murphy noted that when futures markets\n\nbecome excessively financialised they can contribute to short-term price volatility,\n\nwhich increases farmers' food insecurity. Many participants and commentators\n\nemphasised that greater transparency in markets is needed to mitigate the impact\n\nof volatility, and make evident whether adequate stocks and supplies are available.\n\nOthers contended that agribusiness companies should be held responsible for\n\npaying for negative side effects.\n\nMany essayists mentioned climate change and its consequences for small-scale\n\nagriculture. Fan explained that 'in addition to reducing crop yields, climate change\n\nincreases the magnitude and the frequency of extreme weather events, which\n\nincrease smallholder vulnerability.' The growing unpredictability of weather patterns\n\nincreases farmers' difficulty in managing weather-related risks. According to this\n\nauthor, one solution would be to develop crop varieties that are more resilient\n\nto new climate trends and extreme weather patterns. Accordingly, Pat Mooney,\n\nco-founder and executive director of the ETC Group, suggested that 'if we are to\n\nsurvive climate change, we must adopt policies that let peasants diversify the plant\n\nand animal species and varieties/breeds that make up our menus.'\n\nH Some participating authors and commentators argued in favour of community-\n\nbased and autonomous risk management strategies through collective action\n\ngroups, co-operatives or producers' groups. Such groups enhance market\n\nopportunities for small-scale producers, reduce marketing costs and synchronise\n\nbuying and selling with seasonal price conditions. According to Murphy, 'collective\n\naction offers an important way for farmers to strengthen their political and economic\n\nbargaining power, and to reduce their business risks.' One commentator, Giel Ton,\n\nwarned that collective action does not come as a free good. It takes time, effort\n\nand money to organise, build trust and to experiment. Others, like Marcel Vernooij\n\nand Marcel Beukeboom, suggested that in order to 'apply what we already know',\n\nall stakeholders, including business, government, scientists and civil society, must\n\nwork together, starting at the beginning of the value chain.\n\nSome participants explained that market price volatility is often worsened by the\n\npresence of intermediary purchasers who, taking advantage of farmers' vulnerability,\n\ndictate prices. One commentator suggested farmers can gain greater control over\n\nprices and minimise price volatility by selling directly to consumers. Similarly, Sonali\n\nBisht, founder and advisor to the Institute of Himalayan Environmental Research\n\nand Education (INHERE), India, wrote that community-supported agriculture, where\n\nconsumers invest in local farmers by subscription and guarantee producers a fair\n\nprice, is a risk-sharing model worth more attention. Direct food distribution systems\n\nnot only encourage small-scale agriculture but also give consumers more control\n\nover the food they consume, she wrote.
41	97	The Lost City of Machu Picchu	exploration of the remote hinterland to the west of Cusco, the old capital of the Inca\n\nempire in the Andes mountains of Peru. His goal was to locate the remains of a city\n\ncalled Vitcos, the last capital of the Inca civilisation. Cusco lies on a high plateau\n\nat an elevation of more than 3,000 metres, and Bingham's plan was to descend\n\nfrom this plateau along the valley of the Urubamba river, which takes a circuitous\n\nroute down to the Amazon and passes through an area of dramatic canyons and\n\nmountain ranges.\n\nWhen Bingham and his team set off down the Urubamba in late July, they had\n\nan advantage over travellers who had preceded them: a track had recently been\n\nblasted down the valley canyon to enable rubber to be brought up by mules from\n\nthe jungle. Almost all previous travellers had left the river at Ollantaytambo and\n\ntaken a high pass across the mountains to rejoin the river lower down, thereby\n\ncutting a substantial corner, but also therefore never passing through the area\n\naround Machu Picchu.\n\nOn 24 July they were a few days into their descent of the valley. The day began\n\nslowly, with Bingham trying to arrange sufficient mules for the next stage of the\n\ntrek. His companions showed no interest in accompanying him up the nearby hill\n\nto see some ruins that a local farmer, Melchor Arteaga, had told them about the\n\nnight before. The morning was dull and damp, and Bingham also seems to have\n\nbeen less than keen on the prospect of climbing the hill. In his book Lost City of the\n\nIncas, he relates that he made the ascent without having the least expectation that\n\nhe would find anything at the top.\n\nBingham writes about the approach in vivid style in his book. First, as he climbs\n\nup the hill, he describes the ever-present possibility of deadly snakes, 'capable of\n\nmaking considerable springs when in pursuit of their prey'; not that he sees any.\n\nThen there's a sense of mounting discovery as he comes across great sweeps\n\nof terraces, then a mausoleum, followed by monumental staircases and, finally,\n\nthe grand ceremonial buildings of Machu Picchu, 'It seemed like an unbelievable\n\ndream the sight held me spellbound he wrote.\n\n**Section E**\n\n**Section F**\n\nG We should remember, however, that Lost City of the Incas is a work of hindsight,\n\nnot written until 1948, many years after his journey. His journal entries of the\n\ntime reveal a much more gradual appreciation of his achievement. He spent\n\nthe afternoon at the ruins noting down the dimensions of some of the buildings,\n\nthen descended and rejoined his companions, to whom he seems to have said\n\nlittle about his discovery. At this stage, Bingham didn't realise the extent or the\n\nimportance of the site, nor did he realise what use he could make of the discovery.\n\nHowever, soon after returning it occurred to him that he could make a name for\n\nhimself from this discovery. When he came to write the National Geographic\n\nmagazine article that broke the story to the world in April 191 3, he knew he had\n\nto produce a big idea. He wondered whether it could have been the birthplace of\n\nthe very first Inca, Manco the Great, and whether it could also have been what\n\nchroniclers described as 'the last city of the Incas'. This term refers to Vilcabamba,\n\nthe settlement where the Incas had fled from Spanish invaders in the 1530s.\n\nBingham made desperate attempts to prove this belief for nearly 40 years. Sadly,\n\nhis vision of the site as both the beginning and end of the Inca civilisation, while\n\na magnificent one, is inaccurate. We now know that Vilcabamba actually lies 65\n\nkilometres away in the depths of the jungle.\n\nOne question that has perplexed visitors, historians and archaeologists alike ever\n\nsince Bingham, is why the site seems to have been abandoned before the Spanish\n\nConquest. There are no references to it by any of the Spanish chroniclers - and if\n\nthey had known of its existence so close to Cusco they would certainly have come\n\nin search of gold. An idea which has gained wide acceptance over the past few\n\nyears is that Machu Picchu was a moya, a country estate built by an Inca emperor\n\nto escape the cold winters of Cusco, where the elite could enjoy monumental\n\narchitecture and spectacular views. Furthermore, the particular architecture of\n\nMachu Picchu suggests that it was constructed at the time of the greatest of all the\n\nIncas, the emperor Pachacuti (c. 1438-71 By custom, Pachacuti's descendants\n\nbuilt other similar estates for their own use, and so Machu Picchu would have been\n\nabandoned after his death, some 50 years before the Spanish Conquest.
42	98	The bilingual advantage	The Benefits of Being Bilingual\n\nAccording to the latest figures, the majority of the world's population is now bilingual\n\nor multilingual, having grown up speaking two or more languages. In the past, such\n\nchildren were considered to be at a disadvantage compared with their monolingual\n\npeers. Over the past few decades, however, technological advances have allowed\n\nresearchers to look more deeply at how bilingualism interacts with and changes\n\nthe cognitive and neurological systems, thereby identifying several clear benefits of\n\nbeing bilingual.\n\nResearch shows that when a bilingual person uses one language, the other is\n\nactive at the same time. When we hear a word, we don't hear the entire word all at\n\nonce: the sounds arrive in sequential order. Long before the word is finished, the\n\nbrain's language system begins to guess what that word might be. If you hear 'can',\n\nyou will likely activate words like 'candy' and 'candle' as well, at least during the\n\nearlier stages of word recognition. For bilingual people, this activation is not limited\n\nto a single language; auditory input activates corresponding words regardless\n\nof the language to which they belong. Some of the most compelling evidence\n\nfor this phenomenon, called 'language co-activation', comes from studying eye\n\nmovements. A Russian-English bilingual asked to 'pick up a marker' from a set of\n\nobjects would look more at a stamp than someone who doesn't know Russian,\n\nbecause the Russian word for 'stamp', marka, sounds like the English word he or\n\nshe heard, 'marker'. In cases like this, language co-activation occurs because what\n\nthe listener hears could map onto words in either language.\n\nHaving to deal with this persistent linguistic competition can result in difficulties,\n\nhowever. For instance, knowing more than one language can cause speakers to\n\nname pictures more slowly, and can increase 'tip-of-the-tongue states', when you\n\ncan almost, but not quite, bring a word to mind. As a result, the constant juggling of\n\ntwo languages creates a need to control how much a person accesses a language\n\nat any given time. For this reason, bilingual people often perform better on tasks\n\nthat require conflict management. In the classic Stroop Task, people see a word\n\nand are asked to name the colour of the word's font. When the colour and the\n\nword match (i.e., the word 'red' printed in red), people correctly name the colour\n\nmore quickly than when the colour and the word don't match (i.e., the word 'red'\n\nprinted in blue). This occurs because the word itself ('red') and its font colour (blue)\n\nconflict. Bilingual people often excel at tasks such as this, which tap into the ability\n\nto ignore competing perceptual information and focus on the relevant aspects of\n\nthe input. Bilinguals are also better at switching between two tasks; for example,\n\nwhen bilinguals have to switch from categorizing objects by colour (red or green)\n\n**Section D**\n\n**Section E**\n\n**Section F**\n\nG to categorizing them by shape (circle or triangle), they do so more quickly than\n\nmonolingual people, reflecting better cognitive control when having to make rapid\n\nchanges of strategy.\n\nIt also seems that the neurological roots of the bilingual advantage extend to brain\n\nareas more traditionally associated with sensory processing. When monolingual\n\nand bilingual adolescents listen to simple speech sounds without any intervening\n\nbackground noise, they show highly similar brain stem responses. When\n\nresearchers play the same sound to both groups in the presence of background\n\nnoise, however, the bilingual listeners' neural response is considerably larger,\n\nreflecting better encoding of the sound's fundamental frequency, a feature of sound\n\ncl osely related to pitch perception.\n\nSuch improvements in cognitive and sensory processing may help a bilingual\n\nperson to process information in the environment, and help explain why bilingual\n\nadults acquire a third language better than monolingual adults master a second\n\nla nguage. This advantage may be rooted in the skill of focussing on information\n\nabout the new language while reducing interference from the languages they\n\nal ready know.\n\nResearch also indicates that bilingual experience may help to keep the cognitive\n\nmechanisms sharp by recruiting alternate brain networks to compensate for those\n\nthat become damaged during aging. Older bilinguals enjoy improved memory\n\nrelative to monolingual people, which can lead to real-world health benefits. In a\n\nstudy of over 200 patients with Alzheimer's disease, a degenerative brain disease,\n\nbilingual patients reported showing initial symptoms of the disease an average\n\nof five years later than monolingual patients. In a follow-up study, researchers\n\ncompared the brains of bilingual and monolingual patients matched on the severity\n\nof Alzheimer's symptoms. Surprisingly, the bilinguals' brains had more physical\n\nsigns of disease than their monolingual counterparts, even though their outward\n\nbehaviour and abilities were the same. If the brain is an engine, bilingualism may\n\nhelp it to go farther on the same amount of fuel.\n\nFurthermore, the benefits associated with bilingual experience seem to start\n\nvery early. In one study, researchers taught seven-month-old babies growing\n\nup in monolingual or bilingual homes that when they heard a tinkling sound, a\n\npuppet appeared on one side of a screen. Halfway through the study, the puppet\n\nbegan appearing on the opposite side of the screen. In order to get a reward, the\n\ninfants had to adjust the rule they'd learned; only the bilingual babies were able to\n\nsuccessfully learn the new rule. This suggests that for very young children, as well\n\nas for older people, navigating a multilingual environment imparts advantages that\n\ntransfer far beyond language.
43	103	Flying tortoises	vegetation at the skirt of the often cloud-covered peak of Sierra Negra offers respite\n\nfrom the barren terrain below. This inhospitable environment is home to the giant\n\nGalåpagos tortoise. Some time after the Galåpagos's birth, around five million\n\nyears ago, the islands were colonised by one or more tortoises from mainland\n\nSouth America. As these ancestral tortoises settled on the individual islands, the\n\ndifferent populations adapted to their unique environments, giving rise to at least\n\n14 different subspecies. Island life agreed with them. In the absence of significant\n\npredators, they grew to become the largest and longest-living tortoises on the\n\nplanet, weighing more than 400 kilograms, occasionally exceeding 1.8 metres in\n\nlength and living for more than a century.\n\nBefore human arrival, the archipelago's tortoises numbered in the hundreds\n\nof thousands. From the 17th century onwards, pirates took a few on board for\n\nfood, but the arrival of whaling ships in the 1790s saw this exploitation grow\n\nexponentially. Relatively immobile and capable of surviving for months without food\n\nor water, the tortoises were taken on board these ships to act as food supplies\n\nduring long ocean passages. Sometimes, their bodies were processed into high-\n\ngrade oil. In total, an estimated 200,000 animals were taken from the archipelago\n\nbefore the 20th century. This historical exploitation was then exacerbated when\n\nsettlers came to the islands. They hunted the tortoises and destroyed their habitat\n\nto clear land for agriculture. They also introduced alien species - ranging from\n\ncattle, pigs, goats, rats and dogs to plants and ants - that either prey on the eggs\n\nand young tortoises or damage or destroy their habitat\n\nToday, only 11 of the original subspecies survive and of these, several are highly\n\nendangered. In 1989, work began on a tortoise-breeding centre just outside the\n\ntown of Puerto Villamil on Isabela, dedicated to protecting the island's tortoise\n\npopulations. The centre's captive-breeding programme proved to be extremely\n\nsuccessful, and it eventually had to deal with an overpopulation problem.\n\nThe problem was also a pressing one. Captive-bred tortoises can't be reintroduced\n\ninto the wild until they're at least five years old and weigh at least 4.5 kilograms,\n\nat which point their size and weight - and their hardened shells are sufficient\n\nto protect them from predators. But if people wait too long after that point, the\n\ntortoises eventually become too large to transport.\n\n**Section E**\n\n**Section F**\n\nG For years, repatriation efforts were carried out in small numbers, with the tortoises\n\ncarried on the backs of men over weeks of long, treacherous hikes along narrow\n\ntrails. But in November 2010, the environmentalist and Galåpagos National Park\n\nliaison officer Godfrey Merlin, a visiting private motor yacht captain and a helicopter\n\npilot gathered around a table in a small café in Puerto Ayora on the island of Santa\n\nCruz to work out more ambitious reintroduction. The aim was to use a helicopter\n\nto move 300 of the breeding centre's tortoises to various locations close to Sierra\n\nNegra.\n\nThis unprecedented effort was made possible by the owners of the 67-metre\n\nyacht White Cloud, who provided the Galåpagos National Park with free use of\n\ntheir helicopter and its experienced pilot, as well as the logistical support of the\n\nyacht, its captain and crew. Originally an air ambulance, the yacht's helicopter\n\nhas a rear double door and a large internal space that's well suited for cargo,\n\nso a custom crate was designed to hold up to 33 tortoises with a total weight of\n\nabout 150 kilograms. This weight, together with that of the fuel, pilot and four crew,\n\napproached the helicopter's maximum payload, and there were times when it was\n\nclearly right on the edge of the helicopter's capabilities. During a period of three\n\ndays, a group of volunteers from the breeding centre worked around the clock to\n\nprepare the young tortoises for transport. Meanwhile, park wardens, dropped off\n\nahead of time in remote locations, cleared landing sites within the thick brush, cacti\n\nand lava rocks.\n\nUpon their release, the juvenile tortoises quickly spread out over their ancestral\n\nterritory, investigating their new surroundings and feeding on the vegetation.\n\nEventually, one tiny tortoise came across a fully grown giant who had been\n\nlumbering around the island for around a hundred years. The two stood side by\n\nside, a powerful symbol of the regeneration of an ancient species.
44	104	The Intersection of Health Sciences and Geography	D The Intersection of Health Sciences and Geography\n\nWhile many diseases that affect humans have been eradicated due to\n\nimprovements in vaccinations and the availability of healthcare, there are still areas\n\naround the world where certain health issues are more prevalent. In a world that is\n\nfar more globalised than ever before, people come into contact with one another\n\nthrough travel and living closer and closer to each other. As a result, super-viruses\n\nand other infections resistant to antibiotics are becoming more and more common.\n\nGeography can often play a very large role in the health concerns of certain\n\npopulations. For instance, depending on where you live, you will not have the same\n\nhealth concerns as someone who lives in a different geographical region. Perhaps\n\none of the most obvious examples of this idea is malariæprone areas, which are\n\nusually tropical regions that foster a warm and damp environment in which the\n\nmosquitos that can give people this disease can grow. Malaria is much less of a\n\nproblem in high-altitude deserts, for instance.\n\nIn some countries, geographical factors influence the health and well-being of\n\nthe population in very obvious ways. In many large cities, the wind is not strong\n\nenough to clear the air of the massive amounts of smog and pollution that cause\n\nasthma, lung problems, eyesight issues and more in the people who live there. Part\n\nof the problem is, of course, the massiVe number of cars being driven, in addition\n\nto factories that run on coal power. The rapid industrialisation of some countries in\n\nrecent years has also led to the cutting down of forests to allow for the expansion of\n\nbig cities, which makes it even harder to fight the pollution with the fresh air that is\n\nproduced by plants.\n\nIt is in situations like these that the field of health geography comes into its own. It\n\nis an increasingly important area of study in a world where diseases like polio are\n\nre-emerging, respiratory diseases continue to spread, and malaria-prone areas\n\nare still fighting to find a better cure. Health geography is the combination of, on\n\nthe one hand, knowledge regarding geography and methods used to analyse and\n\ninterpret geographical information, and on the other, the study of health, diseases\n\nand healthcare practices around the world The aim of this hybrid science is to\n\ncreate solutions for common geography-based health problems. While people will\n\nalways be prone to illness, the study of how geography affects our health could\n\nlead to the eradication of certain illnesses, and the prevention of others in the\n\nfuture. By understanding why and how we get sick, we can change the way we\n\ntreat illness and disease specific to certain geographical locations.\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH The geography of disease and ill health analyses the frequency with which certain\n\ndiseases appear in different parts of the world, and overlays the data with the\n\ngeography of the region, to see if there could be a correlation between the two.\n\nHealth geographers also study factors that could make certain individuals or a\n\npopulation more likely to be taken ill with a specific health concern or disease, as\n\ncompared with the population of another area. Health geographers in this field\n\nare usually trained as healthcare workers, and have an understanding of basic\n\nepidemiology as it relates to the spread of diseases among the population.\n\nResearchers study the interactions between humans and their environment that\n\ncould lead to illness (such as asthma in places with high levels of pollution) and\n\nwork to create a clear way of categorising illnesses, diseases and epidemics into\n\nlocal and global scales. Health geographers can map the spread of illnesses and\n\nattempt to identify the reasons behind an increase or decrease in illnesses, as\n\nthey work to find a way to halt the further spread or re-emergence of diseases in\n\nvulnerable populations.\n\nThe second subcategory of health geography is the geography of healthcare\n\nprovision. This group studies the availability (or lack thereof) of healthcare\n\nresources to individuals and populations around the world. In both developed and\n\ndeveloping nations there is often a very large discrepancy between the options\n\navailable to people in different social classes, income brackets, and levels of\n\neducation. Individuals working in the area of the geography of healthcare provision\n\nattempt to assess the levels of healthcare in the area (for instance, it may be very\n\ndifficult for people to get medical attention because there is a mountain between\n\ntheir village and the nearest hospital). These researchers are on the frontline of\n\nmaking recommendations regarding policy to international organisations, local\n\ngovernment bodies and others.\n\nThe field of health geography is often overlooked, but it constitutes a huge area\n\nof need in the fields of geography and healthcare. If we can understand how\n\ngeography affects our health no matter where in the world we are located, we can\n\nbetter treat disease, prevent illness, and keep people safe and well.
45	105	Music and the emotions	Music and the emotions\n\nNeuroscientist Jonah Lehrer considers the emotional power of music\n\nWhy does music make us feel? On the one hand, music is a purely abstract art form,\n\ndevoid of language or explicit ideas. And yet, even though music says little, it still\n\nmanages to touch us deeply. When listening to our favourite songs, our body betrays all\n\nthe symptoms of emotional arousal. The pupils in our eyes dilate, our pulse and blood\n\npressure rise, the electrical conductance of our skin is lowered, and the cerebellum, a\n\nbrain region associated with bodily movement, becomes strangely active. Blood is even\n\nre-directed to the muscles in our legs. In other words, sound stirs us at our biological\n\nroots.\n\nA recent paper in Nature Neuroscience by a research team in Montreal, Canada, marks\n\nan important step in revealing the precise underpinnings of the potent pleasurable\n\nstimulus' that is music. Although the study involves plenty of fancy technology, including\n\nfunctional magnetic resonance imaging (fMRI) and ligand-based positron emission\n\ntomography (PET) scanning, the experiment itself was rather straightforward. After\n\nscreening 217 individuals who responded to advertisements requesting people who\n\nexperience 'chills' to instrumental music, the scientists narrowed down the subject pool\n\nto ten. They then asked the subjects to bring in their playlist of favourite songs - virtually\n\nevery genre was represented, from techno to tango - and played them the music while\n\ntheir brain activity was monitored. Because the scientists were combining methodologies\n\n(PET and fMRI), they were able to obtain an impressively exact and detailed portrait of\n\nmusic in the brain. The first thing they discovered is that music triggers the production\n\nof dopamine - a chemical with a key role in setting people's moods by the neurons\n\n(nerve cells) in both the dorsal and ventral regions of the brain. As these two regions\n\nhave long been linked with the experience of pleasure, this finding isn't particularly\n\nsurprising.\n\nWhat is rather more significant is the finding that the dopamine neurons in the\n\ncaudate - a region of the brain involved in learning stimulus-response associations,\n\nand in anticipating food and other 'reward' stimuli were at their most active around\n\n15 seconds before the participants' favourite moments in the music. The researchers\n\ncall this the 'anticipatory phase' and argue that the purpose of this activity is to help\n\nus predict the arrival of our favourite part. The question, of course, is what all these\n\ndopamine neurons are up to. Why are they so active in the period preceding the\n\nacoustic climax? After all, we typically associate surges of dopamine with pleasure, with\n\nthe processing of actual rewards. And yet, this cluster of cells is most active when the\n\n'chills' have yet to arrive, when the melodic pattern is still unresolved.\n\nOne way to answer the question is to look at the music and not the neurons. While\n\nmusic can often seem (at least to the outsider) like a labyrinth of intricate patterns, it\n\nturns out that the most important part of every song or symphony is when the patterns\n\nbreak down, when the sound becomes unpredictable. If the music is too obvious, it is\n\nannoyingly boring, like an alarm clock. Numerous studies, after all, have demonstrated\n\nthat dopamine neurons quickly adapt to predictable rewards. If we know what's going\n\nto happen next, then we don't get excited. This is why composers often introduce a\n\nkey note in the beginning of a song, spend most of the rest of the piece in the studious\n\navoidance of the pattern, and then finally repeat it only at the end. The longer we are\n\ndenied the pattern we expect, the greater the emotional release when the pattern\n\nreturns, safe and sound.\n\nTo demonstrate this psychological principle, the musicologist Leonard Meyer, in his\n\nclassic book Emotion and Meaning in Music (1956), analysed the 5th movement of\n\nBeethoven's String Quartet in C-sharp minor, Op. 131. Meyer wanted to show how\n\nmusic is defined by its flirtation with - but not submission to - our expectations of order.\n\nMeyer dissected 50 measures (bars) of the masterpiece, showing how Beethoven\n\nbegins with the clear statement of a rhythmic and harmonic pattern and then, in an\n\ningenious tonal dance, carefully holds off repeating it. What Beethoven does instead is\n\nsuggest variations of the pattern. He wants to preserve an element of uncertainty in his\n\nmusic, making our brains beg for the one chord he refuses to give us. Beethoven saves\n\nthat chord for the end.\n\nAccording to Meyer, it is the suspenseful tension of music, arising out of our unfulfilled\n\nexpectations, that is the source of the music's feeling. While earlier theories of music\n\nfocused on the way a sound can refer to the real world of images and experiences - its\n\n'connotative' meaning - Meyer argued that the emotions we find in music come from the\n\nunfolding events of the music itself. This 'embodied meaning' arises from the patterns\n\nthe symphony invokes and then ignores. It is this uncertainty that triggers the surge\n\nof dopamine in the caudate, as we struggle to figure out what will happen next. We\n\ncan predict some of the notes, but we can't predict them all, and that is what keeps us\n\nlistening, waiting expectantly for our reward, for the pattern to be completed.
46	110	The History of Glass	From our earliest origins, nyan has been\n\nmaking use of glass. Historians have\n\ndiscovered that a type of natural glass\n\nobsidian formed in places such as\n\nthe mouth of a volcano as a result of\n\nthe intense heat of an eruption melting\n\nsand - was first used as tips for spears.\n\nArchaeologists have even found evidence\n\nof man-made glass which dates back to\n\n4000 BC; this took the form of glazes used\n\nfor coating stone beads. It was not until\n\n1500 BC, however, that the first hollow\n\nglass container was made by covering a\n\nsand core with a layer of molten glass.\n\nGlass blowing became the most common\n\nway to make glass containers from the\n\nfirst century BC. The glass made during\n\nthis time was highly coloured due to the\n\nimpurities of the raw material. In the\n\nfirst century AD, methods of creating\n\ncolourless glass were developed, which\n\nwas then tinted by the addition of\n\ncolouring materials. The secret of glass\n\nmaking was taken across Europe by the\n\nRomans during this century. However,\n\nthey guarded the skills and technology\n\nrequired to make glass very closely, and\n\nit was not until their empire collapsed\n\nin 476 AD that glass-making knowledge\n\nbecame widespread throughout Europe\n\nand the Middle East. From the 10th\n\ncentury onwards, the Venetians gained a\n\nreputation for technical skill and artistic ability in the nval<ing of glass bottles, and\n\nmany of the city's craftsmen left Italy to\n\nset up glassworks throughout Europe.\n\nA major milestone in the history of glass\n\noccurred with the invention of lead crystal\n\nglass by the English glass manufacturer\n\nGeorge Ravenscroft (1632-1683). He\n\nattempted to counter the effect of\n\nclouding that sometimes occurred in\n\nblown glass by introducing lead to the raw\n\nmaterials used in the process. The new\n\nglass he created was softer and easier\n\nto decorate, and had a higher refractive\n\nindex, adding to its brilliance and beauty,\n\nand it proved invaluable to the optical\n\nindustry. It is thanks to Ravenscroft's\n\ninvention that optical lenses, astronomical\n\ntelescopes, microscopes and the like\n\nbecame possible.\n\nIn Britain, the modern glass industry only\n\nreally started to develop after the repeal\n\nof the Excise Act in 1845. Before that\n\ntime, heavy taxes had been placed on the\n\namount of glass melted in a glasshouse,\n\nand were levied continuously from\n\n1745 to 1845. Joseph Paxton's Crystal\n\nPalace at London's Great Exhibition of\n\n1851 marked the beginning of glass as a\n\nmaterial used in the building industry. This\n\nrevolutionary new building encouraged\n\nthe use of glass in public, domestic\n\nand horticultural architecture. Glass manufacturing techniques also improved\n\nwith the advancement of science and the\n\ndevelopment of better technology.\n\nFrom 1887 onwards, glass making\n\ndeveloped from traditional mouth-blowing\n\nto a semi-automatic process, after factory-\n\nowner HM Ashley introduced a machine\n\ncapable of producing 200 bottles per hour\n\nin Castleford, Yorkshire, England - more\n\nthan three times quicker than any previous\n\nproduction method. Then in 1907, the first\n\nfully automated machine was developed\n\nin the USA by Michael Owens - founder\n\nof the Owens Bottle Machine Company\n\n(later the major manufacturers Owens-\n\nIllinois) - and installed in its factory.\n\nOwens' invention could produce an\n\nimpressive 2,500 bottles per hour. Other\n\ndevelopments followed rapidly, but it\n\nwas not until the First World War, when\n\nBritain became cut off from essential glass\n\nsuppliers, that glass became part of the\n\nscientific sector. Previous to this, glass\n\nhad been seen as a craft rather than a\n\nprecise science.\n\nToday, glass making is big business. It\n\nhas become a modern, hi-tech industry operating in a fiercely competitive global\n\nmarket where quality, design and service\n\nlevels are critical to maintaining market\n\nshare. Modern glass plants are capable\n\nof making millions of glass containers a\n\nday in many different colours, with green,\n\nbrown and clear remaining the most\n\npopular. Few of us can imagine modern\n\nlife without glass. It features in almost\n\nevery aspect of our lives - in our homes,\n\nour cars and whenever we sit down to eat\n\nor drink. Glass packaging is used for many\n\nproducts, many beverages are sold in\n\nglass, as are numerous foodstuffs, as well\n\nas medicines and cosmetics.\n\nGlass is an ideal material for recycling,\n\nand with growing consumer concern\n\nfor green issues, glass bottles and\n\njars are becoming ever more popular.\n\nGlass recycling is good news for\n\nthe environment. It saves used glass\n\ncontainers being sent to landfill. As less\n\nenergy is needed to melt recycled glass\n\nthan to melt down raw materials, this also\n\nsaves fuel and production costs. Recycling\n\nalso reduces the need for raw materials\n\nto be quarried, thus saving precious\n\nresources.
47	111	Bring back the big cats	It's time to start returning vanished native anima/s to Britain, says John Vesty\n\nThere is a poem, written around 598 AD,\n\nwhich describes hunting a mystery animal\n\ncalled a //ewyn. But what was it? Nothing\n\nseemed to fit, until 2006, when an animal\n\nbone, dating from around the same\n\nperiod, was found in the Kinsey Cave in\n\nnorthern England. Until this discovery, the\n\nlynx - a large spotted cat with tasselled\n\nears - was presumed to have died out in\n\nBritain at least 61000 years ago, before\n\nthe inhabitants of these islands took up\n\nfarming. But the 2006 find, together with\n\nthree others in Yorkshire and Scotland, is\n\ncompelling evidence that the lynx and the\n\nmysterious //ewyn were in fact one and the\n\nsame animal. If this is so, it would bring\n\nforward the tassel-eared cat's estimated\n\nextinction date by roughly 5,000 years.\n\nHowever, this is not quite the last glimpse\n\nof the animal in British culture. A 9th-\n\ncentury stone cross from the Isle of Eigg\n\nshows, alongside the deer, boar and\n\naurochs pursued by a mounted hunter, a\n\nspeckled cat with tasselled ears. Were it not\n\nfor the animal's backside having worn away\n\nwith time, we could have been certain, as\n\nthe lynx's stubby tail is unmistakable. But\n\neven without this key feature, it's hard to\n\nsee what else the creature could have been.\n\nThe lynx is now becoming the totemic\n\nanimal of a movement that is transforming\n\nBritish environmentalism: rewilding.\n\nRewilding means the mass restoration of\n\ndamaged ecosystems. It involves letting trees return to places that have been\n\ndenuded, allowing parts of the seabed\n\nto recover from trawling and dredging,\n\npermitting rivers to flow freely again.\n\nAbove all, it means bringing back missing\n\nspecies. One of the most striking findings\n\nof modern ecology is that ecosystems\n\nwithout large predators behave in\n\ncompletely different ways from those that\n\nretain them. Some of them drive dynamic\n\nprocesses that resonate through the whole\n\nfood chain, creating niches for hundreds\n\nof species that might otherwise struggle to\n\nsurvive. The killers turn out to be bringers\n\nof life.\n\nSuch findings present a big challenge\n\nto British conservation, which has often\n\nselected arbitrary assemblages of plants\n\nand animals and sought, at great effort and\n\nexpense, to prevent them from changing.\n\nIt has tried to preserve the living world as\n\nif it were a jar of pickles, letting nothing\n\nin and nothing out, keeping nature in\n\na state of arrested development. But\n\necosystems are not merely collections of\n\nspecies; they are also the dynamic and\n\never-shifting relationships between them.\n\nAnd this dynamism often depends on large\n\npredators.\n\nAt sea the potential is even greater: by\n\nprotecting large areas from commercial\n\nfishing, we could once more see what\n\n18th-century literature describes: vast\n\nshoals of fish being chased by fin and sperm whales, within sight of the English\n\nshore. This policy would also greatly boost\n\ncatches in the surrounding seas; the fishing\n\nindustry's insistence on scouring every inch\n\nof seabed, leaving no breeding reserves,\n\ncould not be more damaging to its own\n\ninterests.\n\nRewilding is a rare example of an\n\nenvironmental movement in which\n\ncampaigners articulate what they are for\n\nrather than only what they are against,\n\nOne of the reasons why the enthusiasm for\n\nrewilding is spreading so quickly in Britain\n\nis that it helps to create a more inspiring\n\nvision than the green movement's usual\n\npromise of 'Follow us and the world will be\n\nslightly less awful than it would otherwise\n\nhave been.'\n\nThe lynx presents no threat to human\n\nbeings: there is no known instance of one\n\npreying on people. It is a specialist predator\n\nof roe deer, a species that has exploded in\n\nBritain in recent decades, holding back, by\n\nintensive browsing, attempts to re-establish\n\nforests. It will also winkle out sika deer:\n\nan exotic species that is almost impossible\n\nfor human beings to control, as it hides in\n\nimpenetrable plantations of young trees.\n\nThe attempt to reintroduce this predator\n\nmarries well with the aim of bringing\n\nforests back to parts of our bare and barren\n\nuplands. The lynx requires deep cover, and\n\nas such presents little risk to sheep and\n\nother livestock, which are supposed, as a\n\ncondition of farm subsidies, to be kept out\n\nof the woods. On a recent trip to the Cairngorm\n\nMountains, I heard several conservationists\n\nsuggest that the lynx could be reintroduced\n\nthere within 20 years. If trees return to\n\nthe bare hills elsewhere in Britain, the big\n\ncats could soon follow. There is nothing\n\nextraordinary about these proposals,\n\nseen from the perspective of anywhere\n\nelse in Europe. The lynx has now been\n\nreintroduced to the Jura Mountains, the\n\nAlps, the Vosges in eastern France and\n\nthe Harz mountains in Germany, and has\n\nre-established itself in many more places.\n\nThe European population has tripled since\n\n1970 to roughly 10,000. As with wolves,\n\nbears, beavers, boar, bison, moose and\n\nmany other species, the lynx has been able\n\nto spread as farming has left the hills and\n\npeople discover that it is more lucrative to\n\nprotect charismatic wildlife than to hunt it,\n\nas tourists will pay for the chance to see it.\n\nLarge-scale rewilding is happening almost\n\neverywhere except Britain.\n\nHere, attitudes are just beginning to\n\nchange. Conservationists are starting to\n\naccept that the old preservation-jar model\n\nis failing, even on its own terms. Already,\n\nprojects such as Trees for Life in the\n\nHighlands provide a hint of what might be\n\ncoming. An organisation is being set up\n\nthat will seek to catalyse the rewilding of\n\nland and sea across Britain, its aim being to\n\nreintroduce that rarest of species to British\n\necosystems: hope.
48	112	UK companies need more effective boards of directors	**Section C**\n\nD UK companies need more effective boards of directors\n\nAfter a number of serious failures of governance (that is, how they are managed\n\nat the highest level), companies in Britain, as well as elsewhere, should consider\n\nradical changes to their directors' roles. It is clear that the role of a board director\n\ntoday is not an easy one. Following the 2008 financial meltdown, which resulted in\n\na deeper and more prolonged period of economic downturn than anyone expected,\n\nthe search for explanations in the many post-mortems of the crisis has meant\n\nblame has been spread far and wide. Governments, regulators, central banks and\n\nauditors have all been in the frame. The role of bank directors and management\n\nand their widely publicised failures have been extensively picked over and\n\nexamined in reports, inquiries and commentaries.\n\nThe knock-on effect of this scrutiny has been to make the governance of\n\ncompanies in general an issue of intense public debate and has significantly\n\nincreased the pressures on, and the responsibilities of, directors. At the simplest\n\nand most practical level, the time involved in fulfilling the demands of a board\n\ndirectorship has increased significantly, calling into question the effectiveness of\n\nthe classic model of corporate governance by part-time, independent non-executive\n\ndirectors. Where once a board schedule may have consisted of between eight and\n\nten meetings a year, in many companies the number of events requiring board\n\ninput and decisions has dramatically risen. Furthermore, the amount of reading\n\nand preparation required for each meeting is increasing. Agendas can become\n\noverloaded and this can mean the time for constructive debate must necessarily be\n\nrestricted in favour of getting through the business.\n\nOften, board business is devolved to committees in order to cope with the\n\nworkload, which may be more efficient but can mean that the board as a whole\n\nis less involved in fully addressing some of the most important issues. It is not\n\nuncommon for the audit committee meeting to last longer than the main board\n\nmeeting itself. Process may take the place of discussion and be at the expense of\n\nreal collaboration, so that boxes are ticked rather than issues tackled\n\nA radical solution, which may work for some very large companies whose\n\nbusinesses are extensive and complex, is the professional board, whose members\n\nwould work up to three or four days a week, supported by their own dedicated staff\n\nand advisers. There are obvious risks to this and it would be important to establish\n\nclear guidelines for such a board to ensure that it did not step on the toes of\n\nmanagement by becoming too engaged in the day-to-day running of the company.\n\nProblems of recruitment, remuneration and independence could also arise and this\n\nstructure would not be appropriate for all companies. However, more professional\n\nand better-informed boards would have been particularly appropriate for banks\n\nwhere the executives had access to information that part-time non-executive\n\ndirectors lacked, leaving the latter unable to comprehend or anticipate the 2008\n\ncrash.\n\n**Section E**\n\n**Section F**\n\nG One of the main criticisms of boards and their directors is that they do not focus\n\nsufficiently on longer-term matters of strategy, sustainability and governance,\n\nbut instead concentrate too much on short-term financial metrics. Regulatory\n\nrequirements and the structure of the market encourage this behaviour. The tyranny\n\nof quarterly reporting can distort board decision-making, as directors have to 'make\n\nthe numbers' every four months to meet the insatiable appetite of the market for\n\nmore data. This serves to encourage the trading methodology of a certain kind of\n\ninvestor who moves in and out of a stock without engaging in constructive dialogue\n\nwith the company about strategy or performance, and is simply seeking a short-\n\nterm financial gain. This effect has been made worse by the changing profile of\n\ninvestors due to the globalisation of capital and the increasing use of automated\n\ntrading systems. Corporate culture adapts and management teams are largely\n\nincentivised to meet financial goals.\n\nCompensation for chief executives has become a combat zone where pitched\n\nbattles between investors, management and board members are fought, often\n\nbehind closed doors but increasingly frequently in the full glare of press attention.\n\nMany would argue that this is in the interest of transparency and good governance\n\nas shareholders use their muscle in the area of pay to pressure boards to\n\nremove underperforming chief executives. Their powers to vote down executive\n\nremuneration policies increased when binding votes came into force. The chair\n\nof the remuneration committee can be an exposed and lonely role, as Alison\n\nCarnwath, chair of Barclays Bank's remuneration committee, found when she had\n\nto resign, having been roundly criticised for trying to defend the enormous bonus\n\nto be paid to the chief executive; the irony being that she was widely understood to\n\nhave spoken out against it in the privacy of the committee.\n\nThe financial crisis stimulated a debate about the role and purpose of the company\n\nand a heightened awareness of corporate ethics. Trust in the corporation has been\n\neroded and academics such as Michael Sandel, in his thoughtful and bestselling\n\nbook What Money Can't Buy, are questioning the morality of capitalism and the\n\nmarket economy. Boards of companies in all sectors will need to widen their\n\nperspective to encompass these issues and this may involve a realignment of\n\ncorporate goals. We live in challenging times.
49	117	Case Study: Tourism New Zealand Website	New Zealand is a small country of four million inhabitants, a long-haul flight from all the major tourist-generating markets of the world. Tourism currently makes up 9% of the country's gross domestic product, and is the country's largest export sector. Unlike other export sectors, which make products and then sell them overseas, tourism brings its customers to New Zealand. The product is the country itself - the people, the places and the experiences. In 1999, Tourism New Zealand launched a campaign to communicate a new brand position to the world. The campaign focused on New Zealand's scenic beauty, exhilarating outdoor activities and authentic Maori culture, and it made New Zealand one of the strongest national brands in the world.\n\nA key feature of the campaign was the website which provided potential visitors to New Zealand with a single gateway to everything the destination had to offer. The heart of the website was a database of tourism services operators, both those based in New Zealand and those based abroad which offered tourism services to the country. Any tourism-related business could be listed by filling in a simple form. This meant that even the smallest bed and breakfast address or specialist activity provider could gain a web presence with access to an audience of long-haul visitors. In addition, because participating businesses were able to update the details they gave on a regular basis, the information provided remained accurate. And to maintain and improve standards, Tourism New Zealand organised a scheme whereby organisations appearing on the website underwent an independent evaluation against a set of agreed national standards of quality. As part of this, the effect of each business on the environment was considered.\n\nTo communicate the New Zealand experience, the site also carried features relating to famous people and places. One of the most popular was an interview with former New Zealand All Blacks rugby captain Tana Umaga. Another feature that attracted a lot of attention was an interactive journey through a number of the locations chosen for blockbuster films which had made use of New Zealand's stunning scenery as a backdrop. As the site developed, additional features were added to help independent travellers devise their own customised itineraries. To make it easier to plan motoring holidays, the site catalogued the most popular driving routes in the country, highlighting different routes according to the season and indicating distances and times.\n\nLater, a Travel Planner feature was added, which allowed visitors to click and 'bookmark' ces or attractions they were interested in, and then view the results on a map. The Travel Planner offered suggested routes and public transport options between the chosen locations. There were also links to accommodation in the area. By registering with the website, users could save their Travel Plan and return to it later, or print it out t take on the visit. The website also had a 'Your Words' section where anyone could submit a blog of their New Zealand travels for possible inclusion on the website.\n\nThe Tourism New Zealand website won two Webby awards for online achievement and innovation. More importantly perhaps, the growth of tourism to New Zealand was impressive. Overall tourism expenditure increased by an average of 6.9% per year between 1999 and 2004. From Britain, visits to New Zealand grew at an average annual rate of 13% between 2002 and 2006, compared to a rate of 4% overall for British vtsits abroad.\n\nThe website was set up to allow both individuals and travel organisations to create aneraries and travel packages to suit their own needs and interests. On the website, v-tsitors can search for activities not solely by geographical location, but also by the pancular nature of the activity. This is important as research shows that activities are the key driver of visitor satisfaction, contributing 74% to visitor satisfaction, while transport and accommodation account for the remaining 26%. The more activities that visitors undertake, the more satisfied they will be. It has also been found that visitors enjoy cuttural activities most when they are interactive, such as visiting a marae (meeting ground) to learn about traditional Maori life. Many long-haul travellers enjoy such erning experiences, which provide them with stories to take home to their friends and family. In addition, it appears that visitors to New Zealand don't want to be 'one of the crowd' and find activities that involve only a few people more special and meaningful.\n\ntt could be argued that New Zealand is not a typical destination. New Zealand is a small country with a visitor economy composed mainly of small businesses. It is generally perceived as a safe English-speaking country with a reliable transport infrastructure. Because of the long-haul flight, most visitors stay for longer (average 20 days) and want to see as much of the country as possible on what is often seen as a once-in-a-lifetime vtsit. However, the underlying lessons apply anywhere - the effectiveness of a strong brand, a strategy based on unique experiences and a comprehensive and user-friendly website.
51	119	Artificial artists	Can computers really create works of att?\n\nThe Painting Fool is one of a growing number of computer programs which, so their makers claim, possess creative talents. Classical music by an artificial composer has had audiences enraptured, and even tricked them into believing a human was behind the score. Artworks painted by a robot have sold for thousands of dollars and been hung in prestigious galleries. And software has been built which creates art that could not have been imagined by the programmer.\n\nHuman beings are the only species to perform sophisticated creative acts regularly. If we can break this process down into computer code, where does that leave human creativity? 'This is a question at the very core of humanity,' says Geraint Wiggins, a computational creativity researcher at Goldsmiths, University of London. 'It scares a lot of people. They are worried that it is taking something special away from what it means to be human.'\n\nTo some extent, we are all familiar with computerised art. The question is: where does the work of the artist stop and the creativity of the computer begin? Consider one of the oldest machine artists, Aaron, a robot that has had paintings exhibited in London's Tate Modern and the San Francisco Museum of Modern Art. Aaron can pick up a paintbrush and paint on canvas on its own. Impressive perhaps, but it is still little more than a tool to realise the programmer's own creative ideas.\n\nSimon Colton, the designer of the Painting Fool, is keen to make sure his creation doesn't attract the same criticism. Unlike earlier 'artists' such as Aaron, the Painting Fool only needs minimal direction and can come up with its own concepts by going online for material. The software runs its own web searches and trawls through social media sites. It is now beginning to display a kind of imagination too, creating pictures from scratch. One of its original works is a series of fuzzy landscapes, depicting trees and sky. While some might say they have a mechanical look, Colton argues that such reactions arise from people's double standards towards software-produced and human-produced art. After all, he says, consider that the Painting Fool painted the landscapes without referring to a photo. 'If a child painted a new scene from its head, you'd say it has a certain level of imagination,' he points out. 'The same should be true of a machine. Software bugs can also lead to unexpected results. Some of the Painting Fool's paintings of a chair came out in black and white, thanks to a technical glitch. This gives the work an eerie, ghostlike quality. Human artists like the renowned Ellsworth Kelly are lauded for limiting their colour palette - so why should computers be any different? Researchers like Colton don't believe it is right to measure machine creativity directly to that of humans who 'have had millennia to develop our skills'. Others, though, are fascinated by the prospect that a computer might create something as original and subtle as our best artists. So far, only one has come close. Composer David Cope invented a program called Experiments in Musical Intelligence, or EMI. Not only did EMI create compositions in Cope's style, but also that of the most revered classical composers, including Bach, Chopin and Mozart. Audiences were moved to tears, and EMI even fooled classical music experts into thinking they were hearing genuine Bach. Not everyone was impressed however. Some, such as Wiggins, have blasted Cope's work as pseudoscience, and condemned him for his deliberately vague explanation of how the software worked. Meanwhile, Douglas Hofstadter of Indiana University said EMI created replicas which still rely completely on the original artist's creative impulses. When audiences found out the truth they were often outraged with Cope, and one music lover even tried to punch him. Amid such controversy, Cope destroyed EMI's vital databases.\n\nBut why did so many people love the music, yet recoil when they discovered how it was composed? A study by computer scientist David Moffat of Glasgow Caledonian University provides a clue. He asked both expert musicians and non-experts to assess six compositions. The participants weren't told beforehand whether the tunes were composed by humans or computers, but were asked to guess, and then rate how much they liked each one. People who thought the composer was a computer tended to dislike the piece more than those who believed it was human. This was true even among the experts, who might have been expected to be more objective in their analyses.\n\nWhere does this prejudice come from? Paul Bloom of Yale University has a suggestion: he reckons part of the pleasure we get from art stems from the creative process behind the work. This can give it an 'irresistible essence', says Bloom. Meanwhile, experiments by Justin Kruger of New York University have shown that people's enjoyment of an artwork increases if they think more time and effort was needed to create it. Similarly. Colton thinks that when people experience art, they wonder what the artist might have been thinking or what the artist is trying to tell them. It seems obvious, therefore, that with computers producing art, this speculation is cut short - there's nothing to explore. But as technology becomes increasingly complex, finding those greater depths in Computer art could become possible. This is precisely why Colton asks the Painting Fool to tap into online social networks for its inspiration: hopefully this way it will choose themes that will already be meaningful to us.
52	124	Bringing cinnamon to Europe	Cinnamon is a sweet, fragrant spice produced from the inner bark of trees of the genus Cinnamomum, which is native to the Indian sub-continent. It was known in biblical times, and is mentioned in several books of the Bible, both as an ingredient that was mixed with oils for anointing people's bodies, and also as a token indicating friendship among lovers and friends. In ancient Rome, mourners attending funerals burnt cinnamon to create a pleasant scent. Most often, however, the spice found its primary use as an additive to food and drink. In the Middle Ages, Europeans who could afford the spice used it to flavour food, particularly meat, and to impress those around them with their ability to purchase an expensive condiment from the 'exotic' East. At a banquet, a host would offer guests a plate with various spices piled upon it as a sign of the wealth at his or her disposal. Cinnamon was also reported to have health benefits, and was thought to cure various ailments, such as indigestion.\n\nToward the end of the Middle Ages, the European middle classes began to desire the lifestyle of the elite, including their consumption of spices. This led to a growth in demand for cinnamon and other spices. At that time, cinnamon was transported by Arab merchants, who closely guarded the secret of the source of the spice from potential rivals. They took it from India, where it was grown, on camels via an overland route to the Mediterranean. Their journey ended when they reached Alexandria. European traders sailed there to purchase their supply of cinnamon, then brought it back to Venice. The spice then travelled from that great trading city to markets all around Europe. Because the overland trade route allowed for only small quantities of the spice to reach Europe, and because Venice had a virtual monopoly of the trade, the Venetians could set the price of cinnamon exorbitantly high. These prices, coupled with the increasing demand, spurred the search for new routes to Asia by Europeans eager to take part in the spice trade.\n\nSeeking the high profits promised by the cinnamon market, Portuguese traders arrived on the island of Ceylon in the Indian Ocean toward the end of the 15th century. Before Europeans arrived on the island, the state had organized the cultivation of cinnamon. People belonging to the ethnic group called the Salagama would peel the bark off young shoots of the cinnamon plant in the rainy season, when the wet bark was more pliable. During the peeling process, they curled the bark into the 'stick' shape still associated with the spice today. The Salagama then gave the finished product to the king as a form of tribute. When the Portuguese arrived, they needed to increase production significantly, and so enslaved many other members of the Ceylonese native population, forcing them to work in cinnamon harvesting. In 1518, the Portuguese built a fort on Ceylon, which enabled them to protect the island, so helping them to develop a monopoly in the cinnamon trade and generate very high profits. In the late 16th century, for example, they enjoyed a tenfold profit when shipping cinnamon over a journey of eight days from Ceylon to India.\n\nWhen the Dutch arrived off the coast of southern Asia at the very beginning of the 17th century, they set their sights on displacing the Portuguese as kings of cinnamon. The Dutch allied themselves with Kandy, an inland kingdom on Ceylon. In return for payments of elephants and cinnamon, they protected the native king from the Portuguese. By 1640, the Dutch broke the 150-year Portuguese monopoly when they overran and occupied their factories. By 1658, they had permanently expelled the Portuguese from the island, thereby gaining control of the lucrative cinnamon trade.\n\nIn order to protect their hold on the market, the Dutch, like the Portuguese before them, treated the native inhabitants harshly. Because of the need to boost production and satisfy Europe's ever-increasing appetite for cinnamon, the Dutch began to alter the harvesting practices of the Ceylonese. Over time, the supply of cinnamon trees on the island became nearly exhausted, due to systematic stripping of the bark. Eventually, the Dutch began cultivating their own cinnamon trees to supplement the diminishing number of wild trees available for use.\n\nThen, in 1796, the English arrived on Ceylon, thereby displacing the Dutch from their control of the cinnamon monopoly. By the middle of the 19th century, production of cinnamon reached 1,OOO tons a year, after a lower grade quality of the spice became acceptable to European tastes. By that time, cinnamon was being grown in other parts of the Indian Ocean region and in the West Indies, Brazil, and Guyana. Not only was a monopoly of cinnamon becoming impossible, but the spice trade overall was diminishing in economic potential, and was eventually superseded by the rise of trade in coffee, tea, chocolate, and sugar.
53	125	Oxytocin: The love molecule	The positive and negative effects of the chemical known as the 'love hormone'\n\n**Section A**\n\n**Section B**\n\nC Oxytocin is a chemical, a hormone produced in the pituitary gland in the brain. It was through various studies focusing on animals that scientists first became aware of the influence of oxytocin. They discovered that it helps reinforce the bonds between prairie voles, which mate for life, and triggers the motherly behaviour that sheep show towards their newborn lambs. It is also released by women in childbirth, strengthening the attachment between mother and baby. Few chemicals have as positive a reputation as oxytocin, which is sometimes referred to as the 'love hormone'. One sniff of it can, it is claimed, make a person more trusting, empathetic, generous and cooperative. It is time, however, to revise this wholly optimistic view. A new wave of studies has shown that its effects vary greatly depending on the person and the circumstances, and it can impact on our social interactions for worse as well as for better.\n\nOxytocin's role in human behaviour first emerged in 2005. In a groundbreaking experiment, Markus Heinrichs and his colleagues at the University of Freiburg, Germany, asked volunteers to do an activity in which they could invest money with an anonymous person who was not guaranteed to be honest. The team found that participants who had sniffed oxytocin via a nasal spray beforehand invested more money than those who received a placebo instead. The study was the start of research into the effects of oxytocin on human interactions. 'For eight years, it was quite a lonesome field,' Heinrichs recalls. 'Now, everyone is interested.' These follow-up studies have shown that after a sniff of the hormone, people become more charitable, better at reading emotions on others' faces and at communicating constructively in arguments. Together, the results fuelled the view that oxytocin universally enhanced the positive aspects of our social nature.\n\nThen, after a few years, contrasting findings began to emerge. Simone Shamay- Tsoory at the University of Haifa, Israel, found that when volunteers played a competitive game, those who inhaled the hormone showed more pleasure when they beat other players, and felt more envy when others won. What's more, administering oxytocin also has sharply contrasting outcomes depending on a person's disposition. Jennifer Bartz from Mount Sinai School of Medicine, New York, found that it improves people's ability to read emotions, but only if they are not very socially adept to begin with. Her research also shows that oxytocin in fact reduces cooperation in subjects who are particularly anxious or sensitive to rejection.\n\nAnother discovery is that oxytocin's effects vary depending on who we are interacting with. Studies conducted by Carolyn DeClerck of the University of Antwerp, Belgium, revealed that people who had received a dose of oxytocin actually became less cooperative when dealing with complete strangers. Meanwhile, Carsten De Dreu at the University of Amsterdam in the Netherlands discovered that volunteers given oxytocin showed favouritism: Dutch men became quicker to associate positive words with Dutch names than with foreign ones, for example. According to De Dreu, oxytocin drives people to care for those in their social circles and defend them from outside dangers. So, it appears that oxytocin strengthens biases, rather than promoting general goodwill, as was previously thought.\n\nE There were signs of these subtleties from the start. Bartz has recently shown that in almost half of the existing research results, oxytocin influenced only certain individuals or in certain circumstances. Where once researchers took no notice of such findings, now a more nuanced understanding of oxytocin's effects is propelling investigations down new lines. To Bartz, the key to understanding what the hormone does lies in pinpointing its core function rather than in cataloguing its seemingly endless effects. There are several hypotheses which are not mutually exclusive. Oxytocin could help to reduce anxiety and fear. Or it could simply motivate people to seek out social connections. She believes that oxytocin acts as a chemical spotlight that shines on social clues - a shift in posture, a flicker of the eyes, a dip in the voice - making people more attuned to their social environment. This would explain why it makes us more likely to look others in the eye and improves our ability to identify emotions. But it could also make things worse for people who are overly sensitive or prone to interpreting social cues in the worst light.\n\nF Perhaps we should not be surprised that the oxytocin story has become more perplexing. The hormone is found in everything from octopuses to sheep, and its evolutionary roots stretch back half a billion years. 'It's a very simple and ancient molecule that has been co-opted for many different functions,' says Sue Carter at the University of Illinois, Chicago, USA. 'It affects primitive parts of the brain like the amygdala, so it's going to have many effects on just about everything.' Bartz agrees. 'Oxytocin probably does some very basic things, but once you add our higher-order thinking and social situations, these basic processes could manifest in different ways depending on individual differences and context.'
54	126	Making the most of trends	Experts from Harvard Business School give advice to managers\n\nMost managers can identity the major trends of the day. But in the course of conducting research in a number of industries and working directly with companies, we have discovered that managers often fail to recognize the less obvious but profound ways these trends are influencing consumers' aspirations, attitudes, and behaviors. This is especially true of trends that managers view as peripheral to their core markets.\n\nMany ignore trends in their innovation strategies or adopt a wait-and-see approach and let competitors take the lead. At a minimum, such responses mean missed profit opportunities. At the extreme, they can jeopardize a company by ceding to rivals the opportunity to transform the industry. The purpose of this article is twofold: to spur managers to think more expansively about how trends could engender new value propositions in their core markets, and to provide some high-level advice on how to make market research and product development personnel more adept at analyzing and exploiting trends.\n\nOne strategy. known as 'infuse and augment', is to design a product or service that retains most of the attributes and functions of existing products in the category but adds others that address the needs and desires unleashed by a major trend. A case in point is the Poppy range of handbags, which the firm Coach created in response to the economic downturn of 2008. The Coach brand had been a mbol of opulence and luxury for nearly 70 years, and the most obvious reaction to the downturn would have been to lower prices. However, that would have risked cheapening the brand's image. Instead, they initiated a consumer-research project which revealed that customers were eager to lift themselves and the country out of tough times. Using these insights, Coach launched the lower-priced Poppy handbags. which were in vibrant colors, and looked more youthful and playful than conventional Coach products. Creating the sub-brand allowed Coach to avert an across-the-board price cut. In contrast to the many companies that responded to the recession by cutting prices, Coach saw the new consumer mindset as an opportunity for innovation and renewal.\n\nA further example of this strategy was supermarket Tesco's response to consumers' growing concerns about the environment. With that in mind, Tesco. one of the world's top five retailers, introduced its Greener Living program, which demonstrates the company's commitment to protecting the environment by involving consumers in ways that produce tangible results. For example, Tesco customers can accumulate points for such activities as reusing bags, recycling cans and printer cartridges. and buying home-insulation materials. Like points earned on regular purchases, these green points can be redeemed for cash. Tesco has not abandoned its traditional retail offerings but augmented its business with these innovations, thereby infusing its value proposition with a green streak.\n\nA more radical strategy is combine and transcend'. 'Ihis entails combining aspects of the product's existing value proposition with attributes addressing changes arising from a trend, to create a novel experience - one that may land the company in an entirely new market space. At first glance, spending resources to incorporate elements of a seemingly irrelevant trend into one's core oilérings sounds like it's hardly worthwhile. But consider Nike s move to integrate the digital revolution into its reputation tor high-performance athletic footwear. In 2()06, they teamed up with technology company Apple to launch Nike+. a digital sports kit comprising a sensor that attaches to the running shoe and a receiver that connects to the useö.s iPod. By combining Nike's original value proposition for amateur athletes ith one tor digital consumers, the Nike sports kit and web interillce moved the company from a focus on athletic apparel to a new plane of engagement with its customers.\n\nA third approach. known as counteract and reailirm involves developing products or services that stress the values traditionally associated with the category in ways that allow consumers to oppose v or at least temporarily escape from - the aspects of trends they view as undesirable. A product that accomplished this is the ME2, a video game created by Canada-s ilOys. By reaffirming the toy category's association ith physical play. the ME2 counteracted some of the widely perceived negative impacts of digital gaming devices. Like other handheld games. the device fC atured a host of exciting interactive games. a füll-color LCD screen. and advanced 3D graphics. What set it apart was that it incorporated the traditional physical component of children's play: it contained a pedometer. which tracked and awarded points for physical activity (walking. running. biking. skateboarding. climbing stairs). The child could use the points to enhance various virtual skills needed iOr the video game. "lhe ME2. introduced in mid- 2008, catered to kids huge desire to play video games while countering the negatives. such as associations with lack of exercise and obesity.\n\nOnce you have gained perspective on how trend-related changes in consumer opinions and behaviors impact on your category, you can determine which of our three innovation strategies Io pursue. When your category s basic value proposition continues to be meaninglUI for consumers influenced by the trend, the infuse-and-augment strategy will allow you to reinvigorate the category. If analysis reveals an increasing disparity between y our category and consumers' new focus. your innovations need to transcend the category to integrate the o worlds. Finall.N. if aspects of the category clash with undesired outcomes of a trend. such as associations ith unhealthv lifestyles. there is an opportunity to counteract those changes by reatlirming the core values of your category.\n\nTrends - technological, economic. environmental. social. or political - that how people perceive the world around them and shape what they expect from products and serx ices present firms with unique opportunities tor growth.
55	131	The Coconut Palm	For millennia, the coconut has been central to the lives of Polynesian and Asian peoples. In the western world, on the other hand, coconuts have always been exotic and unusual, sometimes rare. The Italian merchant traveller Marco Polo apparently saw coconuts in South Asia in the late 13th century, and among the mid-14th-century travel writings of Sir John Mandeville there is mention of 'great Notes of Ynde' (great Nuts of India). Today, images of palm-fringed tropical beaches are clichés in the west to sell holidays, chocolate bars, fizzy drinks and even romance.\n\nTypically, we envisage coconuts as brown cannonballs that, when opened, provide sweet white flesh. But we see only part of the fruit and none of the plant from which they come. The coconut palm has a smooth, slender, grey trunk, up to 30 metres tall. This is an important source of timber for building houses, and is increasingly being used as a replacement for endangered hardwoods in the furniture construction industry. The trunk is surmounted by a rosette of leaves, each of which may be up to six metres long. The leaves have hard veins in their centres which, in many parts of the world, are used as brushes after the green part of the leaf has been stripped away. Immature coconut flowers are tightly clustered together among the leaves at the top of the trunk. The flower stems may be tapped for their sap to produce a drink, and the sap can also be reduced by boiling to produce a type of sugar used for cooking.\n\nCoconut palms produce as many as seventy fruits per year, weighing more than a kilogram each. The wall of the fruit has three layers: a waterproof outer layer, a fibrous middle layer and a hard, inner layer. The thick fibrous middle layer produces coconut fibre, 'coir', which has numerous uses and is particularly important in manufacturing ropes. The woody innermost layer, the shell, with its three prominent 'eyes', surrounds the seed. An important product obtained from the shell is charcoal, which is widely used in various industries as well as in the home as a cooking fuel. When broken in half, the shells are also used as bowls in many parts of Asia.\n\nInside the shell are the nutrients (endosperm) needed by the developing seed. Initially, the endosperm is a sweetish liquid, coconut water, which is enjoyed as a drink, but also provides the hormones which encourage other plants to grow more rapidly and produce higher yields. As the fruit matures, the coconut water gradually solidifies to form the brilliant white, fat-rich, edible flesh or meat. Dried coconut flesh, 'copra', is made into coconut oil and coconut milk, which are widely used in cooking in different parts of the world, as well as in cosmetics. A derivative of coconut fat, glycerine, acquired strategic importance in a quite different sphere, as Alfred Nobel introduced the world to his nitroglycerine-based invention: dynamite.\n\nTheir biology would appear to make coconuts the great maritime voyagers and coastal colonizers of the plant world. The large, energy-rich fruits are able to float in water and tolerate salt, but cannot remain viable indefinitely; studies suggest after about 110 days at sea they are no longer able to germinate. Literally cast onto desert island shores, with little more than sand to grow in and exposed to the full glare of the tropical sun, coconut seeds are able to germinate and root. The air pocket in the seed, created as the endosperm solidifies, protects the embryo. In addition, the fibrous fruit wall that helped it to float during the voyage stores moisture that can be taken up by the roots of the coconut seedling as it starts to grow.\n\nThere have been centuries of academic debate over the origins of the coconut. There were no coconut palms in West Africa, the Caribbean or the east coast of the Americas before the voyages of the European explorers Vasco da Gama and Columbus in the late 15th and early 16th centuries. 16th century trade and human migration patterns reveal that Arab traders and European sailors are likely to have moved coconuts from South and Southeast Asia to Africa and then across the Atlantic to the east coast of America. But the origin of coconuts discovered along the west coast of America by 16th century sailors has been the subject of centuries of discussion. Two diametrically opposed origins have been proposed: that they came from Asia, or that they were native t America. Both suggestions have problems. In Asia, there is a large degree of coconut diversity and evidence of millennia of human use - but there are no relatives growing in the wild. In America, there are close coconut relatives, but no evidence that coconuts are indigenous. These problems have led to the intriguing suggestion that coconuts originated on coral islands in the Pacific and were dispersed from there.
50	118	Why being bored is stimulating - and useful, too	Paragraph F S\n\n**Section C**\n\nD Why being bored is stimulating - and useful, too\n\nThis most common of emotions is turning out to be more interesting than\n\nwe thought\n\nWe all know how it feels - it's impossible to keep your mind on anything, time stretches out, and all the things you could do seem equally unlikely to make you feel better. But defining boredom so that it can be studied in the lab has proved difficult. For a start, it can include a lot of other mental states, such as frustration, apathy, depression and indifference. There isn't even agreement over whether boredom is always a low-energy, flat kind of emotion or whether feeling agitated and restless counts as boredom, too. In his book, Boredom: A Lively History, Peter Toohey at the University of Calgary, Canada, compares it to disgust - an emotion that motivates us to stay away from certain situations. 'If disgust protects humans from infection, boredom may protect them from "infectious" social situations, he suggests.\n\nBy asking people about their experiences of boredom, Thomas Goetz and his team at the University of Konstanz in Germany have recently identified five distinct types: indifferent, calibrating, searching, reactant and apathetic. These can be plotted on two axes - one running left to right, which measures low to high arousal, and the other from top to bottom, which measures how positive or negative the feeling is. Intriguingly, Goetz has found that while people experience all kinds of boredom, they tend to specialise in one. Of the five types, the most damaging is 'reactant' boredom with its explosive combination of high arousal and negative emotion. The most useful is what Goetz calls 'indifferent' boredom: someone isn't engaged in anything satisfying but still feels relaxed and calm. However, it remains to be seen whether there are any character traits that predict the kind of boredom each of us might be prone to.\n\nPsychologist Sandi Mann at the University of Central Lancashire, I-JK, goes further. 'All emotions are there for a reason, including boredom,' she says. Mann has found that being bored makes us more creative. 'We're all afraid of being bored but in actual fact it can lead to all kinds of amazing things,' she says. In experiments published last year, Mann found that people who had been made to feel bored by copying numbers out of the phone book for 15 minutes came up with more creative ideas about how to use a polystyrene cup than a control group. Mann concluded that a passive, boring activity is best for creativity because it allows the mind to wander. In fact, she goes so far as to suggest that we should seek out more boredom in our lives.\n\nPsychologist John Eastwood at York University in Toronto, Canada, isn't convinced. 'If you are in a state of mind-wandering you are not bored,' he says. 'In my view, by definition boredom is an undesirable state.' That doesn't necessarily mean that it isn't adaptive, he adds. 'Pain is adaptive - if we didn't have physical pain, bad things would happen to us. Does that mean that we should actively cause pain? No. But even if boredom has evolved to help us survive, it can still be toxic\n\n**Section E**\n\nF if allowed to fester.' For Eastwood, the central feature of boredom is a failure to put our 'attention system' into gear. This causes an inability to focus on anything, which makes time seem to go painfully slowly. What's more, your efforts to improve the situation can end up making you feel worse. 'People try to connect with the world and if they are not successful there's that frustration and irritability,' he says. Perhaps most worryingly, says Eastwood, repeatedly failing to engage attention can lead to a state where we don't know what to do any more, and no longer care.\n\nEastwood's team is now trying to explore why the attention system fails. It's early days but they think that at least some of it comes down to personality. Boredom proneness has been linked with a variety of traits. People who are motivated by pleasure seem to suffer particularly badly. Other personality traits, such as curiosity, are associated with a high boredom threshold. More evidence that boredom has detrimental effects comes from studies of people who are more or less prone to boredom. It seems those who bore easily face poorer prospects in education, their career and even life in general. But of course, boredom itself cannot kill - it's the things we do to deal with it that may put us in danger What can we do to alleviate it before it comes to that? Goetz's group has one suggestion. Working with teenagers, they found that those who 'approach' a boring situation - in other words, see that it's boring and get stuck in anyway - report less boredom than those who try to avoid it by using snacks, TV or social media for distraction.\n\nPsychologist Francoise Wemelsfelder speculates that our over-connected lifestyles might even be a new source of boredom. 'In modern human society there is a lot of overstimulation but still a lot of problems finding meaning,' she says. So instead of seeking yet more mental stimulation, perhaps we should leave our phones alone, and use boredom to motivate us to engage with the world in a more meaningful way.\n\nZuestions 20-23\n\ncok at the following people (Questions 20-23) and the list of ideas below.\n\nMatch each person with the correct idea, A-E.\n\n%-te the correct letter, A-E, in boxes 20-23 on your answer sheet.\n\nPeter Toohey\n\nThomas Goetz\n\nJohn Eastwood\n\nFrancoise Wemelsfelder\n\n**Section A**\n\n**Section B**\n\n**Section C**\n\n**Section D**\n\nE List of Ideas\n\nThe way we live today may encourage boredom.\n\nOne sort of boredom is worse than all the others.\n\nLevels of boredom may fall in the future.\n\nTrying to cope with boredom can increase its negative effects.\n\nBoredom may encourage us to avoid an unpleasant experience.
15	35	The psychology of innovation	Why are so few companies truly innovative?\n\nInnovation is key to business survival, and companies put substantial resources into inspiring employees to develop new ideas. There are, nevertheless, people working in luxurious, state-of-the-art centres designed to stimulate innovation who find that their environment doesn't make them feel at all creative. And there are those who don't have a budget, or much space, but who innovate successfully.\n\nFor Robert B. Cialdini, Professor of Psychologr at Arizona State University, one reason that companies don't succeed as often as they should is that innovation starts with recruitment. Research shows that the fit between an employee's values and a company's values makes a difference to what contribution they make and whether, two years after they join, they're still at the company. Studies at Harvard Business School show that, although some individuals may be more creative than others, almost every individual can be creative in the right circumstances.\n\nOne of the most famous photographs in the stow of rock'n'roll emphasises Cialdini's views. The 1956 picture of singers Elvis Presley, Carl Perkins, Johnny Cash and Jerry Lee Lewis jamming at a piano in Sun Studios in Memphis tells a hidden stow. Sun's 'million-dollar quartet' could have been a quintet. Missing from the picture is Roy Orbison, a greater natural singer than Lewis, Perkins or Cash. Sam Phillips, who owned Sun, wanted to revolutionise popular music with songs that fused black and white music, and country and blues. Presley, Cash, Perkins and Lewis instinctively understood Phillips's ambition and believed in it. Orbison wasn't inspired by the goal, and only ever achieved one hit with the Sun label.\n\nThe value fit matters, says Cialdini, because innovation is, in part, a process of change, and under that pressure we, as a species, behave differently, 'When things change, we are hard-wired to play it safe. ' Managers should therefore adopt an approach that appears counter- intuitive - they should explain what stands to be lost if the company fails to seize a particular opportunity. Studies show that we invariably take more gambles when threatened with a loss than when offered a reward.\n\nManaging innovation is a delicate art. It's easy for a company to be pulled in conflicting directions as the marketing, product development, and finance departments each get different feedback from different sets of people. And without a system which ensures collaborative exchanges within the company, it's also easy for small 'pockets of innovation' to disappear. Innovation is a contact sport. You cant brief people just by saying, 'We're going in this direction and I'm going to take you with me. ' Cialdini believes that this 'follow-the- leader syndrome' is dangerous, not least because it encourages bosses to go it alone. 'It's been scientifically proven that three people will be better than one at solving problems, even if that one person is the smartest person in the field.' To prove his point, Cialdini cites an interview with molecular biologist James Watson. Watson, together with Francis Crick, discovered the structure of DNA, the genetic information carrier of all living organisms. 'When asked how they had cracked the code ahead of an array of highly accomplished rival investigators, he said something that stunned me. He said he and Crick had succeeded because they were aware that they weren't the most intelligent of the scientists pursuing the answer. The smartest scientist was called Rosalind Franklin who, Watson said, "was so intelligent she rarely sought advice". '\n\nTeamwork taps into one of the basic drivers of human behaviour. 'The principle of social proof is so pervasive that we don't even recognise it,' says Cialdini. 'If your project is being resisted, for example, by a group of veteran employees, ask another old-timer to speak up for it.' Cialdini is not alone in advocating this strategy. Research shows that peer power, used horizontally not vertically, is much more powerful than any boss's speech.\n\nWriting, visualising and prototyping can stimulate the flow of new ideas. Cialdini cites scores of research papers and historical events that prove that even something as simple as writing deepens every individual's engagement in the project. It is, he says, the reason why all those competitions on breakfast cereal packets encouraged us to write in saying, in no more than IO words: 'I like Kellogg's Corn Flakes because. ' The very act of writing makes us more likely to believe it.\n\nAuthority doesn't have to inhibit innovation but it often does. The wrong kind of leadership will lead to what Cialdini calls 'captainitis, the regrettable tendency of tearn members to opt out of team responsibilities that are properly theirs'. He calls it captainitis because, he says, 'crew members of multipilot aircraft exhibit a sometimes deadly passivity when the flight captain makes a clearly wrong-headed decision'. This behaviour is not, he says, unique to air travel, but can happen in any workplace where the leader is overbearing.\n\nAt the other end of the scale is the 1980s Memphis design collective, a group of young designers for whom 'the only rule was that there were no rules'. This environment encouraged a free interchange of ideas, which led to more creativity with form, function, colour and materials that revolutionised attitudes to furniture design.\n\nMany theorists believe the ideal boss should lead from behind, taking pride in collective accomplishment and giving credit where it is due. Cialdini says: 'Leaders should encourage everyone to contribute and simultaneously assure all concerned that every recommendation is important to making the right decision and will be given full attention.' The frustrating thing about innovation is that there are many approaches, but no magic formula. However, a manager who wants to create a truly innovative culture can make their job a lot easier by recognising these psychological realities.
16	40	Tea and the Industrial Revolution	**Paragraph E**\n\nParagraph F List of Headings The search for the reasons for an increase in population Industrialisation and the fear of unemployment The development of cities in Japan The time and place of the Industrial Revolution The cases of Holland, France and China Changes in drinking habits in Britain Two keys to Britain's industrial revolution Conditions required for industrialisation Comparisons with Japan lead to the answer\n\n**Paragraph G**\n\n**Section A**\n\n**Section B**\n\nD Tea and the Industrial Revolution\n\nA Cambridge professor says that a change in drinking habits was the reason for the Industrial Revolution in Britain. Anjana Ahuja reports\n\nAlan Macfarlane, professor of anthropological science at King's College, Cambridge, has, like other historians, spent decades wrestling with the enigma of the Industrial Revolution. Why did this particular Big Bang - the world-changing birth of industry - happen in Britain? And why did it strike at the end of the 18th century?\n\nMacfarlane compares the puzzle to a combination lock. 'There are about 20 different factors and all of them need to be present before the revolution can happen,' he says. For industry to take off, there needs to be the technology and power to drive factories, large urban populations to provide cheap labour, easy transport to move goods around, an affluent middle-class willing to buy mass-produced objects, a market-driven economy and a political system that allows this to happen. While this was the case for England, other nations, such as Japan, the Netherlands and France also met some of these criteria but were not industrialising. 'All these factors must have been necessary but not sufficient to cause the revolution,' says Macfarlane. 'After all, Holland had everything except coal, while China also had many of these factors. Most historians are convinced there are one or two missing factors that you need to open the lock. '\n\nmissing factors, he proposes, are to be found in almost every kitchen cupboard. Tea and beer, two of the nation's favourite drinks, fuelled the revolution. antiseptic properties of tannin, the active ingredient in tea, and of hops in beer - plus the fact that both are made with boiled water - allowed urban communities to flourish at close quarters without succumbing to water-borne diseases such as dysentery. The theory sounds eccentric but once he starts to explain the detective work that went into his deduction, the scepticism gives way to wary admiration. Macfarlane's case has been strengthened by support from notable quarters - Roy Porter, the distinguished medical historian, recently wrote a favourable appraisal of his research.\n\nMacfarlane had wondered for a long time how the Industrial Revolution came about. Historians had alighted on one interesting factor around the mid-18th century that required explanation. Between about 1650 and 1740, the population in Britain was static. But then there was a burst in population growth. Macfarlane says: 'The infant mortality rate halved in the space of 20 years, and this happened in both rural areas and cities, and across all classes. People suggested four possible causes. Was there a sudden change in the viruses and bacteria around? Unlikely. Was there a revolution in medical science? But this was a century before Lister's revolution Was there a change in environmental conditions? There were improvements in agriculture that wiped out malaria, but these were small gains. Sanitation did not become widespread until the 19th century. 'lhe only option left is food. But the height and weight statistics show a decline. So the food must have got worse. Efforts to explain this sudden reduction in child deaths appeared to draw a blank.'\n\nJoseph Lister was the first doctor to use antiseptic techniques during surgical operations to prevent infections.\n\n**Section F**\n\nG population burst seemed to happen at just the right time to provide labour for the Industrial Revolution. 'When you start moving towards an industrial revolution, it is economically effcient to have people living close together,' says Macfarlane. 'But then you get disease, particularly from human waste.' Some digging around in historical records revealed that there was a change in the incidence of water-borne disease at that time, especially dysentery. Macfarlane deduced that whatever the British were drinking must have been important in regulating disease. He says, 'We drank beer. For a long time, the English were protected by the strong antibacterial agent in hops, which were added to help preserve the beer. But in the late 17th century a tax was introduced on malt, the basic ingredient of beer. The poor turned to water and gin and in the 1720s the mortality rate began to rise again. lhen it suddenly dropped again. What caused this?' Macfarlane looked to Japan, which was also developing large cities about the same time, and also had no sanitation. Water-borne diseases had a much looser grip on the Japanese population than those in Britain. Could it be the prevalence of tea in their culture? Macfarlane then noted that the history of tea in Britain provided an extraordinary coincidence of dates. Tea was relatively expensive until Britain started a direct clipper trade with China in the early 18th century. By the 1740s, about the time that infant mortality was dipping, the drink was common. Macfarlane guessed that the fact that water had to be boiled, together with the stomach-purifring properties of tea meant that the breast milk provided by mothers was healthier than it had ever been. No other European nation sipped tea like the British, which, by Macfarlane's logic, pushed these other countries out of contention for the revolution. But, if tea is a factor in the combination lock, why didn't Japan forge ahead in a tea-soaked industrial revolution of its own? Macfarlane notes that even though 17th-century Japan had large cities, high literacy rates, even a futures market, it had turned its back on the essence of any work-based revolution by giving up labour-saving devices such as animals, afraid that they would put people out of work. So, the nation that we now think of as one of the most technologically advanced entered the 19th century having 'abandoned the wheel'.
17	41	Gifted children and learning	ifted children and learning\n\nInternationally, 'giftedness' is most frequently determined by a score on a general intelligence test, known as an IQ test, which is above a chosen cut- off point, usually at around the top 2-5%. Children's educational environment contributes to the IQ score and the way intelligence is used. For example, a very close positive relationship was found when children's IQ scores were compared with their home educational provision (Freeman, 2010). The higher the children's IQ scores, especially over IQ 1 30, the better the quality of their educational backup, measured in terms of reported verbal interactions with parents, number of books and activities in their home etc. Because IQ tests are decidedly influenced by what the child has learned, they are to some extent measures of current achievement based on age-norms; that is, how well the children have learned to manipulate their knowledge and know-how within the terms of the test. The vocabulary aspect, for example, is dependent on having heard those words. But IQ tests can neither identify the processes of learning and thinking nor predict creativity.\n\nExcellence does not emerge without appropriate help. To reach an exceptionally high standard in any area very able children need the means to learn, which includes material to work with and focused challenging tuition and the encouragement to follow their dream. There appears to be a qualitative difference in the way the intellectually highly able think, compared with more average-ability or older pupils, for whom external regulation by the teacher often compensates for lack of internal regulation. To be at their most effective in their self-regulation, all children can be helped to identify their own ways of learning - metacognition - which will include strategies of planning, monitoring, evaluation, and choice of what to learn. Emotional awareness is also part of metacognition, so children should be helped to be aware of their feelings around the area to be learned, feelings Of curiosity or confidence, for example.\n\nHigh achievers have been found to use self-regulatory learning strategies more often and more effectively than lower achievers, and are better able to transfer these strategies to deal with unfamiliar tasks. This happens to such a high degree in some children that they appear to be demonstrating talent in particular areas. Overviewing research on the thinking process of highly able children, (Shore and Kanevsky, 1993) put the instructor's problem succinctly: 'If they [the gifted] merely think more quickly, then we need only teach more quickly. If they merely make fewer errors, then we can shorten the practice'. But of course, this is not entirely the case; adjustments have to be made in methods of learning and teaching, to take account of the many ways individuals think,\n\nYet in order to learn by themselves, the gifted do need some support from their teachers. Conversely, teachers who have a tendency to 'overdirect' can diminish their gifted pupils' learning autonomy. Although 'spoon-feeding' can produce extremely high examination results, these are not always followed by equally impressive life successes. Too much dependence on the teacher risks loss of autonomy and motivation to discover. However, when teachers help pupils to reflect on their own learning and thinking activities, they increase their pupils' self-regulation. For a young child, it may be just the simple question 'What have you learned today?' which helps them to recognise what they are doing. Given that a fundamental goal of education is to transfer the control of learning from teachers to pupils, improving pupils' learning to learn techniques should be a major outcome of the school experience, especially for the highly competent. There are quite a number of new methods which can help, such as child- initiated learning, ability-peer tutoring, etc. Such practices have been found to be particularly useful for bright children from deprived areas.\n\nBut scientific progress is not all theoretical, knowledge is also vital to outstanding performance: individuals who know a great deal about a specific domain will achieve at a higher level than those who do not (Elshout, 1995). Research with creative scientists by Simonton (1988) brought him to the conclusion that above a certain high level, characteristics such as independence seemed to contribute more to reaching the highest levels of expertise than intellectual skills, due to the great demands of effort and time needed for learning and practice. Creativity in all forms can be seen as expertise mixed with a high level of motivation (Weisberg, 1993).\n\nTO sum up, learning is affected by emotions of both the individual and significant others. Positive emotions facilitate the creative aspects of learning and negative emotions inhibit it. Fear, for example, can limit the development of curiosity, which is a strong force in scientific advance, because it motivates problem-solving behaviour. In Boekaerts' (1991) review of emotion in the learning of very high IQ and highly achieving children, she found emotional forces in harness. They were not only curious, but often had a strong desire to control their environment, improve their learning efficiency, and increase their own learning resources.
18	42	Museums of fine art and their public	The fact that people go to the Louvre museum in Paris to see the original painting Mona Lisa when they can see a reproduction anywhere leads us to question some assumptions about the role of museums of fine art in today's world One of the most famous works of art in the world is Leonardo da Vinci's Mona Lisa. Nearly everyone who goes to see the original will already be familiar with it from reproductions, but they accept that fine art is more rewardingly viewed in its original form. However, if Mona Lisa was a famous novel, few people would bother to go to a museum to read the writer's actual manuscript rather than a printed reproduction. This might be explained by the fact that the novel has evolved precisely because of technological developments that made it possible to print out huge numbers of texts, whereas oil paintings have always been produced as unique objects. In addition, it could be argued that the practice of interpreting or 'reading' each medium follows different conventions. With novels, the reader attends mainly to the meaning of words rather than the way they are printed on the page, whereas the 'reader' of a painting must attend just as closely to the material form of marks and shapes in the picture as to any ideas they may signify. Yet it has always been possible to make very accurate facsimiles of pretty well any fine art work. The seven surviving versions of Mona Lisa bear witness to the fact that in the 1 6th century, artists seemed perfectly content to assign the reproduction of their creations to their workshop apprentices as regular 'bread and butter' work. And today the task of reproducing pictures is incomparably more simple and reliable, with reprographic techniques that allow the production of high-quality prints made exactly to the original scale, with faithful colour values, and even with duplication of the surface relief of the painting. But despite an implicit recognition that the spread of good reproductions can be culturally valuable, museums continue to promote the special status of original work. Unfortunately, this seems to place severe limitations on the kind of experience offered to visitors. One limitation is related to the way the museum presents its exhibits. As repositories of unique historical objects, art museums are often called 'treasure houses'. We are reminded of this even before we view a collection by the presence of security guards, attendants, ropes and display cases to keep us away from the exhibits. In many cases, the architectural style of the building further reinforces that notion. In addition, a major collection like that of London's National Gallery is housed in numerous rooms, each with dozens of works, any one of which is likely to be worth more than all the average visitor possesses. In a society that judges the personal status of the individual so much by their material worth, it is therefore difficult not to be impressed by one's own relative 'worthlessness' in such an environment. Furthermore, consideration of the 'value' of the original work in its treasure house setting impresses upon the viewer that, since these works were originally produced, they have been assigned a huge monetary value by some person or institution more powerful than themselves. Evidently, nothing the viewer thinks about the work is going to alter that value, and so today's viewer is deterred from trying to extend that spontaneous, immediate, self-reliant kind of reading which would originally have met the work. The visitor may then be struck by the strangeness of seeing such diverse paintings, drawings and sculptures brought together in an environment for which they were not originally created. This 'displacement effect' is further heightened by the sheer volume of exhibits. In the case of a major collection, there are probably more works on display than we could realistically view in weeks or even months. This is particularly distressing because time seems to be a vital factor in the appreciation of all art forms. A fundamental difference between paintings and other art forms is that there is no prescribed time over which a painting is viewed. By contrast, the audience encounters an opera or a play over a specific time, which is the duration of the performance. Similarly, novels and poems are read in a prescribed temporal sequence, whereas a picture has no clear place at which to start viewing, or at which to finish. Thus art works themselves encourage us to view them superficially, without appreciating the richness of detail and labour that is involved. Consequently, the dominant critical approach becomes that of the art historian, a specialised academic approach devoted to 'discovering the meaning' of art within the cultural context of its time. This is in perfect harmony with the museum's function, since the approach is dedicated to seeking out and conserving 'authentic', 'original' readings of the exhibits. Again, this seems to put paid to that spontaneous, participatory criticism which can be found in abundance in criticism of classic works of literature, but is absent from most art history. The displays of art museums serve as a warning of what critical practices can emerge when spontaneous criticism is suppressed. The museum public, like any other audience, experience art more rewardingly when given the confidence to express their views. If appropriate works of fine art could be rendered permanently accessible to the public by means of high-fidelity reproductions, as literature and music already are, the public may feel somewhat less in awe of them. Unfortunately, that may be too much to ask from those who seek to maintain and control the art establishment.
19	47	The Tourism Boom	A Travel has existed since the beginning of time, when primitive man set out, often traversing great distances in search of game, which provided the food and clothing necessary for his survival. Throughout the course of history, people have travelled for purposes of trade, religious conviction, economic gain, war, migration and other equally compelling motivations. In the Roman era, wealthy aristocrats and high government officials also travelled for pleasure. Seaside resorts located at Pompeii and Herculaneum afforded citizens the opportunity to escape to their vacation villas in order to avoid the summer heat of Rome. Travel, except during the Dark Ages, has continued to grow and, throughout recorded history, has played a vital role in the development of civilisations and their economies. B Tourism in the mass form as we know it today is a distinctly twentieth-century phenomenon. Historians suggest that the advent of mass tourism began in England during the industrial revolution with the rise of the middle class and the availability of relatively inexpensive transportation. The creation of the commercial airline industry following the Second World War and the subsequent development of the jet aircraft in the 1950s signalled the rapid growth and expansion of international travel. This growth led to the development of a major new industry: tourism. In turn, international tourism became the concern of a number of world governments since it not only provided new employment opportunities but also produced a means of earning foreign exchange. C Tourism today has grown significantly in both economic and social importance. In most industrialised countries over the past few years the fastest growth has been seen in the area of services. One of the largest segments of the service industry, although largely unrecognised as an entity in some of these countries, is travel and tourism. According to the World Travel and Tourism Council (1992), 'Travel and tourism is the largest industry in the world on virtually any economic measure including value-added capital investment, employment and tax contributions'. In 1992, the industry's gross output was estimated to be $3.5 trillion, over 12 per cent of all consumer spending. The travel and tourism industry is the world's largest employer with almost 130 million jobs, or almost 7 per cent of all employees. This industry is the world's leading industrial contributor, producing over 6 per cent of the world's gross national product and accounting for capital investment in excess of $422 billion in direct, indirect and personal taxes each year. Thus, tourism has a profound impact both on the world economy and, because of the educative effect of travel and the effects on employment, on society itself.\n\n**Section D**\n\nE However, the major problems of the travel and tourism industry that have hidden, or obscured, its economic impact are the diversity and fragmentation of the industry itself. The travel industry includes: hotels, motels and other types of accommodation; restaurants and other food services; transportation services and facilities; amusements, attractions and other leisure facilities; gift shops and a large number of other enterprises. Since many of these businesses also serve local residents, the impact of spending by visitors can easily be overlooked or underestimated. In addition, Meis (1992) points out that the tourism industry involves concepts that have remained amorphous to both analysts and decision makers. Moreover, in all nations this problem has made it difficult for the industry to develop any type of reliable or credible tourism information base in order to estimate the contribution it makes to regional, national and global economies. However, the nature of this very diversity makes travel and tourism ideal vehicles for economic development in a wide variety of countries, regions or communities. Once the exclusive province of the wealthy, travel and tourism have become an institutionalised way of life for most of the population. In fact, McIntosh and Goeldner (1990) suggest that tourism has become the largest commodity in international trade for many nations and, for a significant number of other countries, it ranks second or third. For example, tourism is the major source of income in Bermuda, Greece, Italy, Spain, Switzerland and most Caribbean countries. In addition, Hawkins and Ritchie, quoting from data published by the American Express Company, suggest that the travel and tourism industry is the number one ranked employer in the Bahamas, Brazil, Canada, France, (the former) West Germany, Hong Kong, Italy, Jamaica, Japan, Singapore, the United Kingdom and the United States. However, because of problems of definition, which directly affect statistical measurement, it is not possible with any degree of certainty to provide precise, valid or reliable data about the extent of world-wide tourism participation or its economic impact. In many cases, similar difficulties arise when attempts are made to measure domestic tourism.
20	48	Autumn leaves	utumn leaves\n\nCanadian writer Jay Ingram investigates the mystery of why leaves turn red in the fall\n\nOne of the most captivating natural events of the year in many areas throughout North America is the turning of the leaves in the fall. The colours are magnificent, but the question of exactly why some trees turn yellow or orange, and others red or purple, is something which has long puzzled scientists.\n\nSummer leaves are green because they are full of chlorophyll, the molecule that captures sunlight and converts that energ.' into new building materials for the tree. As fall approaches in the northern hemisphere, the amount of solar energy available declines considerably. For many trees - evergreen conifers being an exception - the best strategy is to abandon photosynthesis until the spring. So rather than maintaining the now redundant leaves throughout the winter, the tree saves its precious resources and discards them. But before letting its leaves go, the tree dismantles their chlorophyll molecules and ships their valuable nitrogen back into the twigs. As chlorophyll is depleted, other colours that have been dominated by it throughout the summer begin to be revealed. This unmasking explains the autumn colours of yellow and orange, but not the brilliant reds and purples of trees such as the maple or sumac.\n\nThe source of the red is widely known: it is created by anthocyanins, water-soluble plant pigrnents reflecting the red to blue range of the visible spectrum. They belong to a class of sugar-based chemical compounds also known as flavonoids. What's puzzling is that anthocyanins are actually newly minted, made in the leaves at the sarne time as the tree is preparing to drop them. But it is hard to make sense of the manufacture of anthocyanins - why should a tree bother making new chemicals in its leaves when it's already scrambling to withdraw and preserve the ones already there?\n\nSome theories about anthocyanins have argued that they might act as a chemical defence against attacks by insects or fungi, or that they might attract fruit-eating birds or increase a leaf's tolerance to freezing. However there are problems with each of these theories, including the fact that leaves are red for such a relatively short period that the expense of energy needed to manufacture the anthocyanins would outweigh any anti-fungal or anti-herbivore activity achieved.\n\nphotosynthesis: the production of new material from sunlight, water and carbon dioxide\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH It has also been proposed that trees may produce vivid red colours to convince herbivorous insects that they are healthy and robust and would be easily able to mount chemical defences against infestation. If insects paid attention to such advertisements, they might be prompted to lay their eggs on a duller, and presumably less resistant host. The flaw in this theory lies in the lack of proof to support it. No one ha.s as yet ascertained whether more robust trees sport the brightest leaves, or whether insects make choices according to colour intensity.\n\nPerhaps the most plausible suggestion as to why leaves would go to the trouble of making anthocyanins when they're busy packing up for the winter is the theory known as the 'light screen' hypothesis. It sounds paradoxical, because the idea behind this hypothesis is that the red pigment is made in autumn leaves to protect chlorophyll, the light-absorbing chemical, from too much light. Why does chlorophyll need protection when it is the natural world's supreme light absorber? Why protect chlorophyll at a time when the tree is breaking it down to salvage as much of it as possible?\n\nChlorophyll, although exquisitely evolved to capture the energy of sunlight, can sometimes be overwhelmed by it, especially in situations of drought, Iow temperatures, or nutrient deficiency. Moreover, the problem of oversensitivity to light is even more acute in the fall, when the leaf is busy preparing for winter by dismantling its internal machinery. The energy absorbed by the chlorophyll molecules of the unstable autumn leaf is not immediately channelled into useful products and processes, as it would be in an intact summer leaf. The weakened fall leaf then becomes vulnerable to the highly destructive effects of the oxygen created by the excited chlorophyll molecules.\n\nEven if you had never suspected that this is what was going on when leaves turn red, there are clues out there. One is straightforward: on many trees, the leaves that are the reddest are those on the side of the tree which gets most sun. Not only that, but the red is brighter on the upper side of the leaf. It has also been recognised for decades that the best conditions for intense red colours are dry, sunny days and cool nights, conditions that nicely match those that make leaves susceptible to excess light. And finally, trees such as maples usually get much redder the more north you travel in the northern hemisphere. It's colder there, they're more stressed, their chlorophyll is more sensitive and it needs more sunblock.\n\nWhat is still not fully understood, however, is why some trees resort to producing red pigments while others don't bother, and simply reveal their orange or yellow hues. Do these trees have other means at their disposal to prevent overexposure to light in autumn? Their stow, though not as spectacular to the eye, will surely turn out to be a.s subtle and as complex.
21	49	Beyond the blue horizon	Ancient voyagers who settled the far-flung islands of the Pacific Ocean\n\nAn important archaeological discovery on the island of Éfaté in the Pacific archipelago of Vanuatu has revealed traces of an ancient seafaring people, the distant ancestors of today's Polynesians. The site came to light only by chance. An agricultural worker, digging in the grounds of a derelict plantation, scraped open a grave - the first of dozens in a burial ground some 3,000 years old. It is the oldest cemetery ever found in the Pacific islands, and it harbors the remains of an ancient people archaeologists call the Lapita They were daring blue-water adventurers who used basic canoes to rove across the ocean. But they were not just explorers. Ihey were also pioneers who carried with them everything they would need to build new lives - their livestock, taro seedlings and stone tools. Within the span of several centuries, the Lapita stretched the boundaries of their world from the jungle-clad volcanoes of Papua New Guinea to the loneliest coral outliers Of Tonga. The Lapita left precious few clues about themselves, but Éfaté expands the volume of data available to researchers dramatically. The remains of 62 individuals have been uncovered so far, and archaeologists were also thrilled to find six complete Lapita pots. Other items included a Lapita burial urn with modeled birds arranged on the rim as though peering down at the human remains sealed inside. 'It's an important discovery, says Matthew Spriggs, professor of archaeology at the Australian National University and head of ua New Gtijneac\n\nI VanuatU. Tbhiti\n\nthe international team digging up the site, 'for it conclusively identifies the remains as Lapita.'\n\nDNA teased from these human remains may help answer one of the most puzzling questions in Pacific anthropology: did all Pacific islanders spring from one source or many? Was there only one outward migration from a single point in Asia, or several from different points? 'This represents the best opportunity we've had yet,' says Spriggs, 'to find out who the Lapita actually were, where they came from, and who their closest descendants are today. '\n\nThere is one stubborn question for which archaeology has yet to provide any answers: how did the Lapita accomplish the ancient equivalent of a moon landing, many times over? No-one has found one of their canoes or any rigging, which could reveal how the canoes were sailed. Nor do the oral histories and traditions of later Polynesians offer any insights, for they turn into myths long before they reach as far back in time as the Lapita.\n\n'All we can say for certain is that the Lapita had canoes that were capable of ocean voyages, and they had the ability to sail them,' says Geoff Irwin, a professor of archaeology at the University of Auckland. Those sailing skills, he says, were developed and passed down over thousands of years by earlier mariners who worked their way through the archipelagoes of the western Pacific, making short crossings to nearby islands. "lhe real adventure didn't begin, however, until their Lapita descendants sailed out of sight of land, with empty horizons on every side. This must have been as diffcult for them as landing on the moon is for us today. Certainly it distinguished them from their ancestors, but what gave them the courage to launch out on such risky voyages? The Lapita's thrust into the Pacific was eastward, against the prevailing trade winds, Irwin notes. Those nagging headwinds, he argues, may have been the key to their success. 'They could sail out for days into the unknown and assess the area, secure in the knowledge that if they didn't find anything, they could turn about and catch a swift ride back on the trade winds. Ihis is what would have made the whole thing work.' Once out there, skilled seafarers would have detected abundant leads to follow to land: seabirds, coconuts and twigs carried out to sea by the tides, and the afternoon pile-up of clouds on the horizon which often indicates an island in the distance.\n\nFor returning explorers, successful or not, the geography of their own archipelagoes would have provided a safety net. Without this to go by, overshooting their home ports, getting lost and sailing off into eternity would have been all too easy. Vanuatu, for example, stretches more than 500 miles in a northwest-southeast trend, its scores of intervisible islands forming a backstop for mariners riding the trade winds home.\n\nAll this presupposes one essential detail, says Atholl Anderson, professor of prehistory at the Australian National University: the Lapita had mastered the advanced art of sailing against the wind. 'And there's no proof they could do any such thing,' Anderson says. 'There has been this assumption they did, and people have built canoes to re-create those early voyages based on that assumption. But nobody has any idea what their canoes looked like or how they were rigged.' Rather than give all the credit to human skill, Anderson invokes the winds of chance. El Nino, the same climate disruption that affects the Pacific today, may have helped scatter the Lapita, Anderson suggests. He points out that climate data obtained from slow-growing corals around the Pacific indicate a series of unusually frequent El Nifios around the time of the Lapita expansion. By reversing the regular east-to-west flow of the trade winds for weeks at a time, these 'super El Nifios' might have taken the Lapita on long unplanned voyages. However they did it, the Lapita spread themselves a third of the way across the Pacific, then called it quits for reasons known only to them. Ahead lay the vast emptiness of the central Pacific and perhaps they were too thinly stretched to venture farther. 'Ihey probably never numbered more than a few thousand in total, and in their rapid migration eastward they encountered hundreds of islands - more than 300 in Fiji alone.
22	54	The Megafires of California	Drought, housing expansion, and oversupply of tinder make for bigger, hotter fires in the western United States\n\nWildfires are becoming an increasing menace in the western United States, with Southern California being the hardest hit area. There's a reason fire squads battling more frequent blazes in Southern California are having such difficulty containing the flames, despite better preparedness than ever and decades of experience fighting fires fanned by the 'Santa Ana Winds'. The wildfires themselves, experts say, are generally hotter, faster, and spread more erratically than in the past. Megafires, also called 'siege fires', are the increasingly frequent blazes that burn 500,000 acres or more - IO times the size of the average forest fire of 20 years ago. Some recent wildfires are among the biggest ever in California in terms of acreage burned, according to state figures and news reports. One explanation for the trend to more superhot fires is that the region, which usually has dry summers, has had significantly below normal precipitation in many recent years. Another reason, experts say, is related to the century- long policy of the US Forest Service to stop wildfires as quickly as possible. The unintentional consequence has been to halt the natural eradication of underbrush, now the primary fuel for megafires. Three other factors contribute to the trend, they add. First is climate change, marked by a I-degree Fahrenheit rise in average yearly temperature across the western states. Second is fire seasons that on average are 78 days longer than they were 20 years ago. Third is increased construction of homes in wooded areas. are increasingly building our homes in fire-prone ecosystems, ' says Dominik Kulakowski, adjunct professor of biology at Clark University Graduate School of Geography in Worcester, Massachusetts. Doing that in many of the forests of the western US is like building homes on the side of an active volcano. ' In California, where population growth has averaged more than 600,000 a year for at least a decade, more residential housing is being built. ' IA.That once was open space is now residential homes providing fuel to make fires burn with greater intensity, ' says Terry McHale of the California Department of Forestry firefighters' union. 'With so much dryness, so many communities to catch fire, so many fronts to fight, it becomes an almost incredible job.' That said, many experts give California high marks for making progress on preparedness in recent years, after some of the largest fires in state history scorched thousands of acres, burned thousands of homes, and killed numerous people. Stung in the past by criticism of bungling that allowed fires to spread when they might have been contained, personnel are meeting the peculiar challenges of neighborhood - and canyon- hopping fires better than previously, observers say. State promises to provide more up-to-date engines, planes, and helicopters to fight fires have been fulfilled. Firefighters' unions that in the past complained of dilapidated equipment, old fire engines, and insufficient blueprints for fire safety are now praising the state's commitment, noting that funding for firefighting has increased, despite huge cuts in many other programs. 'We are pleased that the current state administration has been very proactive in its support of us, and [has] come through with budgetary support of the infrastructure needs we have long sought,' says Mr. McHale of the firefighters' union. Besides providing money to upgrade the fire engines that must traverse the mammoth state and wind along serpentine canyon roads, the state has invested in better command-and-control facilities as well as in the strategies to run them. 'In the fire sieges of earlier years, we found that other jurisdictions and states were willing to offer mutual-aid help, but we were not able to communicate adequately with them,' says Kim Zagaris, chief of the state's Office of Emergency Services Fire and Rescue Branch. After a commission examined and revamped communications procedures, the statewide response 'has become far more professional and responsive, ' he says. There is a sense among both government officials and residents that the speed, dedication, and coordination of firefighters from several states and jurisdictions are resulting in greater efficiency than in past 'siege fire' situations. In recent years, the Southern California region has improved building codes, evacuation procedures, and procurement of new technology. 'I am extraordinarily impressed by the improvements we have witnessed, ' says Randy Jacobs, a Southern California- based lawyer who has had to evacuate both his home and business to escape wildfires. 'Notwithstanding all the damage that will continue to be caused by wildfires, we will no longer suffer the loss of life endured in the past because of the fire prevention and firefighting measures that have been put in place, ' he says.
23	55	Second nature	Your personality isn 't necessarily set in stone. With a little experimentation, people can reshape their temperaments and inject passion, optimism, joy and\n\n**Section A**\n\n**Section B**\n\n**Section C**\n\nD courage into their lives\n\nPsychologists have long held that a person's character cannot undergo a transformation in any meaningful way and that the key traits of personality are determined at a very young age. However, researchers have begun looking more closely at ways we can change. Positive psychologists have identified 24 qualities we admire, such as loyalty and kindness, and are studying them to find out why they come so naturally to some people. What they're discovering is that many of these qualities amount to habitual behaviour that determines the way we respond to the world. The good news is that all this can be learned. Some qualities are less challenging to develop than others, optimism being one of them. However, developing qualities requires mastering a range of skills which are diverse and sometimes surprising. For example, to bring more joy and passion into your life, you must be open to experiencing negative emotions. Cultivating such qualities will help you realise your full potential. 'The evidence is good that most personality traits can be altered,' says Christopher Peterson, professor of psychology at the University of Michigan, who cites himself as an example. Inherently introverted, he realised early on that as an academic, his reticence would prove disastrous in the lecture hall. So he learned to be more outgoing and to entertain his classes. 'Now my extroverted behaviour is spontaneous,' he says. David Fajgenbaum had to make a similar transition. He was preparing for university, when he had an accident that put an end to his sports career. On campus, he quickly found that beyond ordinary counselling, the university had no services for students who were undergoing physical rehabilitation and suffering from depression like him. He therefore launched a support group to help others in similar situations. He took action despite his own pain - a typical response of an optimist. Suzanne Segerstrom, professor Of psychology at the University of Kentucky, believes that the key to increasing optimism is through cultivating optimistic behaviour, rather than positive thinking. She recommends you train yourself to pay attention to good fortune by writing down three positive things that come about each day. This will help you convince yourself that favourable outcomes actually happen all the time, making it easier to begin taking action.\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH You can recognise a person who is passionate about a pursuit by the way they are so strongly involved in it. Tanya Streeter's passion is freediving - the sport of plunging deep into the water without tanks or other breathing equipment. Beginning in 1998, she set nine world records and can hold her breath for six minutes. The physical stamina required for this sport is intense but the psychological demands are even more overwhelming. Streeter learned to untangle her fears from her judgment of what her body and mind could do. 'In my career as a competitive freediver, there was a limit to what I could do - but it wasn't anywhere near what I thought it was,' she says. Finding a pursuit that excites you can improve anyone's life. The secret about consuming passions, though, according to psychologist Paul Silvia of the University of North Carolina, is that 'they require discipline, hard work and ability, which is why they are so rewarding.' Psychologist Todd Kashdan has this advice for those people taking up a new passion: 'As a newcomer, you also have to tolerate and laugh at your own ignorance. You must be willing to accept the negative feelings that come your way,' he says. In 2004, physician-scientist Mauro Zappaterra began his PhD research at Harvard Medical School. Unfortunately, he was miserable as his research wasn't compatible with his curiosity about healing. He finally took a break and during eight months in Santa Fe, Zappaterra learned about alternative healing techniques not taught at Harvard. When he got back, he switched labs to study how cerebrospinal fluid nourishes the developing nervous system. He also vowed to look for the joy in everything, including failure, as this could help him learn about his research and himself. One thing that can hold joy back is a person's concentration on avoiding failure rather than their looking forward to doing something well. 'Focusing on being safe might get in the way of your reaching your goals,' explains Kashdan. For example, are you hoping to get through a business lunch without embarrassing yourself, or are you thinking about how fascinating the conversation might be? Usually, we think of courage in physical terms but ordinary life demands something else. For marketing executive Kenneth Pedeleose, it meant speaking out against something he thought was ethically wrong. The new manager was intimidating staff so Pedeleose carefully recorded each instance of bullying and eventually took the evidence to a senior director, knowing his own job security would be threatened. Eventually the manager was the one to go. According to Cynthia Pury, a psychologist at Clemson University, Pedeleose's story proves the point that courage is not motivated by fearlessness, but by moral obligation. Pury also believes that people can acquire courage. Many of her students said that faced with a risky situation, they first tried to calm themselves down, then looked for a way to mitigate the danger, just as Pedeleose did by documenting his allegations. Over the long term, picking up a new character trait may help you move toward being the person you want to be. And in the short term, the effort itself could be surprisingly rewarding, a kind of internal adventure.
24	56	When evolution runs in reverse	When evolution runs backwards\n\nEvolution isn 't supposed to run backwards - yet an increasing number of examples show that it does and that it can sometimes represent the future of a species\n\nThe description of any animal as an 'evolutionary throwback' is controversial. For the better part of a century, most biologists have been reluctant to use those words, mindful of a principle of evolution that says 'evolution cannot run backwards'. But as more and more examples come to light and modern genetics enters the scene, that principle is having to be rewritten. Not only are evolutionary throwbacks possible, they sometimes play an important role in the forward march of evolution.\n\nThe technical term for an evolutionary throwback is an 'atavism' from the Latin atavus, meaning forefather. The word has ugly connotations thanks largely to Cesare Lombroso, a 19th-century Italian medic who argued that criminals were born not made and could be identified by certain physical features that were throwbacks to a primitive, sub-human state.\n\nWhile Lombroso was measuring criminals, a Belgian palaeontologist called Louis Dollo was studying fossil records and coming to the opposite conclusion. In 1890 he proposed that evolution was irreversible: that 'an organism is unable to return, even partially, to a previous stage already realised in the ranks of its ancestors'. Early 20th-century biologists came to a similar conclusion, though they qualified it in terms of probability, stating that there is no reason why evolution cannot run backwards it is just very unlikely. And so the idea of irreversibility in evolution stuck and came to be known as 'Dollo's law'.\n\nIf Dollo's law is right, atavisms should occur only very rarely, if at all. Yet almost since the idea took root, exceptions have been cropping up. In 1919, for example, a humpback whale with a pair of leg-like appendages over a metre long, complete with a full set of limb bones, was caught off Vancouver Island in Canada. Explorer Roy Chapman Andrews argued at the time that the whale must be a throwback to a land-living ancestor. 'l can see no other explanation,' he wrote in 1921\n\nSince then, so many other examples have been discovered that it no longer makes sense to say that evolution is as good as irreversible. And this poses a puzzle: how can characteristics that disappeared millions of years ago suddenly reappear? In 1994, Rudolf Raff and colleagues at Indiana University in the USA decided to use genetics to put a number on the probability of evolution going into reverse. They reasoned that while some evolutionary changes involve the loss of genes and are therefore irreversible, others may be the result of genes being switched off. If these silent genes are somehow switched back on, they argued, long-lost traits could reappear.\n\nRaff's team went on to calculate the likelihood of it happening. Silent genes accumulate random mutations, they reasoned, eventually rendering them useless. So how long can a gene survive in a species if it is no longer used? The team calculated that there is a good chance of silent genes surviving for up to 6 million years in at least a few individuals in a population, and that some might survive as long as 10 million years. In other words, throwbacks are possible, but only to the relatively recent evolutionary past.\n\nAs a possible example, the team pointed to the mole salamanders of Mexico and California. Like most amphibians these begin life in a juvenile 'tadpole' state, then metamorphose into the adult form - except for one species, the axolotl, which famously lives its entire life as a juvenile. The simplest explanation for this is that the axolotl lineage alone lost the ability to metamorphose, while others retained it. From a detailed analysis of the salamanders' family tree, however, it is clear that the other lineages evolved from an ancestor that itself had lost the ability to metamorphose. In other words, metamorphosis in mole salamanders is an atavism. The salamander example fits with Raff's I O-million-year time frame.\n\nMore recently, however, examples have been reported that break the time limit, suggesting that silent genes may not be the whole story. In a paper published last year, biologist Gunter Wagner of Yale University reported some work on the evolutionary history of a group of South American lizards called Bachia. Many of these have minuscule limbs; some look more like snakes than lizards and a few have completely lost the toes on their hind limbs. Other species, however, sport up to four toes on their hind legs. The simplest explanation is that the toed lineages never lost their toes, but Wagner begs to differ. According to his analysis of the Bachia family tree, the toed species re-evolved toes from toeless ancestors and, what is more, digit loss and gain has occurred on more than one occasion over tens of millions of years.\n\nSo what's going on? One possibility is that these traits are lost and then simply reappear, in much the same way that similar structures can independently arise in unrelated species, such as the dorsal fins of sharks and killer whales. Another more intriguing possibility is that the genetic information needed to make toes somehow survived for tens or perhaps hundreds of millions of years in the lizards and was reactivated. These atavistic traits provided an advantage and spread through the population, effectively reversing evolution.\n\nBut if silent genes degrade within 6 to IO million years, how can long-lost traits be reactivated over longer timescales? The answer may lie in the womb. Early embryos of many species develop ancestral features. Snake embryos, for example, sprout hind limb buds. Later in development these features disappear thanks to developmental programs that say 'lose the leg'. If for any reason this does not happen, the ancestral feature may not disappear, leading to an atavism.
30	70	Neuroaesthetics	An emerging discipline called neuroaesthetics is seeking to bring scientific objectivity to the study of art, and has already given us a better understanding of many masterpieces. The blurred imagery of Impressionist paintings seems to stimulate the brain's amygdala, for instance. Since the amygdala plays a crucial role in our feelings, that finding might explain why many people find these pieces so moving.\n\nCould the same approach also shed light on abstract twentieth-century pieces, from Mondrian's geometrical blocks of colour, to Pollock's seemingly haphazard arrangements of splashed paint on canvas? Sceptics believe that people claim to like such works simply because they are famous. We certainly do have an inclination to follow the crowd. When asked to make simple perceptual decisions such as matching a shape to its rotated image, for\n\nexample, people often choose a definitively wrong answer if they see others doing the same. It is easy to imagine that this mentality would have even more impact on a fuzzy concept like art appreciation, where there is no right or wrong answer.\n\nAngelina Hawley-Dolan, of.Boston College, Massachusetts, responded to this debate by asking volunteers to view pairs of paintings - either the creations of famous abstract artists or the doodles of infants, chimps and elephants. They then had to judge which they preferred. A third of the paintings were given no captions, while many were labelled incorrectly - volunteers might think they were viewing a chimp's messy brushstrokes when they were actually seeing an acclaimed masterpiece. In each set of trials, volunteers generally preferred the work of renowned artists, even when they believed it was by an animal or a child. It seems that the viewer can sense the artist's vision in paintings, even if they can't explain why.\n\nRobert Pepperell, an artist based at Cardiff University, creates ambiguous works that are neither entirely abstract nor clearly representational. In one study, Pepperell and his collaborators asked volunteers to decide how 'powerful'they considered an artwork to be, and whether they saw anything familiar in the piece. The longer they took to answer these\n\nquestions, the more highly they rated the piece under scrutiny, and the greater their neural activity. It would seem that the brain sees these images as puzzles, and the harder it is to decipher the meaning, the more rewarding is the moment of recognition.\n\nAnd what about artists such as Mondrian, whose paintings consist exclusively of horizontal and vertical lines encasing blocks of colour? Mondrian's works are deceptively simple, but eye-tracking studies confirm that they are meticulously composed, and that simply rotating a piece radically changes the way we view it. With the originals, volunteers' eyes tended to stay longer on certain places in the image, but with the altered versions they would flit across a piece more rapidly. As a result, the volunteers considered the altered versions less pleasurable when they later rated the work.\n\nIn a similar study, Oshin Vartanian ofToronto University asked volunteers to compare original paintings with ones which he had altered by moving objects around within the frame. He found that almost everyone preferred the original, whether it was a Van Gogh still life or an abstract by Miro. Vartanian also found that changing the composition of the paintings reduced activation in those brain areas linked with meaning and interpretation.\n\nIn another experiment, Alex Forsythe of the University of Liverpool analysed the visual intricacy of different pieces of art, and her results suggest that many artists use a key level of detail to please the brain. Too little and the work is boring, but too much results in a kind of 'perceptual overload; according to Forsythe. What's more, appealing pieces both abstract and\n\nrepresentational, show signs of'fractals' - repeated motifs recurring in different scales. Fractals are common throughout nature, for example in the shapes of mountain peaks or the branches of trees. It is possible that our visual system, which evolved in the great outdoors, finds it easier to process such patterns.\n\nIt is also intriguing that the brain appears to process movement when we see a handwritten letter, as if we are replaying the writer's moment of creation. This has led some to wonder whether Pollock's works feel so dynamic because the brain reconstructs the energetic actions the artist used as he painted. This may be down to our brain's 'mirror neurons; which are known to mimic others' actions. The hypothesis will need to be thoroughly tested, however. It might even be the case that we could use neuroaesthetic studies to understand the longevity of some pieces of artwork. While the fashions of the time might shape what is currently popular, work_ that are best adapted to our visual system may be the most likely to linger once the trends of previous generations have been forgotten.\n\nIt's still early days for the field of neuroaesthetics - and these studies are probably only a taste of what is to come. It would, however, be foolish to reduce art appreciation to a set of scientific laws. We shouldn't underestimate the importance of the style of a particular artist, their place in history and the artistic environment of their time. Abstract art offers both a challenge and the freedom to play with different interpretations. In some ways, it's not so different to science, where we are constantly looking for systems and decoding meaning so that we can view and appreciate the world in a new way.
31	75	The story of silk	The history of the world's most luxurious fabric, from ancient China to the present day Silk is a fine, smooth material produced from the cocoons - soft protective shells that are made by mulberry silkworms (insect larvae). Legend has it that it was Lei Tzu, wife of the Yellow Emperor, ruler of China in about 3000 BC, who discovered silkworms. One account of the story goes that as she was taking a walk in her husband's gardens, she discovered that silkworms were responsible for the destruction of several mulberry trees. She collected a number of cocoons and sat down to have a rest. It just so happened that while she was sipping some tea, one of the cocoons that she had collected landed in the hot tea and started to unravel into a fine thread. Lei Tzu found that she could wind this thread around her fingers. Subsequently, she persuaded her husband to allow her to rear silkworms on a grove of mulberry trees. She also devised a special reel to draw the fibres from the cocoon into a single thread so that they would be strong enough to be woven into fabric. While it is unknown just how much of this is true, it is certainly\n\nknown that silk cultivation has existed in China for several millennia. Originally, silkworm farming was solely restricted to women, and it was they who were responsible for the growing, harvesting and weaving. Silk quickly grew into a symbol of status, and originally, only royalty were entitled to have clothes made of silk. The rules were gradually relaxed over the years until flnally during the Qing Dynasty (1644-1911 AD), even peasants, the lowest caste, were also entitled to wear silk. Sometime during the Han Dynasty (206 BC-220 AD), silk was so prized that it was also used as a unit of currency. Government officials were paid their salary in silk, and farmers paid their taxes in grain and silk. Silk was also used\n\nas diplomatic gifts by the emperor. Fishing lines, bowstrings, musical instruments and paper were all made using silk The earliest indication of silk paper being used was discovered in the tomb of a noble who is estimated to have died around 168AD.\n\nDemand for this exotic fabric eventually created the lucrative trade route now known as the Silk Road, taking silk westward and bringing gold, silver and\n\nulI ul,,j {!:?.>" wool to the East. It was named the Silk Road after its most precious commodity, which was considered to be worth more than gold. The Silk Road stretched over 6,000 kilometres from Eastern China to the Mediterranean Sea, following the Great Wall of China, climbing the Pamir mountain range, crossing modem-day Afghanist.an and going on to the Middle East, with a major trading market in Damascus. From there, the merchandise was shipped across the Mediterranean Sea Few merchants travelled the entire route; goods were handled mostly by a series of middlemen.\n\nWith the mulberry silkworm being native to China, the country was the world's sole producer of silk for many hundreds of years. The secret of silk-making eventually reached the rest of the world via the Byzantine Empire, which ruled over the Mediterranean region of southern Europe, North Africa and the Middle East during the period 330-1453 AD. According to another legend, monks working for the Byzantine emperor Justinian smuggled silkworm eggs to Const.antinople (lst.anbul in modem-day Turkey) in 660 AD, concealed inside hollow bamboo walking canes.. The Byzantines were as secretive as the Chinese, however, and for many centuries the weaving and trading of silk fabric was a strict imperial monopoly. Then in the seventh century, the Arabs conquered Persia, capturing their magnificent silks in the process. Silk production thus spread through Africa, Sicily and Spain as the Arabs swept through these lands. Andalusia in southern Spain was Europe's main silk­ producing centre in the tenth century. By the thirteenth century, however, Italy had become Europe's leader in silk production and export. Venetian merchants traded extensively in silk and encouraged silk growers to settle in Italy. Even now,\n\nsilk processed in the province of Como in northern Italy eajoys an esteemed reputation.\n\nThe nineteenth century and industrialisation saw the downfall of the European silk industry. Cheaper Japanese silk, trade in which was greatly facilitated by the opening of the Suez Canal, was one of the many factors driving the trend. Then in the twentieth century, new manmade fibres, such as nylon, started to be used in\n\nwhat had traditionally been silk products, such as stockings and parachutes. The two world wars, which interrupted the supply of raw material from Japan, also stifled the European silk industry. After the Second World War, Japan's silk production was restored, with improved production and quality of raw silk. Japan was to remain the world's biggest producer of raw silk, and practically the only major exporter of raw silk, until the 1970s. However, in more recent decades, China has gradually recaptured its position as the world's biggest producer and exporter of raw silk and silk yam. Today, around 126,000 metric tons of silk are produced in the world, and almost two thirds of that production takes place in China.
32	76	Great Migrations	Animal migration, however it is defined, is far more than just the movement of animals. It can loosely be described as travel that takes place at regular intervals - often in an annual cycle - that may involve many members of a species, and is rewarded only after a long journey. It suggests inherited instinct. The biologist Hugh Dingle has\n\nidentified five characteristics that apply, in varying degrees and combinations, to all migrations. They are prolonged movements that carry animals outside familiar habitats; they tend to be linear, not zigzaggy; they involve special behaviours concerning\n\npreparation (such as overfeeding) and arrival; they demand special allocations of energy. And one more: migrating animals maintain an intense attentiveness to the greater mission, which keeps them undistracted by temptations and undeterred by challenges that would turn other animals aside.\n\nAn arctic tern, 0n its 20,000 km flight from the extreme south of South America to the Arctic circle, will take no notice of a nice smelly herring offered from a bird-watcher's boat along the way. While local gulls will dive voraciously for such handouts, the tern flies on. Why? The arctic tern resists distraction because it is driven at that moment by an instinctive sense of something we humans find admirable: larger purpose. In other words, it is determined to reach its destination. The bird senses that it can eat, rest and mate later. Right now it is totally focused on the journey; its undivided intent is arrival. Reaching some gravelly coastline in the Arctic, upon which other arctic terns have converged, will serve its larger purpose as shaped by evolution: finding a place, a time, and a set of circumstances in which it can successfully hatch and rear offspring.\n\nBut migration is a complex issue, and biologists define it differently, depending in part on what sorts of animals they study. Joel Berger, of the University of Montana,\n\nwho works on the American pronghorn and other large terrestrial mammals, prefers what he calls a simple, practical definition suited to his beasts: 'movements from a seasonal home area away to another\n\nhome area and back again'. Generally the reason for such seasonal back-and-forth movement is to seek resources that aren't available within a single area year-round.\n\nBut daily vertical movements by zooplankton in the ocean - upward by night to seek food, downward by day to escape predators - can also be considered migration. So can the movement of aphids when, having depleted the young leaves on one food plant, their offspring then fly onward to a different host plant, with no one aphid ever returning to where it started.\n\nDingle is an evolutionary biologist who studies insects. His definition is more intricate than Berger's, citing those five features that distinguish migration from other forms of movement. They allow for the fact that, for example, aphids will become sensitive to blue light (from the sky) when it's time for takeoff on their big journey, and sensitive to yellow light (reflected from tender young leaves) when it's appropriate to land. Birds will fatten themselves with heavy feeding in advance of a long migrational flight. The value of his definition. Dingle argues, is that it focuses attention on what the phenomenon of wildebeest migration shares with the phenomenon of the aphids. and therefore helps guide researchers towards understanding how evolution has produced them all.\n\nHuman behaviour, however, is having a detrimental impact on animal migration. The pronghorn, which resembles an antelope, though they are unrelated, is the fastest land mammal of the New World. One population, which spends the summer in the mountainous Grand Teton\n\nNational Park of the western USA, follows a narrow route from its summer range in the mountains, across a river, and down onto the plains. Here they wait out the frozen months, feeding mainly on sagebrush\n\nblown clear of snow. These pronghorn are notable for the invariance of their migration route and the severity of its constriction at three bottlenecks. If they can't pass through each of the three during their spring migration, they can't reach their bounty of summer grazing; if they can't pass through again in autumn. escaping south onto those windblown plains. they are likely to die trying to overwinter in the deep snow. Pronghorn. dependent on distance vision and speed to keep safe from predators, traverse high, open shoulders of land, where they can see and run. At one of the bottlenecks, forested hills rise to form a V, leaving a corridor of open ground only about 150 metres wide, filled with private homes. Increasing development is leading toward a crisis for the pronghorn, threatening to choke off their passageway.\n\nConservation scientists, along with some biologists and land managers within the USA's National Park Service and other agencies, are now working to preserve migrational behaviours, not just species and habitats. A National Forest has recognised the path of the pronghorn. much of which passes across its land, as a protected migration corridor. But neither the Forest Service nor the Park Service can control what happens on private land at a bottleneck. And with certain other migrating species, the challenge is complicated further - by vastly greater distances traversed, more jurisdictions, more borders, more dangers along the way. We will require wisdom and resoluteness to\n\nensure that migrating species can continue their journeying a while longer.
33	77	The math mystery: Intuition and beauty in mathematics	Preface to 'How the other half thinks: Adventures in mathematical reasoning'\n\nA Occasionally, in some difficult musical compositions, there are beautiful, but easy parts - parts so simple a beginner could play them. So it is with mathematics as well. There are some discoveries in advanced mathematics that do not depend on specialized knowledge, not even on algebra, geometry, or trigonometry. Instead they may involve, at most, a little arithmetic, such as 'the sum of two odd numbers is even', and common sense. Each of the eight chapters in this book illustrates this phenomenon. Anyone can understand every step in the reasoning.\n\nThe thinking in each chapter uses at most only elementary arithmetic, and sometimes not even that. Thus all readers will have the chance to participate in a mathematical experience, to appreciate the beauty of mathematics, and to become familiar with its logical, yet intuitive, style of thinking.\n\nB One of my purposes in writing this book is to give readers who haven't had the opportunity to see and enjoy real mathematics the chance to appreciate the mathematical way of thinking. I want to reveal not only some of the fascinating discoveries, but, more importantly, the reasoning behind them.\n\nIn that respect, this book differs from most books on mathematics written for the general public. Some present the lives of colorful mathematicians. Others describe important applications of mathematics. Yet others go into mathematical procedures, but assume that the reader is adept in using algebra.\n\nC I hope this book will help bridge that notorious gap that separates the two cultures: the humanities and the sciences, or should I say the right brain (intuitive) and the left brain (analytical, numerical). As the chapters will illustrate, mathematics is not restricted to the analytical and numerical; intuition plays a significant role. The\n\nalleged gap can be narrowed or completely overcome by anyone,. in part because each of us is far from using the full capacity of either side of the brain. To illustrate our human potential, I cite a structural engineer who is an artist, an electrical engineer who is an opera singer, an opera singer who published mathematical research, and a mathematician who publishes short stories.\n\nD Other scientists have written books to explain their fields to non-scientists, but have necessarily had to omit the mathematics, although it provides the foundation of their theories. The reader must remain a tantalized spectator rather than an involved participant. since the appropriate language for describing the details in much of science is mathematics, whether the subject is expanding universe, subatomic particles, or chromosomes. Though the broad outline of a scientific theory can be sketched intuitively, when a part of the physical universe is finally understood, its description often looks like a page in a mathematics text.\n\nE Still, the non-mathematical reader can go far in understanding mathematical reasoning. This book presents the details that illustrate the mathematical style of thinking, which involves sustained, step-by-step analysis, experiments, and insights. You will turn these pages much more slowly than when reading a novel or a newspaper. It may help to have a pencil and paper ready to check claims and carry out experiments.\n\nF As I wrote, I kept in mind two types of readers: those who enjoyed mathematics until they were turned off by an unpleasant episode, usually around fifth grade, and mathematics aficionados, who will find much that is new throughout the book. This book also serves readers who simply want to sharpen their analytical skills. Many careers, such as law and medicine, require extended, precise analysis. Each chapter offers practice in following a sustained and closely argued line of thought. That mathematics can develop this skill is shown by these two testimonials:\n\nG A physician wrote, The discipline of analytical thought processes [in mathematics] prepared me extremely well for medical school. In medicine one is faced with a problem which must be thoroughly analyzed before a solution can be found. The process is similar to doing mathematics.'\n\nA lawyer made the same point, 'Although I had no background in law - not even one political science course - I did well at one of the best law schools. I attribute much of my success there to having learned, through the study of mathematics, and, in particular, theorems, how to analyze complicated principles. Lawyers who have studied mathematics can master the legal principles in a way that most others cannot.'\n\nI hope you will share my delight in watching as simple, even na"ive, questions lead to remarkable solutions and purely theoretical discoveries find unanticipated applications.
34	82	Research using twins	To biomedical researchers all over the world, twins offer a precious opportunity to untangle the influence of genes and the environment - of nature and nurture. Because identical twins come from a single fertilized egg that splits into two, they share virtually the same genetic code. Any differences between them - one twin having younger looking skin, for example - must be due to environmental\n\nfactors such as less time spent in the sun. Alternatively, by comparing the experiences of identical twins with those of fraternal twins, who come from separate eggs and share on average half their DNA, researchers can quantify the extent to which our genes affect our lives. If identical twins are more similar to each other with respect to an ailment than fraternal twins are, then vulnerability to the disease must be rooted at least in part in heredity.\n\nThese two lines of research - studying the differences between identical twins to pinpoint the influence of environment, and comparing identical twins with fraternal ones to measure the role of inheritance - have been crucial to understanding the interplay of nature and nurture in determining our personalities, behavior, and vulnerability to disease. The idea of using twins to measure the influence of heredity dates back to 1875, when the English scientist Francis Galton first suggested the approach (and coined the phrase 'nature and nurture'). But twin studies took a surprising twist in the 1980s, with the arrival of studies into identical twins who had been separated at birth and reunited as adults. Over two decades 137 sets of twins eventually visited Thomas Bouchard's lab in what became known as the Minnesota Study of Twins Reared Apart. Numerous tests were carried out on the twins, and they were each asked more than 15,000 questions.\n\nBouchard and his colleagues used this mountain of data to identify how far twins were affected by their genetic makeup. The key to their approach was a statistical concept called heritability.\n\nIn broad terms, the heritability of a trait measures the extent to which differences among members of a population can be explained by differences in their genetics. And wherever Bouchard and other scientists looked, it seemed, they found the invisible hand of genetic influence helping to shape our lives.\n\nLately, however, twin studies have helped lead scientists to a radical new conclusion: that nature and nurture are not the only elemental forces at work. According to a recent field called epigenetics, there is a third factor also in play, one that in some cases serves as a bridge between the environment and our genes, and in others operates on its own to shape who we are.\n\nEpigenetic processes are chemical reactions tied to neither nature nor nurture but representing what researchers have called a 'third component'. These reactions influence how our genetic code is expressed: how each gene is strengthened or weakened, even turned on or off, to build our bones, brains and all the other parts of our bodies.\n\nIf you think of our DNA as an immense piano keyboard and our genes as the keys each key symbolizing a segment of DNA responsible for a particular note, or trait, and all the keys combining to make us who we are - then epigenetic processes determine when and how each key can be struck, changing the tune being played.\n\nOne way the study of epigenetics is revolutionizing our understanding of biology is by revealing a mechanism by which the environment directly impacts on genes. Studies of animals, for example, have shown that when a rat experiences stress during pregnancy, it can cause epigenetic changes in a fetus that lead to behavioral problems as the rodent grows up. Other epigenetic processes appear to\n\noccur randomly, while others are normal, such as those that guide embryonic cells as they become heart, brain, or liver cells, for example. Geneticist Danielle Reed has worked with many twins over the years and thought deeply about what twin studies have taught us. 'It's very clear when you look at twins that much of what they share is hardwired,' she says. 'Many things about them are absolutely the same and unalterable. But it's also clear, when you get to know them, that other things about them are different. Epigenetics is the origin of a lot of those differences, in my view.'\n\nReed credits Thomas Bouchard's work for today's surge in twin studies. 'He was the trailblazer.' she says. 'We forget that 50 years ago things like heart disease were thought to be caused entirely by lifestyle. Schizophrenia was thought to be due to poor mothering. Twin studies have allowed us to be more reflective about what people are actually born with and what's caused by experience.'\n\nHaving said that, Reed adds, the latest work in epigenetics promises to take our understanding even further. 'What I like to say is that nature writes some things in pencil and some things in pen.' she says. 'Things written in pen you can't change. That's DNA But things written in pencil you can. That's epigenetics. Now that we're actually able to look at the DNA and see where the pencil writings are, it's sort of a whole new world.'
35	83	An Introduction to Film Sound	Though we might think of film as an essentially visual experience, we really cannot afford to underestimate the importance of film sound. A meaningful sound track is often as complicated as the image on the screen, and is ultimately just as much the responsibility of the director. The entire sound track consists of three essential ingredients: the human voice, sound effects and music. These three tracks must be mixed and balanced so as to produce the necessary emphases which in turn create desired effects. Topics which essentially refer to the three previously mentioned tracks are discussed below. They include dialogue, synchronous and asynchronous sound effects, and music.\n\nLet us start with dialogue. As is the case with stage drama, dialogue serves to tell the story and expresses feelings and motivations of characters as well. Often with film charaeterization the audience perceives little or no difference between the character and the actor. Thus, for example, the actor Humphrey Bogart is the character Sam Spade; film personality and life personality seem to merge. Perhaps this is because the very texture of a performer's voice supplies an element of character.\n\nWhen voice textures fit the performer's physiognomy and gestures, a whole and very realistic persona emerges. The viewer sees not an actor working at his craft, but another human being struggling with life. It is interesting to note that how dialogue is used and the very amount of dialogue used varies widely among films. For example, in the highly successful science-fiction film 2001, little dialogue was evident, and most of it was banal and of little intrinsic interest. In this way the film-maker was able to portray what Thomas Sobochack and Vivian Sobochack call, in An Introduction to Film, the 'inadequacy of human responses when compared with the magnificent technology created by man and the visual beauties of the universe'.\n\nThe comedy Bringing Up Baby, on the other hand, presents practically non-stop dialogue delivered at breakneck speed. This use of dialogue underscores not only the dizzy quality of the character played by Katherine Hepburn, but also the absurdity of the film itself and thus its humor. The audience is bounced from gag to gag and conversation to conversation; there is no time for audience reflection. The audience is caught up in a whirlwind of activity in simply managing to follow the plot. This film presents pure escapism largely due to its frenetic dialogue.\n\nSynchronous sound effects are those sounds which are synchronized or matched with what is viewed. For example, if the film portrays a character playing the piano, the sounds of the piano are projected. Synchronous sounds contribute to the realism of film and also help to create a particular atmosphere. For example, the 'click' of a door being opened may simply serve to convince the audience that the image portrayed is real, and the audience may only subconsciously note the expected sound. However, if the 'click' of an opening door is part of an ominous action such as a burglary, the sound mixer may call attention to the 'click' with an increase in volume; this helps to engage the audience in a moment of suspense.\n\nAsynchronous sound effects, on the other hand, are not matched with a visible source of the sound on screen. Such sounds are included so as to provide an\n\nappropriate emotional nuance, and they may also add to the realism of the film. For example, a film-maker might opt to include the background sound of an ambulance's siren while the foreground sound and image portrays an arguing couple. The asynchronous ambulance siren underscores the psychic injury incurred in the argument; at the same time the noise of the siren adds to the realism of the film by acknowledging the film's city setting. We are probably all familiar with background music in films, which has become so ubiquitous as to be noticeable in its absence. We are aware that it is used to add emotion and rhythm. Usually not meant to be noticeable, it often provides a tone or an emotional attitude toward the story and/or the characters depicted. In addition, background music often foreshadows a change in mood. For example, dissonant music may be used in film to indicate an approaching (but not yet visible) menace or disaster.\n\nBackground music may aid viewer understanding by linking scenes. For example, a particular musical theme associated with an individual character or situation may be repeated at various points in a film in order to remind the audience of salient motifs or ideas.\n\nFilm sound comprises conventions and innovations. We have come to expect an acceleration of music during car chases and creaky doors in horror films. Yet, it is important to note as well that sound is often brilliantly conceived. The effects of sound are often largely subtle and often are noted by only our subconscious minds. We need to foster an awareness of\n\nfilm sound as well as film space so as to truly appreciate an art form that sprang to life during the twentieth century - the modem film.
36	84	This Marvellous Invention	Even silence can be meaningful vi Why language is the most important invention of all vii The universal ability to use language\n\n**Paragraph A**\n\n**Paragraph B**\n\n**Paragraph C**\n\n**Paragraph D**\n\n**Paragraph E**\n\n**Paragraph F**\n\nl>.!I.:,j {!:-'.>" uIY-1 uj .JI> 'This Marvellous Invention'\n\nA Of all mankind's manifold creations, language must take pride of place. Other inventions - the wheel, agriculture, sliced bread - may have transformed our material existence, but the advent of language is what made us human. Compared to language, all other inventions pale in significance, since everything we have ever achieved depends on language and originates from it. Without language, we could never have embarked on our ascent to unparalleled power over all other animals, and even over nature itself.\n\nB But language is foremost not just because it came first. In its own right it is a tool of extraordinary sophistication, yet based on an idea of ingenious simplicity: 'this marvellous invention of composing out of twenty-five or thirty sounds that infinite variety of expressions which, whilst having in themselves no likeness to what is in our mind, allow us to disclose to others its whole secret, and to make known to those who cannot penetrate it all that we imagine, and all the various stirrings of our soul'. This was how, in 1660, the renowned French grammarians of the Port-Royal abbey near Versailles distilled the essence of language, and no one since has celebrated more eloquently the magnitude of its achievement. Even so, there is just one flaw in all these hymns of praise, for the homage to language's unique accomplishment conceals a simple yet critical incongruity. Language is mankind's greatest invention - except, of course, that it was never invented. This apparent paradox is at the core of our fascination with language, and it holds many of its secrets.\n\nC Language often seems so skillfully drafted that one can hardly imagine it as anything other than the perfected handiwork of a master craftsman. How else could this instrument make so much out of barely three dozen measly morsels of sound? In themselves, these configurations of mouth - p,f,b, v,t,d,k,g,sh,a,e and so on - amount to nothing more than a few haphazard spits and splutters, random noises with no meaning, no ability to express, no power to explain. But run them through the cogs and wheels of the language machine, let it arrange them in some very special orders, and there is nothing that these meaningless streams of air cannot do: from sighing the interminable boredom of existence to unravelling the fundamental order of the universe.\n\nO The most extraordinary thing about language, however, is that one doesn't have to be a genius to set its wheels in motion. The language machine allows just about everybody - from pre-modern foragers in the subtropical savannah, to post-modern philosophers in the suburban sprawl - to tie these meaningless sounds together into an infinite variety of subtle senses, and all apparently without the slightest exertion. Yet it is precisely this deceptive ease\n\nwhich makes language a victim of its own success, since in everyday life its triumphs are usually taken for granted. The wheels of language run so smoothly that one rarely bothers to stop and think about all the resourcefulness and expertise that must have gone into making it tick. Language conceals art. mu.v...,o-.\n\n1rLanguagc-\n\n**Section E**\n\nF Often, it is only the estrangement of foreign tongues, with their many exotic and outlandish features, that brings home the wonder of language's design. One of the showiest stunts that some languages can pull off is an ability to build up words of breath-breaking length, and thus express in one word what English takes a whole sentence to say. The Turkish word fehirlili?tiremediklerimizdensiniz, to take one example, means nothing less than 'you are one of those whom we can't turn into a town-dweller'. (In case you were wondering. this monstrosity really is one word, not merely many different words squashed together - most of its components cannot even stand up on their own.)\n\nAnd if that sounds like some one-off freak, then consider Sumerian, the language spoken on the banks of the Euphrates some 5,000 years ago by the people who invented writing and thus enabled the documentation of history. A Sumerian word like munintumaa ('when he had made it suitable for her') might seem rather trim compared to the Turkish colossus above. What is so impressive about it, however, is not its lengthiness but rather the reverse the thrifty compactness of its construction. The word is made up of different slots, each corresponding to a particular portion of meaning. This sleek design allows single sounds\n\nto convey useful information, and in fact even the absence of a sound has been enlisted to express something specific. If you were to ask which bit in the Sumerian word corresponds to the pronoun 'it' in the English translation 'when he had made it suitable for her: then the answer would have to be nothing. Mind you, a very particular kind of nothing: the nothing that stands in the empty slot in the middle. The technology is so fine-tuned then that even a non-sound, when carefully placed in a particular position, has been invested with a specific function. Who coul.d possibly have come up with such a nifty contraption?\n\nul>.!I Qj E-' JD
56	132	How baby talk gives infant brains a boost	ow baby talk gives infant brains a boost\n\nThe typical way of talking to a baby - high-pitched, exaggerated and repetitious - is a source of fascination for linguists who hope to understand how 'baby talk' impacts on learning. Most babies start developing their hearing while still in the womb, prompting some hopeful parents to play classical music to their pregnant bellies. Some research even suggests that infants are listening to adult speech as early as 10 weeks before being born, gathering the basic building blocks of their family's native tongue.\n\nEarly language exposure seems to have benefits to the brain - for instance, studies suggest that babies raised in bilingual homes are better at learning how to mentally prioritize information. So how does the sweet if sometimes absurd sound of infant- directed speech influence a baby's development? Here are some recent studies that explore the science behind baby talk.\n\nFathers don't use baby talk as often or in the same ways as mothers - and that's perfectly 0K, according to a new study. Mark VanDam of Washington State University at Spokane and colleagues equipped parents with recording devices and speech-recognition software to study the way they interacted with their youngsters during a normal day. 'We found that moms do exactly what you'd expect and what's been described many times over,' VanDam explains. 'But we found that dads aren't doing the same thing. Dads didn't raise their pitch or fundamental frequency when they talked to kids.' Their role may be rooted in what is called the bridge hypothesis, which dates back to 1975. It suggests that fathers use less familial language to provide their children with a bridge to the kind of speech they'll hear in public. 'The idea is that a kid gets to practice a certain kind of speech with mom and another kind of speech with dad, so the kid then has a wider repertoire of kinds of speech to practice,' says VanDam.\n\nScientists from the University of Washington and the University of Connecticut collected thousands of 30-second conversations between parents and their babies, fitting 26 children with audio-recording vests that captured language and sound during a typical eight-hour day. The study found that the more baby talk parents used, the more their youngsters began to babble. And when researchers saw the same babies at age two, they found that frequent baby talk had dramatically boosted vocabulary, regardless of socioeconomic status. 'Those children who listened to a lot of baby talk were talking more than the babies that listened to more\n\n**Section E**\n\nF adult talk or standard speech,' says Nairån Ramirez-Esparza of the University of Connecticut. 'We also found that it really matters whether you use baby talk in a one-on-one context,' she adds. 'The more parents use baby talk one-on-one, the more babies babble, and the more they babble, the more words they produce later in life.'\n\nAnother study suggests that parents might want to pair their youngsters up so they can babble more with their own kind. Researchers from McGill University and Université du Québec å Montréal found that babies seem to like listening to each other rather than to adults - which may be why baby talk is such a universal tool among parents. They played repeating vowel sounds made by a special synthesizing device that mimicked sounds made by either an adult woman or another baby. This way, only the impact of the auditory cues was observed. The team then measured how long each type of sound held the infants' attention. They found that the 'infant' sounds held babies' attention nearly 40 percent longer. The baby noises also induced more reactions in the listening infants, like smiling or lip moving, which approximates sound making. The team theorizes that this attraction to other infant sounds could help launch the learning process that leads to speech. 'It may be some property of the sound that is just drawing their attention,' says study co-author Linda Polka. 'Or maybe they are really interested in that particular type of sound because they are starting to focus on their own ability to make sounds. We are speculating here but it might catch their attention because they recognize it as a sound they could possibly make.'\n\nIn a study published in Proceedings of the National Academy of Sciences, a total of 57 babies from two slightly different age groups - seven months and eleven and a half months - were played a number of syllables from both their native language (English) and a non-native tongue (Spanish). The infants were placed in a brain- activation scanner that recorded activity in a brain region known to guide the motor movements that produce speech. The results suggest that listening to baby talk prompts infant brains to start practicing their language skills. 'Finding activation in motor areas of the brain when infants are simply listening is significant, because it means the baby brain is engaged in trying to talk back right from the start, and suggests that seven-month-olds' brains are already trying to figure out how to make the right movements that will produce words,' says co-author Patricia Kuhl. Another interesting finding was that while the seven-month-olds responded to all speech sounds regardless of language, the brains of the older infants worked harder at the motor activations of non-native sounds compared to native sounds. The study may have also uncovered a process by which babies recognize differences between their native language and other tongues.
57	133	Whatever happened to the Harappan Civilisation?	New research sheds light on the disappearance of an ancient society\n\nThe Harappan Civilisation of ancient Pakistan and India flourished 5,000 years ago, but a thousand years later their cities were abandoned. The Harappan Civilisation was a sophisticated Bronze Age society who built 'megacities' and traded internationally in luxury craft products, and yet seemed to have left almost no depictions of themselves. But their lack of self-imagery - at a time when the Egyptians were carving and painting representations of themselves all over their temples - is only part of the mystery.\n\n'There is plenty of archaeological evidence to tell us about the rise of the Harappan Civilisation, but relatively little about its fall,' explains archaeologist Dr Cameron Petrie of the University of Cambridge. 'As populations increased, cities were built that had great baths, craft workshops, palaces and halls laid out in distinct sectors. Houses were arranged in blocks, with wide main streets and narrow alleyways, and many had their own wells and drainage systems. It was very much a "thriving" civilisation.' Then around 2100 BC, a transformation began. Streets went uncleaned, buildings started to be abandoned, and ritual structures fell out of use. After their final demise, a millennium passed before really large-scale cities appeared once more in South Asia.\n\nSome have claimed that major glacier-fed rivers changed their course, dramatically affecting the water supply and agriculture; or that the cities could not cope with an increasing population, they exhausted their resource base, the trading economy broke down or they succumbed to invasion and conflict; and yet others that climate change caused an environmental change that affected food and water provision. 'It is unlikely that there was a single cause for the decline of the civilisation. But the fact is, until now, we have had little solid evidence from the area for most of the key elements,' said Petrie. A lot of the archaeological debate has really only been well- argued speculation.'\n\nA research team led by Petrie, together with Dr Ravindanath Singh of Banaras Hindu University in India, found early in their investigations that many of the archaeological sites were not where they were supposed to be, completely altering understanding of the way that this region was inhabited in the past. When they carried out a survey of how the larger area was settled in relation to sources of water, they found inaccuracies in the published geographic locations of ancient settlements ranging from several hundred metres to many kilometres. They realised\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH that any attempts to use the existing data were likely to be fundamentally flawed. Over the course of several seasons of fieldwork they carried out new surveys, finding an astonishing 198 settlement sites that were previously unknown.\n\nNow, research published by Dr Yama Dixit and Professor David Hodell, both from Cambridge's Department of Earth Sciences, has provided the first definitive evidence for climate change affecting the plains of north-western India, where hundreds of Harappan sites are known to have been situated. The researchers gathered shells of Melanoides tuberculata snails from the sediments of an ancient lake and used geochemical analysis as a means of tracing the climate history of the region. 'As today, the major source of water into the lake is likely to have been the summer monsoon,' says Dixit. 'But we have observed that there was an abrupt change about 4,100 years ago, when the amount of evaporation from the lake exceeded the rainfall - indicative of a drought.' Hodell adds: 'We estimate that the weakening of the Indian summer monsoon climate lasted about 200 years before recovering to the previous conditions, which we still see today.'\n\nIt has long been thought that other great Bronze Age civilisations also declined at a similar time, with a global-scale climate event being seen as the cause. While it is possible that these local-scale processes were linked, the real archaeological interest lies in understanding the impact of these larger-scale events on different environments and different populations. 'Considering the vast area of the Harappan Civilisation with its variable weather systems,' explains Singh, 'it is essential that we obtain more climate data from areas close to the two great cities at Mohenjodaro and Harappa and also from the Indian Punjab.'\n\nPetrie and Singh's team is now examining archaeological records and trying to understand details of how people led their lives in the region five millennia ago. They are analysing grains cultivated at the time, and trying to work out whether they were grown under extreme conditions of water stress, and whether they were adjusting the combinations of crops they were growing for different weather systems. They are also looking at whether the types of pottery used, and other aspects of their material culture, were distinctive to specific regions or were more similar across larger areas. This gives us insight into the types of interactive networks that the population was involved in, and whether those changed.\n\nPetrie believes that archaeologists are in a unique position to investigate how past societies responded to environmental and climatic change. 'By investigating responses to environmental pressures and threats, we can learn from the past to engage with the public, and the relevant governmental and administrative bodies, to be more proactive in issues such as the management and administration of water supply, the balance of urban and rural development, and the importance of preserving cultural heritage in the future.'
58	138	Cutty Sark: The fastest sailing ship of all time	The nineteenth century was a period of great technological development in Britain, and for shipping the major changes were from wind to steam power, and from wood to iron and steel.\n\nThe fastest commercial sailing vessels of all time were clippers, three-masted ships built to transport goods around the world. although some also took passengers. From the 1840s until 1869, when the Suez Canal opened and steam propulsion was replacing sail, clippers dominated world trade. Although many were built, only one has survived more or less intact: Cutty Sark, now on display in (ireenwich, southeast London.\n\nCutty Sark's unusual name comes from the poem Tam O 'Shanter by the Scottish poet Robert Burns. Tam. a farmer, is chased by a witch called Nannie, who is wearing a 'cutty sark' - an old Scottish name tor a short nightdress. The witch is depicted in Cutty Sark's figurehead - the carving ofa woman typically at the front of old sailing ships. In legend, and in Burns's poem, witches cannot cross water, so this was a rather strange choice of name for a ship.\n\nCutty Sark was built in Dumbarton, Scotland. in 1 869, for a shipping company owned by John Willis. To carry out construction. Willis chose a new shipbuilding firm, Scott & Linton, and ensured that the contract with them put him in a very strong position. In the end, the firm was forced out of business. and the ship was finished by a competitor.\n\nWillis's company "as active in the tea trade between China and Britain, where speed could bring shipowners both profits and prestige, so Cutty Sark was designed to make the journey more quickly than any other ship. On her maiden voyage, in 1870, she set sail from London, carrying large amounts of goods to China. She returned laden with tea, making the journey back to London in four months. However, Cutty Sark never lived up to the high expectations of her owner, as a result of bad winds and various misfortunes. On one occasion, in 1872, the ship and a rival clipper. Thermopylae, left port in China on the same day. Crossing the Indian Ocean, Cutty Sark gained a lead of over 400 miles, but then her rudder was severely damaged in stormy seas. making her impossible to steer. The ship's crew had the daunting task of repairing the rudder at sea. and only succeeded at the second attempt. Cutty Sark reached London a week after Thermopylae.\n\nSteam ships posed a growing threat to clippers, as their speed and cargo capacity increased. In addition, the opening of the Suez Canal in 1869, the same year that Cutty Sark was launched, had a serious impact. While steam ships could make use of the quick, direct route between the Mediterranean and the Red Sea, the canal was of no use to sailing ships, which needed the much stronger winds of the oceans. and so had to sail a far greater distance. Steam ships reduced the journey time between Britain and China by approximately two months.\n\nBy 1878, tea traders weren't interested in Cutty Sark. and instead, she took on the much less prestigious work of carrying any cargo between any two ports in the world. In 1880, violence aboard the ship led ultimately to the replacement of the captain with an incompetent drunkard who stole the crew's wages. He was suspended from service, and a new captain appointed. This marked a turnaround and the beginning of the most successful period in Cutty Sark's working life. transporting wool from Australia to Britain. One such journey took just under 12 weeks, beating every other ship sailing that year by around a month.\n\nThe ship's next captain, Richard Woodget. was an excellent navigator. who got the best out of both his ship and his crew. As a sailing ship, Cutty Sark depended on the strong trade winds of the southern hemisphere, and Woodget took her further south than any previous captain, bringing her dangerously close to icebergs off the southern tip of South America. His gamble paid off, though, and the ship was the fastest vessel in the wool trade for ten years.\n\nAs competition from steam ships increased in the 1890s, and Cutty Sark approached the end of her life expectancy. she became less profitable. She was sold to a Portuguese firm, which renamed her Ferreira. For the next 25 years, she again carried miscellaneous cargoes around the world.\n\nBadly damaged in a gale in 1922, she was put into Falmouth harbour in southwest England, for repairs. Wilfred Dowman, a retired sea captain who owned a training vessel, recognised her and tried to buy her, but without success. She returned to Portugal and was sold to another Portuguese company. Dowman was determined, however, and offered a high price: this " as accepted, and the ship returned to Falmouth the following year and had her original name restored.\n\nDowman used Cutty Sark as a training ship, and she continued in this role after his death. When she was no longer required, in 1954, she was transferred to dry dock at Greenwich to go on public display. The ship suffered from fire in 2007, and again, less seriously, in 2014, but now Cutty Sark attracts a quarter ofa million visitors a year.
59	139	Saving the soil	More than a third of the Earth's top layer is at risk. Is there hope for our planet's most precious resource?\n\nMore than a third of the world's soil is endangered, according to a recent UN report. If we don't slow the decline, all farmable soil could be gone in 60 years. Since soil grows 95% of our food, and sustains human life in other more surprising ways, that is a huge problem.\n\nPeter Groffman, from the Cary Institute of Ecosystem Studies in New York, points out that soil scientists have been warning about the degradation of the world's soil for decades. At the same time, our understanding of its importance to humans has grown. A single gram of healthy soil might contain 100 million bacteria, as well as other microorganisms such as viruses and fungi, living amid decomposing plants and various minerals.\n\nThat means soils do not just grow our food, but are the source of nearly all our existing antibiotics, and could be our best hope in the fight against antibiotic- resistant bacteria. Soil is also an ally against climate change: as microorganisms within soil digest dead animals and plants, they lock in their carbon content, holding three times the amount of carbon as does the entire atmosphere. Soils also store water, preventing flood damage: in the UK, damage to buildings, roads and bridges from floods caused by soil degradation costs E233 million every year.\n\nIf the soil loses its ability to perform these functions, the human race could be in big trouble. The danger is not that the soil will disappear completely, but that the microorganisms that give it its special properties will be lost. And once this has happened, it may take the soil thousands of years to recover.\n\nAgriculture is by far the biggest problem. In the wild, when plants grow they remove nutrients from the soil, but then when the plants die and decay these nutrients are returned directly to the soil. Humans tend not to return unused parts of harvested crops directly to the soil to enrich it, meaning that the soil gradually becomes less fertile. In the past we developed strategies to get around the problem, such as regularly varying the types of crops grown, or leaving fields uncultivated for a season.\n\nBut these practices became inconvenient as populations grew and agriculture had to be run on more commercial lines. A solution came in the early 20th century with the Haber-Bosch process for manufacturing ammonium nitrate. Farmers have been putting this synthetic fertiliser on their fields ever since.\n\n**Section E**\n\n**Section F**\n\nG But over the past few decades, it has become clear this wasn't such a bright idea. Chemical fertilisers can release polluting nitrous oxide into the atmosphere and excess is often washed away with the rain, releasing nitrogen into rivers. More recently, we have found that indiscriminate use of fertilisers hurts the soil itself, turning it acidic and salty, and degrading the soil they are supposed to nourish.\n\nOne of the people looking for a solution to this problem is Pius Floris, who started out running a tree-care business in the Netherlands, and now advises some of the world's top soil scientists. He came to realise that the best way to ensure his trees flourished was to take care of the soil, and has developed a cocktail of beneficial bacteria, fungi and humus to do this. Researchers at the University of Valladolid in Spain recently used this cocktail on soils destroyed by years of fertiliser overuse. When they applied Floris's mix to the desert-like test plots, a good crop of plants emerged that were not just healthy at the surface, but had roots strong enough to pierce dirt as hard as rock. The few plants that grew in the control plots, fed with traditional fertilisers, were small and weak.\n\nHowever, measures like this are not enough to solve the global soil degradation problem. To assess our options on a global scale we first need an accurate picture of what types of soil are out there, and the problems they face. That's not easy. For one thing, there is no agreed international system for classifying soil. In an attempt to unify the different approaches, the IJN has created the Global Soil Map project. Researchers from nine countries are working together to create a map linked to a database that can be fed measurements from field surveys, drone surveys, satellite imagery, lab analyses and so on to provide real-time data on the state of the soil. Within the next four years, they aim to have mapped soils worldwide to a depth Of 100 metres, with the results freely accessible to all.\n\nBut this is only a first step. We need ways of presenting the problem that bring it home to governments and the wider public, says Pamela Chasek at the International Institute for Sustainable Development, in Winnipeg, Canada. 'Most scientists don't speak language that policy-makers can understand, and vice versa.' Chasek and her colleagues have proposed a goal of 'zero net land degradation'. Like the idea of carbon neutrality, it is an easily understood target that can help shape expectations and encourage action.\n\nFor soils on the brink, that may be too late. Several researchers are agitating for the immediate creation of protected zones for endangered soils. One diffiCUltY here is defining what these areas should conserve: areas where the greatest soil diversity is present? Or areas Of unspoilt soils that could act as a future benchmark of quality?\n\nWhatever we do, if we want our soils to survive, we need to take action now
60	140	Book Review: The Happiness Industry	The Happiness Industry: How the Government and Big Business Sold Us Well-Being\n\nBy William Davies\n\n'Happiness is the ultimate goal because it is self-evidently good. If we are asked why happiness matters we can give no further external reason. It just obviously does matter.' This pronouncement by Richard Layard, an economist and advocate of 'positive psychology', summarises the beliefs of many people today. For Layard and others like him, it is obvious that the purpose of government is to promote a state of collective well-being. The only question is how to achieve it, and here positive psychology - a supposed science that not only identifies what makes people happy but also allows their happiness to be measured - can show the way. Equipped with this science, they say, governments can secure happiness in society in a way they never could in the past.\n\nIt is an astonishingly crude and simple-minded way of thinking, and for that very reason increasingly popular. Those who think in this way are oblivious to the vast philosophical literature in which the meaning and value of happiness have been explored and questioned, and write as if nothing of any importance had been thought on the subject until it came to their attention. It was the philosopher Jeremy Bentham (1748-1832) who was more than anyone else responsible for the development of this way of thinking. For Bentham it was obvious that the human good consists of pleasure and the absence of pain. The Greek philosopher Aristotle may have identified happiness with self-realisation in the 4th century BC, and thinkers throughout the ages may have struggled to reconcile the pursuit of happiness with other human values, but for Bentham all this was mere metaphysics or fiction. Without knowing anything much of him or the school of moral theory he established - since they are by education and intellectual conviction illiterate in the history of ideas - our advocates of positive psychology follow in his tracks in rejecting as outmoded and irrelevant pretty much the entirety of ethical reflection on human happiness to date.\n\nBut as William Davies notes in his recent book The Happiness Industry, the view that happiness is the only self-evident good is actually a way of limiting moral inquiry. One of the virtues of this rich, lucid and arresting book is that it places the current cult of happiness in a well-defined historical framework. Rightly, Davies begins his story with Bentham, noting that he was far more than a philosopher. Davies writes, 'Bentham's activities were those which we might now associate with a public sector management consultant'. In the 1790s, he wrote to the Home Office suggesting that the departments of government be linked together through a set of 'conversation tubes' and to the Bank of England with a design for a printing device that could produce unt otgeable banknotes, Ile dtvw up plans t'ot u t tigidariunv to Keep ptovisions tish. t ntit and vegetables t'tesh, I lis celebtatcd design tot' a pt ison to be known 'unopticon'\n\nin which ptisonets would be kept in solitary continetnent while being visible ot all tintes IO the guatxls, was very nearly adopted. (Suqwisingly, Davies does not discuss the I'nct that tneant his Panopticon not just as tuodcl prison but also us on instrutnent 01' control thot could applied to schools and factories.)\n\nBenthatn was also a pioneer of the science of happiness'. If happiness is to be legat(led as a science. it has to be tneasutvd. and Benthatn suggested two ways in which this Illight be done. Viewing happiness as a cotnplex of pleasurable sensations, he suggested that it Illight be quantified by tneasuting the hutnan pulse lilte. Altetnatively, tuoney could be usecl us the standard for quantification: if two ditrerent goods have the sante price. it can be claitnecl that they produce the satne quantity of pleasutv in the eons unwt Benthatn was tnore attmeted by the latter measure. By associating ntoney so closely to inner experience, I)avies writes, Benthntn set the stage for the entangling ot' psychological research and capitalistn that would shape the business practices of the twentieth century'.\n\nThe Ilappiness Industry describes how the pmject 01' a science of happiness has become integml to capitalistn. We learn much that is intetvsting about how econotnic problerns are being redetined and ttvated as psychological ntaladies. In addition, Davies shows how the belief that inner states of pleasutv and displeasutv can be objectively Ineasured has informed management studies and advertising. The tendency of thinkers such as J B Watson, the founder of behaviouristn was that hutnan beings could be shaped, or Inanipulated, by policymakers and managers. Watson had no factual basis for his view of human action. When he became president of the American Psychological Association in 1915, he 'had never even studied a single human being': his research had been conlined to experinwnts on white rats. Yet Watson's reductive model is now widely applied. with 'behaviour change' becotning the goal of governments: in Britain, a 'Behaviour Insights Teatn has been established by the governtnent to study how people can be encouraged, at tninitnutn cost to the public pulse, to live in what are considered to be socially desirable ways.\n\nModern industrial societies appear to need the possibility of ever-increasing happiness to motivate them in their labours. But whatever its intellectual pedigree. the idea that governments should be responsible for protnoting happiness is always a threat to human freedom.\n\n'behaviourism': a branch of psychology which is concornod with obsorvnblo behaviour
61	145	The Importance of Children's Play	Brick by brick, six-year-old Alice is building a magical kingdom. Imagining fairy-tale turrets and fire-breathing dragons, wicked witches and gallant heroes, creating an enchanting world. Although she isn 't aware of it, this fantasy is helping her take her first steps towards her capacity for creativity and so it will have important repercussions in her adult life.\n\nMinutes later, Alice has abandoned the kingdom in favour of playing schools with her younger brother. When she bosses him around as his 'teacher', shek practising how to regulate her emotions through pretence. Later on, when they tire of this and settle down with a board game, Shes learning about the need to follow rules and take turns with a partner.\n\n'Play in all its rich variety is one of the highest achievements of the human species,' says Dr David Whitebread from the Faculty of Education at the University of Cambridge, UK. 'It underpins how we develop as intellectual, problem-solving adults and is crucial to our success as a highly adaptable species.'\n\nRecognising the importance ofplay is not new: over two millennia ago, the Greek philosopher Plato extolled its virtues as a means of developing skills for adult life, and ideas about play-based learning have been developing since the 1 9th century.\n\nBut we live in changing times, and Whitebread is mindful of a worldwide decline in play, pointing out that over half the people in the world now live in cities. 'The opportunities for free play, which I experienced almost every day of my childhood, are becoming increasingly scarce,' he says. Outdoor play is curtailed by perceptions of risk to do with traffic, as well as parents' increased wish to protect their children from being the victims of crime, and by the emphasis on 'earlier is better' which is leading to greater competition in academic learning and schools.\n\nInternational bodies like the United Nations and the European Union have begun to develop policies concerned with childrenk right to play, and to consider implications for leisure facilities and educational programmes. But what they often lack is the evidence to base policies on.\n\n'The type of play we are interested in is child-initiated, spontaneous and unpredictable - but, as soon as you ask a five-year-old "to play", then you as the researcher have intervenecL' explains Dr Sara Baker. 'And we want to know what the long-term impact of play is. Itk a real challenge.' Dr Jenny Gibson agrees, pointing out that although some Of the S in the puzzle of how and why play is important have been looked at, there is very little data o the impact it has on the child's later life.\n\nNow, thanks to the university's new Centre for Research on Play in Education, Development and Learning (PEDAL), Whitebread, Baker, Gibson and a team of researchers hope to provide evidence on the role played by play in how a child develops.\n\n'A strong possibility is that play supports the early development of Children's self-control,' explains Baker. 'This is our ability to develop awareness Ofour own thinking processes - it influences how effectively we go about undertaking challenging activities.,\n\nIn a study carried out by Baker with toddlers and young pre-schoolers' She found that children with greater self-control solved problems more quickly when exploring an Unfamiliar set-up requiring scientific reasoning. 'This sort of evidence makes us think that giving Children the chance to play will make them more successful problem-solvers in the long run.'\n\nIf playful experiences do facilitate this aspect of development' say the researchers, it could be extremely significant for educational practices, because the ability to Self-regulate has been shown to be a key predictor of academic performance.\n\nGibson adds: 'Playful behaviour is also an important indicator Of healthy social and emotional development. In my previous research, I investigated how observing Children at play can give us important clues about their well-being and can even be useful In the diagnosis of neurodevelopmental disorders like autism.'\n\nWhitebread's recent research has involved developing a play-based approach to supporting children's writing. 'Many primary school children find writing difficult, but we showed in a previous study that a playful stimulus was far more effective than an instructional one.' Children wrote longer and better-structured stories when they first played with dolls representing characters in the story. In the latest study, children first created their story, with Lego with similar results. 'Many teachers commented that they had always Previously had children saying they didn't know what to write about. With the Lego building' however, not a single child said this through the whole year of the project.'\n\nWhitebread, who directs PEDAL, trained as a primary school teacher in the early 1970s, when, as he describes, 'the teaching of young children was largely a quiet backwater, untroubled by any serious intellectual debate or controversy.' Now, the landscape is very different, with hotly debated topics such as school starting age.\n\n'Somehow the importance of play has been lost in recent decades It's regarded as something trivial, or even as something negative that contrasts with "work". Let's not lose sight ofits benefits, and the fundamental contributions it makes to human achievements in the arts, sciences and technology. Let's make sure children have a rich diet of play experiences., Lego: coloured plastic building blocks and other pieces that can be joined together Test I
62	146	The Growth of Bike-sharing Schemes	around the world\n\nHow Dutch engineer Luud Schimmelpennink helped to devise urban bike-sharing schemes\n\nThe original idea for an urban bike-sharing scheme dates back to a summer's day in Amsterdam in 1965. Provo, the organisation that came up with the idea, was a group of Dutch activists who wanted to change society. They believed the scheme, which was known as the Witte Fietsenplan, was an answer to the perceived threats of air pollution and consumerism. In the centre of Amsterdam, they painted a small number of used bikes white. They also distributed leaflets describing the dangers of cars and inviting people to use the white bikes. The bikes were then left unlocked at various locations around the city, to be used by anyone in need of transport.\n\nLuud Schimmelpennink, a Dutch industrial engineer who still lives and cycles in Amsterdam, was heavily involved in the original scheme. He recalls how the scheme succeeded in attracting a great deal of attention - particularly when it came to publicising Provo's aims - but struggled to get off the ground. The police were opposed to Provo's initiatives and almost as soon as the white bikes were distributed around the city, they removed them. However, for Schimmelpennink and for bike-sharing schemes in general, this was just the beginning. 'The first Witte Fietsenplan was just a symbolic thing,' he says. 'We painted a few bikes white, that was all. Things got more serious when I became a member of the Amsterdam city council two years later.'\n\nSchimmelpennink seized this opportunity to present a more elaborate Witte Fietsenplan to the city council. 'My idea was that the municipality of Amsterdam would distribute 10,000 white bikes over the city, for everyone to use,' he explains. 'l made serious calculations. It turned out that a white bicycle - per person, per kilometre - would cost the municipality only 10% of what it contributed to public transport per person per kilometre.' Nevertheless, the council unanimously rejected the plan. 'They said that the bicycle belongs to the past. They saw a glorious future for the car,' says Schimmelpennink. But he was not in the least discouraged.\n\nSchimmelpennink never stopped believing in bike-sharing, and in the mid-90s, two Danes asked for his help to set up a system in Copenhagen. The result was the world's first large-scale bike-share programme. It worked on a deposit: 'You dropped a coin in the bike and when you returned it, you got your money back.' After setting up the Danish system, Schimmelpennink decided to try his luck again\n\n**Section E**\n\n**Section F**\n\nG in the Netherlands - and this time he succeeded in arousing the interest of the Dutch Ministry of Transport. 'Times had changed,' he recalls. 'People had become more environmentally conscious, and the Danish experiment had proved that bike-sharing was a real possibility.' A new Witte Fietsenplan was launched in 1999 in Amsterdam. However, riding a white bike was no longer free; it cost one guilder per trip and payment was made with a chip card developed by the Dutch bank Postbank. Schimmelpennink designed conspicuous, sturdy white bikes locked in special racks which could be opened with the chip card - the plan started with 250 bikes, distributed over five stations.\n\nTheo Molenaar, who was a system designer for the project, worked alongside Schimmelpennink. 'l remember when we were testing the bike racks, he announced that he had already designed better ones. But of course, we had to go through with the ones we had.' The system, however, was prone to vandalism and theft. After every weekend there would always be a couple of bikes missing,' Molenaar says. 'l really have no idea what people did with them, because they could instantly be recognised as white bikes.' But the biggest blow came when Postbank decided to abolish the chip card, because it wasn't profitable. 'That chip card was pivotal to the system,' Molenaar says. 'To continue the project we would have needed to set up another system, but the business partner had lost interest.'\n\nSchimmelpennink was disappointed, but - characteristically - not for long. In 2002 he got a call from the French advertising corporation JC Decaux, who wanted to set up his bike-sharing scheme in Vienna. 'That went really well. After Vienna, they set up a system in Lyon. Then in 2007, Paris followed. That was a decisive moment in the history of bike-sharing.' The huge and unexpected success of the Parisian bike-sharing programme, which now boasts more than 20,000 bicycles, inspired cities all over the world to set up their own schemes, all modelled on Schimmelpennink's. 'It's wonderful that this happened,' he says. 'But financially I didn't really benefit from it, because I never filed for a patent.'\n\nIn Amsterdam today, 38% of all trips are made by bike and, along with Copenhagen, it is regarded as one of the two most cycle-friendly capitals in the world - but the city never got another Witte Fietsenplan. Molenaar believes this may be because everybody in Amsterdam already has a bike. Schimmelpennink, however, cannot see that this changes Amsterdam's need for a bike-sharing scheme. 'People who travel on the underground don't carry their bikes around. But often they need additional transport to reach their final destination.' Although he thinks it is strange that a city like Amsterdam does not have a successful bike- sharing scheme, he is optimistic about the future. 'In the '60s we didn't stand a chance because people were prepared to give their lives to keep cars in the city. But that mentality has totally changed. Today everybody longs for cities that are not dominated by cars.'
64	152	Alexander Henderson (1831-1913)	Born in Scotland, Henderson emigrated to Canada in 1855 and became a well-known landscape photographer\n\nAlexander Henderson was born in Scotland in 1831 and was the son of a successful merchant. His grandfather, also called Alexander, had founded the family business, and later became the first chairman of the National Bank of Scotland. The family had extensive landholdings in Scotland. Besides its residence in Edinburgh, it owned Press Estate, 650 acres of farmland about 35 miles southeast of the city. The family often stayed at Press Castle, the large mansion on the northern edge of the property, and Alexander spent much of his childhood in the area, playing on the beach near Eyemouth or fishing in the streams nearby.\n\nEven after he went to school at Murcheston Academy on the outskirts of Edinburgh, Henderson returned to Press at weekends. In 1849 he began a three-year apprenticeship to become an accountant. Although he never liked the prospect ofa business career, he stayed with it to please his family. In October 1855, however, he emigrated to Canada with his wife Agnes Elder Robertson and they settled in Montreal.\n\nHenderson learned photography in Montreal around the year 1857 and quickly took it up as a serious amateur. He became a personal friend and colleague of the Scottish-Canadian photographer William Notman. The two men made a photographic excursion to Niagara Falls in 1860 and they cooperated on experiments with magnesium flares as a source of artificial light in 1865. They belonged to the same societies and were among the founding members of the Art Association of Montreal. Henderson acted as chairman of the association's first meeting, which was held in Notman's studio on I I January 1860.\n\nIn spite of their friendship, their styles of photography were quite different. While Notman's landscapes were noted for their bold realism, Henderson for the first 20 years of his career produced romantic images, showing the strong influence of the British landscape tradition. His artistic and technical progress was rapid and in 1865 he published his first major collection of landscape photographs. The publication had limited circulation (only seven copies have ever been found), and was called Canadian Views and Studies. The contents of each copy vary significantly and have proved a useful source for evaluating Henderson's early work.\n\nThis text is taken, for the most part. verbatim from the Dictionary of Canadian Biography Volume XIV (1911-1920), For design purposes, quotation marks have been omitted. Source: http:///enJbioIhenderson_alexander_1831_1913_14E.html. Reproduced with permission.\n\nIn 1 866, he gave up his business to open a photographic studio, advertising himself as a portrait and landscape photographer. From about 1870 he dropped portraiture to specialize in landscape photography and other views. His numerous photographs of city life revealed in street scenes, houses, and markets are alive with human activity, and although his favourite subject was landscape he usually composed his scenes around such human pursuits as farming the land, cutting ice on a river, or sailing down a woodland stream. There was sufficient demand for these types of scenes and others he took depicting the lumber trade, steamboats and waterfalls to enable him to make a living. There was little competing hobby or amateur photography before the late 1880s because of the time-consuming techniques involved and the weight of the equipment. People wanted to buy photographs as souvenirs of a trip or as gifts, and catering to this market, Henderson had stock photographs on display at his studio for mounting, framing, or inclusion in albums.\n\nHenderson frequently exhibited his photographs in Montreal and abroad, in London, Edinburgh, Dublin, Paris, New York, and Philadelphia. He met with greater success in 1877 and 1878 in New York when he won first prizes in the exhibition held by E and H T Anthony and Company for landscapes using the Lambertype process. In 1878 his work won second prize at the world exhibition in Paris.\n\nIn the 1870s and 1880s Henderson travelled widely throughout Quebec and Ontario, in Canada, documenting the major cities of the two provinces and many of the villages in Quebec. He was especially fond of the wilderness and often travelled by canoe on the Blanche, du Liévre, and other noted eastern rivers. He went on several occasions to the Maritimes and in 1872 he sailed by yacht along the lower north shore of the St Lawrence River. That same year, while in the lower St Lawrence River region, he took some photographs of the construction of the Intercolonial Railway. This undertaking led in 1875 to a commission from the railway to record the principal structures along the almost-completed line connecting Montreal to Halifax. Commissions from other railways followed. In 1876 he photographed bridges on the Quebec, Montreal, Ottawa and Occidental Railway between Montreal and Ottawa. In 1885 he went west along the Canadian Pacific Railway (CPR) as far as Rogers Pass in British Columbia, where he took photographs of the mountains and the progress of construction.\n\nIn 1892 Henderson accepted a full-time position with the CPR as manager of a photographic department which he was to set up and administer. His duties included spending four months in the field each year. That summer he made his second trip west, photographing extensively along the railway line as far as Victoria. He continued in this post until 1 897, when he retired completely from photography.\n\nWhen Henderson died in 1913, his huge collection of glass negatives was stored in the basement of his house. Today collections of his work are held at the National Archives of Canada, Ottawa, and the McCord Museum of Canadian History, Montreal.\n\nThis text is taken, for the most part, verbatim from the Dictionary of Canadian Biography Volume XIV (1911-1920), For design purposes, quotatlon marks have been omitted, Source: http:///en/biomenderson_alexander_1831_1913_14E.html_ Reproduced with permission.
63	147	Motivational drivers in the hospitality industry	Motivational factors and the hospitality industry\n\nA critical ingredient in the success of hotels is developing and maintaining superior performance from their employees. How is that accomplished? What Human Resource Management (HRM) practices should organizations invest in to acquire and retain great employees?\n\nSome hotels aim to provide superior working conditions for their employees. The idea originated from workplaces - usually in the non-service sector - that emphasized fun and enjoyment as part of work-life balance. By contrast, the service sector, and more specifically hotels, has traditionally not extended these practices to address basic employee needs, such as good working conditions.\n\nPfeffer (1994) emphasizes that in order to succeed in a global business environment, organizations must make investment in Human Resource Management (HRM) to allow them to acquire employees who possess better skills and capabilities than their competitors. This investment will be to their competitive advantage. Despite this recognition of the importance of employee development, the hospitality industry has historically been dominated by underdeveloped HR practices (Lucas, 2002).\n\nLucas also points out that 'the substance of HRM practices does not appear to be designed to foster constructive relations with employees or to represent a managerial approach that enables developing and drawing out the full potential of people, even though employees may be broadly satisfied with many aspects of their work' (Lucas, 2002). In addition, or maybe as a result, high employee turnover has been a recurring problem throughout the hospitality industry. Among the many cited reasons are low compensation, inadequate benefits, poor working conditions and compromised employee morale and attitudes (Maroudas et al., 2008).\n\nNg and Sorensen (2008) demonstrated that when managers provide recognition to employees, motivate employees to work together, and remove obstacles preventing effective performance, employees feel more obligated to stay with the company. This was succinctly summarized by Michel et al. (2013): '[P]roviding support to employees gives them the confidence to perform their jobs better and the motivation to stay with the organization.' Hospitality organizations can therefore enhance employee motivation and retention through the development and improvement of their working conditions. These conditions are inherently linked to the working environment.\n\nWhile it seems likely that employees' reactions to their job characteristics could be affected by a predisposition to view their work environment negatively, no evidence exists to support this hypothesis (Spector et al., 2000). However, given the opportunity, many people will find something to complain about in relation to their workplace (Poulston, 2009). There is a strong link between the perceptions of employees and particular factors of their work environment that are separate from the work itself, including company policies, salary and vacations.\n\nSuch conditions are particularly troubling for the luxury hotel market, where high-quality service, requiring a sophisticated approach to HRM, is recognized as a critical source of competitive advantage (Maroudas et al., 2008). In a real sense, the services of hotel employees represent their industry (Schneider and Bowen, 1993). This representation has commonly been limited to guest experiences. This suggests that there has been a dichotomy between the guest environment provided in luxury hotels and the working conditions of their employees.\n\nIt is therefore essential for hotel management to develop HRM practices that enable them to inspire and retain competent employees. This requires an understanding of what motivates employees at different levels of management and different stages of their careers (Enz and Siguaw, 2000). This implies that it is beneficial for hotel managers to understand what practices are most favorable to increase employee satisfaction and retention.\n\nHerzberg ( 1966) proposes that people have two major types of needs, the first being extrinsic motivation factors relating to the context in which work is performed, rather than the work itself. These include working conditions and job security. When these factors are unfavorable, job dissatisfaction may result. Significantly, though, just fulfilling these needs does not result in satisfaction, but only in the reduction of dissatisfaction (Maroudas et al., 2008).\n\nEmployees also have intrinsic motivation needs or motivators, which include such factors as achievement and recognition. Unlike extrinsic factors, motivator factors may ideally result in job satisfaction (Maroudas et al., 2008). Herzberg's (1966) theory discusses the need for a 'balance' of these two types of needs.\n\nThe impact of fun as a motivating factor at work has also been explored. For example, Tews, Michel and Stafford (2013) conducted a study focusing on staff from a chain of themed restaurants in the United States. It was found that fun activities had a favorable impact on performance and manager support for fun had a favorable impact in reducing turnover. Their findings support the view that fun may indeed have a beneficial effect, but the framing of that fun must be carefully aligned with both organizational goals and employee characteristics. 'Managers must learn how to achieve the delicate balance of allowing employees the freedom to enjoy themselves at work while simultaneously maintaining high levels ofperformance' (Tews et al., 2013).\n\nDeery (2008) has recommended several actions that can be adopted at the organizational level to retain good staff as well as assist in balancing work and family life. Those particularly appropriate to the hospitality industry include allowing adequate breaks during the working day, staff functions that involve families, and providing health and well-being opportunities.
65	153	Back to the future of skyscraper design	k to the future of skyscraper design\n\nAnswers to the problem of excessive electricity use by skyscrapers and large public buildings can be found in ingenious but forgotten architectural designs of the 19th and early-20th centuries The Recovery of Natural Environments in Architecture by Professor Alan Short is the culmination of 30 years of research and award-winning green building design by Short and colleagues in Architecture, Engineering, Applied Maths and Earth Sciences at the University of Cambridge. 'The crisis in building design is already here,' said Short. 'Policy makers think you can solve energy and building problems with gadgets. You can't. As global temperatures continue to rise, we are going to continue to squander more and more energy on keeping our buildings mechanically cool until we have run out of capacity. ' Short is calling for a sweeping reinvention of how skyscrapers and major public buildings are designed - to end the reliance on sealed buildings which exist solely via the 'life support' system of vast air conditioning units. Instead, he shows it is entirely possible to accommodate natural ventilation and cooling in large buildings by looking into the past, before the widespread introduction of air conditioning systems, which were 'relentlessly and aggressively marketed' by their inventors. Short points out that to make most contemporary buildings habitable, they have to be sealed and air conditioned. The energy use and carbon emissions this generates is spectacular and largely unnecessary. Buildings in the West account for 40-50% of electricity usage, generating substantial carbon emissions, and the rest of the world is catching up at a frightening rate. Short regards glass, steel and air-conditioned skyscrapers as symbols of status, rather than practical ways of meeting our requirements. Short's book highlights a developing and sophisticated art and science of ventilating buildings through the 19th and earlier-20th centuries, including the design of ingeniously ventilated hospitals. Of particular interest were those built to the designs of John Shaw Billings, including the first Johns Hopkins Hospital in the US city of Baltimore (1873-1889). 'We spent three years digitally modelling Billings' final designs,' says Short. 'We put pathogens' in the airstreams, modelled for someone with tuberculosis (TB) coughing in the wards and we found the ventilation systems in the room would have kept other patients safe from harm. pathogens: microorganisms that can cause disease\n\n**Section E**\n\n**Section F**\n\n**Section G**\n\nH 'We discovered that 19th-century hospital wards could generate up to 24 air changes an hour - that's similar to the performance of a modern-day, computer-controlled operating theatre. We believe you could build wards based on these principles now. Single rooms are not appropriate for all patients. Communal wards appropriate for certain patients - older people with dementia, for example - would work just as well in today's hospitals, at a fraction of the energy cost.' Professor Short contends the mindset and skill-sets behind these designs have been completely lost, lamenting the disappearance of expertly designed theatres, opera houses, and other buildings where up to half the volume of the building was given over to ensuring everyone got fresh air. Much of the ingenuity present in 19th-century hospital and building design was driven by a panicked public clamouring for buildings that could protect against what was thought to be the lethal threat of miasmas - toxic air that spread disease. Miasmas were feared as the principal agents of disease and epidemics for centuries, and were used to explain the spread of infection from the Middle Ages right through to the cholera outbreaks in London and Paris during the 1850s. Foul air, rather than germs, was believed to be the main driver of 'hospital fever', leading to disease and frequent death. The prosperous steered clear of hospitals. While miasma theory has been long since disproved, Short has for the last 30 years advocated a return to some of the building design principles produced in its wake. Today, huge amounts of a building's space and construction cost are given over to air conditioning. 'But I have designed and built a series of buildings over the past three decades which have tried to reinvent some of these ideas and then measure what happens. 'To go forward into our new low-energy, low-carbon future, we would be well advised to look back at design before our high-energy, high-carbon present appeared. What is surprising is what a rich legacy we have abandoned.' Successful examples of Short's approach include the Queen's Building at De Montfort University in Leicester. Containing as many as 2,000 staff and students, the entire building is naturally ventilated, passively cooled and naturally lit, including the two largest auditoria, each seating more than 150 people. The award-winning building uses a fraction of the electricity of comparable buildings in the UK. Short contends that glass skyscrapers in London and around the world will become a liability over the next 20 or 30 years if climate modelling predictions and energy price rises come to pass as expected. He is convinced that sufficiently cooled skyscrapers using the natural environment can be produced in almost any climate. He and his team have worked on hybrid buildings in the harsh climates of Beijing and Chicago - built with natural ventilation assisted by back-up air conditioning - which, surprisingly perhaps, can be switched off more than half the time on milder days and during the spring and autumn. Short looks at how we might reimagine the cities, offices and homes of the future. Maybe it's time we changed our outlook.
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
3	5	1	Jamieson	t
4	16	1	Jamieson	t
\.


--
-- Data for Name: user_attempts; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.user_attempts (id, user_id, section_id, started_at, finished_at) FROM stdin;
1	1	1	2026-08-31 22:39:48.167739+07	2026-08-31 22:39:48.183064+07
2	2	1	2026-08-31 22:54:36.260104+07	2026-08-31 22:56:51.642416+07
3	2	1	2026-08-31 22:56:59.197766+07	\N
4	2	8	2026-08-31 22:57:05.732989+07	\N
5	1	1	2026-09-01 21:26:42.192635+07	2026-09-01 21:26:42.217242+07
6	2	117	2026-09-01 22:26:06.54716+07	\N
7	2	33	2026-09-01 22:26:36.809421+07	\N
8	2	1	2026-09-01 22:26:48.614892+07	\N
9	2	113	2026-09-01 22:26:59.029064+07	\N
10	2	5	2026-09-01 22:57:17.764068+07	\N
11	2	1	2026-09-01 22:57:42.029832+07	\N
12	2	29	2026-09-01 22:57:53.067398+07	\N
13	2	33	2026-09-01 22:58:01.881582+07	\N
14	2	5	2026-09-01 23:08:07.785395+07	\N
15	2	54	2026-09-01 23:08:41.569462+07	\N
16	1	1	2026-09-01 23:17:14.700251+07	2026-09-01 23:17:14.712957+07
17	2	5	2026-09-01 23:22:47.316626+07	\N
18	2	33	2026-09-01 23:22:53.894306+07	\N
19	2	57	2026-09-04 00:36:16.263942+07	\N
20	2	61	2026-09-04 00:36:26.650739+07	\N
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.users (id, username, password_hash, is_admin, created_at) FROM stdin;
1	admin	332ef5d1c148cddfc57688dae8e7df559632ba17c1bfdc051b3f031a7a3f0913	t	2026-08-31 22:39:48.093784+07
2	student	d2b8a5bd97f4f058e6668e784a22293970f9a19c1580e7260f31ccd0e8d7d9b8	f	2026-08-31 22:54:18.487201+07
3	john_doe_99	cab25e4f78b08707b74688e76dd23504e53582a45297263076b968a7a17b1ca1	f	2026-08-31 23:13:03.473544+07
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

SELECT pg_catalog.setval('public.user_answers_id_seq', 4, true);


--
-- Name: user_attempts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.user_attempts_id_seq', 20, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


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

\unrestrict 2Sg5cFuOwH70agoaBgxceldgQTok85HH6tQZFW5ATY63wVCGFqqeib2kWdR72mS

