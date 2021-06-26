## 2021-06-27(일) 작업내용

#### 데이터베이스 ERD

![DB_ERD](C:\Users\user\Desktop\(최신)단어 학습 프로젝트\TyporaImages\DB_ERD.png)



TBL_BOOK: 책을 저장하는 테이블

TBL_CATEGORY: 책의 카테고리를 저장하는 테이블

TBL_WORD: 카테고리의 단어를 저장하는 테이블



#### 데이터베이스 테이블 생성

```SQL
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
```



1. 책 컬럼을 삭제하면 자식인 카테고리 컬럼들도 모두 연쇄 삭제되도록 설정했다. (ON DELETE CASCADE)
   - `단어가 읽기다 기본편`을 삭제하면 소속되어 있는 `Unit 01 - 요리`카테고리와 `Unit 02 - 일상1`카테고리도 연쇄 삭제되도록 설정했다.
2. 카테고리 컬럼을 삭제하면 자식인 단어 컬럼들도 모두 연쇄 삭제되도록 설정했다. (ON DELETE CASCADE)
   - `Unit 01 - 요리` 카테고리를 삭제하면 소속되어 있는 `spice, 양념` 단어와 `add, 추가하다` 단어도 연쇄 삭제되도록 설정했다.

3. 책 이름이 중복되지 않도록 UNIQUE 설정을 걸어줬다.
   - `단어가 읽기다 기본편`이 이미 존재 하는데, 또 다시 `단어가 읽기다 기본편`이 추가되지 않도록 설정했다.
4. 카테고리 이름이 중복되지 않도록 UNIQUE 설정을 걸어줬다.
   - `단어가 읽기다 기본편`에 `Unit 01 - 요리`카테고리가 이미 존재하는데, 또 다시 `Unit 01 - 요리`가 추가되지 않도록 설정했다.
   - `단어가 읽기다 기본편`에 `Unit 01 - 요리`카테고리가 이미 존재하고 `단어가 읽기다 실전편`에 `Unit 01 -요리`가 추가되는것은 허용한다. 
5. 단어가 중복되지 않도록 단어 이름과 단어 뜻을 묶어서 UNIQUE 설정을 걸어줬다.
   - `take, (수업을)듣다`가 이미 존재하는데 또 다시 `take, (수업을)듣다`가 추가되지 않도록 설정했다.
   - 하지만, `take, (수업을)듣다`가 존재하는데 `take, (의자에)앉다`는 추가되도록 설정했다.

6. 각 테이블에 컬럼을 추가하면 자동으로 등록일과 수정일을 기록하도록 설정했다.



#### 테이블 CRUD SQL테스트

```SQL
-- 책 조회
SELECT TBL_BOOK.* FROM TBL_BOOK;

-- 책 컬럼 추가
INSERT INTO TBL_BOOK(BOOK_NAME) VALUES ('단어가 읽기다 기본편');
INSERT INTO TBL_BOOK(BOOK_NAME) VALUES ('단어가 읽기다 실전편');

-- 책 컬럼 삭제 ( ON DELETE CASCADE )
DELETE FROM TBL_BOOK WHERE BOOK_ID = 1;

-- 카테고리 조회
SELECT TBL_CATEGORY.* FROM TBL_CATEGORY;

-- 카테고리 컬럼 추가
INSERT INTO TBL_CATEGORY(CATEGORY_NAME, BOOK_ID) VALUES ('Unit 01 - 요리', 5);
INSERT INTO TBL_CATEGORY(CATEGORY_NAME, BOOK_ID) VALUES ('Unit 01 - 요리', 4); 
INSERT INTO TBL_CATEGORY(CATEGORY_NAME, BOOK_ID) VALUES ('Unit 02 - 일상1', 5);
INSERT INTO TBL_CATEGORY(CATEGORY_NAME, BOOK_ID) VALUES ('Unit 03 - 일상2', 5);

-- 책 테이블과 카테고리 테이블 INNER JOIN
SELECT B.BOOK_ID, B.BOOK_NAME, C.CATEGORY_ID, C.CATEGORY_NAME FROM TBL_BOOK B
INNER JOIN TBL_CATEGORY C ON B.BOOK_ID = C.BOOK_ID;

-- 카테고리 컬럼 삭제 ( ON DELETE CASCADE )
DELETE FROM TBL_CATEGORY WHERE CATEGORY_ID = 6;

-- 단어 조회
SELECT TBL_WORD.* FROM TBL_WORD;

-- 단어 컬럼 추가
INSERT INTO TBL_WORD(WORD_NAME, WORD_MEANING, CATEGORY_ID) VALUES ('spice', '양념', 6);
INSERT INTO TBL_WORD(WORD_NAME, WORD_MEANING, CATEGORY_ID) VALUES ('take', '(수업을)듣다', 6);
INSERT INTO TBL_WORD(WORD_NAME, WORD_MEANING, CATEGORY_ID) VALUES ('take', '(의자에)앉다', 6);
INSERT INTO TBL_WORD(WORD_NAME, WORD_MEANING, CATEGORY_ID) VALUES ('delicious', '맛있는', 6);
INSERT INTO TBL_WORD(WORD_NAME, WORD_MEANING, CATEGORY_ID) VALUES ('tasty', '맛있는', 6);
```

1. 책 테이블의 연쇄 삭제가 제대로 동작 하는지 테스트 (테스트 성공)
   - 책 컬럼을 삭제시 소속된 모든 카테고리들이 연쇄 삭제 되었고, 카테고리에 소속된 모든 단어들도 같이 연쇄 삭제가 되었다.
2. 카테고리 테이블의 연쇄 삭제가 제대로 동작 하는지 테스트 (테스트 성공)
   - 카테고리 컬럼을 삭제시 소속된 모든 단어들이 연쇄 삭제 되었다.
3. 책 테이블에 중복된 컬럼이 추가되는지 테스트 ---> 추가되지 않았음 (테스트 성공)
   - `단어가 읽기다 기본편`을 추가하고 또 다시 `단어가 읽기다 기본편`을 추가하면 추가되지 않았다.
4. 카테고리 테이블에 중복된 컬럼이 추가되는지 테스트 ---> 추가되지 않았음 (테스트 성공)
   - `단어가 읽기다 기본편`에 `Unit 03 - 일상2`를 추가하고 또 다시 `Unit 03 - 일상2`를 추가하면 추가되지 않았다.
5. 단어 테이블에 중복된 컬럼이 추가되는지 테스트 ---> 추가되지 않았음 (테스트 성공)
   - `단어가 읽기다 기본편`의 `Unit 01 - 요리`카테고리에 `take, (수업을)듣다`를 추가하고 또 다시 `take, (수업을)듣다`를 추가하면 추가되지 않았다.
6. 단어 테이블에 단어의 이름은 중복되고 뜻만 다르게 추가되는지 테스트 ---> 추가됨 (테스트 성공)
   - `단어가 읽기다 기본편`의 `Unit 01 - 요리`카테고리에 `take, (수업을)듣다`를 추가하고 `take, (의자에)앉다`를 추가하면 추가 되었다.
7. 단어 테이블에 단어의 뜻은 중복되고 단어의 이름은 다르게 추가되는지 테스트 ---> 추가됨(테스트 성공)
   - `단어가 읽기다 기본편`의 `Unit 01 - 요리`카테고리에 `delicious, 맛있는`을 추가하고 `tasty, 맛있는`을 추가하면 추가 되었다.

