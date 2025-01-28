unset ZE_AFFINITY_MASK
unset EnableImplicitScaling
binary=buildOmegah/src/ugawg_hsc_oshmeshload
srun -n 1 -c 1 ./${binary} --osh-pool Omega_h_Compatibility_Data/deltaWing_500kMetric.osh &> standardrun.txt
binary=buildOmegahConstCompatibility/src/ugawg_hsc_oshmeshload
srun -n 1 -c 1 ./${binary} --osh-pool Omega_h_Compatibility_Data/deltaWing_500kMetric.osh &> compatiblerun.txt
