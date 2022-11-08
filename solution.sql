CREATE TABLE TableA (dimension_1 VARCHAR(32), dimension_2 VARCHAR(32), dimension_3 VARCHAR(32), measure_1 INT);
INSERT INTO TableA VALUES ('a', 'I', 'K', 1);
INSERT INTO TableA VALUES ('a', 'J', 'L', 7);
INSERT INTO TableA VALUES ('b', 'I', 'M', 2);
INSERT INTO TableA VALUES ('c', 'J', 'N', 5);

CREATE TABLE TableB (dimension_1 VARCHAR(32), dimension_2 VARCHAR(32), measure_2 INT);
INSERT INTO TableB VALUES ('a', 'J', 7);
INSERT INTO TableB VALUES ('b', 'J', 10);
INSERT INTO TableB VALUES ('d', 'J', 4);

CREATE TABLE TableMAP (dimension_1 VARCHAR(32), correct_dimension_2 VARCHAR(32));
INSERT INTO TableMAP VALUES ('a', 'W');
INSERT INTO TableMAP VALUES ('a', 'W');
INSERT INTO TableMAP VALUES ('b', 'X');
INSERT INTO TableMAP VALUES ('c', 'Y');
INSERT INTO TableMAP VALUES ('b', 'X');
INSERT INTO TableMAP VALUES ('d', 'Z');

with source as 
(
select distinct TableA.dimension_1, correct_dimension_2 as dimension_2, measure_1, '0' as measure_2 from TableA
join TableMAP on TableA.dimension_1 =  TableMAP.dimension_1 
union all
select distinct TableB.dimension_1, correct_dimension_2 as dimension_2, '0' as measure_1, measure_2 from TableB
join  TableMAP on TableB.dimension_1 =  TableMAP.dimension_1)

select dimension_1, dimension_2, sum(measure_1) as measure_1, sum(measure_2) as measure_2 from source  group by dimension_1, dimension_2
