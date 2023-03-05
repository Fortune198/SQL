DROP TABLE my_contacts;
CREATE TABLE my_contacts (
	contact_id bigserial CONSTRAINT contact_id PRIMARY KEY,
	last_name varchar(30) NOT NULL,
	first_name varchar(30) NOT NULL,
	gender varchar(30) NOT NULL,
	phone varchar(10) NOT NULL,
	email varchar(30) NOT NULL,
	zip_code_id bigint REFERENCES zip_codes (zip_code_id) ON DELETE CASCADE,
	status_id bigint REFERENCES statuses (status_id) ON DELETE CASCADE,
	profession_id bigint REFERENCES professions (profession_id) ON DELETE CASCADE,
	);
	
	
INSERT INTO my_contacts 
(	
	last_name,
	first_name,
	gender,
	phone,
	email,
	zip_code_id,
	status_id,
	profession_id,

)
 
VALUES
('Tom','Smith','female','0780615009','tom@gmail.com', 1,1,1),
    ('Gugu','Ndaba','female','0780615012','gugu@gmail.com', 2,2,2),
    ('Jo','Nala','male','0780615078','jo@gmail.com', 1,1,3),
    ('Mary','Smith','female','0610615009','mary@gmail.com', 2,2,4),
    ('Kyle','Koo','male','0710615009','kyle@gmail.com', 1,2,1),
    ('Sizwe','Nchabe','male','0840615099','sizwe@gmail.com', 3,1,3),
    ('Liz','Sun','female','0830777009','liz@gmail.com', 3,1,2);

SELECT * FROM my_contacts;
	

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE zip_codes
(
	zip_code_id bigserial CONSTRAINT zip_code_id_key PRIMARY KEY,
	zip_code char(11) NOT NULL,
	city varchar(30) NOT NULL,
	state_name varchar(30) NOT NULL,
	state_abbr char(2) NOT NULL
);

INSERT INTO zip_codes (
	zip_code,
	city,
	state_name,
	state_abbr
)
VALUES
	('36013-36191','Mongomery','Alabama','AL'),
	('99703-99781','Fairbanks','Alaska','AK'),
	('85641-85705','Tucson','Arizona','AR');

SELECT * FROM zip_codes;

SELECT * 
FROM my_contacts AS cont
JOIN zip_codes AS zip
ON cont.zip_code_id = zip.zip_code_id;

----------------------------------------------------------------------------------------------------------------------

CREATE TABLE professions (
	profession_id bigserial CONSTRAINT profession_id_key PRIMARY KEY,
	profession varchar(30) NOT NULL
);

INSERT INTO professions (
	profession
)
VALUES 
('doctor'),
('teacher'),
('software developer'),
('student');

SELECT * FROM professions;

SELECT * 
FROM my_contacts AS cont
JOIN professions AS prof
ON cont.profession_id = prof.profession_id;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE statuses (
	status_id bigserial CONSTRAINT status_id_key PRIMARY KEY,
	status varchar(30) NOT NULL
);

INSERT INTO statuses (
	status
)
VALUES 
('single'),
('divorced');

SELECT * FROM statuses;

SELECT * 
FROM my_contacts AS cont
JOIN statuses AS sta
ON cont.status_id = sta.status_id;

===================================================================================================================================

CREATE TABLE seekings (
	seeking_id BIGSERIAL CONSTRAINT seeking_id_key PRIMARY KEY,
	seeking VARCHAR(50)NOT NULL UNIQUE
);

INSERT INTO seekings (
	seeking
)
VALUES 
( 'single male'),
('single female'),
('same profession'),
('under 25'),
('over 50'),
('under 50'),
('employed'),
('retired');

DROP TABLE seekings;

SELECT * FROM seekings;

===================================================================================================================================



CREATE TABLE seeking_contact (
	contact_id BIGINT NOT NULL REFERENCES my_contacts(contact_id),
	seeking_id BIGINT NOT NULL REFERENCES seekings(seeking_id)
);

INSERT INTO seeking_contact (
	contact_id,
	seeking_id
)
VALUES
	(1,1),
	(1,3),
	(1,5),
	(2,7),
	(2,1),
	(3,3),
	(3,4),
	(3,5),
	(3,6),
	(4,1),
	(5,2),
	(6,1),
	(6,3),
	(7,2);
	
	
SELECT * FROM seeking_contact;

SELECT c.first_name, c.last_name, s.seeking
FROM my_contacts AS c
JOIN seeking_contact AS sc
ON c.contact_id = sc.contact_id
JOIN seekings AS s
ON s.seeking_id = sc.seeking_id;

DROP TABLE seeking_contact;


======================================================================================================================================================================================================

CREATE TABLE interests (
	interest_id BIGSERIAL CONSTRAINT interest_id_key PRIMARY KEY,
	interest varchar(40) NOT NULL 
);

INSERT INTO interests (
	interest
)
VALUES 
	('hiking'),
	('reading'),
	('biking'),
	('cooking'),
	('running'),
	('diving'),
	('studying'),
	('reading'),
	('cycling'),
	('art'),
	('walkimg');


DROP TABLE interests;

SELECT * FROM interests;

================================================================================================================================================================
	 
CREATE TABLE interest_contact (
	contact_id BIGINT NOT NULL REFERENCES my_contacts(contact_id),
	interest_id BIGINT NOT NULL REFERENCES interests(interest_id)
);

INSERT INTO interest_contact (
	contact_id,
	interest_id
)

VALUES 
	(1,1),
	(1,2),
	(1,3),
	(2,1),
	(2,4),
	(2,5),
	(3,1),
	(3,6),
	(3,3),
	(4,7),
	(4,2),
	(4,9),
	(5,10),
	(5,8),
	(5,9),
	(6,1),
	(6,8),
	(6,9),
	(7,11),
	(7,2),
	(7,3);
	

SELECT c.first_name, c.last_name, i.interest
FROM my_contacts AS c
JOIN interest_contact AS ic
ON c.contact_id = ic.contact_id
JOIN interests AS i
ON i.interest_id = ic.interest_id;

SELECT * FROM interest_contact;


=============================================================================================================================================================================================





