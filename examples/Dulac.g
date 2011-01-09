LoadPackage( "GradedRingForHomalg" );

Qxy := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
A2 := RingOfDerivations( Qxy, "Dx,Dy" );

rot := HomalgMatrix( "[ \
-y*Dx+x*Dy \
]", 1, 1, A2 );

dulac := HomalgMatrix( "[ \
x*Dx+y*Dy-2 \
]", 1, 1, A2 );

dulac := UnionOfRows( rot, dulac );

LoadPackage( "Modules" );

rot := LeftPresentation( rot );

IsTorsionFree( rot );

dulac := LeftPresentation( dulac );

IsTorsionFree( dulac );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( A2 );
