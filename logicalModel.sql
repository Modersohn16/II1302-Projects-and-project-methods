CREATE TABLE available_time (
 available_time_id INT NOT NULL,
 available_time TIMESTAMP(6)
);

ALTER TABLE available_time ADD CONSTRAINT PK_available_time PRIMARY KEY (available_time_id);


CREATE TABLE instrument (
 instrument_id VARCHAR(100) NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (instrument_id);


CREATE TABLE personal_data (
 personal_data_id INT NOT NULL,
 name VARCHAR(200) NOT NULL,
 age VARCHAR(10) NOT NULL,
 social_security_Nr VARCHAR(15) NOT NULL,
 street VARCHAR(100),
 zipcode VARCHAR(10),
 city VARCHAR(100),
 phone_nr VARCHAR(20) NOT NULL,
 email VARCHAR(100) NOT NULL
);

ALTER TABLE personal_data ADD CONSTRAINT PK_personal_data PRIMARY KEY (personal_data_id);


CREATE TABLE rental_instrument (
 rental_instrument_id INT NOT NULL,
 price DECIMAL(20) NOT NULL,
 quantity INT NOT NULL,
 brand VARCHAR(200),
 instrument_id VARCHAR(100) NOT NULL
);

ALTER TABLE rental_instrument ADD CONSTRAINT PK_rental_instrument PRIMARY KEY (rental_instrument_id);


CREATE TABLE salary (
 salary_id INT NOT NULL,
 amount INT,
 month VARCHAR(20)
);

ALTER TABLE salary ADD CONSTRAINT PK_salary PRIMARY KEY (salary_id);


CREATE TABLE school (
 school_id INT NOT NULL,
 slots_available INT NOT NULL,
 min_age INT NOT NULL
);

ALTER TABLE school ADD CONSTRAINT PK_school PRIMARY KEY (school_id);


CREATE TABLE school_admin (
 admin_id INT NOT NULL,
 school_id INT NOT NULL
);

ALTER TABLE school_admin ADD CONSTRAINT PK_school_admin PRIMARY KEY (admin_id);


CREATE TABLE skill_level (
 skill_level_id VARCHAR(50) NOT NULL,
 skill_level VARCHAR(50)
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (skill_level_id);


CREATE TABLE student (
 student_id INT NOT NULL,
 personal_data_id INT NOT NULL,
 rental_fee INT
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE waitlist (
 personal_data_id INT NOT NULL,
 admin_id INT NOT NULL
);

ALTER TABLE waitlist ADD CONSTRAINT PK_waitlist PRIMARY KEY (personal_data_id,admin_id);


CREATE TABLE application (
 personal_data_id INT NOT NULL,
 application_id INT NOT NULL,
 result INT
);

ALTER TABLE application ADD CONSTRAINT PK_application PRIMARY KEY (personal_data_id,application_id);


CREATE TABLE audition (
 student_id INT NOT NULL,
 instrument VARCHAR(100) NOT NULL,
 result VARCHAR(10)
);

ALTER TABLE audition ADD CONSTRAINT PK_audition PRIMARY KEY (student_id);


CREATE TABLE guardian (
 guardian_id INT NOT NULL,
 personal_data_id INT NOT NULL,
 phone_nr VARCHAR(20) NOT NULL,
 email VARCHAR(100) NOT NULL
);

ALTER TABLE guardian ADD CONSTRAINT PK_guardian PRIMARY KEY (guardian_id,personal_data_id);


CREATE TABLE instructor (
 instructor_id INT NOT NULL,
 personal_data_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_available_slots (
 available_time_id INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE instructor_available_slots ADD CONSTRAINT PK_instructor_available_slots PRIMARY KEY (available_time_id,instructor_id);


CREATE TABLE instructor_instrument_skill (
 instructor_id INT NOT NULL,
 instrument_id VARCHAR(100) NOT NULL
);

ALTER TABLE instructor_instrument_skill ADD CONSTRAINT PK_instructor_instrument_skill PRIMARY KEY (instructor_id,instrument_id);


CREATE TABLE monthly_salary (
 instructor_id INT NOT NULL,
 salary_id INT
);

ALTER TABLE monthly_salary ADD CONSTRAINT PK_monthly_salary PRIMARY KEY (instructor_id);


CREATE TABLE monthly_student_fee (
 student_id INT NOT NULL,
 sibiling_discount DECIMAL(20),
 extra_charge DECIMAL(20),
 amount INT
);

ALTER TABLE monthly_student_fee ADD CONSTRAINT PK_monthly_student_fee PRIMARY KEY (student_id);


CREATE TABLE pricing_details (
 pricing_details_id INT NOT NULL,
 for_day_of_week VARCHAR(10),
 amount DECIMAL(10),
 skill_level_id VARCHAR(50) NOT NULL
);

ALTER TABLE pricing_details ADD CONSTRAINT PK_pricing_details PRIMARY KEY (pricing_details_id);


CREATE TABLE rental (
 rental_id INT NOT NULL,
 lease_period DATE NOT NULL,
 rental_instrument_id INT,
 termination VARCHAR(100)
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (rental_id);


CREATE TABLE rental_student (
 student_id INT NOT NULL,
 rental_id INT NOT NULL,
 delivery VARCHAR(100)
);

ALTER TABLE rental_student ADD CONSTRAINT PK_rental_student PRIMARY KEY (student_id,rental_id);


CREATE TABLE siblings (
 student_id_1 INT NOT NULL,
 student_id_0 INT NOT NULL
);

ALTER TABLE siblings ADD CONSTRAINT PK_siblings PRIMARY KEY (student_id_1,student_id_0);


CREATE TABLE booking (
 booking_id INT NOT NULL,
 instructor_id INT NOT NULL,
 admin_id INT,
 pricing_details_id INT NOT NULL,
 max_enrollment INT,
 min_enrollment INT,
 date TIMESTAMP(6)
);

ALTER TABLE booking ADD CONSTRAINT PK_booking PRIMARY KEY (booking_id);


CREATE TABLE booking_student (
 student_id INT NOT NULL,
 booking_id INT NOT NULL
);

ALTER TABLE booking_student ADD CONSTRAINT PK_booking_student PRIMARY KEY (student_id,booking_id);


CREATE TABLE ensemble (
 ensemble_id INT NOT NULL,
 booking_id INT,
 genre VARCHAR(100)
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (ensemble_id);


CREATE TABLE ensemble_instrument (
 instrument_id VARCHAR(100) NOT NULL,
 ensemble_id INT NOT NULL
);

ALTER TABLE ensemble_instrument ADD CONSTRAINT PK_ensemble_instrument PRIMARY KEY (instrument_id,ensemble_id);


CREATE TABLE group_lesson (
 group_lesson_id INT NOT NULL,
 booking_id INT
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (group_lesson_id);


CREATE TABLE group_lesson_instrument (
 instrument_id VARCHAR(100) NOT NULL,
 group_lesson_id INT NOT NULL
);

ALTER TABLE group_lesson_instrument ADD CONSTRAINT PK_group_lesson_instrument PRIMARY KEY (instrument_id,group_lesson_id);


CREATE TABLE individual_lesson (
 individual_lesson_id INT NOT NULL,
 instrument_id VARCHAR(100) NOT NULL,
 booking_id INT
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (individual_lesson_id);


ALTER TABLE rental_instrument ADD CONSTRAINT FK_rental_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE school_admin ADD CONSTRAINT FK_school_admin_0 FOREIGN KEY (school_id) REFERENCES school (school_id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE waitlist ADD CONSTRAINT FK_waitlist_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);
ALTER TABLE waitlist ADD CONSTRAINT FK_waitlist_1 FOREIGN KEY (admin_id) REFERENCES school_admin (admin_id);


ALTER TABLE application ADD CONSTRAINT FK_application_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE audition ADD CONSTRAINT FK_audition_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE guardian ADD CONSTRAINT FK_guardian_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (personal_data_id) REFERENCES personal_data (personal_data_id);


ALTER TABLE instructor_available_slots ADD CONSTRAINT FK_instructor_available_slots_0 FOREIGN KEY (available_time_id) REFERENCES available_time (available_time_id);
ALTER TABLE instructor_available_slots ADD CONSTRAINT FK_instructor_available_slots_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);


ALTER TABLE instructor_instrument_skill ADD CONSTRAINT FK_instructor_instrument_skill_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE instructor_instrument_skill ADD CONSTRAINT FK_instructor_instrument_skill_1 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);


ALTER TABLE monthly_salary ADD CONSTRAINT FK_monthly_salary_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE monthly_salary ADD CONSTRAINT FK_monthly_salary_1 FOREIGN KEY (salary_id) REFERENCES salary (salary_id);


ALTER TABLE monthly_student_fee ADD CONSTRAINT FK_monthly_student_fee_0 FOREIGN KEY (student_id) REFERENCES student (student_id);


ALTER TABLE pricing_details ADD CONSTRAINT FK_pricing_details_0 FOREIGN KEY (skill_level_id) REFERENCES skill_level (skill_level_id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (rental_instrument_id) REFERENCES rental_instrument (rental_instrument_id);


ALTER TABLE rental_student ADD CONSTRAINT FK_rental_student_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE rental_student ADD CONSTRAINT FK_rental_student_1 FOREIGN KEY (rental_id) REFERENCES rental (rental_id);


ALTER TABLE siblings ADD CONSTRAINT FK_siblings_0 FOREIGN KEY (student_id_1) REFERENCES student (student_id);
ALTER TABLE siblings ADD CONSTRAINT FK_siblings_1 FOREIGN KEY (student_id_0) REFERENCES student (student_id);


ALTER TABLE booking ADD CONSTRAINT FK_booking_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_1 FOREIGN KEY (admin_id) REFERENCES school_admin (admin_id);
ALTER TABLE booking ADD CONSTRAINT FK_booking_2 FOREIGN KEY (pricing_details_id) REFERENCES pricing_details (pricing_details_id);


ALTER TABLE booking_student ADD CONSTRAINT FK_booking_student_0 FOREIGN KEY (student_id) REFERENCES student (student_id);
ALTER TABLE booking_student ADD CONSTRAINT FK_booking_student_1 FOREIGN KEY (booking_id) REFERENCES booking (booking_id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (booking_id) REFERENCES booking (booking_id);


ALTER TABLE ensemble_instrument ADD CONSTRAINT FK_ensemble_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE ensemble_instrument ADD CONSTRAINT FK_ensemble_instrument_1 FOREIGN KEY (ensemble_id) REFERENCES ensemble (ensemble_id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (booking_id) REFERENCES booking (booking_id);


ALTER TABLE group_lesson_instrument ADD CONSTRAINT FK_group_lesson_instrument_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE group_lesson_instrument ADD CONSTRAINT FK_group_lesson_instrument_1 FOREIGN KEY (group_lesson_id) REFERENCES group_lesson (group_lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (instrument_id) REFERENCES instrument (instrument_id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (booking_id) REFERENCES booking (booking_id);


