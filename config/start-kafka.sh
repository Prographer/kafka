#!/bin/bash
echo $KAFKA_BROKER_ID > /tmp/zookeeper/myid
sed -i 's/{{KAFKA_BROKER_ID}}/'"$KAFKA_BROKER_ID"'/g' /usr/local/kafka/config/server.properties

zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties
