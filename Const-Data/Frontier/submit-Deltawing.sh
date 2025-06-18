#!/bin/bash
#SBATCH -A cli193
#SBATCH -N 1
#SBATCH -J RunDeltaWingComparison
#SBATCH -t 00:10:00
#SBATCH -q debug
#SBATCH --gpus-per-task=1
#SBATCH --gpu-bind=closest

OMP_NUM_THREADS=1

echo "Main Branch:"
binary=buildOmegahVega90a_MPIoff_release_hipcc/src/ugawg_hsc_oshmeshload
srun -n1 -c1 ./${binary} $root/deltaWing_500kMetric.osh 

echo "Const-Compatibility Branch:"
binary=buildOmegahConstCompatibilityVega90a_MPIoff_release_hipcc/src/ugawg_hsc_oshmeshload
srun -n1 -c1 ./${binary} $root/deltaWing_500kMetric.osh 
