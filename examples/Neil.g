LoadPackage( "GradedRingForHomalg" );

Q := HomalgFieldOfRationalsInDefaultCAS( );
R := Q * "x,y";

AssignGeneratorVariables( R );

f := y^2-x^3;

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

I := LeftSubmodule( "(y^2-x^3)*Dx-s*(-3*x^2),(y^2-x^3)*Dy-s*(2*y)", Ds );

Assert( 0, IsSubset( Ann, I ) );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

g := Concatenation( "(", String( f ), ")^s" );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

D := Divisor( f );
