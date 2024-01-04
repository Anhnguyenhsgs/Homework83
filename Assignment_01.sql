DROP DATABASE IF EXISTS assignment_01;
CREATE DATABASE assignment_01;
USE assignment_01;

-- Create department table
CREATE TABLE department (
	department_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE 
);

-- Create position table
CREATE TABLE position (
	position_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM ('dev','test','scrum master','pm') NOT NULL UNIQUE
);

-- Create account table
CREATE TABlE account(
	account_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	email varchar(255) NOT NULL UNIQUE , 
    username varchar(255) NOT NULL UNIQUE,
    full_name varchar(255) NOT NULL,
    department_id TINYINT UNSIGNED,
    position_id TINYINT UNSIGNED,
    created_date DATE DEFAULT(CURRENT_DATE),
    FOREIGN KEY (position_id) REFERENCES position (position_id),
    FOREIGN KEY (department_id) REFERENCES department(department_id)
);

-- Create group table
CREATE TABlE `group` (
	group_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	group_name varchar(255) NOT NULL UNIQUE,
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

-- Create group_account table
CREATE TABlE group_account (
	group_id TINYINT UNSIGNED,
    account_id TINYINT UNSIGNED,
    joined_date DATE NOT NULL DEFAULT(CURRENT_DATE), 
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);

-- Create Type question table
CREATE TABlE type_question (
	type_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('essay','multiple choice') NOT NULL UNIQUE
);

-- Create category question table
CREATE TABlE category_question (
	category_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE
);

-- Create question table
CREATE TABlE question (
	question_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255)NOT NULL, 
    category_id TINYINT UNSIGNED,
    type_id TINYINT UNSIGNED,
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    FOREIGN KEY (category_id) REFERENCES category_question (category_id),
    FOREIGN KEY (type_id) REFERENCES type_question (type_id),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

-- Create answer table
CREATE TABlE answer (
	answer_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255),
    question_id TINYINT UNSIGNED,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);

-- Create answer table
CREATE TABlE exam (
	exam_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    code CHAR(10) NOT NULL UNIQUE,
    title VARCHAR(50) NOT NULL,
    category_id TINYINT UNSIGNED,
    duration TINYINT UNSIGNED NOT NULL,
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT(CURRENT_DATE),
	CHECK (duration >=15),
    FOREIGN KEY (category_id) REFERENCES category_question (category_id),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

-- Create exam question table
CREATE TABlE exam_question (
	exam_id TINYINT UNSIGNED ,
    question_id TINYINT UNSIGNED,
    PRIMARY KEY (exam_id, question_id),
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
	FOREIGN KEY (question_id) REFERENCES question (question_id)
);








