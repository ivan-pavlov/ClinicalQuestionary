CREATE TABLE doctor (
	id integer PRIMARY KEY AUTOINCREMENT,
	login string UNIQUE,
	pw integer
);

CREATE TABLE patient (
	id integer PRIMARY KEY AUTOINCREMENT,
	doctor_id integer,
	name string NOT NULL UNIQUE,
	sex string,
	dateofbirth date,
        hsctdate date,
        dischargedate date,
        registration integer UNIQUE,
        posthsctprogression string,
        comments string
);

CREATE TABLE survey (
	id integer PRIMARY KEY AUTOINCREMENT,
	questionary_id integer,
	patient_id integer,
	survey_date date,
	results string
);

CREATE TABLE questionary (
	id integer PRIMARY KEY AUTOINCREMENT,
	date date
);

CREATE TABLE question (
	id integer PRIMARY KEY AUTOINCREMENT,
	question string,
	type integer,
	answers string,
	critical boolean
);

CREATE TABLE quest_quest (
	id integer PRIMARY KEY AUTOINCREMENT,
	questionary_id integer,
	question_id integer
);

CREATE TABLE doc_quest (
	id integer PRIMARY KEY AUTOINCREMENT,
	questionary_id integer,
	doctor_id integer
);
