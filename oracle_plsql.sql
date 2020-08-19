SET SERVEROUTPUT ON
-------------------------------------------------------------------------------
-- single line comment

/*
	multiple line comment
*/


-------------------------------------------------------------------------------
create table rahul_emp as select * from emp
create table rahul_dept as select * from dept
alter table rahul_emp add primary key(empno)
alter table rahul_dept add primary key(deptno)
alter table rahul_emp add foreign key(deptno) references rahul_dept(deptno)

desc rahul_emp
desc rahul_dept
-------------------------------------------------------------------------------

declare
	msal number(9,2);
	mename varchar2(20);
begin
	 select ename , sal into mename,msal from rahul_emp
	 where empno=7900;
	 dbms_output.put_line(' the salary of employee '||mename||' is '||msal);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	 

-------------------------------------------------------------------------------

declare
	dname varchar2(20);
begin
	 select dname into dname from rahul_dept
	 where deptno=40;
	 dbms_output.put_line(' the dept name is '||dname);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	 

-------------------------------------------------------------------------------
%type for type of a variable
-------------------------------------------------------------------------------

declare
	dname rahul_dept.dname%type;
begin
	 select dname into dname from rahul_dept
	 where deptno=40;
	 dbms_output.put_line(' the dept name is '||dname);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	 

----------------------------------------------------------------------------------
combined 1 & 2 
----------------------------------------------------------------------------------


declare
	msal number(9,2);
	mename varchar2(20);
	deptno rahul_emp.deptno%type;
	dcount number(4);
begin
	 select ename , sal,deptno into mename,msal,deptno from rahul_emp
	 where empno=7900;
	 select count(*) into dcount from rahul_dept
	 where deptno=deptno;
	 dbms_output.put_line(' the salary of employee '||mename||' is '||msal);
	 dbms_output.put_line(' the total department count is '||dcount);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	 

-------------------------------------------------------------------------------------
%rowtype for complete row into 
-------------------------------------------------------------------------------------
declare
	mrec rahul_emp%rowtype;
begin
	 select * into mrec from rahul_emp
	 where empno=7900;
	 dbms_output.put_line(' the salary of employee '||mrec.ename||' is '||mrec.sal ||' job= '||mrec.job);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	
 
-------------------------------------------------------------------------------------
taking input in plsql 
-------------------------------------------------------------------------------------
declare
	mrec rahul_emp%rowtype;
begin
	 select * into mrec from rahul_emp
	 where empno=&input;
	 dbms_output.put_line(' the salary of employee '||mrec.ename||' is '||mrec.sal ||' job= '||mrec.job);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	
-------------------------------------------------------------------------------------
taking input in plsql for a varchar requires single quotes in where 
-------------------------------------------------------------------------------------
declare
	mrec rahul_emp%rowtype;
begin
	 select * into mrec from rahul_emp
	 where ename = '&input';
	 dbms_output.put_line(' the salary of employee '||mrec.ename||' is '||mrec.sal ||' job= '||mrec.job);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;
-------------------------------------------------------------------------------------
taking input in plsql for a varchar requires single quotes in where , making input to upper case
-------------------------------------------------------------------------------------
declare
	mrec rahul_emp%rowtype;
begin
	 select * into mrec from rahul_emp
	 where ename = upper('&input');
	 dbms_output.put_line(' the salary of employee '||mrec.ename||' is '||mrec.sal ||' job= '||mrec.job);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	
-------------------------------------------------------------------------------------
control statement if ,elsif, else, end if
-------------------------------------------------------------------------------------
declare
	mrec rahul_emp%rowtype;
	mempno rahul_emp.EMPNO%type;
	service_years number;
begin
	 mempno:=&empNoInput;
	 select * into mrec from rahul_emp where empno = mempno;
	 service_years:=trunc(months_between(sysdate,mrec.hiredate)/12);
	 
	 if service_years >25 then
	 	mrec.sal:=mrec.sal+(mrec.sal*.2);
	 elsif service_years >23 then
	 	mrec.sal:=mrec.sal+(mrec.sal*.15);
	 else	
		mrec.sal:=mrec.sal+(mrec.sal*.02);
	 end if;	
	 
	 dbms_output.put_line(' the reveised salary of employee '||mrec.ename||' is '||mrec.sal ||' job= '||mrec.job);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	
 
-------------------------------------------------------------------------------------
excersise on if elsif else
-------------------------------------------------------------------------------------
 
declare
	mrec rahul_emp%rowtype;
	mempno rahul_emp.EMPNO%type;
begin
	 mempno:=&empNoInput;
	 select * into mrec from rahul_emp where empno = mempno;
	 if mrec.sal >4500 then
	 	mrec.sal:=mrec.sal+(mrec.sal*.30);
	 elsif mrec.sal >2500 and mrec.sal <=4500then
	 	mrec.sal:=mrec.sal+(mrec.sal*.20);
	 else
		mrec.sal:=mrec.sal+(mrec.sal*.10);
	 end if;	
	 dbms_output.put_line(' the reveised salary with bonus of employee '||mrec.ename||' is '||mrec.sal ||' job= '||mrec.job);
exception
     when no_data_found then
	 dbms_output.put_line('no such employee found');
end;	
 	
-------------------------------------------------------------------------------------
loops
-------------------------------------------------------------------------------------
declare
    i number;
begin
	 i:=0;
	loop
		 dbms_output.put_line(i);
		exit when i=5;
		i:=i+1;
	end loop;
exception
     when no_data_found then
	 dbms_output.put_line('error');
end;	
 
-------------------------------------------------------------------------------------
blocks within blocks
-------------------------------------------------------------------------------------
declare
    x number:=100;
begin
	 declare
	 	x number :=500;
	 begin
	 	x:=1000;
		dbms_output.put_line('value of x of inner block is '||x);
	 end inner_block;
		dbms_output.put_line('value of x of outer block is '||x);		
end;	
-------------------------------------------------------------------------------------
same nested blocks with label
-------------------------------------------------------------------------------------
<<outer_block>>
declare
    x number:=100;
begin
	 <<inner_block>>
	 declare
	 	x number :=500;
	 begin
	 	x:=1000;
		dbms_output.put_line('value of x of inner block is '||x);
	 end inner_block;
		dbms_output.put_line('value of x of outer block is '||x);		
end;	
 -------------------------------------------------------------------------------------
with outer_block.x and inner_block.x
-------------------------------------------------------------------------------------
<<outer_block>>
declare
    x number:=100;
begin
	 <<inner_block>>
	 declare
	 	x number :=500;
	 begin
	 	x:=1000;
		dbms_output.put_line('value of x of inner block is '||outer_block.x);
	 end inner_block;
		dbms_output.put_line('value of x of outer block is '||x);		
end;	
 -------------------------------------------------------------------------------------
record creation  
-------------------------------------------------------------------------------------
declare
	Type emp_info is Record
	( empno emp.empno%type,
  	ename emp.ename%type,
  	hiredate emp.hiredate%type,
  	sal emp.sal%type
	);
     mrec emp_info;
    mempno emp.empno%type; service_yrs number;
begin
	mempno := &aempno;
	select empno,ename,hiredate,sal into mrec
	from emp where empno = mempno;
	service_yrs := trunc(months_between(sysdate,mrec.hiredate)/12);

	if service_yrs > 25 then
                  		 mrec.sal := mrec.sal + (mrec.sal*.2);
   	else
            		mrec.sal := mrec.sal + (mrec.sal*.02);
   	end if;
	dbms_output.put_line('the revised salary of employee ' || mrec.ename || '  is ' || mrec.sal);
end;

-------------------------------------------------------------------------------------
cursors
-------------------------------------------------------------------------------------
declare
	cursor cemp  is select empno,ename,job,sal,hiredate from rahul_emp Order by ename;
	mrec cemp%rowtype; service_yrs number;
begin
	open cemp;
	    loop
			fetch cemp into mrec;
	   		exit when cemp%notfound;
			service_yrs := trunc(months_between(sysdate,mrec.hiredate)/12);
			if service_yrs > 25 then
	       		mrec.sal := mrec.sal + (mrec.sal*.2);
	   		else
	   			mrec.sal := mrec.sal + (mrec.sal*.02);
	   		end if;
	            dbms_output.put_line('the revised salary of employee ' || mrec.ename || ' is ' || mrec.sal);
		end loop;
	close cemp;
End;


-------------------------------------------------------------------------------------
cursors for loop
-------------------------------------------------------------------------------------
declare
	cursor cemp  is select empno,ename,job,sal,hiredate from emp Order by ename;
	 service_yrs number;
begin

	for mrec in cemp
	loop
		          service_yrs := trunc(months_between(sysdate,mrec.hiredate)/12);

	          if service_yrs > 25 then
                    		mrec.sal := mrec.sal + (mrec.sal*.2);
   	          else
            		mrec.sal := mrec.sal + (mrec.sal*.02);
   	         end if;

  		        dbms_output.put_line('the revised salary of employee ' || mrec.ename ||  ' is ' || mrec.sal);

		end loop;
End;


-------------------------------------------------------------------------------------
cursor update multiple records
-------------------------------------------------------------------------------------
 declare
	cursor cemp  is select empno,ename,job,sal,hiredate from rahul_emp Order by ename for update of sal;
	 service_yrs number;
begin

	for mrec in cemp
	loop
          service_yrs := trunc(months_between(sysdate,mrec.hiredate)/12);
		  dbms_output.put_line('the original salary of employee ' || mrec.ename ||  ' is ' || mrec.sal);
         if service_yrs > 25 then
                   		mrec.sal := mrec.sal + (mrec.sal*.2);
  	          else
           		mrec.sal := mrec.sal + (mrec.sal*.02);
  	     end if;
			    update rahul_emp 
				set sal=mrec.sal 
				where current of cemp; 
 		        dbms_output.put_line('the revised salary of employee ' || mrec.ename ||  ' is ' || mrec.sal);

		end loop;
End;
-------------------------------------------------------------------------------------
curor code my own for updating perticular record 
-------------------------------------------------------------------------------------
declare
	cursor cemp  is select empno,ename,job,sal,hiredate from rahul_emp where job='&oldInput' Order by ename for update of job;
	oldJobTitle rahul_emp.job%type;
	newJobTitle rahul_emp.job%type;
	updated boolean;
begin
		  newJobTitle:='&newInput';
		  updated:=false;
	for mrec in cemp
	loop
		  	 	dbms_output.put_line('the original job title of employee ' || mrec.ename ||  ' is ' || mrec.job);
			    update rahul_emp 
				set job=newJobTitle 
				where current of cemp; 
 		        dbms_output.put_line('the revised job title of employee ' || mrec.ename ||  ' is ' || mrec.job);
				updated:=true;	
	end loop;
	if not updated then
		  	 	dbms_output.put_line('job title not found');
	end if;
End;
-------------------------------------------------------------------------------------
cursor update modified
-------------------------------------------------------------------------------------
begin
	update rahul_emp
	set
	job ='&newJobTitle'
	where job ='&oldJobTitle';
	
	if sql%notfound then
	   dbms_output.put_line('no record found');
	else
	   dbms_output.put_line(' record found and updated '||sql%rowcount);
	end if;
end;   
		
-------------------------------------------------------------------------------------
exception 
-------------------------------------------------------------------------------------

declare
	msal rahul_emp.sal%type;
	mempno rahul_emp.empno%type;
	mename rahul_emp.ename%type;
	mjob rahul_emp.job%type;
begin
	mjob:=upper('&inpJob');
	mempno:= &inpEno;
	select ename ,sal into mename,msal from rahul_emp
	where job=mjob;
	dbms_output.put_line(' The salary of employee '||mename||' is '||msal);
	select ename ,sal into mename,msal from rahul_emp
	where empno=mempno;
	dbms_output.put_line(' The salary of employee '||mename||' is '||msal);
exception
		 when no_data_found then
		 	  	dbms_output.put_line('no such employee');
		 when too_many_rows then 
		 	  	dbms_output.put_line('more than one record');
end; 

-------------------------------------------------------------------------------------
exception  which occured and error messager
-------------------------------------------------------------------------------------
declare
	msal rahul_emp.sal%type;
	mempno rahul_emp.empno%type;
	mename rahul_emp.ename%type;
	mjob rahul_emp.job%type;
begin
	mjob:=upper('&inpJob');
	mempno:= &inpEno;
	select ename ,sal into mename,msal from rahul_emp
	where job=mjob;
	dbms_output.put_line(' The salary of employee '||mename||' is '||msal);
	select ename ,sal into mename,msal from rahul_emp
	where empno=mempno;
	dbms_output.put_line(' The salary of employee '||mename||' is '||msal);
exception
		 when others then
		 	  	dbms_output.put_line('error code '||sqlcode ||' error message '||sqlerrm);
end; 
-------------------------------------------------------------------------------------
exception user defined
-------------------------------------------------------------------------------------
declare
	mcount number;
	msal rahul_emp.sal%type;
	mename rahul_emp.ename%type;
	myException exception;
	mjob rahul_emp.job%type;	
begin
	mjob:=upper('&inpJob');
	select count(*) into mcount from rahul_emp
	where job=mjob;

	if mcount>0 then
	   dbms_output.put_line('More than 1 emp for same job type ');
	else
		raise myException;   
	end if;   
exception
		 when myException then
		 	  	dbms_output.put_line('My Exception occured due to less count');
				dbms_output.put_line('error code '||sqlcode ||' error message '||sqlerrm);				
end; 
-------------------------------------------------------------------------------------
raise exception (my own)
-------------------------------------------------------------------------------------
declare
	cursor cemp  is select empno,ename,job,sal,hiredate from rahul_emp where job='&oldInput' Order by ename for update of job;
	oldJobTitle rahul_emp.job%type;
	newJobTitle rahul_emp.job%type;
	myException exception;
	updated boolean;
begin
		  newJobTitle:='&newInput';
		  updated:=false;
	for mrec in cemp
	loop
		  	 	dbms_output.put_line('the original job title of employee ' || mrec.ename ||  ' is ' || mrec.job);
			    update rahul_emp 
				set job=newJobTitle 
				where current of cemp; 
 		        dbms_output.put_line('the revised job title of employee ' || mrec.ename ||  ' is ' || mrec.job);
				updated:=true;	
	end loop;
	if not updated then
		  	 	raise myException;
	end if;
Exception
		  when myException then
		 	  	dbms_output.put_line('My Exception occured bec record not found ');
				dbms_output.put_line('error code '||sqlcode ||' error message '||sqlerrm);		
End;
-------------------------------------------------------------------------------------
procedure
-------------------------------------------------------------------------------------
create or replace procedure rahul_increment_emp
(phiredate rahul_emp.hiredate%type, psal rahul_emp.sal%type, incr_sal  out rahul_emp.sal%type) is
service_yrs number;
Begin
	service_yrs := trunc(months_between(sysdate,phiredate)/12);

  	 if service_yrs > 25 then
                  	 incr_sal := psal + (psal*.2);
   	elsif service_yrs  > 23 then
                   	 incr_sal := psal + (psal*.15);
   	else
            		 incr_sal := psal + (psal*.02);
   	end if;
End;
-------------------------------------------------------------------------------------
block calling procedure
-------------------------------------------------------------------------------------
declare
	cursor cemp is select empno,ename,job,sal,hiredate from rahul_emp
	where deptno = 10
	for update of sal;
	new_sal rahul_emp.sal%type;
begin
	For mrec in cemp
	loop
		rahul_increment_emp(mrec.hiredate,mrec.sal,new_sal);
		update rahul_emp set sal = new_sal
		where current of cemp;
	end loop;
end;

-------------------------------------------------------------------------------------
procedure with inout acess to variable
-------------------------------------------------------------------------------------
create or replace procedure rahul_increment_emp
(phiredate emp.hiredate%type, psal IN OUT emp.sal%type) is
service_yrs number;
begin
	service_yrs := trunc(months_between(sysdate,phiredate)/12);

  	 if service_yrs > 25 then
                  	 psal := psal + (psal*.2);
   	elsif service_yrs  > 23 then
                   	 psal := psal + (psal*.15);
   	else
            		 psal := psal + (psal*.02);
   	end if;
End;

-------------------------------------------------------------------------------------
declare for inout procedure
-------------------------------------------------------------------------------------
declare
	cursor cemp is select empno,ename,job,sal,hiredate from rahul_emp
	where deptno = 10
	for update of sal;

begin
	For mrec in cemp
	loop

		rahul_increment_emp(mrec.hiredate,mrec.sal);

		update rahul_emp set sal = mrec.sal
		where current of cemp;

	end loop;
end;


-------------------------------------------------------------------------------------
create function
-------------------------------------------------------------------------------------
create or replace function rc_increment
(phiredate rahul_emp.hiredate%type , psal rahul_emp.sal%type) 
return number
is
service_yrs number;
revised_sal rahul_emp.sal%type ;
begin
	service_yrs := trunc(months_between(sysdate,phiredate)/12);

  	 if service_yrs > 25 then
                  	 	revised_sal := psal + (psal*.2);
   	elsif service_yrs  > 23 then
 		revised_sal := psal + (psal*.15);
   	else
            		 revised_sal := psal + (psal*.02);
   	end if;
	return revised_sal;
End;

-------------------------------------------------------------------------------------
calling function from block
-------------------------------------------------------------------------------------
declare
	cursor cemp is select empno,ename,job,sal,hiredate from rahul_emp
	where deptno = 10
	for update of sal;
	new_sal rahul_emp.sal%type;
begin
	For mrec in cemp
	loop

	new_sal := rc_increment(mrec.hiredate ,mrec.sal);
	dbms_output.put_line('here in function new salary '||new_sal);
	update rahul_emp set sal = new_sal
	where current of cemp;

	end loop;
end;


-------------------------------------------------------------------------------------
function call from sql statement
-------------------------------------------------------------------------------------
select empno,hiredate,sal,rc_increment(hiredate,sal) from rahul_emp;

update rahul_emp
set sal = rc_increment(hiredate,sal)
where empno = 7900;

-------------------------------------------------------------------------------------
question sol function return number
-------------------------------------------------------------------------------------
create or replace function rc_fuc
(deptNo rahul_emp.deptNo%type ) 
return number
is
dcount number;
begin
	select count(*) into dcount from rahul_emp where deptno=deptNo;
	if sql%notfound then
	   return 0;   
	end if;
	return 1;
End;
-------------------------------------------------------------------------------------
calling block for function
-------------------------------------------------------------------------------------
declare

begin
	 dbms_output.put_line('answer = '||rc_fuc(&inp) );
end;
-------------------------------------------------------------------------------------
question sol function return varchar
-------------------------------------------------------------------------------------
create or replace function rc_fuc
(deptNumber rahul_emp.deptNo%type ) 
return varchar
is
dcount number;
begin
	select count(*) into dcount from rahul_emp where deptno=deptNumber;
	if dcount>0 then
	   return 'Department has employees';   
	end if;
	return 'Department does not has employees';
End;
-------------------------------------------------------------------------------------
calling block for function
-------------------------------------------------------------------------------------
declare

begin
	 dbms_output.put_line('answer = '||rc_fuc(&inp) );
end;
-------------------------------------------------------------------------------------
sql statement with above created function 
-------------------------------------------------------------------------------------


select rc_fuc(0) from rahul_dept;



-------------------------------------------------------------------------------------
packages creation ....
-------------------------------------------------------------------------------------
create or replace package rahul_salary
as
procedure rahul_process_increment;
function rahul_fn_increment(phiredate rahul_emp.hiredate%type , psal rahul_emp.sal%type)  return number;
end;

-------------------------------------------------------------------------------------
package body for above declared package 
-------------------------------------------------------------------------------------
create or replace package body rahul_salary
as
    procedure rahul_process_increment
	is
	cursor cemp is select empno,ename,job,sal,hiredate from rahul_emp
	for update of sal;
	service_yrs number;
	begin
		For mrec in cemp
		loop
			service_yrs := trunc(months_between(sysdate,mrec.hiredate)/12);
	
			if service_yrs > 25 then
	                  			 mrec.sal := mrec.sal + (mrec.sal*.2);
	   		else
	            			mrec.sal := mrec.sal + (mrec.sal*.02);
	   		end if;
	
			update rahul_emp set sal = mrec.sal
	 		where current of cemp;
		end loop;
	End;
	function rahul_fn_increment
	(phiredate rahul_emp.hiredate%type , psal rahul_emp.sal%type) 
	return number
	is
	service_yrs number;
	revised_sal rahul_emp.sal%type ;
	begin
		service_yrs := trunc(months_between(sysdate,phiredate)/12);
	
	  	 if service_yrs > 25 then
	                  	 	revised_sal := psal + (psal*.2);
	   	elsif service_yrs  > 23 then
	 		revised_sal := psal + (psal*.15);
	   	else
	            		 revised_sal := psal + (psal*.02);
	   	end if;
		return revised_sal;
	End;
End;
-------------------------------------------------------------------------------------
calling the procedure of above declared package
-------------------------------------------------------------------------------------
begin

rahul_salary.rahul_process_increment;

end;
-------------------------------------------------------------------------------------
calling the function of above declared package
-------------------------------------------------------------------------------------
begin

dbms_output.put_line(rahul_salary.rahul_fn_increment('1-JAN-2010',4500));

end;
-------------------------------------------------------------------------------------
drop package 
-------------------------------------------------------------------------------------

drop package <package name>

drop package body <package name>

-------------------------------------------------------------------------------------
triggers
create trigger on  rahul_emp_del when deletion occures on rahul_emp
-------------------------------------------------------------------------------------
create or replace trigger rahul_emp_del
before delete on rahul_emp
for each row
begin
	insert into rahul_emp_history values
	(:old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,
	:old.sal,:old.comm,:old.deptno);

end ;
-------------------------------------------------------------------------------------
add total employees in rahul_dept 
-------------------------------------------------------------------------------------

alter table rahul_dept add tot_emp number;

-------------------------------------------------------------------------------------
update rahul_dept when insertion occures on rahul_emp
-------------------------------------------------------------------------------------
create or replace trigger rahul_dept_tot_emp
after insert on rahul_emp
for each row
begin
	
   	 update rahul_dept set tot_emp = (tot_emp + 1)
	where deptno = :new.deptno;
end;

-------------------------------------------------------------------------------------
trigger for insert or updating or deleting on rahul_emp
-------------------------------------------------------------------------------------
create or replace trigger  rahul_dept_tot_emp
after insert or delete or  update of deptno  on rahul_emp
for each row
begin

if inserting or updating then
	    update rahul_dept set tot_emp = tot_emp + 1
	    where deptno = :new.deptno;

end if;

if updating  or deleting then

    	update rahul_dept set tot_emp = tot_emp - 1
	where deptno = :old.deptno;
end if;
    
end;

-------------------------------------------------------------------------------------
triger executes operations when a condition matches
-------------------------------------------------------------------------------------
create or replace trigger  rahul_dept_tot_emp
after insert or delete or  update of deptno  on rahul_emp
for each row
when(old.deptno <> new.deptno)
begin
if inserting or updating then
	    update rahul_dept set tot_emp = tot_emp + 1
	   where deptno = :new.deptno;
end if;
if updating  or deleting then
    	update rahul_dept set tot_emp = tot_emp - 1
	where deptno = :old.deptno;
end if;
end;

-------------------------------------------------------------------------------------
conditions
-------------------------------------------------------------------------------------

if((to_char(sysdate, 'HH')>=8 &&to_char(sysdate, 'MM')>=30) && (to_char(sysdate, 'HH')<=17 && to_char(sysdate, 'MM')<=30) && (to_char(sysdate, 'd')>=1  && to_char(sysdate, 'd')<=6))


-------------------------------------------------------------------------------------
creating a view
-------------------------------------------------------------------------------------
create view rahul_emp_details
as
select e.empno,e.ename,e.hiredate,d.deptno,d.dname from rahul_emp e,rahul_dept d
where e.deptno = d.deptno
-------------------------------------------------------------------------------------
create instead of trigger on the view created above
-------------------------------------------------------------------------------------
create or replace trigger rahul_emp_details_insert
--Instead of insert on rahul_emp_details (view name)
Instead of insert on rahul_emp_details 
for each row
begin
insert into rahul_emp(EMPNO,ENAME,HIREDATE,DEPTNO) values(:new.empno,:new.ename,:new.hiredate,:new.deptno);
insert into rahul_dept(deptno,dname)
values (:new.deptno,:new.dname);
end;
-------------------------------------------------------------------------------------
insert into view to trigger instead of trigger
-------------------------------------------------------------------------------------
inert into rahul_emp_details(empno,ename,hiredate,deptno,dname) values(1234,'rc',sysdate,50,'ee');



-------------------------------------------------------------------------------------
enable disable trigger
-------------------------------------------------------------------------------------
Alter trigger trigger_name  disable | enable

Alter table table_name   disable | enable  all triggers

Alter trigger trigger_name compile
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------


