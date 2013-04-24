LoadPackage( "GradedRingForHomalg" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
R := Q * "x";

AssignGeneratorVariables( R );

f := x;

LoadPackage( "D-Modules" );

Ann := AnnihilatorOfPower( 1, f, "s" );

Ds := HomalgRing( Ann );

Dsf := LeftSubmodule( f / Ds );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );

b := IntersectWithSubalgebra( Annf, s );

factors := Collected( Factors( b ) );

Assert( 0, factors =
        [ [ s+1, 1 ] ] );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

g := Concatenation( "(", String( f ), ")^s" );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

D := Divisor( f );
