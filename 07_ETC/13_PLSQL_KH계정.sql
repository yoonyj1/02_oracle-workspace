/*
    < PL / SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL(프로시져)
    
    오라클 자체에 내장되어있는 절차적 언어
    SQL 문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP, FOR, WHILE)등을 지원하여 SQL의 단점을 보완
    다수의 SQL문을 한번에 실행 가능(BLOCK 구조) + 예외처리
    
    * PL / SQL 구조
    - [선언부]: DECLARE로 시작, 변수나 상수를 선언 및 초기화하는 부분
    - 실행부: BEGIN으로 시작, 무조건 있어야함, SQL문 또는 제어문(조건문, 반복문) 등의 로직을 기술하는 부분
    - [예외처리부]: EXCEPTION으로 시작, 예외의 발생 시 해결하기 위한 구문을 미리 기술해둘 수 있는 구문
*/

-- 간단하게 화면에 HELLO ORACLE 출력
SET SERVEROUTPUT ON;
-- 화면에 출력을 할 수 있게하는 명령문(한번만 실행하면 됨)

BEGIN
  -- System.out.println("HELLO ORACLE");
  DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/
-- 블럭을 구분해주는 역할을 하는 /

--------------------------------------------------------------------------------

/*
    1. DECLARE 선언부
    변수 및 상수 선언하는 공간 (선언과 동시에 초기화 가능)
    일반타입 변수, 레퍼런스타입 변수, ROW타입 변수
    
    1_1) 일반타입 변수 선언 및 초기화
        [표현식] 변수명 [CONSTANT -> 상수로 만들 경우] 자료형 [:= 값]
                             선언                        초기화
*/

DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;
    
BEGIN
    --EID := 800;
    --ENAME := '가나다';
    EID := &번호;
    ENAME := '&이름';
    
    DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI: ' || PI);
    
END;
/
--------------------------------------------------------------------------------
-- 1_2) 레퍼런스 타입 변수 선언 및 초기화(어떤 테이블의 어떤 컬럼의 데이터 타입을 참조해서 그 타입으로 지정)
-- [표현식] 변수명 테이블명.컬럼명%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    
BEGIN
    --EID := '300';
    --ENAME := '윤여진';
    --SAL := 1234567;
    
    -- 사번이 200번인 사원의 사번, 사원명, 급여 조회해서 각 변수에 대입
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL
    FROM EMPLOYEE
    --WHERE EMP_ID = 200;
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL: ' || SAL);
    
END;
/

------------------------------ 실습문제 ------------------------------------------
/*
    레퍼런스 타입 변수로 EID, ENAME, SAL, DTITLE을 선언하고
    각 자료형이 EMPLOYEE, DEPARTMENT 테이블들을 참조하도록
    
    사용자가 입력한 사번의 사원의 사번, 사원명, 직급코드, 급여, 부서명 조회 한 후 각 변수에 담아 출력
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('EID: ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('JCODE: ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('SAL: ' || SAL);
    DBMS_OUTPUT.PUT_LINE('DTITLE: ' || DTITLE);
    
END;
/
--------------------------------------------------------------------------------
-- 1_3) ROW타입 변수 선언
-- 테이블의 한 행에 대한 모든 컬럼값을 한꺼번에 담을 수 있는 변수
-- [표현식] 변수명 테이블명%ROWTYPE;

DECLARE
    E EMPLOYEE%ROWTYPE;
    
BEGIN
    SELECT * -- ROWTYPE일 경우 필수로 모든 컬럼의 값을 담아야함
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    -- DBMS_OUTPUT.PUT_LINE(E); 
    DBMS_OUTPUT.PUT_LINE('사원명: ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여: ' || E.SALARY);
    DBMS_OUTPUT.PUT_LINE('보너스: ' || NVL(E.BONUS, 0));
                                        -- NVL 사용가능
END;
/
--------------------------------------------------------------------------------

/*
    2. BEGIN 실행부
*/

-- < 조건문 >
-- 1) IF 조건식 THEN 실행내용 END IF; (단독 IF문)

-- 사번 입력 받은 후 해당 사원의 사번, 이름, 급여, 보너스율(%) 출력
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.' 출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번: ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여: ' || SALARY);
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('보너스율: ' || BONUS * 100 || '%'); 
    
END;
/

-- 2. IF 조건식 THEN 실행내용 ELSE 실행내용 END IF; (≒ 자바에서 IF-ELSE 문)
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
    
BEGIN
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번: ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여: ' || SALARY);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율: ' || BONUS * 100 || '%');
    END IF;
    
END;
/

------------------------------ 실습문제 ------------------------------------------
-- 레퍼런스타입의 변수(EID, ENAME, DTITLE, NCODE)
-- 참조테이블 EMPLOYEE, DEPARTMENT, LOCATION
-- 일반타입 변수 TEAM 문자형10바이트 <= '국내팀' OR '해외팀'
-- 사용자가 입력한 사번의 사원의 사번, 이름, 부서명, 근무국가코드 조회 후 각 변수에 대입
-- NCODE의 값이 KO일 경우 TEAM 변수에 '국내팀' 아닐 경우 '해외팀'
-- 사번, 이름, 부서, 소속(국내팀, 해외팀)에 대해 출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(10);
    
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO' 
        THEN TEAM := '국내팀';
    ELSE
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번: ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름: ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명: ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속: ' || TEAM);
  
END;
/