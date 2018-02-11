CREATE OR REPLACE   TRIGGER  AWS.TB_CTT_DESCRIPTION_T1
BEFORE
update on AWS.TB_CTT_DESCRIPTION
for each row
begin
DECLARE
  v_status_changed VARCHAR2(2000);
BEGIN
  if :OLD.status!=:NEW.status THEN
    v_status_changed:='changed STATUS: ' || 'from ' || :OLD.status || ' into ' || :NEW.status || ' on ' || to_char(sysdate,'yyyy-mm-dd hh24:mi:ss');
     INSERT INTO TB_NTT_DESCRIPTION_LOG (LOG2DESCRIPTION, CHANGED_BY, FULL_LOG) VALUES (:OLD.id, :NEW.changed_by, v_status_changed);
    END IF;
END;
end;

/

ALTER TRIGGER  AWS.TB_CTT_DESCRIPTION_T1 ENABLE
/