--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: ltree; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS ltree WITH SCHEMA public;


--
-- Name: EXTENSION ltree; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION ltree IS 'data type for hierarchical tree-like structures';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE account (
    id integer NOT NULL,
    first_name text,
    last_name text,
    email text,
    phone1 text,
    phone2 text,
    address1 text,
    address2 text,
    city text,
    state text,
    country text,
    user_id_added integer,
    date_added timestamp without time zone,
    user_id_modified integer,
    date_modified timestamp without time zone,
    notes text,
    enabled boolean DEFAULT true NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE account OWNER TO jareds;

--
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE account_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE account_id_seq OWNER TO jareds;

--
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE account_id_seq OWNED BY account.id;


--
-- Name: category; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE category (
    id integer NOT NULL,
    category text,
    enabled boolean DEFAULT true NOT NULL,
    path ltree
);


ALTER TABLE category OWNER TO jareds;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE category_id_seq OWNER TO jareds;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE category_id_seq OWNED BY category.id;


--
-- Name: content; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE content (
    id bigint NOT NULL,
    user_id integer,
    date_published timestamp without time zone DEFAULT now(),
    content text,
    date_updated timestamp without time zone DEFAULT now(),
    modifiedby_user_id integer,
    enabled boolean DEFAULT true,
    account_id integer NOT NULL,
    template_id integer
);


ALTER TABLE content OWNER TO jareds;

--
-- Name: content_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE content_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE content_id_seq OWNER TO jareds;

--
-- Name: content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE content_id_seq OWNED BY content.id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE menu (
    id integer NOT NULL,
    menu text NOT NULL,
    slug text,
    date_added timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone DEFAULT now(),
    addedby_user_id integer,
    modifiedby_user_id integer,
    path text,
    parent_path text,
    parent_id integer,
    sort_order integer,
    enabled boolean DEFAULT true
);


ALTER TABLE menu OWNER TO jareds;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu_id_seq OWNER TO jareds;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE menu_id_seq OWNED BY menu.id;


--
-- Name: slug; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE slug (
    id bigint NOT NULL,
    content_id integer NOT NULL,
    slug text NOT NULL,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE slug OWNER TO jareds;

--
-- Name: slug_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE slug_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE slug_id_seq OWNER TO jareds;

--
-- Name: slug_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE slug_id_seq OWNED BY slug.id;


--
-- Name: template; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE template (
    id integer NOT NULL,
    date_added timestamp without time zone DEFAULT now(),
    date_modified timestamp without time zone DEFAULT now(),
    addedby_user_id integer,
    modifiedby_user_id integer,
    name text,
    content text,
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE template OWNER TO jareds;

--
-- Name: template_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE template_id_seq OWNER TO jareds;

--
-- Name: template_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE template_id_seq OWNED BY template.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: jareds
--

CREATE TABLE users (
    id integer NOT NULL,
    username character varying(180) NOT NULL,
    username_canonical character varying(180) NOT NULL,
    email character varying(180) NOT NULL,
    email_canonical character varying(180) NOT NULL,
    enabled boolean NOT NULL,
    salt character varying(255) DEFAULT NULL::character varying,
    password character varying(255) NOT NULL,
    last_login timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    confirmation_token character varying(180) DEFAULT NULL::character varying,
    password_requested_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    roles json,
    sessionid text
);


ALTER TABLE users OWNER TO jareds;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: jareds
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO jareds;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: jareds
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: account id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY account ALTER COLUMN id SET DEFAULT nextval('account_id_seq'::regclass);


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY category ALTER COLUMN id SET DEFAULT nextval('category_id_seq'::regclass);


--
-- Name: content id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY content ALTER COLUMN id SET DEFAULT nextval('content_id_seq'::regclass);


--
-- Name: menu id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY menu ALTER COLUMN id SET DEFAULT nextval('menu_id_seq'::regclass);


--
-- Name: slug id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY slug ALTER COLUMN id SET DEFAULT nextval('slug_id_seq'::regclass);


--
-- Name: template id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY template ALTER COLUMN id SET DEFAULT nextval('template_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY account (id, first_name, last_name, email, phone1, phone2, address1, address2, city, state, country, user_id_added, date_added, user_id_modified, date_modified, notes, enabled, user_id) FROM stdin;
1	Jared	Santibanez	jay_565@yahoo.com	123-456-789		400 Bur Oak Trl		Forney	TX	US	\N	\N	\N	\N	Good Customer	t	1
\.


--
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('account_id_seq', 1, false);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY category (id, category, enabled, path) FROM stdin;
3	Electrician	t	Top.Electrical
1	Plumber	t	Top.Plumber
2	Restaurant	t	Top.Restaurant
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('category_id_seq', 3, true);


--
-- Data for Name: content; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY content (id, user_id, date_published, content, date_updated, modifiedby_user_id, enabled, account_id, template_id) FROM stdin;
1	\N	2017-11-04 16:35:01.294674	<head>\n    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">    \n    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">    \n\n<style>\n\n  /* Conatct start */\n\n        .header-title\n        {\ntext-align:center;\n          color:#00bfff;\n        }\n\n        #tip \n        {\n            display:none;  \n        }\n\n        .fadeIn\n        {\n          animation-duration: 3s;\n        }\n\n        .form-control\n        {\n          border-radius:0px;\n          border:1px solid #EDEDED;\n        }\n\n        .form-control:focus\n        {\n          border:1px solid #00bfff;\n        }\n\n        .textarea-contact\n        {\n          resize:none; \n        }\n\n        .btn-send\n        {\n          border-radius: 0px;\n          border:1px solid #00bfff;\n          background:#00bfff;\n          color:#fff; \n        }\n\n        .btn-send:hover\n        {\n          border:1px solid #00bfff;\n          background:#fff;\n          color:#00bfff;\n          transition:background 0.5s;   \n        }\n\n        .second-portion\n        {\n          margin-top:50px; \n        }\n\n            @import "//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css";\n    @import "http://fonts.googleapis.com/css?family=Roboto:400,500";\n\n    .box > .icon { text-align: center; position: relative; }\n    .box > .icon > .image { position: relative; z-index: 2; margin: auto; width: 88px; height: 88px; border: 8px solid white; line-height: 88px; border-radius: 50%; background: #00bfff; vertical-align: middle; }\n    .box > .icon:hover > .image { background: #333; }\n    .box > .icon > .image > i { font-size: 36px !important; color: #fff !important; }\n    .box > .icon:hover > .image > i { color: white !important; }\n    .box > .icon > .info { margin-top: -24px; background: rgba(0, 0, 0, 0.04); border: 1px solid #e0e0e0; padding: 15px 0 10px 0; min-height:163px;}\n    .box > .icon:hover > .info { background: rgba(0, 0, 0, 0.04); border-color: #e0e0e0; color: white; }\n    .box > .icon > .info > h3.title { font-family: "Robot",sans-serif !important; font-size: 16px; color: #222; font-weight: 700; }\n    .box > .icon > .info > p { font-family: "Robot",sans-serif !important; font-size: 13px; color: #666; line-height: 1.5em; margin: 20px;}\n    .box > .icon:hover > .info > h3.title, .box > .icon:hover > .info > p, .box > .icon:hover > .info > .more > a { color: #222; }\n    .box > .icon > .info > .more a { font-family: "Robot",sans-serif !important; font-size: 12px; color: #222; line-height: 12px; text-transform: uppercase; text-decoration: none; }\n    .box > .icon:hover > .info > .more > a { color: #fff; padding: 6px 8px; background-color: #63B76C; }\n    .box .space { height: 30px; }\n\n    @media only screen and (max-width: 768px)\n    {\n      .contact-form\n      {\n        margin-top:25px; \n      }\n\n      .btn-send\n      {\n        width: 100%;\n        padding:10px; \n      }\n\n      .second-portion\n      {\n        margin-top:25px; \n      }\n    }\n  /* Conatct end */\n</style>\n</head>\n<div class="container animated fadeIn">\n\n  <div class="row">\n    <h1 class="header-title"> I am a Plumber  </h1>\n<div class="header-title">\n<a class="btn btn-primary btn-lg" href="tel:213-123-xxxx">Call me: 214-123-xxxx</a>\n</div>\n    <hr>\n    <div class="col-sm-12" id="parent">\n      <div class="col-sm-6">\n      <iframe width="100%" height="320px;" src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d13425.90921800701!2d-96.4663289!3d32.726514449999996!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x864ead86c0a19901%3A0x2da48e1311a76e17!2sForney+Community+Park!5e0!3m2!1sen!2sus!4v1509886172311" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>\n      </div>\n\n      <div class="col-sm-6">\n        <form action="form.php" class="contact-form" method="post">\n  \n            <div class="form-group">\n              <input type="text" class="form-control" id="name" name="nm" placeholder="Name" required="" autofocus="">\n            </div>\n        \n        \n            <div class="form-group form_left">\n              <input type="email" class="form-control" id="email" name="em" placeholder="Email" required="">\n            </div>\n        \n          <div class="form-group">\n               <input type="tel" class="form-control" id="phone" onkeypress="return event.charCode >= 48 && event.charCode <= 57" maxlength="10" placeholder="Mobile No." required="">\n          </div>\n          <div class="form-group">\n          <textarea class="form-control textarea-contact" rows="5" id="comment" name="FB" placeholder="Inquiry" required=""></textarea>\n          <br>\n            <button class="btn btn-default btn-send"> <span class="glyphicon glyphicon-send"></span> Send </button>\n          </div>\n        </form>\n      </div>\n    </div>\n  </div>\n\n  <div class="container second-portion">\n  <div class="row">\n        <!-- Boxes de Acoes -->\n      <div class="col-xs-12 col-sm-6 col-lg-4">\n      <div class="box">             \n        <div class="icon">\n          <div class="image"><i class="fa fa-envelope" aria-hidden="true"></i></div>\n          <div class="info">\n            <h3 class="title">MAIL & WEBSITE</h3>\n            <p>\n              <i class="fa fa-envelope" aria-hidden="true"></i> &nbsp example@gmail.com\n              <br>\n              <br>\n              <i class="fa fa-globe" aria-hidden="true"></i> &nbsp www.example.com\n            </p>\n          \n          </div>\n        </div>\n        <div class="space"></div>\n      </div> \n    </div>\n      \n        <div class="col-xs-12 col-sm-6 col-lg-4">\n      <div class="box">             \n        <div class="icon">\n          <div class="image"><i class="fa fa-mobile" aria-hidden="true"></i></div>\n          <div class="info">\n            <h3 class="title">CONTACT</h3>\n              <p>\n              <i class="fa fa-mobile" aria-hidden="true"></i> &nbsp (214)-9624-XXXX\n              <br>\n              <br>\n              <i class="fa fa-mobile" aria-hidden="true"></i> &nbsp  (972)-7567-XXXX \n            </p>\n          </div>\n        </div>\n        <div class="space"></div>\n      </div> \n    </div>\n      \n        <div class="col-xs-12 col-sm-6 col-lg-4">\n      <div class="box">             \n        <div class="icon">\n          <div class="image"><i class="fa fa-map-marker" aria-hidden="true"></i></div>\n          <div class="info">\n            <h3 class="title">ADDRESS</h3>\n              <p>\n               <i class="fa fa-map-marker" aria-hidden="true"></i> &nbsp 241 S Farm to Market 548, Forney, TX 75126\n            </p>\n          </div>\n        </div>\n        <div class="space"></div>\n      </div> \n    </div>        \n    <!-- /Boxes de Acoes -->\n    \n    <!--My Portfolio  dont Copy this -->\n      \n  </div>\n</div>\n\n</div>	2017-11-04 16:35:01.294674	\N	t	1	1
\.


--
-- Name: content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('content_id_seq', 1, true);


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY menu (id, menu, slug, date_added, date_modified, addedby_user_id, modifiedby_user_id, path, parent_path, parent_id, sort_order, enabled) FROM stdin;
\.


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('menu_id_seq', 1, false);


--
-- Data for Name: slug; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY slug (id, content_id, slug, enabled) FROM stdin;
1	1	forneytx/plumber	t
2	1	75126/plumber	t
\.


--
-- Name: slug_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('slug_id_seq', 2, true);


--
-- Data for Name: template; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY template (id, date_added, date_modified, addedby_user_id, modifiedby_user_id, name, content, enabled) FROM stdin;
1	2017-11-05 06:40:19.533758	2017-11-05 06:40:19.533758	1	1	Contact Form 1	<head>\n    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">    \n</head>\n<div class="container animated fadeIn">\n\n  <div class="row">\n    <h1 class="header-title"> Contact </h1>\n    <hr>\n    <div class="col-sm-12" id="parent">\n    \t<div class="col-sm-6">\n    \t<iframe width="100%" height="320px;" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/place?q=place_id:ChIJaY32Qm3KWTkRuOnKfoIVZws&key=AIzaSyAf64FepFyUGZd3WFWhZzisswVx2K37RFY" allowfullscreen></iframe>\n    \t</div>\n\n    \t<div class="col-sm-6">\n    \t\t<form action="form.php" class="contact-form" method="post">\n\t\n\t\t        <div class="form-group">\n\t\t          <input type="text" class="form-control" id="name" name="nm" placeholder="Name" required="" autofocus="">\n\t\t        </div>\n\t\t    \n\t\t    \n\t\t        <div class="form-group form_left">\n\t\t          <input type="email" class="form-control" id="email" name="em" placeholder="Email" required="">\n\t\t        </div>\n\t\t    \n\t\t      <div class="form-group">\n\t\t           <input type="text" class="form-control" id="phone" onkeypress="return event.charCode >= 48 && event.charCode <= 57" maxlength="10" placeholder="Mobile No." required="">\n\t\t      </div>\n\t\t      <div class="form-group">\n\t\t      <textarea class="form-control textarea-contact" rows="5" id="comment" name="FB" placeholder="Type Your Message/Feedback here..." required=""></textarea>\n\t\t      <br>\n\t      \t  <button class="btn btn-default btn-send"> <span class="glyphicon glyphicon-send"></span> Send </button>\n\t\t      </div>\n     \t\t</form>\n    \t</div>\n    </div>\n  </div>\n\n  <div class="container second-portion">\n\t<div class="row">\n        <!-- Boxes de Acoes -->\n    \t<div class="col-xs-12 col-sm-6 col-lg-4">\n\t\t\t<div class="box">\t\t\t\t\t\t\t\n\t\t\t\t<div class="icon">\n\t\t\t\t\t<div class="image"><i class="fa fa-envelope" aria-hidden="true"></i></div>\n\t\t\t\t\t<div class="info">\n\t\t\t\t\t\t<h3 class="title">MAIL & WEBSITE</h3>\n\t\t\t\t\t\t<p>\n\t\t\t\t\t\t\t<i class="fa fa-envelope" aria-hidden="true"></i> &nbsp gondhiyahardik6610@gmail.com\n\t\t\t\t\t\t\t<br>\n\t\t\t\t\t\t\t<br>\n\t\t\t\t\t\t\t<i class="fa fa-globe" aria-hidden="true"></i> &nbsp www.hardikgondhiya.com\n\t\t\t\t\t\t</p>\n\t\t\t\t\t\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="space"></div>\n\t\t\t</div> \n\t\t</div>\n\t\t\t\n        <div class="col-xs-12 col-sm-6 col-lg-4">\n\t\t\t<div class="box">\t\t\t\t\t\t\t\n\t\t\t\t<div class="icon">\n\t\t\t\t\t<div class="image"><i class="fa fa-mobile" aria-hidden="true"></i></div>\n\t\t\t\t\t<div class="info">\n\t\t\t\t\t\t<h3 class="title">CONTACT</h3>\n    \t\t\t\t\t<p>\n\t\t\t\t\t\t\t<i class="fa fa-mobile" aria-hidden="true"></i> &nbsp (+91)-9624XXXXX\n\t\t\t\t\t\t\t<br>\n\t\t\t\t\t\t\t<br>\n\t\t\t\t\t\t\t<i class="fa fa-mobile" aria-hidden="true"></i> &nbsp  (+91)-7567065254 \n\t\t\t\t\t\t</p>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="space"></div>\n\t\t\t</div> \n\t\t</div>\n\t\t\t\n        <div class="col-xs-12 col-sm-6 col-lg-4">\n\t\t\t<div class="box">\t\t\t\t\t\t\t\n\t\t\t\t<div class="icon">\n\t\t\t\t\t<div class="image"><i class="fa fa-map-marker" aria-hidden="true"></i></div>\n\t\t\t\t\t<div class="info">\n\t\t\t\t\t\t<h3 class="title">ADDRESS</h3>\n    \t\t\t\t\t<p>\n\t\t\t\t\t\t\t <i class="fa fa-map-marker" aria-hidden="true"></i> &nbsp 15/3 Junction Plot \n\t\t\t\t\t\t\t "Shree Krishna Krupa", Rajkot - 360001.\n\t\t\t\t\t\t</p>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t\t<div class="space"></div>\n\t\t\t</div> \n\t\t</div>\t\t    \n\t\t<!-- /Boxes de Acoes -->\n\t\t\n\t\t<!--My Portfolio  dont Copy this -->\n\t    \n\t</div>\n</div>\n\n</div>	t
2	2017-11-05 06:58:58.502726	2017-11-05 06:58:58.502726	1	1	Contact Form No Map	<head>\n<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">    \n    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">    \n<style>\nsection#contact {\n    background-color: #222222;\n    background-image: url('http://artdnaswitchbd.com/componants/images/map-image.png');\n    background-position: center;\n    background-repeat: no-repeat;\n}\nsection {\n    padding: 30px 0PX;\n}\nsection#contact .section-heading {\n    color: white;\n}\nsection#contact .form-group {\n    margin-bottom: 25px;\n}\nsection#contact .form-group input,\nsection#contact .form-group textarea {\n    padding: 20px;\n}\nsection#contact .form-group input.form-control {\n    height: auto;\n}\nsection#contact .form-group textarea.form-control {\n    height: 236px;\n}\nsection#contact .form-control:focus {\n    border-color: #fed136;\n    box-shadow: none;\n}\nsection#contact ::-webkit-input-placeholder {\n    font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;\n    text-transform: uppercase;\n    font-weight: 700;\n    color: #eeeeee;\n}\n.gellary_bg_none img{\n\twidth: 100%;\n\theight: 250px;\n}\nsection#contact :-moz-placeholder {\n    /* Firefox 18- */\n    font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;\n    text-transform: uppercase;\n    font-weight: 700;\n    color: #eeeeee;\n}\nsection#contact ::-moz-placeholder {\n    /* Firefox 19+ */\n    font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;\n    text-transform: uppercase;\n    font-weight: 700;\n    color: #eeeeee;\n}\nsection#contact :-ms-input-placeholder {\n    font-family: "Montserrat", "Helvetica Neue", Helvetica, Arial, sans-serif;\n    text-transform: uppercase;\n    font-weight: 700;\n    color: #eeeeee;\n}\nsection#contact .text-danger {\n    color: #e74c3c;\n}\n\n.about_our_company{\n    text-align: center;\n}\n.about_our_company h1{\n    font-size: 25px;\n}\n.titleline-icon {\n    position: relative;\n    max-width: 100px;\n    border-top: 4px double #F99700;\n    margin: 20px auto 20px;\n}\n.titleline-icon:after {\n    position: absolute;\n    top: -11px;\n    left: 0;\n    right: 0;\n    margin: auto;\n    font-family: 'FontAwesome';\n    content: "\\f141";\n    font-size: 20px;\n    line-height: 1;\n    color: #F99700;\n    text-align: center;\n    vertical-align: middle;\n    width: 40px;\n    height: 20px;\n    background: #ffffff;\n}\n\n</style>\n</head>\n\t<section id="contact" style="">\n            <div class="container">\n                <div class="row">\n                    <div class="about_our_company" style="margin-bottom: 20px;">\n                        <h1 style="color:#fff;">Write Your Message</h1>\n                        <div class="titleline-icon"></div>\n                        <p style="color:#fff;">Lorem Ipsum is simply dummy text of the printing and typesetting </p>\n                    </div>\n                </div>\n                <div class="row">\n                    <div class="col-md-8">\n                        <form name="sentMessage" id="contactForm" novalidate="">\n                            <div class="row">\n                                <div class="col-md-6">\n                                    <div class="form-group">\n                                        <input type="text" class="form-control" placeholder="Your Name *" id="name" required="" data-validation-required-message="Please enter your name.">\n                                        <p class="help-block text-danger"></p>\n                                    </div>\n                                    <div class="form-group">\n                                        <input type="email" class="form-control" placeholder="Your Email *" id="email" required="" data-validation-required-message="Please enter your email address.">\n                                        <p class="help-block text-danger"></p>\n                                    </div>\n                                    <div class="form-group">\n                                        <input type="tel" class="form-control" placeholder="Your Phone *" id="phone" required="" data-validation-required-message="Please enter your phone number.">\n                                        <p class="help-block text-danger"></p>\n                                    </div>\n                                </div>\n                                <div class="col-md-6">\n                                    <div class="form-group">\n                                        <textarea class="form-control" placeholder="Your Message *" id="message" required="" data-validation-required-message="Please enter a message."></textarea>\n                                        <p class="help-block text-danger"></p>\n                                    </div>\n                                </div>\n                                <div class="clearfix"></div>\n                                <div class="col-lg-12 text-center">\n                                    <div id="success"></div>\n                                    <button type="submit" class="btn btn-xl get">Send Message</button>\n                                </div>\n                            </div>\n                        </form>\n                    </div>\n                    <div class="col-md-4">\n                        <p style="color:#fff;">\n                            <strong><i class="fa fa-map-marker"></i> Address</strong><br>\n                            1216/Mirpur_10 Beach, Dhaka(Bangladesh)\n                        </p>\n                        <p style="color:#fff;"><strong><i class="fa fa-phone"></i> Phone Number</strong><br>\n                            (+8801)7123456</p>\n                        <p style="color:#fff;">\n                            <strong><i class="fa fa-envelope"></i>  Email Address</strong><br>\n                            Email@info.com</p>\n                        <p></p>\n                    </div>\n                </div>\n            </div>\n        </section>	t
\.


--
-- Name: template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('template_id_seq', 2, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: jareds
--

COPY users (id, username, username_canonical, email, email_canonical, enabled, salt, password, last_login, confirmation_token, password_requested_at, first_name, last_name, roles, sessionid) FROM stdin;
1	admin	admin	admin@savvylogics.com	admin@savvylogics.com	t	\N	$2y$11$UDQsuCwPAbixQ.ukjlbSVOdzD8WrmMuA1k.U2Pq4ZgBxIZBeP5ike	2017-10-11 21:04:42	\N	\N	Jane	Doe	\N	457189e31f735255338776dc32f72048
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: jareds
--

SELECT pg_catalog.setval('users_id_seq', 1, false);


--
-- Name: account account_id_pkey; Type: CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_id_pkey PRIMARY KEY (id);


--
-- Name: content content_pkey; Type: CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY content
    ADD CONSTRAINT content_pkey PRIMARY KEY (id);


--
-- Name: slug slug_pkey; Type: CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY slug
    ADD CONSTRAINT slug_pkey PRIMARY KEY (id);


--
-- Name: users user_pkey; Type: CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: users users_username_ukey; Type: CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_username_ukey UNIQUE (username);


--
-- Name: slug_slug_lower_idx; Type: INDEX; Schema: public; Owner: jareds
--

CREATE UNIQUE INDEX slug_slug_lower_idx ON slug USING btree (slug);


--
-- Name: account account_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_user_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: content conent_account_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY content
    ADD CONSTRAINT conent_account_fkey FOREIGN KEY (account_id) REFERENCES account(id);


--
-- Name: slug slug_content_fkey; Type: FK CONSTRAINT; Schema: public; Owner: jareds
--

ALTER TABLE ONLY slug
    ADD CONSTRAINT slug_content_fkey FOREIGN KEY (content_id) REFERENCES content(id);


--
-- PostgreSQL database dump complete
--

