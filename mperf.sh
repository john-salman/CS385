#!/bin/bash                                                                    

echo "label tsc"

for i in `seq 10`;
do
    echo -n "start: "; ./rdmsr --decimal 231
    sleep 1
    echo -n "stop: ";./rdmsr --decimal 231
done
