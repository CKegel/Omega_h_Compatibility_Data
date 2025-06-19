#!/bin/bash -l
#PBS -A pcms
#PBS -l select=1
#PBS -N DeltaWingComparison
#PBS -l walltime=00:10:00
#PBS -l filesystems=flare
#PBS -k doe
#PBS -l place=scatter
#PBS -q debug

unset ZE_AFFINITY_MASK
unset EnableImplicitScaling

echo "Main Branch:"
binary=/lus/flare/projects/pcms/omega_h-kokkos-sort/06-18-2025_22.16.00/omegahKkSycl/buildOmegahKkSyclAot/src/ugawg_hsc_oshmeshload
${binary} /lus/flare/projects/pcms/omega_h-kokkos-sort/deltaWing_500kMetric.osh 

echo "Kokkos Sort Branch:"
binary=/lus/flare/projects/pcms/omega_h-kokkos-sort/06-18-2025_22.16.00/omegahKkSycl/buildOmegahKokkosSortKkSyclAot/src/ugawg_hsc_oshmeshload
${binary} /lus/flare/projects/pcms/omega_h-kokkos-sort/deltaWing_500kMetric.osh
