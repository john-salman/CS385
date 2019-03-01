run: hw interpose
	LD_PRELOAD=./interpose.so ./hw

clean:
	rm -f hw interpose.so

hw:
	gcc -Wall -o hw hw.c

interpose:
	gcc -Wall -std=c99 interpose.c -o interpose.so -fPIC -shared -ldl 

