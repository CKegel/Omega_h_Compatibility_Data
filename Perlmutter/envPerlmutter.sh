module load PrgEnv-gnu
module load cudatoolkit/12.2
module load cmake/3.24.3
#cuda 11.7 is loaded/available by default
#craype-accel-nvidia80 is loaded by default
export root=$PWD
export kk=$root/build-kokkos-perlmutter/install
export libMesh=$root/build-libMeshb-perlmutter/install
export CMAKE_PREFIX_PATH=$kk:$kk/lib64/cmake:$libMesh:$libMesh/lib/cmake:$CMAKE_PREFIX_PATH
cm=`which cmake`
echo "cmake: $cm"
echo "kokkos install dir: $kk"
