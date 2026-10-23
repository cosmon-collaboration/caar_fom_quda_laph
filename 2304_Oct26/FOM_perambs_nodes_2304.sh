#!/bin/bash -l
#SBATCH -J FOM_QUDA_LAPH_Perambs
#SBATCH -t 1:00:00
#SBATCH -N 2304
#SBATCH -o /lustre/orion/scratch/mcamacho/csc728/FOM/2304/FOM_QUDA_LAPH_Perambs_nodes_2304.log
#SBATCH -p batch
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mongecamachj@ornl.gov
#SBATCH -C nvme
#SBATCH -A NPH165

export QUDA_ENABLE_P2P=0
export QUDA_ENABLE_GDR=1
export QUDA_ENABLE_DSLASH_POLICY="0,1,6,7"
export MPICH_GPU_SUPPORT_ENABLED=1
export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

pushd /lustre/orion/scratch/mcamacho/csc728/software/quda_laph/quda_laph_rocm_7_2_0
source env.sh
popd
export QUDA_RESOURCE_PATH=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/quda_resource
export QUDA_PROFILE_OUTPUT_BASE=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/quda_resource/profile_Perambs

EXE=quda_laph
PROG=${INSTALLROOT}/quda_laph/bin/${EXE}


sbcast --send-libs -pf ${PROG} /mnt/bb/$USER/${EXE}
if [ ! "$?" == "0" ]; then
    # CHECK EXIT CODE. When SBCAST fails, it may leave partial files on the compute nodes, and if you continue to launch srun,
    # your application may pick up partially complete shared library files, which would give you confusing errors.
    echo "SBCAST failed!"
    exit 1
fi

LOC_PROG=/mnt/bb/$USER/${EXE}

echo "*****ls -lh /mnt/bb/$USER*****"
ls -lh /mnt/bb/$USER/
echo "*****ls -lh /mnt/bb/$USER/${EXE}_libs*****"
ls -lh /mnt/bb/$USER/${EXE}_libs

export LD_LIBRARY_PATH="/mnt/bb/$USER/${exe}_libs:${LD_LIBRARY_PATH}"


export OMP_NUM_THREADS=4
umask 007
NPARTITIONS="2 4 4 6"

# Capture the QUDA environment in a subshell, save it to a file
env | grep -E '^[A-Za-z_][A-Za-z0-9_]*='     | grep -vE '^(BASH_FUNC_|SLURM_|FLUX_|PS1=|PROMPT_COMMAND=|_=)'     | grep -vE '^(CUDA|HIP|ROCR)_VISIBLE_DEVICES=|^GPU_DEVICE_ORDINAL='     | grep -v '\$'     > "$QUDA_ENV_FILE"

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun0/perambs_cfg600_srct_2.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun0/perambs_cfg600_srct_2.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun0
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun1/perambs_cfg600_srct_6.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun1/perambs_cfg600_srct_6.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun1
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun2/perambs_cfg600_srct_10.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun2/perambs_cfg600_srct_10.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun2
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun3/perambs_cfg600_srct_14.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun3/perambs_cfg600_srct_14.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun3
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun4/perambs_cfg600_srct_18.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun4/perambs_cfg600_srct_18.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun4
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun5/perambs_cfg600_srct_22.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun5/perambs_cfg600_srct_22.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun5
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun6/perambs_cfg600_srct_26.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun6/perambs_cfg600_srct_26.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun6
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun7/perambs_cfg600_srct_30.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun7/perambs_cfg600_srct_30.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun7
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun8/perambs_cfg600_srct_34.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun8/perambs_cfg600_srct_34.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun8
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun9/perambs_cfg600_srct_38.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun9/perambs_cfg600_srct_38.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun9
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun10/perambs_cfg600_srct_42.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun10/perambs_cfg600_srct_42.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun10
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun11/perambs_cfg600_srct_46.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun11/perambs_cfg600_srct_46.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun11
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun12/perambs_cfg600_srct_50.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun12/perambs_cfg600_srct_50.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun12
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun13/perambs_cfg600_srct_54.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun13/perambs_cfg600_srct_54.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun13
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun14/perambs_cfg600_srct_58.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun14/perambs_cfg600_srct_58.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun14
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun15/perambs_cfg600_srct_62.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun15/perambs_cfg600_srct_62.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun15
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun16/perambs_cfg600_srct_66.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun16/perambs_cfg600_srct_66.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun16
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun17/perambs_cfg600_srct_70.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun17/perambs_cfg600_srct_70.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun17
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun18/perambs_cfg600_srct_74.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun18/perambs_cfg600_srct_74.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun18
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun19/perambs_cfg600_srct_78.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun19/perambs_cfg600_srct_78.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun19
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun20/perambs_cfg600_srct_82.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun20/perambs_cfg600_srct_82.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun20
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun21/perambs_cfg600_srct_86.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun21/perambs_cfg600_srct_86.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun21
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun22/perambs_cfg600_srct_90.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun22/perambs_cfg600_srct_90.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun22
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun23/perambs_cfg600_srct_94.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun23/perambs_cfg600_srct_94.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun23
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun24/perambs_cfg600_srct_98.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun24/perambs_cfg600_srct_98.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun24
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun25/perambs_cfg600_srct_102.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun25/perambs_cfg600_srct_102.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun25
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun26/perambs_cfg600_srct_106.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun26/perambs_cfg600_srct_106.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun26
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun27/perambs_cfg600_srct_110.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun27/perambs_cfg600_srct_110.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun27
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun28/perambs_cfg600_srct_114.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun28/perambs_cfg600_srct_114.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun28
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun29/perambs_cfg600_srct_118.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun29/perambs_cfg600_srct_118.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun29
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun30/perambs_cfg600_srct_122.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun30/perambs_cfg600_srct_122.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun30
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun31/perambs_cfg600_srct_126.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun31/perambs_cfg600_srct_126.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun31
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun32/perambs_cfg600_srct_130.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun32/perambs_cfg600_srct_130.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun32
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun33/perambs_cfg600_srct_134.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun33/perambs_cfg600_srct_134.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun33
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun34/perambs_cfg600_srct_138.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun34/perambs_cfg600_srct_138.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun34
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun35/perambs_cfg600_srct_142.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun35/perambs_cfg600_srct_142.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun35
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun36/perambs_cfg600_srct_146.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun36/perambs_cfg600_srct_146.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun36
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun37/perambs_cfg600_srct_150.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun37/perambs_cfg600_srct_150.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun37
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun38/perambs_cfg600_srct_154.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun38/perambs_cfg600_srct_154.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun38
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun39/perambs_cfg600_srct_158.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun39/perambs_cfg600_srct_158.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun39
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun40/perambs_cfg600_srct_162.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun40/perambs_cfg600_srct_162.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun40
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun41/perambs_cfg600_srct_166.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun41/perambs_cfg600_srct_166.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun41
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun42/perambs_cfg600_srct_170.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun42/perambs_cfg600_srct_170.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun42
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun43/perambs_cfg600_srct_174.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun43/perambs_cfg600_srct_174.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun43
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun44/perambs_cfg600_srct_178.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun44/perambs_cfg600_srct_178.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun44
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun45/perambs_cfg600_srct_182.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun45/perambs_cfg600_srct_182.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun45
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun46/perambs_cfg600_srct_186.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun46/perambs_cfg600_srct_186.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun46
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun47/perambs_cfg600_srct_190.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun47/perambs_cfg600_srct_190.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/600/mpirun47
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun0/perambs_cfg604_srct_2.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun0/perambs_cfg604_srct_2.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun0
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun1/perambs_cfg604_srct_6.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun1/perambs_cfg604_srct_6.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun1
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun2/perambs_cfg604_srct_10.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun2/perambs_cfg604_srct_10.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun2
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun3/perambs_cfg604_srct_14.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun3/perambs_cfg604_srct_14.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun3
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun4/perambs_cfg604_srct_18.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun4/perambs_cfg604_srct_18.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun4
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun5/perambs_cfg604_srct_22.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun5/perambs_cfg604_srct_22.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun5
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun6/perambs_cfg604_srct_26.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun6/perambs_cfg604_srct_26.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun6
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun7/perambs_cfg604_srct_30.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun7/perambs_cfg604_srct_30.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun7
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun8/perambs_cfg604_srct_34.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun8/perambs_cfg604_srct_34.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun8
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun9/perambs_cfg604_srct_38.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun9/perambs_cfg604_srct_38.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun9
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun10/perambs_cfg604_srct_42.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun10/perambs_cfg604_srct_42.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun10
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun11/perambs_cfg604_srct_46.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun11/perambs_cfg604_srct_46.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun11
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun12/perambs_cfg604_srct_50.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun12/perambs_cfg604_srct_50.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun12
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun13/perambs_cfg604_srct_54.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun13/perambs_cfg604_srct_54.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun13
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun14/perambs_cfg604_srct_58.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun14/perambs_cfg604_srct_58.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun14
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun15/perambs_cfg604_srct_62.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun15/perambs_cfg604_srct_62.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun15
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun16/perambs_cfg604_srct_66.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun16/perambs_cfg604_srct_66.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun16
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun17/perambs_cfg604_srct_70.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun17/perambs_cfg604_srct_70.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun17
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun18/perambs_cfg604_srct_74.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun18/perambs_cfg604_srct_74.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun18
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun19/perambs_cfg604_srct_78.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun19/perambs_cfg604_srct_78.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun19
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun20/perambs_cfg604_srct_82.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun20/perambs_cfg604_srct_82.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun20
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun21/perambs_cfg604_srct_86.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun21/perambs_cfg604_srct_86.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun21
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun22/perambs_cfg604_srct_90.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun22/perambs_cfg604_srct_90.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun22
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun23/perambs_cfg604_srct_94.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun23/perambs_cfg604_srct_94.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun23
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun24/perambs_cfg604_srct_98.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun24/perambs_cfg604_srct_98.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun24
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun25/perambs_cfg604_srct_102.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun25/perambs_cfg604_srct_102.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun25
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun26/perambs_cfg604_srct_106.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun26/perambs_cfg604_srct_106.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun26
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun27/perambs_cfg604_srct_110.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun27/perambs_cfg604_srct_110.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun27
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun28/perambs_cfg604_srct_114.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun28/perambs_cfg604_srct_114.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun28
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun29/perambs_cfg604_srct_118.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun29/perambs_cfg604_srct_118.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun29
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun30/perambs_cfg604_srct_122.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun30/perambs_cfg604_srct_122.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun30
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun31/perambs_cfg604_srct_126.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun31/perambs_cfg604_srct_126.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun31
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun32/perambs_cfg604_srct_130.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun32/perambs_cfg604_srct_130.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun32
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun33/perambs_cfg604_srct_134.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun33/perambs_cfg604_srct_134.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun33
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun34/perambs_cfg604_srct_138.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun34/perambs_cfg604_srct_138.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun34
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun35/perambs_cfg604_srct_142.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun35/perambs_cfg604_srct_142.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun35
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun36/perambs_cfg604_srct_146.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun36/perambs_cfg604_srct_146.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun36
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun37/perambs_cfg604_srct_150.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun37/perambs_cfg604_srct_150.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun37
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun38/perambs_cfg604_srct_154.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun38/perambs_cfg604_srct_154.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun38
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun39/perambs_cfg604_srct_158.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun39/perambs_cfg604_srct_158.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun39
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun40/perambs_cfg604_srct_162.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun40/perambs_cfg604_srct_162.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun40
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun41/perambs_cfg604_srct_166.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun41/perambs_cfg604_srct_166.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun41
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun42/perambs_cfg604_srct_170.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun42/perambs_cfg604_srct_170.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun42
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun43/perambs_cfg604_srct_174.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun43/perambs_cfg604_srct_174.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun43
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun44/perambs_cfg604_srct_178.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun44/perambs_cfg604_srct_178.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun44
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun45/perambs_cfg604_srct_182.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun45/perambs_cfg604_srct_182.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun45
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun46/perambs_cfg604_srct_186.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun46/perambs_cfg604_srct_186.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun46
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

INXML=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun47/perambs_cfg604_srct_190.xml
OUTPUT=/lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun47/perambs_cfg604_srct_190.stdout
pushd /lustre/orion/scratch/mcamacho/csc728/FOM/2304/604/mpirun47
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${LOC_PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &

popd
sleep 1

wait

rm -rf /mnt/bb/$USER/*