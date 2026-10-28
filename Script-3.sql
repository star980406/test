/* 
 * <함수 function>
 * 전달된 컬러값을 읽어들여 함수를 실행한 결과 반환
 * 
 * - 단일행 함수 : n개의 값을 읽어들여 n개의 결과를 반환( 매행마다 함수 실행) 
 * - 그룹 함수 : n개의 값을 읽어들여 1개의 결과를 반환(그룹별로 함수 실행)
 * 
 * >> select절에 단일행 함수와 그룹함수를 함께 사용할 수 없다.
 * >> 함수식을 기술할 수 있는 위치 : select절, where절, orderby절, having절
 * 
 */*/
 -----------------------------단일행 함수 ----------------------------
 --===============================================================
 --                         <문자처리 함수>
  --===============================================================
 /*
  * length / octet_length -> integer로 반환
  * 
  * length(컬럼명 | '문자열') : 해당 글자수 반환
  * octet_length(컬럼명 | '문자열') : 해당 문자열의 byte수 반환
  *  - 한글 : 1글자당 3byte / 영문, 숫자, 공백 : 1글자당 1byte
  * */
 
 select length('데이터베이스'), OCTET_LENGTH('데이터베이스');
 
 select length('postgreSQL'), OCTET_LENGTH('postgreSQL');
 
 select emp_name, length(emp_name), octet_length(emp_name)
        , email, length(email), OCTET_LENGTH(email)
 from employee;
 
 ------------------------------------------------------------------------
 /*
  * LEFT / RIGHT ('문자열',글자수) : 오른쪽 끝에서부터 지정한 개수만큼 문자열 반환
  * > 글자수에 음수를 넣으면 맨 뒤/앞의 글자수만큼 제외하고 나머지 전부
  * */
 
 select LEFT('databasepostgresql',4)
 
 select right('databasepostgresql',3)
 
select right('서울특별시', 3);

select right('databasepostgre',-8)  -- 맨앞 8글자 제외하고
 
select left('databasesql',-3)  -- 맨뒤 3글자 제외하고

select right('data',100)  -- 큰숫자 상관없음

select right('data',0)   -- 빈문자열 반환

------------------------------------------------------------------------------
/*
 * position / strpos : 문자열로부터 특정 문자의 시작위치(index)를 찾아서 반환(1부터시작)
 * 
 * */

select position('a' in 'database');
select strpos('database','a');
select position('a' in reverse('database'));    

select EMAIL
	   ,position('_' in EMAIL) as "_위치"
	   ,position('@' in EMAIL)as "@위치"
from employee;
--------------------------------------------------------------------------
/*
 * substr / substring : 문자열에서 특정 문자열을 추출
 * - substr('문자열',position, [length])
 *   > position : 문자열을 추출할 시작 위치 index
 *   > length : 추출할 문자 갯수(생략시 맨 끝까지 추출)
 * - substring('문자열', from position [for length])
 * */

select substr('databasesql', 9);
select substring('databasesql' from 5);

select substr('databasesql',5,4); 
select substring('databasesql' from 5 for 4);

select substr('databasesql', 3,6);
select substring('databasesql' from 3 for 6);

-- employee 테이블에서 주민번호에 성별만 추출하여 주민번호, 사원명, 성별 조회
select emp_no, emp_name, substr(emp_no,8,1) as 성별
from employee;

-- employee 테이블에서 여자 사원들만 사번, 사원명, 성별(1~4중 하나) 조회
select emp_id, emp_name, substr(emp_no,8,1) as 성별
from employee 
where substr(emp_no,8,1)='2' or substr(emp_no,8,1)='4'

-- employee 테이블에서 남자 사원들만 사번, 사원명, 성별(1~4중 하나) 조회
select emp_id, emp_name, substr(emp_no,8,1) as 성별
from employee 
where substr(emp_no,8,1) in ('1','3');


-- employee 테이블에서 email의 아이디만 추출하여 사원명, 이메일, 아이디 조회
select emp_name, email, substr(email,1,position('@' in email)-1)
from employee 
---------------------------------------------------------
/*
 * LPAD / RPAD : 문자열 조회할 때 길이를 맞춰 통일감있게 조회하고자 할 때 사용
 * LPAD / RPAD ('문자열',최종반환할 문자의 길이, [덧붙이고자하는 문자])
 * */
-- 20길이에 맞춰 EMAIL을 오른쪽 정렬로 출력

select emp_name, LPAD(EMAIL,30)  --덧붙이고자하는 문자 생략시 기본값 공백
from employee ;

select emp_name, LPAD(email, 25, '#')
from employee

select emp_name, RPAD(email, 25, '#')
from employee

-- EMPLOYEE 테이블에서 사번, 사원명, 주민번호 출력(주민번호는 123456-1****** 의 형식으로)

select emp_id, emp_name, rpad(substr(emp_no,1,8),14,'*')
from employee ;
select emp_id, emp_name, substr(emp_no,1,8) || '******' 주민번호 
from employee;

---------------------------------------------------------
/*
 * LTRIM / RTRIM : 문자열에서 특정 문자열 제거하고 반환
 * TRIM : 문자의 앞/뒤 양쪽에 있는 특정 문자들을 제거한 나머지 반환
 * LTRIM / RTRIM ('문자열', 제거하고자하는 문자)  -> 제거하고자하는 문자를 생략시 공백제거
 * TRIM ([LEADING|TRAILING|BOTH] 제거하고자하는 문자 FROM '문자열')
 * */

select LTRIM ('     TJOEUN     ') || '컴퓨터아카데미';
select LTRIM ('     TJOEUN     ') || '컴퓨터아카데미';

select LTRIM('datadatabase','data');
select LTRIM('bacabaadfsg','abc');
select LTRIM('4548gegwg14','0123456789');
select rTRIM('4548gegwg14','0123456789');
select trim('      tjoeun       ') || '컴퓨터아카데미';  --기본값, 양쪽제거

-- 방향 지정
select trim(leading 'a' from 'aaaabked1554faadfe');
select trim(trailing 'a' from 'aaaadkfj444aaa');
select trim(both 'a' from 'aaaadkfj444aaa');

----------------------------------------------------------------
/*
 * LOWER / UPPER / INITCAP : 문자열을 대소문자로 변환 및 단어의 앞글자만 대문자로 변환
 * LOWER('문자열')
 * */

select lower('DATABASE postgreSQL');
select upper('DATABASE postgreSQL');
select initcap('DATABASE postgreSQL');

----------------------------------------------------------------------
/*
 * concat : 문자열 두개를 하나로 합친 결과 반환
 * concat('문자열','문자열',...)
 * */

select concat('SQL','포스트그레');
select concat('PostgreSQL','데이터베이스','02-1234-3456');

select 'SQL' || '포스트그레';

---------------------------------------------------------------------
/*
 * REPLACE : 기존문자열을 새로운 문자열로 변경
 * 
 * [표현법]
 * REPLACE('문자열','기존문자열','바꿀문자열')
 * */

select emp_name, email, replace(email,'google.com','naver.com')
from employee;



 --===============================================================
 --                         <숫자처리 함수>
  --===============================================================

/*
 * ABS : 숫자의 절대값을 구해주는 함수
 * ABS(NUMBER)
 * */

select abs(-19);
select abs(-13.67);

--------------------------------------------------------------
/*
 * MOD / % : 나머지 값 반환
 * */
select mod(10,3);
select 10%3;      --postgre에서만 사용

-------------------------------------------------------------
/*
 * ROUND : 반올림한 결과 반환
 * [표현법]
 * ROUND(NUMBER, [위치])
 * */

select round(1234.56);
select round(12.34);

select round(1234.5678,2);
select round(1234.56, 4);

select round(1234.56,-2);

------------------------------------------------------------

/*
 * CEIL : 올림한 결과 반환
 * FLOOR : 내림한 결과 반환
 * */

select ceil(123.234);
select ceil(-123.234);

select floor(123.234);
select floor(-123.234);

------------------------------------------------------------------
/*
 * TRUNC : 버림
 * TRUNC(NUMBER, [위치])
 * */

select trunc(123.789);
select trunc(123.789,1);

select trunc(-123.789);
select trunc(125.456,-1);

 --===============================================================
 --                         <날짜처리 함수>
  --===============================================================
/*
 * current_date() : 시스템 날짜
 * now() : 시스템날짜와 시간
 * */
select current_date;
select now();

select emp_name, hire_date, current_date - hire_date 근무일수
from employee;

---------------------------------------------------------------------
/*
 * interval 'n MONTH' : 특정 날짜에 해당 숫자만큼 개월수를 더해 날짜를 리턴
 * */

select current_date + interval '1 month' 다음달;
select (current_date + interval '1 month')::date;

-- employee에서 사원명, 입사일, 입사 후 정직원된 날짜(6개월 후) 조회
select emp_name, hire_date, (hire_date + interval '6 month')::date as "정직원된 날짜"
from employee 

---------------------------------------------------------------------
/*
 * extract : 특정날짜로 부터 년|월|일 값을 추출하여 반환
 * extract(year from date) : 년도만 추출
 * extract(month from date) : 월만 추출
 * extract(day from date) : 일만 추출
 * */
-- employee에서 사원명, 입사년도, 입사월, 입사일 조회
select emp_name
		,EXTRACT(year from hire_date)::text as 입사년도
		,extract(month from hire_date) as 입사월
		,extract(day from hire_date) as 입사일
from employee;

 --===============================================================
 --                         <형 변환 함수>
  --===============================================================

/*
 * to_char : 숫자 또는 날짜를 문자로 변환
 * - 특정형식에 맞게 출력 가능
 * to_cahr(숫자|날짜, [포맷])
 * */
-------------------------- 숫자타입->문자타입 ------------
/*
 * 9 : 해당 자리의 숫자를 의미
 * 	- 값이 없을 경우 소수점 이상은 공백, 소수점 이하는 0표시
 * 0 : 해당 자리의 숫자를 의미
 * 	- 값이 없을 경우 0으로 표시
 * FM : 해당 자리에 값이 없을 경우 자리차지하지 않음
 * */
select to_char(1234,'948'), to_char(1234,'00000');
select to_char(123.45, '9999.999'), to_char(123.45,'00000.0000');
select to_char(0.12,'9.99'), to_char(0.12,'0.00');

select '\' || to_char(1234,'99,999');

select emp_name
		,'\' || to_char(salary,'999,999,999,999') as 급여
		, '\' || to_char(salary*12,'999,999,999,999') as 연봉
from employee;

select to_char(0.1000, '99990.999');

select to_char(123.456, 'FM9999.999')
		,to_char(1234.56, 'FM9990.99')
		,to_char(0.1000,'FM9990.999')
		,to_char(0.1000,'FM9999.999');
-- FML : L(LOCAL의 설정에 따라 통화 기호 나타냄)
select to_char(1234,'FML999,999');

--------------------------------날짜타입->문자타입------------------------
--대소문자 안가림
--요일만 대소문자 가림

select to_char(now(),'YYYY') as 년도4자리
		,to_char(now(), 'YY') as 년도2자리
		,to_char(now(),'MM') as 월
		,to_char(now(),'dd') as 일
		,to_char(now(),'DAY') as 요일
		,to_char(now(),'HH') as 시
		,to_char(now(),'MI') as 분
		,to_char(now(),'SS') as 초;

-- 시간
select to_char(now(),'am hh:mi:ss');   -- am or pm 어떤것들 쓰던 상관없음
select to_char(now(), 'hh12:mi:ss');   --12시간제
select to_char(now(), 'hh24:mi:ss');   --24시간제

-- 날짜
select to_char(now(),'YYYY-MM-DD DAY');
select to_char(now(), 'YYYY"년" MM"월" DD"일"')

-- EMPLOYEE에서 사원명, 입사일(형식 25-10-28) 조회
select emp_name, to_char(hire_date,'yy-mm-dd')
from employee


-- EMPLOYEE 에서 사원명, 입사년도(4자리), 입사월, 입사일 조회
select emp_name,to_char(hire_Date,'yyyy') as 입사년도,to_char(hire_Date,'mi') as 입사월,to_char(hire_Date,'dd') as 입사일
from employee

--------------------------------------------------------
/*
 * to_date : 문자열을 날짜로 변경
 * : 숫자를 바로 넣는 것은 허용하지 않음. 반드시 문자열로 넣어야 됨
 * 
 * to_date('문자열','포맷')
 * */
select to_date('261028', 'YYMMDD');
select to_date('261028 152850','YYMMDD HH24MISS');
   -- to_date() 함수 특성상 시간정보는 버려짐. 년월일만 출력
select to_date(20261028::text, 'YYYYMMDD');

---------------------------------------------------------------
/*
 * to_timestamp() : 문자열로 표현된 날짜와 시간을 포맷으로 변환
 * to_timestamp('문자열','포맷')
 * */
select to_timestamp('2026-10-28 15:12:30', 'YYYY-MM-DD HH24:MI:SS');
select to_timestamp('20261028151230', 'YYYYMMDDHH24MISS');
select to_timestamp('2026-10-28 pm 03:14','YYYY-MM-DD AM HH:MI');

-----------------------------------------문자->숫자-----------------
/*
 * to_number : 문자열을 숫자로 변환
 * */
select to_number('012341234', '999999999999');
select to_number('1,000,000', '999,999,999') + to_number('550000','999,999,999');

select '1000000'::integer + '550000'::integer;

 --===============================================================
 --                         <null 처리 함수>
  --===============================================================
/*
 * coalesce (컬럼, 해당컬럼값이 null일때 반환할 값)
 * */

-- employee에서 사원명, 보너스(null이면 0으로 출력)
select emp_name, coalesce(bonus,0)
from employee;

-- employee에서 사원명, 보너스포함 연봉
select emp_name, to_char((salary + salary*coalesce(bonus,0))*12,'FML999,999,999') as 연봉
from employee;

-- employee 에서 사원명, 부서코드(null이면 부서 없음), 입사일 조회
select emp_name, coalesce(dept_code,'부서없음'), hire_date
from employee

 --===============================================================
 --                         <선택 함수>
  --===============================================================
/*
 * case when then
 * ...
 * end
 * 
 * ex) 
 * case when 조건식1 then 결과값1
 *      when 조건식2 then 결과값2
 * 		...
 * 		else 결과값n
 * end
 * 
 * if-else문과 같음
 * */
-- employee 에서 급여가 350만원 미만이면 '초급', 350만원 이상 500만원 미만 이면 '중급', 500만원 이상이면 '고급'
select emp_name, salary
		,case when salary >= 5000000 then '고급'
		      when salary >= 3500000 then '중급'
		      else '초급'
		 end as 급수 
from employee ;

 --===============================================================
 --                         <그룹 함수>
  --===============================================================
/*
 * sum(숫자타입의컬럼) : 컬럼들의 총합계를 반환
 * */
-- employee에서 전사원의 총 급여의 합
select sum(salary) as 급여합계 from employee;

-- employee에서 남자 사원의 총 급여의 합
select sum(salary)
from employee
where substr(emp_no, 8, 1) in ('1','3');

-- employee에서 부서코드가 D5인 사원들의 총 연봉의 합
select sum(salary*12)
from employee 
where dept_code='D5';

select sum(salary*(1+coalesce(bonus,0)) * 12) as 연봉
from employee 
where dept_code='D5';


/*
 * avg(숫자타입의 컬럼) : 평균반환
 * */
select avg(salary) from employee;
select round(avg(salary),2) from employee;

/*
 * min / max (모든타입의 컬럼) : 최소값과 최대값
 * */
select min(emp_name), min(salary), min(hire_date) from employee;

select max(emp_name), max(salary), max(hire_date) from employee;

/*
 * count(* |컬럼|DISTINCT 컬럼) : 행 갯수 반환

 * count(*) : 조회된 결과의 모든 행의 갯수 반환
 * count(컬럼) : 컬럼의 값이 null인 것을 제외한 행의 갯수 반환
 * count(distinct 컬럼) : 중복을 제거한 행의 갯수 반환
 *  * */
-- employee의 전체 사원수
select count(*) from employee;

-- 보너스를 받는 사원의 수
select count(bonus) from employee;

-- 부서 배치를 받은 사원의 수
select count(dept_code) from employee;

-- 중복제거한 부서의 수
select count(distinct dept_code) from employee;

-- 여성 사원의 수
select count(substr(emp_no, 8, 1) in ('4','2')) from employee;


 --===============================================================
 --                         <postgreSQL 에서 형변환>
  --===============================================================

-- 숫자 자료형
::int or ::integer  -> 정수4byte
::numeric           -> 소수(정수)
::real              -> 실수4byte

-- 문자 자료형
::text              -> 길이제한이 없는 문자열
::varchar           -> 가변 길이 문자열
::varchar(n)        -> 가변 길이이지만 최대 n글자까지만 넣을 수 있음 
::char(n)           -> 고정길이 n길이만큼

-- 날짜 시간
::date              -> 날짜만 표시
::time              -> 시간만 표시
::timestamp         -> 날짜와 시간 표시
::interval          -> '1 month'::interval

-- 기타 자료형
::boolean           -> 참 거짓
::json              -> json 자료형     '{"age" : 25}'::json



------------------------------- 종합 문제 ----------------------------------
-- 1. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
select emp_name, substr(emp_no, 1, 2) 생년, substr(emp_no, 3, 2) 생월, substr(emp_no, 5, 2) 생일
from employee

-- 2. EMPLOYEE테이블에서 사원명, 주민번호 조회 (단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
select emp_name, substr(emp_no, 1, 6) || '******'
from employee 
-- 3. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--   (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)



-- 4. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회
select *
from employee 
where cast(emp_id as int) % 2 =1

-- 5. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회
SELECT *
FROM employee 
WHERE hire_date <= NOW() - INTERVAL '20 years';

-- 6. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)
SELECT emp_name, E'\\' || TO_CHAR(salary, 'FM999,999,999') AS salary
FROM employee;

-- 7. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이 조회
--   (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며 
--   나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
SELECT 
    emp_name,
    dept_code,
    TO_CHAR(TO_DATE(LEFT(emp_no, 6), 'YYMMDD'), 'YY"년 "MM"월 "DD"일"') AS birth_date,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, TO_DATE(LEFT(emp_no, 6), 'YYMMDD'))) AS age
FROM employee;


-- 8. EMPLOYEE테이블에서 부서코드가 D5, D6, D9인 사원만 조회하되 D5면 총무부
--   , D6면 기획부, D9면 영업부로 처리(EMP_ID, EMP_NAME, DEPT_CODE, 총무부)
--    (단, 부서코드 오름차순으로 정렬)
SELECT 
    emp_id,
    emp_name,
    dept_code,
    CASE dept_code
        WHEN 'D5' THEN '총무부'
        WHEN 'D6' THEN '기획부'
        WHEN 'D9' THEN '영업부'
    END AS dept_name
FROM employee 
WHERE dept_code IN ('D5', 'D6', 'D9')
ORDER BY dept_code ASC;


-- 9. EMPLOYEE테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT 
    SUM((salary + (salary * COALESCE(bonus, 0))) * 12) AS total_annual_salary
FROM employee 
WHERE dept_code = 'D5';

-- 10. EMPLOYEE테이블에서 직원들의 입사일로부터 년도만 가지고 각 년도별 입사 인원수 조회
--      전체 직원 수, 2001년, 2002년, 2003년, 2004년

SELECT 
    COUNT(*) AS 전체직원수,
    SUM(CASE WHEN EXTRACT(YEAR FROM hire_date) = 2001 THEN 1 ELSE 0 END) AS "2001년",
    SUM(CASE WHEN EXTRACT(YEAR FROM hire_date) = 2002 THEN 1 ELSE 0 END) AS "2002년",
    SUM(CASE WHEN EXTRACT(YEAR FROM hire_date) = 2003 THEN 1 ELSE 0 END) AS "2003년",
    SUM(CASE WHEN EXTRACT(YEAR FROM hire_date) = 2004 THEN 1 ELSE 0 END) AS "2004년"
FROM employee;












