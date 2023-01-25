alter session set "_oracle_script"  = true; -- c## 접두어 없이 계정 생성가능하도록 설정

create user obtg
identified by obtg
default tablespace users;

alter user obtg quota  unlimited on users;

grant connect, resource to obtg;


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

select * from member;

CREATE TABLE Member (
	member_id	varchar2(50),
	style	varchar2(20)		NOT NULL,
	name	varchar2(200)		NULL,
	password	varchar2(50)		not NULL,
	email	varchar2(200)		not NULL,
	phone	varchar2(20)		not NULL,
	birthday	date		NULL,
	enroll_date	date		default sysdate,
	member_role	char(1)		default 'U' not null,
	nickname	varchar2(50)		NULL,
	gender	char(5)		NULL,
	introduce	varchar2(500)		NULL,
	original	varchar2(100),
	renamed	varchar2(100),
    constraint pk_member_id primary key(member_id),
    constraint ck_member_role check(member_role in ('U', 'A')),
    constraint ck_member_gender check(gender in ('M', 'F')),
    constraint uq_member_email unique(email),
--    constraint fk_fashionstyle FOREIGN KEY (style) REFERENCES fashionstyle (style_no) 이 제약조건안씀(by혜진.0118)
-- ALTER TABLE member  ADD constraint fk_fashionstyle FOREIGN KEY (style) REFERENCES fashionstyle (style);  이 제약조건으로 추가(by혜진.0118)

insert into Member (member_id, style, name, password, email, phone, birthday, enroll_date, member_role, nickname, gender, introduce, original, renamed)
values ('incheol', '


);
ALTER TABLE Member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	member_id,
	style
);

ALTER TABLE Member ADD constraint uq_nickname unique(nickname);

-------------------------------------------------
-------------------------------------------------
-------------------------------------------------
-------------------------------------------------
--CREATE TABLE fashionstyle (
--	style_no	varchar2(10)		NOT NULL,
--	style	varchar2(20)		NULL,
--   CONSTRAINT PK_STYLE_STYLE PRIMARY KEY (style_no)
--);
-- ALTER TABLE fashionstyle  ADD constraint uq_fashionstyle  unique(style); <--unique로 바꿈 (by혜진.0118) / 밑에 정보 넣은  내역 추가 
--insert into fashionstyle values ('1','러블리'); insert into fashionstyle values ('2','댄디');insert into fashionstyle values ('3','포멀');insert into fashionstyle values ('4','스트릿');
--insert into fashionstyle values ('5','걸리쉬'); --insert into fashionstyle values ('6','레트로');insert into fashionstyle values ('7','로맨틱');
--insert into fashionstyle values ('8','시크');insert into fashionstyle values ('9','아메카지');





CREATE TABLE OOTD_board (
	OOTD_no	number,
	OOTD_writer	varchar2(50)		NOT NULL,
	style_no	varchar2(10)		NOT NULL,
	OOTD_title	varchar2(50)		NOT NULL,
	OOTD_contents	varchar2(4000)	NOT NULL,
	OOTD_read_count	number		default 0,
	OOTD_reg_date	date		default sysdate,
	OOTD_top	varchar2(50)		NULL,
	OOTD_bottom	varchar2(50)		NULL,
	OOTD_shoes	varchar2(50)		NULL,
	OOTD_etc	varchar2(50)		NULL,
    CONSTRAINT PK_OOTD_BOARD PRIMARY KEY (OOTD_no),
    CONSTRAINT FK_OOTD_board_writer FOREIGN KEY (ootd_writer) REFERENCES Member (member_id) on delete set null,
    CONSTRAINT FK_fashionstyle_TO_OOTD_board_1 FOREIGN KEY (style_no) REFERENCES fashionstyle (style_no) on delete set null
);

create sequence seq_board_no;

select * from OOTD_board;

CREATE TABLE OOTD_attachment (
	attach_no	number,
	board_no	number		NOT NULL,
	attach_style_no	varchar2(10)		NOT NULL,
	original_filename	varchar2(255)		NOT NULL, -- 프로필용
	renamed_filename	varchar2(255)		NOT NULL, -- 프로필용
	reg_date	Date	default sysdate,
    CONSTRAINT PK_OOTD_ATTACHMENT PRIMARY KEY (attach_no),
    CONSTRAINT FK_OOTD_board_OOTD_attachment_1 FOREIGN KEY (board_no) REFERENCES OOTD_board (OOTD_no) on delete cascade
);

--CONSTRAINT FK_OOTD_board_OOTD_attachment_2 FOREIGN KEY (attach_style_no) REFERENCES OOTD_board (style_no) on delete set null

ALTER TABLE OOTD_attachment ADD CONSTRAINT FK_OOTD_board_OOTD_attachment_2 FOREIGN KEY (attach_style_no) REFERENCES fashionstyle (style_no);

create sequence seq_ootd_attachment_no;


CREATE TABLE SHARE_board (
	SHARE_no	number,
	member_id	varchar2(50)		NOT NULL,
	SAHRE_TITLE	varchar2(50)		NOT NULL,
	SAHRE_CONTENT	varchar2(4000)	NOT NULL,
	SAHRE_READ_COUNT	number	default 0,
	SAHRE_REG_DATE	Date		default sysdate,
	SHARE_BUY_DATE	Date		NULL,
	SHARE_PRODUCT_STATUS	varchar2(50)		NULL,
	SHARE_CATEGORY	varchar2(50)		NULL,
	SHARE_STATE	varchar2(50)		NULL,
    style	varchar2(20)		NOT NULL,
    CONSTRAINT PK_SHARE_BOARD PRIMARY KEY (SHARE_no),
    CONSTRAINT FK_Member_TO_SHARE_board_1 FOREIGN KEY (member_id) REFERENCES Member (member_id) on delete set null,
    CONSTRAINT FK_fashionstyle_TO_SHARE_board_1 FOREIGN KEY (style) REFERENCES fashionstyle (style_no) on delete set null
);


ALTER TABLE SHARE_board ADD constraint uq_share_member_id unique(member_id);

create sequence seq_SHARE_board_no;








CREATE TABLE SHARE_attachment (
	attach_no	number		NOT NULL,
	board_no	number		NOT NULL,
	original_filename	varchar2(255)		NOT NULL,
	renamed_filename	varchar2(255)		NOT NULL,
	reg_date	Date		default sysdate,
    CONSTRAINT PK_SHARE_ATTACHMENT PRIMARY KEY (attach_no),
    CONSTRAINT FK_SHARE_board_SHARE_attachment_1 FOREIGN KEY (board_no) REFERENCES SHARE_board (SHARE_no) on delete cascade
);

alter table SHARE_attachment
rename column rename_filename to renamed_filename;

create sequence seq_SHARE_attachment_no;





CREATE TABLE OOTD_board_comment (
	cmt_no	number,
	board_no	number,
	member_id	varchar2(50)		NOT NULL,
	cmt_level	number		default 1,
	cmt_content	varchar2(2000)		NULL,
	cmt_reg_date	Date		default sysdate,
	comment_ref	number,
    CONSTRAINT PK_OOTD_BOARD_COMMENT PRIMARY KEY (cmt_no),
    CONSTRAINT FK_OOTD_board_TO_OOTD_board_comment_1 FOREIGN KEY (board_no) REFERENCES OOTD_board (OOTD_no),
    CONSTRAINT FK_Member_TO_OOTD_board_comment_1 FOREIGN KEY (member_id) REFERENCES Member (member_id),
    CONSTRAINT FK_OOTD_BORAD_comment_ref foreign key(comment_ref) references OOTD_board_comment(cmt_no)
);

create sequence seq_OOTD_board_comment_no;



-- FAQ 나중에 ....
-------------------------------------------------------
-------------------------------------------------------
--CREATE TABLE FAQ (
--	FAQ_no	number		NOT NULL,
--	member_id	varchar2(50)		NOT NULL,
--	FAQ_title	varchar2(50)		NULL,
--	FAQ_content	varchar2(50)		NULL,
--    CONSTRAINT PK_FAQ PRIMARY KEY (FAQ_no),
--    CONSTRAINT FK_Member_TO_FAQ_1 FOREIGN KEY (member_id) REFERENCES Member (member_id)
--);
-------------------------------------------------------
-------------------------------------------------------


CREATE TABLE Report (
    report_no    number        NOT NULL,
    reported_userId    varchar2(50)        NOT NULL,
    board_no    number        NOT NULL,
    reg_date    date   default sysdate,
    report_status    char(1) default 'x',
    report_reason   char(5)     NOT NULL,
    CONSTRAINT PK_REPORT PRIMARY KEY (report_no),
    CONSTRAINT FK_Member_TO_Report_1 FOREIGN KEY (reported_userId) REFERENCES Member (member_id),
    CONSTRAINT FK_OOTD_board_TO_Report_1 FOREIGN KEY (board_no) REFERENCES OOTD_board (OOTD_no),
    CONSTRAINT CK_report_reason check (report_reason in ('1', '2', '3', '4', '5' )),
    CONSTRAINT CK_report_status check (report_status in ('o', 'x'))
);

create sequence seq_report_no;







CREATE TABLE SHARE_Likes (
	LIKE_no	number,
	board_no	number		NOT NULL,
	member_id	varchar2(50)		NOT NULL,
    CONSTRAINT PK_SHARE_LIKES PRIMARY KEY (LIKE_no),
    CONSTRAINT FK_SHARE_board_TO_SHARE_Likes_1 FOREIGN KEY (board_no) REFERENCES SHARE_board (SHARE_no),
    CONSTRAINT FK_Member_TO_SHARE_Likes_1 FOREIGN KEY (member_id) REFERENCES Member (member_id)
);

create sequence seq_share_likes_no;


CREATE TABLE OOTD_Likes (
	LIKE_no	number,
	board_no	number		NOT NULL,
	member_id	varchar2(50)		NOT NULL,
    CONSTRAINT PK_OOTD_LIKES PRIMARY KEY (LIKE_no),
    CONSTRAINT FK_OOTD_board_TO_OOTD_Likes_1 FOREIGN KEY (board_no)REFERENCES OOTD_board (OOTD_no),
    CONSTRAINT FK_Member_TO_OOTD_Likes_1 FOREIGN KEY (member_id)REFERENCES Member (member_id)
);

create sequence seq_ootd_likes_no;



CREATE TABLE ootd_find (
	no	number,
	style_no	varchar2(10)		NOT NULL,
	OOTD_no	number		NOT NULL,
    CONSTRAINT PK_OOTD_FIND PRIMARY KEY (no),
    CONSTRAINT FK_fashionstyle_TO_ootd_find_1 FOREIGN KEY (style_no)REFERENCES fashionstyle (style_no),
    CONSTRAINT FK_OOTD_board_TO_ootd_find_1 FOREIGN KEY (OOTD_no)REFERENCES OOTD_board (OOTD_no)
);

create sequence seq_ootd_find_no;


CREATE TABLE SHARE_find (
	no	number,
	style_no	varchar2(10)		NOT NULL,
	share_no	number		NOT NULL,
    CONSTRAINT PK_SHARE_FIND PRIMARY KEY (no),
    CONSTRAINT FK_fashionstyle_TO_SHARE_find_1 FOREIGN KEY (style_no) REFERENCES fashionstyle (style_no),
    CONSTRAINT FK_SHARE_board_TO_SHARE_find_1 FOREIGN KEY (share_no) REFERENCES SHARE_board (SHARE_no)
);

create sequence seq_share_find_no;



CREATE TABLE chat_log (
	no	number,
	chatroom_id	number		NOT NULL,
	message	varchar2(500)		NULL,
	datetime	Date	default sysdate,
    CONSTRAINT PK_CHAT_LOG PRIMARY KEY (no),
    CONSTRAINT FK_chatroom_TO_chat_log_1 FOREIGN KEY (chatroom_id) REFERENCES chatroom (chatroom_id)
);

create sequence seq_chat_log_no;





CREATE TABLE chatroom (
	chatroom_id	number		NOT NULL,
    board_id    varchar2(50) NOT NULL,
	member_id	varchar2(50)		NOT NULL,
    CONSTRAINT PK_CHATROOM PRIMARY KEY (chatroom_id),
    CONSTRAINT FK_SHARE_board_TO_chatroom_1 FOREIGN KEY (board_id) REFERENCES SHARE_board (member_id),
    CONSTRAINT FK_Member_TO_chatroom_1 FOREIGN KEY (member_id) REFERENCES Member (member_id)
);

create sequence seq_chatroom_no;


create table obtg_column (
    no number,
    writer varchar2(20),
    title varchar2(50) not null,
    subtitle varchar2(50) not null,
    content varchar2(4000) not null,
    original_filename varchar2(100),
    renamed_filename varchar2(100),
    read_count number default 0,
    reg_date date default sysdate,
    constraint pk_column_no primary key(no),
    constraint fk_column_writer foreign key(writer) references member(member_id)
);
create sequence seq_column_no;
