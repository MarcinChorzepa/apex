/* ścieżka jak uzyskaliśmy wyniki*/
SELECT * from DANE

with tmp as (SELECT  ID_NUMBER, X_AREA , STATUS FROM DANE)
    SELECT count(*) as ile ,
           X_AREA from tmp
    WHERE STATUS='ANULOWANY'
    GROUP BY X_AREA


/*with razem z funkcjami analitycznymi*/
WITH tmp as (
         SELECT  ID_NUMBER, X_AREA ,
            /*analityczna funkcja sum razem z warunkiem sumowanie */
          sum(case when STATUS='ANULOWANY' THEN 1 ELSE 0 end) OVER (PARTITION BY X_AREA)
        /
        /*analityczna funkcja partycje per x_area*/
        count(*) OVER (PARTITION BY X_AREA) dd
        FROM DANE)
    /*na końcu można grupować wyniki*/
    SELECT X_AREA , max(dd) FROM tmp
    GROUP BY X_AREA;


/*użycie rank z tmp table*/
CREATE table tmp_rank_test (id NUMBER, name VARCHAR2(100), dt date);
INSERT INTO tmp_rank_test (id, name, dt) VALUES (1,'pierwszy',to_date('2017-01-02','yyyy-mm-dd'));
INSERT INTO tmp_rank_test (id, name, dt) VALUES (2,'pierwszy',to_date('2017-01-03','yyyy-mm-dd'));
INSERT INTO tmp_rank_test (id, name, dt) VALUES (3,'drugi',   to_date('2017-01-04','yyyy-mm-dd'));
INSERT INTO tmp_rank_test (id, name, dt) VALUES (4,'trzeci',  to_date('2017-01-05','yyyy-mm-dd'));
INSERT INTO tmp_rank_test (id, name, dt) VALUES (5,'trzeci',  to_date('2017-01-06','yyyy-mm-dd'));
INSERT INTO tmp_rank_test (id, name, dt) VALUES (6,'trzeci'  ,to_date('2017-01-07','yyyy-mm-dd'));
INSERT INTO tmp_rank_test (id, name, dt) VALUES (7,'czwarty'  ,to_date('2017-01-23','yyyy-mm-dd'));

/*uzycie rank i dense_rank*/
SELECT id, name,
  dt
, rank() OVER (ORDER BY dt) rnk
, rank() OVER (partition by name ORDER BY dt) rank_with_partition
, dense_rank() OVER (ORDER BY dt) dense_rank_function
from tmp_rank_test