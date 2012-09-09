uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
uname_M := $(shell sh -c 'uname -m 2>/dev/null || echo not')
UNAME = $(uname_S)_$(uname_M)

# CHECK = -DCHECK
CHECK = 
DOUBLE = -DDOUBLE 
# DOUBLE = 
CFLAGS = -c -O3 $(DOUBLE) $(CHECK) -Wall -pedantic-errors -Werror -flto
CFLAGS2 = -O3 $(DOUBLE) $(CHECK) -Wall -pedantic-errors -Werror -flto

#
# OS-X
ifeq ($(UNAME), Darwin_x86_64)
	CC = gcc
endif

# plane_down.c 
DCS =  linprog.c \
	vector_up.c \
	lp_base_case.c  \
	randperm.c \
	randomize.c \
	unit2.c


#plane_down.o 
DOS = linprog.o \
	vector_up.o \
	lp_base_case.o  \
	randperm.o \
	randomize.o \
	unit2.o

LIBA = libseidel_$(UNAME).a

$(LIBA):  $(DOS)
	rm -f $(LIBA); ar rcs $(LIBA) $(DOS); $(RANLIB)

llib-llinear.ln: $(DCS)
	lint -Clinear $(DCS)


lint: $(LIBA)
	lint -u -DCHECK $(DCS)

randperm.o: randperm.c
	$(CC) $(CFLAGS)  randperm.c 
lp_base_case.o: lp_base_case.c lp.h
	$(CC) $(CFLAGS)  lp_base_case.c 
linprog.o: linprog.c lp.h localmath.h
	$(CC) $(CFLAGS)  linprog.c 
vector_up.o: vector_up.c
	$(CC) $(CFLAGS)  vector_up.c

randomize.o: randomize.c
	$(CC) $(CFLAGS)  randomize.c

do_lp: do_lp.c $(LIBA) lp.h unit2.o
	$(CC) $(CFLAGS2) -o do_lp do_lp.c unit2.o $(LIBA) -lm
lintdo_lp: llib-llinear.ln do_lp.c
	lint -u do_lp.c llib-llinear.ln
randp: randp.c
	$(CC) -g -o randp randp.c -lm
findeps: findeps.c
	$(CC) -o findeps findeps.c -lm

clean:
	rm -f $(DOS) do_lp randp a.out

source.a: $(DCS) README makefile tol.h localmath.h do_lp.c lp.h randp.c
	rm -f source.a; \
	ar qv source.a $(DCS) README makefile tol.h localmath.h do_lp.c \
	lp.h randp.c
