 with data as (  select breadcrumb_id, parent_breadcrumb_id, breadcrumb_entry_id, defined_for_page
                            from apex_application_bc_entries
                            where application_id =102 )
            select defined_for_page,
                breadcrumb_entry_id,
                substr(sys_connect_by_path(defined_for_page,':'),1,instr(sys_connect_by_path(defined_for_page,':'),':',-1)-1) parent_pages,
              APEX_UTIL.STRING_TO_TABLE(substr(sys_connect_by_path(defined_for_page,':'),1,instr(sys_connect_by_path(defined_for_page,':'),':',-1)-1)  ) dd
            from data
            start with parent_breadcrumb_id = 0
            connect by prior breadcrumb_id = breadcrumb_id
                and prior breadcrumb_entry_id = parent_breadcrumb_id;

set SERVEROUTPUT ON;
select * from  EBA_DEMO_IR_PKG.getBreadPageRefsTable(102)  -- apex_application_pages where application_id=102

;