#----- Libmeshb (for deltawing adapt benchmark) -----#
cd $root
git clone git@github.com:LoicMarechal/libMeshb.git
bdir=build-libMeshb-perlmutter
cmake -S libMeshb -B $bdir \
  -DCMAKE_C_COMPILER=gcc \
  -DBUILD_SHARED_LIBS=on \
  -DCMAKE_Fortran_COMPILER=gfortran \
  -DCMAKE_INSTALL_PREFIX=$bdir/install
cmake --build ${bdir%%install} --target install -j8

#----- Kokkos -----#
cd $root
git clone -b develop git@github.com:Kokkos/kokkos.git
bdir=build-kokkos-perlmutter
cmake -S kokkos -B $bdir \
  -DBUILD_SHARED_LIBS=ON \
  -DCRAYPE_LINK_TYPE=dynamic \
  -DCMAKE_CXX_COMPILER=$PWD/kokkos/bin/nvcc_wrapper \
  -DKokkos_ARCH_AMPERE80=ON \
  -DKokkos_ENABLE_SERIAL=ON \
  -DKokkos_ENABLE_OPENMP=off \
  -DKokkos_ENABLE_CUDA=on \
  -DKokkos_ENABLE_CUDA_LAMBDA=on \
  -DKokkos_ENABLE_DEBUG=off \
  -DCMAKE_INSTALL_PREFIX=$bdir/install
cmake --build ${bdir%%install} -j8 --target install
