library(RSQLite)
db <- dbConnect(SQLite(), dbname="./docs/test.sqlite")
dbSendQuery(conn = db,"CREATE TABLE doctor (
	id integer PRIMARY KEY AUTOINCREMENT,
	login string,
	pw integer
);")
dbSendQuery(conn = db,"CREATE TABLE patient (
	id integer PRIMARY KEY AUTOINCREMENT,
	doctor_id integer,
	name string,
	sex binary,
	dateofbirth date
);")
dbSendQuery(conn = db,"CREATE TABLE survey (
	id integer PRIMARY KEY AUTOINCREMENT,
	questionary_id integer,
	patient_id integer,
	survey_date date,
	results string
);")
dbSendQuery(conn = db,"CREATE TABLE questionary (
	id integer PRIMARY KEY AUTOINCREMENT,
	date date
);")
dbSendQuery(conn = db,"CREATE TABLE question (
	id integer PRIMARY KEY AUTOINCREMENT,
	question string,
	type integer,
	answers string,
	critical boolean
);")
dbSendQuery(conn = db,"CREATE TABLE quest_quest (
	id integer PRIMARY KEY AUTOINCREMENT,
	questionary_id integer,
	question_id integer
);")
dbSendQuery(conn = db,"CREATE TABLE doc_quest (
	id integer PRIMARY KEY AUTOINCREMENT,
	questionary_id integer,
	doctor_id integer
);")
dbDisconnect(db)