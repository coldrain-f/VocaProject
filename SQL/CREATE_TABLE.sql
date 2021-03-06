-- TBL_BOOK Table Create SQL
CREATE TABLE TBL_BOOK
(
    BOOK_ID       NUMBER(10, 0)    NOT NULL, 
    BOOK_NAME     VARCHAR2(500)    NOT NULL, 
    REGDATE       DATE             DEFAULT SYSDATE NOT NULL, 
    UPDATEDATE    DATE             DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_TBL_BOOK PRIMARY KEY (BOOK_ID)
)
/

CREATE SEQUENCE TBL_BOOK_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER TBL_BOOK_AI_TRG
BEFORE INSERT ON TBL_BOOK 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT TBL_BOOK_SEQ.NEXTVAL
    INTO :NEW.BOOK_ID
    FROM DUAL;
END;
/

--DROP TRIGGER TBL_BOOK_AI_TRG;
/

--DROP SEQUENCE TBL_BOOK_SEQ;
/

CREATE UNIQUE INDEX UQ_TBL_BOOK_1
    ON TBL_BOOK(BOOK_NAME)
/


-- TBL_CATEGORY Table Create SQL
CREATE TABLE TBL_CATEGORY
(
    CATEGORY_ID      NUMBER(10, 0)    NOT NULL, 
    CATEGORY_NAME    VARCHAR2(500)    NOT NULL, 
    BOOK_ID          NUMBER(10, 0)    NOT NULL, 
    REGDATE          DATE             DEFAULT SYSDATE NOT NULL, 
    UPDATEDATE       DATE             DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_TBL_CATEGORY PRIMARY KEY (CATEGORY_ID)
)
/

CREATE SEQUENCE TBL_CATEGORY_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER TBL_CATEGORY_AI_TRG
BEFORE INSERT ON TBL_CATEGORY 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT TBL_CATEGORY_SEQ.NEXTVAL
    INTO :NEW.CATEGORY_ID
    FROM DUAL;
END;
/

--DROP TRIGGER TBL_CATEGORY_AI_TRG;
/

--DROP SEQUENCE TBL_CATEGORY_SEQ;
/

CREATE UNIQUE INDEX UQ_TBL_CATEGORY_1
    ON TBL_CATEGORY(CATEGORY_NAME, BOOK_ID)
/

ALTER TABLE TBL_CATEGORY
    ADD CONSTRAINT FK_TBL_CATEGORY_BOOK_ID_TBL_BO FOREIGN KEY (BOOK_ID)
        REFERENCES TBL_BOOK (BOOK_ID) ON DELETE CASCADE
/


-- TBL_WORD Table Create SQL
CREATE TABLE TBL_WORD
(
    WORD_ID         NUMBER(10, 0)    NOT NULL, 
    WORD_NAME       VARCHAR2(500)    NULL, 
    WORD_MEANING    VARCHAR2(500)    NULL, 
    CATEGORY_ID     NUMBER(10, 0)    NOT NULL, 
    REGDATE         DATE             DEFAULT SYSDATE NOT NULL, 
    UPDATEDATE      DATE             DEFAULT SYSDATE NOT NULL, 
    CONSTRAINT PK_TBL_WORD PRIMARY KEY (WORD_ID)
)
/

CREATE SEQUENCE TBL_WORD_SEQ
START WITH 1
INCREMENT BY 1;
/

CREATE OR REPLACE TRIGGER TBL_WORD_AI_TRG
BEFORE INSERT ON TBL_WORD 
REFERENCING NEW AS NEW FOR EACH ROW 
BEGIN 
    SELECT TBL_WORD_SEQ.NEXTVAL
    INTO :NEW.WORD_ID
    FROM DUAL;
END;
/

--DROP TRIGGER TBL_WORD_AI_TRG;
/

--DROP SEQUENCE TBL_WORD_SEQ;
/

CREATE UNIQUE INDEX UQ_TBL_WORD_1
    ON TBL_WORD(WORD_NAME, WORD_MEANING)
/

ALTER TABLE TBL_WORD
    ADD CONSTRAINT FK_TBL_WORD_CATEGORY_ID_TBL_CA FOREIGN KEY (CATEGORY_ID)
        REFERENCES TBL_CATEGORY (CATEGORY_ID) ON DELETE CASCADE
/