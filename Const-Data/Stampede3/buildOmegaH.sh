#!/bin/bash

#module use /soft/modulefiles

#use explicit scaling
export EnableImplicitScaling=0
export ZE_AFFINITY_MASK=0.0

#git clone https://github.com/CKegel/omega_h.git
#git clone -b const_compatibility https://github.com/CKegel/omega_h.git omega_h-const-compatibility

bdir=$PWD/buildOmegah

cmake -S omega_h -B $bdir \
-DCMAKE_INSTALL_PREFIX=$bdir/install \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_COMPILER=icpx \
-DCMAKE_EXE_LINKER_FLAGS="-fsycl-max-parallel-link-jobs=48" \
-DBUILD_SHARED_LIBS=OFF \
-DOmega_h_USE_CUDA=OFF \
-DOmega_h_USE_OpenMP=OFF \
-DOmega_h_USE_MPI=ON \
-DOmega_h_USE_Kokkos=ON \
-DKokkos_PREFIX=$PWD/buildKokkosSycl/install \
-DBUILD_TESTING=ON

cmake --build $bdir -j32 --target ugawg_hsc_oshmeshload

bdir=$PWD/buildOmegahConstCompatibility

cmake -S omega_h-const-compatibility -B $bdir \
-DCMAKE_INSTALL_PREFIX=$bdir/install \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_CXX_COMPILER=icpx \
-DCMAKE_EXE_LINKER_FLAGS="-fsycl-max-parallel-link-jobs=48" \
-DBUILD_SHARED_LIBS=OFF \
-DOmega_h_USE_CUDA=OFF \
-DOmega_h_USE_OpenMP=OFF \
-DOmega_h_USE_MPI=ON \
-DOmega_h_USE_Kokkos=ON \
-DKokkos_PREFIX=$PWD/buildKokkosSycl/install \
-DBUILD_TESTING=ON

cmake --build $bdir -j32 --target ugawg_hsc_oshmeshload
