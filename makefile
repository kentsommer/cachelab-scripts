CFLAGS=-O3 -lpapi -DPERFCTR 
OPTCFLAGS=-O3 -lpapi -DPERFCTR #Can change to 2 if too much output.  Add more compiler options here.  
RESULT_PATH=/export/scratch/cachelab_results_somme282/

all: compare_drivers
	gcc $(OPTCFLAGS) -o matmul-1024-opt matmul-1024-opt.c
	gcc $(OPTCFLAGS) -o matmul-2000-opt matmul-2000-opt.c

setup:
	make clean
	touch .test
	mkdir $(RESULT_PATH)
	echo $(RESULT_PATH) > path
	make
	make compare

setup_optc:
	make clean
	touch .test
	mkdir path
	echo $(RESULT_PATH) > path
	make
	make compare_optc

compare_drivers:
	gcc $(CFLAGS) -o matmul-1024 matmul-1024.c
	gcc $(CFLAGS) -o matmul-2000 matmul-2000.c

compare:
	make compare_drivers CFLAGS='$(CFLAGS)'
	./matmul-1024 1> $(RESULT_PATH)matmul-1024-results 2> matmul-1024-time;
	./matmul-2000 1> $(RESULT_PATH)matmul-2000-results 2> matmul-2000-time;

compare_optc:
	make compare CFLAGS='$(OPTCFLAGS)'

matmul-1024-opt:
	gcc $(OPTCFLAGS) -o matmul-1024-opt matmul-1024-opt.c
#	./matmul-1024 1> matmul-1024-results 2> matmul-1024-time;

matmul-2000-opt:
	gcc $(OPTCFLAGS) -o matmul-2000-opt matmul-2000-opt.c
#	./matmul-1024 1> matmul-2000-results 2> matmul-2000-time;

clean_opt:
	rm -rf *o matmul-1024-opt
	rm -rf *o matmul-2000-opt

clean:
	rm -rf *o matmul-1024
	rm -rf *o matmul-1024-opt
	rm -rf *o matmul-2000
	rm -rf *o matmul-2000-opt
	rm -rf $(RESULT_PATH)matmul-1024-results matmul-1024-time $(RESULT_PATH)matmul-2000-results matmul-2000-time $(RESULT_PATH)matmul-1024-opt-results $(RESULT_PATH)matmul-2000-opt-results difference difference_size matmul-1024-opt-time matmul-2000-opt-time path .test
	rm -rf -r $(RESULT_PATH)