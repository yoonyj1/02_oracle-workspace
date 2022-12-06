-- DDL 비번도 동일하게 마들고 커넥션, 리소스 권한 부여할 것

/*
    * DDL (DATA DEFINITION LANGUAGE): 데이터 정의 언어
    오라클에서 제공하는 객체(OBJECT)를 새로이 만들고(CREATE), 구조를 변경하고(ALTER), 구조 자체를 삭제(DROP)하는 언어
    즉, 실제 데이터 값이 아닌 구조자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함
    
    오라클에서 제공하는 객체(구조): 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX),
                               패키지(PACKAGE), 트리거(TRIGGER), 프로시져(PROCEDURE), 함수(FUNCTION)
                               동의어(SYNONYM), 사용자(USER)
                               
    < CREATE >
    객체를 새로이 생성하는 구문
*/

/*
    1. 테이블 생성
    - 테이블: 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
             모든 데이터들은 테이블을 통해서 저장
             (DBMS 용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것)
             
    [표현식]
    CREATE TABLE 테이블명( 
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형,            (NUMBER나 DATE는 크기지정 딱히 필요없음)
        ...                 
    );
    
    * 자료형
    - 문자 (CHAR(바이트크기) | VARCHAR2(바이트크기)) => 반드시 크기지정 해야함
     > CHAR: 최대 2000바이트까지 지정 가능, 지정한 범위 안에서만 써야함 / 고정길이(지정한 크기보다 더 적은 값이 들어와도 나머지는 공백으로 채워짐)
             고정된 글자수의 데이터만이 담길 경우 사용(GENDER, YES/NO, Y/N)
     
     > VARCHAR2: 최대 4000바이트까지 지정 가능, 가변길이(담기는 값에 따라서 공간의 크기가 맞춰짐)
                 몇 글자의 데이터가 들어올 지 모르는 경우 사용
    
    - 숫자(NUMBER)
    
    - 날짜(DATE)
    
*/

-- 회원에 대한 데이터를 담기위한 MEMBER 생성하기
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;
-- 만약 컬럼명에 오타가 발생했다면 다시 만드는 게 아니고 삭제하고 다시 만들어야함

-- [참고] 계정이 가지고 있는 테이블들이 궁금할때
SELECT * FROM USER_TABLES; --> 현재 계정이 가지고 있는 테이블 구조를 볼 수 있음
SELECT * FROM USER_TAB_COLUMNS; --> 현재 계정에 있는 테이블과 컬럼을 볼 수 있음

--------------------------------------------------------------------------------
/*
    2. 컬럼에 주석 달기(컬럼에 대한 설명)
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    
    >> 잘못 작성해서 실행했을 경우 수정 후 다시 실행하면 됨
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원버노';
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호'; -- 오타 발생 했을 경우 수정해서 다시 실행할 수 있음

COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';

-- 테이블 삭제하고자 할 때: DROP TABLE 테이블명;
DROP TABLE MEMBER;
CREATE TABLE MEMBER (
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);


COMMENT ON COLUMN MEMBER.MEM_NO IS '회원버노';
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호'; -- 오타 발생 했을 경우 수정해서 다시 실행할 수 있음
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원명';
COMMENT ON COLUMN MEMBER.GENDER IS '성별(남/여)';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

-- 테이블에 데이터를 추가시키는 구문(DML: INSERT)
-- INSERT INTO 테이블명 VALUES(값1, 값2,....);
SELECT * FROM MEMBER;

-- INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '손흥민'); 입력을 다 하지 않으면 에러 발생
INSERT INTO MEMBER VALUES(1, 'user01', 'pass01', '손흥민', '남', '010-1111-2222', 'qwe@naver.com', '20/12/30');
INSERT INTO MEMBER VALUES(2, 'user02', 'pass02', '황희찬', '여', NULL, NULL, SYSDATE);

INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
-- 유효하지 않은 데이터가 들어가고 있음 -> 조건을 걸어줘야함
--------------------------------------------------------------------------------
/*
    < 제약조건 CONSTRAINTS >
    - 원하는 데이터값(유효한 형식의 값)만 유지하기 위해서 특정 컬럼에 설정하는 제약조건
    - 데이터 무결성 보장을 목적으로 함
    
    * 종류: NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL 제약조건
    - 해당 컬럼에 반드시 값이 존재해야 할 경우(즉, 해당컬럼에 절대로 NULL이 들어와서는 안되는 경우)
    - 삽입 / 수정 시 NULL 값을 허용하지 않도록 제한
    
    제약 조건을 부여하는 방식(2가지) => 컬럼레벨방식, 테이블레벨방식
     * NOT NULL 제약조건은 오로지 컬럼레벨방식 밖에 안됨
*/

-- 컬럼레벨방식: 컬럼명 자료형 제약조건
CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);
SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES (1, 'user01', 'pass01', '손흥민', '남', NULL, NULL);
INSERT INTO MEM_NOTNULL VALUES (2, 'user02', null, '황희찬', '여', null, 'wqe@naver.com');
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_PWD")
-- 의도한대로 오류 남 (NOT NULL 제약조건에 위배)
INSERT INTO MEM_NOTNULL VALUES (2, 'user01', 'pass01', '황희찬', null, null, null);
-- 아이디가 중복되어있음에도 불구하고 추가가 됨

--------------------------------------------------------------------------------
/*
    * UNIQUE 제약조건
    해당 컬럼에 중복된 제약조건이 들어가서는 안 될 경우
    컬럼값에 중복값을 제한하는 제약조건
    삽입 / 수정 시 기존에 있는 데이터 값 중 중복값이 있을 경우 오류 발생
*/

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE, --> 컬럼레벨 방식
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
);

SELECT * FROM MEM_UNIQUE;
DROP TABLE MEM_UNIQUE;

-- 테이블 레벨 방식: 모든 컬럼 나열 후 마지막에 기술
--                제약조건 (컬럼명)
CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    UNIQUE(MEM_ID) -- 테이블 레벨 방식
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '손흥민', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '황희찬', null, null, null);
-- ORA-00001: unique constraint (DDL.SYS_C007063) violated
-- UNIQUE 제약조건에 위배되었음 -> INSERT 실패
--> 오류구문을 제약조건명으로 알려줌(특정 컬럼에 어떤 문제가 있는 지 상세히 알려주지는 않음)
--> 쉽게 파악하기 어려움
--> 제약조건 부여 시 제약조건명 지정해주지 않으면 시스템에서 임의의 제약조건명을 부여해버린다

/*
    * 제약조건 부여 시 제약조건명까지 지어주는 방법
    
    > 컬럼 레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형 [CONSTRAINT 제약조건명] 제약조건,
        컬럼명 자료형
    );
    
    > 테이블 레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형,
        컬럼명 자료형,
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
*/

DROP TABLE MEM_UNIQUE;

CREATE TABLE MEM_UNIQUE (
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL,
    MEM_ID VARCHAR2(20) CONSTRAINT MEMID_NN NOT NULL,
    MEM_PWD VARCHAR2(20) CONSTRAINT MEMPWD_NN NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEMID_UQ UNIQUE(MEM_ID) -- 테이블 레벨 방식
);

SELECT * FROM MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '손흥민', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(2, 'user01', 'pass02', '황희찬', null, null, null);
-- ORA-00001: unique constraint (DDL.MEMID_UQ) violated
--                                        -> 정한 오류 이름으로 출력

INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '황희찬', null, null, null);
INSERT INTO MEM_UNIQUE VALUES(3, 'user03', 'pass03', '이강인', 'ㄴ', null, null); -- 정상적으로 삽입 됨
--> 성별에 유효한 값이 아닌게 들어와도 잘 INSERT 됨

--------------------------------------------------------------------------------
/*
    * CHECK(조건식) 제약조건
    해당 컬럼에 들어올 수 있는 값에 대한 조건을 제시해둘 수 있음
    해당 조건에 만족하는 데이터 값만 담길 수 있음
*/

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')), -- 컬럼레벨 방식
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CHECK(GENDER IN ('남', '여')) -- 테이블레벨 방식
);

SELECT * FROM MEM_CHECK;

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '손흥민', '남', null, null);

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '황희찬', 'ㅋ', null, null);
-- ORA-02290: check constraint (DDL.SYS_C007073) violated
-- CHECK 제약조건에 위배되었기 때문에 오류발생 (GENDER에는 '남', '여'만 들어가야함)
-- 만일 GENDER 컬럼에 데이터 값을 넣고자 한다면, CHECK 제약조건에 만족하는 값을 넣어야함
INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '황희찬', NULL, null, null); -- CHECK 조건이 있는 컬럼에 NOT NULL 제약조건이 없으면 NULL도 가능함

INSERT INTO MEM_CHECK
VALUES(2, 'user03', 'pass03', '이강인', NULL, null, null);

--------------------------------------------------------------------------------
/*
    * PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행들을 식별하기 위해 사용될 컬럼에 부여하는 제약조건(식별자의 역할)
    
    EX) 학번, 회원번호, 사번(EMP_ID), 부서코드(DEPT_ID), 직급코드(JOB_CODE), 주문번호, 예약번호, 운송장번호,........
    
    PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건을 가진다
    
    * 유의사항: 한 테이블 당 오로지 한 개만 설정 가능
*/

CREATE TABLE MEM_PRI(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- 컬럼레벨 방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- 테이블 레벨 방식
);

SELECT * FROM MEM_PRI;

INSERT INTO MEM_PRI
VALUES(1, 'user01', 'pass01', '손흥민', '남', '010-1111-2222', null);
INSERT INTO MEM_PRI
VALUES(1, 'user02', 'pass02', '황희찬', '남', NULL, NULL);
-- ORA-00001: unique constraint (DDL.MEMNO_PK) violated
-- 기본키에 중복값을 담으려고 할 때 (UNIQUE 제약조건에 위배)

INSERT INTO MEM_PRI
VALUES(NULL, 'user02', 'pass02', '황희찬', '남', NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI"."MEM_NO")
-- 기본키에 NULL을 담으려고 할 때 (NOT NULL 제약조건에 위배)

INSERT INTO MEM_PRI
VALUES(2, 'user02', 'pass02', '황희찬', '남', NULL, NULL);

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER CONSTRAINT MEMNO_PK PRIMARY KEY, -- 컬럼레벨 방식
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50)
    -- CONSTRAINT MEMNO_PK PRIMARY KEY(MEM_NO) -- 테이블 레벨 방식
);
-- ORA-02260: table can have only one primary key
-- 기본키가 하나만 됨

CREATE TABLE MEM_PRI2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID) -- 묶어서 PRIMARY KEY 제약조건을 부여할 수 있음 (*복합키), 테이블레벨 방식에서만 가능
);

SELECT * FROM MEM_PRI2;

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '손흥민', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(1, 'user02', 'pass02', '황희찬', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(1, 'user01', 'pass01', '이강인', NULL, NULL, NULL);

INSERT INTO MEM_PRI2
VALUES(NULL, 'user01', 'pass01', '이강인', NULL, NULL, NULL);
-- ORA-01400: cannot insert NULL into ("DDL"."MEM_PRI2"."MEM_NO")
-- PRIMARY KEY로 묶여있는 각 컬럼에는 절대 NULL을 허용하지 않음

-- 복합키 사용 예시(찜하기, 좋아요, 구독 - 한 사람 당 한 번밖에 할 수 없는 것)
-- 찜하기: 한 상품은 오직 한 번만 찜할 수 있음
--      어떤 회원이 어떤 상품을 찜하는지에 대한 데이터를 보관하는 테이블
CREATE TABLE TB_LIKE(
    MEM_ID VARCHAR2(20),
    PRODUCT_NAME VARCHAR2(10),
    LIKE_DATE DATE,
    PRIMARY KEY(MEM_ID, PRODUCT_NAME)
);
SELECT * FROM TB_LIKE;

INSERT INTO TB_LIKE
VALUES('user01', '닭', SYSDATE);

INSERT INTO TB_LIKE
VALUES('user02', '귤', SYSDATE);

INSERT INTO TB_LIKE
VALUES('user01', '귤', SYSDATE);

--------------------------------------------------------------------------------
-- 회원등급에 대한 데이터를 따로 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

SELECT * FROM MEM_GRADE;

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER -- 회원등급번호 같이 보관할 컬럼
);

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '손흥민', '남', NULL, NULL, NULL);
INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '황희찬', NULL, NULL, NULL, 10);
INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이강인', NULL, NULL, NULL, 40);
-- 유효한 회원등급번호가 아님에도 불구하고 INSERT가 됨
--------------------------------------------------------------------------------
/*
    * FOREIGN KEY(외래키) 제약조건
    다른 테이블에 존재하는 값만 들어와야 되는 특정 컬럼에 부여하는 제약조건
    --> 다른 테이블을 참조한다고 표현
    --> 주로 FOREIGN KEY 제약조건에 의해 테이블 간의 관계가 형성됨
    
    > 컬럼레벨 방식
        컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할 테이블명[(참조할 컬럼명)] - 생략 시 기본키로 자동으로 잡힘
    
    > 테이블레벨 방식
        [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할 테이블명[(참조할 컬럼명)]
        
    --> 참조할 컬럼명 생략 시 참조할 테이블에 PRIMARY KEY로 지정된 컬럼으로 매칭
*/
DROP TABLE MEM;

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE--(GRADE_CODE)-- 회원등급번호 같이 보관할 컬럼 / 컬럼레벨방식
    -- FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE 
);

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '손흥민', '남', NULL, NULL, NULL);
INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '황희찬', NULL, NULL, NULL, 10);
INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이강인', NULL, NULL, NULL, 40);
-- ORA-02291: integrity constraint (DDL.SYS_C007160) violated - parent key not found
-- PARENT KEY를 찾을 수 없다는 오류 발생

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이강인', NULL, NULL, NULL, 20);
INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '이승우', NULL, NULL, NULL, 10);

-- MEM_GRADE(부모테이블)-----|---------------------<----- MEM(자식테이블)

--> 이 때 부모테이블(MEM_GRADE)에서 데이터 값을 삭제할 경우 어떤 문제가 있을까
--> 데이터 삭제구문 : DELETE FROM 테이블명 WHERE 조건;
--> MEM_GRADE 테이블에서 10번 등급 삭제
DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = '10'; --**********
-- ORA-02292: integrity constraint (DDL.SYS_C007160) violated - child record found
-- > 자식테이블(MEM)에서 10이라는 값을 사용하고 있기 때문에 삭제가 안됨

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = '30';
--> 자식테이블에서 30이라는 값을 사용하고 있지 않기 때문에 삭제가 됨
-- 자식테이블에 이미 사용하고 있는 값이 있을 경우
--> 부모테이블로부터 무조건 삭제가 안되게 하는 "삭제제한" 옵션이 걸려있음

ROLLBACK;
--------------------------------------------------------------------------------
/*
    자식 테이블 생성 시 외래키 제약조건 부여할 때 삭제옵션 지정가능
    * 삭제옵션: 부모테이블의 데이터 삭제 시 그 데이터를 사용하고 있는 자식테이블의 값을
               어떻게 처리할건지
    - ON DELETE RESTRICTED(기본값): 삭제제한옵션으로, 자식데이터로 쓰이는 부모데이터는 삭제가 안되게끔
    - ON DELETE SET NULL: 부모데이터 삭제 시 해당 데이터를 쓰고 있는 자식데이터의 값을 NULL로 변경
    - ON DELETE CASCADE: 부모데이터 삭제 시 해당 데이터를 쓰고 있는 자식데이터도 같이 삭제시킴
*/

DROP TABLE MEM;

-- ON DELETE SET NULL
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL 
);

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '손흥민', '남', NULL, NULL, NULL);
INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '황희찬', NULL, NULL, NULL, 10);
INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이강인', NULL, NULL, NULL, 20);
INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '이승우', NULL, NULL, NULL, 10);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- MEM_GRADE의 GRADE_CODE 10 삭제 후 MEM의 황희찬과 이승우의 GRADE_ID의 값 NULL로 변경

ROLLBACK;

DROP TABLE MEM;

-- ON DELETE CASCADE
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE
);

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '손흥민', '남', NULL, NULL, NULL);
INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '황희찬', NULL, NULL, NULL, 10);
INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이강인', NULL, NULL, NULL, 20);
INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '이승우', NULL, NULL, NULL, 10);

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
-- MEM_GRADE의 GRADE_CODE 10 삭제 후 MEM의 황희찬과 이승우의 데이터도 삭제됨

--------------------------------------------------------------------------------
/*
    < DEFAULT 기본값 >
    컬럼을 선정하지 않고 INSERT 시 NULL이 아닌 기본값을 세팅해둘 수 있다
*/
DROP TABLE MEMBER;
-- 컬럼명 자료형 DEFAULT 기본값

CREATE TABLE MEMBER(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_NAME VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    ENROLL_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER VALUES(1, '손흥민', 20, '축구', '19/12/13');
INSERT INTO MEMBER VALUES(2, '황희찬', NULL, NULL, NULL);
INSERT INTO MEMBER VALUES(3, '이강인', NULL, DEFAULT, DEFAULT); -- 내가 설정한 DEFAULT 값으로 들어감

-- INSERT INTO 테이블명(컬럼명, 컬럼명) VALUES(값1, 값2);
-- NOT NULL인건 꼭 써야함

INSERT INTO MEMBER(MEM_NO, MEM_NAME) VALUES(4, '이승우');
-- 선택되지 않은 컬럼에는 기본적으로 NULL이 들어감 / 단, 해당 컬럼에 DEFAULT 값이 있을 경우 DEFAULT값이 들어감