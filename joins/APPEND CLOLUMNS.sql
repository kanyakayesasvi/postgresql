--APPEND CLOLUMNS


CREATE TABLE TABLE1
(
	ADD_DATE  DATE,
	COL1 INT,
	COL2 INT,
	COL3 INT
)



CREATE TABLE TABLE2
(
	ADD_DATE  DATE,
	COL1 INT,
	COL2 INT,
	COL3 INT,
	COL4 INT,
	COL5 INT
	)


INSERT INTO TABLE1(ADD_DATE,COL1,COL2,COL3)
VALUES

('2022-03-04',6,5,6);





INSERT INTO TABLE2(ADD_DATE,COL1,COL2,COL3,COL4,COL5)
VALUES
('2022-03-01',NULL,7,8,9,10),
('2022-03-02',11,12,13,14,15),
('2022-03-03',16,17,18,19,20)

SELECT * FROM TABLE1
SELECT * FROM TABLE2

SELECT
COALESCE(T1.ADD_DATE,T2.ADD_DATE) AS "ADD_DATE",
COALESCE(T1.COL1,T2.COL1)  COL1,
COALESCE(T1.COL2,T2.COL2)  COL2,
COALESCE(T1.COL3,T2.COL3)  COL3,
T2.COL4,
T2.COL5
FROM TABLE1 T1 FULL OUTER JOIN  TABLE2 T2 ON T1.ADD_DATE=T2.ADD_DATE























