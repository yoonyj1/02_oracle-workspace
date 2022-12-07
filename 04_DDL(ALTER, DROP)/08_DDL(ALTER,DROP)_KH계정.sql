/*
    DDL (Data Definition Language): 데이터 정의 언어
    
    객체들을 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 구문
    
    < ALTER >
    객체를 변경하는 구문
    
    [표현식]
    ALTER TABLE 테이블명 변경할내용;
    
    * 변경할 내용
     1) 컬럼을 추가 / 수정 / 삭제
     2) 제약조건 추가 / 삭제 -> 수정은 불가능 (수정하고자 한다면 삭제한 후 새로 추가)
     3) 컬럼명 / 제약조건명 / 테이블명 변경
*/

-- 1) 컬럼을 추가 / 수정 / 삭제
-- 1-1) 컬럼 추가 (ADD): ADD 컬럼명 자료형 [DEFAULT 기본값] [CONSTRAINT 제약조건명] 제약조건
-- DEPT_COPY 테이블에 CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- 새로운 컬럼이 만들어지고 기본적으로 NULL로 채워짐

-- LNAME 컬럼 추가: VARCHAR2(20) / 기본값: 한국
ALTER TABLE DEPT_COPY ADD LNAME VARCHAR2(20) DEFAULT '한국';

-- 1-2) 컬럼 수정 (MODIFY)
--> 자료형 수정           : MODIFY 컬럼명 바꾸고자하는자료형
--> DEFAULT값 수정       : MODIFY 컬럼명 DEFAULT 바꾸고자하는 기본값

ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUBMER;
-- 오류 발생: 이미 데이터가 숫자가 아닌 것도 들어있음
-- 존재하는 데이터가 없어야만 이렇게 바꿀 수 있음

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10);
-- 오류 발생: 이미 담겨있는 데이터가 10바이트보다 큼

-- DEPT_TITLE 컬럼을 VARCHAR2(50)으로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(50);

-- LOCATION_ID 컬럼을 VARCHAR2(4)로 변경
ALTER TABLE DEPT_COPY MODIFY LOCATION_ID VARCHAR2(4);

-- LNAME 컬럼의 기본값을 '영국'으로 변경
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT '영국';
-- DEFAULT 값을 바꾼다고 해서 이전에 추가된 데이터가 바뀌는 것은 아님

-- 다중 변경 가능
ALTER TABLE DEPT_COPY
    MODIFY DEPT_TITLE VARCHAR2(40)
    MODIFY LOCATION_ID VARCHAR2(2)
    MODIFY LNAME DEFAULT '미국';
    
-- 1-3) 컬럼 삭제 (DROP COLUMN): DROP COLUMN 삭제하고자 하는 컬럼명
-- 삭제를 위한 복사본 테이블 생성
CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

-- DEPT_COPY2에서 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;

-- 다중 삭제 안됨
ALTER TABLE DEPT_COPY2
    DROP COLUMN DEPT_ID
    DROP COLUMN DEPT_TITLE;
    
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
-- 오류발생: 최소 한개의 테이블은 존재해야함.
