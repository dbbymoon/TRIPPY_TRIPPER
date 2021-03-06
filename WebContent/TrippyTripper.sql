-----멤버-----
CREATE TABLE TMEMBER (
   MEMBERID VARCHAR2(20) PRIMARY KEY,
   MEMBERPASS VARCHAR2(20) NOT NULL,
   MEMBERNAME VARCHAR2(20) NOT NULL,
   MEMBERPHONENUM VARCHAR2(20),
   MEMBEREMAIL VARCHAR2(20) NOT NULL,
   MEMBERGENDER VARCHAR2(20) ,
   MEMBERBIRTH DATE DEFAULT SYSDATE,
   MEMBERPROFILE VARCHAR2(200) DEFAULT '../profileImg/basic_profile.png',
   MEMBERINTRO VARCHAR2(200) DEFAULT '',
   MEMBERSECRET VARCHAR2(20)
);

-----여행 일정-----
CREATE TABLE ITINERARY (
ITINERARYSEQ NUMBER(20) PRIMARY KEY,
MEMBERID VARCHAR2(20) NOT NULL,
TOURNAME VARCHAR2(50) NOT NULL,
DEPARTUREDATE DATE NOT NULL,
ENDDATE DATE NOT NULL,
TOURDATE DATE NOT NULL,
TOURSPOT VARCHAR2(100),
SPOTLINK VARCHAR2(300),
TOURMEMO VARCHAR2(200),
TRANSPORTATION VARCHAR2(100),
DEPARTURE VARCHAR2(200),
DESTINATION VARCHAR2(200),
DURATION VARCHAR2(100),
DISTANCE VARCHAR2(100),
ITINERARYTYPE VARCHAR2(20) NOT NULL,
FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

-----여행기록----
CREATE TABLE TRIPRECORD(
   RECORDSEQ NUMBER(20) PRIMARY KEY,
   MEMBERID VARCHAR2(20) NOT NULL,
   RECORDCONTENT VARCHAR2(500) NOT NULL,
   RECORDSPOT VARCHAR2(100) NOT NULL,
   RECORDSECRET VARCHAR2(20) NOT NULL,
   RECORDDATE DATE DEFAULT SYSDATE,
   READCOUNT NUMBER(20) DEFAULT 0
);

-----동행-----
CREATE TABLE COMPANION (
   COMPANIONSEQ NUMBER(20) PRIMARY KEY,
   MEMBERID VARCHAR2(20) NOT NULL,
   DEPARTURE VARCHAR2(100),
   DESTINATION VARCHAR2(100) NOT NULL,
   DETAILSPOT VARCHAR2(100) NOT NULL,
   VEHICLES VARCHAR2(20) NOT NULL,
   COMPANIONMEMO VARCHAR2(1000) NOT NULL,
   TOURDATE DATE DEFAULT SYSDATE,
   COMPANIONNUM NUMBER(20) NOT NULL,
   COMPANIONGENDER VARCHAR2(20) NOT NULL,
   COMPANIONSECRET VARCHAR2(20) NOT NULL,
   MEMBERPROFILE VARCHAR(200) NOT NULL,
   COMPANIONDETERMINNUM NUMBER(20) NOT NULL,
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

-----매칭-----
CREATE TABLE MATCHING (
   COMPANIONSEQ NUMBER(20),
   MEMBERID VARCHAR2(20),
   MATCHINGTYPE VARCHAR2(20) DEFAULT 1,
   CONSTRAINT MATCHING_PK PRIMARY KEY(COMPANIONSEQ,MEMBERID,MATCHINGTYPE),
   FOREIGN KEY(COMPANIONSEQ) REFERENCES COMPANION(COMPANIONSEQ),
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);


-----다이어리 댓글-----
TREPLY_SEQ는 전체 댓글을 위한 sequence
REPLYNUM은 대댓글을 제외한 댓글의 sequence

CREATE TABLE TREPLY (
   TREPLYSEQ NUMBER(20) PRIMARY KEY,
   REPLYNUM NUMBER(20),
   DEPTH NUMBER(20),
   RECORDSEQ NUMBER(20) NOT NULL,
   MEMBERID VARCHAR2(20) NOT NULL,
   REPLYDATE DATE DEFAULT SYSDATE,
   REPLYCONTENT VARCHAR2(500) NOT NULL,
   MEMBERPROFILE VARCHAR2(200),
   FOREIGN KEY(RECORDSEQ) REFERENCES TRIPRECORD(RECORDSEQ),
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

-----동행 댓글-----
CREPLY_SEQ는 전체 댓글을 위한 sequence
CREPLYNUM은 대댓글을 제외한 댓글의 sequence
SECRET 비밀댓글 여부

CREATE TABLE CREPLY (
   CREPLYSEQ NUMBER(20) PRIMARY KEY,
   CREPLYNUM NUMBER(20),
   DEPTH NUMBER(20),
   COMPANIONSEQ NUMBER(20) NOT NULL,
   MEMBERID VARCHAR2(20) NOT NULL,
   REPLYCONTENT VARCHAR2(500) NOT NULL,
   MEMBERPROFILE VARCHAR2(200),
   SECRET NUMBER(3) NOT NULL,
   FOREIGN KEY(COMPANIONSEQ) REFERENCES COMPANION(COMPANIONSEQ),
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);


-----사진-----
CREATE TABLE ATTACHFILE (
   FILENUM NUMBER(20) PRIMARY KEY,
   RECORDSEQ NUMBER(20) NOT NULL,
   FILENAME VARCHAR2(200) NOT NULL,
   FILEDATE DATE DEFAULT SYSDATE,
   FOREIGN KEY(RECORDSEQ) REFERENCES TRIPRECORD(RECORDSEQ)
);

==================================================
--여행 일정 게시판 SEQ--
CREATE SEQUENCE ITINERARY_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
--여행 기록 게시판 SEQ--
CREATE SEQUENCE RECORD_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
--동행 게시판 SEQ--
CREATE SEQUENCE COMPANION_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;

--다이어리 댓글 SEQ1--
CREATE SEQUENCE TREPLY_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;

--다이어리 댓글 SEQ2--
CREATE SEQUENCE REPLYNUM
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
--동행 댓글 SEQ1--
CREATE SEQUENCE CREPLY_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;

--동행 댓글 SEQ2--
CREATE SEQUENCE CREPLYNUM
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
   
--사진 게시판 SEQ--
CREATE SEQUENCE ATTACHFILE_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;   
