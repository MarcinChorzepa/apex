
/*set the name of query plan*/
EXPLAIN PLAN SET STATEMENT_ID ='nazwa' FOR
SELECT * FROM aws.dane ;

/*select the plan for the name*/
SELECT *
FROM TABLE (DBMS_XPLAN.DISPLAY(NULL, 'nazwa', 'ALL'));

/*clear all plans from cache*/
alter system flush shared_pool;

