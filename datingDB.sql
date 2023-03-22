--Creating table my_contacts


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
	seeking_id BIGINT NOT NULL REFERENCES seekings(seeking_id),
	interest_id BIGINT NOT NULL REFERENCES interests(interest_id) 
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
	seeking_id,
	interest_id
)
 
VALUES
('Tom','Smith','female','0780615009','tom@gmail.com', 1,1,1,2,7),
    ('Gugu','Ndaba','female','0780615012','gugu@gmail.com', 2,2,2,8,10),
    ('Jo','Nala','male','0780615078','jo@gmail.com', 4,1,3,6,11),
    ('Mary','Smith','female','0610615009','mary@gmail.com', 5,2,4,5,7),
    ('Kyle','Koo','male','0710615009','kyle@gmail.com', 10,2,1,3,4),
    ('Sizwe','Nchabe','male','0840615099','sizwe@gmail.com', 9,1,3,8,2),
    ('Liz','Sun','female','0830777009','liz@gmail.com', 7,1,2,7,1),
	('Elliot','Moloto','male','0735255128','elliotm19@outlook.com',2,1,4,1,3),
	('Jessica','Mills','female','0789986545','jessmills@outlook.com',4,1,3,7,9),
	('Bonolo','November','female','0761231123','bonolonov98@gmail.com',3,2,1,5,8),
	('Jason','Borne','male','0832526485','jasonbourne@gmail.com',8,1,2,6,3),
	('Maria','Gates','female','0863659624','mariagates213@outlook.com',4,2,4,4,5),
	('Gareth','Jill','male','0892547894','garethj11@gmail.com',3,1,1,6,4),
	('Whitey','Black','male','0633659862','whiteybl232@outlook.com',1,2,1,8,5),
	('Manny','Musk','male','0625684756','mannymusk2329@oulook.com',9,1,3,4,7),
	('Vusi','Nkosi','male','0798851457','vusinko00@gmail.com',10,2,4,2,10);
	
SELECT * FROM my_contacts;
	

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Zip_code table


CREATE TABLE zip_codes
(
	zip_code_id bigserial CONSTRAINT zip_code_id_key PRIMARY KEY,
	zip_code char(4) NOT NULL CHECK (length(zip_code) <= 4),
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
	('3601','Mongomery','Alabama','AL'),
	('9970','Fairbanks','Alaska','AK'),
	('8564','Tucson','Arizona','AR'),
	('2565','California','Los Angeles','LA'),
	('8988','California','San Diego','SD'),
	('3152','Taxes','San Antonio','SA'),
	('7546','Pennsylvania','Philadelphia','PH'),
	('5879','Ohio','Columbus','CL'),
	('7845','Washington','Seattle','SE'),
	('2587','Nevada','Las Vegas','LV');

SELECT * FROM zip_codes;

SELECT * 
FROM my_contacts AS cont
JOIN zip_codes AS zip
ON cont.zip_code_id = zip.zip_code_id;

----------------------------------------------------------------------------------------------------------------------
--professions table


CREATE TABLE professions (
    profession_id bigserial CONSTRAINT profession_id_key PRIMARY KEY,
    profession varchar(30) UNIQUE NOT NULL
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
--statuses table

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
--seeking table


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
--interest table


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
	('walking');


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
	
SELECT * FROM interest_contact;
-----------------------------------------------------------------------------------------------------------------

SELECT c.first_name, c.last_name, i.interest
FROM my_contacts AS c
JOIN interest_contact AS ic
ON c.contact_id = ic.contact_id
JOIN interests AS i
ON i.interest_id = ic.interest_id;

SELECT * FROM interest_contact;

=============================================================================================================================================================================================
--Left join

SELECT 
  prof.profession, 
  zip.zip_code, 
  zip.city, 
  zip.state_name as province, 
  sta.status, 
  int.interest, 
  sek.seeking
FROM 
  my_contacts AS cont
  LEFT JOIN zip_codes AS zip ON cont.zip_code_id = zip.zip_code_id
  LEFT JOIN professions AS prof ON cont.profession_id = prof.profession_id
  LEFT JOIN statuses AS sta ON cont.status_id = sta.status_id
  LEFT JOIN interests AS int ON cont.interest_id = int.interest_id
  LEFT JOIN seekings AS sek ON cont.seeking_id = sek.seeking_id;
