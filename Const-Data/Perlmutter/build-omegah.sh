#!/bin/bash -ex

usage="Usage: $0  <mpi=on|off> <libmeshb=on|off>"
[[ $# -ne 2 ]] && echo $usage && exit 1

mpi=$1
[[ $mpi != "on" && $mpi != "off" ]] && echo $usage && exit 1

libmeshb=$2
[[ $libmeshb != "on" && $libmeshb != "off" ]] && echo $usage && exit 1

git clone https://github.com/CKegel/omega_h.git
git clone -b const_compatibility https://github.com/CKegel/omega_h.git omega_h_const_compatibility

bdir=build-omega_h-perlmutter
cmake -S omega_h -B $bdir \
  -DCMAKE_INSTALL_PREFIX=$PWD/install \
  -DBUILD_SHARED_LIBS=on \
  -DOmega_h_USE_Kokkos=on \
  -DOmega_h_CUDA_ARCH=80 \
  -DOmega_h_USE_MPI=$mpi \
  -DOmega_h_USE_libMeshb=$libmeshb \
  -DBUILD_TESTING=on \
  -DCMAKE_CXX_COMPILER=CC

cmake --build $bdir -j8

bdir=build-omegah-const-compatibility-perlmutter
cmake -S omega_h_const_compatibility -B $bdir \
  -DCMAKE_INSTALL_PREFIX=$PWD/install \
  -DBUILD_SHARED_LIBS=on \
  -DOmega_h_USE_Kokkos=on \
  -DOmega_h_CUDA_ARCH=80 \
  -DOmega_h_USE_MPI=$mpi \
  -DOmega_h_USE_libMeshb=$libmeshb \
  -DBUILD_TESTING=on \
  -DCMAKE_CXX_COMPILER=CC

cmake --build $bdir -j8

