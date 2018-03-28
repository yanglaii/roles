#!/bin/bash
#Usage: discovery soft
#Last Modified:
#softCmdStr=("-e mysql -e ' node ' -e pm2 -e tomcat -e memcached -e haproxy -e docker -e nginx -e rabbitmq -e asterisk")
printf "{\n"
        printf  '\t'"\"data\":[\n"
		processArrayStr=`ps -ef ww|grep -e mysql -e ' node ' -e pm2 -e tomcat -e memcached -e haproxy -e docker -e nginx -e rabbitmq -e asterisk|grep -v grep|grep -v userparameter|grep -v mysqld_safe`
		OLD_IFS="$IFS"
		IFS=`echo -e "\n\r"`
		processArray=($processArrayStr)
		IFS="$OLD_IFS"
		length=${#processArray[@]}
		for (( i = 0; i < ${length}; i++ ));
		do
			soft_type_str=`echo "${processArray[$i]}"|awk '{for(i=9;i<=NF;i++){printf"%s ", $i};}'`
			soft_type_str=`echo $soft_type_str|cut -c1-200`
			soft_process_cmd_str=`echo "${processArray[$i]}"|awk '{print $2}'`
			printf "\t\t{\"{#SOFT_NAME}\":\"${soft_type_str}\",\"{#PID}\":\"${soft_process_cmd_str}\"}"
			if [ $i -lt $[$length-1] ];then
				printf ',\n'
			fi
		done
        printf  "\n\t]\n"
printf "}\n"
