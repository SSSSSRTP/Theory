/*
*	创建了dbSRTP数据库
*	创建了用户信息表、学院信息系索引表、专业或实验室索引表
*	代码规范：
*	1、编码方式utf-8mb4，字符串字段一律使用unicode
*	2、命名采用下划线命名法
*	3、保留字一律使用大写，自定义命名标识符采用小写
*	4、主键与外键不加索引关系
*	5、字段一律限制为 NOT NULL
*	6、数据字典表以_dic结尾，外键字段以_id结尾
*	7、增加了用户性别，政治面貌，民族，籍贯，职务信息及出生年月
*/
CREATE DATABASE dbSRTP CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use dbSRTP;

CREATE TABLE IF NOT EXISTS users (
	user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    user_password VARCHAR(16) NOT NULL COMMENT '用户密码',
    user_name VARCHAR(15) NOT NULL COMMENT '用户真实名字',
    user_type_id TINYINT NOT NULL COMMENT '用户类型：0--学生，1--教师，2--辅导员，3--管理员',
    user_college_id VARCHAR(40) NULL COMMENT '外键，用户所在学院',
    user_major_id VARCHAR(100) NOT NULL COMMENT '外键，用户所在的专业或者实验室', 
    user_sex TINYINT NOT NULL COMMENT '用户性别：0--男，1--女',
    user_political_status VARCHAR(20) NOT NULL COMMENT '用户政治面貌：团员，预备党员，党员，群众，其他党派人士',
    user_native_place VARCHAR(10) NULL COMMENT '用户籍贯',
    user_nation VARCHAR(15) NULL COMMENT '用户民族',
	user_post VARCHAR(15) NULL COMMENT '用户职务',
	user_birthday DATE NULL COMMENT '用户出生年月'
)COMMENT='用户信息表';

CREATE TABLE IF NOT EXISTS college_dic (
	college_id TINYINT PRIMARY KEY COMMENT '学院编号',
    college_name VARCHAR(40) NOT NULL COMMENT '学院名称，20字符以内'
)COMMENT='学院信息索引表';

CREATE TABLE IF NOT EXISTS major_dic (
	major_id INT PRIMARY KEY COMMENT '专业或实验室编号',
    major_belong TINYINT NOT NULL COMMENT '专业属于的学院;',
    major_name VARCHAR(100) NOT NULL COMMENT '专业或实验室名称，20字符以内'
)COMMENT='专业（或实验室）信息索引表';

CREATE TABLE IF NOT EXISTS course_dic(
	course_id INT PRIMARY KEY COMMENT '课程代码',
    course_name VARCHAR(32) NOT NULL COMMENT '课程名称，长度为32个字符以内',
    course_credit TINYINT NOT NULL COMMENT '课程学分，范围是1-6',
    course_property_id TINYINT NOT NULL COMMENT '课程性质，1--必修、2--限选、3--选修、4--通识'
)COMMENT='课程信息表';

CREATE TABLE IF NOT EXISTS course_arrangement (
	course_arr_id INT PRIMARY KEY COMMENT '选课安排编号',
    course_id INT NOT NULL COMMENT '外键，课程代码',
	teacher_id INT NOT NULL COMMENT '外键，任课教师id',
    course_arr_year INT NOT NULL COMMENT '开课学年-学期，格式为：学期0学年，如2017第二学年为201702'
)COMMENT='课程安排信息表，选课时的课程信息，注意与课程信息表区分';

CREATE TABLE IF NOT EXISTS course_choosen (
	course_arr_id INT NOT NULL COMMENT '学生选择的课程安排编号',
	student_id INT NOT NULL COMMENT '选课的学生学号',
    score DECIMAL(4, 1) NOT NULL DEFAULT 0.0 COMMENT '选择的这门课的成绩',
    PRIMARY KEY(course_arr_id, student_id)
)COMMENT='学生选课信息';

CREATE TABLE IF NOT EXISTS contest_dic(
    user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    cst_id INT NOT NULL COMMENT '竞赛编号',
    cst_name VARCHAR(50) NOT NULL COMMENT '竞赛名称',
    prize_lv VARCHAR(10) NOT NULL COMMENT '获奖等级（金银铜奖，一二三等奖）',
    prize_rank VARCHAR(10) NOT NULL COMMENT '奖项等级（国家，省级等）'
)COMMENT='获奖信息';

CREATE TABLE IF NOT EXISTS library_dic(
	user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    time_in TIMESTAMP NOT NULL COMMENT '进馆时间',
    time_out TIMESTAMP NOT NULL COMMENT '出馆时间'
)COMMENT='图书馆进出信息';

CREATE TABLE IF NOT EXISTS borrow_dic(
	user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    bro_book VARCHAR(60) NOT NULL COMMENT '借阅书目名称',
    bro_time TIMESTAMP NOT NULL COMMENT '借阅时间',
    bro_ol TINYINT NOT NULL COMMENT '是否续借：0--未续借，1--已续借',
    bro_return TINYINT NOT NULL COMMENT '是否归还：0--归还，1--未归还'
)COMMENT='借阅信息';

CREATE TABLE IF NOT EXISTS sport_dic(
	user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    spt_place TINYINT NOT NULL COMMENT '运动地点：0--南区体育场，1--北区体育场，2--校园路夜跑，3--篮球场，4--羽毛球馆，5--网球场，6-游泳馆',
    spt_time  INT NOT NULL COMMENT '运动时间（分钟）',
    spt_star TIMESTAMP NOT NULL COMMENT '运动开始时间'
)COMMENT='运动信息记录';

CREATE TABLE IF NOT EXISTS contest(
    user_id INT PRIMARY KEY COMMENT '用户id：学号、教师工号...',
    cst_id INT NOT NULL COMMENT '竞赛编号',
    cst_tea VARCHAR(5) NOT NULL COMMENT '竞赛指导老师',
    cst_name VARCHAR(50) NOT NULL COMMENT '竞赛名称',
    prize_lv VARCHAR(10) NOT NULL COMMENT '获奖等级（金银铜奖，一二三等奖）',
    prize_rank VARCHAR(10) NOT NULL COMMENT '奖项等级（国家，省级等）',
    prize_time DATE NOT NULL COMMENT '获奖时间',
    prize_first TINYINT NOT NULL COMMENT '竞赛第X参与人：1~5对应第一参与人到第五参与人'
)COMMENT='获奖信息';

CREATE TABLE IF NOT EXISTS library(
	id INT PRIMARY KEY COMMENT '图书馆进出记录编号',
	user_id INT NOT NULL COMMENT '用户id：学号、教师工号...',
    time_in TIMESTAMP NOT NULL COMMENT '进馆时间',
    time_out TIMESTAMP NOT NULL COMMENT '出馆时间'
)COMMENT='图书馆进出信息';

CREATE TABLE IF NOT EXISTS borrow(
	id INT PRIMARY KEY COMMENT '借书记录编号',
    user_id INT NOT NULL COMMENT  '用户id：学号、教师工号...',
    bro_book VARCHAR(60) NOT NULL COMMENT '借阅书目名称',
    bro_time TIMESTAMP NOT NULL COMMENT '借阅时间',
    bro_ol TINYINT NOT NULL COMMENT '是否续借：0--未续借，1--已续借',
    bro_return TINYINT NOT NULL COMMENT '是否归还：0--归还，1--未归还'
)COMMENT='借阅信息';

CREATE TABLE IF NOT EXISTS sport(
	id INT PRIMARY KEY COMMENT '运动记录编号',
	user_id INT NOT NULL COMMENT '用户id：学号、教师工号...',
    spt_place TINYINT NOT NULL COMMENT '运动地点：0--南区体育场，1--北区体育场，2--校园路夜跑，3--篮球场，4--羽毛球馆，5--网球场，6-游泳馆',
    spt_star TIMESTAMP NOT NULL COMMENT '运动开始时间',
    spt_end TIMESTAMP NOT NULL COMMENT '运动结束时间'
)COMMENT='运动信息记录';

CREATE TABLE IF NOT EXISTS lab(
	id INT PRIMARY KEY COMMENT '实验室项目编号',
    lab_name VARCHAR(20) NOT NULL COMMENT '项目名称',
    lab_lv VARCHAR(6) NOT NULL COMMENT '项目等级',
    lab_tea VARCHAR(5) NOT NULL COMMENT '指导老师',
    lab_star DATE NOT NULL COMMENT '项目开始时间',
    lab_end DATE NOT NULL COMMENT '项目结束时间',
    lab_first TINYINT NOT NULL COMMENT '项目第X参与人：1~5对应第一参与人到第五参与人'
)COMMENT='实验室项目信息';