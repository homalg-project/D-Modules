LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInSingular( ) * "t";

A1 := RingOfDerivations( Qt, "Dt" );

M := HomalgMatrix( "[ \
Dt^2, \
t*Dt-1 \
]", 2, 1, A1 );

LoadPackage( "Modules" );

M := LeftPresentation( M );

P := ShortenResolution( M );

Assert( 0, IsIdenticalObj( Cokernel( PresentationMorphism( M ) ), M ) );
