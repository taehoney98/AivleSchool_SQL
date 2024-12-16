/*
제목: 데이터 기본 조회(2)
작성: 이장래
내용: 기본적인 데이터 조회 방법 학습
*/

USE hrdb2024;
SELECT DATABASE();

/*
7. 범위 조건과 리스트 조건
*/

-- 급여가 5,000~8,000 사이인 직원 정보 조회
SELECT emp_name, emp_id, dept_id, hire_date, phone, salary
	FROM employee
	WHERE salary BETWEEN 5000 AND 8000;

-- SYS, MKT, GEN 부서 직원 정보 조회
SELECT emp_name, emp_id, dept_id, hire_date, phone
	FROM employee
	WHERE dept_id IN ('SYS', 'MKT', 'GEN');
    
-- 2020년에 입사한 직원 정보 조회
SELECT emp_name, emp_id, dept_id, hire_date, phone
	FROM employee
	WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 2019년도에 입사한 정보시스템, 영업팀 직원 정보 조회
SELECT emp_name, emp_id, dept_id, hire_date, phone
	FROM employee
	WHERE (dept_id  = 'SYS' OR 'MKT')  
    AND hire_date BETWEEN '2019-01-01' AND '2019-12-31';


-- Q) 2019년도에 입사한 연봉이 6,000 이상인 근무중인 직원 정보 조회

SELECT *
	FROM employee
	WHERE hire_date BETWEEN '2019-01-01' AND '2019-12-31'
    AND salary >=6000
    AND retire_date IS  NULL;

-- Q) 홍길동(S0001), 강우동(S0003), 오삼식(S0005)의 2019년 휴가 정보 조회

SELECT * 
	FROM vacation
    WHERE emp_id in ('S0001' , 'S0002' , 'S0003')  AND  YEAR(begin_date)=2019;

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
 
/*
8. NULL 값 비교
*/

-- 근무 중인 직원 정보 조회 (?)
SELECT emp_name, emp_id, gender, dept_id, hire_date, retire_date, phone
	FROM employee
	WHERE retire_date = 'NULL';

-- 근무 중인 직원 정보 조회 (?)
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date = NULL;

-- 근무 중인 직원 정보 조회 (!)
SELECT emp_name, emp_id, gender, dept_id, hire_date, retire_date, phone
	FROM employee
	WHERE retire_date IS NULL;
    
-- 퇴사한 직원 정보 조회
SELECT emp_name, emp_id, gender, dept_id, hire_date, retire_date, phone
	FROM employee
	WHERE retire_date IS NOT NULL;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 본부에 속하지 않은 부서 정보 조회

SELECT * 
	FROM employee
    WHERE dept_id IS NOT NULL;

-- Q) 영어 이름이 없는 근무 중인 직원 정보 조회
SELECT *
	FROM employee
    WHERE eng_name IS NULL and retire_date is null ;

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --


/*
9. IFNULL() 함수
*/

-- IFNULL 함수 사용 전
SELECT emp_name, emp_id, eng_name, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;

-- IFNULL 함수 사용: eng_name 열 값이 NULL이면 공백 표시
SELECT emp_name, emp_id, IFNULL(eng_name, ''), gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;

-- IFNULL 함수 결과에 별칭 사용
SELECT emp_name, emp_id, IFNULL(eng_name, '') AS eng_name, gender, dept_id, hire_date
	FROM employee
	WHERE retire_date IS NULL;

-- COALESCE(a,b,c,d ...)
-- COALESCE() 함수 사용 나열된 값 중에 첫번째 NULL 이 아닌 값
SELECT emp_name, emp_id, COALESCE(eng_name, '') AS eng_name, gender, dept_id, hire_date
	FROM employee
	WHERE retire_date IS NULL;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) retire_date 열 값이 NULL이면 9999-12-31로 표시해서 직원 정보 조회

SELECT emp_name, emp_id, eng_name , gender, dept_id , hire_date ,COALESCE (retire_date, '9999-12-31') AS retire_date
	FROM employee;

-- Q) salary열 값이 NULL이면 0으로 표시해서 근무 중인 여직원 정보 조회

SELECT  emp_name, emp_id, eng_name , gender, dept_id , hire_date , coalesce(salary ,'0') AS salary
	FROM employee
    WHERE gender= 'F' AND retire_date IS NULL;
    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --


/*
9. 자동 형 변환
*/

-- 자동 형 변환
SELECT '10' + '20';
SELECT 10 + '20'; 
SELECT 10 + '20AX';
SELECT 10 + 'LX20';

-- 문자열 데이터 결합
SELECT CONCAT('10', '20');
SELECT CONCAT(10, '20');
SELECT CONCAT(10, 20);
SELECT CONCAT(10, NULL);


/*
10. 데이터 결합
*/

SELECT CONCAT(emp_name, '(', emp_id, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- 문자와 숫자 결합
SELECT CONCAT(emp_name, '(', salary, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- 문자와 날짜 결합
SELECT CONCAT(emp_name, '(', hire_date, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL과 결합하면?
SELECT CONCAT(emp_name, '(', eng_name, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL 값 처리 #1
SELECT CONCAT(emp_name, '(', IFNULL(eng_name, ''), ')') AS emp_name, dept_id, gender, 
       hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL 값 처리 #2
SELECT CONCAT(emp_name, IFNULL(CONCAT('(', eng_name, ')'), '')) AS emp_name, dept_id, gender, 
       hire_date, email
	FROM employee
	WHERE retire_date IS NULL;
    

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 사원번호와 부서코드를 묶어서(예: S0001(SYS)) 근무 중인 직원 정보 조회
SELECT concat(emp_id , '(', IFNULL(dept_id, ''), ')')  AS emp_name
	FROM employee
    WHERE retire_date IS NULL;

 
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
  
    
/*
11. 데이터 정렬
*/

-- 오름차순: 1, 2, 3, 4 (ASC)
-- 내림차순: 4, 3, 2, 1 (DESC)

-- 이름을 기준으로 오름차순 정렬
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY emp_name ASC;

-- 이름을 기준으로 내림차순 정렬
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY emp_name ASC;

-- 부서코드를 기준으로 오름차순, 이름을 기준으로 내림차순 정렬
SELECT dept_id, emp_name, emp_id, gender, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY dept_id ASC, emp_name DESC;

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 연봉이 높은 순으로 정렬해서 근무 중인 직원 정보 조회
SELECT * 
	FROM employee
    WHERE  retire_date IS NULL
    ORDER BY salary DESC;


-- Q) 최근 입사자가 먼저 조회되도록 정렬해서 근무 중인 직원 정보 조회

SELECT *
	FROM employee
    WHERE retire_date IS NULL
    ORDER BY hire_date DESC;
    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
  
-- IFNULL() vs COALESCE()
 
SELECT emp_id, score03, score02 , score01
	FROM toeic;
 


SELECT emp_id, IFNULL(score03, score02 , score01) AS score -- 변수에 2개 밖에
	FROM toeic; -- 실행 불가

SELECT emp_id, score03, score02 , score01 , coalesce(score03, score02 , score01) AS score
	FROM toeic; -- 첫번째로 NULL이 아닌 값을 변수의 개수와 상관없이 산출 가능
/*
12. CASE 문
*/

-- 직원 정보 조회
SELECT emp_name, emp_id, gender, hire_date, salary
	FROM employee;

-- 성별: M, F --> 남자, 여자
SELECT emp_name, emp_id, 
       CASE WHEN gender = 'M' THEN '남자'
            WHEN gender = 'F' THEN '여자'
            ELSE '' END AS gender, 
	   hire_date, retire_date, salary
	FROM employee;

-- 다른 방법(추천하지 않음)
SELECT emp_name, emp_id, 
       CASE gender WHEN 'M' THEN '남자'
                   WHEN 'F' THEN '여자'
                   ELSE '' END AS gender, 
	   hire_date, retire_date, salary
	FROM employee;
    
-- 근무 상태를 근무, 퇴사로 표시
SELECT emp_name, emp_id, gender, hire_date, salary,
       CASE WHEN retire_date IS NULL THEN '근무'
            ELSE '퇴사' END AS status
	FROM employee;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) 부서 코드가 SYS이면 전화번호를 공백으로 해서 근무 중인 직원 조회


    
-- Q) 급여 크기를 상, 중, 하로 구분해서 근무 중인 직원 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
     
     
/*
13. IF 함수
*/

-- 성별: M, F --> 남자, 여자 (단, gender 열에 M, F 만 입력 된다고 가정함)
SELECT emp_name, emp_id, 
       IF(gender = 'M', '남자', '여자') AS gender, 
	   hire_date, retire_date, salary
	FROM employee;

-- 성별: M, F --> 남자, 여자 (IF 함수 중첩해서 사용)
SELECT emp_name, emp_id, 
       IF(gender = 'M', '남자', IF(gender = 'F', '여자', '')) AS gender, 
	   hire_date, retire_date, salary
	FROM employee;
    
-- 근무 상태를 근무, 퇴사로 표시
SELECT emp_name, emp_id, gender, hire_date, salary,
       IF(retire_date IS NULL,  '근무', '퇴사') AS status
	FROM employee;

-- 영어 이름이 NULL이면 공백 표시
SELECT emp_name, emp_id, 
       IF(eng_name IS NULL, '', eng_name) AS eng_name,
       gender, hire_date, salary
	FROM employee;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) 부서 코드가 SYS이면 전화번호를 공백으로 해서 근무 중인 직원 조회

    
    
-- Q) 급여 크기를 상, 중, 하로 구분해서 근무 중인 직원 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --   