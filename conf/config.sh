#!/bin/bash
if [  -f "/www/dev" ];then
  env="dev"
elif [  -f "/www/qa" ];then
  env="qa"
elif [  -f "/www/pre" ];then
  env="pre"
elif [  -f "/www/master" ];then
  env="master"
else 
  echo "当前环境配置不存在1!"
  exit -1;
fi
configUrl="/www/data-analysis/conf/data_info.$env"
echo $configUrl