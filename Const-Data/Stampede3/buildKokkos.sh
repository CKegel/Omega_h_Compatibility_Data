#!/bin/bash
 
git clone -b develop https://github.com/Kokkos/kokkos.git
 
module use /soft/modulefiles
module load spack-pe-gcc cmake \
oneapi/eng-compiler/2023.12.15.002 \

#use explicit scaling
export EnableImplicitScaling=0
export ZE_AFFINITY_MASK=0.0
 
bdir=$PWD/buildKokkosSycl
 
cmake -S kokkos -B $bdir \
 -DCMAKE_BUILD_TYPE=Release\
 -DCMAKE_CXX_COMPILER=icpx\
 -DCMAKE_CXX_EXTENSIONS=OFF\
 -DCMAKE_CXX_STANDARD=17\
 -DKokkos_ENABLE_TESTS=OFF\
 -DKokkos_ENABLE_SERIAL=ON\
 -DKokkos_ENABLE_OPENMP=OFF\
 -DKokkos_ENABLE_SYCL=ON\
 -DKokkos_ARCH_INTEL_GEN=ON\
 -DBUILD_SHARED_LIBS=OFF\
 -DKokkos_ENABLE_DEBUG=OFF\
 -DKokkos_ENABLE_EXAMPLES=OFF\
 -DCMAKE_CXX_FLAGS="-Wno-deprecated-declarations -Wno-tautological-constant-compare"\
 -DCMAKE_EXE_LINKER_FLAGS="-fsycl-max-parallel-link-jobs=48" \
 -DCMAKE_VERBOSE_MAKEFILE=OFF\
 -DCMAKE_INSTALL_PREFIX=$bdir/install
 
cmake --build $bdir --target install -j32
