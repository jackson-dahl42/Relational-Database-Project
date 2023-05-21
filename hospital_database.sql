### Schema SQL

### Made Up Hospital Relational Database

### Create table to hold patient information
create table patient(
 id serial,
 name varchar,
 date_of_birth date,
 gender varchar,
 weight decimal,
 height decimal,
 blood_type varchar,
 address text,
 phone_number varchar,
 email varchar,
 primary key(id)
);

### This index will speed up the search for patients by name if there is a large number data in the table
### This might be useful for an employee at the hospital to quickly retrieve a patients information

create index index_patient_name ON patient (name);

### Create table to hold doctor information
create table doctor(
 id serial,
 name varchar,
 specialization varchar,
 address text,
 phone_number varchar,
 email varchar,
 primary key(id)
);

### Create table to hold appointment information
create table appointment(
 id serial,
 patient_id int references patient(id),
 doctor_id int references doctor(id),
 appointment_date date,
 primary key(id)
);

### Create table to hold diagnosis information
create table diagnosis(
 id serial,
 patient_id int references patient(id),
 doctor_id int references doctor(id),
 diagnosis_notes text,
 diagnosis_date date, 
 primary key(id)
);

### Create table to hold disease information
create table disease(
 id serial,
 name varchar,
 disease_description text,
 primary key(id)
);

### Create table to hold symptom information
create table symptom(
 id serial,
 name varchar,
 symptom_description text,
 primary key(id)
);

### Create a table for a many-to-many relationship between diagnosis and disease.
create table disease_diagnosis(
  diagnosis_id integer,
  disease_id integer,
  constraint fk_diagnosis_id foreign key(diagnosis_id) references diagnosis(id),
  constraint fk_disease_id foreign key(disease_id) references disease(id)
);

### Create a table for a many-to-many relationship between disease and symptom.
create table disease_symptom(
  disease_id integer,
  symptom_id integer,
  constraint fk_disease_id foreign key(disease_id) references disease(id),
  constraint fk_symptom_id foreign key(symptom_id) references symptom(id)
);

### Create table to hold prescription information
create table prescription(
 id serial,
 patient_id int references patient(id),
 doctor_id int references doctor(id),
 prescription_notes text,
 prescription_date date, 
 expiry_date date,
 primary key(id)
);

### Create table to hold medication information
create table medication(
 id serial,
 name varchar,
 medication_description text,
 cost decimal,
 primary key(id)
);

### Create a table for a many-to-many relationship prescription and medication.
create table prescription_medication(
  prescription_id integer,
  medication_id integer,
  constraint fk_prescription_id foreign key(prescription_id) references prescription(id),
  constraint fk_medication_id foreign key(medication_id) references medication(id)
);

### Populate the schema with fake information for a fake hospital

### This the data for the patient table
insert into patient (name, date_of_birth, gender, weight, height, blood_type, address, phone_number, email) values
('Jane Doe', '1984-01-09', 'F', '152', '175', 'AB-', 'SouthWest Ave 787, City, Province', '213-122-7779', 'jane2121@gmail.com'),
('Jill Doe', '1985-02-17', 'F', '151', '180', 'B+', 'West St 123, City, Province', '213-123-9323', 'jilldoe@email.com'),
('John Daniel', '1971-03-21', 'M', '180', '180', 'O-','North St 134, City, Province', '213-124-3213', 'johndaniel@email.com'),
('Zach Simmons', '1960-09-20', 'M', '170', '170', 'AB+', 'East St 242, City, Province', '213-232-2323', 'zachsimmons@email.com'),
('Elijah Fabian', '1990-11-23', 'M', '170', '190', 'B-', 'South St 241, Town, State', '213-132-3123', 'elijahfabian@email.com'),
('Spiridon Maquinna', '1982-10-1', 'M', '160', '200', 'B+', 'Up St 234, Town, Province', '213-313-3232', 'spiriddon1233@email.com'),
('Valter, Abdastartos', '1993-05-10', 'M', '190', '190', 'A+', 'Down Ave 131, City, Province', '213-313-4554', 'valt131@email.com'),
('Ashlynn Pallas', '1961-07-10', 'F', '150', '170', 'A+', 'Sideways St 134, City, Province', '213-134-1341', 'ashlynnp@hotmail.com'),
('Saraswati Ravinder', '1952-09-10', 'F', '150', '190', 'O+', 'Left Ave 494, Town, Province', '213-232-9595', 'saraswatiravinder@gmail.com'),
('Kata Hanna', '1957-02-12', 'F', '140', '150', 'O+', 'Right Ave 931, Town, Province', '213-231-1313', 'katahanna@email.com');

### This is the data for the doctor table
insert into doctor (name, specialization, address, phone_number, email) values
('Dr. Tim Smith', 'Cardiology', 'north st 124, city, province', '213-130-3919', 'smithtim@email.com'),
('Dr. Lisa Evans', 'Neurology', 'down st 204, town, province', '213-130-2131', 'lisa1212@email.com'),
('Dr. Lea Naliaka', 'Dermatology', 'up st 204, town, province,', '213-459-4994', 'leanaliaka@gmail.com'),
('Dr. Jaiden Alex', 'General Practitioner', 'left st 204, town, province,', '213-314-4593', 'jaiden1453@hotmail.com'),
('Dr. Pomare Haven', 'Internal Medicine', 'down ave 242, city, province', '213-314-4965', 'pomare123@email.com');

### This is the data for the appointment table
insert into appointment (patient_id, doctor_id, appointment_date) values
(1, 1, '2023-08-13'),
(2, 3, '2023-04-19'),
(5, 2, '2023-01-19'),
(6, 4, '2023-08-13'),
(3, 4, '2023-10-19'),
(2, 4, '2023-01-19'),
(1, 3, '2023-08-13'),
(10, 3, '2023-04-19'),
(2, 1, '2023-12-19'),
(8, 1, '2023-08-13'),
(2, 2, '2023-04-19'),
(7, 1, '2023-01-19');

### This is the data for the disease table
insert into disease (name, disease_description) values
('diabetes', 'disease related to metabolism of sugar'),
('hypertension', 'chronically high blood pressure'),
('multiple sclerosis', 'brain disease due to damage in myelin sheath'),
('alzheimers', 'brain disease related to reduced cognitive function'),
('asthma', 'inflammation and narrowing of the airways'),
('osteoporosis', 'space between bone marrow grows larger damaging bones'),
('meningitis', 'inflammation and swelling of the brain by infection'),
('common cold', 'mild infection of upper respiratory tract'),
('hepatitis', 'inflammation of the liver caused by a virus');

### This is the data for the symptom table
insert into symptom (name, symptom_description) values
('high blood pressure', 'high blood pressure measure on sphygmomanometer'),
('fatigue', 'chronic tiredness'),
('headache', 'pain in the head'),
('cough', 'sudden sharp exhale of air'),
('shortness of breath', 'difficulty breathing'),
('back and neck pain', 'pain in the back and neck'),
('cognitive impairment', 'problems thinking and planning'),
('blurry vision', 'difficulty focusing with eyesight'),
('jaundice', 'yellowing of the skin');

### This is for the many-to-many relationship between disease table and symptom table
insert into disease_symptom (disease_id, symptom_id) values
(1,8), (1,1), (1,2), (2,1), (3,2), (3,7), (3,8), (4,7), (5,4), (5,5), (6,6), (7,2), (7,3), (7,7), (7,8), (8,2), (8,3), (8,4), (9,2), (9,9)
;

### This is the data for the diagnosis table
insert into diagnosis (patient_id, doctor_id, diagnosis_notes, diagnosis_date) values
(1, 1, 'patient has disease brought on by stress', '2023-09-13'),
(2, 2, 'relapsing remitting multiple sclerosis, and early alzheimers', '2023-06-01'),
(3, 3, 'physical test shows patient has hepatitis', '2023-05-20'),
(5, 4, 'patient has the common cold', '2023-11-07'),
(4, 2, 'mental exam shows patient has decreased cognition', '2023-05-02'),
(6, 1, 'primary hypertension', '2023-12-10'),
(7, 2, 'MRI results shows meningitis', '2023-10-20'),
(8, 3, 'routine check up for diseases', '2023-03-21'),
(9, 4, 'patient has nothing more than a common cold', '2023-08-20'),
(10, 5, 'walk ever day for disease ', '2023-07-20');

### This is for the many-to-many relationship between disease table and diagnosis table
insert into disease_diagnosis (diagnosis_id, disease_id) values 
(1,2), (1,1), (2,3), (2,4), (3,9), (3,5), (4,8), (5,4), (6,2), (7,7), (8,1), (8,8), (9,8), (10,6)
;

insert into prescription (patient_id, doctor_id, prescription_notes, prescription_date, expiry_date) values
(1, 1, 'dose of xx ml for everyday', '2023-11-02', '2025-01-01'),
(5, 2, 'dose of xx ml do not drink with alcohol', '2023-10-12', '2024-04-01'),
(3, 4, 'purchase of inhaler alongside Rx', '2023-10-12', '2025-02-03'),
(8, 1, 'amount: xx ml ever odd day', '2023-06-02', '2025-04-12'),
(3, 3, 'for bacterial infection xx ml no more', '2023-07-03', '2025-04-03'),
(10, 4, 'xx ml available at xx xxxx for these days M W F ...', '2023-10-02', '2024-10-01')
;

insert into medication (name, medication_description, cost) values
('penicillin', 'antibiotic', 28),
('insulin', 'medication for diabetes', 35),
('aspirin', 'pain reliever', 10),
('bronchodilator', 'dilates bronchi for airflow', 18)
;

insert into prescription_medication (prescription_id, medication_id) values
(1,2), (2,3), (3,4), (3,3), (4,2), (4,3), (5,1), (6,1), (6,3)
;

### Query SQL

/*
This view creates a list of all the people with the common cold this type 
of query might be useful for detecting patients with a common cold and using 
this information to determine the relationship between people with this disease, 
for example if may be a hereditary disease, there are countless uses of 
creating a view of all the people with a certain disease
*/

/*
create view patients_common_cold as
select patient.id, patient.name
from patient
join diagnosis on patient.id = diagnosis.patient_id
join disease_diagnosis on diagnosis.id = disease_diagnosis.diagnosis_id
join disease on disease_diagnosis.disease_id = disease.id
where disease.name = 'common cold';

#select * from patients_common_cold;
*/

/*
This query uses grouping to count the number of people with a disease based on 
the number of diagnoses of that disease. This could be useful for governments 
and hospitals so they can see which diseases affect the highest number of people. 
This query shows common cold has the most cases
*/

/*
select disease.name, count(*)
from disease_diagnosis
join disease on disease_diagnosis.disease_id = disease.id
group by disease.name
order by count desc;
*/

/*
This creates a function that counts the number of prescriptions
there are of a certain drug. This could be used to determine 
how much a certain drug is used if a company wants to know
for their profits or how much in future to sell to the hospital
*/

/*
create or replace function count_number_of_prescriptions(drug_query varchar)
returns int as '
declare
    med_count int;
begin
    select count(*) into med_count
    from prescription_medication
    join medication on prescription_medication.medication_id = medication.id
    where medication.name = drug_query;

    return med_count;
end;
' language plpgsql;

select count_number_of_prescriptions('aspirin');
*/

/*
This is an example of a function that takes in a blood type and finds people with
the same blood type. This could be used to find people with compatible blood types
if someone is in need of a blood transfusion. For example someone with B- blood
can only accept B- and O- blood, so running the function with parameters such as these
could help find people who could donate blood with there contact information
*/

/*
create or replace function find_blood_type(input_blood_type VARCHAR)
returns table (
    id int,
    name varchar,
    date_of_birth date,
    gender varchar,
    weight decimal,
    height decimal,
    blood_type varchar,
    address text,
    phone_number varchar,
    email varchar) 
as '
begin
    return query
    select *
    from patient
    where patient.blood_type = input_blood_type;
end;
' language plpgsql;

select * from find_blood_type('B-');
select * from find_blood_type('O-');
*/

/*
Here is an example of a procedure of updating a someones weight. This is useful as people's 
weights change all of the time, and it can be required information by doctors for things such 
as metabolic processes or donating blood
*/

/*
create or replace procedure update_patient_weight(patient_id int, input_weight decimal)
language plpgsql as '
begin
    update patient
    set weight = input_weight
    where id = patient_id;
end;
';

call update_patient_weight(1, 160);
*/
