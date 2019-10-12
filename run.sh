#!/bin/bash
#--conf spark.default.parallelism=200 \
source /etc/profile
hdfsin=/user/gdpi/public/sada_gdpi_adcookie
effi=/data2/u_lx_tst2/adp_spark/effi
merge_output_path=private/im/merge
#translate_output=private/im/translate

translate_output=hdfs://ns1/user/u_lx_tst2/public/terminal_ad
logdir=/data2/u_lx_tst2/adp_spark/log
blackdir=/data2/u_lx_tst2/adp_spark/black
empty_hdfs_dir=private/im/emp

#merge 不是 当月第一天
function merge_not_1(){
day=$1
last_day=$(date --date="1 day ago ${day}" +"%Y%m%d")
hadoop fs -rm -r ${merge_output_path}/${day}
cd /usr/local/spark-2.0.2-bin-2.6.0-cdh5.8.0 && ./bin/spark-submit \
--class com.ideal.adp.spark.AdpPrepare \
--master yarn \
--conf yarn.nodemanager.vmem-check-enabled=false \
--conf spark.yarn.executor.memoryOverhead=9000 \
--conf spark.network.timeout=1000 \
--conf spark.sql.shuffle.partitions=10000 \
--conf spark.default.parallelism=10000 \
--conf repartitionNum=20000 \
--driver-memory 60g \
--executor-memory 5g \
--num-executors 200 \
--executor-cores 5 \
--jars /data2/u_lx_tst2/adp_spark/bin/adpspark.jar /data2/u_lx_tst2/adp_spark/bin/adpwhitelist.jar \
steps=1,2,3 pre_in=${hdfsin}/${day}/*  train_black=${blackdir}/${day} merge_former=${merge_output_path}/${last_day} merge_out=${merge_output_path}/${day} merge_date=${day} \
> ${logdir}/im_${day} 2>&1

#pre_effi=${effi}/effi_${day}
}

#merge 当月第一天
function merge_1(){
day=$1
hadoop fs -mkdir ${empty_hdfs_dir}
hadoop fs -rm -r ${merge_output_path}/${day}
cd /usr/local/spark-2.0.2-bin-2.6.0-cdh5.8.0 && ./bin/spark-submit \
--class com.ideal.adp.spark.AdpPrepare \
--master yarn \
--conf yarn.nodemanager.vmem-check-enabled=false \
--conf spark.yarn.executor.memoryOverhead=9000 \
--conf spark.network.timeout=1000 \
--conf spark.sql.shuffle.partitions=10000 \
--conf spark.default.parallelism=10000 \
--conf repartitionNum=20000 \
--driver-memory 60g \
--executor-memory 5g \
--num-executors 200 \
--executor-cores 5 \
--jars /data2/u_lx_tst2/adp_spark/bin/adpspark.jar /data2/u_lx_tst2/adp_spark/bin/adpwhitelist.jar \
steps=1,2,3 pre_in=${hdfsin}/${day}/*  train_black=${blackdir}/${day} merge_former=${empty_hdfs_dir} merge_out=${merge_output_path}/${day} merge_date=${day} \
> ${logdir}/im_${day} 2>&1
}

function merge(){
 dt=$1
 day=$(date --date="${dt}" +"%d")
 if [ "${day}xx" == "01xx" ]
 then
 echo "it is the first day"
  merge_1 ${dt}
 else
  merge_not_1 ${dt}
 fi
}

#为最终结果表添加分区
function add_par(){
day=$1
day=$(date --date="${day}" +"%Y%m")
hive -e "
use u_lx_tst2;
alter table terminal_ad add if not exists partition(mon='${day}') location '${day}'
"

}

#解密
function phid(){
day=$1
day_out=$(date --date="$day" +"%Y%m")
out_path=${translate_output}/${day_out}
hadoop fs -rm -r ${out_path}
cd /usr/local/spark-2.0.2-bin-2.6.0-cdh5.8.0 && ./bin/spark-submit \
--class com.ideal.adp.spark.AdpPrepare \
--master yarn \
--conf yarn.nodemanager.vmem-check-enabled=false \
--conf spark.yarn.executor.memoryOverhead=9000 \
--conf spark.network.timeout=500 \
--driver-memory 60g \
--executor-memory 10g \
--num-executors 100 \
--executor-cores 10 \
--jars /data2/u_lx_tst2/adp_spark/bin/adpspark.jar /data2/u_lx_tst2/adp_spark/bin/adpwhitelist.jar \
steps=4 translate_in=${merge_output_path}/${day} translate_out=${out_path} translate_date=${day} \
> ${logdir}/translate_${day} 2>&1
add_par day_out
}


function all(){
day=$1
merge ${day}
phid ${day}
add_par ${day}
}

function bat(){
func=$1
st=$2
et=$3
while [ ${st} -le ${et} ]
do
 ${func} ${st}
 st=$(date --date="+1 day ${st}" +"%Y%m%d")
done
}

function cront(){
day=$(date --date="1 day ago" +"%Y%m%d")
all $day
}

if [ $# = 3 ]
then
bat $1 $2 $3
elif [ $# = 1 ]
then
cront
else
 echo "Usage: sh $0 <merge|phid> <starttime> <endtime> | cront"
fi

