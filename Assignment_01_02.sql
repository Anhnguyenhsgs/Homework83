DROP DATABASE IF EXISTS Assignment_01;
CREATE DATABASE Assignment_01;
USE assignment_01;

-- Create department table
CREATE TABLE department (
	department_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50) NOT NULL UNIQUE 
);

INSERT INTO department(department_id, department_name)
VALUES                (1            ,"Ke toan" ),
                      (2            ,"Hanh chinh" ),
                      (3            ,"Marketing" ),
                      (4            ,"Phong phat trien 1" ),
		      (5            ,"Phong phat trien 2" );
                      
-- Create position table
CREATE TABLE position (
	position_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM ('dev','test','scrum master','pm','BA') NOT NULL UNIQUE
);
INSERT INTO position (position_id,position_name)
VALUES               (1          ,"dev"),
		     (2          ,"test"),
		     (3          ,"scrum master"),
                     (4          ,"pm"),
                     (5          ,"BA");

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
INSERT INTO account  (account_id, email, username, full_name, department_id,position_id)
VALUES               (1,"nva@gmail.com", "nvA", "nguyen van A", 1, 1),
		     (2,"nvb@gmail.com", "nvB", "nguyen van B", 2, 2),
		     (3,"nvc@gmail.com", "nvC", "nguyen van C", 3, 3),
                     (4,"nvd@gmail.com", "nvD", "nguyen van D", 4, 4),
                     (5,"nve@gmail.com", "nvE", "nguyen van E", 5, 5);

-- Create group table
CREATE TABlE `group` (
	group_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
	group_name varchar(255) NOT NULL UNIQUE,
    creator_id TINYINT UNSIGNED,
    created_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    FOREIGN KEY (creator_id) REFERENCES account (account_id)
);
INSERT INTO `group`  (group_id, group_name, creator_id)
VALUES               (1       ,"Group1", 1),
		     (2       ,"Group2", 2),
		     (3       ,"Group3", 3),
                     (4       ,"Group4", 4),
                     (5       ,"Group5", 5);
                     
-- Create group_account table
CREATE TABlE group_account (
	group_id TINYINT UNSIGNED,
    account_id TINYINT UNSIGNED,
    joined_date DATE NOT NULL DEFAULT(CURRENT_DATE), 
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id),
    FOREIGN KEY (account_id) REFERENCES account (account_id)
);
INSERT INTO group_account  (group_id, account_id, joined_date)
VALUES                     (1       ,1, "2023-08-12" ),
		           (2       ,2, "2023-08-13" ),
			   (3       ,3, "2023-08-14" ),
                           (4       ,4, "2023-08-15" ),
                           (5       ,5, "2023-08-16" );
                           
-- Create Type question table
CREATE TABlE type_question (
	type_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    type_name ENUM('essay','multiple choice','opinon','caculation','draw') NOT NULL UNIQUE
);

INSERT INTO type_question  (type_id, type_name)
VALUES                     (1       ,"essay"),
		           (2       ,"multiple choice"),
			   (3       ,"opinon"),
                           (4       ,"caculation"),
                           (5       ,"draw");
                           
-- Create category question table
CREATE TABlE category_question (
	category_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) UNIQUE
);

INSERT INTO category_question  (category_id, category_name)
VALUES                     (1       ,"Easy"),
			   (2       ,"Lower medium"),
			   (3       ,"Medium"),
                           (4       ,"Higher medium"),
                           (5       ,"Difficult");

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
INSERT INTO question  (question_id, content, category_id, type_id, creator_id )
VALUES                (1       ,"content1", 1, 1, 1),
		      (2       ,"content2", 2, 2, 2),
                      (3       ,"content3", 3, 3, 3),
                      (4       ,"content4", 4, 4, 4),
                      (5       ,"content5", 5, 5, 5);

-- Create answer table
CREATE TABlE answer (
	answer_id TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(255),
    question_id TINYINT UNSIGNED,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (question_id) REFERENCES question (question_id)
);

INSERT INTO answer  (answer_id, content, question_id, is_correct )
VALUES                (1       ,"content1", 1, TRUE ),
		      (2       ,"content2", 2, FALSE),
                      (3       ,"content3", 3, TRUE),
                      (4       ,"content4", 4, FALSE),
                      (5       ,"content5", 5, TRUE);

-- Create exam table
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
INSERT INTO exam  (exam_id, code, title, category_id, duration, creator_id )
VALUES            (1       ,"CODE1", "exam1", 1, 15, 1 ),
                  (2       ,"CODE2", "exam2", 2, 30, 2 ),
                  (3       ,"CODE3", "exam3", 3, 45, 3 ),
                  (4       ,"CODE4", "exam4", 4, 60, 4 ),
                  (5       ,"CODE5", "exam5", 5, 90, 5 );

-- Create exam question table
CREATE TABlE exam_question (
	exam_id TINYINT UNSIGNED ,
    question_id TINYINT UNSIGNED,
    PRIMARY KEY (exam_id, question_id),
    FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
	FOREIGN KEY (question_id) REFERENCES question (question_id)
);
INSERT INTO exam_question(exam_id, question_id)
VALUES                (1            ,1 ),
                      (2            ,2 ),
                      (3            ,3),
                      (4            ,4),
		      (5            ,5);
