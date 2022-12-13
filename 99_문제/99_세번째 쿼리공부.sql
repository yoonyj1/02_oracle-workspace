-- 12/15

-- QUIZ 1
-- CREATE USER TEST IDENTIFIED BY 1234; 실행
-- User TEST이(가) 생성됐습니다.
-- 계정 생성만 하고 접속 => 에러

-- 오류 발생의 이유
-- 문제점: 계정 생성만 하고 접속권한을 주지 않았음
-- 조치사항: GRANT CONNECT, RESOURCE TO TEST;

-- QUIZ2 (JOIN)
CREATE TABLE TB_JOB(
    JOBCODE NUMBER PRIMARY KEY,
    JOBNAME VARCHAR2(10) NOT NULL
);

CREATE TABLE TB_EMP(
    EMPNO NUMBER PRIMARY KEY,
    EMPNAME VARCHAR2(10) NOT NULL,
    JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);

-- 위의 두 테이블이 있다는 가정하에 
-- 두 테이블 조인해서 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회하려 함
-- 이 때 실행한 SQL문
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB USING(JOBNO);
-- "TB_JOB"."JOBNO": invalid identifier 발생

-- 문제점: JOBNO테이블이 TB_EMP에는 존재하나 TB_JOB 테이블에는 존재하지 않기 때문에 USING을 사용하면 안됨
-- 조치
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
JOIN TB_JOB ON(JOBNO = JOBCODE);

--------------------------------------------------------------------------------
-- 테이블 생성 관련해서 데이터 타입(CHAR와 VARCHAR2의 차이점): KEYWORD - 고정길이, 가변길이
-- 오라클 객체(SEQUENCE, VIEW) 각각 정의
-- 제약조건 -> 뒤늦게 추가할 수 있는 ALTER문
-- DCL (GRANT, REVOKE)
-- COMMIT, ROLLBACK 각각 뭔지