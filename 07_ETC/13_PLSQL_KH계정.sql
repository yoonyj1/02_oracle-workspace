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