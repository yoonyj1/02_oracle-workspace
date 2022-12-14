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


-- QUIZ3(JOIN 복슴)
 아래의 SQL구문은 부서별 월급합계가 15,000,000을 초과하는 부서를 조회한 것이다.
 그 결과가 올바르지 않다고 할 때 그 원인과 조치사항
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
WHERE SALARY > 15000000
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
--WHERE SALARY > 15000000 -- GROUP BY는 WHERE가 아닌 HAVING 이용
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > 15000000;


QUIZ 4
CREATE TABLE QUIZ4(
    QNO NUMBER PRIMARY KEY,
    QNAME VARCHAR2(10),
    SCORE NUMBER
);

INSERT INTO QUIZ4 VALUES(1, '퀴즈1번', 30);
INSERT INTO QUIZ4 VALUES(1, '퀴즈2번', 50);
-- 에러발생 이유


-- JOIN => DECODE
-- J7인 사원은 급여를 10% 인상
-- J6인 사원은 급여를 15% 인상

-- '21/09/28' 문자열 => '2021-09-28'로 바꾸기

-- '210908' 문자열 -> 2021년 9월 8일 로 바꾸기

-- 초급개발자 중급개발자 고급개발자
-- CASE WHEN
--------------------------------------------------------------------------------
-- 테이블 생성 관련해서 데이터 타입(CHAR와 VARCHAR2의 차이점): KEYWORD - 고정길이, 가변길이
-- 오라클 객체(SEQUENCE, VIEW) 각각 정의
 -- 1. SEQUENCE: 자동으로 순서를 정할 수 있는 숫자를 발생시켜주는 객체
 --               일정한 숫자만큼 늘어나게 설정할 수 있으며 기본값으로는 1씩 증가한다.
 --     [표현법] CREATE SEQUENCE 시퀀스명으로 생성하며 추가할 수 있는 옵션으로는 START WITH, INCREMENT BY, MAXVALUE, MINVALUE, CACHE|NOCACHE 등이 있으며
 --             NEXTVAL은 현재 시퀀스에서 정해진 값을 반환하며, CURRVAL은 마지막으로 실행된 NEXTVAL의 값을 반환한다.
 -- 2. VIEW: 가상의 논리테이블로 자주 사용하는 쿼리를 저장해둘 수 있는 객체
-- 제약조건 -> 뒤늦게 추가할 수 있는 ALTER문
/*PRIMARY KEY: ADD PRIMARY KEY(컬럼명)
    FOREIGN KEY: ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(컬럼명)] 
    UNIQUE:      ADD UNIQUE(컬럼명)
    CHECK:       ADD CHECK(컬럼에 대한 조건) 
    NOT NULL:    MODIFY 컬럼명 NOT NULL | NULL => NULL쓰면 NULL 허용
    */
-- DCL (GRANT, REVOKE)
    -- GRANT는 계정에 권한을 부여하는 구문으로 시스템 권한, 객체접근 권한을 부여할 수 있다.
    -- REVOKE는 부여한 권한을 회수하는 역할을 한다.
-- COMMIT, ROLLBACK 각각 뭔지
    --1. COMMIT은 DML문 사용 후 생기는 트랜젝션을 확정시키는 역할을 하며, COMMIT을 함으로써 데이터베이스에 저장이 된다.
    -- 2. ROLLBACK은 DML문 사용 후 생기는 트랜젝션에 있는 것을 취소하는 역할을 하며 마지막 COMMIT 이후에 생기는 트랜젝션의 시점으로 돌아간다.
    
----------------------------------------------------------------------------------

/*
1. DBMS가 뭔지

2. DDL문 종류

3. NUMBER 자료형에 뭐 올 수 있는지
정수 실수 등 숫자면 다 가능

4. CHAR(10) 의미

5. INNER JOIN

6. OUTTER JOIN

7. SUBSTR()

8. 테이블이 뭔지

9. ResultSet

10. UPPER()

11. MINUS, INTERSECT 의미

12. INITCAP()
 첫 글자만 대문자로 바꿔주는 함수
 
13. TRIM()

14. UNION / UNIONALL 차이

15. DECODE() 역할

16. CONCAT() <=> ||

17. ROLLUP()

18. RANK OVER() DENSE_RANK OVER()
*/