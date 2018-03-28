#!/bin/bash
#Usage: discovery soft
#Last Modified:
infoType=$1
case  "$infoType"  in
  "ip") 
	  host_ip=`ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`
	  echo ${host_ip};;
esac
