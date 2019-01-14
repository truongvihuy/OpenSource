#!/bin/bash
rm -rf data04_result.txt
! [ -e data4.txt ] && echo "8.8.8.8" >> data4.txt && tongping=0 && pingduoc=0 && pingko=0 &&
while read line ;do
	tongping=$tongping+1
	ping -c1 $line | grep "64 bytes" &> /dev/null
	if [ $? -eq 0 ];then 
		echo "$line -> Ping thanh cong" >> data04_result.txt
		pingduoc=$pingduoc+1
	else
		echo "$line -> Ping khong thanh cong" >> data04_result.txt
		pingko=$pingko+1
	fi
done < data4.txt