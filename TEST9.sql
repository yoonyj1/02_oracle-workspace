-- 테이블 생성 전 DROP
DROP TABLE COOKING_ORDER_IMG;
DROP TABLE TB_COOKING_ORDER;
DROP TABLE TB_INGREDIENT;
DROP TABLE TB_SAUCE;
DROP TABLE TB_COMMENT;
DROP TABLE TB_REVIEW;
DROP TABLE TB_RECIPE;

-- 테이블 생성 (TB_RECIPE)
CREATE TABLE TB_RECIPE (
        RECIPE_NO VARCHAR2(10) CONSTRAINT RECIPE_PK PRIMARY KEY,
        RECIPE_NAME VARCHAR2(100) CONSTRAINT RECIPE_NM_NN NOT NULL,
        RECIPE_TAG VARCHAR2(100) CONSTRAINT RECIPE_TAG_NN NOT NULL,
        RECIPE_VIDEO VARCHAR2(300),
        RECIPE_DIFFICULTY CHAR(3) CHECK(RECIPE_DIFFICULTY IN ('상', '중', '하')) NOT NULL,
        RECIPE_PERSON NUMBER CONSTRAINT RECIPE_PERSON_NN NOT NULL,
        RECIPE_TIME NUMBER CONSTRAINT RECIPE_TIME_NN NOT NULL,
        RECIPE_DATE DATE DEFAULT SYSDATE NOT NULL,
        RECIPE_WRITER VARCHAR2(60) CONSTRAINT RECIPE_WRITER_NN NOT NULL,
        RECIPE_PIC VARCHAR2(300) CONSTRAINT RECIPE_PIC_NN NOT NULL,
        RECIPE_VIEWS NUMBER DEFAULT 0 CONSTRAINT RECIPE_VIEWS_NN NOT NULL);
        
-- 테이블 생성(TB_COOKING_ORDER)
CREATE TABLE TB_COOKING_ORDER (
    CO_NO VARCHAR2(10) CONSTRAINT CO_NO_PK PRIMARY KEY,
    RECIPE_NO VARCHAR2(10) REFERENCES TB_RECIPE,
    CO_STEP  VARCHAR2(10) CONSTRAINT CO_STEP_NN NOT NULL,
    CO_CONTENT VARCHAR2(300) CONSTRAINT CONTENT_NN NOT NULL);
    
-- 테이블 생성(TB_INGREDIENT)
CREATE TABLE TB_INGREDIENT (
    INGRE_NO VARCHAR2(10) CONSTRAINT INGRE_NO_PK PRIMARY KEY,
    RECIPE_NO VARCHAR2(10) REFERENCES TB_RECIPE,
    INGRE_NAME VARCHAR2(60) CONSTRAINT INGRE_NAME_NN NOT NULL,
    INGRE_AMOUNT VARCHAR2(30) CONSTRAINT INGRE_AMOUNT_NN NOT NULL);
    
-- 테이블 생성(TB_SAUCE)
CREATE TABLE TB_SAUCE (
    SAUCE_NO VARCHAR2(30) CONSTRAINT SAUCE_NO_PK PRIMARY KEY,
    RECIPE_NO VARCHAR2(10) REFERENCES TB_RECIPE,
    SAUCE_NAME VARCHAR2(60) DEFAULT '양념' CONSTRAINT SAUCE_NAME_NN NOT NULL);

-- 테이블 생성(TB_SAUCE_INGRE)
CREATE TABLE TB_SAUCE_INGRE (
    SAUCE_INGRE_NO VARCHAR2(10) CONSTRAINT SI_PK PRIMARY KEY,
    SAUCE_NO VARCHAR2(30) REFERENCES TB_SAUCE,
    RECIPE_NO VARCHAR2(10) REFERENCES TB_RECIPE,
    SAUCE_INGRE_NAME VARCHAR2(60) CONSTRAINT SIN_NN NOT NULL,
    SAUCE_INGRE_AMOUNT VARCHAR2(30) CONSTRAINT SIA_NN NOT NULL);

-- 테이블 생성 (TB_COMMENT)
CREATE TABLE TB_COMMENT (
    COM_NO VARCHAR2(10) CONSTRAINT COM_NO_PK PRIMARY KEY,
    RECIPE_NO VARCHAR2(10) REFERENCES TB_RECIPE,
    COM_CONTENT VARCHAR2(300) CONSTRAINT COM_CONTENT_NN NOT NULL,
    COM_AUTHOR VARCHAR2(60) CONSTRAINT COM_AUTHOR_NN NOT NULL,
    COM_DATE DATE DEFAULT SYSDATE);
    
-- 테이블 생성(TB_REVIEW)
CREATE TABLE TB_REVIEW (
    REV_NO VARCHAR2(10) CONSTRAINT REV_NO_PK PRIMARY KEY,
    RECIPE_NO VARCHAR2(10) REFERENCES TB_RECIPE,
    REV_CONTENT VARCHAR2(1000) CONSTRAINT REV_CONTENT_NN NOT NULL,
    REV_IMG VARCHAR2(300) CONSTRAINT REV_IMG_NN NOT NULL,
    REV_AUTHOR VARCHAR2(60) CONSTRAINT REV_AUTHOR_NN NOT NULL,
    REV_DATE DATE DEFAULT SYSDATE);
    
-- 테이블 생성 (TB_COOKING_ORDER_IMG)
CREATE TABLE TB_COOKING_ORDER_IMG (
    CO_NO VARCHAR2(10) REFERENCES TB_COOKING_ORDER,
    ORDIMG_IMGURL VARCHAR2(300) CONSTRAINT ORDIMG_NN NOT NULL);
    
-- 주석
-- TB_RECIPE
COMMENT ON COLUMN TB_RECIPE.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_RECIPE.RECIPE_NAME IS '글제목';
COMMENT ON COLUMN TB_RECIPE.RECIPE_TAG IS '태그';
COMMENT ON COLUMN TB_RECIPE.RECIPE_VIDEO IS '비디오';
COMMENT ON COLUMN TB_RECIPE.RECIPE_DIFFICULTY IS '난이도';
COMMENT ON COLUMN TB_RECIPE.RECIPE_PERSON IS '인분';
COMMENT ON COLUMN TB_RECIPE.RECIPE_TIME IS '소요시간';
COMMENT ON COLUMN TB_RECIPE.RECIPE_DATE IS '작성일';
COMMENT ON COLUMN TB_RECIPE.RECIPE_WRITER IS '작성자';
COMMENT ON COLUMN TB_RECIPE.RECIPE_PIC IS '대표사진';
COMMENT ON COLUMN TB_RECIPE.RECIPE_VIEWS IS '조회수';

-- TB_COOKING_ORDER
COMMENT ON COLUMN TB_COOKING_ORDER.CO_NO IS '요리순서번호';
COMMENT ON COLUMN TB_COOKING_ORDER.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_COOKING_ORDER.CO_STEP IS '조리순서';
COMMENT ON COLUMN TB_COOKING_ORDER.CO_CONTENT IS '내용';

-- TB_COOKING_ORDER_IMG
COMMENT ON COLUMN TB_COOKING_ORDER_IMG.CO_NO IS '요리순서번호';
COMMENT ON COLUMN TB_COOKING_ORDER_IMG.ORDIMG_IMGURL IS '이미지경로';

-- TB_INGREDIENT
COMMENT ON COLUMN TB_INGREDIENT.INGRE_NO IS '요리순서번호';
COMMENT ON COLUMN TB_INGREDIENT.INGRE_NAME IS '재료명';
COMMENT ON COLUMN TB_INGREDIENT.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_INGREDIENT.INGRE_AMOUNT IS '양';

-- TB_SAUCE
COMMENT ON COLUMN TB_SAUCE.SAUCE_NO IS '양념번호';
COMMENT ON COLUMN TB_SAUCE.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_SAUCE.SAUCE_NAME IS '양념이름';

-- TB_COMMENT
COMMENT ON COLUMN TB_COMMENT.COM_NO IS '댓글번호';
COMMENT ON COLUMN TB_COMMENT.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_COMMENT.COM_CONTENT IS '댓글내용';
COMMENT ON COLUMN TB_COMMENT.COM_AUTHOR IS '작성자';
COMMENT ON COLUMN TB_COMMENT.COM_DATE IS '작성일';

-- TB_REVIEW
COMMENT ON COLUMN TB_REVIEW.REV_NO IS '후기번호';
COMMENT ON COLUMN TB_REVIEW.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_REVIEW.REV_CONTENT IS '후기내용';
COMMENT ON COLUMN TB_REVIEW.REV_IMG IS '사진';
COMMENT ON COLUMN TB_REVIEW.REV_AUTHOR IS '작성자';
COMMENT ON COLUMN TB_REVIEW.REV_DATE IS '작성일';

-- TB_SAUCE_INGRE
COMMENT ON COLUMN TB_SAUCE_INGRE.SAUCE_INGRE_NO IS '양념재료번호';
COMMENT ON COLUMN TB_SAUCE_INGRE.SAUCE_NO IS '양념번호'; 
COMMENT ON COLUMN TB_SAUCE_INGRE.RECIPE_NO IS '게시글번호';
COMMENT ON COLUMN TB_SAUCE_INGRE.SAUCE_INGRE_NAME IS '양념재료명';
COMMENT ON COLUMN TB_SAUCE_INGRE.SAUCE_INGRE_AMOUNT IS '양';
   
-- 시퀀스 생성 전 DROP
DROP SEQUENCE SEQ_SI_NO;
DROP SEQUENCE SEQ_SAUCE_NO;
DROP SEQUENCE SEQ_INGRE_NO;
DROP SEQUENCE SEQ_REV_NO;
DROP SEQUENCE SEQ_COM_NO;
DROP SEQUENCE SEQ_CO_NO;
DROP SEQUENCE SEQ_RECIPE_NO;

-- 시퀀스 생성 - 레시피 게시글 번호(SEQ_RECIPE_NO)
CREATE SEQUENCE SEQ_RECIPE_NO;

-- 시퀀스 생성 - 요리순서번호(SEQ_CO_NO)
CREATE SEQUENCE SEQ_CO_NO;

--  시퀀스 생성 - 댓글 번호(SEQ_COM_NO)
CREATE SEQUENCE SEQ_COM_NO;

-- 시퀀스 생성 - 후기 번호(SEQ_REV_NO)
CREATE SEQUENCE SEQ_REV_NO;

-- 시퀀스 생성 - 재료번호(SEQ_INGRE_NO)
CREATE SEQUENCE SEQ_INGRE_NO;

-- 시퀀스 생성 - 양념 번호(SEQ_SAUCE_NO)
CREATE SEQUENCE SEQ_SAUCE_NO;

-- 시퀀스 생성 - 양념재료 번호(SEQ_SI_NO)
CREATE SEQUENCE SEQ_SI_NO;

-- 데이터 입력(TB_RECIPE 1번 게시글)
INSERT INTO TB_RECIPE 
VALUES('R' || SEQ_RECIPE_NO.NEXTVAL, '대파 닭꼬치', '#닭, #꼬치, #매콤', NULL, '중', 3, 30, DEFAULT, 'USER01', 'C:\Users\PC\Desktop\KH\semi/logo.png', DEFAULT);

-- 1번 게시글 재료 & 양념 & 양념재료
INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '닭다리살', 500);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL,  'R' || SEQ_RECIPE_NO.CURRVAL, '대파', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '기름', '약간');

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '석쇠', 1);

INSERT INTO TB_SAUCE
VALUES('S' || SEQ_SAUCE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '데리야끼소스');

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '간장', 4);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '청주', 4);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '미림', 4);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '설탕', 4);

INSERT INTO TB_SAUCE
VALUES('S' || SEQ_SAUCE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '닭다리살양념');

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '간장', 2);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '생강가루', '약간');

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '청주나 소주', 2);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '설탕', 1);

-- 1번 게시글 요리순서 & 요리순서이미지
INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '닭다리살은 1개당 4~5등분으로 자르고 밑간 재료에 20분 정도 재워주세요.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/01/04/3ee2dea8fe7ef8c4bc73bd73c0bf22821.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '대파는 3센치 길이로 썰어주세요. 볼에 양념 재료를 넣고 섞어주세요.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/01/04/ecf1eec4a22cddfa5431781e68f160d51.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '닭고기와 대파를 꼬치에 번갈아 가며 끼운 후 양념을 발라주세요.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/01/04/3c4287eb7ec9dd421dc4833ed816b60f1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '구이 전용 팬에 닭 꼬치를 올린 후 4단에 넣고 광파오븐 자동 요리 <구이>에서 <닭 꼬치>를 선택한 후 500g을 선택해 구워주세요. 도중에 멜로디가 울리면 한번 뒤집어 주세요.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/01/04/2e6da04b035e5534c5921fdb5a182e9d1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '완성된 닭 꼬치에 송송 썬 쪽파를 뿌려  맛있게 즐겨주세요.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/01/04/55b38017928250fada34014dec0239ae1.jpg');

-- 1번 게시글 댓글
INSERT INTO TB_COMMENT
VALUES('COM' || SEQ_COM_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '맛있어보이네요! 주말에 해보겠습니다', 'USER02', SYSDATE);

-- 1번 게시글 후기
INSERT INTO TB_REVIEW
VALUES('RE' || SEQ_REV_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '쉽게 따라할 수 있고 아이들이 좋아하네요! 찜할게요!', 'https://recipe1.ezmember.co.kr/cache/review/2017/07/13/926a2d5f7363b849adf5b564793aae22.jpg', 'USER03', SYSDATE);

-- 데이터 입력(TB_RECIPE 2번 게시글)
INSERT INTO TB_RECIPE 
VALUES('R' || SEQ_RECIPE_NO.NEXTVAL, '비엔나 만두 강정', '#간단, #만두', 'https://youtu.be/y4aImV_6dQc', '하', 2, 15, DEFAULT, 'USER02', 'C:\Users\PC\Desktop\KH\semi/mainpic.png', DEFAULT);

-- 2번 게시글 재료 & 양념 & 양념재료
INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '만두(교자만두/물만두)', 10);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '비엔나소세지', 1);

INSERT INTO TB_SAUCE
VALUES('S' || SEQ_SAUCE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, DEFAULT);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '물', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '간장', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '고추장', 2);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '케찹', 2);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '올리고당', 1.5);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '다진마늘', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '참기름', '약간');

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '깨', '약간');

-- 2번 게시글 요리순서 & 요리순서이미지
INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '만두는 기름을 두룬 팬에 노릇하게 구워줍니다.   ');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/09/28/8fc533297f2fc246cbbf5f2fd1c8dfc21.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '비엔나 소세지에 원하는 모양대로 칼집을 내고 팬에 볶아줍니다. 양파가 있다면 같이 볶아줘도 좋아요:)');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/09/28/199b0d79568471660afcb5a4ac07b3171.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '비엔나가 어느정도 구워지면 만두를 같이 넣어줍니다.   ');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/09/28/04feae556dcd5899ef67ffb89e051fb51.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '양념장을 넣고 양념이 고루 베이도록 잘 섞어줍니다');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/09/28/05e4e16467b13cc29ffa7c1d07e8cc911.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '양념이 어느정도 베이면 위에 통깨를 뿌려 마무리합니다.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/09/28/61da0ef87e2a754dc739eb177c3395341.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '간식이나 술안주, 밑반찬으로 먹기 좋은 비엔나만두강정 완성!');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/09/28/83c2df92a39da5d4ab9e238b8722b72a1.jpg');

-- 2번 게시글 댓글
INSERT INTO TB_COMMENT
VALUES('COM' || SEQ_COM_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '정신없이 하다가 사진을 안찍었네요! 다음에도 또 해볼게요', 'USER03', SYSDATE);

-- 2번 게시글 후기
INSERT INTO TB_REVIEW
VALUES('RE' || SEQ_REV_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '아침에 간단하게 만들기 좋은 반찬요리인것 같아요!', 'https://recipe1.ezmember.co.kr/cache/review/2020/09/09/2f565264dcc287547f9e95ecc009e9871.jpg', 'USER04', SYSDATE);

-- 데이터 입력(TB_RECIPE 3번 게시글)
INSERT INTO TB_RECIPE 
VALUES('R' || SEQ_RECIPE_NO.NEXTVAL, '추운 날 속 뜨끈 한 1000원 김치 콩나물 국', '#얼큰, #칼칼, #겨울', NULL, '중', 2, 10, DEFAULT, 'USER03', 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/15/780d9d434e922fb4993e4984e6fb52561.jpg', DEFAULT);

-- 3번 게시글 재료 & 양념 & 양념재료
INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '콩나물', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '신김치', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '파', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '청양고추', 2);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '물', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '멸치다시마육수팩', 1);

INSERT INTO TB_SAUCE
VALUES('S' || SEQ_SAUCE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, DEFAULT);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '다진마늘', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '고춧가루', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '국간장', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '참치액젓', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '김치국물', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '소금', '적당량');

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '후추', '약간');

-- 3번 게시글 요리순서 & 요리순서이미지
INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '콩나물은 잘 씻어서 채에 받쳐주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/cfa6ad0536338d0a8a0ab964b125ac611.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '물 1리터를 넣고 다시팩을 넣어 육수를 내주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/2917c38e66c28258c81e0dea59c2651c1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '그 사이 김치를 송송 썰어주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/e01428ff48ccaa00b1e29e34413c0f961.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '물이 끓어오르면 다시팩을 건져 버려주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/2cdd812d69e1f4a4d109de023b41b44f1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '송송썬 김치와 김치국물 1국자를 넣어주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/bb393a55546a7767d64344a99e5aeef61.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '다진마늘도 넣어주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/09ddb86fa43da9629b2251b0344950fc1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '참치액 1큰술 + 국간장 1큰술+ 고추가루 1큰술을 넣어 끓여주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/f3fa9fe524839f00a910d154d838e7531.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '거품을 건져 버려주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/c36d04e66a8e46dc3d26c6927dbd9a7c1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '끓어오르면 씻어 놓은 콩나물을 넣어주세요 막 끓어오르면 간을 봐 주시고 싱거우면 소금을 넣어 입맛에 맞게 간을 해주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/a0d0ec36fb5b9c8fb93d9026efc0d0201.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '고추는 먹을 때 불편해서 두 동강이 내서 국물만 내주고 건져주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/01/31/39e4f894500af7e01cae963db7967acc1.jpg');

-- 3번 게시글 댓글
INSERT INTO TB_COMMENT
VALUES('COM' || SEQ_COM_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '해장으로 완벽하네요..', 'USER04', SYSDATE);

-- 3번 게시글 후기
INSERT INTO TB_REVIEW
VALUES('RE' || SEQ_REV_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '간단하고 종종 해먹기 좋은것같아요^^', 'https://recipe1.ezmember.co.kr/cache/recipe/2017/08/30/2ac5cab916566dbe2a5a673a372423111_m.jpg', 'USER01', SYSDATE);

-- 데이터 입력(TB_RECIPE 4번 게시글)
INSERT INTO TB_RECIPE 
VALUES('R' || SEQ_RECIPE_NO.NEXTVAL, '오랜만에 집에 온 아들을 위한 쇠고기스테이크', '#소고기, #스테이크', NULL, '하', 2, 15, DEFAULT, 'USER04', 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/ed10f757c71a440ab502066d5e12784b1.jpg', DEFAULT);

-- 4번 게시글 재료 & 양념 & 양념재료
INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '쇠고기', 400);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '파프리카', '1/2');

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '딸기', 3);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '미나리', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '후추', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '새송이버섯', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '양파', '1/2');

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '허브솔트', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '소금', 1);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '올리브유', 2);

-- 4번 게시글 요리순서 & 요리순서이미지
INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '쇠고기는 칼끝으로 힘줄을 끊어주고 새송이버섯, 파프리카, 양파는 먹기 좋은 크기로 썰어둔다.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/d9173b2113b4528c037d0d2fe5a044901.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '식용유를 두르고 썰어둔 채소를 넣고 허브솔트로 간을 한 후 노릇하게 구워준다.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/45af706b00b803598c45d77c2b0bc3411.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '고기에 올리브유, 허브솔트를 뿌려둔다.   ');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/a5c5b37a1bb79f459fe7da2ad527f0371.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '프라이팬에 올려 구워준다.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/17fd748c1956b89f43805af4729431ec1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '구워둔 채소와 스테이크를 담아준다.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/0fe662825ef57c4378b325672e9ab8c41.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '딸기, 미나리를 올려 마무리한다.');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2023/02/03/b8761cd81822f12a618ef3ff1cfac19e1.jpg');

-- 4번 게시글 댓글
INSERT INTO TB_COMMENT
VALUES('COM' || SEQ_COM_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '맛있네요!!!!', 'USER05', SYSDATE);

-- 4번 게시글 후기
INSERT INTO TB_REVIEW
VALUES('RE' || SEQ_REV_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '반찬으로도 좋고 안주로도 좋네요!', 'https://recipe1.ezmember.co.kr/cache/recipe/2018/10/24/fd75db19796b172643d3a6d9136700801_m.jpg', 'USER02', SYSDATE);

-- 데이터 입력(TB_RECIPE 5번 게시글)
INSERT INTO TB_RECIPE 
VALUES('R' || SEQ_RECIPE_NO.NEXTVAL, '【10분만에 고급진 요리】파프리카소고기말이', '#초간단, #소고기', NULL, '상', 2, 30, DEFAULT, 'USER05', 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/9765639935fc28e17b598a9c4f93ca1a1.jpg', DEFAULT);

-- 5번 게시글 재료 & 양념 & 양념재료
INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '얇게 썬 소고기', 6);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '깻잎', 6);

INSERT INTO TB_INGREDIENT
VALUES('I' || SEQ_INGRE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL,  '파프리카(색깔별로)', '1/3');

INSERT INTO TB_SAUCE
VALUES('S' || SEQ_SAUCE_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, DEFAULT);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '간장', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '물', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '식초', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '설탕', 1);

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '소금', '6번톡톡');

INSERT INTO TB_SAUCE_INGRE
VALUES('SI' || SEQ_SI_NO.NEXTVAL, 'S' || SEQ_SAUCE_NO.CURRVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '후추', '6번톡톡');

-- 5번 게시글 요리순서 & 요리순서이미지
INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '(6개 기준입니다)소고기는 얇게썬 불고기용으로 6장 준비 해주시구요~고기가 녹으면 키친타올로 살짝살짝 핏물을 닦아 주셔요~고기 하나당 후추,소금 한번씩만 톡 해서 살짝만 밑간을 해주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/cb8d0d829b947d0daa7b192cdb636aa01.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '파프리카 색깔별로 1/3쪽씩 채썰어 주시구요 깻잎6장 씻어서 준비해주세요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/f090c38a1365f29c57f0f7787034ac0b1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '해동된 소고기는 밑에 깔고 깻잎올려 파프리카를 색깔별로 올려');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/f9fe79fd49ba77487f8093ba7ba310271.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '깻잎부터 돌돌말고 소고기를 말아 주세요~');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/c93329adb20c910d1254e9235a608abb1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '말아진 부분이 풀리지 않게 밑으로 가게끔 두시구요');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/13ecd786640db87799fc57d74888235c1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '구우실때도 풀리지않게 말아진 끝부분 부터 구워 주세요~');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/5791c838196f0bb18ef68a1ee0d68eb11.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '식용유 살짝 둘러 약불로 고기만 익으면 끝이에요^~^');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/7fdfbb0846d45c1a994fd67a3d73f2ed1.jpg');

INSERT INTO TB_COOKING_ORDER
VALUES('CO' || SEQ_CO_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, 'CO' || SEQ_CO_NO.CURRVAL, '구워진 소고기말이는 어슷썰어 주시면 완성입니다^~^');

INSERT INTO TB_COOKING_ORDER_IMG
VALUES('CO' || SEQ_CO_NO.CURRVAL, 'https://recipe1.ezmember.co.kr/cache/recipe/2017/04/24/564d7f329cb7a81f18cd3c7a5c49c1461.jpg');

-- 5번 게시글 댓글
INSERT INTO TB_COMMENT
VALUES('COM' || SEQ_COM_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '따라하기 좋고 굳이네요~', 'USER01', SYSDATE);

-- 5번 게시글 후기
INSERT INTO TB_REVIEW
VALUES('RE' || SEQ_REV_NO.NEXTVAL, 'R' || SEQ_RECIPE_NO.CURRVAL, '너무 맛있게 잘 해먹었어요 아들이 혼자 2인분을 뚝딱 ㅎㅎ 거자소스에 양파채썰어서 하니까 느끼한 맛도 잡아주고 좋았어요 감사합니다  ', 'https://recipe1.ezmember.co.kr/cache/review/2021/01/30/ca7698f165a9f2bcf4d4f80c359894361.jpg', 'USER03', SYSDATE);