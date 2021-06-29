# 목차

[TOC]



## 2021-06-26(토) 작업내용

#### 데이터베이스 ERD

![DB_ERD](https://user-images.githubusercontent.com/81298415/123519811-71817b80-d6e8-11eb-8659-a0833916712a.png)



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
4. 카테고리가 중복되지 않도록 카테고리 이름과 소속된 책의 번호를 묶어서 UNIQUE 설정을 걸어줬다.
   - `단어가 읽기다 기본편`에 `Unit 01 - 요리`카테고리가 이미 존재하는데, 또 다시 `Unit 01 - 요리`가 추가되지 않도록 설정했다.
   - `단어가 읽기다 기본편`에 `Unit 01 - 요리`카테고리가 이미 존재하고 `단어가 읽기다 실전편`에 `Unit 01 -요리`가 추가되는것은 허용한다. 
5. 단어가 중복되지 않도록 단어 이름과 단어 뜻을 묶어서 UNIQUE 설정을 걸어줬다.
   - `take, (수업을)듣다`가 이미 존재하는데 또 다시 `take, (수업을)듣다`가 추가되지 않도록 설정했다.
   - 하지만, `take, (수업을)듣다`가 존재하는데 `take, (의자에)앉다`는 추가되도록 설정했다.

6. 각 테이블에 컬럼을 추가하면 자동으로 등록일과 수정일을 기록하도록 설정했다.



#### 테이블 CRUD SQL 테스트

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





## 2021-06-27(일) 작업내용

#### Mybatis Mapper에 사용할 각 테이블의 CRUD 쿼리문 생성



```sql
/* 단어 책 테이블 CRUD */
-- 책 추가하기
INSERT INTO TBL_BOOK (BOOK_NAME) VALUES ('추가할 책 이름');

-- 특정 책 조회하기
SELECT TBL_BOOK.* FROM TBL_BOOK
WHERE BOOK_ID = 21;

-- 특정 책 수정하기
UPDATE TBL_BOOK SET
BOOK_NAME = '수정할 책 이름'
WHERE BOOK_ID = 21;

-- 특정 책 삭제하기
DELETE FROM TBL_BOOK
WHERE BOOK_ID = 2;

-- 모든 책의 목록 조회하기 (새로 추가된 책부터 보여주도록 내림차순 조회)
SELECT /*+ INDEX_DESC(TBL_BOOK PK_TBL_BOOK)*/TBL_BOOK.* FROM TBL_BOOK;

/* 카테고리 테이블 CRUD */
-- 특정 책에 카테고리 추가하기 (추가할 카테고리 이름, 부모 책의 ID)
INSERT INTO TBL_CATEGORY (CATEGORY_NAME, BOOK_ID) VALUES ('추가할 카테고리 이름', 5);

-- 특정 카테고리 조회하기
SELECT TBL_CATEGORY.* FROM TBL_CATEGORY
WHERE CATEGORY_ID = 21;

-- 특정 카테고리 수정하기
UPDATE TBL_CATEGORY SET
CATEGORY_NAME = '수정할 카테고리 이름'
WHERE CATEGORY_ID = 21;

-- 특정 카테고리 삭제하기
DELETE FROM TBL_CATEGORY
WHERE CATEGORY_ID = 26;

-- 모든 카테고리의 목록 조회 (새로 추가된 카테고리 부터 보여주도록 내림차순 조회)
SELECT /*+ INDEX_DESC(TBL_CATEGORY PK_TBL_CATEGORY)*/TBL_CATEGORY.* FROM TBL_CATEGORY;

-- 특정 책에 소속된 모든 카테고리의 목록 조회 (새로 추가된 카테고리 부터 보여주도록 내림차순 조회)
SELECT /*+ INDEX_DESC(TBL_CATEGORY PK_TBL_CATEGORY)*/TBL_CATEGORY.* FROM TBL_CATEGORY
WHERE BOOK_ID = 2;

-- 동작 확인용 책 테이블과 카테고리 테이블 INNER JOIN
SELECT B.BOOK_ID, B.BOOK_NAME, C.CATEGORY_ID, C.CATEGORY_NAME 
FROM TBL_BOOK B INNER JOIN TBL_CATEGORY C ON B.BOOK_ID = C.BOOK_ID
ORDER BY BOOK_ID DESC, CATEGORY_ID ASC;

/* 단어 테이블 CRUD */
-- 특정 카테고리에 단어 추가하기
INSERT INTO TBL_WORD (WORD_NAME, WORD_MEANING, CATEGORY_ID) VALUES ('추가할 단어 이름', '추가할 단어 뜻', 1);

-- 특정 단어 조회하기
SELECT TBL_WORD.* FROM TBL_WORD
WHERE WORD_ID = 21;

-- 특정 단어 수정하기
UPDATE TBL_WORD SET
WORD_NAME = '수정할 단어 이름',
WORD_MEANING = '수정할 단어 뜻'
WHERE WORD_ID = 21;

-- 특정 단어 삭제하기
DELETE FROM TBL_WORD
WHERE WORD_ID = 21;

-- 모든 단어 목록 조회 (새로 추가된 카테고리 부터 보여주도록 내림차순 조회)
SELECT /*+ INDEX_DESC(TBL_WORD PK_TBL_WORD)*/TBL_WORD.* FROM TBL_WORD;

-- 특정 카테고리의 모든 단어 목록 조회 (새로 추가된 카테고리 부터 보여주도록 내림차순 조회)
SELECT /*+ INDEX_DESC(TBL_WORD PK_TBL_WORD)*/TBL_WORD.* FROM TBL_WORD
WHERE CATEGORY_ID = 1;

-- 동작 확인용 카테고리 테이블과 단어 테이블 INNER JOIN
SELECT B.BOOK_ID, B.BOOK_NAME, C.CATEGORY_ID, C.CATEGORY_NAME, W.WORD_ID, W.WORD_NAME, W.WORD_MEANING 
FROM TBL_CATEGORY C INNER JOIN TBL_WORD W ON C.CATEGORY_ID = W.CATEGORY_ID
INNER JOIN TBL_BOOK B ON B.BOOK_ID = C.BOOK_ID
```



SQL문들이 정상적으로 동작하는지 실제 관리자 페이지에서 데이터를 추가한다고 가정하고 더미 데이터를 추가하고, 수정, 삭제, 목록을 테스트 해 보았다.

일단 모든 기능들이 생각했던대로 정상적으로 동작되었다. 

이후에 추가로 필요한 SQL문이 있다면 그때 가서 추가하도록 하겠다.

![CRUD](C:\Users\user\Desktop\(최신)단어 학습 프로젝트\TyporaImages\CRUD.PNG)



#### 메이븐(Maven) 프로젝트 생성 및 세팅

`pom.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/maven-v4_0_0.xsd">
	<modelVersion>4.0.0</modelVersion>
	<groupId>edu.coldrain</groupId>
	<artifactId>controller</artifactId>
	<name>VocaProject</name>
	<packaging>war</packaging>
	<version>1.0.0-BUILD-SNAPSHOT</version>
	<properties>
		<java-version>1.8</java-version>
		<org.springframework-version>5.2.9.RELEASE</org.springframework-version>
		<org.aspectj-version>1.6.10</org.aspectj-version>
		<org.slf4j-version>1.6.6</org.slf4j-version>
	</properties>
	<dependencies>
		<!-- Spring -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-context</artifactId>
			<version>${org.springframework-version}</version>
			<exclusions>
				<!-- Exclude Commons Logging in favor of SLF4j -->
				<exclusion>
					<groupId>commons-logging</groupId>
					<artifactId>commons-logging</artifactId>
				</exclusion>
			</exclusions>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- AspectJ -->
		<dependency>
			<groupId>org.aspectj</groupId>
			<artifactId>aspectjrt</artifactId>
			<version>${org.aspectj-version}</version>
		</dependency>

		<!-- Logging -->
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
			<version>${org.slf4j-version}</version>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>jcl-over-slf4j</artifactId>
			<version>${org.slf4j-version}</version>
			<scope>runtime</scope>
		</dependency>
		<dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-log4j12</artifactId>
			<version>${org.slf4j-version}</version>
			<scope>runtime</scope>
		</dependency>

		<!-- @Inject -->
		<dependency>
			<groupId>javax.inject</groupId>
			<artifactId>javax.inject</artifactId>
			<version>1</version>
		</dependency>

		<!-- 서블릿 관련 라이브러리 -->
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>javax.servlet-api</artifactId>
			<version>3.1.0</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet.jsp</groupId>
			<artifactId>jsp-api</artifactId>
			<version>2.1</version>
			<scope>provided</scope>
		</dependency>
		<dependency>
			<groupId>javax.servlet</groupId>
			<artifactId>jstl</artifactId>
			<version>1.2</version>
		</dependency>
		<!-- //서블릿 관련 라이브러리 -->

		<!-- JUnit 테스트 라이브러리 -->
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<version>4.12</version>
			<scope>test</scope>
		</dependency>

		<!-- 롬복 라이브러리 -->
		<dependency>
			<groupId>org.projectlombok</groupId>
			<artifactId>lombok</artifactId>
			<version>1.18.0</version>
			<scope>provided</scope>
		</dependency>

		<!-- log4j 라이브러리 -->
		<dependency>
			<groupId>log4j</groupId>
			<artifactId>log4j</artifactId>
			<version>1.2.17</version>
		</dependency>


		<!-- 데이터베이스 관련 라이브러리 -->

		<!-- Oracle JDBC8 드라이버 -->
		<dependency>
			<groupId>com.oracle.database.jdbc</groupId>
			<artifactId>ojdbc8</artifactId>
			<version>21.1.0.0</version>
		</dependency>

		<!-- HikariCP 커넥션 풀 라이브러리 -->
		<dependency>
			<groupId>com.zaxxer</groupId>
			<artifactId>HikariCP</artifactId>
			<version>3.4.5</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis</artifactId>
			<version>3.4.6</version>
		</dependency>

		<!-- https://mvnrepository.com/artifact/org.mybatis/mybatis-spring -->
		<dependency>
			<groupId>org.mybatis</groupId>
			<artifactId>mybatis-spring</artifactId>
			<version>1.3.2</version>
		</dependency>

		<!-- 스프링에서 트랜잭션 처리 라이브러리 -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-tx</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- 스프링에서 데이터베이스 처리 라이브러리 -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- 스프링 테스트 라이브러리 -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-test</artifactId>
			<version>${org.springframework-version}</version>
		</dependency>

		<!-- Log4jdbc JDBC 로그 라이브러리 -->
		<dependency>
			<groupId>org.bgee.log4jdbc-log4j2</groupId>
			<artifactId>log4jdbc-log4j2-jdbc4</artifactId>
			<version>1.16</version>
		</dependency>

		<!-- //데이터베이스 관련 라이브러리 -->

	</dependencies>
	<build>
		<plugins>
			<plugin>
				<artifactId>maven-eclipse-plugin</artifactId>
				<version>2.9</version>
				<configuration>
					<additionalProjectnatures>
						<projectnature>org.springframework.ide.eclipse.core.springnature</projectnature>
					</additionalProjectnatures>
					<additionalBuildcommands>
						<buildcommand>org.springframework.ide.eclipse.core.springbuilder</buildcommand>
					</additionalBuildcommands>
					<downloadSources>true</downloadSources>
					<downloadJavadocs>true</downloadJavadocs>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.apache.maven.plugins</groupId>
				<artifactId>maven-compiler-plugin</artifactId>
				<version>2.5.1</version>
				<configuration>
					<source>1.8</source>
					<target>1.8</target>
					<compilerArgument>-Xlint:all</compilerArgument>
					<showWarnings>true</showWarnings>
					<showDeprecation>true</showDeprecation>
				</configuration>
			</plugin>
			<plugin>
				<groupId>org.codehaus.mojo</groupId>
				<artifactId>exec-maven-plugin</artifactId>
				<version>1.2.1</version>
				<configuration>
					<mainClass>org.test.int1.Main</mainClass>
				</configuration>
			</plugin>
		</plugins>
	</build>
</project>
```



`root-context.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mybatis-spring="http://mybatis.org/schema/mybatis-spring"
	xsi:schemaLocation="http://mybatis.org/schema/mybatis-spring http://mybatis.org/schema/mybatis-spring-1.2.xsd
		http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd">

	<!-- Root Context: defines shared resources visible to all other web components -->
	<!-- 데이터베이스 관련된 빈 설정 -->

	<!-- HikariCP 설정 -->
	<bean id="hikariConfig" class="com.zaxxer.hikari.HikariConfig">
		<!-- log4jdbc-log4j2 사용 설정 추가 -->
		<property name="driverClassName"
			value="net.sf.log4jdbc.sql.jdbcapi.DriverSpy" />
		<property name="jdbcUrl"
			value="jdbc:log4jdbc:oracle:thin:@localhost:1521:XE" />

		<property name="username" value="voca2" />
		<property name="password" value="voca2" />
	</bean>
	<bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource"
		destroy-method="close">
		<constructor-arg ref="hikariConfig"></constructor-arg>
	</bean>

	<!-- SQLSessionFactory 설정 -->
	<bean id="sqlSessionFactory"
		class="org.mybatis.spring.SqlSessionFactoryBean">
		<property name="dataSource" ref="dataSource" />
	</bean>


	<!-- mybatis scan 설정 -->
	<mybatis-spring:scan
		base-package="edu.coldrain.mapper" />

	<!-- //데이터베이스 관련된 빈 설정 -->
</beans>
```



`log4jdbc.log4j2.properties`

```properties
log4jdbc.spylogdelegator.name=net.sf.log4jdbc.log.slf4j.Slf4jSpyLogDelegator
```



#### JDBC 연결 테스트

```java
package edu.coldrain.persistence;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String USER = "voca2";
    private static final String PASSWORD = "voca2";

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void textConnection() {
        try {

            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);

            //정상적으로 데이터베이스가 연결되면 연결된 Connection 객체가 출력된다.
            log.info(connection);

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
```



#### Datasource 테스트

```java
package edu.coldrain.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {

	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void testConnection() throws Exception {
		
		try(Connection con = dataSource.getConnection()) {
			log.info(con);
		} catch(Exception e) {
			fail(e.getMessage());
		}
	}
	
	@Test
	public void testMyBatis() {
		
		try (SqlSession session = sqlSessionFactory.openSession();
				Connection con = session.getConnection(); ) {
			log.info(session);
			log.info(con);
		} catch (SQLException e) {
			fail(e.getMessage());
		}
	}
}
```



#### 단어 책 테이블 영속 계층 구현

`BookVO 정의`

```java
@Getter
@Setter
@ToString
@NoArgsConstructor
public class BookVO {

	// 책 아이디 AUTO SEQUENCE
	private Long bookId;

	// 책 이름 UNIQUE
	private String bookName;

	// 등록일 DEFAULT SYSDATE
	private Date regdate;

	// 수정일 DEFAULT SYSDATE
	private Date updatedate;
	
	public BookVO(String bookName) {
		this.bookName = bookName;
	}
}
```

`BookMapper 인터페이스 정의`

```java
public interface BookMapper {

	// 책 추가하기
	public int insert(BookVO bookVO);
    
	// 특정 책 조회하기
	public BookVO read(Long bookId);
	
	// 특정 책 수정하기
	public int update(BookVO bookVO);
	
	// 특정 책 삭제하기
	public int delete(Long bookId);
	
	// 모든 책의 목록 조회하기
	public List<BookVO> readList();

}
```



`BookMapper.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
	PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="edu.coldrain.mapper.BookMapper">

	<resultMap type="edu.coldrain.domain.BookVO" id="bookResultMap">
		<result property="bookId" column="book_id" />
		<result property="bookName" column="book_name" />
	</resultMap>

	<!-- 책 추가하기 -->
	<insert id="insert" >
		INSERT INTO TBL_BOOK (BOOK_NAME) VALUES (#{bookName})
	</insert>
	
	<!-- 특정 책 조회하기 -->
	<select id="read" resultMap="bookResultMap">
		SELECT TBL_BOOK.* FROM TBL_BOOK
		WHERE BOOK_ID = #{bookId}
	</select>
	
	<!-- 특정 책 수정하기 -->
	<update id="update">
		UPDATE TBL_BOOK SET
		BOOK_NAME = #{bookName}
		WHERE BOOK_ID = #{bookId}
	</update>
	
	<!-- 특정 책 삭제하기 -->
	<delete id="delete">
		DELETE FROM TBL_BOOK
		WHERE BOOK_ID = #{bookId}
	</delete>
	
	<!-- 모든 책의 목록 조회하기 (내림차순) -->
	<select id="readList" resultMap="bookResultMap">
		<![CDATA[
			SELECT /*+ INDEX_DESC(TBL_BOOK PK_TBL_BOOK)*/TBL_BOOK.* FROM TBL_BOOK
		]]>
	</select>
	
</mapper>
```



`BookMapperTests 정의`

```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookMapperTests {

	@Autowired
	private BookMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		BookVO bookVO = new BookVO("단어가 읽기다 테스트편3");
		int count = mapper.insert(bookVO);
		
		log.info("INSERT COUNT = " + count);
		log.info("BOOK_VO = " + bookVO);
	}
	
	@Test
	public void testRead() {
		BookVO bookVO = mapper.read(5L);
		log.info("BOOK_VO = " + bookVO);
	}
	
	@Test
	public void testUpdate() {
		BookVO bookVO = mapper.read(47L);
		bookVO.setBookName("단어가 읽기다 수정편");
		
		int count = mapper.update(bookVO);
		log.info("UPDATE COUNT = " + count);
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(47L);
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<BookVO> list = mapper.readList();
		list.forEach(book -> log.info(book));
	}
}
```



#### 단어 책 테이블 비즈니스 계층 구현

`BookService 인터페이스`

```java
public interface BookService {

	// 책 추가하기
	public boolean register(BookVO bookVO);
    
	// 특정 책 조회하기
	public BookVO get(Long bookId);
	
	// 특정 책 수정하기
	public boolean modify(BookVO bookVO);
	
	// 특정 책 삭제하기
	public boolean remove(Long bookId);
	
	// 모든 책의 목록 조회하기
	public List<BookVO> getList();
}
```



`BookServiceImpl 클래스`

```java
@Service
@RequiredArgsConstructor
public class BookServiceImpl implements BookService {

	private final BookMapper mapper;
	
	/**
	 * 책 레코드 하나를 추가하는 기능을 수행한다.
	 * @param BookVO 추가할 책 모델
	 * @return boolean 레코드가 정상적으로 추가 되었으면 true 실패하면 false
	 */
	@Override
	public boolean register(BookVO bookVO) {
		return ( mapper.insert(bookVO) == 1 );
	}

	/**
	 * 책 레코드 하나를 조회하는 기능을 수행한다.
	 * @param Long 책 아이디
	 * @return BookVO 조회한 책 모델
	 */
	@Override
	public BookVO get(Long bookId) {
		return mapper.read(bookId);
	}

	/**
	 * 책 레코드 하나를 수정하는 기능을 수행한다.
	 * @param BookVO 수정할 책 모델
	 * @return boolean 레코드가 정상적으로 수정 되었으면 true 실패하면 false
	 */
	@Override
	public boolean modify(BookVO bookVO) {
		return ( mapper.update(bookVO) == 1 );
	}

	/**
	 * 책 레코드 하나를 삭제하는 기능을 수행한다.
	 * @param Long 책 아이디
	 * @return boolean 레코드가 정상적으로 삭제 되었으면 true 실패하면 false
	 */
	@Override
	public boolean remove(Long bookId) {
		return ( mapper.delete(bookId) == 1 );
	}

	/**
	 * 모든 책 레코드 목록을 조회하는 기능을 수행한다.
	 * @return List<BookVO> 조회된 모든 책 레코드 모델 리스트 
	 */
	@Override
	public List<BookVO> getList() {
		return mapper.readList();
	}
}

```

`BookServiceTests 클래스`

```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookServiceTests {

	@Autowired
	private BookService service;
	
	@Test
	public void testExist() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		BookVO bookVO = new BookVO("BOOK REGISTER");
		boolean success = service.register(bookVO);
		
		log.info("REGISTER SUCCESS = " + success);
	}
	
	@Test
	public void testGet() {
		BookVO bookVO = service.get(48L);
		log.info("BOOK_VO = " + bookVO);
	}
	
	@Test
	public void testModify() {
		BookVO bookVO = service.get(48L);
		bookVO.setBookName("BOOK MODIFY");
		
		boolean success = service.modify(bookVO);
		log.info("MODIFY SUCCESS = " + success);
	}
	
	@Test
	public void testRemove() {
		boolean success = service.remove(48L);
		log.info("DELETE SUCCESS = " + success);
	}
	
	@Test
	public void testGetList() {
		List<BookVO> list = service.getList();
		list.forEach(bookVO -> log.info(bookVO));
	}
}
```



#### 카테고리 테이블 영속 계층 구현

`CategoryVO 클래스`

```java
@Getter
@Setter
@ToString
@NoArgsConstructor
public class CategoryVO {

	// 카테고리 아이디 AUTO SEQUENCE
	private Long categoryId;
	
	// 카테고리 이름 UNIQUE
	private String categoryName;
	
	// 책 아이디 UNIQUE
	private Long bookId;
	
	// 등록일 DEFAULT SYSDATE
	private Date regdate;
	
	// 수정일 DEFAULT SYSDATE
	private Date updatedate;
	
	public CategoryVO(String categoryName, Long bookId) {
		this.categoryName = categoryName;
		this.bookId = bookId;
	}
	
}
```

`CategoryMapper 인터페이스`

```java
public interface CategoryMapper {

	// 카테고리 추가하기
	public int insert(CategoryVO categoryVO);
	
	// 특정 카테고리 조회하기
	public CategoryVO read(Long categoryId);
	
	// 특정 카테고리 수정하기
	public int update(CategoryVO categoryVO);
	
	// 특정 카테고리 삭제하기
	public int delete(Long categoryId);
	
	// 모든 카테고리의 목록 조회하기
	public List<CategoryVO> readList();
	
	// 특정 책에 소속된 모든 카테고리의 목록 조회
	public List<CategoryVO> readListByBookId(Long bookId);
}
```



`CategoryMapper.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper
	PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="edu.coldrain.mapper.CategoryMapper">

	<resultMap type="edu.coldrain.domain.CategoryVO" id="categoryResultMap">
		<result property="categoryId" column="category_id"/>
		<result property="categoryName" column="category_name"/>
		<result property="bookId" column="book_id"/>
	</resultMap>

	<!-- 특정 책에 카테고리 추가하기 -->
	<insert id="insert">
		INSERT INTO TBL_CATEGORY (CATEGORY_NAME, BOOK_ID) VALUES (#{categoryName}, #{bookId})
	</insert>
	
	<!-- 특정 카테고리 조회하기 -->
	<select id="read" resultMap="categoryResultMap">
		SELECT TBL_CATEGORY.* FROM TBL_CATEGORY
		WHERE CATEGORY_ID = #{categoryId}
	</select>
	
	<!-- 특정 카테고리 수정하기 -->
	<update id="update">
		UPDATE TBL_CATEGORY SET
		CATEGORY_NAME = #{categoryName}
		WHERE CATEGORY_ID = #{categoryId}
	</update>
	
	<!-- 특정 카테고리 삭제하기 -->
	<delete id="delete">
		DELETE FROM TBL_CATEGORY
		WHERE CATEGORY_ID = #{categoryId}
	</delete>
	
	<!-- 모든 카테고리의 목록 조회 ( 내림차순 )-->
	<select id="readList" resultMap="categoryResultMap">
		<![CDATA[
			SELECT /*+ INDEX_DESC(TBL_CATEGORY PK_TBL_CATEGORY)*/TBL_CATEGORY.* FROM TBL_CATEGORY
		]]>
	</select>
	
	<!-- 특정 책에 소속된 모든 카테고리의 목록 조회 ( 내림차순 ) -->
	<select id="readListByBookId" resultMap="categoryResultMap">
		SELECT /*+ INDEX_DESC(TBL_CATEGORY PK_TBL_CATEGORY)*/TBL_CATEGORY.* FROM TBL_CATEGORY
		WHERE BOOK_ID = #{bookId}
	</select>

</mapper>
```



`CategoryMapperTests 클래스`

```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CategoryMapperTests {
	
	@Autowired
	private CategoryMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		CategoryVO categoryVO = new CategoryVO("Unit 00 - 테스트", 44L);
		
		int count = mapper.insert(categoryVO);
		log.info("INSERT COUNT = " + count);
	}
	
	@Test
	public void testRead() {
		CategoryVO categoryVO = mapper.read(28L);
		
		log.info("CATEGORY_VO = " + categoryVO);
	}
	
	@Test
	public void testUpdate() {
		CategoryVO categoryVO = mapper.read(28L);
		categoryVO.setCategoryName("Unit 00 - 테스트 (수정)");
		
		int count = mapper.update(categoryVO);
		
		log.info("UPDATE COUNT = " + count);
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(28L);
		
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<CategoryVO> list = mapper.readList();
		list.forEach(category -> log.info(category));
	}
	
	@Test
	public void testReadListByBookId() {
		List<CategoryVO> list = mapper.readListByBookId(5L);
		list.forEach(category -> log.info(category));
	}
}
```

#### 카테고리 테이블 비즈니스 계층 구현

`CategoryService 인터페이스`

```java
public interface CategoryService {

	// 카테고리 추가하기
	public boolean register(CategoryVO categoryVO);
    
	// 특정 카테고리 조회하기
	public CategoryVO get(Long categoryId);
	
	// 특정 카테고리 수정하기
	public boolean modify(CategoryVO categoryVO);
	
	// 특정 카테고리 삭제하기
	public boolean remove(Long categoryId);
	
	// 모든 카테고리의 목록 조회하기
	public List<CategoryVO> getList();
		
	// 특정 책에 소속된 모든 카테고리의 목록 조회
	public List<CategoryVO> getListByBookId(Long bookId);
}
```



`CategoryServiceImpl 클래스`

```java
@Service
@RequiredArgsConstructor
public class CategoryServiceImpl implements CategoryService {

	private final CategoryMapper mapper;
	
	@Override
	public boolean register(CategoryVO categoryVO) {
		return ( mapper.insert(categoryVO) == 1 );
	}

	@Override
	public CategoryVO get(Long categoryId) {
		return mapper.read(categoryId);
	}

	@Override
	public boolean modify(CategoryVO categoryVO) {
		return ( mapper.update(categoryVO) == 1 );
	}

	@Override
	public boolean remove(Long categoryId) {
		return ( mapper.delete(categoryId) == 1 );
	}

	@Override
	public List<CategoryVO> getList() {
		return mapper.readList();
	}

	@Override
	public List<CategoryVO> getListByBookId(Long bookId) {
		return mapper.readListByBookId(bookId);
	}

}
```



`CategoryServiceTests 클래스`

```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class CategoryServiceTests {

	@Autowired
	private CategoryService service;
	
	@Test
	public void testExist() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		CategoryVO categoryVO = new CategoryVO("REGISTER TEST", 5L);
		boolean success = service.register(categoryVO);
		log.info("REGISTER SUCCESS = " + success);
	}
	
	@Test
	public void testGet() {
		CategoryVO categoryVO = service.get(29L);
		log.info(categoryVO);
	}
	
	@Test
	public void testModify() {
		CategoryVO categoryVO = service.get(29L);
		categoryVO.setCategoryName("MODIFY TEST");
		
		boolean success = service.modify(categoryVO);
		log.info("MODIFY SUCCESS = " + success);
	}
	
	@Test
	public void testRemove() {
		boolean success = service.remove(29L);
		log.info("DELETE SUCCESS = " + success);
	}
	
	@Test
	public void testGetList() {
		List<CategoryVO> list = service.getList();
		list.forEach(category -> log.info(category));
	}
	
	@Test
	public void testGetListByBookId() {
		List<CategoryVO> list = service.getListByBookId(5L);
		list.forEach(category -> log.info(category));
	}
}
```



#### 단어 테이블 영속 계층 구현

`WordVO 클래스`

```java
@Getter
@Setter
@ToString
@NoArgsConstructor
public class WordVO {

	// 단어 아이디 AUTO SEQUENCE
	private Long wordId;
	
	// 단어 이름 UNIQUE
	private String wordName;
	  
	// 단어 뜻 UNIQUE
	private String wordMeaning;
	
	// 카테고리 아이디 UNIQUE
	private Long categoryId;
	
	// 등록일 DEFAULT SYSDATE
	private Date regdate;
	
	// 수정일 DEFAULT SYSDATE
	private Date updatedate;
	
	public WordVO(String wordName, String wordMeaning, Long categoryId) {
		this.wordName = wordName;
		this.wordMeaning = wordMeaning;
		this.categoryId = categoryId;
	}
	
}
```

`WordMapper 인터페이스`

```java
public interface WordMapper {

	// 특정 카테고리에 단어 추가하기
	public int insert(WordVO wordVO);
	
	// 특정 단어 조회하기
	public WordVO read(Long wordId);
	
	// 특정 단어 수정하기
	public int update(WordVO wordVO);
	
	// 특정 단어 삭제하기
	public int delete(Long wordId);
	
	// 모든 단어의 목록 조회하기
	public List<WordVO> readList();
	
	// 특정 카테고리의 모든 단어 목록 조회하기
	public List<WordVO> readListByCategoryId(Long categoryId);
}
```



`WordMapperTests 클래스`

```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class WordMapperTests {

	@Autowired
	private WordMapper mapper;
	
	@Test
	public void testExist() {
		log.info(mapper);
	}
	
	@Test
	public void testInsert() {
		WordVO wordVO = new WordVO("INSERT", "삽입하다", 23L);
		int count = mapper.insert(wordVO);
		
		log.info("INSERT COUNT = " + count);
	}
	
	@Test
	public void testRead() {
		WordVO wordVO = mapper.read(30L);
		log.info("WORD_VO = " + wordVO);
	}
	
	@Test
	public void testUpdate() {
		WordVO wordVO = mapper.read(30L);
		wordVO.setWordName("UPDATE");
		wordVO.setWordMeaning("갱신하다");
		
		int count = mapper.update(wordVO);
		log.info("UPDATE COUNT = " + count);		
	}
	
	@Test
	public void testDelete() {
		int count = mapper.delete(30L);
		log.info("DELETE COUNT = " + count);
	}
	
	@Test
	public void testReadList() {
		List<WordVO> list = mapper.readList();
		list.forEach(word -> log.info(word));
	}
	
	@Test
	public void testReadListByCategoryId() {
		List<WordVO> list = mapper.readListByCategoryId(23L);
		list.forEach(word -> log.info(word));
	}
}
```

#### 단어 테이블 비즈니스 계층 구현

`WordService 인터페이스`

```java
public interface WordService {

	// 특정 카테고리에 단어 추가하기
	public boolean register(WordVO wordVO);
	
	// 특정 단어 조회하기 
	public WordVO get(Long wordId);
	
	// 특정 단어 수정하기
	public boolean modify(WordVO wordVO);
	
	// 특정 단어 삭제하기
	public boolean remove(Long wordId);
	
	// 모든 단어의 목록 조회하기
	public List<WordVO> getList();
	
	// 특정 카테고리의 모든 단어 목록 조회하기
	public List<WordVO> getListByCategoryId(Long categoryId);
}
```

`WordServiceImpl 클래스`

```java
@Service
@RequiredArgsConstructor
public class WordServiceImpl implements WordService {

	private final WordMapper mapper;
	
	@Override
	public boolean register(WordVO wordVO) {
		return ( mapper.insert(wordVO) == 1 );
	}

	@Override
	public WordVO get(Long wordId) {
		return mapper.read(wordId);
	}

	@Override
	public boolean modify(WordVO wordVO) {
		return ( mapper.update(wordVO) == 1 );
	}

	@Override
	public boolean remove(Long wordId) {
		return ( mapper.delete(wordId) == 1 );
	}

	@Override
	public List<WordVO> getList() {
		return mapper.readList();
	}

	@Override
	public List<WordVO> getListByCategoryId(Long categoryId) {
		return mapper.readListByCategoryId(categoryId);
	}

}
```

`WordServiceTests 클래스`

```java
@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class WordServiceTests {

	@Autowired
	private WordService service;
	
	@Test
	public void testExist() {
		log.info(service);
	}
	
	@Test
	public void testRegister() {
		WordVO wordVO = new WordVO("REGISTER", "등록하다", 23L);
		boolean success = service.register(wordVO);
		
		log.info("REGISTER SUCCESS = " + success);
	}
	
	@Test
	public void testGet() {
		WordVO wordVO = service.get(31L);
		log.info("WORD_VO = " + wordVO);
	}
	
	@Test
	public void testModify() {
		WordVO wordVO = service.get(31L);
		wordVO.setWordName("MODIFY");
		wordVO.setWordMeaning("수정하다");
		
		boolean success = service.modify(wordVO);
		log.info("MODIFY SUCCESS = " + success);
	}
	
	@Test
	public void testRemove() {
		boolean success = service.remove(31L);
		log.info("REMOVE SUCCESS = " + success);
	}
	
	@Test
	public void testGetList() {
		List<WordVO> list = service.getList();
		list.forEach(word -> log.info(word));
	}
	
	@Test
	public void testGetListByCategoryId() {
		List<WordVO> list = service.getListByCategoryId(23L);
		list.forEach(word -> log.info(word));
	}
}
```



## 2021-06-28(월) 작업내용

#### 단어 책 테이블 프레젠테이션 계층 구현 - (RestController)

```java
@Log4j
@RestController
@RequestMapping("/books")
@RequiredArgsConstructor
public class BookController {
	
	private final BookService service;

	
	/*    ------ RestFul API 설계
	 * 	  /books GET 모든 책 조회
	 *    /books/new POST 책 추가하기
	 *    /books/1 GET 특정 책 조회하기
	 *    /books/1 PUT/PATCH 특정 책 수정하기
	 *    /books/1 DELETE 특정 책 삭제하기
	 */
	
	//모든 데이터를 조회한다.
	@GetMapping(produces =  MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<BookVO>> getList() {
		log.info("BookController.getList()");
		
		List<BookVO> list = service.getList();
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//클라이언트에서 전송한 JSON 데이터를 받아서 데이터베이스에 추가하고 성공했다는 메시지를 응답해준다.
	@PostMapping(value = "/new", 
				 consumes = MediaType.APPLICATION_JSON_VALUE,
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody BookVO bookVO) {
		log.info("BookController.register()");
		log.info("BookVO = " + bookVO);
		
		//책 등록
		boolean success = service.register(bookVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info("책 등록에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info("책 등록에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//클아이언트가 1번의 책 정보를 요청하면 데이터베이스에서 조회해서 JSON 데이터를 응답해준다.
	@GetMapping(value = "/{bookId}",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BookVO> get(@PathVariable("bookId") Long bookId) {
		log.info("BookController.get()");
		log.info("bookId = " + bookId);
		
		BookVO bookVO = service.get(bookId);
		log.info("BookVO = " + bookVO);
		
		ResponseEntity<BookVO> responseEntity = null;
		
		if (bookVO != null) {
			log.info(bookId + "번 책 조회에 성공했습니다.");
			responseEntity = new ResponseEntity<>(bookVO, HttpStatus.OK);
		} else {
			log.info(bookId + "번 책 조회에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//클라이언트가 수정할 책 아이디와 수정할 책 정보를 전송하면 데이터베이스에서 수정하고 성공했다는 메시지를 응답해준다.
	@PatchMapping(value = "/{bookId}",
				  consumes = MediaType.APPLICATION_JSON_VALUE,
				  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody BookVO bookVO, @PathVariable("bookId") Long bookId) {
		log.info("BookController.modify()");
		
		//{"bookId": 5, "bookName": "단어가 읽기다 기본편"}
		boolean success = service.modify(bookVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(bookId + "번 책 수정에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(bookId + "번 책 수정에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	
	//클라이언트가 책 아이디 1번을 요청하면 1번 책을 데이터베이스에서 삭제한다.
	@DeleteMapping(value = "/{bookId}", 
				   produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("bookId") Long bookId) {
		log.info("BookController.remove()");
		log.info("bookId = " + bookId);
		
		boolean success = service.remove(bookId);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(bookId + "번 책 삭제에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(bookId + "번 책 삭제에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		return responseEntity;
	}
	
}
```



#### 카테고리 테이블 프레젠테이션 계층 구현 - (RestController)

```java
@Log4j
@RestController
@RequiredArgsConstructor
public class CategoryController {

	private final CategoryService service;
	
	/*    ------ RestFul API 설계
	 * 	  /categories GET 모든 카테고리 목록 조회하기 -------- 당장 구현X
	 *    /books/{bookId}/categories GET 1번 책에 소속된 카테고리 목록 조회하기
	 *    /books/{bookId}/categories/new POST 1번 책에 카테고리 추가하기
	 *    /categories/{categoryId} GET 1번 카테고리 조회하기
	 *    /categories/{categoryId} PUT/PATCH 1번 카테고리 수정하기
	 *    /categories/{categoryId} DELETE 1번 카테고리 삭제하기
	 */
	
	//특정 책의 모든 카테고리 목록 조회하기
	@GetMapping(value = "/books/{bookId}/categories",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<CategoryVO>> getList(@PathVariable("bookId") Long bookId) {
		log.info("CategoryController.getList()");
		
		List<CategoryVO> list = service.getListByBookId(bookId);
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//특정 책에 카테고리 추가하기
	@PostMapping(value = "/books/{bookId}/categories/new",
				 consumes = MediaType.APPLICATION_JSON_VALUE,
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody CategoryVO categoryVO, @PathVariable("bookId") Long bookId) {
		log.info("CategoryController.register()");
		
		// {"bookId": 5, "categoryName": "Unit 01 - 요리"}
		boolean success = service.register(categoryVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(bookId + "번 책의 카테고리 추가에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(bookId + "번 책의 카테고리 추가에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 카테고리 조회하기
	@GetMapping(value = "/categories/{categoryId}",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<CategoryVO> get(@PathVariable("categoryId") Long categoryId) {
		log.info("CategoryController.get()");
		
		CategoryVO categoryVO = service.get(categoryId);
		
		ResponseEntity<CategoryVO> responseEntity = null;
		
		if (categoryVO != null) {
			log.info(categoryId + "번 카테고리 조회에 성공했습니다.");
			responseEntity = new ResponseEntity<>(categoryVO, HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리 조회에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 카테고리 수정하기
	@PatchMapping(value = "/categories/{categoryId}",
				  consumes = MediaType.APPLICATION_JSON_VALUE,
				  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody CategoryVO categoryVO, @PathVariable("categoryId") Long categoryId) {
		log.info("CategoryController.modify()");
	
		ResponseEntity<String> responseEntity = null;
	
		//클라이언트 요청: {"categoryId": "1", "categoryName": "Unit 01 - 요리"}
		boolean success = service.modify(categoryVO);
		
		if (success) {
			log.info(categoryId + "번 카테고리 수정에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리 수정에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 카테고리 삭제하기
	@DeleteMapping(value = "/categories/{categoryId}",
				   produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> remove(@PathVariable("categoryId") Long categoryId) {
		log.info("CategoryController.remove()");
		
		boolean success = service.remove(categoryId);

		ResponseEntity<String> responseEntity = null;

		if (success) {
			log.info(categoryId + "번 카테고리 삭제에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리 삭제에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
}
```



#### 단어 테이블 프레젠테이션 계층 구현 - (RestController)

```java
@Log4j
@RestController
@RequiredArgsConstructor
public class WordController {

	private final WordService service;
	
	/*    ------ RestFul API 설계
	 * 	  /words GET 모든 단어 목록 조회하기 -------- 당장 구현X
	 *    /categories/{categoryId}/words GET 1번 카테고리에 소속된 단어 목록 조회하기
	 *    /categories/{categoryId}/words/new POST 1번 카테고리에 단어 추가하기
	 *    /words/{wordId} GET 1번 단어 조회하기
	 *    /words/{wordId} PUT/PATCH 1번 단어 수정하기
	 *    /words/{wordId} DELETE 1번 단어 삭제하기
	 */
	
	//특정 카테고리에 소속된 단어 목록 조회하기
	@GetMapping(value = "/categories/{categoryId}/words",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<WordVO>> getList(@PathVariable("categoryId") Long categoryId) {
		log.info("WordController.getList()");
		
		List<WordVO> list = service.getListByCategoryId(categoryId);
		list.forEach(word -> log.info(word));
		
		return new ResponseEntity<>(list, HttpStatus.OK);
	}
	
	//특정 카테고리에 단어 추가하기
	@PostMapping(value = "/categories/{categoryId}/words/new",
				 consumes = MediaType.APPLICATION_JSON_VALUE,
				 produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> register(@RequestBody WordVO wordVO, @PathVariable("categoryId") Long categoryId) {
		log.info("WordController.register()");
		
		//{"categoryId" :1, "wordName": "spice", "wordMeaning": "양념"}
		boolean success = service.register(wordVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(categoryId + "번 카테고리의 단어 추가에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(categoryId + "번 카테고리의 단어 추가에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 단어 조회하기
	@GetMapping(value = "/words/{wordId}",
			    produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<WordVO> get(@PathVariable("wordId") Long wordId) {
		log.info("WordController.get()");
		
		WordVO wordVO = service.get(wordId);
		
		ResponseEntity<WordVO> responseEntity = null;
		
		if (wordVO != null) {
			log.info(wordId + "번 단어 조회에 성공했습니다.");
			responseEntity = new ResponseEntity<>(wordVO, HttpStatus.OK);
			
		} else {
			log.info(wordId + "번 단어 조회에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	//특정 단어 수정하기
	@PatchMapping(value = "/words/{wordId}",
				  consumes = MediaType.APPLICATION_JSON_VALUE,
				  produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> modify(@RequestBody WordVO wordVO, @PathVariable("wordId") Long wordId) {
		log.info("WordController.modify()");
		
		//{"wordId": 41, "wordName": "remove", "wordMeaning": "제거하다"}
		boolean success = service.modify(wordVO);
		
		ResponseEntity<String> responseEntity = null;
		
		if (success) {
			log.info(wordId +"번 단어 수정에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(wordId +"번 단어 수정에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
	
	
	//특정 단어 삭제하기
	@DeleteMapping(value = "/words/{wordId}",
				   produces = MediaType.TEXT_XML_VALUE)
	public ResponseEntity<String> remove(@PathVariable("wordId") Long wordId) {
		log.info("WordController.remove()");
		
		boolean success = service.remove(wordId);
		
		ResponseEntity<String> responseEntity = null;

		if (success) {
			log.info(wordId + "번 단어 삭제에 성공했습니다.");
			responseEntity = new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			log.info(wordId + "번 단어 삭제에 실패했습니다.");
			responseEntity = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		return responseEntity;
	}
}
```



## 2021-06-29(화) 작업내용

책 관리 jsp 페이지 Ajax를 이용한 CRUD 구현 완료

딜리트 모달창 세부 내용 구현예정

