use test;
CREATE TABLE test
(
id                    int      comment 'id',
name               string   ,
sex                  int      comment 'sex'
)
COMMENT '測試'
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\001' STORED AS TEXTFILE;
 