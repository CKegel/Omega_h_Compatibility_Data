echo "Main Branch:"
binary=build-omega_h/src/ugawg_hsc_oshmeshload
./${binary} $root/deltaWing_500kMetric.osh
echo "Const-Compatibility Branch:"
binary=build-omega_h-kokkos-sort/src/ugawg_hsc_oshmeshload
./${binary} $root/deltaWing_500kMetric.osh
