 CREATE OR REPLACE PROCEDURE aws.calculate_time(query IN VARCHAR2) AS
  n NUMBER;
  BEGIN
    n := dbms_utility.get_time();
    EXECUTE IMMEDIATE query;
    dbms_output.put_line((dbms_utility.get_time - n) / 100 || ' seconds....');
  END;


/*to run the procedure use*/
--begin
--  aws.calculate_time('select * from aws.dane');
--end;