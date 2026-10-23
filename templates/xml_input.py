peramb_ud_s_task='''<QudaLaph>
   <LatticeLayoutInfo>
      <XYZTExtents>96 96 96 192</XYZTExtents>
   </LatticeLayoutInfo>
   <QudaInfo>
      <CPUPrecision>double</CPUPrecision>
      <CUDAPrecision>double</CUDAPrecision>
      <CUDASloppyPrecision>single</CUDASloppyPrecision>
   </QudaInfo>
   <Verbosity>low</Verbosity>
   <EchoXML></EchoXML>
   <Task>
      <Name>SMEAR_GAUGE_FIELD</Name>
      <GaugeConfigurationInfo>
         <EnsembleName>CLS_E250</EnsembleName>
         <ConfigType>WilsonImproved</ConfigType>
         <FileFormat>CERN</FileFormat>
         <MarkovChainNumber>1</MarkovChainNumber>
         <ConfigNumber>%(NCFG)s</ConfigNumber>
         <FileName>%(CFG_FILE)s</FileName>
      </GaugeConfigurationInfo>
      <GluonStoutSmearingInfo>
         <LinkIterations>48</LinkIterations>
         <LinkStapleWeight>0.1</LinkStapleWeight>
      </GluonStoutSmearingInfo>
   </Task>
   <Task>
      <Name>SMEAR_QUARK_FIELD</Name>
      <GaugeConfigurationInfo>
         <EnsembleName>CLS_E250</EnsembleName>
         <ConfigType>WilsonImproved</ConfigType>
         <FileFormat>CERN</FileFormat>
         <MarkovChainNumber>1</MarkovChainNumber>
         <ConfigNumber>%(NCFG)s</ConfigNumber>
         <FileName>%(CFG_FILE)s</FileName>
      </GaugeConfigurationInfo>
      <GluonStoutSmearingInfo>
         <LinkIterations>48</LinkIterations>
         <LinkStapleWeight>0.1</LinkStapleWeight>
      </GluonStoutSmearingInfo>
      <QuarkLaphSmearingInfo>
         <LaphSigmaCutoff>0.077</LaphSigmaCutoff>
         <NumberLaphEigvecs>768</NumberLaphEigvecs>
      </QuarkLaphSmearingInfo>
      <LaphEigenSolverInfo>
         <ResidualTolerance>1.0e-12</ResidualTolerance>
         <MaxIterations>200</MaxIterations>
         <KrylovDimension>1024</KrylovDimension>
         <ChebyshevOrder>64</ChebyshevOrder>
         <MaxEigenvalue>12.01</MaxEigenvalue>
         <CutoffEigenvalue>0.085</CutoffEigenvalue>
         <StartingVectorType>equal_components</StartingVectorType>
      </LaphEigenSolverInfo>
   </Task>
   <Task>
      <Name>LAPH_QUARK_PERAMBULATORS</Name>
      <QuarkPerambulatorInfo>
         <GaugeConfigurationInfo>
            <EnsembleName>CLS_E250</EnsembleName>
            <ConfigType>WilsonImproved</ConfigType>
            <FileFormat>CERN</FileFormat>
            <MarkovChainNumber>1</MarkovChainNumber>
            <ConfigNumber>%(NCFG)s</ConfigNumber>
            <FileName>%(CFG_FILE)s</FileName>
         </GaugeConfigurationInfo>
         <GluonStoutSmearingInfo>
            <LinkIterations>48</LinkIterations>
            <LinkStapleWeight>0.1</LinkStapleWeight>
         </GluonStoutSmearingInfo>
         <QuarkLaphSmearingInfo>
            <LaphSigmaCutoff>0.077</LaphSigmaCutoff>
            <NumberLaphEigvecs>768</NumberLaphEigvecs>
         </QuarkLaphSmearingInfo>
         <QuarkActionInfo>
            <Name>WILSON_CLOVER</Name>
            <Flavor>ud</Flavor>
            <Kappa>0.137232867</Kappa>
            <clovCoeff>1.8248654</clovCoeff>
            <TimeBC>antiperiodic</TimeBC>
         </QuarkActionInfo>
         <FileListInfo>
            <FileNameStub>%(PERAMB_DIR)s/%(NCFG)s/mpirun%(NMPI)s/quark_perambs_ud_%(NCFG)s</FileNameStub>
            <MinFileNumber>0</MinFileNumber>
            <MaxFileNumber>7</MaxFileNumber>
         </FileListInfo>
         <InverterInfo>
            <Name>GCR_MULTIGRID</Name>
            <Tolerance>1.0e-12</Tolerance>
            <MaxIterations>150</MaxIterations>
            <NKrylov>24</NKrylov>
            <MGPreconditioner>
               <NumLevels>3</NumLevels>
               <Level0>
                  <XYZTBlockExtents>6 6 6 4</XYZTBlockExtents>
                  <NullSpaceDim>S</NullSpaceDim>
                  <NullSpaceSolveSteps>500</NullSpaceSolveSteps>
                  <CoarseSolverTolerance>0.25</CoarseSolverTolerance>
                  <CoarseSolverMaxIterations>150</CoarseSolverMaxIterations>
                  <NumPreSmooth>0</NumPreSmooth>
                  <NumPostSmooth>6</NumPostSmooth>
               </Level0>
               <Level1>
                  <XYZTBlockExtents>4 2 2 4</XYZTBlockExtents>
                  <NullSpaceDim>S</NullSpaceDim>
                  <NullSpaceSolveSteps>500</NullSpaceSolveSteps>
                  <CoarseSolverTolerance>0.25</CoarseSolverTolerance>
                  <CoarseSolverMaxIterations>150</CoarseSolverMaxIterations>
                  <NumPreSmooth>0</NumPreSmooth>
                  <NumPostSmooth>6</NumPostSmooth>
               </Level1>
               <Level2>
                  <CoarseSolverTolerance>0.1</CoarseSolverTolerance>
                  <CoarseSolverMaxIterations>300</CoarseSolverMaxIterations>
                  <TRLMDeflation>
                     <NumVectors>1536</NumVectors>
                     <Tolerance>1.0e-06</Tolerance>
                     <MaxIterations>200</MaxIterations>
                     <ChebyshevOrder>32</ChebyshevOrder>
                     <CutoffEigenvalue>0.015</CutoffEigenvalue>
                  </TRLMDeflation>
               </Level2>
               <LoadNullVectors>false</LoadNullVectors>
               <GenerateAllLevels>true</GenerateAllLevels>
               <PreOrthoNullVectors>true</PreOrthoNullVectors>
               <PostOrthoNullVectors>true</PostOrthoNullVectors>
               <RunVerify>false</RunVerify>
            </MGPreconditioner>
         </InverterInfo>
      </QuarkPerambulatorInfo>
      <ComputationSet>
         <UseMultiSrcInverter>no</UseMultiSrcInverter>
         <NumSinksBeforeProject>24</NumSinksBeforeProject>
         <NumSinksInProjectBatch>24</NumSinksInProjectBatch>
         <NumEigsInProjectBatch>24</NumEigsInProjectBatch>
         <Computation>
            <SourceTime>%(SRCT1)s</SourceTime>
            <SourceLaphEigvecIndexMin>0</SourceLaphEigvecIndexMin>
            <SourceLaphEigvecIndexMax>767</SourceLaphEigvecIndexMax>
         </Computation>
         <Computation>
            <SourceTime>%(SRCT2)s</SourceTime>
            <SourceLaphEigvecIndexMin>0</SourceLaphEigvecIndexMin>
            <SourceLaphEigvecIndexMax>767</SourceLaphEigvecIndexMax>
         </Computation>
      </ComputationSet>
   </Task>
   <Task>
      <Name>LAPH_QUARK_PERAMBULATORS</Name>
      <QuarkPerambulatorInfo>
         <GaugeConfigurationInfo>
            <EnsembleName>CLS_E250</EnsembleName>
            <ConfigType>WilsonImproved</ConfigType>
            <FileFormat>CERN</FileFormat>
            <MarkovChainNumber>1</MarkovChainNumber>
            <ConfigNumber>%(NCFG)s</ConfigNumber>
            <FileName>%(CFG_FILE)s</FileName>
         </GaugeConfigurationInfo>
         <GluonStoutSmearingInfo>
            <LinkIterations>48</LinkIterations>
            <LinkStapleWeight>0.1</LinkStapleWeight>
         </GluonStoutSmearingInfo>
         <QuarkLaphSmearingInfo>
            <LaphSigmaCutoff>0.077</LaphSigmaCutoff>
            <NumberLaphEigvecs>768</NumberLaphEigvecs>
         </QuarkLaphSmearingInfo>
         <QuarkActionInfo>
            <Name>WILSON_CLOVER</Name>
            <Flavor>s</Flavor>
            <Kappa>0.136536633</Kappa>
            <clovCoeff>1.8248654</clovCoeff>
            <TimeBC>antiperiodic</TimeBC>
         </QuarkActionInfo>
         <FileListInfo>
            <FileNameStub>%(PERAMB_DIR)s/%(NCFG)s/mpirun%(NMPI)s/quark_perambs_s_%(NCFG)s</FileNameStub>
            <MinFileNumber>0</MinFileNumber>
            <MaxFileNumber>7</MaxFileNumber>
         </FileListInfo>
         <InverterInfo>
            <Name>GCR_MULTIGRID</Name>
            <Tolerance>1.0e-12</Tolerance>
            <MaxIterations>150</MaxIterations>
            <NKrylov>24</NKrylov>
            <MGPreconditioner>
               <NumLevels>3</NumLevels>
               <Level0>
                  <XYZTBlockExtents>6 6 6 4</XYZTBlockExtents>
                  <NullSpaceDim>S</NullSpaceDim>
                  <NullSpaceSolveSteps>500</NullSpaceSolveSteps>
                  <CoarseSolverTolerance>0.25</CoarseSolverTolerance>
                  <CoarseSolverMaxIterations>150</CoarseSolverMaxIterations>
                  <NumPreSmooth>0</NumPreSmooth>
                  <NumPostSmooth>6</NumPostSmooth>
               </Level0>
               <Level1>
                  <XYZTBlockExtents>4 2 2 4</XYZTBlockExtents>
                  <NullSpaceDim>S</NullSpaceDim>
                  <NullSpaceSolveSteps>500</NullSpaceSolveSteps>
                  <CoarseSolverTolerance>0.25</CoarseSolverTolerance>
                  <CoarseSolverMaxIterations>150</CoarseSolverMaxIterations>
                  <NumPreSmooth>0</NumPreSmooth>
                  <NumPostSmooth>6</NumPostSmooth>
               </Level1>
               <Level2>
                  <CoarseSolverTolerance>0.1</CoarseSolverTolerance>
                  <CoarseSolverMaxIterations>300</CoarseSolverMaxIterations>
                  <TRLMDeflation>
                     <NumVectors>1536</NumVectors>
                     <Tolerance>1.0e-06</Tolerance>
                     <MaxIterations>200</MaxIterations>
                     <ChebyshevOrder>32</ChebyshevOrder>
                     <CutoffEigenvalue>0.015</CutoffEigenvalue>
                  </TRLMDeflation>
               </Level2>
               <LoadNullVectors>false</LoadNullVectors>
               <GenerateAllLevels>true</GenerateAllLevels>
               <PreOrthoNullVectors>true</PreOrthoNullVectors>
               <PostOrthoNullVectors>true</PostOrthoNullVectors>
               <RunVerify>false</RunVerify>
            </MGPreconditioner>
         </InverterInfo>
      </QuarkPerambulatorInfo>
      <ComputationSet>
         <UseMultiSrcInverter>no</UseMultiSrcInverter>
         <NumSinksBeforeProject>24</NumSinksBeforeProject>
         <NumSinksInProjectBatch>24</NumSinksInProjectBatch>
         <NumEigsInProjectBatch>24</NumEigsInProjectBatch>
         <Computation>
            <SourceTime>%(SRCT1)s</SourceTime>
            <SourceLaphEigvecIndexMin>0</SourceLaphEigvecIndexMin>
            <SourceLaphEigvecIndexMax>767</SourceLaphEigvecIndexMax>
         </Computation>
         <Computation>
            <SourceTime>%(SRCT2)s</SourceTime>
            <SourceLaphEigvecIndexMin>0</SourceLaphEigvecIndexMin>
            <SourceLaphEigvecIndexMax>767</SourceLaphEigvecIndexMax>
         </Computation>
      </ComputationSet>
   </Task>
</QudaLaph>
'''


bash_head='''#!/bin/bash -l
#SBATCH -J FOM_QUDA_LAPH_Perambs
#SBATCH -t 1:00:00
#SBATCH -N %(NODES)s
#SBATCH -o %(PERAMB_DIR)s/FOM_QUDA_LAPH_Perambs_nodes_%(NODES)s.log
#SBATCH -p batch
#SBATCH --mail-type=ALL
#SBATCH --mail-user=mongecamachj@ornl.gov
#SBATCH -A CSC728

export QUDA_ENABLE_P2P=0
export QUDA_ENABLE_GDR=1
export QUDA_ENABLE_DSLASH_POLICY="0,1,6,7"
export MPICH_GPU_SUPPORT_ENABLED=1
export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH

pushd /lustre/orion/scratch/mcamacho/csc728/software/quda_laph/quda_laph_rocm_7_2_0
source %(ENV)s
popd
export QUDA_RESOURCE_PATH=%(PERAMB_DIR)s/quda_resource
export QUDA_PROFILE_OUTPUT_BASE=%(PERAMB_DIR)s/quda_resource/profile_Perambs

PROG=${INSTALLROOT}/${QUDA_LAPH}/bin/quda_laph
export OMP_NUM_THREADS=4
umask 007
NPARTITIONS="2 4 4 6"

'''

peramb_jobs='''
INXML=%(PERAMB_DIR)s/%(NCFG)s/mpirun%(NMPI)s/%(TASKNAME)s.xml
OUTPUT=%(PERAMB_DIR)s/%(NCFG)s/mpirun%(NMPI)s/%(TASKNAME)s.stdout
pushd %(PERAMB_DIR)s/%(NCFG)s/mpirun%(NMPI)s
srun --exclusive -N 24 -n 192 --ntasks-per-node=8 --gpu-bind=closest --export=ALL,QUDA_RESOURCE_PATH=${QUDA_RESOURCE_PATH} ${PROG} -i ${INXML} -npartitions ${NPARTITIONS} >& ${OUTPUT} &
popd
sleep 1
'''
