# CAAR_FOM_QUDA_LAPH

## Figure of Merit:
A Lattice QCD observable is obtained from calculations performed on an ensemble of configurations representing a large Monte Carlo integral. For different observables and their required precision, the number of Monte Carlo samples can change with the precision improving inversely with the square-root of the number of samples.  The computational cost of each observable depends on the total number of Monte Carlo samples computed.  We define a task as the computation of a single Monte Carlo sample and use this to define our figure of merit as follows: 
FOM=N_task/t
where N_task  is the number of tasks (Monte Carlo samples), and t (hours) is the time to compute those tasks.

The Monte Carlo sample is obtained from a two-step calculation performed on a 96^3×192 4-dimensional lattice of SU(3) gauge links with quark masses set to their physical values. The steps for one Monte Carlo sample task are:
Perform linear solves to compute quark perambulators for 48 source times, 768 LAPH eigenvectors, all source spins.
Contract 768 LAPH eigenvectors to create baryon triplets for all time sources and 33 momenta.

To measure the FOM time, we will use timers existing in the code that reports the time for step 1 and 2 and that exclude I/O.  Every Monte Carlo sample requires 576 nodes, we will run FOM measures using 5760 nodes to measure the FOM on 10 Monte Carlo sample tasks.
