


/*
여러줄 주석 : ctrl+shift+/
*/
-- 한줄주석 : ctrl + /

/*
 * DML (Data Manipulation Language) : 데이터 조작언어
 * : 테이블에 값을 검색(select), 삽입(insert), 수정(update), 삭제(delete)하는 구문
 * */
------------------------------------------------------------------

/*
 * (') 홑따옴표 : 문자열을 감싸주는 기호
 * (") 쌍따옴표 : 컬럼명 등을 감싸주는 기호
 * */

/*
 * <select>
 * 데이터 조회할 때 사용
 * >>result set:행들의 집합
   [표현법]
   select 조회하고자 하는 컬럼, 컬럼, ... 
   from 테이블명;
   
 *  * */
-- employee 테이블에 있는 모든 컬럼(*) 조회

select * 
from employee;

-- employee 테이블에서 사번, 이름, 급여 조회
select emp_id, emp_name, salary
from employee;

-- job테이블의 모든 컬럼 조회
select *
from job;

------------------- 실습문제 ----------------------
-- 1. job테이블에서 직급명만 조회
select job_name
from job;
-- 2. department.테이블에서 모든 컬럼 조회
select *
from department

-- 3. department테이블에서 테이블의 부서코드, 부서명 조회
select dept_id, dept_title
from department 

-- 4. employee 테이블에서 사번, 사원명, 이메일, 전화번호, 입사일, 급여 조회
select emp_id, emp_name, email, phone, hire_date, salary
from employee;

/*
 * <컬럼값을 통한 산술연산>
 * select절 컬럼명 작성 부분에 산술연산 쓸 수 있다.
 *  * */
-- employee 테이블에서 사원명, 사원의 연봉 조회
select emp_name, salary*12
from employee;

-- employee 에서 사원명, 보너스, 급여 조회
select emp_name, bonus, salary
from employee;

-- employee에서 사원명, 급여, 보너스, 연봉, 보너스가 포함된 연봉 조회
select emp_name, salary, bonus, salary*12, ((bonus*salary)+salary)*12
from employee;

-- employee에서 사원명, 입사일, 근무일수
-- date형식끼리 연산 가능 : +,-
-- 오늘 날짜 current_date
select emp_name, hire_date, current_date - hire_date
from employee;
------------------------------------------------------------
/*
 * <컬럼명에 별칭 지정하기>
 * 산술 연산시 컬럼명이 ?column? 으로 나옴. 이때 별칭을 부여하여 처리

 * [표현법]
 * 컬럼명 별칭 / 컬럼명 as 별칭 / 컬럼명 "별칭" / 컬럼명 as "별칭"
 * 
 * * 반드시 별칭에 쌍따옴표("")가 들어가야 할 때
 * -> 별칭에 띄어쓰기가 들어 있던지, 특수 문자가 포함되어 있는 경우
 *  * */

select emp_name, salary, bonus, salary*12 "연봉(원)", ((bonus*salary)+salary)*12 "총 소득"
from employee;
-----------------------------------------------
/*
 * <리터럴>
 * 임의로 지정한 문자열(')
 * 
 * select절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터 처럼 조회가능
 * 조회된 result set의 모든 행에 반복적으로 같이 출력
 * */

-- employee에 사번, 사원명, 급여 조회
select emp_id, emp_name, salary, '원' as 단위
from employee;

-------------------------------------------------------------------
/*
 * <연결 연산자 : ||>
 * 여러 컬럼값들을 마치 하나의 컬럼인 것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
 * 숫자를 그냥 결합하면 타입 에러
 * 숫자형을 문자로 명시적 변환(::text)
 * */
-- employee에서 사번, 이름, 급여를 하나의 컬럼으로 조회
select emp_id || emp_name || salary as idname
from employee;
-- 컬럼값과 리터럴을 연결
select emp_name || '의 월급은' || salary || '원 입니다' as salary
from employee; 
----------------------------------------------------------
/*
 * <distinct>
 * 컬럼에 중복된 값들을 한번씩만 표시하고자 할 때
 * */
-- employee 에서 직급코드 조회
select job_code from employee;
--위에서 중복 제거
select distinct job_code from employee;
--부서코드도 중복 제거
select distinct dept_code from employee;
-- distinct는 select절에 딱 한번만 기술할 수 있음.
-- dept_code, job_code가 쌍으로 되어있는 값의 중복제거
select distinct dept_code,job_code from employee;
------------------------------------------------------------

/*<where 절>
 * 조회하고자 하는 테이블로부터 특정 조건에 만족하는 데이터만 조회할 때
 * where절에 조건식을 씀
 * 조건식에는 다양한 연산자 사용 가능
 * 
 * [표현법]
 * select 컬럼, 컬럼, ... 
 * from 테이블명
 * where 조건식;
 * 
 * 비교연산자
 * >, <, >=, <=     ->대소비교
 * =                ->같은지 비교
 * !=, <>           ->같지 않은지 비교
 * */
-- employee에서 부서코드가 'D9'인 사원의 모든 컬럼 조회
select *
from employee 
where dept_code='D9'

-- employee에서 부서코드가 'd1'인 사원의 사원명, 급여, 부서코드 조회
select emp_name, salary, dept_code
from employee 
where dept_code='D1';

-- employee에서 부서코드가 'd1'이 아닌 사원의 사원명, 급여, 부서코드 조회
select emp_name, salary, dept_code
from employee 
where dept_code!='D1';

-- employee에서 급여가 400만원 이상인 사원의 사원명, 급여, 입사일 조회
select emp_name, salary, hire_date
from employee 
where salary >= 4000000;

-- employee에서 재직중인 사원들의 사번, 사원명, 입사일 조회
select emp_id, emp_name, hire_date, ent_yn
from employee 
where ent_yn = 'N';

-----------------------------실습문제---------------------------
-- 1.급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회
select emp_name,salary,hire_date, salary*12
from employee
where salary >= 3000000

-- 2. 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
select emp_name, salary, salary*12 연봉, dept_code 
from employee
where salary*12 >= 50000000

-- 3. 직급코드가 'j3'이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
select emp_id, emp_name, job_code, ent_yn
from employee 
where job_code <> 'J3'

--------------------------------------------------------------------
/*
 * <논리 연산자>
 * 여러개의 조건을 제시하고자 할 때
 * AND (~이면서 그리고)
 * OR (~이거나 또는)
 * */
-- 부서코드가 'D9'이면서 급여가 500만원 이상인 사원의 사원명, 부서코드, 급여 조회
select emp_name, dept_code, salary
from employee 
where dept_code = 'D9' and salary >= 5000000;

-- 부서코드가 'D6'이거나 급여가 300만원 이상인 사원의 사원명, 부서코드, 급여 조회 
select emp_name, dept_code, salary
from employee 
where dept_code = 'D6' OR salary >= 3000000;

-- 급여가 350만원 이상, 600만원 이하인 사원들의 사원명, 사번, 급여 조회
select emp_name, emp_id, salary
from employee  
where salary >= 3500000 and salary <= 6000000

------------------------------------------
/*
 * <between A and B>
 * 조건식에서 사용되는 구문으로 
 * ~이상 ~이하인 범위에 대한 조건을 제시할 때 사용되느 연산자
 * 
 * [표현법]
 * 비교대상컬럼 BETWEEN 하한값 AND 상한값
 * */

-- 급여가 350만원 이상, 600만원 이하인 사원들을 제외한 나머지 사원들의 사원명, 사번, 급여 조회
select emp_name, emp_id, salary
from employee  
where not salary between 3500000 and 6000000

-- 입사일이 '1990-01-01 ~ 2004-12-31'
select *
from employee  
where hire_date between '1990-01-01' and '2004-12-31'

--------------------------------------------------------------
/*
 * <LIKE>
 * 비교하고자 하는 컬럼값이 내가 제시한 특정 패턴에 만족하는 경우 조회
[표현법]
비교대상컬럼 LIKE '특정패턴' 
: '특정패턴'에는 와일드카드(%, _)로 쓸 수 있다.
 * % : 0글자 이상
 * EX) 비교대상컬럼 LIKE '문자%' -> 비교대상의 컬럼값이 '문자'로 시작되는 것 조회
 *     비교대상컬럼 LIKE '%문자' -> 비교대상의 컬럼값이 '문자'로 끝나는 것 조회
 *     비교대상컬럼 LIKE '%문자%' -> 비교대상의 컬럼값이 '문자'가 포함되어 있는것 조회
 * _ : 1글자
EX) 비교대상컬럼 LIKE '_문자' -> 비교대상의 컬럼값이 '문자'앞에 무조건 한글자가 올 경우
    비교대상컬럼 LIKE '__문자' -> 비교대상의 컬럼값이 '문자'앞에 무조건 두글자가 올 경우
    비교대상컬럼 LIKE '_문자_' -> 비교대상의 컬럼값이 '문자'앞에 무조건 한글자, 뒤에 한글자가 올 경우
 *  * */
-- 사원들 중 성이 전씨인 사원의 사원명, 급여, 입사일 조회
select emp_name, salary, hire_date
from employee  
where emp_name like '전%'

-- 사원 이름 중 '하'가 포함되어 있는 사원의 사번, 사원명, 전화번호 조회
select emp_id, emp_name, phone
from employee   
where emp_name like '%하%'

-- 사원 중 이름의 가운데에 '하'가 포함되어 있는 사원의 사번, 사원명, 이메일 조회
select emp_id, emp_name, email 
from employee 
where emp_name like '_하_'

-- 사원의 전화번호 3번째 자리가 1인 사원의 사번, 사원명, 전화번호, 이메일 조회
select emp_id, emp_name, phone, email 
from employee  
where phone like '__1%'

-- 이메일 중 _(언더바) 앞에 글자가 3글자인 사원들의 사번, 이름, 이메일 조회
select emp_id, emp_name, email 
from employee
where email like '____%'
  -- 와일드카드로 사용되는 문자와 컬럼값에 들어있는 문자가 동일하기 때문에 조회가 안됨
  -- >> 어떤것이 와일드카드이고 데이터 값인지 구분해줘야 함
  -- >> 데이터값으로 취급하고자 하는 값 앞에 나만의 와일드카드 (아무거나 숫자,문자,특수기호)를 넣어줌
  --    나만의 와일드카드를 escape에 등록

select emp_id, emp_name, email 
from employee
where email like '___$_%' escape '$'

-- 위의 사원을 제외한 사원들 조회
select emp_id, emp_name, email 
from employee
where not email like '___$_%' escape '$'

------------------------------ 실습문제 ----------------------------------
-- 1. employee에서 이름이 '연'으로 끝나는 사원들의 사번, 사원명, 입사일 조회
select emp_id, emp_name, hire_date
from employee 
where emp_name like '%연'

-- 2. employee에서 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
select emp_name, phone
from employee 
where not phone like '010%'

-- 3. employee에서 이름에 '하'가 포함되어 있고 급여가 240만원 이상인 사원의 사번, 사원명, 급여 조회
select emp_id, emp_name, salary
from employee 
where emp_name like '%하%' and salary >= 2400000

-- 4. department에서 해외영업부인 부서들의 부서코드, 부서명 조회
select dept_id, dept_title
from department
where dept_title like '%해외영업%'

---------------------------------------------------------
/*
 * <is null / is not null>
 * 컬럼값에 null이 있을 경우 null값 비교에 이용하는 연산자
 * */
-- employee 에서 보너스를 받지 않는 사원들의 사번, 이름, 급여, 보너스 조회
select emp_id, emp_name, salary, bonus  
from employee 
where bonus is null;

-- employee 에서 보너스를 받는 사원들의 사번, 이름, 급여, 보너스 조회
select emp_id, emp_name, salary, bonus  
from employee 
where bonus is not null;

-- employee에서 사수가 없는 사원의 사원명, 부서코드 조회
select emp_name, dept_code
from employee  
where manager_id is null

-- employee에서 부서배치를 받지 않았지만 보너스는 받는 사원들의 이름, 보너스, 부서코드 조회
select emp_name, bonus, dept_code
from employee  
where dept_code is null and bonus is not null

---------------------------------------------------------------------
/*
 * <in / not in>
 * in : 컬럼값이 내가 제시한 목록중에 일치하는 값이 있는 것만 조회
 * not in : 컬럼값이 내가 제시한 목록중에 일치하는 값을 제외한 나머지 조회
[표현법]
비교대상컬럼 in ('값1','값2','값3'..)
비교대상컬럼 not in ('값1','값2','값3'..)
 *  * */
-- employee에서 부서코드가 D6이거나 D8이거나 D5인 사원의 이름, 부서코드, 급여 조회
select emp_name, dept_code, salary
from employee 
where dept_code in ('D6','D8','D5')

-- employee에서 부서코드가 D6이거나 D8이거나 D5인 사원을 제외한 사원들의 이름, 부서코드, 급여 조회
select emp_name, dept_code, salary
from employee 
where dept_code not in ('D6','D8','D5')

-----------------------------------------------------------------------------
/*
 * <연산자 우선순위>
 * 1. ()
 * 2. 산술 연산자
 * 3. 연결 연산자
 * 4. 비교 연산자
 * 5. IS NULL / LIKE '패턴' / IN
 * 6. BETWEEN AND
 * 7. NOT(논리연산자)
 * 8. AND(논리연산자)
 * 9. OR(논리연산자)
 * */

-- 직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
select *
from employee  
where (job_code = 'J7' or JOB_CODE = 'J2')
and SALARY >=2000000



-------------------------- 실습문제------------------------
-- 1. 사수가 없고 부서배치도 받지 않은 사원들의 사원명, 사수사번, 부서코드 조회
select emp_name, emp_id, dept_code
from employee 
where manager_id is null and dept_code is null


-- 2. 연봉(보너스포함X)이 3000만원 이상이고 보너스를 받지 않은 사원들의 
--		사번, 사원명, 연봉, 보너스 조회
select emp_id, emp_name, salary*12, bonus 
from employee  
where salary*12 >= 30000000 and bonus is null


-- 3. 입사일이 1995-01-01 이상이고 부서배치를 받은 사원들의 
--		사번, 사원명, 입사일, 부서코드 조회
select emp_id, emp_name, hire_date, dept_code
from employee  
where hire_date >= '1995-01-01' and dept_code is not null


-- 4. 급여가 200만원 이상 500만원 이하고 입사일이 2001-01-01 이상이고 
--		보너스를 받지 않는 사원들의 사번, 사원명, 급여, 입사일, 보너스 조회
select emp_id, emp_name, salary, hire_date, bonus  
from employee  
where (salary between 2000000 and 5000000) and hire_date>='2001-01-01'and bonus is null


-- 5. 보너스포함 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 
--		사번, 사원명, 급여, 보너스포함연봉 조회 (별칭부여)
select emp_id, emp_name, salary, ((bonus*salary)+salary)*12
from employee 
where emp_name like '%하%' and bonus is not null

------------------------------- 종합 문제 ----------------------------------
-- 1. JOB테이블에서 모든 정보 조회
select *
from job

-- 2. JOB 테이블에서 직급 이름 조회
select job_name
from job 

-- 3. DEPARTMENT 테이블에서 모든 정보 조회
select *
from department

-- 4. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 고용일 조회
select emp_name, email, phone, hire_Date
from employee

-- 5. EMPLOYEE테이블의 고용일, 사원 이름, 월급 조회
select hire_date, emp_name, salary
from employee 

-- 6. EMPLOYEE테이블에서 이름, 연봉, 총수령액(보너스포함), 실수령액(총수령액 - (연봉*세금 3%)) 조회
select emp_name, salary, ((salary*bonus)+salary) as 총수령액, ((salary*bonus)+salary)-((salary*bonus)+salary)*12*0.03 as 실수령액
from employee


-- 7. EMPLOYEE테이블에서 JOB_CODE가 J1인 사원의 이름, 월급, 고용일, 연락처 조회
select emp_name, salary, hire_date, phone
from employee 
where job_code='J1'

-- 8. EMPLOYEE테이블에서 실수령액이 5천만원 이상인 사원의 이름, 월급, 실수령액, 고용일 조회
select emp_name, salary, hire_date
from employee 
where 

-- 9. EMPLOYEE테이블에 월급이 4000000이상이고 JOB_CODE가 J2인 사원의 전체 내용 조회
select *
from employee 
where salary >= 4000000 and job_code='J2'

-- 10. EMPLOYEE테이블에 DEPT_CODE가 D9이거나 D5인 사원 중 고용일이 02년 1월 1일보다 빠른 사원의 이름, 부서코드, 고용일 조회
select emp_name, dept_code, hire_date
from employee 
where (dept_code = 'D9' or dept_code ='D5') and hire_date < '2002-01-01'

-- 11. EMPLOYEE테이블에 고용일이 1990-01-01 ~ 2001-01-01인 사원의 전체 내용을 조회
select *
from employee 
where hire_date between '1990-01-01' and '2001-01-01'


-- 12. EMPLOYEE테이블에서 이름 끝이 '연'으로 끝나는 사원의 이름 조회
select emp_name
from employee 
where emp_name like '%연'

-- 13. EMPLOYEE테이블에서 전화번호 처음 3자리가 010이 아닌 사원의 이름, 전화번호를 조회
select emp_name, phone
from employee  
where phone not like '010%'

-- 14. EMPLOYEE테이블에서 메일주소 '_'의 앞이 4자이면서 DEPT_CODE가 D9 또는 D6이고 고용일이 1990-01-01 ~ 2000-12-01이고, 급여가 270만 이상인 사원의 전체를 조회
select *
from employee
where salary >= 2700000 and (hire_date between '1990-01-01'and '2000-12-01') and email like '____$_%' escape '$' and (dept_code = 'D9' or dept_code = 'D6') 
