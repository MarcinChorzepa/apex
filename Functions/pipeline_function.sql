
CREATE OR REPLACE FUNCTION GET_DEPT(id NUMBER)
  RETURN DEPT_TABLE PIPELINED IS
  CURSOR c1 IS (SELECT *
                FROM aws.DEPT_TABLE
                WHERE deptno = id);
  ldept c1%ROWTYPE;
  BEGIN

    FOR c IN sel LOOP
      SELECT *
      INTO ldept
      FROM SEL;
      PIPE ROW (ldept);
    END LOOP;
    RETURN;
  END;
/