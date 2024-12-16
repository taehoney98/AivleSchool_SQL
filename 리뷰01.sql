/*
제목: 리뷰01
작성: 김태헌
내용: 어제 배운 내용 복습
*/

-- 데이터베이스 연결
USE myshop2024;

-- 데이터베이스 확인
SELECT database();

-- 고객 정보
SELECT customer_name AS 이름,
	customer_id AS 번호,
    CASE WHEN gender ='M' THEN '남자'
		WHEN gender='F' THEN '여자'
        ELSE NULL END AS 성별, 
    CASE WHEN city ='서울' THEN '서울'
		ELSE '기타' END AS 지역 ,
    register_date AS 가입일, 
	coalesce(point, 10000 ) AS point
	FROM customer
    WHERE city IN ('서울','부산','대구','광주','인천')
		AND register_Date between '2023-01-01' AND '2023-12-31'
	ORDER BY 이름 ASC;
--