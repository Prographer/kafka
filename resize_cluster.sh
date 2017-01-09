#!/bin/bash

# N is the node number of kafka cluster
N=$1


if [ $# = 0 ]
then
	echo "Please enter the node number of kafka cluster"
	exit 1
fi
echo -e "\n1. make zookeeper.properties file"
# change zookeeper.properties file
rm config/zookeeper.properties
cp config/zookeeper.properties.template config/zookeeper.properties

echo -e "\ninitLimit=5\nsyncLimit=2\n" >> config/zookeeper.properties

echo -e " - zookeeper server"
i=1
while [ $i -le $N ]
do
	zookeeper_server="server.$i=kafka-$i:2888:3888"
	echo -e $zookeeper_server >> config/zookeeper.properties
	echo -e "\t$zookeeper_server"

	connection_string+="kafka-$i:2181,"
	((i++))
done

echo -e "\n2. make server.properties\n - zookeeper connection string\n\t"${connection_string%,}
sed 's/{{ZOOKEEPER_CONNECTIONS}}/'"${connection_string%,}"'/g' config/server.properties.template > config/server.properties

echo -e "\n3. build docker kafka image\n"
docker build --tag kafka:1.0 .
