#!/bin/bash


# echo "label tsc"

# for i in 'seq 10'
# do
#     echo -n "start: "; rdmsr  --decimal 0x611 --bitfield 31:0
#     #./FIRESTARTER -b "0" -t 10                                                
#     # ./rdmsr --hexadecimal --all 10
#     sleep 10
#     echo -n "stop: "; rdmsr  --decimal 0x611 --bitfield 31:0
# done


rdmsr  --decimal 0x611 --bitfield 31:0
./FIRESTARTER -b "0,1,2,3" -t 10 -q
rdmsr  --decimal 0x611 --bitfield 31:0