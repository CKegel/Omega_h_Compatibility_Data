#!/bin/bash

root=`date "+%m-%d-%Y_%H.%M.%S"`
mkdir $root
cd $root
  
rm -rf omegahKkSycl
mkdir omegahKkSycl
cd omegahKkSycl
export OMEGA_H_ROOT=$(pwd)
git clone https://github.com/SCOREC/omega_h.git
git clone -b ck-kokkos-sort https://github.com/CKegel/omega_h.git omega_h-kokkos-sort
git clone -b develop https://github.com/Kokkos/kokkos.git

module load cmake

#use explicit scaling
export EnableImplicitScaling=0
export ZE_AFFINITY_MASK=0.0
    
bdir=$PWD/buildKokkosSycl
     
cmake -S kokkos -B $bdir \
    -DCMAKE_BUILD_TYPE=Release\
    -DCMAKE_CXX_COMPILER=icpx \
    -DCMAKE_CXX_EXTENSIONS=OFF\
    -DCMAKE_CXX_STANDARD=17\
    -DKokkos_ENABLE_TESTS=OFF\
    -DKokkos_ENABLE_SERIAL=ON\
    -DKokkos_ENABLE_OPENMP=OFF\
    -DKokkos_ENABLE_SYCL=ON\
    -DKokkos_ARCH_INTEL_PVC=ON\
    -DBUILD_SHARED_LIBS=OFF\
    -DKokkos_ENABLE_DEBUG=OFF\
    -DKokkos_ENABLE_EXAMPLES=OFF\
    -DCMAKE_CXX_FLAGS="-Wno-deprecated-declarations -Wno-tautological-constant-compare"\
    -DCMAKE_EXE_LINKER_FLAGS="-fsycl-max-parallel-link-jobs=48 -Xsycl-target-backend '-device pvc -options -ftarget-register-alloc-mode=pvc:auto'" \
    -DCMAKE_VERBOSE_MAKEFILE=OFF\
    -DCMAKE_INSTALL_PREFIX=$bdir/install
                     
cmake --build $bdir --target install -j32
                       
bdir=$PWD/buildOmegahKkSyclAot
                        
cmake -S omega_h -B $bdir \
    -DCMAKE_INSTALL_PREFIX=$bdir/install \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=mpicxx \
    -DCMAKE_EXE_LINKER_FLAGS="-fsycl-max-parallel-link-jobs=48 -Xsycl-target-backend '-device pvc -options -ftarget-register-alloc-mode=pvc:auto'" \
    -DBUILD_SHARED_LIBS=OFF \
    -DOmega_h_USE_CUDA=OFF \
    -DOmega_h_USE_OpenMP=OFF \
    -DOmega_h_USE_MPI=ON \
    -DOmega_h_USE_Kokkos=ON \
    -DKokkos_PREFIX=$PWD/buildKokkosSycl/install \
    -DBUILD_TESTING=ON
                         
#build all the tests, takes ~30mins on aurora
cmake --build $bdir -j32

bdir=$PWD/buildOmegahKokkosSortKkSyclAot
                        
cmake -S omega_h-kokkos-sort -B $bdir \
    -DCMAKE_INSTALL_PREFIX=$bdir/install \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=mpicxx \
    -DCMAKE_EXE_LINKER_FLAGS="-fsycl-max-parallel-link-jobs=48 -Xsycl-target-backend '-device pvc -options -ftarget-register-alloc-mode=pvc:auto'" \
    -DBUILD_SHARED_LIBS=OFF \
    -DOmega_h_USE_CUDA=OFF \
    -DOmega_h_USE_OpenMP=OFF \
    -DOmega_h_USE_MPI=ON \
    -DOmega_h_USE_Kokkos=ON \
    -DKokkos_PREFIX=$PWD/buildKokkosSycl/install \
    -DBUILD_TESTING=ON \
    -DOmega_h_FORCE_KOKKOS_SORT=ON
                         
#build all the tests, takes ~30mins on aurora
cmake --build $bdir -j32
