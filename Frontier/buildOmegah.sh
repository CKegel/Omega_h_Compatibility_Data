buildType=$1
[[ $buildType != "release" && $buildType != "debug" && $buildType != "RelWithDebInfo" ]] && 
  echo " buildType != [release|debug|RelWithDebInfo] " &&
  exit 1

mpi=off

compiler=$2
[[ $compiler != "amdclang" && $compiler != "hipcc" ]] && 
  echo " compiler != [amdclang|hipcc] " &&
  exit 1

libmesh=$3
[[ $libmesh != "on" && $libmesh != "off" ]] && 
  echo " libmesh != [on|off] " &&
  exit 1

libmeshArgs=""
[[ $libmesh == "on" ]] && libmeshArgs="-DlibMeshb_PREFIX=$PWD/buildLibMeshbVega90a_release/install"

cxx=""
[[ $compiler == "amdclang" ]] && cxx="CC"
[[ $compiler == "hipcc" ]] && cxx="hipcc"

git clone https://github.com/CKegel/omega_h.git
git clone -b const_compatibility https://github.com/CKegel/omega_h.git omega_h-const-compatibility


bdir=$PWD/buildOmegahVega90a_MPI${mpi}_${buildType}_${compiler}
 
cmake -S ./omega_h -B $bdir \
-DCMAKE_BUILD_TYPE=${buildType} \
-DCMAKE_INSTALL_PREFIX=$bdir/install \
-DBUILD_SHARED_LIBS=OFF \
-DOmega_h_USE_MPI=$mpi \
-DOmega_h_USE_OpenMP=OFF \
-DCMAKE_CXX_COMPILER=${cxx} \
-DOmega_h_USE_Kokkos=ON \
-DKokkos_PREFIX=$PWD/buildKokkosVega90a_${buildType}_${compiler}/install \
-DOmega_h_USE_libMeshb=${libmesh} \
${libmeshArgs} \
-DBUILD_TESTING=ON

cmake --build $bdir -j8

bdir=$PWD/buildOmegahConstCompatibilityVega90a_MPI${mpi}_${buildType}_${compiler}
cmake -S ./omega_h-const-compatibility -B $bdir \
-DCMAKE_BUILD_TYPE=${buildType} \
-DCMAKE_INSTALL_PREFIX=$bdir/install \
-DBUILD_SHARED_LIBS=OFF \
-DOmega_h_USE_MPI=$mpi \
-DOmega_h_USE_OpenMP=OFF \
-DCMAKE_CXX_COMPILER=${cxx} \
-DOmega_h_USE_Kokkos=ON \
-DKokkos_PREFIX=$PWD/buildKokkosVega90a_${buildType}_${compiler}/install \
-DOmega_h_USE_libMeshb=${libmesh} \
${libmeshArgs} \
-DBUILD_TESTING=ON

cmake --build $bdir -j8

