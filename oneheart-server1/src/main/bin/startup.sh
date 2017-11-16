#!/bin/sh

java -server -jar *.jar 2>&1 | tee output.log &

