--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4 (Debian 14.4-1.pgdg110+1)
-- Dumped by pg_dump version 14.3

-- Started on 2022-09-24 23:28:16

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

DROP DATABASE efishery_dwh;
--
-- TOC entry 3324 (class 1262 OID 16497)
-- Name: efishery_dwh; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE efishery_dwh WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE efishery_dwh OWNER TO postgres;

\connect efishery_dwh

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
-- TOC entry 211 (class 1259 OID 16508)
-- Name: dim_customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_customer (
    index bigint,
    id bigint,
    name text
);


ALTER TABLE public.dim_customer OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16498)
-- Name: dim_date; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dim_date (
    index bigint,
    id bigint,
    date date,
    month double precision,
    quarter_of_year double precision,
    year double precision,
    is_weekend boolean
);


ALTER TABLE public.dim_date OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16502)
-- Name: fact_order_accumulating; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fact_order_accumulating (
    index bigint,
    order_date_id bigint,
    invoice_date_id bigint,
    payment_date_id bigint,
    customer_id bigint,
    order_number text,
    invoice_number text,
    payment_number text,
    total_order_quantity bigint,
    total_order_usd_amount double precision,
    order_to_invoice_lag_days bigint,
    invoice_to_payment_lag_days bigint
);


ALTER TABLE public.fact_order_accumulating OWNER TO postgres;

--
-- TOC entry 3318 (class 0 OID 16508)
-- Dependencies: 211
-- Data for Name: dim_customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dim_customer VALUES (0, 3923, 'Ani');
INSERT INTO public.dim_customer VALUES (1, 3924, 'Budi');
INSERT INTO public.dim_customer VALUES (2, 3925, 'Caca');


--
-- TOC entry 3316 (class 0 OID 16498)
-- Dependencies: 209
-- Data for Name: dim_date; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dim_date VALUES (0, 691137792, '2020-03-08', 3, 1, 2020, true);
INSERT INTO public.dim_date VALUES (1, -366110782, '2020-09-17', 9, 3, 2020, false);
INSERT INTO public.dim_date VALUES (2, 199480210, '2020-10-05', 10, 4, 2020, false);
INSERT INTO public.dim_date VALUES (3, 1375097227, '2020-10-23', 10, 4, 2020, false);
INSERT INTO public.dim_date VALUES (4, 1662348298, '2021-01-11', 1, 1, 2021, false);
INSERT INTO public.dim_date VALUES (5, 922076539, '2021-02-02', 2, 1, 2021, false);
INSERT INTO public.dim_date VALUES (6, -691019836, '2020-03-09', 3, 1, 2020, false);
INSERT INTO public.dim_date VALUES (7, -1262179944, '2020-03-05', 3, 1, 2020, false);
INSERT INTO public.dim_date VALUES (8, 1847036956, '2020-07-19', 7, 3, 2020, true);
INSERT INTO public.dim_date VALUES (9, -1584098249, '2020-08-22', 8, 3, 2020, true);
INSERT INTO public.dim_date VALUES (10, 1649720770, '2020-09-17', 9, 3, 2020, false);
INSERT INTO public.dim_date VALUES (11, -158796314, '2020-10-13', 10, 4, 2020, false);
INSERT INTO public.dim_date VALUES (12, 1020424474, '2020-12-13', 12, 4, 2020, true);
INSERT INTO public.dim_date VALUES (13, 973843736, '2021-02-01', 2, 1, 2021, false);
INSERT INTO public.dim_date VALUES (14, -137295822, '2020-02-25', 2, 1, 2020, false);
INSERT INTO public.dim_date VALUES (15, -1951883509, '2020-03-02', 3, 1, 2020, false);
INSERT INTO public.dim_date VALUES (16, 1734841420, '2020-06-01', 6, 2, 2020, false);
INSERT INTO public.dim_date VALUES (17, 1297539520, '2020-07-13', 7, 3, 2020, false);
INSERT INTO public.dim_date VALUES (18, -1252272931, '2020-08-16', 8, 3, 2020, true);
INSERT INTO public.dim_date VALUES (19, 849277236, '2020-09-10', 9, 3, 2020, false);
INSERT INTO public.dim_date VALUES (20, -1119259512, '2020-10-09', 10, 4, 2020, false);
INSERT INTO public.dim_date VALUES (21, -242054994, '2020-11-16', 11, 4, 2020, false);
INSERT INTO public.dim_date VALUES (22, 444395358, '2020-12-04', 12, 4, 2020, false);
INSERT INTO public.dim_date VALUES (23, 834764519, '2021-01-23', 1, 1, 2021, true);


--
-- TOC entry 3317 (class 0 OID 16502)
-- Dependencies: 210
-- Data for Name: fact_order_accumulating; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.fact_order_accumulating VALUES (0, 834764519, 973843736, 922076539, 3923, 'ORD-205', 'INV-647', 'PYM-803', 7, 123.2, 9, 1);
INSERT INTO public.fact_order_accumulating VALUES (1, -1951883509, -1262179944, 691137792, 3923, 'ORD-223', 'INV-525', 'PYM-777', 18, 213.5, 3, 3);
INSERT INTO public.fact_order_accumulating VALUES (2, -1252272931, -1584098249, -366110782, 3924, 'ORD-142', 'INV-642', 'PYM-817', 9, 10.8, 6, 26);
INSERT INTO public.fact_order_accumulating VALUES (3, -1119259512, -158796314, 1375097227, 3924, 'ORD-201', 'INV-581', 'PYM-802', 7, 73.5, 4, 10);
INSERT INTO public.fact_order_accumulating VALUES (4, 849277236, 1649720770, 199480210, 3923, 'ORD-206', 'INV-557', 'PYM-792', 9, 10.8, 7, 18);
INSERT INTO public.fact_order_accumulating VALUES (5, 444395358, 1020424474, 1662348298, 3924, 'ORD-134', 'INV-587', 'PYM-761', 3, 3.6, 9, 29);


--
-- TOC entry 3176 (class 1259 OID 16513)
-- Name: ix_dim_customer_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dim_customer_index ON public.dim_customer USING btree (index);


--
-- TOC entry 3174 (class 1259 OID 16501)
-- Name: ix_dim_date_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_dim_date_index ON public.dim_date USING btree (index);


--
-- TOC entry 3175 (class 1259 OID 16507)
-- Name: ix_fact_order_accumulating_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_fact_order_accumulating_index ON public.fact_order_accumulating USING btree (index);


-- Completed on 2022-09-24 23:28:16

--
-- PostgreSQL database dump complete
--

