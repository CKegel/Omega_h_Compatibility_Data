git clone -b develop https://github.com/kokkos/kokkos.git # tested with 6d2005a5c

buildType=$1
[[ $buildType != "release" && $buildType != "debug" && $buildType != "RelWithDebInfo" ]] && 
  echo " buildType != [release|debug|RelWithDebInfo] " &&
  exit 1

compiler=$2
[[ $compiler != "amdclang" && $compiler != "hipcc" ]] && 
  echo " compiler != [amdclang|hipcc] " &&
  exit 1

cxx=""
[[ $compiler == "amdclang" ]] && cxx="CC"
[[ $compiler == "hipcc" ]] && cxx="hipcc"

bdir=$PWD/buildKokkosVega90a_${buildType}_${compiler}
 
cmake -S ./kokkos -B $bdir \
 -DCMAKE_BUILD_TYPE=${buildType}\
 -DCMAKE_CXX_COMPILER=${cxx} \
 -DCMAKE_CXX_STANDARD=17 \
 -DCMAKE_CXX_EXTENSIONS=OFF\
 -DKokkos_ENABLE_TESTS=OFF\
 -DKokkos_ENABLE_EXAMPLES=OFF\
 -DKokkos_ENABLE_SERIAL=ON\
 -DKokkos_ENABLE_OPENMP=OFF\
 -DKokkos_ENABLE_HIP=ON\
 -DKokkos_ARCH_VEGA90A=ON\
 -DKokkos_ENABLE_DEBUG=OFF\
 -DCMAKE_INSTALL_PREFIX=$bdir/install

cmake --build $bdir -j8 --target install
