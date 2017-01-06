#!/bin/bash

sed -i 's/{{KAFKA_BROKER_ID}}/'"$KAFKA_BROKER_ID"'/g' /usr/local/kafka/config/server.properties
sed -i 's/{{ZOOKEEPER_CONNECTIONS}}/'"$ZOOKEEPER_CONNECTIONS"'/g' /usr/local/kafka/config/server.properties

zookeeper-server-start.sh -daemon /usr/local/kafka/config/zookeeper.properties
kafka-server-start.sh -daemon /usr/local/kafka/config/server.properties
