/*this method can be used instead of execute immediate*/

/*declare global types of row and tables*/
create or replace  TYPE DEPT_TYPE AS OBJECT (id NUMBER(2), name VARCHAR2(14), loc VARCHAR2(13));
create or replace TYPE DEPT_TABLE AS TABLE OF DEPT_TYPE;

/*create function*/
CREATE OR REPLACE FUNCTION tmp_table(p_deptno IN NUMBER) RETURN DEPT_TABLE IS
 type rc01 is  REF CURSOR ;
  c1 rc01;
   l_dept_row DEPT_TYPE:=DEPT_TYPE(null,null,null) ;
  l_dept_table DEPT_TABLE:=DEPT_TABLE(l_dept_row);
  cnt NUMBER:=1;
  BEGIN
    OPEN c1 for 'select deptno, dname, loc from aws.dept where deptno = :1' USING p_deptno;
    LOOP
      FETCH c1 INTO l_dept_row.id, l_dept_row.name, l_dept_row.loc;
      EXIT WHEN c1%NOTFOUND;
      l_dept_table(cnt):=l_dept_row;
       cnt:=cnt+1;
    END LOOP;
    CLOSE c1;
    RETURN l_dept_table;
  END;

/*gets records*/
SELECT *
FROM TABLE (tmp_table(10));


/*optimalization using bulk collect*/
CREATE OR REPLACE FUNCTION tmp_table2(p_deptno IN NUMBER) RETURN DEPT_TABLE IS
 type rc01 is  REF CURSOR ;
  c1 rc01;
   l_dept_row DEPT_TYPE:=DEPT_TYPE(null,null,null) ;
  l_dept_table DEPT_TABLE:=DEPT_TABLE(l_dept_row);
  BEGIN
    OPEN c1 for 'select deptno, dname, loc from aws.dept where deptno = :1' USING p_deptno;
      FETCH c1 BULK COLLECT INTO  l_dept_table; -- l_dept_row.id, l_dept_row.name, l_dept_row.loc;
    CLOSE c1;
    RETURN l_dept_table;
  END;