export FCOMP = gfortran
export FCFLAGS = -fPIC -O3 -funroll-loops -ftree-parallelize-loops=4 -march=native -fopenmp # -fno-underscoring -g -fno-omit-frame-pointer
# export FCFLAGS = -fPIC -O3 -funroll-loops -march=native -ffast-math
 #export FCFLAGS = -fPIC -O3 -funroll-loops -march=native -std=f2008
# export FCFLAGS = -g -fPIC -fcheck=all -fbacktrace -pedantic -fno-omit-frame-pointer  -ffpe-trap=invalid,zero,overflow,underflow,precision,denormal -std=f2008 -W -Wtabs -O -fbacktrace -fbounds-check -fstack-arrays -fno-underscoring

# export GFORTRAN_UNBUFFERED_ALL = 1
# export FCOMP = ifort
# export FCFLAGS = -fPIC -O3 -funroll-loops -march=native -fopenmp -heap-arrays -xHost -wrap-margin- 
#  # export FCFLAGS = -fpic -O0 -g3 -stand f08 -traceback  -fstack-protector  -assume protect_parens  -implicitnone -check bounds -ftrapuv -debug all -fpe-all=0 -no-ftz -wrap-margin-
#export FCFLAGS = -L/home/ad214/Software/intel/mkl/lib/intel64/ -L/home/ad214/Software/intel/mkl/lib/intel64_lin/  -fPIC -O3 -funroll-loops -march=native -fomit-frame-pointer -wrap-margin- -xHost -heap-arrays -assume nounderscore
#
# export LDFLAGS = -L/home/ad214/Software/intel/mkl/lib/intel64/ -L/home/ad214/Software/intel/mkl/lib/intel64_lin/ -llapack -shared -lmkl_intel_lp64 -lmkl_core -lmkl_intel_thread -liomp5 -ldl -lpthread

export LDFLAGS = -L$(LAPACK_LIB_DIR) -llapack -shared -fopenmp
FOLDER = src/
LIBRARY_NAME =  libxbeam
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
EXT=so
endif
ifeq ($(UNAME), Darwin)
EXT=dylib
endif

LIBRARY = $(LIBRARY_NAME:=.$(EXT))
export LIBRARY

all: $(LIBRARY)

install: $(LIBRARY)
	mv ./lib/$(LIBRARY) ../sharpy/lib/$(LIBRARY)

$(LIBRARY):
	$(MAKE) -C src
	mkdir -p ./lib
	mv $(FOLDER)$(LIBRARY) ./lib/$(LIBRARY)

.PHONY: clean veryclean

clean:
	rm -f *.o *.mod *.MOD
	rm -f ./lib/$(LIBRARY)
	$(MAKE) -C src clean

veryclean: clean
	rm -f *~ $(LIBRARY)
	$(MAKE) -C src veryclean
