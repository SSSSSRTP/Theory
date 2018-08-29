/*
*	创建了dbSRTP数据库
*	创建了用户信息表、学院信息系索引表、专业或实验室索引表
*	代码规范：
*	1、编码方式utf-8，字符串字段一律使用unicode
*	2、命名采用下划线命名法
*	3、保留字一律使用大写，自定义命名标识符采用小写
*	4、主键与外键不加索引关系
*	5、字段一律限制为 NOT NULL
*	6、数据字典表以_dic结尾，外键字段以_id结尾
*/
<<<<<<< HEAD
CREATE DATABASE dbSRTP CHARACTER SET utf8 COLLATE utf8_general_ci;
=======
CREATE DATABASE dbIBM CHARACTER SET utf8 COLLATE utf8_general_ci;
>>>>>>> 4fe05cd7717287961770d2c51976be79da596fb9

use dbSRTP;

CREATE TABLE IF NOT EXISTS users (
	user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    user_password VARCHAR(16) NOT NULL COMMENT '用户密码',
    user_name VARCHAR(15) NOT NULL COMMENT '用户真实名字',
    user_type_id TINYINT NOT NULL COMMENT '用户类型：0--学生，1--教师，2--辅导员，3--管理员',
    user_college_id VARCHAR(5) NULL COMMENT '外键，用户所在学院', 
    user_major_id VARCHAR(5) NOT NULL COMMENT '外键，用户所在的专业或者实验室'
)COMMENT='用户信息表';

CREATE TABLE IF NOT EXISTS college_dic (
	college_id VARCHAR(5) PRIMARY KEY COMMENT '学院编号',
    college_name VARCHAR(20) NOT NULL COMMENT '学院名称，20字符以内'
)COMMENT='学院信息索引表';

CREATE TABLE IF NOT EXISTS major_dic (
	major_id VARCHAR(5) PRIMARY KEY COMMENT '专业或实验室编号',
<<<<<<< HEAD
    major_name VARCHAR(32) NOT NULL COMMENT '专业或实验室名称，20字符以内'
=======
    college_name VARCHAR(20) NOT NULL COMMENT '专业或实验室名称，20字符以内'
>>>>>>> 4fe05cd7717287961770d2c51976be79da596fb9
)COMMENT='专业（或实验室）信息索引表';

CREATE TABLE IF NOT EXISTS course (
	course_id INT PRIMARY KEY COMMENT '课程代码',
    course_name VARCHAR(32) NOT NULL COMMENT '课程名称，长度为32个字符以内',
    course_credit TINYINT NOT NULL COMMENT '课程学分，范围是1-6',
    course_property_id TINYINT NOT NULL COMMENT '课程性质，1--必修、2--限选、3--选修、4--通识'
)COMMENT='课程信息表';

CREATE TABLE IF NOT EXISTS course_arrangement (
	course_arr_id VARCHAR(5) PRIMARY KEY COMMENT '选课安排编号',
    course_id INT NOT NULL COMMENT '外键，课程代码',
	teacher_id INT NOT NULL COMMENT '外键，任课教师id',
    course_arr_year INT NOT NULL COMMENT '开课学年-学期，格式为：学期0学年，如2017第二学年为201702'
)COMMENT='课程安排信息表，选课时的课程信息，注意与课程信息表区分';

CREATE TABLE IF NOT EXISTS course_choosen (
	course_arr_id VARCHAR(5) NOT NULL COMMENT '学生选择的课程安排编号',
	student_id INT NOT NULL COMMENT '选课的学生学号',
    score DECIMAL(4, 1) NOT NULL DEFAULT 0.0 COMMENT '选择的这门课的成绩',
    PRIMARY KEY(course_arr_id, student_id)
)COMMENT='学生选课信息';
