/*creujemy pakiet ze stałą
oraz funkcję do użycia w select*/
create or replace package tmp as
    kpi_7 number := 80;
    FUNCTION kpi_7 RETURN NUMBER ;
end ;
/
/*packaga body*/
create or replace PACKAGE BODY tmp AS
 FUNCTION kpi_7 RETURN NUMBER IS
      BEGIN
      return tmp.kpi_7;
    end kpi_7;
end;
/
/*how to use the package function*/
SELECT tmp.kpi_7() FROM dual;
