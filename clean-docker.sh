#!/bin/sh

for i in $(docker ps -aq)
do
	echo $(docker stop $i)
done

for i in $(docker ps -aq)
do
	echo $(docker rm $i)
done

for i in $(docker images -aq)
do
	echo $(docker rmi -f $i)
done

for i in $(docker network ls --filter type=custom -q)
do
	echo $(docker network rm $i)
done
