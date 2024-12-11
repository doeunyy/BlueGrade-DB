/* 데이터베이스 생성 */
CREATE DATABASE StudentDB;
USE StudentDB;
-- DROP DATABASE StudentDB;

/* 테이블 생성 */
-- 반 테이블
CREATE TABLE classes (
	class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name ENUM('금', '토A', '토B', '일', '월', '특강') NOT NULL,
    class_day VARCHAR(5) NOT NULL,
    class_time VARCHAR(10) NOT NULL
);
# drop table classes;

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
    session_number INT NOT NULL
);

-- 출석 테이블 
CREATE TABLE attendance (
	attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL REFERENCES students(student_id),
    session_id INT NOT NULL REFERENCES sessions(session_id),
	attendance_status ENUM('present', 'makeup', 'absent', 'online') NOT NULL,
    material_status ENUM('received', 'not_received') DEFAULT NULL
);
drop table attendance;

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

/* 데이터 삽입 */
-- 반 데이터 삽입
INSERT INTO classes (class_id, class_name, class_day, class_time)
VALUES
    (1, '금', '금', '6:30'),
    (2, '토A', '토', '2:00'),
    (3, '토B', '토', '6:30'),
    (4, '일', '일', '2:00');

# AUTO_INCREMENT 확인용
INSERT INTO classes (class_name, class_day, class_time)
VALUES ('월', '월', '6:30');
SELECT * FROM classes;

-- 학생 데이터 삽입
# 금 반 (9명)
INSERT INTO students (student_id, class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES
(1, 1, 'Student1', 'Nick1', 'Seoul, Korea', '2005-05-10', 'HighSchool1', '010-1234-5678', '010-8765-4321', 'student1@ewha-lms.com', '2024-01-05', NULL, 'active');

INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES
(1, 'Student2', 'Nick2', 'Seoul, Korea', '2006-11-20', 'HighSchool2', '010-2234-5678', '010-9765-4321', 'student2@ewha-lms.com', '2024-01-15', NULL, 'active'),
(1, 'Student3', 'Nick3', 'Seoul, Korea', '2005-03-15', 'HighSchool3', '010-3234-5678', '010-8765-3321', 'student3@ewha-lms.com', '2024-02-10', NULL, 'active'),
(1, 'Student4', 'Nick4', 'Seoul, Korea', '2007-06-18', 'HighSchool4', '010-4234-5678', '010-4765-4321', 'student4@ewha-lms.com', '2024-01-25', '2024-02-20', 'withdrawn'),
(1, 'Student5', 'Nick5', 'Seoul, Korea', '2005-12-10', 'HighSchool5', '010-5234-5678', '010-5765-4321', 'student5@ewha-lms.com', '2024-02-01', NULL, 'active'),
(1, 'Student6', 'Nick6', 'Seoul, Korea', '2006-02-24', 'HighSchool6', '010-6234-5678', '010-6765-4321', 'student6@ewha-lms.com', '2024-02-10', NULL, 'active'),
(1, 'Student7', 'Nick7', 'Seoul, Korea', '2005-08-11', 'HighSchool7', '010-7234-5678', '010-7765-4321', 'student7@ewha-lms.com', '2024-01-20', '2024-02-15', 'withdrawn'),
(1, 'Student8', 'Nick8', 'Seoul, Korea', '2007-09-25', 'HighSchool8', '010-8234-5678', '010-8765-4321', 'student8@ewha-lms.com', '2024-02-15', NULL, 'active'),
(1, 'Student9', 'Nick9', 'Seoul, Korea', '2006-10-30', 'HighSchool9', '010-9234-5678', '010-9765-4321', 'student9@ewha-lms.com', '2024-01-10', NULL, 'active');

# 토A 반 (11명)
INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES
(2, 'Student10', 'Nick10', 'Seoul, Korea', '2005-05-10', 'HighSchool1', '010-1234-6789', '010-8765-9876', 'student10@ewha-lms.com', '2024-01-05', '2024-02-20', 'withdrawn'),
(2, 'Student11', 'Nick11', 'Seoul, Korea', '2006-12-10', 'HighSchool2', '010-1111-2222', '010-3333-4444', 'student11@ewha-lms.com', '2024-01-10', NULL, 'active'),
(2, 'Student12', 'Nick12', 'Seoul, Korea', '2007-01-20', 'HighSchool3', '010-2345-6789', '010-9876-5432', 'student12@ewha-lms.com', '2024-02-01', NULL, 'active'),
(2, 'Student13', 'Nick13', 'Seoul, Korea', '2005-02-15', 'HighSchool4', '010-3456-7890', '010-1111-6666', 'student13@ewha-lms.com', '2024-02-20', NULL, 'active'),
(2, 'Student14', 'Nick14', 'Seoul, Korea', '2006-03-25', 'HighSchool5', '010-4567-8901', '010-7777-8888', 'student14@ewha-lms.com', '2024-01-15', '2024-02-13', 'withdrawn'),
(2, 'Student15', 'Nick15', 'Seoul, Korea', '2007-07-07', 'HighSchool6', '010-5678-9012', '010-5555-6666', 'student15@ewha-lms.com', '2024-01-22', NULL, 'active'),
(2, 'Student16', 'Nick16', 'Seoul, Korea', '2005-06-30', 'HighSchool7', '010-6789-0123', '010-4444-5555', 'student16@ewha-lms.com', '2024-02-05', NULL, 'active'),
(2, 'Student17', 'Nick17', 'Seoul, Korea', '2006-08-15', 'HighSchool8', '010-7890-1234', '010-6666-7777', 'student17@ewha-lms.com', '2024-01-12', NULL, 'active'),
(2, 'Student18', 'Nick18', 'Seoul, Korea', '2007-09-10', 'HighSchool9', '010-8901-2345', '010-8888-9999', 'student18@ewha-lms.com', '2024-02-10', NULL, 'active'),
(2, 'Student19', 'Nick19', 'Seoul, Korea', '2005-10-01', 'HighSchool10', '010-9012-3456', '010-1234-5678', 'student19@ewha-lms.com', '2024-01-20', NULL, 'active'),
(2, 'Student20', 'Nick20', 'Seoul, Korea', '2006-11-05', 'HighSchool11', '010-1111-1212', '010-2222-2323', 'student20@ewha-lms.com', '2024-02-01', NULL, 'active');

INSERT INTO students (class_id, student_name, nickname, address, birth_date, high_school, student_phone, parent_phone, email, registration_date, withdrawal_date, registration_status)
VALUES
# 토B 반 (5명)
(3, 'Student21', 'Nick21', 'Seoul, Korea', '2006-02-28', 'HighSchool21', '010-3236-5678', '010-8769-4321', 'student21@ewha-lms.com', '2024-01-12', NULL, 'active'),
(3, 'Student22', 'Nick22', 'Seoul, Korea', '2005-06-01', 'HighSchool22', '010-4236-5678', '010-4769-4321', 'student22@ewha-lms.com', '2024-01-18', '2024-02-28', 'withdrawn'),
(3, 'Student23', 'Nick23', 'Seoul, Korea', '2007-07-07', 'HighSchool23', '010-5236-5678', '010-5769-4321', 'student23@ewha-lms.com', '2024-02-05', NULL, 'active'),
(3, 'Student24', 'Nick24', 'Seoul, Korea', '2006-10-13', 'HighSchool24', '010-6236-5678', '010-6769-4321', 'student24@ewha-lms.com', '2024-02-15', NULL, 'active'),
(3, 'Student25', 'Nick25', 'Seoul, Korea', '2005-09-20', 'HighSchool25', '010-7236-5678', '010-7769-4321', 'student25@ewha-lms.com', '2024-01-28', NULL, 'active'),
# 일 반 (18명)
(4, 'Student26', 'Nick26', 'Seoul, Korea', '2006-12-12', 'HighSchool26', '010-8236-5678', '010-8761-4321', 'student26@ewha-lms.com', '2024-01-10', NULL, 'active'),
(4, 'Student27', 'Nick27', 'Seoul, Korea', '2005-11-25', 'HighSchool27', '010-9236-5678', '010-9761-4321', 'student27@ewha-lms.com', '2024-01-18', NULL, 'active'),
(4, 'Student28', 'Nick28', 'Seoul, Korea', '2007-03-17', 'HighSchool28', '010-1237-5678', '010-8762-4321', 'student28@ewha-lms.com', '2024-01-25', NULL, 'active'),
(4, 'Student29', 'Nick29', 'Seoul, Korea', '2006-05-13', 'HighSchool29', '010-2237-5678', '010-9762-4321', 'student29@ewha-lms.com', '2024-02-01', NULL, 'active'),
(4, 'Student30', 'Nick30', 'Seoul, Korea', '2005-07-11', 'HighSchool30', '010-3237-5678', '010-8763-4321', 'student30@ewha-lms.com', '2024-01-05', '2024-02-20', 'withdrawn'),
(4, 'Student31', 'Nick31', 'Seoul, Korea', '2007-10-18', 'HighSchool31', '010-4237-5678', '010-4763-4321', 'student31@ewha-lms.com', '2024-02-10', NULL, 'active'),
(4, 'Student32', 'Nick32', 'Seoul, Korea', '2006-02-25', 'HighSchool32', '010-5237-5678', '010-5763-4321', 'student32@ewha-lms.com', '2024-02-15', NULL, 'active'),
(4, 'Student33', 'Nick33', 'Seoul, Korea', '2005-08-05', 'HighSchool33', '010-6237-5678', '010-6763-4321', 'student33@ewha-lms.com', '2024-01-12', NULL, 'active'),
(4, 'Student34', 'Nick34', 'Seoul, Korea', '2007-04-14', 'HighSchool34', '010-7237-5678', '010-7763-4321', 'student34@ewha-lms.com', '2024-02-01', NULL, 'active'),
(4, 'Student35', 'Nick35', 'Seoul, Korea', '2006-09-29', 'HighSchool35', '010-8237-5678', '010-8763-4321', 'student35@ewha-lms.com', '2024-01-15', NULL, 'active'),
(4, 'Student36', 'Nick36', 'Seoul, Korea', '2005-03-08', 'HighSchool36', '010-9237-5678', '010-9763-4321', 'student36@ewha-lms.com', '2024-02-12', '2024-02-23', 'withdrawn'),
(4, 'Student37', 'Nick37', 'Seoul, Korea', '2006-07-20', 'HighSchool37', '010-1238-5678', '010-8764-4321', 'student37@ewha-lms.com', '2024-01-25', NULL, 'active'),
(4, 'Student38', 'Nick38', 'Seoul, Korea', '2005-10-01', 'HighSchool38', '010-2238-5678', '010-9764-4321', 'student38@ewha-lms.com', '2024-01-18', NULL, 'active'),
(4, 'Student39', 'Nick39', 'Seoul, Korea', '2007-01-31', 'HighSchool39', '010-3238-5678', '010-8765-4321', 'student39@ewha-lms.com', '2024-01-12', '2024-02-25', 'withdrawn'),
(4, 'Student40', 'Nick40', 'Seoul, Korea', '2006-11-02', 'HighSchool40', '010-4238-5678', '010-4765-4321', 'student40@ewha-lms.com', '2024-02-01', NULL, 'active'),
(4, 'Student41', 'Nick41', 'Seoul, Korea', '2005-06-16', 'HighSchool41', '010-5238-5678', '010-5765-4321', 'student41@ewha-lms.com', '2024-01-05', NULL, 'active'),
(4, 'Student42', 'Nick42', 'Seoul, Korea', '2007-12-18', 'HighSchool42', '010-6238-5678', '010-6765-4321', 'student42@ewha-lms.com', '2024-02-10', NULL, 'active'),
# 월 반 (8명)
(5, 'Student43', 'Nick43', 'Seoul, Korea', '2005-09-13', 'HighSchool43', '010-7238-5678', '010-7765-4321', 'student43@ewha-lms.com', '2024-01-15', NULL, 'active'),
(5, 'Student44', 'Nick44', 'Seoul, Korea', '2006-02-20', 'HighSchool44', '010-8238-5678', '010-8765-4321', 'student44@ewha-lms.com', '2024-02-01', NULL, 'active'),
(5, 'Student45', 'Nick45', 'Seoul, Korea', '2007-11-10', 'HighSchool45', '010-9238-5678', '010-9765-4321', 'student45@ewha-lms.com', '2024-01-25', NULL, 'active'),
(5, 'Student46', 'Nick46', 'Seoul, Korea', '2005-05-24', 'HighSchool46', '010-1239-5678', '010-8766-4321', 'student46@ewha-lms.com', '2024-02-10', '2024-02-20', 'withdrawn'),
(5, 'Student47', 'Nick47', 'Seoul, Korea', '2006-06-16', 'HighSchool47', '010-2239-5678', '010-9766-4321', 'student47@ewha-lms.com', '2024-01-08', NULL, 'active'),
(5, 'Student48', 'Nick48', 'Seoul, Korea', '2007-09-07', 'HighSchool48', '010-3239-5678', '010-8767-4321', 'student48@ewha-lms.com', '2024-01-18', NULL, 'active'),
(5, 'Student49', 'Nick49', 'Seoul, Korea', '2005-08-30', 'HighSchool49', '010-4239-5678', '010-4767-4321', 'student49@ewha-lms.com', '2024-02-15', NULL, 'active'),
(5, 'Student50', 'Nick50', 'Seoul, Korea', '2006-01-12', 'HighSchool50', '010-5239-5678', '010-5767-4321', 'student50@ewha-lms.com', '2024-01-12', '2024-02-21', 'withdrawn');

SELECT * FROM students;

-- 수업 데이터 삽입
INSERT INTO sessions (session_id, class_id, session_date, session_number)
VALUES
# 1주차 (Session Number = 1)
(1, 1, '2024-01-05', 1),  -- 금요일반
(2, 2, '2024-01-06', 1),  -- 토A반
(3, 3, '2024-01-06', 1),  -- 토B반
(4, 4, '2024-01-07', 1),  -- 일요일반
(5, 5, '2024-01-08', 1);  -- 월요일반

INSERT INTO sessions (class_id, session_date, session_number)
VALUES
# 2주차 (Session Number = 2)
(1, '2024-01-12', 2), (2, '2024-01-13', 2), (3, '2024-01-13', 2), (4, '2024-01-14', 2), (5, '2024-01-15', 2),  
# 3주차 (Session Number = 3)
(1, '2024-01-19', 3), (2, '2024-01-20', 3), (3, '2024-01-20', 3), (4, '2024-01-21', 3), (5, '2024-01-22', 3),  
# 4주차 (Session Number = 4)
(1, '2024-01-26', 4), (2, '2024-01-27', 4), (3, '2024-01-27', 4), (4, '2024-01-28', 4), (5, '2024-01-29', 4), 
# 5주차 (Session Number = 5)
(1, '2024-02-02', 5), (2, '2024-02-03', 5), (3, '2024-02-03', 5), (4, '2024-02-04', 5), (5, '2024-02-05', 5),
# 6주차 (Session Number = 6)
(1, '2024-02-09', 6), (2, '2024-02-10', 6), (3, '2024-02-10', 6), (4, '2024-02-11', 6), (5, '2024-02-12', 6),
# 7주차 (Session Number = 7)
(1, '2024-02-16', 7), (2, '2024-02-17', 7), (3, '2024-02-17', 7), (4, '2024-02-18', 7), (5, '2024-02-19', 7),
# 8주차 (Session Number = 8)
(1, '2024-02-23', 8), (2, '2024-02-24', 8), (3, '2024-02-24', 8), (4, '2024-02-25', 8), (5, '2024-02-26', 8);

SELECT * FROM sessions;

-- 출석 데이터 삽입 
## 금요일 반
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
# 1주차 (session_number = 1, session_id = 1)
(1, 1, 'present', 'received'), (2, 1, 'present', 'received'), (3, 1, 'absent', NULL), (4, 1, 'online', 'not_received'), (5, 1, 'present', 'received'),
(6, 1, 'present', 'received'), (7, 1, 'makeup', 'received'), (8, 1, 'present', 'received'), (9, 1, 'absent', NULL),
# 2주차 (session_number = 2, session_id = 6)
(1, 6, 'makeup', 'received'), (2, 6, 'present', 'received'), (3, 6, 'absent', NULL), (4, 6, 'present', 'received'), (5, 6, 'present', 'received'),
(6, 6, 'online', 'not_received'), (7, 6, 'present', 'received'), (8, 6, 'absent', NULL), (9, 6, 'present', 'received'),
# 3주차 (session_number = 3, session_id = 11)
(1, 11, 'present', 'received'), (2, 11, 'online', 'not_received'), (3, 11, 'absent', NULL), (4, 11, 'present', 'received'), (5, 11, 'makeup', 'received'),
(6, 11, 'present', 'received'), (7, 11, 'present', 'received'), (8, 11, 'absent', NULL), (9, 11, 'present', 'received'),
# 4주차 (session_number = 4, session_id = 16)
(1, 16, 'present', 'received'), (2, 16, 'makeup', 'received'), (3, 16, 'online', 'not_received'), (4, 16, 'present', 'received'), (5, 16, 'present', 'received'),
(6, 16, 'present', 'received'), (7, 16, 'absent', NULL), (8, 16, 'present', 'received'), (9, 16, 'makeup', 'received'),
# 5주차 (session_number = 5, session_id = 21)
(1, 21, 'present', 'received'), (2, 21, 'present', 'received'), (3, 21, 'online', 'not_received'), (4, 21, 'absent', NULL), (5, 21, 'present', 'received'),
(6, 21, 'present', 'received'), (7, 21, 'present', 'received'), (8, 21, 'present', 'received'), (9, 21, 'absent', NULL),
# 6주차 (session_number = 6, session_id = 26)
(1, 26, 'present', 'received'), (2, 26, 'absent', NULL), (3, 26, 'online', 'not_received'), (4, 26, 'present', 'received'), (5, 26, 'makeup', 'received'),
(6, 26, 'present', 'received'), (7, 26, 'present', 'received'), (8, 26, 'absent', NULL), (9, 26, 'present', 'received'),
# 7주차 (session_number = 7, session_id = 31)
(1, 31, 'present', 'received'), (2, 31, 'makeup', 'received'), (3, 31, 'absent', NULL), (4, 31, 'present', 'received'), (5, 31, 'present', 'received'),
(6, 31, 'online', 'not_received'), (7, 31, 'present', 'received'), (8, 31, 'present', 'received'), (9, 31, 'makeup', 'received'),
# 8주차 (session_number = 8, session_id = 36)
(1, 36, 'present', 'received'), (2, 36, 'present', 'received'), (3, 36, 'absent', NULL), (4, 36, 'online', 'not_received'), (5, 36, 'makeup', 'received'),
(6, 36, 'present', 'received'), (7, 36, 'present', 'received'), (8, 36, 'absent', NULL), (9, 36, 'present', 'received');

## 토요일A반
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
# 1주차 (session_number = 1, session_id = 2)
(10, 2, 'present', 'received'), (11, 2, 'present', 'received'), (12, 2, 'online', 'not_received'), (13, 2, 'absent', NULL), (14, 2, 'present', 'received'),
(15, 2, 'present', 'received'), (16, 2, 'makeup', 'received'), (17, 2, 'absent', NULL), (18, 2, 'present', 'received'), (19, 2, 'present', 'received'), (20, 2, 'present', 'received'),
# 2주차 (session_number = 2, session_id = 7)
(10, 7, 'present', 'received'), (11, 7, 'online', 'not_received'), (12, 7, 'absent', NULL), (13, 7, 'present', 'received'), (14, 7, 'present', 'received'),
(15, 7, 'makeup', 'received'), (16, 7, 'present', 'received'), (17, 7, 'absent', NULL), (18, 7, 'present', 'received'), (19, 7, 'present', 'received'), (20, 7, 'absent', NULL),
# 3주차 (session_number = 3, session_id = 12)
(10, 12, 'absent', NULL), (11, 12, 'present', 'received'), (12, 12, 'present', 'received'), (13, 12, 'makeup', 'received'), (14, 12, 'present', 'received'),
(15, 12, 'present', 'received'), (16, 12, 'absent', NULL), (17, 12, 'present', 'received'), (18, 12, 'online', 'not_received'), (19, 12, 'present', 'received'), (20, 12, 'present', 'received'),
# 4주차 (session_number = 4, session_id = 17)
(10, 17, 'present', 'received'), (11, 17, 'absent', NULL), (12, 17, 'present', 'received'), (13, 17, 'present', 'received'), (14, 17, 'online', 'not_received'),
(15, 17, 'present', 'received'), (16, 17, 'present', 'received'), (17, 17, 'present', 'received'), (18, 17, 'absent', NULL), (19, 17, 'present', 'received'), (20, 17, 'makeup', 'received'),
# 5주차 (session_number = 5, session_id = 22)
(10, 22, 'present', 'received'), (11, 22, 'present', 'received'), (12, 22, 'absent', NULL), (13, 22, 'present', 'received'), (14, 22, 'present', 'received'),
(15, 22, 'online', 'not_received'), (16, 22, 'present', 'received'), (17, 22, 'present', 'received'), (18, 22, 'absent', NULL), (19, 22, 'makeup', 'received'), (20, 22, 'present', 'received'),
# 6주차 (session_number = 6, session_id = 27)
(10, 27, 'online', 'not_received'), (11, 27, 'present', 'received'), (12, 27, 'present', 'received'), (13, 27, 'absent', NULL), (14, 27, 'present', 'received'),
(15, 27, 'present', 'received'), (16, 27, 'absent', NULL), (17, 27, 'makeup', 'received'), (18, 27, 'present', 'received'), (19, 27, 'present', 'received'), (20, 27, 'online', 'not_received'),
# 7주차 (session_number = 7, session_id = 32)
(10, 32, 'present', 'received'), (11, 32, 'present', 'received'), (12, 32, 'online', 'not_received'), (13, 32, 'present', 'received'), (14, 32, 'makeup', 'received'),
(15, 32, 'absent', NULL), (16, 32, 'present', 'received'), (17, 32, 'present', 'received'), (18, 32, 'absent', NULL), (19, 32, 'present', 'received'), (20, 32, 'present', 'received'),
# 8주차 (session_number = 8, session_id = 37)
(10, 37, 'present', 'received'), (11, 37, 'present', 'received'), (12, 37, 'absent', NULL), (13, 37, 'present', 'received'), (14, 37, 'online', 'not_received'),
(15, 37, 'present', 'received'), (16, 37, 'present', 'received'), (17, 37, 'makeup', 'received'), (18, 37, 'present', 'received'), (19, 37, 'present', 'received'), (20, 37, 'absent', NULL);

## 토요일B 반
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
# 1주차 (session_number = 1, session_id = 3)
(21, 3, 'present', 'received'), (22, 3, 'absent', NULL), (23, 3, 'present', 'received'), (24, 3, 'online', 'not_received'), (25, 3, 'present', 'received'),
# 2주차 (session_number = 2, session_id = 8)
(21, 8, 'present', 'received'), (22, 8, 'online', 'not_received'), (23, 8, 'present', 'received'), (24, 8, 'present', 'received'), (25, 8, 'absent', NULL),
# 3주차 (session_number = 3, session_id = 13)
(21, 13, 'present', 'received'), (22, 13, 'absent', NULL), (23, 13, 'makeup', 'received'), (24, 13, 'present', 'received'), (25, 13, 'online', 'not_received'),
# 4주차 (session_number = 4, session_id = 18)
(21, 18, 'present', 'received'), (22, 18, 'present', 'received'), (23, 18, 'present', 'received'), (24, 18, 'absent', NULL), (25, 18, 'present', 'received'),
# 5주차 (session_number = 5, session_id = 23)
(21, 23, 'present', 'received'), (22, 23, 'makeup', 'received'), (23, 23, 'present', 'received'), (24, 23, 'absent', NULL), (25, 23, 'present', 'received'),
# 6주차 (session_number = 6, session_id = 28)
(21, 28, 'online', 'not_received'), (22, 28, 'present', 'received'), (23, 28, 'present', 'received'), (24, 28, 'present', 'received'), (25, 28, 'absent', NULL),
# 7주차 (session_number = 7, session_id = 33)
(21, 33, 'present', 'received'), (22, 33, 'absent', NULL), (23, 33, 'makeup', 'received'), (24, 33, 'present', 'received'), (25, 33, 'present', 'received'),
# 8주차 (session_number = 8, session_id = 38)
(21, 38, 'present', 'received'), (22, 38, 'online', 'not_received'), (23, 38, 'present', 'received'), (24, 38, 'absent', NULL), (25, 38, 'present', 'received');

## 일요일 반
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
# 1주차 (session_number = 1, session_id = 4)
(26, 4, 'present', 'received'), (27, 4, 'present', 'received'), (28, 4, 'online', 'not_received'), (29, 4, 'absent', NULL), (30, 4, 'present', 'received'),
(31, 4, 'present', 'received'), (32, 4, 'absent', NULL), (33, 4, 'present', 'received'), (34, 4, 'present', 'received'), (35, 4, 'online', 'not_received'),
(36, 4, 'present', 'received'), (37, 4, 'present', 'received'), (38, 4, 'present', 'received'), (39, 4, 'absent', NULL), (40, 4, 'present', 'received'),
(41, 4, 'makeup', 'received'), (42, 4, 'present', 'received'),
# 2주차 (session_number = 2, session_id = 9)
(26, 9, 'present', 'received'), (27, 9, 'online', 'not_received'), (28, 9, 'present', 'received'), (29, 9, 'absent', NULL), (30, 9, 'present', 'received'),
(31, 9, 'present', 'received'), (32, 9, 'makeup', 'received'), (33, 9, 'present', 'received'), (34, 9, 'present', 'received'), (35, 9, 'absent', NULL),
(36, 9, 'present', 'received'), (37, 9, 'online', 'not_received'), (38, 9, 'present', 'received'), (39, 9, 'absent', NULL), (40, 9, 'present', 'received'),
(41, 9, 'present', 'received'), (42, 9, 'present', 'received'),
# 3주차 (session_number = 3, session_id = 14)
(26, 14, 'present', 'received'), (27, 14, 'present', 'received'), (28, 14, 'absent', NULL), (29, 14, 'present', 'received'), (30, 14, 'present', 'received'),
(31, 14, 'present', 'received'), (32, 14, 'absent', NULL), (33, 14, 'present', 'received'), (34, 14, 'makeup', 'received'), (35, 14, 'present', 'received'),
(36, 14, 'online', 'not_received'), (37, 14, 'present', 'received'), (38, 14, 'present', 'received'), (39, 14, 'absent', NULL), (40, 14, 'present', 'received'),
(41, 14, 'present', 'received'), (42, 14, 'online', 'not_received'),
# 4주차 (session_number = 4, session_id = 19)
(26, 19, 'present', 'received'), (27, 19, 'online', 'not_received'), (28, 19, 'present', 'received'), (29, 19, 'absent', NULL), (30, 19, 'present', 'received'),
(31, 19, 'present', 'received'), (32, 19, 'present', 'received'), (33, 19, 'present', 'received'), (34, 19, 'absent', NULL), (35, 19, 'present', 'received'),
(36, 19, 'present', 'received'), (37, 19, 'present', 'received'), (38, 19, 'absent', NULL), (39, 19, 'present', 'received'), (40, 19, 'online', 'not_received'),
(41, 19, 'present', 'received'), (42, 19, 'present', 'received'),
# 5주차 (session_number = 5, session_id = 24)
(26, 24, 'present', 'received'), (27, 24, 'absent', NULL), (28, 24, 'present', 'received'), (29, 24, 'present', 'received'), (30, 24, 'online', 'not_received'),
(31, 24, 'present', 'received'), (32, 24, 'present', 'received'), (33, 24, 'present', 'received'), (34, 24, 'present', 'received'), (35, 24, 'absent', NULL),
(36, 24, 'present', 'received'), (37, 24, 'makeup', 'received'), (38, 24, 'present', 'received'), (39, 24, 'absent', NULL), (40, 24, 'present', 'received'),
(41, 24, 'present', 'received'), (42, 24, 'online', 'not_received'),
# 6주차 (session_number = 6, session_id = 29)
(26, 29, 'present', 'received'), (27, 29, 'present', 'received'), (28, 29, 'absent', NULL), (29, 29, 'present', 'received'), (30, 29, 'online', 'not_received'),
(31, 29, 'present', 'received'), (32, 29, 'present', 'received'), (33, 29, 'makeup', 'received'), (34, 29, 'absent', NULL), (35, 29, 'present', 'received'),
(36, 29, 'online', 'not_received'), (37, 29, 'present', 'received'), (38, 29, 'present', 'received'), (39, 29, 'present', 'received'), (40, 29, 'present', 'received'),
(41, 29, 'absent', NULL), (42, 29, 'present', 'received'),
# 7주차 (session_number = 7, session_id = 34)
(26, 34, 'present', 'received'), (27, 34, 'present', 'received'), (28, 34, 'online', 'not_received'), (29, 34, 'absent', NULL), (30, 34, 'present', 'received'),
(31, 34, 'present', 'received'), (32, 34, 'absent', NULL), (33, 34, 'present', 'received'), (34, 34, 'present', 'received'), (35, 34, 'makeup', 'received'),
(36, 34, 'present', 'received'), (37, 34, 'present', 'received'), (38, 34, 'absent', NULL), (39, 34, 'present', 'received'), (40, 34, 'present', 'received'),
(41, 34, 'present', 'received'), (42, 34, 'online', 'not_received'),
# 8주차 (session_number = 8, session_id = 39)
(26, 39, 'present', 'received'), (27, 39, 'absent', NULL), (28, 39, 'present', 'received'), (29, 39, 'present', 'received'), (30, 39, 'present', 'received'),
(31, 39, 'present', 'received'), (32, 39, 'online', 'not_received'), (33, 39, 'present', 'received'), (34, 39, 'absent', NULL), (35, 39, 'present', 'received'),
(36, 39, 'present', 'received'), (37, 39, 'present', 'received'), (38, 39, 'absent', NULL), (39, 39, 'online', 'not_received'), (40, 39, 'present', 'received'),
(41, 39, 'present', 'received'), (42, 39, 'present', 'received');

## 월요일 반
INSERT INTO attendance (student_id, session_id, attendance_status, material_status)
VALUES
# 1주차 (session_number = 1, session_id = 5)
(43, 5, 'present', 'received'), (44, 5, 'absent', NULL), (45, 5, 'present', 'received'), (46, 5, 'online', 'not_received'), (47, 5, 'present', 'received'),
(48, 5, 'present', 'received'), (49, 5, 'present', 'received'), (50, 5, 'present', 'received'),
# 2주차 (session_number = 2, session_id = 10)
(43, 10, 'online', 'not_received'), (44, 10, 'present', 'received'), (45, 10, 'present', 'received'), (46, 10, 'present', 'received'), (47, 10, 'present', 'received'),
(48, 10, 'absent', NULL), (49, 10, 'present', 'received'), (50, 10, 'present', 'received'),
# 3주차 (session_number = 3, session_id = 15)
(43, 15, 'present', 'received'), (44, 15, 'present', 'received'), (45, 15, 'absent', NULL), (46, 15, 'present', 'received'), (47, 15, 'present', 'received'),
(48, 15, 'online', 'not_received'), (49, 15, 'present', 'received'), (50, 15, 'present', 'received'),
# 4주차 (session_number = 4, session_id = 20)
(43, 20, 'present', 'received'), (44, 20, 'online', 'not_received'), (45, 20, 'present', 'received'), (46, 20, 'absent', NULL), (47, 20, 'present', 'received'),
(48, 20, 'present', 'received'), (49, 20, 'present', 'received'), (50, 20, 'present', 'received'),
# 5주차 (session_number = 5, session_id = 25)
(43, 25, 'present', 'received'), (44, 25, 'absent', NULL), (45, 25, 'present', 'received'), (46, 25, 'online', 'not_received'), (47, 25, 'present', 'received'),
(48, 25, 'present', 'received'), (49, 25, 'present', 'received'), (50, 25, 'present', 'received'),
# 6주차 (session_number = 6, session_id = 30)
(43, 30, 'present', 'received'), (44, 30, 'present', 'received'), (45, 30, 'present', 'received'), (46, 30, 'absent', NULL), (47, 30, 'present', 'received'),
(48, 30, 'online', 'not_received'), (49, 30, 'present', 'received'), (50, 30, 'present', 'received'),
# 7주차 (session_number = 7, session_id = 35)
(43, 35, 'online', 'not_received'), (44, 35, 'present', 'received'), (45, 35, 'present', 'received'), (46, 35, 'present', 'received'), (47, 35, 'present', 'received'),
(48, 35, 'absent', NULL), (49, 35, 'present', 'received'), (50, 35, 'present', 'received'),
# 8주차 (session_number = 8, session_id = 40)
(43, 40, 'present', 'received'), (44, 40, 'present', 'received'), (45, 40, 'present', 'received'), (46, 40, 'present', 'received'), (47, 40, 'absent', NULL),
(48, 40, 'present', 'received'), (49, 40, 'online', 'not_received'), (50, 40, 'present', 'received');
SELECT count(*) FROM attendance;
select * from attendance;
select * from students;   

-- 시험 데이터 삽입
INSERT INTO tests (session_id, test_type, test_date)
VALUES
# 1주차 (session_number = 1)
(1, '단어시험', '2024-01-05'), (1, '모의고사', '2024-01-05'),
(2, '단어시험', '2024-01-06'), (2, '모의고사', '2024-01-06'),
(3, '단어시험', '2024-01-06'), (3, '모의고사', '2024-01-06'),
(4, '단어시험', '2024-01-07'), (4, '모의고사', '2024-01-07'),
(5, '단어시험', '2024-01-08'), (5, '모의고사', '2024-01-08'),
# 2주차 (session_number = 2)
(6, '단어시험', '2024-01-12'), (6, '모의고사', '2024-01-12'),
(7, '단어시험', '2024-01-13'), (7, '모의고사', '2024-01-13'),
(8, '단어시험', '2024-01-13'), (8, '모의고사', '2024-01-13'),
(9, '단어시험', '2024-01-14'), (9, '모의고사', '2024-01-14'),
(10, '단어시험', '2024-01-15'), (10, '모의고사', '2024-01-15'),
# 3주차 (session_number = 3)
(11, '단어시험', '2024-01-19'), (11, '모의고사', '2024-01-19'),
(12, '단어시험', '2024-01-20'), (12, '모의고사', '2024-01-20'),
(13, '단어시험', '2024-01-20'), (13, '모의고사', '2024-01-20'),
(14, '단어시험', '2024-01-21'), (14, '모의고사', '2024-01-21'),
(15, '단어시험', '2024-01-22'), (15, '모의고사', '2024-01-22'),
# 4주차 (session_number = 4)
(16, '단어시험', '2024-01-26'), (16, '모의고사', '2024-01-26'),
(17, '단어시험', '2024-01-27'), (17, '모의고사', '2024-01-27'),
(18, '단어시험', '2024-01-27'), (18, '모의고사', '2024-01-27'),
(19, '단어시험', '2024-01-28'), (19, '모의고사', '2024-01-28'),
(20, '단어시험', '2024-01-29'), (20, '모의고사', '2024-01-29'),
# 5주차 (session_number = 5)
(21, '단어시험', '2024-02-02'), (21, '모의고사', '2024-02-02'),
(22, '단어시험', '2024-02-03'), (22, '모의고사', '2024-02-03'),
(23, '단어시험', '2024-02-03'), (23, '모의고사', '2024-02-03'),
(24, '단어시험', '2024-02-04'), (24, '모의고사', '2024-02-04'),
(25, '단어시험', '2024-02-05'), (25, '모의고사', '2024-02-05'),
# 6주차 (session_number = 6)
(26, '단어시험', '2024-02-09'), (26, '모의고사', '2024-02-09'),
(27, '단어시험', '2024-02-10'), (27, '모의고사', '2024-02-10'),
(28, '단어시험', '2024-02-10'), (28, '모의고사', '2024-02-10'),
(29, '단어시험', '2024-02-11'), (29, '모의고사', '2024-02-11'),
(30, '단어시험', '2024-02-12'), (30, '모의고사', '2024-02-12'),
# 7주차 (session_number = 7)
(31, '단어시험', '2024-02-16'), (31, '모의고사', '2024-02-16'),
(32, '단어시험', '2024-02-17'), (32, '모의고사', '2024-02-17'),
(33, '단어시험', '2024-02-17'), (33, '모의고사', '2024-02-17'),
(34, '단어시험', '2024-02-18'), (34, '모의고사', '2024-02-18'),
(35, '단어시험', '2024-02-19'), (35, '모의고사', '2024-02-19'),
# 8주차 (session_number = 8)
(36, '단어시험', '2024-02-23'), (36, '모의고사', '2024-02-23'),
(37, '단어시험', '2024-02-24'), (37, '모의고사', '2024-02-24'),
(38, '단어시험', '2024-02-24'), (38, '모의고사', '2024-02-24'),
(39, '단어시험', '2024-02-25'), (39, '모의고사', '2024-02-25'),
(40, '단어시험', '2024-02-26'), (40, '모의고사', '2024-02-26');

SELECT * FROM tests;

-- 시험 결과 데이터 
## 금요일 반
INSERT INTO test_results (student_id, test_id, score, retest_required)
VALUES
# 1주차
(1, 1, 38, 'N'), (1, 2, 89, NULL), (2, 1, 37, 'N'), (2, 2, 87, NULL),
(5, 1, 39, 'N'), (5, 2, 90, NULL), (6, 1, 36, 'N'), (6, 2, 84, NULL),
(7, 1, 35, 'Y'), (7, 2, 78, NULL), (8, 1, 40, 'N'), (8, 2, 91, NULL),
# 2주차
(1, 11, 39, 'N'), (1, 12, 92, NULL), (2, 11, 36, 'N'), (2, 12, 85, NULL),
(4, 11, 35, 'Y'), (4, 12, 79, NULL), (5, 11, 40, 'N'), (5, 12, 94, NULL),
(7, 11, 34, 'Y'), (7, 12, 74, NULL), (9, 11, 38, 'N'), (9, 12, 89, NULL),
# 3주차
(1, 21, 40, 'N'), (1, 22, 93, NULL), (4, 21, 37, 'N'), (4, 22, 88, NULL),
(5, 21, 39, 'N'), (5, 22, 91, NULL), (6, 21, 34, 'Y'), (6, 22, 75, NULL),
(7, 21, 36, 'N'), (7, 22, 84, NULL), (9, 21, 38, 'N'), (9, 22, 89, NULL),
# 4주차
(1, 31, 39, 'N'), (1, 32, 90, NULL), (2, 31, 38, 'N'), (2, 32, 88, NULL),
(4, 31, 36, 'N'), (4, 32, 86, NULL), (5, 31, 40, 'N'), (5, 32, 94, NULL),
(6, 31, 37, 'N'), (6, 32, 87, NULL), (8, 31, 35, 'Y'), (8, 32, 77, NULL),
(9, 31, 36, 'N'), (9, 32, 85, NULL),
# 5주차
(1, 41, 38, 'N'), (1, 42, 89, NULL), (2, 41, 37, 'N'), (2, 42, 87, NULL),
(5, 41, 39, 'N'), (5, 42, 90, NULL), (6, 41, 36, 'N'), (6, 42, 84, NULL),
(7, 41, 35, 'Y'), (7, 42, 78, NULL), (8, 41, 40, 'N'), (8, 42, 91, NULL),
# 6주차
(1, 51, 40, 'N'), (1, 52, 93, NULL), (4, 51, 35, 'Y'), (4, 52, 78, NULL),
(5, 51, 39, 'N'), (5, 52, 89, NULL), (6, 51, 36, 'N'), (6, 52, 87, NULL),
(7, 51, 34, 'Y'), (7, 52, 75, NULL), (9, 51, 38, 'N'), (9, 52, 90, NULL),
# 7주차
(1, 61, 38, 'N'), (1, 62, 89, NULL), (2, 61, 37, 'N'), (2, 62, 85, NULL),
(5, 61, 40, 'N'), (5, 62, 94, NULL), (6, 61, 34, 'Y'), (6, 62, 76, NULL),
(7, 61, 36, 'N'), (7, 62, 84, NULL), (8, 61, 39, 'N'), (8, 62, 90, NULL),
# 8주차
(1, 71, 39, 'N'), (1, 72, 92, NULL), (2, 71, 38, 'N'), (2, 72, 86, NULL),
(4, 71, 34, 'Y'), (4, 72, 74, NULL), (5, 71, 40, 'N'), (5, 72, 93, NULL),
(7, 71, 35, 'Y'), (7, 72, 78, NULL), (9, 71, 36, 'N'), (9, 72, 85, NULL);

## 토요일A 반
INSERT INTO test_results (student_id, test_id, score, retest_required)
VALUES
# 1주차
(10, 1, 36, 'N'), (10, 2, 85, NULL), (11, 1, 38, 'N'), (11, 2, 90, NULL),
(14, 1, 35, 'Y'), (14, 2, 75, NULL), (15, 1, 37, 'N'), (15, 2, 88, NULL),
(16, 1, 33, 'Y'), (16, 2, 72, NULL), (18, 1, 40, 'N'), (18, 2, 95, NULL),
(19, 1, 34, 'Y'), (19, 2, 78, NULL), (20, 1, 39, 'N'), (20, 2, 89, NULL), 
# 2주차
(10, 11, 36, 'N'), (10, 12, 84, NULL), (13, 11, 34, 'Y'), (13, 12, 70, NULL),
(14, 11, 39, 'N'), (14, 12, 89, NULL), (15, 11, 37, 'N'), (15, 12, 85, NULL),
(16, 11, 33, 'Y'), (16, 12, 72, NULL), (18, 11, 40, 'N'), (18, 12, 93, NULL),
(19, 11, 35, 'Y'), (19, 12, 75, NULL),
# 3주차
(11, 21, 38, 'N'), (11, 22, 92, NULL), (12, 21, 34, 'Y'), (12, 22, 74, NULL),
(13, 21, 39, 'N'), (13, 22, 88, NULL), (14, 21, 35, 'Y'), (14, 22, 79, NULL),
(15, 21, 40, 'N'), (15, 22, 96, NULL), (17, 21, 32, 'Y'), (17, 22, 70, NULL),
(19, 21, 37, 'N'), (19, 22, 85, NULL), (20, 21, 36, 'N'), (20, 22, 89, NULL),
# 4주차
(10, 31, 38, 'N'), (10, 32, 87, NULL), (12, 31, 34, 'Y'), (12, 32, 73, NULL),
(13, 31, 40, 'N'), (13, 32, 91, NULL), (15, 31, 37, 'N'), (15, 32, 86, NULL),
(16, 31, 33, 'Y'), (16, 32, 72, NULL), (17, 31, 35, 'Y'), (17, 32, 75, NULL),
(19, 31, 39, 'N'), (19, 32, 88, NULL), (20, 31, 36, 'N'), (20, 32, 90, NULL),
# 5주차
(10, 41, 37, 'N'), (10, 42, 89, NULL), (11, 41, 39, 'N'), (11, 42, 90, NULL),
(13, 41, 32, 'Y'), (13, 42, 70, NULL), (14, 41, 36, 'N'), (14, 42, 85, NULL),
(16, 41, 33, 'Y'), (16, 42, 71, NULL), (17, 41, 35, 'Y'), (17, 42, 77, NULL),
(19, 41, 40, 'N'), (19, 42, 95, NULL), (20, 41, 36, 'N'), (20, 42, 89, NULL),
# 6주차
(10, 51, 39, 'N'), (10, 52, 92, NULL), (11, 51, 36, 'N'), (11, 52, 84, NULL),
(13, 51, 34, 'Y'), (13, 52, 73, NULL), (15, 51, 38, 'N'), (15, 52, 88, NULL),
(16, 51, 32, 'Y'), (16, 52, 70, NULL), (17, 51, 40, 'N'), (17, 52, 93, NULL),
(19, 51, 35, 'Y'), (19, 52, 75, NULL), (20, 51, 37, 'N'), (20, 52, 86, NULL),
# 7주차
(10, 61, 38, 'N'), (10, 62, 85, NULL), (11, 61, 39, 'N'), (11, 62, 91, NULL),
(12, 61, 34, 'Y'), (12, 62, 74, NULL), (14, 61, 36, 'N'), (14, 62, 80, NULL),
(15, 61, 37, 'N'), (15, 62, 87, NULL), (19, 61, 40, 'N'), (19, 62, 94, NULL),
(20, 61, 35, 'Y'), (20, 62, 78, NULL),
# 8주차
(10, 71, 37, 'N'), (10, 72, 86, NULL), (12, 71, 32, 'Y'), (12, 72, 72, NULL),
(14, 71, 36, 'N'), (14, 72, 85, NULL), (15, 71, 38, 'N'), (15, 72, 88, NULL),
(16, 71, 34, 'Y'), (16, 72, 73, NULL), (19, 71, 39, 'N'), (19, 72, 91, NULL),
(20, 71, 36, 'N'), (20, 72, 90, NULL);

## 토요일 B반
INSERT INTO test_results (student_id, test_id, score, retest_required)
VALUES
# 1주차 
(21, 3, 38, 'N'), (21, 4, 85, NULL), (23, 3, 37, 'N'), (23, 4, 88, NULL), (25, 3, 35, 'Y'), (25, 4, 75, NULL),
# 2주차
(21, 8, 36, 'N'), (21, 9, 83, NULL), (23, 8, 38, 'N'), (23, 9, 90, NULL), (24, 8, 34, 'Y'), (24, 9, 72, NULL),
# 3주차 
(21, 13, 40, 'N'), (21, 14, 92, NULL), (23, 13, 39, 'N'), (23, 14, 87, NULL), (24, 13, 33, 'Y'), (24, 14, 74, NULL),
# 4주차 
(21, 18, 37, 'N'), (21, 19, 88, NULL), (22, 18, 35, 'Y'), (22, 19, 75, NULL), (23, 18, 40, 'N'), (23, 19, 94, NULL), (25, 18, 36, 'N'), (25, 19, 85, NULL),
# 5주차 
(21, 23, 39, 'N'), (21, 24, 91, NULL), (22, 23, 33, 'Y'), (22, 24, 73, NULL), (23, 23, 38, 'N'), (23, 24, 89, NULL), (25, 23, 34, 'Y'), (25, 24, 78, NULL),
# 6주차 
(22, 28, 36, 'N'), (22, 29, 85, NULL), (23, 28, 39, 'N'), (23, 29, 90, NULL), (24, 28, 32, 'Y'), (24, 29, 70, NULL),
# 7주차
(21, 33, 38, 'N'), (21, 34, 86, NULL), (23, 33, 40, 'N'), (23, 34, 95, NULL), (24, 33, 35, 'Y'), (24, 34, 77, NULL), (25, 33, 34, 'Y'), (25, 34, 74, NULL),
# 8주차
(21, 38, 37, 'N'), (21, 39, 88, NULL), (23, 38, 40, 'N'), (23, 39, 90, NULL), (25, 38, 36, 'N'), (25, 39, 85, NULL);

## 일요일 반 
INSERT INTO test_results (student_id, test_id, score, retest_required)
VALUES
# 1주차
(26, 4, 39, 'N'), (26, 5, 85, NULL), (27, 4, 36, 'N'), (27, 5, 90, NULL),
(30, 4, 34, 'Y'), (30, 5, 72, NULL), (31, 4, 40, 'N'), (31, 5, 92, NULL),
(33, 4, 38, 'N'), (33, 5, 88, NULL), (34, 4, 35, 'Y'), (34, 5, 77, NULL),
(36, 4, 37, 'N'), (36, 5, 89, NULL), (37, 4, 39, 'N'), (37, 5, 94, NULL),
(38, 4, 40, 'N'), (38, 5, 96, NULL), (40, 4, 38, 'N'), (40, 5, 88, NULL),
(41, 4, 34, 'Y'), (41, 5, 70, NULL), (42, 4, 40, 'N'), (42, 5, 95, NULL),
# 2주차
(26, 9, 38, 'N'), (26, 10, 85, NULL), (28, 9, 35, 'Y'), (28, 10, 77, NULL),
(30, 9, 39, 'N'), (30, 10, 89, NULL), (31, 9, 37, 'N'), (31, 10, 92, NULL),
(32, 9, 36, 'N'), (32, 10, 85, NULL), (33, 9, 40, 'N'), (33, 10, 93, NULL),
(34, 9, 39, 'N'), (34, 10, 89, NULL), (36, 9, 38, 'N'), (36, 10, 90, NULL),
(38, 9, 37, 'N'), (38, 10, 85, NULL), (40, 9, 34, 'Y'), (40, 10, 72, NULL),
(41, 9, 35, 'Y'), (41, 10, 78, NULL), (42, 9, 36, 'N'), (42, 10, 85, NULL),
# 3주차
(26, 14, 37, 'N'), (26, 15, 88, NULL), (27, 14, 36, 'N'), (27, 15, 90, NULL),
(29, 14, 35, 'Y'), (29, 15, 77, NULL), (30, 14, 38, 'N'), (30, 15, 92, NULL),
(31, 14, 37, 'N'), (31, 15, 89, NULL), (33, 14, 40, 'N'), (33, 15, 94, NULL),
(34, 14, 36, 'N'), (34, 15, 85, NULL), (35, 14, 34, 'Y'), (35, 15, 70, NULL),
(37, 14, 39, 'N'), (37, 15, 93, NULL), (38, 14, 40, 'N'), (38, 15, 96, NULL),
(40, 14, 38, 'N'), (40, 15, 90, NULL), (41, 14, 37, 'N'), (41, 15, 85, NULL),
# 4주차
(26, 19, 40, 'N'), (26, 20, 92, NULL), (28, 19, 36, 'N'), (28, 20, 85, NULL),
(30, 19, 34, 'Y'), (30, 20, 75, NULL), (31, 19, 38, 'N'), (31, 20, 88, NULL),
(32, 19, 35, 'Y'), (32, 20, 77, NULL), (33, 19, 40, 'N'), (33, 20, 95, NULL),
(35, 19, 37, 'N'), (35, 20, 89, NULL), (36, 19, 38, 'N'), (36, 20, 90, NULL),
(38, 19, 39, 'N'), (38, 20, 93, NULL), (40, 19, 36, 'N'), (40, 20, 85, NULL),
(41, 19, 34, 'Y'), (41, 20, 70, NULL), (42, 19, 40, 'N'), (42, 20, 94, NULL),
# 5주차
(26, 24, 39, 'N'), (26, 25, 91, NULL), (28, 24, 34, 'Y'), (28, 25, 72, NULL),
(29, 24, 37, 'N'), (29, 25, 86, NULL), (30, 24, 35, 'Y'), (30, 25, 75, NULL),
(31, 24, 36, 'N'), (31, 25, 88, NULL), (32, 24, 40, 'N'), (32, 25, 95, NULL),
(33, 24, 37, 'N'), (33, 25, 89, NULL), (34, 24, 36, 'N'), (34, 25, 85, NULL),
(36, 24, 40, 'N'), (36, 25, 94, NULL), (38, 24, 39, 'N'), (38, 25, 92, NULL),
(40, 24, 38, 'N'), (40, 25, 88, NULL), (41, 24, 35, 'Y'), (41, 25, 77, NULL),
(42, 24, 37, 'N'), (42, 25, 85, NULL),
# 6주차
(26, 29, 36, 'N'), (26, 30, 88, NULL), (27, 29, 39, 'N'), (27, 30, 90, NULL),
(28, 29, 33, 'Y'), (28, 30, 72, NULL), (30, 29, 40, 'N'), (30, 30, 94, NULL),
(31, 29, 35, 'Y'), (31, 30, 75, NULL), (32, 29, 36, 'N'), (32, 30, 85, NULL),
(33, 29, 38, 'N'), (33, 30, 89, NULL), (35, 29, 40, 'N'), (35, 30, 96, NULL),
(37, 29, 39, 'N'), (37, 30, 93, NULL), (38, 29, 40, 'N'), (38, 30, 96, NULL),
(40, 29, 34, 'Y'), (40, 30, 74, NULL), (41, 29, 35, 'Y'), (41, 30, 77, NULL),
# 7주차
(26, 34, 40, 'N'), (26, 35, 92, NULL), (27, 34, 37, 'N'), (27, 35, 85, NULL),
(28, 34, 38, 'N'), (28, 35, 90, NULL), (29, 34, 36, 'N'), (29, 35, 87, NULL),
(30, 34, 39, 'N'), (30, 35, 95, NULL), (32, 34, 34, 'Y'), (32, 35, 73, NULL),
(33, 34, 35, 'Y'), (33, 35, 74, NULL), (35, 34, 40, 'N'), (35, 35, 93, NULL),
(36, 34, 38, 'N'), (36, 35, 89, NULL), (38, 34, 39, 'N'), (38, 35, 94, NULL),
(40, 34, 37, 'N'), (40, 35, 88, NULL), (41, 34, 36, 'N'), (41, 35, 86, NULL),
# 8주차
(26, 39, 39, 'N'), (26, 40, 91, NULL), (27, 39, 38, 'N'), (27, 40, 89, NULL),
(28, 39, 34, 'Y'), (28, 40, 72, NULL), (29, 39, 36, 'N'), (29, 40, 86, NULL),
(30, 39, 40, 'N'), (30, 40, 95, NULL), (31, 39, 38, 'N'), (31, 40, 89, NULL),
(33, 39, 39, 'N'), (33, 40, 93, NULL), (34, 39, 40, 'N'), (34, 40, 94, NULL),
(36, 39, 38, 'N'), (36, 40, 87, NULL), (38, 39, 39, 'N'), (38, 40, 92, NULL),
(40, 39, 37, 'N'), (40, 40, 88, NULL), (41, 39, 36, 'N'), (41, 40, 85, NULL),
(42, 39, 34, 'Y'), (42, 40, 70, NULL);

## 월요일 반
INSERT INTO test_results (student_id, test_id, score, retest_required)
VALUES
# 1주차
(43, 5, 39, 'N'), (43, 6, 88, NULL), (45, 5, 38, 'N'), (45, 6, 91, NULL),
(47, 5, 35, 'Y'), (47, 6, 77, NULL), (48, 5, 40, 'N'), (48, 6, 94, NULL),
(49, 5, 37, 'N'), (49, 6, 85, NULL), (50, 5, 36, 'N'), (50, 6, 90, NULL),
# 2주차
(44, 10, 36, 'N'), (44, 11, 88, NULL), (45, 10, 39, 'N'), (45, 11, 92, NULL),
(46, 10, 34, 'Y'), (46, 11, 75, NULL), (47, 10, 37, 'N'), (47, 11, 89, NULL),
(49, 10, 40, 'N'), (49, 11, 94, NULL), (50, 10, 38, 'N'), (50, 11, 87, NULL),
# 3주차
(43, 15, 37, 'N'), (43, 16, 89, NULL), (44, 15, 38, 'N'), (44, 16, 91, NULL),
(46, 15, 34, 'Y'), (46, 16, 74, NULL), (47, 15, 36, 'N'), (47, 16, 85, NULL),
(49, 15, 39, 'N'), (49, 16, 92, NULL), (50, 15, 40, 'N'), (50, 16, 95, NULL),
# 4주차
(43, 20, 38, 'N'), (43, 21, 87, NULL), (45, 20, 39, 'N'), (45, 21, 90, NULL),
(47, 20, 36, 'N'), (47, 21, 88, NULL), (48, 20, 40, 'N'), (48, 21, 94, NULL),
(49, 20, 35, 'Y'), (49, 21, 77, NULL), (50, 20, 37, 'N'), (50, 21, 85, NULL),
# 5주차
(43, 25, 39, 'N'), (43, 26, 89, NULL), (45, 25, 38, 'N'), (45, 26, 91, NULL),
(47, 25, 35, 'Y'), (47, 26, 78, NULL), (48, 25, 40, 'N'), (48, 26, 96, NULL),
(49, 25, 37, 'N'), (49, 26, 86, NULL), (50, 25, 36, 'N'), (50, 26, 84, NULL),
# 6주차
(43, 30, 36, 'N'), (43, 31, 88, NULL), (44, 30, 40, 'N'), (44, 31, 93, NULL),
(45, 30, 38, 'N'), (45, 31, 90, NULL), (47, 30, 37, 'N'), (47, 31, 86, NULL),
(49, 30, 35, 'Y'), (49, 31, 78, NULL), (50, 30, 34, 'Y'), (50, 31, 73, NULL),
# 7주차
(44, 35, 39, 'N'), (44, 36, 91, NULL), (45, 35, 40, 'N'), (45, 36, 95, NULL),
(46, 35, 36, 'N'), (46, 36, 87, NULL), (47, 35, 38, 'N'), (47, 36, 90, NULL),
(49, 35, 37, 'N'), (49, 36, 85, NULL), (50, 35, 34, 'Y'), (50, 36, 72, NULL),
# 8주차
(43, 40, 39, 'N'), (43, 41, 92, NULL), (44, 40, 37, 'N'), (44, 41, 86, NULL),
(45, 40, 40, 'N'), (45, 41, 94, NULL), (46, 40, 36, 'N'), (46, 41, 85, NULL),
(48, 40, 39, 'N'), (48, 41, 90, NULL), (50, 40, 35, 'Y'), (50, 41, 75, NULL);

SELECT * FROM test_results;

