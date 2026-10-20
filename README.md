# CAAR_FOM_QUDA_LAPH

## Figure of Merit:
A Lattice QCD observable is obtained from calculations performed on an ensemble of points of a phase space grid. For different observables and their required precision, the phase space grid refinement can change;  but ultimately,  an observable computational cost depends on the size of the phase space grid. We define our figure of merit as follows: 
FOM=Ngrid pointst
Where Ngrid points is the number of phase space grid points and the t the time to compute those grid points.

For a phase grid points, we performed two sequential tasks on a 96^3x192 lattice:
   -Solves to compute quark perambulators
   -Contractions of quark perambulators 
