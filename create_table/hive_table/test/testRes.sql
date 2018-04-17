use test;
CREATE TABLE testRes
(
name                 string   ,
total                  int      comment 'total'
)
COMMENT '測試'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;
 