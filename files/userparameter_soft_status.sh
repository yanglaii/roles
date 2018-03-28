#!/bin/bash
#Usage: discovery soft
#Last Modified:
statusType=$1
pid=$2
case  "$statusType"  in
  "cpu") 
	  processArrayStr=`top -bcn 1 -p ${pid}|grep "^ *${pid} "`
	  soft_cpu=`echo "${processArrayStr}"|awk '{print $9}'`
	  printf ${soft_cpu};;
  "mem") 
	  processArrayStr=`top -bcn 1 -p ${pid}|grep "^ *${pid} "`
	  soft_mem=`echo "${processArrayStr}"|awk '{print $10}'`
	  printf ${soft_mem};;
  "io_read") 
	  soft_io_read=`pidstat -d -l -p ${pid} 1 1|awk 'NR==3{for(i=1;i<=NF;i++)if($i~/^kB_rd/)a[++c]=i}{for(i=1;i<=c;i++)printf $a[i]" ";}'|awk '{print $2}'`
	  printf ${soft_io_read};;
  "io_write") 
	  soft_io_write=`pidstat -d -l -p ${pid} 1 1|awk 'NR==3{for(i=1;i<=NF;i++)if($i~/^kB_wr/)a[++c]=i}{for(i=1;i<=c;i++)printf $a[i]" ";}'|awk '{print $2}'`
	  printf ${soft_io_write};;
  "thread_count")
	soft_thread_count=`pstree -p ${pid}| wc -l`
	printf ${soft_thread_count};; 
  "cmd")
        soft_cmd=`ps -ef |awk 'NR==1{for(i=1;i<=NF;i++)if($i~/^PID/||$i~/^CMD/)a[++c]=i}{for(i=1;i<=c;i++)if($a[i]=="'"${pid}"'"){for(j=i;j<=NF;j++)printf($j"___")}}'`
        printf ${soft_cmd};;
  "stat")
        soft_stat=`ps xua |awk 'NR==1{for(i=1;i<=NF;i++)if($i~/^PID/||$i~/^STAT/)a[++c]=i}{for(i=1;i<=c;i++)if($a[i]=="'"${pid}"'")printf $a[i+1]'}`
	printf ${soft_stat};;
esac
