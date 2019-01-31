#!/bin/bash                                                                    

echo "label tsc"

for i in 'seq 10'
do
    echo -n "start: "; ./rdmsr --decimal 16
    #./FIRESTARTER -b "0" -t 10                                                
    ./rdmsr --hexadecimal --all 10
    echo -n "stop: ";./rdmsr --decimal 16
done
