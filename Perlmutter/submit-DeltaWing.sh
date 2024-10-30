#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --constraint=gpu
#SBATCH --qos=debug
#SBATCH --account=m4274
#SBATCH --gpus-per-node=1
# set up for problem & define any environment variables here
echo "Main Branch:"
binary=build-omega_h-perlmutter/src/ugawg_hsc_oshmeshload
srun -n 1 -c 1 ./${binary} $root/deltaWing_500kMetric.osh
echo "Const-Compatibility Branch:"
binary=build-omegah-const-compatibility-perlmutter/src/ugawg_hsc_oshmeshload
srun -n 1 -c 1 ./${binary} $root/deltaWing_500kMetric.osh
