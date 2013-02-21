LoadPackage( "GradedRingForHomalg" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
R := Q * "x,y";

ExportIndeterminates( R );

f_pq := "x^p + y*y^(q-1) + x*y^(q-1)";

PlaneCurve := function( p, q, r, t )
    return ( x^p + y^q + x^r * y^t );
end;

f := PlaneCurve( 2, 3, 4, 5 );

LoadPackage( "D-Modules" );

Ann := AnnihilatorOfPower( 1, f, "s" );

Ds := HomalgRing( Ann );

Dsf := LeftSubmodule( f / Ds );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );

b := IntersectWithSubalgebra( Annf, s );

factors := Collected( Factors( b ) );

Assert( 0, factors =
        [ [ s+5/6, 1 ], [ s+1, 1 ], [ s+7/6, 1 ] ] );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

g := Concatenation( "(", String( f ), ")^s" );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

D := Divisor( f );
