--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.4
-- Started on 2013-06-25 01:26:02 CST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 182 (class 3079 OID 11935)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2225 (class 0 OID 0)
-- Dependencies: 182
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 174 (class 1259 OID 16438)
-- Name: eleccion; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE eleccion (
    id_evento integer NOT NULL,
    motivo character varying(200),
    reg_tend_inicio date,
    reg_tend_fin date,
    requisitos_inicio date,
    requisitos_fin date,
    votacion_inicio date,
    votacion_fin date,
    padron integer
);


ALTER TABLE public.eleccion OWNER TO r1k4rd0;

--
-- TOC entry 173 (class 1259 OID 16436)
-- Name: eleccion_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: r1k4rd0
--

CREATE SEQUENCE eleccion_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.eleccion_id_evento_seq OWNER TO r1k4rd0;

--
-- TOC entry 2227 (class 0 OID 0)
-- Dependencies: 173
-- Name: eleccion_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: r1k4rd0
--

ALTER SEQUENCE eleccion_id_evento_seq OWNED BY eleccion.id_evento;


--
-- TOC entry 170 (class 1259 OID 16422)
-- Name: padron; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE padron (
    id_padron integer NOT NULL,
    descripcion character varying(200)
);


ALTER TABLE public.padron OWNER TO r1k4rd0;

--
-- TOC entry 169 (class 1259 OID 16420)
-- Name: padron_id_padron_seq; Type: SEQUENCE; Schema: public; Owner: r1k4rd0
--

CREATE SEQUENCE padron_id_padron_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.padron_id_padron_seq OWNER TO r1k4rd0;

--
-- TOC entry 2230 (class 0 OID 0)
-- Dependencies: 169
-- Name: padron_id_padron_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: r1k4rd0
--

ALTER SEQUENCE padron_id_padron_seq OWNED BY padron.id_padron;


--
-- TOC entry 168 (class 1259 OID 16406)
-- Name: persona; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE persona (
    cedula bigint NOT NULL,
    nombre character varying(24),
    apellido1 character varying(24),
    apellido2 character varying(24),
    fecha_nacim date,
    correo character varying(48),
    clave character varying(48),
    llave_publica character varying(1000),
    CONSTRAINT persona_cedula_check CHECK (((cedula > 99999999) AND (cedula < 10000000000000::bigint)))
);


ALTER TABLE public.persona OWNER TO r1k4rd0;

--
-- TOC entry 177 (class 1259 OID 16471)
-- Name: persona_en_padron; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE persona_en_padron (
    cedula bigint NOT NULL,
    id_padron integer NOT NULL
);


ALTER TABLE public.persona_en_padron OWNER TO r1k4rd0;

--
-- TOC entry 172 (class 1259 OID 16430)
-- Name: plebiscito; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE plebiscito (
    id_evento integer NOT NULL,
    nombre character varying(200),
    pregunta character varying(200),
    reg_tend_inicio date,
    reg_tend_fin date,
    requisitos_inicio date,
    requisitos_fin date,
    votacion_inicio date,
    votacion_fin date,
    padron integer
);


ALTER TABLE public.plebiscito OWNER TO r1k4rd0;

--
-- TOC entry 171 (class 1259 OID 16428)
-- Name: plebiscito_id_evento_seq; Type: SEQUENCE; Schema: public; Owner: r1k4rd0
--

CREATE SEQUENCE plebiscito_id_evento_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.plebiscito_id_evento_seq OWNER TO r1k4rd0;

--
-- TOC entry 2235 (class 0 OID 0)
-- Dependencies: 171
-- Name: plebiscito_id_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: r1k4rd0
--

ALTER SEQUENCE plebiscito_id_evento_seq OWNED BY plebiscito.id_evento;


--
-- TOC entry 180 (class 1259 OID 16596)
-- Name: resultados_eleccion; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE resultados_eleccion (
    id_evento integer NOT NULL,
    id_tendencia integer NOT NULL,
    votos_recibidos integer NOT NULL
);


ALTER TABLE public.resultados_eleccion OWNER TO r1k4rd0;

--
-- TOC entry 181 (class 1259 OID 16618)
-- Name: resultados_plebiscito; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE resultados_plebiscito (
    id_evento integer NOT NULL,
    id_tendencia integer NOT NULL,
    votos_recibidos integer NOT NULL
);


ALTER TABLE public.resultados_plebiscito OWNER TO r1k4rd0;

--
-- TOC entry 176 (class 1259 OID 16457)
-- Name: tendencia; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE tendencia (
    id_tendencia integer NOT NULL,
    nombre character varying(200),
    informacion character varying(200),
    enlaces character varying(500)
);


ALTER TABLE public.tendencia OWNER TO r1k4rd0;

--
-- TOC entry 179 (class 1259 OID 16548)
-- Name: tendencia_eleccion; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE tendencia_eleccion (
    id_tendencia integer NOT NULL,
    id_evento integer NOT NULL,
    candidato bigint
);


ALTER TABLE public.tendencia_eleccion OWNER TO r1k4rd0;

--
-- TOC entry 175 (class 1259 OID 16455)
-- Name: tendencia_id_tendencia_seq; Type: SEQUENCE; Schema: public; Owner: r1k4rd0
--

CREATE SEQUENCE tendencia_id_tendencia_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tendencia_id_tendencia_seq OWNER TO r1k4rd0;

--
-- TOC entry 2241 (class 0 OID 0)
-- Dependencies: 175
-- Name: tendencia_id_tendencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: r1k4rd0
--

ALTER SEQUENCE tendencia_id_tendencia_seq OWNED BY tendencia.id_tendencia;


--
-- TOC entry 178 (class 1259 OID 16518)
-- Name: tendencia_plebiscito; Type: TABLE; Schema: public; Owner: r1k4rd0; Tablespace: 
--

CREATE TABLE tendencia_plebiscito (
    id_tendencia integer NOT NULL,
    id_evento integer NOT NULL
);


ALTER TABLE public.tendencia_plebiscito OWNER TO r1k4rd0;

--
-- TOC entry 2169 (class 2604 OID 16441)
-- Name: id_evento; Type: DEFAULT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY eleccion ALTER COLUMN id_evento SET DEFAULT nextval('eleccion_id_evento_seq'::regclass);


--
-- TOC entry 2167 (class 2604 OID 16425)
-- Name: id_padron; Type: DEFAULT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY padron ALTER COLUMN id_padron SET DEFAULT nextval('padron_id_padron_seq'::regclass);


--
-- TOC entry 2168 (class 2604 OID 16433)
-- Name: id_evento; Type: DEFAULT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY plebiscito ALTER COLUMN id_evento SET DEFAULT nextval('plebiscito_id_evento_seq'::regclass);


--
-- TOC entry 2170 (class 2604 OID 16460)
-- Name: id_tendencia; Type: DEFAULT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY tendencia ALTER COLUMN id_tendencia SET DEFAULT nextval('tendencia_id_tendencia_seq'::regclass);


--
-- TOC entry 2210 (class 0 OID 16438)
-- Dependencies: 174
-- Data for Name: eleccion; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY eleccion (id_evento, motivo, reg_tend_inicio, reg_tend_fin, requisitos_inicio, requisitos_fin, votacion_inicio, votacion_fin, padron) FROM stdin;
1	Eleccion Presidencial	2013-06-25	2013-07-01	\N	\N	\N	\N	\N
2	Eleccion de director de escuela	2013-05-15	2013-05-17	\N	\N	\N	\N	\N
4	Elecciones internas de candidato presidencial	2013-06-18	2013-06-19	\N	\N	\N	\N	\N
3	Eleccion Ganador de feria	2013-06-25	2013-06-27	\N	\N	\N	\N	\N
5	Elección de presidente del reino	2013-06-11	2013-06-11	2013-06-11	2013-06-11	2013-06-11	2013-06-11	\N
6	Vote para el más corrupto en el Gobierno	2013-06-24	2013-06-24	2013-06-24	2013-06-24	2013-06-24	2013-06-24	\N
7	Motivo de prueba	2013-06-12	2013-06-12	2013-06-19	2013-06-19	2013-06-11	2013-06-12	\N
8	Motivo de prueba	2013-06-12	2013-06-12	2013-06-19	2013-06-19	2013-06-11	2013-06-12	\N
9	Prueba de Eleccion	2013-06-06	2013-06-06	2013-06-06	2013-06-06	2013-06-06	2013-06-06	\N
10	Hola mundo	2013-06-06	2013-06-06	2013-06-06	2013-06-06	2013-06-06	2013-06-06	\N
11	Hola	2013-06-04	2013-06-04	2013-06-04	2013-06-04	2013-06-04	2013-06-04	\N
12	Prueba de evento	2013-06-24	2013-06-27	2013-06-19	2013-06-27	2013-06-27	2013-06-27	\N
\.


--
-- TOC entry 2244 (class 0 OID 0)
-- Dependencies: 173
-- Name: eleccion_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: r1k4rd0
--

SELECT pg_catalog.setval('eleccion_id_evento_seq', 12, true);


--
-- TOC entry 2206 (class 0 OID 16422)
-- Dependencies: 170
-- Data for Name: padron; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY padron (id_padron, descripcion) FROM stdin;
1	padron de estudiantes ecci
2	Padron de junta cantonal Zarcero
3	Padron elección de alcalde Tarrazú
\.


--
-- TOC entry 2245 (class 0 OID 0)
-- Dependencies: 169
-- Name: padron_id_padron_seq; Type: SEQUENCE SET; Schema: public; Owner: r1k4rd0
--

SELECT pg_catalog.setval('padron_id_padron_seq', 3, true);


--
-- TOC entry 2204 (class 0 OID 16406)
-- Dependencies: 168
-- Data for Name: persona; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY persona (cedula, nombre, apellido1, apellido2, fecha_nacim, correo, clave, llave_publica) FROM stdin;
123530880	Ricardo	Suárez	Vargas	1975-04-15	ra88@gmail.com	\N	\N
912344567	Eduardo	Steiner	Garro	1990-01-01	eduard16sg@gmail.com	\N	\N
545614561	Rebeca	Ramírez	Arroyo	1992-05-25	rivka.ra55@gmail.com	\N	\N
112345678	Juan	Gómez	Salas	1991-10-20	juan123@live.com	\N	\N
888888888	Josué	Bonilla	Mora	\N	\N	\N	\N
987654321	María	Díaz	Vargas	\N	mary.2@hotmail.com	\N	\N
\.


--
-- TOC entry 2213 (class 0 OID 16471)
-- Dependencies: 177
-- Data for Name: persona_en_padron; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY persona_en_padron (cedula, id_padron) FROM stdin;
888888888	1
888888888	3
545614561	3
\.


--
-- TOC entry 2208 (class 0 OID 16430)
-- Dependencies: 172
-- Data for Name: plebiscito; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY plebiscito (id_evento, nombre, pregunta, reg_tend_inicio, reg_tend_fin, requisitos_inicio, requisitos_fin, votacion_inicio, votacion_fin, padron) FROM stdin;
1	Matrimonio humano-animal	¿Está usted de acuerdo en que se apruebe el matrimonio entre personas y animales?	2013-06-24	2013-06-30	2013-06-24	2013-06-30	2013-07-01	2013-07-01	\N
2	Ganador mundial futbol	¿Quien va a ganar el mundial?	\N	\N	\N	\N	\N	\N	\N
3	Buen o mal gobierno	¿Este último gobierno ha sido bueno?	\N	\N	\N	\N	\N	\N	\N
4	Mejor mamá del mundo	¿Cuál es la mejor mamá del mundo?	\N	\N	\N	\N	\N	\N	\N
5	Prueba de Plebiscito	Sabe usted que es un Plebiscito?	2013-06-11	2013-06-15	2013-06-17	2013-06-21	2013-06-24	2013-06-28	\N
\.


--
-- TOC entry 2246 (class 0 OID 0)
-- Dependencies: 171
-- Name: plebiscito_id_evento_seq; Type: SEQUENCE SET; Schema: public; Owner: r1k4rd0
--

SELECT pg_catalog.setval('plebiscito_id_evento_seq', 5, true);


--
-- TOC entry 2216 (class 0 OID 16596)
-- Dependencies: 180
-- Data for Name: resultados_eleccion; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY resultados_eleccion (id_evento, id_tendencia, votos_recibidos) FROM stdin;
2	23	7
\.


--
-- TOC entry 2217 (class 0 OID 16618)
-- Dependencies: 181
-- Data for Name: resultados_plebiscito; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY resultados_plebiscito (id_evento, id_tendencia, votos_recibidos) FROM stdin;
2	29	15
\.


--
-- TOC entry 2212 (class 0 OID 16457)
-- Dependencies: 176
-- Data for Name: tendencia; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY tendencia (id_tendencia, nombre, informacion, enlaces) FROM stdin;
111	PLN	malos	www.pln.com
333	pac	amarillos	www; ; 
133	Fecundacion in vitro	Aprobacion de fecundacion in vitro	fecun.com, , 
166	Perros callejeros	Lucha por mejorar la vida de los callejeros	caniches.com, , 
177	Lineas 4g	Seguridad en lineas 4g	lineas4g.com, , 
199	Perros sanos	Salud animal	salubani.com, , 
229	Calidad de atencion	Lucha por mejora en atencion al publico	, , 
23	PUSC	Partido Unidad Social	www.pusc.com, , 
24	Años 80	Generacion 80	gen80.com, , 
29	Partido Latino	Latinos en politica	unionlat.com, , 
30	Equipo a		equipoa.com, , 
32	banderas	banderas de paises	, , 
33	equipo bueno	un buen equipo	equipobueno.com, , 
34	nuevogrupo	cualquiera	nuevogru.com, , 
35	Nuevopleb	asdasd	nuevop.com, , 
40	Donadores	donar sangre	, , 
44	Jirafas	jirafas grandes	, , 
45	gatos	gatos domesticos	, , 
46	vaca	vacas 	, , 
47	dsfsdf	sdfsdf	, , 
48	musica	mucha musica	, , 
49	perrogato	sdfdsf	, , 
50	lololo	sdfadf	, , 
51	loquesea	sdfsdf	, , 
52	cosa	vfsdfsdf	, , 
53	denuevo	sfdsdf	, , 
54	otravez	kksdjfkjsd	, , 
55	todo	sadsad	, , 
56	caballos	blancos	, , 
57	celular	afsdf	, , 
58	banda	banda musical	, , 
59	golden	raza	, , 
60	bases	asdsd	, , 
61	otrootro	sdfsdf	, , 
62	tendenciapleb	asddadsa	, , 
63	plebnuevo	sfddf	, , 
64	Partido Ecologico	Somos un partido que protege al medio ambiente	partieco.com, , 
65	Partido Del Sol	Somos el partido de el valle	partsol.com, , 
\.


--
-- TOC entry 2215 (class 0 OID 16548)
-- Dependencies: 179
-- Data for Name: tendencia_eleccion; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY tendencia_eleccion (id_tendencia, id_evento, candidato) FROM stdin;
23	2	\N
64	1	\N
65	4	\N
\.


--
-- TOC entry 2247 (class 0 OID 0)
-- Dependencies: 175
-- Name: tendencia_id_tendencia_seq; Type: SEQUENCE SET; Schema: public; Owner: r1k4rd0
--

SELECT pg_catalog.setval('tendencia_id_tendencia_seq', 65, true);


--
-- TOC entry 2214 (class 0 OID 16518)
-- Dependencies: 178
-- Data for Name: tendencia_plebiscito; Type: TABLE DATA; Schema: public; Owner: r1k4rd0
--

COPY tendencia_plebiscito (id_tendencia, id_evento) FROM stdin;
111	2
29	2
30	2
\.


--
-- TOC entry 2178 (class 2606 OID 16443)
-- Name: eleccion_pkey; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY eleccion
    ADD CONSTRAINT eleccion_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 2174 (class 2606 OID 16427)
-- Name: padron_pkey; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY padron
    ADD CONSTRAINT padron_pkey PRIMARY KEY (id_padron);


--
-- TOC entry 2182 (class 2606 OID 16650)
-- Name: persona_en_padron_pkey; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY persona_en_padron
    ADD CONSTRAINT persona_en_padron_pkey PRIMARY KEY (cedula, id_padron);


--
-- TOC entry 2172 (class 2606 OID 16411)
-- Name: persona_pkey; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (cedula);


--
-- TOC entry 2190 (class 2606 OID 16612)
-- Name: pk_eleccion_tendencia; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY resultados_eleccion
    ADD CONSTRAINT pk_eleccion_tendencia PRIMARY KEY (id_evento, id_tendencia);


--
-- TOC entry 2192 (class 2606 OID 16622)
-- Name: pk_plebiscito_tendencia; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY resultados_plebiscito
    ADD CONSTRAINT pk_plebiscito_tendencia PRIMARY KEY (id_evento, id_tendencia);


--
-- TOC entry 2186 (class 2606 OID 16554)
-- Name: pk_tendencia_eleccion; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY tendencia_eleccion
    ADD CONSTRAINT pk_tendencia_eleccion PRIMARY KEY (id_tendencia, id_evento);


--
-- TOC entry 2184 (class 2606 OID 16524)
-- Name: pk_tendencia_plebiscito; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY tendencia_plebiscito
    ADD CONSTRAINT pk_tendencia_plebiscito PRIMARY KEY (id_tendencia, id_evento);


--
-- TOC entry 2176 (class 2606 OID 16435)
-- Name: plebiscito_pkey; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY plebiscito
    ADD CONSTRAINT plebiscito_pkey PRIMARY KEY (id_evento);


--
-- TOC entry 2188 (class 2606 OID 16556)
-- Name: tendencia_eleccion_candidato_key; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY tendencia_eleccion
    ADD CONSTRAINT tendencia_eleccion_candidato_key UNIQUE (candidato);


--
-- TOC entry 2180 (class 2606 OID 16465)
-- Name: tendencia_pkey; Type: CONSTRAINT; Schema: public; Owner: r1k4rd0; Tablespace: 
--

ALTER TABLE ONLY tendencia
    ADD CONSTRAINT tendencia_pkey PRIMARY KEY (id_tendencia);


--
-- TOC entry 2194 (class 2606 OID 16634)
-- Name: eleccion_padron_fkey; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY eleccion
    ADD CONSTRAINT eleccion_padron_fkey FOREIGN KEY (padron) REFERENCES padron(id_padron) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2201 (class 2606 OID 16567)
-- Name: fk_candidato; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY tendencia_eleccion
    ADD CONSTRAINT fk_candidato FOREIGN KEY (candidato) REFERENCES persona(cedula) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2200 (class 2606 OID 16562)
-- Name: fk_eleccion; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY tendencia_eleccion
    ADD CONSTRAINT fk_eleccion FOREIGN KEY (id_evento) REFERENCES eleccion(id_evento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2202 (class 2606 OID 16613)
-- Name: fk_eleccion_tendencia; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY resultados_eleccion
    ADD CONSTRAINT fk_eleccion_tendencia FOREIGN KEY (id_evento, id_tendencia) REFERENCES tendencia_eleccion(id_evento, id_tendencia) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2195 (class 2606 OID 16491)
-- Name: fk_persona; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY persona_en_padron
    ADD CONSTRAINT fk_persona FOREIGN KEY (cedula) REFERENCES persona(cedula) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2198 (class 2606 OID 16530)
-- Name: fk_plebiscito; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY tendencia_plebiscito
    ADD CONSTRAINT fk_plebiscito FOREIGN KEY (id_evento) REFERENCES plebiscito(id_evento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2203 (class 2606 OID 16623)
-- Name: fk_plebiscito_tendencia; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY resultados_plebiscito
    ADD CONSTRAINT fk_plebiscito_tendencia FOREIGN KEY (id_evento, id_tendencia) REFERENCES tendencia_plebiscito(id_evento, id_tendencia) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2197 (class 2606 OID 16525)
-- Name: fk_tendencia; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY tendencia_plebiscito
    ADD CONSTRAINT fk_tendencia FOREIGN KEY (id_tendencia) REFERENCES tendencia(id_tendencia) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2199 (class 2606 OID 16557)
-- Name: fk_tendencia; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY tendencia_eleccion
    ADD CONSTRAINT fk_tendencia FOREIGN KEY (id_tendencia) REFERENCES tendencia(id_tendencia) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2196 (class 2606 OID 16644)
-- Name: persona_en_padron_id_padron_fkey; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY persona_en_padron
    ADD CONSTRAINT persona_en_padron_id_padron_fkey FOREIGN KEY (id_padron) REFERENCES padron(id_padron) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2193 (class 2606 OID 16639)
-- Name: plebiscito_padron_fkey; Type: FK CONSTRAINT; Schema: public; Owner: r1k4rd0
--

ALTER TABLE ONLY plebiscito
    ADD CONSTRAINT plebiscito_padron_fkey FOREIGN KEY (padron) REFERENCES padron(id_padron) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 2224 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2226 (class 0 OID 0)
-- Dependencies: 174
-- Name: eleccion; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE eleccion FROM PUBLIC;
REVOKE ALL ON TABLE eleccion FROM r1k4rd0;
GRANT ALL ON TABLE eleccion TO r1k4rd0;
GRANT ALL ON TABLE eleccion TO rebeca;
GRANT ALL ON TABLE eleccion TO eduardo;


--
-- TOC entry 2228 (class 0 OID 0)
-- Dependencies: 173
-- Name: eleccion_id_evento_seq; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON SEQUENCE eleccion_id_evento_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE eleccion_id_evento_seq FROM r1k4rd0;
GRANT ALL ON SEQUENCE eleccion_id_evento_seq TO r1k4rd0;
GRANT ALL ON SEQUENCE eleccion_id_evento_seq TO rebeca;
GRANT ALL ON SEQUENCE eleccion_id_evento_seq TO eduardo;


--
-- TOC entry 2229 (class 0 OID 0)
-- Dependencies: 170
-- Name: padron; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE padron FROM PUBLIC;
REVOKE ALL ON TABLE padron FROM r1k4rd0;
GRANT ALL ON TABLE padron TO r1k4rd0;
GRANT ALL ON TABLE padron TO rebeca;
GRANT ALL ON TABLE padron TO eduardo;


--
-- TOC entry 2231 (class 0 OID 0)
-- Dependencies: 169
-- Name: padron_id_padron_seq; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON SEQUENCE padron_id_padron_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE padron_id_padron_seq FROM r1k4rd0;
GRANT ALL ON SEQUENCE padron_id_padron_seq TO r1k4rd0;
GRANT ALL ON SEQUENCE padron_id_padron_seq TO rebeca;
GRANT ALL ON SEQUENCE padron_id_padron_seq TO eduardo;


--
-- TOC entry 2232 (class 0 OID 0)
-- Dependencies: 168
-- Name: persona; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE persona FROM PUBLIC;
REVOKE ALL ON TABLE persona FROM r1k4rd0;
GRANT ALL ON TABLE persona TO r1k4rd0;
GRANT ALL ON TABLE persona TO rebeca;
GRANT ALL ON TABLE persona TO eduardo;


--
-- TOC entry 2233 (class 0 OID 0)
-- Dependencies: 177
-- Name: persona_en_padron; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE persona_en_padron FROM PUBLIC;
REVOKE ALL ON TABLE persona_en_padron FROM r1k4rd0;
GRANT ALL ON TABLE persona_en_padron TO r1k4rd0;
GRANT ALL ON TABLE persona_en_padron TO rebeca;
GRANT ALL ON TABLE persona_en_padron TO eduardo;


--
-- TOC entry 2234 (class 0 OID 0)
-- Dependencies: 172
-- Name: plebiscito; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE plebiscito FROM PUBLIC;
REVOKE ALL ON TABLE plebiscito FROM r1k4rd0;
GRANT ALL ON TABLE plebiscito TO r1k4rd0;
GRANT ALL ON TABLE plebiscito TO rebeca;
GRANT ALL ON TABLE plebiscito TO eduardo;


--
-- TOC entry 2236 (class 0 OID 0)
-- Dependencies: 171
-- Name: plebiscito_id_evento_seq; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON SEQUENCE plebiscito_id_evento_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE plebiscito_id_evento_seq FROM r1k4rd0;
GRANT ALL ON SEQUENCE plebiscito_id_evento_seq TO r1k4rd0;
GRANT ALL ON SEQUENCE plebiscito_id_evento_seq TO rebeca;
GRANT ALL ON SEQUENCE plebiscito_id_evento_seq TO eduardo;


--
-- TOC entry 2237 (class 0 OID 0)
-- Dependencies: 180
-- Name: resultados_eleccion; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE resultados_eleccion FROM PUBLIC;
REVOKE ALL ON TABLE resultados_eleccion FROM r1k4rd0;
GRANT ALL ON TABLE resultados_eleccion TO r1k4rd0;
GRANT ALL ON TABLE resultados_eleccion TO rebeca;
GRANT ALL ON TABLE resultados_eleccion TO eduardo;


--
-- TOC entry 2238 (class 0 OID 0)
-- Dependencies: 181
-- Name: resultados_plebiscito; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE resultados_plebiscito FROM PUBLIC;
REVOKE ALL ON TABLE resultados_plebiscito FROM r1k4rd0;
GRANT ALL ON TABLE resultados_plebiscito TO r1k4rd0;
GRANT ALL ON TABLE resultados_plebiscito TO rebeca;
GRANT ALL ON TABLE resultados_plebiscito TO eduardo;


--
-- TOC entry 2239 (class 0 OID 0)
-- Dependencies: 176
-- Name: tendencia; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE tendencia FROM PUBLIC;
REVOKE ALL ON TABLE tendencia FROM r1k4rd0;
GRANT ALL ON TABLE tendencia TO r1k4rd0;
GRANT ALL ON TABLE tendencia TO rebeca;
GRANT ALL ON TABLE tendencia TO eduardo;


--
-- TOC entry 2240 (class 0 OID 0)
-- Dependencies: 179
-- Name: tendencia_eleccion; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE tendencia_eleccion FROM PUBLIC;
REVOKE ALL ON TABLE tendencia_eleccion FROM r1k4rd0;
GRANT ALL ON TABLE tendencia_eleccion TO r1k4rd0;
GRANT ALL ON TABLE tendencia_eleccion TO rebeca;
GRANT ALL ON TABLE tendencia_eleccion TO eduardo;


--
-- TOC entry 2242 (class 0 OID 0)
-- Dependencies: 175
-- Name: tendencia_id_tendencia_seq; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON SEQUENCE tendencia_id_tendencia_seq FROM PUBLIC;
REVOKE ALL ON SEQUENCE tendencia_id_tendencia_seq FROM r1k4rd0;
GRANT ALL ON SEQUENCE tendencia_id_tendencia_seq TO r1k4rd0;
GRANT ALL ON SEQUENCE tendencia_id_tendencia_seq TO rebeca;
GRANT ALL ON SEQUENCE tendencia_id_tendencia_seq TO eduardo;


--
-- TOC entry 2243 (class 0 OID 0)
-- Dependencies: 178
-- Name: tendencia_plebiscito; Type: ACL; Schema: public; Owner: r1k4rd0
--

REVOKE ALL ON TABLE tendencia_plebiscito FROM PUBLIC;
REVOKE ALL ON TABLE tendencia_plebiscito FROM r1k4rd0;
GRANT ALL ON TABLE tendencia_plebiscito TO r1k4rd0;
GRANT ALL ON TABLE tendencia_plebiscito TO rebeca;
GRANT ALL ON TABLE tendencia_plebiscito TO eduardo;


-- Completed on 2013-06-25 01:26:02 CST

--
-- PostgreSQL database dump complete
--

