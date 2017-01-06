#!/bin/bash

# N is the node number of kafka cluster
N=$1

if [ $# = 0 ]
then
	echo "Please enter the node number of kafka cluster"
	exit 1
fi

# change zookeeper.properties file
rm config/zookeeper.properties
cp config/zookeeper.properties.template config/zookeeper.properties

echo -e "\ninitLimit=5\nsyncLimit=2\n" >> config/zookeeper.properties

i=1
while [ $i -le $N ]
do
	echo -e "server.$i=kafka-$i:2888:3888" >> config/zookeeper.properties
	((i++))
done

echo ""

echo -e "\nbuild docker kafka image\n"

# rebuild kafka image
#sudo docker build -t kafka:1.0 .

echo ""
