LoadPackage( "RingsForHomalg" );

Qt := HomalgFieldOfRationalsInSingular( ) * "t";

A1 := RingOfDerivations( Qt, "Dt" );

M := HomalgMatrix( "[ 1 ]", 1, 1, A1 );

LoadPackage( "Modules" );

M := LeftPresentation( M );

SetAsOriginalPresentation( M );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( A1 );
