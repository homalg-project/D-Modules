LoadPackage( "GradedRingForHomalg" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
R := Q * "x,y,z";

ExportIndeterminates( R );

f := x^2*y*z + x^2*z^2 - y^3*z - y^3;

LoadPackage( "D-Modules" );

Ann := AnnihilatorOfPower( 1, f, "s" );

Ds := HomalgRing( Ann );

Dsf := LeftSubmodule( f / Ds );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );

b := IntersectWithSubalgebra( Annf, s );

factors := Collected( Factors( b ) );

Assert( 0, factors =
        [ [ s+5/6, 2 ], [ s+1, 3 ], [ s+7/6, 2 ], [ s+4/3, 1 ], [ s+3/2, 1 ], [ s+5/3, 1 ] ] );

#Read( ".Geisha_rest.g" );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

g := Concatenation( "(", String( f ), ")^s" );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

D := Divisor( f );
