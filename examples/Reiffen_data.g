LoadPackage( "GradedRingForHomalg" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
R := Q * "x,y";

ExportIndeterminates( R );

f_pq := "x^p + y*y^(q-1) + x*y^(q-1)";

Reiffen := function( p, q )
    if q >= p + 1 and p + 1 >= 5 then
        return ( x^p + y*y^(q-1) + x*y^(q-1) );
    fi;
    Error( "We want q >= p + 1 and p + 1 >= 5\n" );
end;

f := Reiffen( 6, 7 );

LoadPackage( "D-Modules" );
