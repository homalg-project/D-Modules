# sys:=Ind2Diff([u[x,x]-u[x,y],u[x,y,y],u[x,y,z]],[x,y,z],[u]);

LoadPackage( "RingsForHomalg" );

LoadPackage( "Modules" );

Qx := HomalgFieldOfRationalsInDefaultCAS( ) * "x";
A1 := RingOfDerivations( Qx, "Dx" );

N := HomalgMatrix( "[ x*Dx+1 ]", 1, 1, A1 );

N := LeftPresentation( N );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( A1 );
