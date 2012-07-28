LoadPackage( "GradedRingForHomalg" );

Qs := HomalgFieldOfRationalsInDefaultCAS( ) * "s";
Qxy := Qs * "x,y";
Ds := RingOfDerivations( Qxy, "Ds,Dx,Dy" );

x := "x" / Ds;
y := "y" / Ds;

Dx := "Dx" / Ds;
Dy := "Dy" / Ds;

SetRelativeIndeterminateCoordinatesOfRingOfDerivations( Ds, [ x, y ] );
ResetFilterObj( Ds, IndeterminateDerivationsOfRingOfDerivations );
SetIndeterminateDerivationsOfRingOfDerivations( Ds, [ Dx, Dy ] );

f := y^2-x^3;

f_1 := Concatenation( "(", String( f ), ")^(-1)" );

g := Concatenation( "(", String( f ), ")^s" );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

Ann := Annihilator( g, 1, Ds );

Dsf := LeftSubmodule( [ f ] );

Annf := Ann + Dsf;

I := LeftSubmodule( "(y^2-x^3)*Dx-s*(-3*x^2),(y^2-x^3)*Dy-s*(2*y)", Ds );

s := Indeterminate( Rationals, "s" );

b := IntersectWithSubalgebra( Annf, s );

factors := Collected( Factors( b ) );

Assert( 0, factors =
        [ [ s+5/6, 1 ], [ s+1, 1 ], [ s+7/6, 1 ] ] );
