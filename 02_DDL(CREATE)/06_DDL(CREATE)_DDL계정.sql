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