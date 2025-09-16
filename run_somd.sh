#!/bin/bash
#SBATCH --job-name=a3fe_run
#SBATCH --output=somd-array-gpu-%A.%a.out
#SBATCH --partition=gpu
#SBATCH --nodes=1                 # optional clarity
#SBATCH --ntasks-per-node=1       # optional clarity (== --ntasks=1)
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --mem=16G
#SBATCH --gpus=1                  # or: #SBATCH --gres=gpu:1

# Activate your A3FE env (Sire + OpenMM)
set +u
source "/opt/software/pkgs/Anaconda3/2024.02-1/etc/profile.d/conda.sh"
conda activate a3fe-gpu
set -u
export OMP_NUM_THREADS="$SLURM_CPUS_PER_TASK"
export OPENMM_DEFAULT_PLATFORM=CUDA

# Lambda from first argument
lam="$1"
echo "lambda is: $lam"

# Run SOMD on the GPU
srun somd-freenrg -C somd.cfg -l "$lam" -p CUDA
set +u
conda deactivate || true
set -u
