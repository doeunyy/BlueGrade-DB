-- *******************************************************************************
-- 	[Database Setup]: Creating the BlueGrade database
-- *******************************************************************************

CREATE DATABASE StudentDB;
USE StudentDB;
-- DROP DATABASE StudentDB;





-- *******************************************************************************
-- 	[Table Creation]: Defining the main tables for the database
-- *******************************************************************************

-- 반 테이블
CREATE TABLE classes (
	class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name ENUM('금', '토A', '토B', '일', '월', '특강') NOT NULL,
    class_day VARCHAR(5) NOT NULL,
    class_time VARCHAR(10) NOT NULL
);

-- 학생 테이블
CREATE TABLE students (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL REFERENCES classes(class_id),
	student_name VARCHAR(10) NOT NULL,
    nickname VARCHAR(20),
    address VARCHAR(15) NOT NULL,
    birth_date DATE NOT NULL,
    high_school VARCHAR(15) NOT NULL,
    student_phone VARCHAR(20) NOT NULL,
    parent_phone VARCHAR(20) NOT NULL,
    email VARCHAR(30),
    registration_date DATE NOT NULL,
    withdrawal_date DATE DEFAULT NULL,
    registration_status ENUM('active', 'withdrawn') NOT NULL
);

-- 수업 테이블 
CREATE TABLE sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL REFERENCES classes(class_id),
    session_date DATE NOT NULL,
    session_number INT NOT NULL,
    session_material VARCHAR(100) DEFAULT NULL
);

-- 출석 테이블 
CREATE TABLE attendance (
	attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    session_id INT NOT NULL REFERENCES sessions(session_id),
	attendance_status ENUM('present', 'makeup', 'absent', 'online') NOT NULL,
    material_status ENUM('received', 'not_received') DEFAULT NULL
);

-- 시험 테이블
CREATE TABLE tests (
	test_id INT AUTO_INCREMENT PRIMARY KEY,
    session_id INT NOT NULL REFERENCES sessions(session_id),
    test_type ENUM('단어시험', '모의고사') NOT NULL,
    test_date DATE NOT NULL
);

-- 시험 결과 테이블
CREATE TABLE test_results (
	result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    test_id INT NOT NULL REFERENCES tests(test_id),
    score INT DEFAULT NULL,
    message_sent ENUM('Y', 'N') DEFAULT 'N',
    retest_required ENUM('Y','N') DEFAULT NULL
);



-- *******************************************************************************
-- 	[Data Insertion]: Adding test data
-- 
-- 	The database includes the following tables and data:
-- 		- Classes: 5 records
-- 		- Students: 50 records
-- 		- Sessions: 40 records (covering 8 weeks)
-- 		- Attendance: 316 records
-- 		- Tests: 80 records
-- 		- Test Results: 444 records
-- *******************************************************************************

-- Adding test data to the 'classes' table
INSERT INTO classes (class_id, class_name, class_day, class_time)
VALUES
    (1, '금', '금', '6:30'),
    (2, '토A', '토', '2:00'),
    (3, '토B', '토', '6:30'),
    (4, '일', '일', '2:00'),
    (5, '월', '월', '6:30');

SELECT * FROM classes;


-- Adding test data to the 'students' table
-- Friday Class (9 students)
INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES
(1, 'Student1', 'Nick1', 'Seoul, Korea', '2005-05-10', 'HighSchool1', '010-1234-5678', '010-8765-4321', 'student1@ewha-lms.com', '2024-01-05', NULL, 'active'),
(1, 'Student2', 'Nick2', 'Seoul, Korea', '2006-11-20', 'HighSchool2', '010-2234-5678', '010-9765-4321', 'student2@ewha-lms.com', '2024-01-05', NULL, 'active'),
(1, 'Student3', 'Nick3', 'Seoul, Korea', '2005-03-15', 'HighSchool3', '010-3234-5678', '010-8765-3321', 'student3@ewha-lms.com', '2024-01-05', NULL, 'active'),
(1, 'Student4', 'Nick4', 'Seoul, Korea', '2007-06-18', 'HighSchool4', '010-4234-5678', '010-4765-4321', 'student4@ewha-lms.com', '2024-01-05', '2024-02-01', 'withdrawn'),
(1, 'Student5', 'Nick5', 'Seoul, Korea', '2005-12-10', 'HighSchool5', '010-5234-5678', '010-5765-4321', 'student5@ewha-lms.com', '2024-01-05', NULL, 'active'),
(1, 'Student6', 'Nick6', 'Seoul, Korea', '2006-02-24', 'HighSchool6', '010-6234-5678', '010-6765-4321', 'student6@ewha-lms.com', '2024-01-12', NULL, 'active'),
(1, 'Student7', 'Nick7', 'Seoul, Korea', '2005-08-11', 'HighSchool7', '010-7234-5678', '010-7765-4321', 'student7@ewha-lms.com', '2024-01-19', '2024-02-20', 'withdrawn'),
(1, 'Student8', 'Nick8', 'Seoul, Korea', '2007-09-25', 'HighSchool8', '010-8234-5678', '010-8765-4321', 'student8@ewha-lms.com', '2024-02-02', NULL, 'active'),
(1, 'Student9', 'Nick9', 'Seoul, Korea', '2006-10-30', 'HighSchool9', '010-9234-5678', '010-9765-4321', 'student9@ewha-lms.com', '2024-02-16', NULL, 'active');

INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES
-- Saturday A Class (11 students)
(2, 'Student10', 'Nick10', 'Seoul, Korea', '2005-05-10', 'HighSchool10', '010-1234-6789', '010-8765-9876', 'student10@ewha-lms.com', '2024-01-06', '2024-02-14', 'withdrawn'),
(2, 'Student11', 'Nick11', 'Seoul, Korea', '2006-12-10', 'HighSchool11', '010-1111-2222', '010-3333-4444', 'student11@ewha-lms.com', '2024-01-06', NULL, 'active'),
(2, 'Student12', 'Nick12', 'Seoul, Korea', '2007-01-20', 'HighSchool12', '010-2345-6789', '010-9876-5432', 'student12@ewha-lms.com', '2024-01-06', NULL, 'active'),
(2, 'Student13', 'Nick13', 'Seoul, Korea', '2005-02-15', 'HighSchool13', '010-3456-7890', '010-1111-6666', 'student13@ewha-lms.com', '2024-01-06', NULL, 'active'),
(2, 'Student14', 'Nick14', 'Seoul, Korea', '2006-03-25', 'HighSchool14', '010-4567-8901', '010-7777-8888', 'student14@ewha-lms.com', '2024-01-06', '2024-02-07', 'withdrawn'),
(2, 'Student15', 'Nick15', 'Seoul, Korea', '2007-07-07', 'HighSchool15', '010-5678-9012', '010-5555-6666', 'student15@ewha-lms.com', '2024-01-06', NULL, 'active'),
(2, 'Student16', 'Nick16', 'Seoul, Korea', '2005-06-30', 'HighSchool16', '010-6789-0123', '010-4444-5555', 'student16@ewha-lms.com', '2024-01-13', NULL, 'active'),
(2, 'Student17', 'Nick17', 'Seoul, Korea', '2006-08-15', 'HighSchool17', '010-7890-1234', '010-6666-7777', 'student17@ewha-lms.com', '2024-01-20', NULL, 'active'),
(2, 'Student18', 'Nick18', 'Seoul, Korea', '2007-09-10', 'HighSchool18', '010-8901-2345', '010-8888-9999', 'student18@ewha-lms.com', '2024-02-03', NULL, 'active'),
(2, 'Student19', 'Nick19', 'Seoul, Korea', '2005-10-01', 'HighSchool19', '010-9012-3456', '010-1234-5678', 'student19@ewha-lms.com', '2024-02-17', NULL, 'active'),
(2, 'Student20', 'Nick20', 'Seoul, Korea', '2006-11-05', 'HighSchool20', '010-1111-1212', '010-2222-2323', 'student20@ewha-lms.com', '2024-02-17', NULL, 'active'),
-- Saturday B Class (5 students)
(3, 'Student21', 'Nick21', 'Seoul, Korea', '2006-02-28', 'HighSchool21', '010-3236-5678', '010-8769-4321', 'student21@ewha-lms.com', '2024-01-06', NULL, 'active'),
(3, 'Student22', 'Nick22', 'Seoul, Korea', '2005-06-01', 'HighSchool22', '010-4236-5678', '010-4769-4321', 'student22@ewha-lms.com', '2024-01-06', NULL, 'active'),
(3, 'Student23', 'Nick23', 'Seoul, Korea', '2007-07-07', 'HighSchool23', '010-5236-5678', '010-5769-4321', 'student23@ewha-lms.com', '2024-01-06', NULL, 'active'),
(3, 'Student24', 'Nick24', 'Seoul, Korea', '2006-10-13', 'HighSchool24', '010-6236-5678', '010-6769-4321', 'student24@ewha-lms.com', '2024-01-06', NULL, 'active'),
(3, 'Student25', 'Nick25', 'Seoul, Korea', '2005-09-20', 'HighSchool25', '010-7236-5678', '010-7769-4321', 'student25@ewha-lms.com', '2024-01-27', NULL, 'active'),
-- Sunday Class (18 students)
(4, 'Student26', 'Nick26', 'Seoul, Korea', '2006-12-12', 'HighSchool26', '010-8236-5678', '010-8761-4321', 'student26@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student27', 'Nick27', 'Seoul, Korea', '2005-11-25', 'HighSchool27', '010-9236-5678', '010-9761-4321', 'student27@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student28', 'Nick28', 'Seoul, Korea', '2007-03-17', 'HighSchool28', '010-1237-5678', '010-8762-4321', 'student28@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student29', 'Nick29', 'Seoul, Korea', '2006-05-13', 'HighSchool29', '010-2237-5678', '010-9762-4321', 'student29@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student30', 'Nick30', 'Seoul, Korea', '2005-07-11', 'HighSchool30', '010-3237-5678', '010-8763-4321', 'student30@ewha-lms.com', '2024-02-04', '2024-01-17', 'active'), -- Re-registered student
(4, 'Student31', 'Nick31', 'Seoul, Korea', '2007-10-18', 'HighSchool31', '010-4237-5678', '010-4763-4321', 'student31@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student32', 'Nick32', 'Seoul, Korea', '2006-02-25', 'HighSchool32', '010-5237-5678', '010-5763-4321', 'student32@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student33', 'Nick33', 'Seoul, Korea', '2005-08-05', 'HighSchool33', '010-6237-5678', '010-6763-4321', 'student33@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student34', 'Nick34', 'Seoul, Korea', '2007-04-14', 'HighSchool34', '010-7237-5678', '010-7763-4321', 'student34@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student35', 'Nick35', 'Seoul, Korea', '2006-09-29', 'HighSchool35', '010-8237-5678', '010-8763-4321', 'student35@ewha-lms.com', '2024-01-07', NULL, 'active'),
(4, 'Student36', 'Nick36', 'Seoul, Korea', '2005-03-08', 'HighSchool36', '010-9237-5678', '010-9763-4321', 'student36@ewha-lms.com', '2024-01-14', NULL, 'active'),
(4, 'Student37', 'Nick37', 'Seoul, Korea', '2006-07-20', 'HighSchool37', '010-1238-5678', '010-8764-4321', 'student37@ewha-lms.com', '2024-01-14', NULL, 'active'),
(4, 'Student38', 'Nick38', 'Seoul, Korea', '2005-10-01', 'HighSchool38', '010-2238-5678', '010-9764-4321', 'student38@ewha-lms.com', '2024-01-21', NULL, 'active'),
(4, 'Student39', 'Nick39', 'Seoul, Korea', '2007-01-31', 'HighSchool39', '010-3238-5678', '010-8765-4321', 'student39@ewha-lms.com', '2024-01-28', '2024-02-14', 'withdrawn'),
(4, 'Student40', 'Nick40', 'Seoul, Korea', '2006-11-02', 'HighSchool40', '010-4238-5678', '010-4765-4321', 'student40@ewha-lms.com', '2024-02-04', NULL, 'active'),
(4, 'Student41', 'Nick41', 'Seoul, Korea', '2005-06-16', 'HighSchool41', '010-5238-5678', '010-5765-4321', 'student41@ewha-lms.com', '2024-02-25', NULL, 'active'),
(4, 'Student42', 'Nick42', 'Seoul, Korea', '2007-12-18', 'HighSchool42', '010-6238-5678', '010-6765-4321', 'student42@ewha-lms.com', '2024-02-25', NULL, 'active'),
-- Monday Class (8 students)
(5, 'Student43', 'Nick43', 'Seoul, Korea', '2005-09-13', 'HighSchool43', '010-7238-5678', '010-7765-4321', 'student43@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student44', 'Nick44', 'Seoul, Korea', '2006-02-20', 'HighSchool44', '010-8238-5678', '010-8765-4321', 'student44@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student45', 'Nick45', 'Seoul, Korea', '2007-11-10', 'HighSchool45', '010-9238-5678', '010-9765-4321', 'student45@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student46', 'Nick46', 'Seoul, Korea', '2005-05-24', 'HighSchool46', '010-1239-5678', '010-8766-4321', 'student46@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student47', 'Nick47', 'Seoul, Korea', '2006-06-16', 'HighSchool47', '010-2239-5678', '010-9766-4321', 'student47@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student48', 'Nick48', 'Seoul, Korea', '2007-09-07', 'HighSchool48', '010-3239-5678', '010-8767-4321', 'student48@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student49', 'Nick49', 'Seoul, Korea', '2005-08-30', 'HighSchool49', '010-4239-5678', '010-4767-4321', 'student49@ewha-lms.com', '2024-01-29', NULL, 'active'),
(5, 'Student50', 'Nick50', 'Seoul, Korea', '2006-01-12', 'HighSchool50', '010-5239-5678', '010-5767-4321', 'student50@ewha-lms.com', '2024-02-19', '2024-02-22', 'withdrawn');

-- SELECT count(*) FROM students;
-- SELECT * FROM students;


-- Adding test data to the 'sessions' table
INSERT INTO sessions (session_id, class_id, session_date, session_number)
VALUES
# Week 1 (Session Number = 1)
(1, 1, '2024-01-05', 1),  -- Friday Class
(2, 2, '2024-01-06', 1),  -- Saturday A Class
(3, 3, '2024-01-06', 1),  -- Saturday B Class
(4, 4, '2024-01-07', 1),  -- Sunday Class
(5, 5, '2024-01-08', 1);  -- Monday Class

INSERT INTO sessions (class_id, session_date, session_number)
VALUES
# Week2 (Session Number = 2)
(1, '2024-01-12', 2), (2, '2024-01-13', 2), (3, '2024-01-13', 2), (4, '2024-01-14', 2), (5, '2024-01-15', 2),  
# Week3 (Session Number = 3)
(1, '2024-01-19', 3), (2, '2024-01-20', 3), (3, '2024-01-20', 3), (4, '2024-01-21', 3), (5, '2024-01-22', 3),  
# Week4 (Session Number = 4)
(1, '2024-01-26', 4), (2, '2024-01-27', 4), (3, '2024-01-27', 4), (4, '2024-01-28', 4), (5, '2024-01-29', 4), 
# Week5 (Session Number = 5)
(1, '2024-02-02', 5), (2, '2024-02-03', 5), (3, '2024-02-03', 5), (4, '2024-02-04', 5), (5, '2024-02-05', 5),
# Week6 (Session Number = 6)
(1, '2024-02-09', 6), (2, '2024-02-10', 6), (3, '2024-02-10', 6), (4, '2024-02-11', 6), (5, '2024-02-12', 6),
# Week7 (Session Number = 7)
(1, '2024-02-16', 7), (2, '2024-02-17', 7), (3, '2024-02-17', 7), (4, '2024-02-18', 7), (5, '2024-02-19', 7),
# Week8 (Session Number = 8)
(1, '2024-02-23', 8), (2, '2024-02-24', 8), (3, '2024-02-24', 8), (4, '2024-02-25', 8), (5, '2024-02-26', 8);

SELECT * FROM sessions;

-- Update session_material for Week1-8
UPDATE sessions
SET session_material = 'Week 1 material: mat1-1, mat1-2, mat1-3'
WHERE session_id BETWEEN 1 AND 5;
UPDATE sessions
SET session_material = 'Week 2 material: mat2-1, mat2-2, mat2-3'
WHERE session_id BETWEEN 6 AND 10;
UPDATE sessions
SET session_material = 'Week 3 material: mat3-1, mat3-2, mat3-3'
WHERE session_id BETWEEN 11 AND 15;
UPDATE sessions
SET session_material = 'Week 4 material: mat4-1, mat4-2, mat4-3'
WHERE session_id BETWEEN 16 AND 20;
UPDATE sessions
SET session_material = 'Week 5 material: mat5-1, mat5-2, mat5-3'
WHERE session_id BETWEEN 21 AND 25;
UPDATE sessions
SET session_material = 'Week 6 material: mat6-1, mat6-2, mat6-3'
WHERE session_id BETWEEN 26 AND 30;
UPDATE sessions
SET session_material = 'Week 7 material: mat7-1, mat7-2, mat7-3'
WHERE session_id BETWEEN 31 AND 35;
UPDATE sessions
SET session_material = 'Week 8 material: mat8-1, mat8-2, mat8-3'
WHERE session_id BETWEEN 36 AND 40;

SELECT * FROM sessions;


-- Adding test data to the 'sessions' table
-- Friday Class
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
-- Week1 (session_number = 1, session_id = 1)
(1, 1, 'present', 'received'), (2, 1, 'present', 'received'), (3, 1, 'absent', NULL), (4, 1, 'online', 'not_received'), (5, 1, 'present', 'received'),
-- Week2 (session_number = 2, session_id = 6)
(1, 6, 'makeup', 'received'), (2, 6, 'present', 'received'), (3, 6, 'absent', NULL), (4, 6, 'present', 'received'), (5, 6, 'present', 'received'),
(6, 6, 'online', 'not_received'),
-- Week3 (session_number = 3, session_id = 11)
(1, 11, 'present', 'received'), (2, 11, 'online', 'not_received'), (3, 11, 'absent', NULL), (4, 11, 'present', 'received'), (5, 11, 'makeup', 'received'),
(6, 11, 'present', 'received'), (7, 11, 'present', 'received'), 
-- Week4 (session_number = 4, session_id = 16)
(1, 16, 'present', 'received'), (2, 16, 'makeup', 'received'), (3, 16, 'online', 'not_received'), (4, 16, 'present', 'received'), (5, 16, 'present', 'received'),
(6, 16, 'present', 'received'), (7, 16, 'absent', NULL),
-- Week5 (session_number = 5, session_id = 21)
(1, 21, 'present', 'received'), (2, 21, 'present', 'received'), (3, 21, 'online', 'not_received'), (5, 21, 'present', 'received'),
(6, 21, 'present', 'received'), (7, 21, 'present', 'received'), (8, 21, 'present', 'received'),
-- Week6 (session_number = 6, session_id = 26)
(1, 26, 'present', 'received'), (2, 26, 'absent', NULL), (3, 26, 'online', 'not_received'), (5, 26, 'makeup', 'received'),
(6, 26, 'present', 'received'), (7, 26, 'present', 'received'), (8, 26, 'absent', NULL),
-- Week7 (session_number = 7, session_id = 31)
(1, 31, 'present', 'received'), (2, 31, 'makeup', 'received'), (3, 31, 'absent', NULL), (5, 31, 'present', 'received'),
(6, 31, 'online', 'not_received'), (7, 31, 'present', 'received'), (8, 31, 'present', 'received'), (9, 31, 'makeup', 'received'),
-- Week8 (session_number = 8, session_id = 36)
(1, 36, 'present', 'received'), (2, 36, 'present', 'received'), (3, 36, 'absent', NULL), (5, 36, 'makeup', 'received'),
(6, 36, 'present', 'received'), (8, 36, 'absent', NULL), (9, 36, 'present', 'received');

-- Saturday A Class
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
-- Week1 (session_number = 1, session_id = 2)
(10, 2, 'present', 'received'), (11, 2, 'present', 'received'), (12, 2, 'online', 'not_received'), (13, 2, 'absent', NULL), (14, 2, 'present', 'received'),
(15, 2, 'present', 'received'), 
-- Week2 (session_number = 2, session_id = 7)
(10, 7, 'present', 'received'), (11, 7, 'online', 'not_received'), (12, 7, 'absent', NULL), (13, 7, 'present', 'received'), (14, 7, 'present', 'received'),
(15, 7, 'makeup', 'received'), (16, 7, 'present', 'received'),
-- Week3 (session_number = 3, session_id = 12)
(10, 12, 'absent', NULL), (11, 12, 'present', 'received'), (12, 12, 'present', 'received'), (13, 12, 'makeup', 'received'), (14, 12, 'present', 'received'),
(15, 12, 'present', 'received'), (16, 12, 'absent', NULL), (17, 12, 'present', 'received'),
-- Week4 (session_number = 4, session_id = 17)
(10, 17, 'present', 'received'), (11, 17, 'absent', NULL), (12, 17, 'present', 'received'), (13, 17, 'present', 'received'), (14, 17, 'online', 'not_received'),
(15, 17, 'present', 'received'), (16, 17, 'present', 'received'), (17, 17, 'present', 'received'),
-- Week5 (session_number = 5, session_id = 22)
(10, 22, 'present', 'received'), (11, 22, 'present', 'received'), (12, 22, 'absent', NULL), (13, 22, 'present', 'received'), (14, 22, 'present', 'received'),
(15, 22, 'online', 'not_received'), (16, 22, 'present', 'received'), (17, 22, 'present', 'received'), (18, 22, 'absent', NULL), 
-- Week6 (session_number = 6, session_id = 27)
(10, 27, 'online', 'not_received'), (11, 27, 'present', 'received'), (12, 27, 'present', 'received'), (13, 27, 'absent', NULL),
(15, 27, 'present', 'received'), (16, 27, 'absent', NULL), (17, 27, 'makeup', 'received'), (18, 27, 'present', 'received'), 
-- Week7 (session_number = 7, session_id = 32)
(11, 32, 'present', 'received'), (12, 32, 'online', 'not_received'), (13, 32, 'present', 'received'),
(15, 32, 'absent', NULL), (16, 32, 'present', 'received'), (17, 32, 'present', 'received'), (18, 32, 'absent', NULL), (19, 32, 'present', 'received'), (20, 32, 'present', 'received'),
-- Week8 (session_number = 8, session_id = 37)
(11, 37, 'present', 'received'), (12, 37, 'absent', NULL), (13, 37, 'present', 'received'),
(15, 37, 'present', 'received'), (16, 37, 'present', 'received'), (17, 37, 'makeup', 'received'), (18, 37, 'present', 'received'), (19, 37, 'present', 'received'), (20, 37, 'absent', NULL);

-- Saturday B Class
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
-- Week1 (session_number = 1, session_id = 3)
(21, 3, 'present', 'received'), (22, 3, 'absent', NULL), (23, 3, 'present', 'received'), (24, 3, 'online', 'not_received'),
-- Week2 (session_number = 2, session_id = 8)
(21, 8, 'present', 'received'), (22, 8, 'online', 'not_received'), (23, 8, 'present', 'received'), (24, 8, 'present', 'received'),
-- Week3 (session_number = 3, session_id = 13)
(21, 13, 'present', 'received'), (22, 13, 'absent', NULL), (23, 13, 'makeup', 'received'), (24, 13, 'present', 'received'),
-- Week4 (session_number = 4, session_id = 18)
(21, 18, 'present', 'received'), (22, 18, 'present', 'received'), (23, 18, 'present', 'received'), (24, 18, 'absent', NULL), (25, 18, 'present', 'received'),
-- Week5 (session_number = 5, session_id = 23)
(21, 23, 'present', 'received'), (22, 23, 'makeup', 'received'), (23, 23, 'present', 'received'), (24, 23, 'absent', NULL), (25, 23, 'present', 'received'),
-- Week6 (session_number = 6, session_id = 28)
(21, 28, 'online', 'not_received'), (22, 28, 'present', 'received'), (23, 28, 'present', 'received'), (24, 28, 'present', 'received'), (25, 28, 'absent', NULL),
-- Week7 (session_number = 7, session_id = 33)
(21, 33, 'present', 'received'), (22, 33, 'absent', NULL), (23, 33, 'makeup', 'received'), (24, 33, 'present', 'received'), (25, 33, 'present', 'received'),
-- Week8 (session_number = 8, session_id = 38)
(21, 38, 'present', 'received'), (22, 38, 'online', 'not_received'), (23, 38, 'present', 'received'), (24, 38, 'absent', NULL), (25, 38, 'present', 'received');

-- Sunday Class
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
-- Week1 (session_number = 1, session_id = 4)
(26, 4, 'present', 'received'), (27, 4, 'present', 'received'), (28, 4, 'online', 'not_received'), (29, 4, 'absent', NULL), (30, 4, 'present', 'received'),
(31, 4, 'present', 'received'), (32, 4, 'absent', NULL), (33, 4, 'present', 'received'), (34, 4, 'present', 'received'), (35, 4, 'online', 'not_received'),
-- Week2 (session_number = 2, session_id = 9)
(26, 9, 'present', 'received'), (27, 9, 'online', 'not_received'), (28, 9, 'present', 'received'), (29, 9, 'absent', NULL), (30, 9, 'present', 'received'),
(31, 9, 'present', 'received'), (32, 9, 'makeup', 'received'), (33, 9, 'present', 'received'), (34, 9, 'present', 'received'), (35, 9, 'absent', NULL),
(36, 9, 'present', 'received'), (37, 9, 'online', 'not_received'),
-- Week3 (session_number = 3, session_id = 14)
(26, 14, 'present', 'received'), (27, 14, 'present', 'received'), (28, 14, 'absent', NULL), (29, 14, 'present', 'received'),
(31, 14, 'present', 'received'), (32, 14, 'absent', NULL), (33, 14, 'present', 'received'), (34, 14, 'makeup', 'received'), (35, 14, 'present', 'received'),
(36, 14, 'online', 'not_received'), (37, 14, 'present', 'received'), (38, 14, 'present', 'received'),
-- Week4 (session_number = 4, session_id = 19)
(26, 19, 'present', 'received'), (27, 19, 'online', 'not_received'), (28, 19, 'present', 'received'), (29, 19, 'absent', NULL), 
(31, 19, 'present', 'received'), (32, 19, 'present', 'received'), (33, 19, 'present', 'received'), (34, 19, 'absent', NULL), (35, 19, 'present', 'received'),
(36, 19, 'present', 'received'), (37, 19, 'present', 'received'), (38, 19, 'absent', NULL), (39, 19, 'present', 'received'),
-- Week5 (session_number = 5, session_id = 24)
(26, 24, 'present', 'received'), (27, 24, 'absent', NULL), (28, 24, 'present', 'received'), (29, 24, 'present', 'received'), (30, 24, 'present', 'received'),               
(31, 24, 'present', 'received'), (32, 24, 'present', 'received'), (33, 24, 'present', 'received'), (34, 24, 'present', 'received'), (35, 24, 'absent', NULL),
(36, 24, 'present', 'received'), (37, 24, 'makeup', 'received'), (38, 24, 'present', 'received'), (39, 24, 'absent', NULL), (40, 24, 'present', 'received'),
-- Week6 (session_number = 6, session_id = 29)
(26, 29, 'present', 'received'), (27, 29, 'present', 'received'), (28, 29, 'absent', NULL), (29, 29, 'present', 'received'), (30, 29, 'online', 'not_received'),
(31, 29, 'present', 'received'), (32, 29, 'present', 'received'), (33, 29, 'makeup', 'received'), (34, 29, 'absent', NULL), (35, 29, 'present', 'received'),
(36, 29, 'online', 'not_received'), (37, 29, 'present', 'received'), (38, 29, 'present', 'received'), (39, 29, 'present', 'received'), (40, 29, 'present', 'received'),
-- Week7 (session_number = 7, session_id = 34)
(26, 34, 'present', 'received'), (27, 34, 'present', 'received'), (28, 34, 'online', 'not_received'), (29, 34, 'absent', NULL), (30, 34, 'present', 'received'),
(31, 34, 'present', 'received'), (32, 34, 'absent', NULL), (33, 34, 'present', 'received'), (34, 34, 'present', 'received'), (35, 34, 'makeup', 'received'),
(36, 34, 'present', 'received'), (37, 34, 'present', 'received'), (38, 34, 'absent', NULL), (40, 34, 'present', 'received'),
-- Week8 (session_number = 8, session_id = 39)
(26, 39, 'present', 'received'), (27, 39, 'absent', NULL), (28, 39, 'present', 'received'), (29, 39, 'present', 'received'), (30, 39, 'present', 'received'),
(31, 39, 'present', 'received'), (32, 39, 'online', 'not_received'), (33, 39, 'present', 'received'), (34, 39, 'absent', NULL), (35, 39, 'present', 'received'),
(36, 39, 'present', 'received'), (37, 39, 'present', 'received'), (38, 39, 'absent', NULL), (40, 39, 'present', 'received'),
(41, 39, 'present', 'received'), (42, 39, 'present', 'received');

-- Monday Class
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
-- Week1 (session_number = 1, session_id = 5)
(43, 5, 'present', 'received'), (44, 5, 'absent', NULL), (45, 5, 'present', 'received'), (46, 5, 'online', 'not_received'), (47, 5, 'present', 'received'),
(48, 5, 'present', 'received'),
-- Week2 (session_number = 2, session_id = 10)
(43, 10, 'online', 'not_received'), (44, 10, 'present', 'received'), (45, 10, 'present', 'received'), (46, 10, 'present', 'received'), (47, 10, 'present', 'received'),
(48, 10, 'absent', NULL),
-- Week3 (session_number = 3, session_id = 15)
(43, 15, 'present', 'received'), (44, 15, 'present', 'received'), (45, 15, 'absent', NULL), (46, 15, 'present', 'received'), (47, 15, 'present', 'received'),
(48, 15, 'online', 'not_received'),
-- Week4 (session_number = 4, session_id = 20)
(43, 20, 'present', 'received'), (44, 20, 'online', 'not_received'), (45, 20, 'present', 'received'), (46, 20, 'absent', NULL), (47, 20, 'present', 'received'),
(48, 20, 'present', 'received'), (49, 20, 'present', 'received'),
-- Week5 (session_number = 5, session_id = 25)
(43, 25, 'present', 'received'), (44, 25, 'absent', NULL), (45, 25, 'present', 'received'), (46, 25, 'online', 'not_received'), (47, 25, 'present', 'received'),
(48, 25, 'present', 'received'), (49, 25, 'present', 'received'), 
-- Week6 (session_number = 6, session_id = 30)
(43, 30, 'present', 'received'), (44, 30, 'present', 'received'), (45, 30, 'present', 'received'), (46, 30, 'absent', NULL), (47, 30, 'present', 'received'),
(48, 30, 'online', 'not_received'), (49, 30, 'present', 'received'), 
-- Week7 (session_number = 7, session_id = 35)
(43, 35, 'online', 'not_received'), (44, 35, 'present', 'received'), (45, 35, 'present', 'received'), (46, 35, 'present', 'received'), (47, 35, 'present', 'received'),
(48, 35, 'absent', NULL), (49, 35, 'present', 'received'), (50, 35, 'present', 'received'),
-- Week8 (session_number = 8, session_id = 40)
(43, 40, 'present', 'received'), (44, 40, 'present', 'received'), (45, 40, 'present', 'received'), (46, 40, 'present', 'received'), (47, 40, 'absent', NULL),
(48, 40, 'present', 'received'), (49, 40, 'online', 'not_received');

SELECT COUNT(*) FROM attendance;
SELECT * FROM attendance;


-- Adding test data to the 'tests' table
INSERT INTO tests (session_id, test_type, test_date)
VALUES
-- Week1 (session_number = 1)
(1, '단어시험', '2024-01-05'), (1, '모의고사', '2024-01-05'),
(2, '단어시험', '2024-01-06'), (2, '모의고사', '2024-01-06'),
(3, '단어시험', '2024-01-06'), (3, '모의고사', '2024-01-06'),
(4, '단어시험', '2024-01-07'), (4, '모의고사', '2024-01-07'),
(5, '단어시험', '2024-01-08'), (5, '모의고사', '2024-01-08'),
-- Week2 (session_number = 2)
(6, '단어시험', '2024-01-12'), (6, '모의고사', '2024-01-12'),
(7, '단어시험', '2024-01-13'), (7, '모의고사', '2024-01-13'),
(8, '단어시험', '2024-01-13'), (8, '모의고사', '2024-01-13'),
(9, '단어시험', '2024-01-14'), (9, '모의고사', '2024-01-14'),
(10, '단어시험', '2024-01-15'), (10, '모의고사', '2024-01-15'),
-- Week3 (session_number = 3)
(11, '단어시험', '2024-01-19'), (11, '모의고사', '2024-01-19'),
(12, '단어시험', '2024-01-20'), (12, '모의고사', '2024-01-20'),
(13, '단어시험', '2024-01-20'), (13, '모의고사', '2024-01-20'),
(14, '단어시험', '2024-01-21'), (14, '모의고사', '2024-01-21'),
(15, '단어시험', '2024-01-22'), (15, '모의고사', '2024-01-22'),
-- Week4 (session_number = 4)
(16, '단어시험', '2024-01-26'), (16, '모의고사', '2024-01-26'),
(17, '단어시험', '2024-01-27'), (17, '모의고사', '2024-01-27'),
(18, '단어시험', '2024-01-27'), (18, '모의고사', '2024-01-27'),
(19, '단어시험', '2024-01-28'), (19, '모의고사', '2024-01-28'),
(20, '단어시험', '2024-01-29'), (20, '모의고사', '2024-01-29'),
-- Week5 (session_number = 5)
(21, '단어시험', '2024-02-02'), (21, '모의고사', '2024-02-02'),
(22, '단어시험', '2024-02-03'), (22, '모의고사', '2024-02-03'),
(23, '단어시험', '2024-02-03'), (23, '모의고사', '2024-02-03'),
(24, '단어시험', '2024-02-04'), (24, '모의고사', '2024-02-04'),
(25, '단어시험', '2024-02-05'), (25, '모의고사', '2024-02-05'),
-- Week6 (session_number = 6)
(26, '단어시험', '2024-02-09'), (26, '모의고사', '2024-02-09'),
(27, '단어시험', '2024-02-10'), (27, '모의고사', '2024-02-10'),
(28, '단어시험', '2024-02-10'), (28, '모의고사', '2024-02-10'),
(29, '단어시험', '2024-02-11'), (29, '모의고사', '2024-02-11'),
(30, '단어시험', '2024-02-12'), (30, '모의고사', '2024-02-12'),
-- Week7 (session_number = 7)
(31, '단어시험', '2024-02-16'), (31, '모의고사', '2024-02-16'),
(32, '단어시험', '2024-02-17'), (32, '모의고사', '2024-02-17'),
(33, '단어시험', '2024-02-17'), (33, '모의고사', '2024-02-17'),
(34, '단어시험', '2024-02-18'), (34, '모의고사', '2024-02-18'),
(35, '단어시험', '2024-02-19'), (35, '모의고사', '2024-02-19'),
-- Week8 (session_number = 8)
(36, '단어시험', '2024-02-23'), (36, '모의고사', '2024-02-23'),
(37, '단어시험', '2024-02-24'), (37, '모의고사', '2024-02-24'),
(38, '단어시험', '2024-02-24'), (38, '모의고사', '2024-02-24'),
(39, '단어시험', '2024-02-25'), (39, '모의고사', '2024-02-25'),
(40, '단어시험', '2024-02-26'), (40, '모의고사', '2024-02-26');

SELECT COUNT(*) FROM tests;
SELECT * FROM tests;


-- Adding test data to the 'test_results' table
-- Friday
INSERT INTO test_results (student_id, test_id, score, message_sent, retest_required)
VALUES
-- Week1
(1, 1, 38, 'N', 'N'), (1, 2, 90, 'N', NULL), (2, 1, 32, 'N', 'Y'), (2, 2, 85, 'N', NULL),
(5, 1, 40, 'N', 'N'), (5, 2, 95, 'N', NULL),
-- Week2
(1, 11, 39, 'N', 'N'), (1, 12, 92, 'N', NULL), (2, 11, 28, 'N', 'Y'), (2, 12, 87, 'N', NULL),
(4, 11, 30, 'N', 'Y'), (4, 12, 78, 'N', NULL), (5, 11, 40, 'N', 'N'), (5, 12, 94, 'N', NULL),
-- Week3
(1, 21, 40, 'N', 'N'), (1, 22, 93, 'N', NULL), (4, 21, 35, 'N', 'Y'), (4, 22, 84, 'N', NULL),
(5, 21, 38, 'N', 'N'), (5, 22, 91, 'N', NULL), (6, 21, 39, 'N', 'N'), (6, 22, 86, 'N', NULL),
(7, 21, 33, 'N', 'Y'), (7, 22, 80, 'N', NULL),
-- Week4
(1, 31, 39, 'N', 'N'), (1, 32, 90, 'N', NULL), (2, 31, 28, 'N', 'Y'), (2, 32, 77, 'N', NULL),
(4, 31, 34, 'N', 'Y'), (4, 32, 81, 'N', NULL), (5, 31, 40, 'N', 'N'), (5, 32, 95, 'N', NULL),
(6, 31, 37, 'N', 'N'), (6, 32, 89, 'N', NULL),
-- Week5
(1, 41, 40, 'N', 'N'), (1, 42, 94, 'N', NULL), (2, 41, 30, 'N', 'Y'), (2, 42, 81, 'N', NULL),
(5, 41, 39, 'N', 'N'), (5, 42, 88, 'N', NULL), (6, 41, 35, 'N', 'Y'), (6, 42, 85, 'N', NULL),
(7, 41, 32, 'N', 'Y'), (7, 42, 82, 'N', NULL), (8, 41, 37, 'N', 'N'), (8, 42, 90, 'N', NULL),
-- Week6
(1, 51, 39, 'N', 'N'), (1, 52, 92, 'N', NULL), (5, 51, 38, 'N', 'N'), (5, 52, 87, 'N', NULL), 
(6, 51, 40, 'N', 'N'), (6, 52, 91, 'N', NULL), (7, 51, 35, 'N', 'Y'), (7, 52, 84, 'N', NULL),
-- Week7
(1, 61, 40, 'N', 'N'), (1, 62, 95, 'N', NULL), (2, 61, 29, 'N', 'Y'), (2, 62, 78, 'N', NULL),
(5, 61, 37, 'N', 'N'), (5, 62, 90, 'N', NULL), (7, 61, 36, 'N', 'N'), (7, 62, 89, 'N', NULL), 
(8, 61, 33, 'N', 'Y'), (8, 62, 82, 'N', NULL), (9, 61, 40, 'N', 'N'), (9, 62, 94, 'N', NULL), 
-- Week8
(1, 71, 39, 'N', 'N'), (1, 72, 92, 'N', NULL), (2, 71, 28, 'N', 'Y'), (2, 72, 79, 'N', NULL),
(5, 71, 38, 'N', 'N'), (5, 72, 91, 'N', NULL), (6, 71, 40, 'N', 'N'), (6, 72, 94, 'N', NULL),
(9, 71, 39, 'N', 'N'), (9, 72, 87, 'N', NULL);

-- Saturday A Class
INSERT INTO test_results (student_id, test_id, score, message_sent, retest_required)
VALUES
-- Week1
(10, 3, 37, 'N', 'N'), (10, 4, 85, 'N', NULL), (11, 3, 35, 'N', 'Y'), (11, 4, 78, 'N', NULL),
(14, 3, 39, 'N', 'N'), (14, 4, 88, 'N', NULL), (15, 3, 40, 'N', 'N'), (15, 4, 92, 'N', NULL),
-- Week2
(10, 13, 35, 'N', 'Y'), (10, 14, 82, 'N', NULL), (13, 13, 39, 'N', 'N'), (13, 14, 91, 'N', NULL),
(14, 13, 31, 'N', 'Y'), (14, 14, 75, 'N', NULL), (15, 13, 37, 'N', 'N'), (15, 14, 88, 'N', NULL),
(16, 13, 36, 'N', 'N'), (16, 14, 79, 'N', NULL),
-- Week3
(11, 23, 38, 'N', 'N'), (11, 24, 87, 'N', NULL), (12, 23, 35, 'N', 'Y'), (12, 24, 80, 'N', NULL),
(13, 23, 40, 'N', 'N'), (13, 24, 92, 'N', NULL), (14, 23, 33, 'N', 'Y'), (14, 24, 78, 'N', NULL),
(15, 23, 39, 'N', 'N'), (15, 24, 90, 'N', NULL), (17, 23, 36, 'N', 'N'), (17, 24, 85, 'N', NULL),
-- Week4
(10, 33, 37, 'N', 'N'), (10, 34, 89, 'N', NULL), (12, 33, 35, 'N', 'Y'), (12, 34, 82, 'N', NULL),
(13, 33, 40, 'N', 'N'), (13, 34, 93, 'N', NULL), (15, 33, 34, 'N', 'Y'), (15, 34, 79, 'N', NULL),
(16, 33, 38, 'N', 'N'), (16, 34, 90, 'N', NULL), (17, 33, 31, 'N', 'Y'), (17, 34, 73, 'N', NULL),
-- Week5
(10, 43, 36, 'N', 'N'), (10, 44, 85, 'N', NULL), (11, 43, 38, 'N', 'N'), (11, 44, 90, 'N', NULL),
(13, 43, 35, 'N', 'Y'), (13, 44, 79, 'N', NULL), (14, 43, 39, 'N', 'N'), (14, 44, 91, 'N', NULL),
(16, 43, 32, 'N', 'Y'), (16, 44, 78, 'N', NULL), (17, 43, 31, 'N', 'Y'), (17, 44, 77, 'N', NULL),
-- Week6
(11, 53, 39, 'N', 'N'), (11, 54, 91, 'N', NULL), (12, 53, 36, 'N', 'N'), (12, 54, 86, 'N', NULL),
(15, 53, 40, 'N', 'N'), (15, 54, 93, 'N', NULL), (17, 53, 31, 'N', 'Y'), (17, 54, 75, 'N', NULL), 
(18, 53, 30, 'N', 'Y'), (18, 54, 77, 'N', NULL),
-- Week7
(11, 63, 40, 'N', 'N'), (11, 64, 90, 'N', NULL), (13, 63, 35, 'N', 'Y'), (13, 64, 78, 'N', NULL),
(16, 63, 34, 'N', 'Y'), (16, 64, 82, 'N', NULL), (17, 63, 32, 'N', 'Y'), (17, 64, 80, 'N', NULL),
(19, 63, 38, 'N', 'N'), (19, 64, 89, 'N', NULL), (20, 63, 40, 'N', 'N'), (20, 64, 92, 'N', NULL),
-- Week8
(11, 73, 37, 'N', 'N'), (11, 74, 88, 'N', NULL), (13, 73, 36, 'N', 'N'), (13, 74, 82, 'N', NULL), 
(15, 73, 34, 'N', 'Y'), (15, 74, 79, 'N', NULL), (16, 73, 32, 'N', 'Y'), (16, 74, 76, 'N', NULL), 
(17, 73, 35, 'N', 'N'), (17, 74, 81, 'N', NULL), (18, 73, 30, 'N', 'Y'), (18, 74, 75, 'N', NULL), 
(19, 73, 38, 'N', 'N'), (19, 74, 89, 'N', NULL);

-- Saturday B Class
INSERT INTO test_results (student_id, test_id, score, message_sent, retest_required)
VALUES
-- Week1
(21, 5, 36, 'N', 'N'), (21, 6, 85, 'N', NULL), (23, 5, 34, 'N', 'Y'), (23, 6, 80, 'N', NULL),
-- Week2
(21, 15, 37, 'N', 'N'), (21, 16, 89, 'N', NULL), (23, 15, 33, 'N', 'Y'), (23, 16, 78, 'N', NULL),
(24, 15, 36, 'N', 'N'), (24, 16, 83, 'N', NULL),
-- Week3
(21, 25, 35, 'N', 'Y'), (21, 26, 86, 'N', NULL), (23, 25, 40, 'N', 'N'), (23, 26, 90, 'N', NULL),
(24, 25, 38, 'N', 'N'), (24, 26, 84, 'N', NULL),
-- Week4
(21, 35, 39, 'N', 'N'), (21, 36, 91, 'N', NULL), (22, 35, 31, 'N', 'Y'), (22, 36, 76, 'N', NULL),
(23, 35, 37, 'N', 'N'), (23, 36, 88, 'N', NULL), (25, 35, 36, 'N', 'N'), (25, 36, 83, 'N', NULL),
-- Week5
(21, 45, 38, 'N', 'N'), (21, 46, 89, 'N', NULL), (22, 45, 32, 'N', 'Y'), (22, 46, 78, 'N', NULL),
(23, 45, 40, 'N', 'N'), (23, 46, 90, 'N', NULL), (25, 45, 35, 'N', 'Y'), (25, 46, 82, 'N', NULL),
-- Week6
(22, 55, 37, 'N', 'N'), (22, 56, 87, 'N', NULL), (23, 55, 33, 'N', 'Y'), (23, 56, 79, 'N', NULL),
(24, 55, 36, 'N', 'N'), (24, 56, 85, 'N', NULL),
-- Week7
(21, 65, 39, 'N', 'N'), (21, 66, 93, 'N', NULL), (23, 65, 35, 'N', 'Y'), (23, 66, 81, 'N', NULL),
(24, 65, 38, 'N', 'N'), (24, 66, 88, 'N', NULL), (25, 65, 40, 'N', 'N'), (25, 66, 90, 'N', NULL),
-- Week8
(21, 75, 37, 'N', 'N'), (21, 76, 86, 'N', NULL), (23, 75, 34, 'N', 'Y'), (23, 76, 78, 'N', NULL),
(25, 75, 39, 'N', 'N'), (25, 76, 89, 'N', NULL);

-- Sunday Class
INSERT INTO test_results (student_id, test_id, score, message_sent, retest_required)
VALUES
-- Week1
(26, 7, 39, 'N', 'N'), (26, 8, 87, 'N', NULL), (27, 7, 34, 'N', 'Y'), (27, 8, 81, 'N', NULL),
(30, 7, 38, 'N', 'N'), (30, 8, 85, 'N', NULL), (31, 7, 36, 'N', 'N'), (31, 8, 83, 'N', NULL),
(33, 7, 35, 'N', 'Y'), (33, 8, 80, 'N', NULL), (34, 7, 40, 'N', 'N'), (34, 8, 92, 'N', NULL),
-- Week2
(26, 17, 37, 'N', 'N'), (26, 18, 86, 'N', NULL), (28, 17, 35, 'N', 'Y'), (28, 18, 78, 'N', NULL),
(30, 17, 39, 'N', 'N'), (30, 18, 90, 'N', NULL), (31, 17, 36, 'N', 'N'), (31, 18, 83, 'N', NULL),
(32, 17, 33, 'N', 'Y'), (32, 18, 79, 'N', NULL), (33, 17, 38, 'N', 'N'), (33, 18, 88, 'N', NULL),
(34, 17, 40, 'N', 'N'), (34, 18, 91, 'N', NULL), (36, 17, 35, 'N', 'Y'), (36, 18, 81, 'N', NULL),
-- Week3
(26, 27, 40, 'N', 'N'), (26, 28, 92, 'N', NULL), (27, 27, 31, 'N', 'Y'), (27, 28, 76, 'N', NULL),
(29, 27, 38, 'N', 'N'), (29, 28, 89, 'N', NULL), (31, 27, 35, 'N', 'Y'), (31, 28, 79, 'N', NULL), 
(33, 27, 37, 'N', 'N'), (33, 28, 85, 'N', NULL), (34, 27, 39, 'N', 'N'), (34, 28, 88, 'N', NULL), 
(35, 27, 33, 'N', 'Y'), (35, 28, 78, 'N', NULL), (37, 27, 36, 'N', 'N'), (37, 28, 84, 'N', NULL), 
(38, 27, 32, 'N', 'Y'), (38, 28, 77, 'N', NULL),
-- Week4
(26, 37, 35, 'N', 'Y'), (26, 38, 85, 'N', NULL), (28, 37, 38, 'N', 'N'), (28, 38, 88, 'N', NULL),
(31, 37, 32, 'N', 'Y'), (31, 38, 79, 'N', NULL), (32, 37, 40, 'N', 'N'), (32, 38, 90, 'N', NULL), 
(33, 37, 38, 'N', 'N'), (33, 38, 89, 'N', NULL), (35, 37, 33, 'N', 'Y'), (35, 38, 78, 'N', NULL), 
(36, 37, 36, 'N', 'N'), (36, 38, 84, 'N', NULL), (37, 37, 40, 'N', 'N'), (37, 38, 91, 'N', NULL), 
(39, 37, 34, 'N', 'Y'), (39, 38, 77, 'N', NULL),
-- Week5
(26, 47, 37, 'N', 'N'), (26, 48, 89, 'N', NULL), (28, 47, 35, 'N', 'Y'), (28, 48, 78, 'N', NULL),
(29, 47, 38, 'N', 'N'), (29, 48, 87, 'N', NULL), (30, 47, 37, 'N', 'N'), (30, 48, 86, 'N', NULL), 
(31, 47, 32, 'N', 'Y'), (31, 48, 77, 'N', NULL), (32, 47, 39, 'N', 'N'), (32, 48, 90, 'N', NULL), 
(33, 47, 36, 'N', 'N'), (33, 48, 85, 'N', NULL), (34, 47, 40, 'N', 'N'), (34, 48, 92, 'N', NULL), 
(36, 47, 34, 'N', 'Y'), (36, 48, 78, 'N', NULL), (37, 47, 35, 'N', 'Y'), (37, 48, 80, 'N', NULL), 
(38, 47, 31, 'N', 'Y'), (38, 48, 76, 'N', NULL), (40, 47, 39, 'N', 'N'), (40, 48, 88, 'N', NULL),
-- Week6
(26, 57, 39, 'N', 'N'), (26, 58, 93, 'N', NULL), (27, 57, 34, 'N', 'Y'), (27, 58, 81, 'N', NULL),
(31, 57, 36, 'N', 'N'), (31, 58, 84, 'N', NULL), (32, 57, 33, 'N', 'Y'), (32, 58, 79, 'N', NULL), 
(33, 57, 40, 'N', 'N'), (33, 58, 92, 'N', NULL), (35, 57, 35, 'N', 'Y'), (35, 58, 80, 'N', NULL), 
(37, 57, 38, 'N', 'N'), (37, 58, 85, 'N', NULL), (38, 57, 31, 'N', 'Y'), (38, 58, 76, 'N', NULL), 
(39, 57, 39, 'N', 'N'), (39, 58, 88, 'N', NULL), (40, 57, 38, 'N', 'N'), (40, 58, 87, 'N', NULL),
-- Week7
(26, 67, 38, 'N', 'N'), (26, 68, 88, 'N', NULL), (27, 67, 31, 'N', 'Y'), (27, 68, 75, 'N', NULL),
(30, 67, 37, 'N', 'N'), (30, 68, 85, 'N', NULL), (31, 67, 36, 'N', 'N'), (31, 68, 83, 'N', NULL),
(33, 67, 35, 'N', 'Y'), (33, 68, 79, 'N', NULL), (34, 67, 39, 'N', 'N'), (34, 68, 91, 'N', NULL),
(36, 67, 34, 'N', 'Y'), (36, 68, 78, 'N', NULL), (37, 67, 38, 'N', 'N'), (37, 68, 85, 'N', NULL),
(40, 67, 39, 'N', 'N'), (40, 68, 89, 'N', NULL),
-- Week8
(26, 77, 37, 'N', 'N'), (26, 78, 87, 'N', NULL), (28, 77, 35, 'N', 'Y'), (28, 78, 79, 'N', NULL),
(29, 77, 38, 'N', 'N'), (29, 78, 88, 'N', NULL), (30, 77, 36, 'N', 'N'), (30, 78, 84, 'N', NULL),
(31, 77, 33, 'N', 'Y'), (31, 78, 78, 'N', NULL), (33, 77, 39, 'N', 'N'), (33, 78, 91, 'N', NULL),
(35, 77, 34, 'N', 'Y'), (35, 78, 80, 'N', NULL), (36, 77, 31, 'N', 'Y'), (36, 78, 76, 'N', NULL),
(37, 77, 39, 'N', 'N'), (37, 78, 89, 'N', NULL), (40, 77, 38, 'N', 'N'), (40, 78, 88, 'N', NULL),
(41, 77, 36, 'N', 'N'), (41, 78, 84, 'N', NULL), (42, 77, 33, 'N', 'Y'), (42, 78, 77, 'N', NULL);

-- Monday Class
INSERT INTO test_results (student_id, test_id, score, message_sent, retest_required)
VALUES
-- Week1
(43, 9, 37, 'N', 'N'), (43, 10, 85, 'N', NULL), (45, 9, 36, 'N', 'N'), (45, 10, 83, 'N', NULL),
(47, 9, 35, 'N', 'Y'), (47, 10, 80, 'N', NULL), (48, 9, 40, 'N', 'N'), (48, 10, 92, 'N', NULL),
-- Week2
(44, 19, 39, 'N', 'N'), (44, 20, 89, 'N', NULL), (45, 19, 37, 'N', 'N'), (45, 20, 87, 'N', NULL),
(46, 19, 32, 'N', 'Y'), (46, 20, 77, 'N', NULL), (47, 19, 38, 'N', 'N'), (47, 20, 84, 'N', NULL),
-- Week3
(43, 29, 36, 'N', 'N'), (43, 30, 88, 'N', NULL), (44, 29, 37, 'N', 'N'), (44, 30, 85, 'N', NULL),
(46, 29, 33, 'N', 'Y'), (46, 30, 79, 'N', NULL), (47, 29, 39, 'N', 'N'), (47, 30, 89, 'N', NULL),
-- Week4
(43, 39, 40, 'N', 'N'), (43, 40, 92, 'N', NULL), (45, 39, 37, 'N', 'N'), (45, 40, 86, 'N', NULL),
(47, 39, 34, 'N', 'Y'), (47, 40, 81, 'N', NULL), (48, 39, 39, 'N', 'N'), (48, 40, 89, 'N', NULL),
(49, 39, 35, 'N', 'Y'), (49, 40, 80, 'N', NULL),
-- Week5
(43, 49, 38, 'N', 'N'), (43, 50, 87, 'N', NULL), (45, 49, 36, 'N', 'N'), (45, 50, 84, 'N', NULL),
(47, 49, 32, 'N', 'Y'), (47, 50, 78, 'N', NULL), (48, 49, 39, 'N', 'N'), (48, 50, 90, 'N', NULL),
(49, 49, 34, 'N', 'Y'), (49, 50, 77, 'N', NULL), 
-- Week6
(43, 59, 40, 'N', 'N'), (43, 60, 93, 'N', NULL), (44, 59, 35, 'N', 'Y'), (44, 60, 82, 'N', NULL),
(45, 59, 37, 'N', 'N'), (45, 60, 88, 'N', NULL), (47, 59, 39, 'N', 'N'), (47, 60, 90, 'N', NULL),
(49, 59, 36, 'N', 'N'), (49, 60, 85, 'N', NULL),
-- Week7
(44, 69, 38, 'N', 'N'), (44, 70, 89, 'N', NULL), (45, 69, 37, 'N', 'N'), (45, 70, 88, 'N', NULL),
(46, 69, 33, 'N', 'Y'), (46, 70, 79, 'N', NULL), (47, 69, 40, 'N', 'N'), (47, 70, 91, 'N', NULL),
(49, 69, 35, 'N', 'Y'), (49, 70, 83, 'N', NULL), (50, 69, 39, 'N', 'N'), (50, 70, 86, 'N', NULL),
-- Week8
(43, 79, 37, 'N', 'N'), (43, 80, 86, 'N', NULL), (44, 79, 39, 'N', 'N'), (44, 80, 89, 'N', NULL),
(45, 79, 34, 'N', 'Y'), (45, 80, 81, 'N', NULL), (46, 79, 35, 'N', 'Y'), (46, 80, 80, 'N', NULL),
(48, 79, 38, 'N', 'N'), (48, 80, 90, 'N', NULL);

SELECT COUNT(*) FROM test_results;
SELECT * FROM test_results;





-- *******************************************************************************
-- 	[Feature Implementation]: Student management system functionality
-- *******************************************************************************

-- ===============================================================================
-- 	[CRUD Operations]: Managing student information
-- ===============================================================================
-- [Description]: This section includes SQL queries for performing basic CRUD operations on the `students` table, including:
-- 		- Creating new student records
-- 		- Updating student information (e.g., nickname, registration status)
-- 		- Deleting student records
-- 		- Reading student information


-- Creating new student records
-- ALTER TABLE students AUTO_INCREMENT = 51;
INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES (1, 'Student51', 'Nick51', 'Seoul, Korea', '2006-11-20', 'HighSchool51', '010-2234-5151', '010-9765-5151', 'student51@ewha-lms.com', '2024-01-15', NULL, 'active');
INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date)
VALUES (1, 'Student52', 'Nick52', 'Seoul, Korea', '2006-11-20', 'HighSchool52', '010-2234-5252', '010-9765-5252', 'student52@ewha-lms.com', '2024-01-15');
SELECT * FROM students;

-- Updating student information (e.g., nickname, registration status)
-- Change nickname for Student51
UPDATE students
SET nickname = 'NickChanged'
WHERE student_id = 51;
SELECT * FROM students WHERE student_id=51;

-- Process withdrawal for Student51
UPDATE students
SET withdrawal_date = '2024-02-01', registration_status = 'withdrawn'
WHERE student_id = 51;
SELECT * FROM students WHERE student_id=51;

-- Re-enroll Student51
UPDATE students
SET registration_date = '2024-02-14', registration_status = 'active'
WHERE student_id = 51;
SELECT * FROM students WHERE student_id=51;

-- Delete Student52
DELETE FROM students
WHERE student_id = 52;
SELECT * FROM students;



-- ===============================================================================
-- 	[Query Operations]: Filtering and retrieving student-related data
-- ===============================================================================
-- [Description]: This section includes SQL queries to filter and retrieve data related to students, such as:
-- 		- Retrieving new students based on registration date
-- 		- Filtering withdrawn and re-enrolled students
-- 		- Counting students by class
-- 		- Analyzing weekly attendance trends

-- Retrieve new students registered during the Week2 (2주차 신규생 조희)
SELECT student_id, class_id, student_name, nickname, registration_date, withdrawal_date, registration_status
FROM students
WHERE registration_date BETWEEN '2024-01-12' AND '2024-01-18'
ORDER BY registration_date ASC;

-- Retrieve all withdrawn students (전체 퇴원생 조회)
SELECT student_id, class_id, student_name, nickname, registration_date, withdrawal_date, registration_status
FROM students
WHERE registration_status = 'withdrawn';

-- Retrieve re-enrolled students (재등록생 조회)
SELECT student_id, class_id, student_name, nickname, registration_date, withdrawal_date, registration_status
FROM students
WHERE registration_status = 'active' AND withdrawal_date IS NOT NULL;

-- Retrieve class name and student count (반별 학생 수 조회)
SELECT c.class_name AS '반', COUNT(s.student_id) AS '학생 수'
FROM classes c
LEFT JOIN students s ON c.class_id = s.class_id
GROUP BY c.class_name;

-- Retrieve weekly attendance counts by session (주차별 출석 학생 수 조회)
SELECT s.session_number AS '주차', COUNT(a.student_id) AS '출석 학생 수'
FROM attendance a
JOIN sessions s ON a.session_id = s.session_id
WHERE a.attendance_status IN ('present', 'makeup')
GROUP BY s.session_number
ORDER BY s.session_number;



-- ===============================================================================
-- 	[Query Operations]: Managing student attendance and session data
-- ===============================================================================
-- [Description]: This section includes SQL queries to analyze attendance and session-related data, such as:
-- 		- Filtering students with specific attendance statuses (e.g., present, makeup)
-- 		- Counting weekly attendance for each session
-- 		- Grouping and summarizing attendance data by session number

-- Retrieve weekly attendance status for Student1 (학생별 주차별 출석 현황)
SELECT 
    s.session_number AS week_number,
    a.attendance_status,
    a.material_status
FROM attendance a
JOIN sessions s ON a.session_id = s.session_id
JOIN students st ON a.student_id = st.student_id
WHERE st.student_id = 1 -- Filter student by ID
ORDER BY s.session_number;

-- Retrieve weekly word test and mock test scores for Student1 (학생별 주차별 성적 현황)
SELECT 
    s.session_number AS '주차',
    MAX(CASE WHEN t.test_type = '단어시험' THEN tr.score END) AS '단어시험 성적',
    MAX(CASE WHEN t.test_type = '모의고사' THEN tr.score END) AS '모의고사 성적'
FROM test_results tr
JOIN tests t ON tr.test_id = t.test_id
JOIN sessions s ON t.session_id = s.session_id
WHERE tr.student_id = 1 -- Filter student by ID
GROUP BY s.session_number
ORDER BY s.session_number;

-- Retrieve students with not_received materials and session details (주차별 자료 미수령 학생 조회)
SELECT 
    sess.session_number AS '주차',
    s.student_name AS '학생 이름',
    s.high_school AS '고등학교',
    s.student_phone AS '학생 번호',
    s.parent_phone AS '학부모 번호',
    s.address AS '주소'
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN sessions sess ON a.session_id = sess.session_id
WHERE a.material_status = 'not_received'
ORDER BY sess.session_number, s.student_name;



-- ===============================================================================
-- 	[View Creation]: Generating views for students and parents
-- ===============================================================================
-- [Description]: This section includes SQL queries to create views providing information for students and parents, such as:
-- 		- Weekly attendance and material receipt status
-- 		- Test scores for vocabulary tests and mock exams
-- 		- Session materials provided during classes

-- Create class management view for Students & Parents (수업 관리 뷰)
CREATE VIEW class_management_view AS
SELECT      
	st.student_id,
    st.student_name AS '이름',
	s.session_number AS '주차',
    s.session_date AS '수업일',
    a.attendance_status AS '수업 출석 여부',            
    s.session_material AS '수업 자료',
    a.material_status AS '수업 자료 수령 여부',
    MAX(CASE WHEN t.test_type = '단어시험' THEN tr.score ELSE NULL END) AS '단어시험 성적',
    MAX(CASE WHEN t.test_type = '모의고사' THEN tr.score ELSE NULL END) AS '모의고사 성적'
FROM
    students st
LEFT JOIN attendance a ON st.student_id = a.student_id
LEFT JOIN sessions s ON a.session_id = s.session_id
LEFT JOIN tests t ON s.session_id = t.session_id
LEFT JOIN test_results tr ON t.test_id = tr.test_id AND tr.student_id = st.student_id
GROUP BY
    st.student_id, st.student_name, s.session_number, s.session_date, s.session_material, a.attendance_status, a.material_status
ORDER BY
    st.student_id, s.session_number;
    
-- DROP VIEW class_management_view;
    
SELECT *
FROM class_management_view
WHERE student_id = 3;