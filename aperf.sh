#!/bin/bash                                                                    

echo "label tsc"

for i in `seq 10`;
do
    echo -n "start: "; ./rdmsr --decimal 232
    sleep 1
    #./rdmsr --hexadecimal --all 10
    echo -n "stop: ";./rdmsr --decimal 232
done
