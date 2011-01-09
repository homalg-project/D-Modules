LoadPackage( "GradedRingForHomalg" );

Qxyz := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y,z";
A3 := RingOfDerivations( Qxyz, "Dx,Dy,Dz" );

var := IndeterminateCoordinatesOfRingOfDerivations( A3 );

x := var[1];
y := var[2];
z := var[3];

f := x^2*y*z + x^2*z^2 - y^3*z - y^3;

f := f / A3;

LoadPackage( "D-Modules" );
