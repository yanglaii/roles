#!/bin/bash
ip=$1
port=$2
nport=`echo ""|telnet ${ip} ${port} 2>/dev/null|grep "\^]"|wc -l`
echo $nport
