----------------------------------DDL-------------------------------------------
/* 1. 계열 정보를 저장할 카테고리 테이블을 만들려고 한다. 다음과 같은 테이블을
작성하시오.
테이블 이름
TB_CATEGORY
컬럼
NAME, VARCHAR2(10) 
USE_YN, CHAR(1), 기본값은 Y 가 들어가도록
*/
CREATE TABLE TB_CATEGORY(
    NAME VARCHAR2(10),
    USE_YN CHAR(1) DEFAULT 'Y'
);

/*2. 과목 구분을 저장할 테이블을 만들려고 한다. 다음과 같은 테이블을 작성하시오.
테이블이름
TB_CLASS_TYPE
컬럼
NO, VARCHAR2(5), PRIMARY KEY
NAME , VARCHAR2(10)*/
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY,
    NAME VARCHAR2(10)
);

/*3. TB_CATAGORY 테이블의 NAME 컬럼에 PRIMARY KEY 를 생성하시오.
(KEY 이름을 생성하지 않아도 무방함. 만일 KEY 이를 지정하고자 한다면 이름은 본인이
알아서 적당한 이름을 사용한다.)*/
ALTER TABLE TB_CATEGORY ADD PRIMARY KEY(NAME);

/*4. TB_CLASS_TYPE 테이블의 NAME 컬럼에 NULL 값이 들어가지 않도록 속성을 변경하시오*/
ALTER TABLE TB_CLASS_TYPE MODIFY NAME NOT NULL;

/*5. 두 테이블에서 컬럼 명이 NO 인 것은 기존 타입을 유지하면서 크기는 10 으로, 컬럼명이
NAME 인 것은 마찬가지로 기존 타입을 유지하면서 크기 20 으로 변경하시오.*/
ALTER TABLE TB_CLASS_TYPE MODIFY NO VARCHAR2(10);
ALTER TABLE TB_CLASS_TYPE MODIFY NAME VARCHAR2(20); 
ALTER TABLE TB_CATEGORY MODIFY NAME VARCHAR2(20);

/*6. 두 테이블의 NO 컬럼과 NAME 컬럼의 이름을 각 각 TB_ 를 제외한 테이블 이름이 앞에
붙은 형태로 변경한다.
(ex. CATEGORY_NAME)*/
ALTER TABLE TB_CATEGORY RENAME COLUMN NAME TO CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NO TO CLASS_TYPE_NO;
ALTER TABLE TB_CLASS_TYPE RENAME COLUMN NAME TO CLASS_TYPE_NAME;

/*7. TB_CATAGORY 테이블과 TB_CLASS_TYPE 테이블의 PRIMARY KEY 이름을 다음과 같이
변경하시오.
Primary Key 의 이름은 ?PK_ + 컬럼이름?으로 지정하시오. (ex. PK_CATEGORY_NAME )*/
ALTER TABLE TB_CATEGORY RENAME CONSTRAINT SYS_C007279 TO PK_CATEGORY_NAME;
ALTER TABLE TB_CLASS_TYPE RENAME CONSTRAINT SYS_C007278 TO PK_CLASS_TYPE_NO;

/*8. 다음과 같은 INSERT 문을 수행한다.
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT; */
INSERT INTO TB_CATEGORY VALUES ('공학','Y');
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y');
INSERT INTO TB_CATEGORY VALUES ('의학','Y');
INSERT INTO TB_CATEGORY VALUES ('예체능','Y');
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y');
COMMIT;


/*9.TB_DEPARTMENT 의 CATEGORY 컬럼이 TB_CATEGORY 테이블의 CATEGORY_NAME 컬럼을 부모
값으로 참조하도록 FOREIGN KEY 를 지정하시오. 이 때 KEY 이름은
FK_테이블이름_컬럼이름으로 지정한다. (ex. FK_DEPARTMENT_CATEGORY )*/
ALTER TABLE TB_DEPARTMENT ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

/*10. 춘 기술대학교 학생들의 정보만이 포함되어 있는 학생일반정보 VIEW 를 만들고자 핚다. 
아래 내용을 참고하여 적절한 SQL 문을 작성하시오.
뷰 이름
VW_학생일반정보
컬럼
학번
학생이름
주소*/
CREATE OR REPLACE VIEW VW_학생일반정보
AS (SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM TB_STUDENT);
    
GRANT CREATE VIEW TO workbook;

/*11. 춘 기술대학교는 1 년에 두 번씩 학과별로 학생과 지도교수가 지도 면담을 진행한다. 
이를 위해 사용할 학생이름, 학과이름, 담당교수이름 으로 구성되어 있는 VIEW 를 만드시오.
이때 지도 교수가 없는 학생이 있을 수 있음을 고려하시오 (단, 이 VIEW 는 단순 SELECT 
만을 할 경우 학과별로 정렬되어 화면에 보여지게 만드시오.)
뷰 이름
VW_지도면담
컬럼
학생이름
학과이름
지도교수이름*/
CREATE OR REPLACE VIEW VW_지도면담
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, NVL(PROFESSOR_NAME, '지도교수미지정') AS "지도교수"
    FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
    LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
    ORDER BY 2;
    
SELECT * FROM VW_지도면담;

/*12. 모든 학과의 학과별 학생 수를 확인할 수 있도록 적절한 VIEW 를 작성해 보자.
뷰 이름
VW_학과별학생수
컬럼
DEPARTMENT_NAME
STUDENT_COUNT*/
CREATE VIEW VW_학과별학생수
AS (SELECT DEPARTMENT_NAME, COUNT(STUDENT_NO) AS "STUDENT_COUNT"
    FROM TB_DEPARTMENT
    JOIN TB_STUDENT USING(DEPARTMENT_NO)
    GROUP BY DEPARTMENT_NAME);


/*13. 위에서 생성한 학생일반정보 View 를 통해서 학번이 A213046 인 학생의 이름을 본인
이름으로 변경하는 SQL 문을 작성하시오.*/
SELECT * FROM VW_학생일반정보;

UPDATE VW_학생일반정보
SET STUDENT_NAME = '윤여진'
WHERE STUDENT_NO = 'A213046';

ROLLBACK;

/*14. 13 번에서와 같이 VIEW 를 통해서 데이터가 변경될 수 있는 상황을 막으려면 VIEW 를
어떻게 생성해야 하는지 작성하시오.*/
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT  G.STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM TB_STUDENT S
    JOIN TB_GRADE G ON(S.STUDENT_NO = G.STUDENT_NO);
    
CREATE OR REPLACE VIEW VW_학생일반정보
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
    FROM TB_STUDENT S
    WITH READ ONLY;


/*15. 춘 기술대학교는 매년 수강신청 기간만 되면 특정 인기 과목들에 수강 신청이 몰려
문제가 되고 있다. 최근 3 년을 기준으로 수강인원이 가장 많았던 3 과목을 찾는 구문을
작성해보시오.
과목번호 과목이름 누적수강생수(명)
---------- ------------------------------ ----------------
C1753800 서어방언학 29
C1753400 서어문체론 23
C2454000 원예작물번식학특론 22*/
/*SELECT 과목이름, 누적수강생수(명)
FROM (
        SELECT CLASS_NO AS "과목번호", CLASS_NAME AS "과목이름", COUNT(STUDENT_NO) AS "누적수강생수(명)"
        FROM TB_CLASS C
        JOIN TB_GRADE G USING(CLASS_NO)
        WHERE TERM_NO LIKE '2009%' OR TERM_NO LIKE '2008%' OR TERM_NO LIKE '2007%'
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY 3 DESC
        );*/
        
/*SELECT V.과목번호
     , V.과목이름
     , V."누적수강생수(명)"
  FROM (SELECT C.CLASS_NO 과목번호
             , C.CLASS_NAME 과목이름
             , COUNT(*) "누적수강생수(명)"
          FROM TB_CLASS C
          JOIN (SELECT * FROM TB_GRADE
                WHERE SUBSTR(TERM_NO, 1, 4) IN ('2005', '2006', '2007', '2008', '2009')) G 
                ON(C.CLASS_NO = G.CLASS_NO)
         GROUP BY C.CLASS_NO, C.CLASS_NAME
         ORDER BY 3 DESC) V
 WHERE ROWNUM < 4;
 */         

SELECT *
FROM (SELECT CLASS_NO AS "과목번호", CLASS_NAME AS "과목이름", COUNT(STUDENT_NO) AS "누적수강생수(명)"
        FROM TB_CLASS 
        JOIN TB_GRADE USING(CLASS_NO)
        WHERE TERM_NO LIKE '2009%' OR TERM_NO LIKE '2008%' OR TERM_NO LIKE '2007%' OR TERM_NO LIKE '2006%' OR TERM_NO LIKE '2005%' 
        GROUP BY CLASS_NO, CLASS_NAME
        ORDER BY 3 DESC)
WHERE ROWNUM <= 3;

----------------------------------DML-------------------------------------------
/*1. 과목유형 테이블(TB_CLASS_TYPE)에 아래와 같은 데이터를 입력하시오.
번호, 유형이름
------------
01, 전공필수
02, 전공선택
03, 교양필수
04, 교양선택
05. 논문지도*/
INSERT INTO TB_CLASS_TYPE VALUES('01', '전공필수');
INSERT INTO TB_CLASS_TYPE VALUES('02', '전공선택');
INSERT INTO TB_CLASS_TYPE VALUES('03', '교양필수');
INSERT INTO TB_CLASS_TYPE VALUES('04', '교양선택');
INSERT INTO TB_CLASS_TYPE VALUES('05', '논문지도');
      
/*2. 춘 기술대학교 학생들의 정보가 포함되어 있는 학생일반정보 테이블을 만들고자 한다. 
아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (서브쿼리를 이용하시오)
테이블이름
TB_학생일반정보
컬럼
학번
학생이름
주소*/
CREATE TABLE TB_학생일반정보
AS (SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "학생이름", STUDENT_ADDRESS AS "주소"
    FROM TB_STUDENT);
    
/*3. 국어국문학과 학생들의 정보만이 포함되어 있는 학과정보 테이블을 만들고자 한다. 
아래 내용을 참고하여 적절한 SQL 문을 작성하시오. (힌트 : 방법은 다양함, 소신껏
작성하시오)
테이블이름
TB_국어국문학과
컬럼
학번
학생이름
출생년도 <= 네자리 년도로 표기
교수이름*/
-- 국어국문학과 학생들의 정보만 조회
SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "이름"
        , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)), 'YYYY') AS "출생년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '001';

-- 서브쿼리 이용해서 테이블 생성
CREATE TABLE TB_국어국문학과
AS (SELECT STUDENT_NO AS "학번", STUDENT_NAME AS "이름"
        , TO_CHAR(TO_DATE(SUBSTR(STUDENT_SSN, 1, 6)), 'YYYY') AS "출생년도"
    FROM TB_STUDENT
    WHERE DEPARTMENT_NO = '001');

/*4. 현 학과들의 정원을 10% 증가시키게 되었다. 이에 사용할 SQL 문을 작성하시오. (단, 
반올림을 사용하여 소수점 자릿수는 생기지 않도록 핚다)*/
UPDATE TB_DEPARTMENT 
SET CAPACITY = ROUND(CAPACITY * 1.1);

/*5. 학번 A413042 인 박건우 학생의 주소가 "서울시 종로구 숭인동 181-21 "로 변경되었다고
한다. 주소지를 정정하기 위해 사용할 SQL 문을 작성하시오.*/
-- 박건우 정보 조회
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE STUDENT_NO = 'A413042';

UPDATE TB_STUDENT
SET STUDENT_ADDRESS = '서울시 종로구 숭인동 181-21' --경기도 파주시 적성면 장현2리 산65번지
WHERE STUDENT_NO = 'A413042';

/*6. 주민등록번호 보호법에 따라 학생정보 테이블에서 주민번호 뒷자리를 저장하지 않기로
결정하였다. 이 내용을 반영할 적절한 SQL 문장을 작성하시오.
(예. 830530-2124663 ==> 830530 )*/
UPDATE TB_STUDENT
SET STUDENT_SSN = SUBSTR(STUDENT_SSN, 1, 6);

/*7. 의학과 김명훈 학생은 2005 년 1 학기에 자신이 수강한 '피부생리학' 점수가
잘못되었다는 것을 발견하고는 정정을 요청하였다. 담당 교수의 확인 받은 결과 해당
과목의 학점을 3.5 로 변경키로 결정되었다. 적절한 SQL 문을 작성하시오.*/
-- 의학과 김명훈 학번 조회
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE STUDENT_NAME = '김명훈';
--A331101

-- 김명훈 2005년 1학기 피부생리학 CLAS_NO조회
SELECT TERM_NO, CLASS_NO, CLASS_NAME, POINT
FROM TB_GRADE G
JOIN TB_CLASS C USING(CLASS_NO)
WHERE CLASS_NAME = '피부생리학' AND STUDENT_NO = 'A331101';
--C3843900

-- 수정
UPDATE TB_GRADE
SET POINT = 3.5 --1.5
WHERE STUDENT_NO = 'A331101' AND CLASS_NO = 'C3843900';

/*8. 성적 테이블(TB_GRADE) 에서 휴학생들의 성적항목을 제거하시오.*/
DELETE FROM TB_GRADE
WHERE STUDENT_NO IN (SELECT STUDENT_NO
                      FROM TB_STUDENT
                      WHERE ABSENCE_YN = 'Y');
                      
                      ROLLBACK;
                      
            