#!/bin/bash -l
#SBATCH -J Peramb_MC0_832_0
#SBATCH -t 1:00:00
#SBATCH -N 8 
##SBATCH -q debug
#SBATCH -p extended
#SBATCH -o /lustre/orion/scratch/mcamacho/stf006/quda_laph/run_single_test/mpirun0/log.task_perambs.DATE-2026-2-25_rocm_7_2_0
##SBATCH -p batch
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mongecamachj@ornl.gov
#SBATCH -A CSC728
export QUDA_ENABLE_P2P=0
export QUDA_ENABLE_GDR=1
export QUDA_ENABLE_DSLASH_POLICY="0,1,6,7"
export MPICH_GPU_SUPPORT_ENABLED=1
export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH


pushd /lustre/orion/scratch/mcamacho/csc728/software/quda_laph/quda_laph_rocm_7_2_0
source ./env.sh
popd

export QUDA_RESOURCE_PATH=./quda_resource
export QUDA_PROFILE_OUTPUT_BASE=profile_test

PROG=${INSTALLROOT}/quda_laph/bin/quda_laph


export OMP_NUM_THREADS=4
umask 007
NPARTITIONS="1 2 2 8"

INXML=./input_perambs_mpirun0.DATE-2025-5-12-TIME-14-17-13.xml
OUTPUT=./output.task_perambs_mpirun0.test_GDR${QUDA_ENABLE_GDR}_P2P${QUDA_ENABLE_P2P}.stdout
#cd /lustre/orion/nph165/proj-shared/cls21_J250_r000/quark_perambulators/832


OUTDIR="\/lustre\/orion\/scratch\/mcamacho\/csc728\/profiling\/prof_runs\/perambs"
MULTISRC=yes
TAG="MULTISRC_${MULTISRC}"

INIBASE="./input_perambs_mpirun0_prof_test.xml"
INXML="./input_perambs_mpirun0_prof_test_${TAG}.xml"
OUTPUT="./input_perambs_mpirun0_prof_test_${TAG}.stdout"
EVEC_IND=7
N_EVECS=8


cp $INIBASE $INXML
sed -i "s/MULTISRC/${MULTISRC}/g" ${INXML}
sed -i "s/OUTDIR/${OUTDIR}/g" ${INXML}
sed -i "s/EVEC_IND/${EVEC_IND}/g" ${INXML}
sed -i "s/N_EVECS/${N_EVECS}/g" ${INXML}



pwd
COMMAND="srun -N 4 -n 32  --ntasks-per-node=8 --gpu-bind=closest  ${PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT}"

echo $COMMAND
eval $COMMAND

