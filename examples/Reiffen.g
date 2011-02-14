LoadPackage( "GradedRingForHomalg" );

Qxy := HomalgFieldOfRationalsInDefaultCAS( "s" ) * "x,y";
A2 := RingOfDerivations( Qxy, "Dx,Dy" );

var := IndeterminateCoordinatesOfRingOfDerivations( A2 );

x := var[1];
y := var[2];

f_pq := "x^p + y*y^(q-1) + x*y^(q-1)";

Reiffen := function( p, q )
    if q >= p + 1 and p + 1 >= 5 then
        return ( x^p + y*y^(q-1) + x*y^(q-1) ) / A2;
    fi;
    Error( "We want q >= p + 1 and p + 1 >= 5\n" );
end;

f := Reiffen( 4, 5 );

g := Concatenation( "1/(", String( f ), ")^s" );

LoadPackage( "D-Modules" );
