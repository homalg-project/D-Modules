LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";
A3 := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );

grad := HomalgMatrix( "[ \
Dx, Dy, Dz \
]", 1, 3, A3 );

grad := LeftPresentation( grad );

IsTorsionFree( grad );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( A3 );
