CREATE TABLE TMEMBER (
   MEMBERID VARCHAR2(20) PRIMARY KEY,
   MEMBERPASS VARCHAR2(20) NOT NULL,
   MEMBERNAME VARCHAR2(20) NOT NULL,
   MEMBERNICK VARCHAR2(20) NOT NULL,
   MEMBERPHONENUM VARCHAR2(20) NOT NULL,
   MEMBEREMAIL VARCHAR2(20) NOT NULL,
   MEMBERGENDER VARCHAR2(20) NOT NULL,
   MEMBERBIRTH DATE NOT NULL,
   MEMBERPROFILE VARCHAR2(50) DEFAULT '../profileImg/basic_profile.png',
   MEMBERINTRO VARCHAR2(200) DEFAULT '',
   MEMBERSECRET VARCHAR2(20) NOT NULL   
);

CREATE TABLE ITINERARY (
   ITINERARYSEQ NUMBER(20) PRIMARY KEY,
   MEMBERID VARCHAR2(20) NOT NULL,
   TOURDATE DATE NOT NULL,
   TOURSPOT VARCHAR2(100) NOT NULL,
   TOURMEMO VARCHAR2(200) NOT NULL,
   VEHICLES VARCHAR2(100) NOT NULL,
   DEPARTURETIME VARCHAR2(100) NOT NULL,
   ARRIVALTIME VARCHAR2(100) NOT NULL,
   ITINERARYTYPE VARCHAR2(20) NOT NULL,
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

CREATE TABLE TRIPRECORD (
   RECORDSEQ NUMBER(20) PRIMARY KEY,
   MEMBERID VARCHAR2(20) NOT NULL,
   RECORDTITLE VARCHAR2(100) NOT NULL,
   RECORDCONTENT VARCHAR2(500) NOT NULL,
   RECORDSPOT VARCHAR2(100) NOT NULL,
   RECORDSECRET VARCHAR2(20) NOT NULL,
   RECORDDATE DATE DEFAULT SYSDATE,
   READCOUNT NUMBER(20) DEFAULT 0,
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

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
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

CREATE TABLE MATCHING (
   COMPANIONSEQ NUMBER(20) PRIMARY KEY,
   MEMBERID VARCHAR2(20) NOT NULL,
   MATCHINGTYPE VARCHAR2(20) NOT NULL,
   FOREIGN KEY(COMPANIONSEQ) REFERENCES COMPANION(COMPANIONSEQ),
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

CREATE TABLE SCRAP (
   RECORDSEQ NUMBER(20),
   MEMBERID VARCHAR2(20),
   CONSTRAINT SCRAP_PK PRIMARY KEY(RECORDSEQ,MEMBERID),
   FOREIGN KEY(RECORDSEQ) REFERENCES TRIPRECORD(RECORDSEQ),
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

CREATE TABLE TREPLY (
   REPLYNUM NUMBER(20),
   DEPTH NUMBER(20),
   RECORDSEQ NUMBER(20) NOT NULL,
   MEMBERID VARCHAR2(20) NOT NULL,
   REPLYCONTENT VARCHAR2(500) NOT NULL,
   REPLYDATE DATE DEFAULT SYSDATE,
   REPLYUPDATEDATE DATE DEFAULT SYSDATE,
   CONSTRAINT TREPLY_PK PRIMARY KEY(REPLYNUM,DEPTH),
   FOREIGN KEY(RECORDSEQ) REFERENCES TRIPRECORD(RECORDSEQ),
   FOREIGN KEY(MEMBERID) REFERENCES TMEMBER(MEMBERID)
);

CREATE TABLE ATTACHFILE (
   FILENUM NUMBER(20) PRIMARY KEY,
   RECORDSEQ NUMBER(20) NOT NULL,
   FILENAME VARCHAR2(100) NOT NULL,
   FILEDATE DATE DEFAULT SYSDATE,
   FOREIGN KEY(RECORDSEQ) REFERENCES TRIPRECORD(RECORDSEQ)
);


==================================================

CREATE SEQUENCE ITINERARY_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
CREATE SEQUENCE RECORD_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
CREATE SEQUENCE COMPANION_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
CREATE SEQUENCE TREPLY_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;
   
CREATE SEQUENCE ATTACHFILE_SEQ
   START WITH 1
   INCREMENT BY 1
   MAXVALUE 100000
   MINVALUE 1
   CYCLE;   