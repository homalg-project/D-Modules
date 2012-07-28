## Wim Veys in Lahore 2011: Claim by Bart Bories (paper on arXiv):
## f = x*y^5+x^3*y^2+x^4*y has b-function with root -6/13;
## this -6/13 is NOT a pole of the topological zeta function
## assoicated to f and a diff. form w = g dx dy

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

f := x*y^5+x^3*y^2+x^4*y;

f_1 := Concatenation( "(", String( f ), ")^(-1)" );

g := Concatenation( "(", String( f ), ")^s" );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

Ann := Annihilator( g, 2, Ds );

Dsf := LeftSubmodule( [ f ] );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );

b := IntersectWithSubalgebra( Annf, s );

factors := Collected( Factors( b ) );

Assert( 0, factors =
        [ [ s+5/13, 1 ], [ s+2/5, 1 ], [ s+6/13, 1 ], [ s+7/13, 1 ],
          [ s+3/5, 1 ], [ s+8/13, 1 ], [ s+9/13, 1 ], [ s+10/13, 1 ],
          [ s+4/5, 1 ], [ s+11/13, 1 ], [ s+12/13, 1 ], [ s+1, 2 ],
          [ s+14/13, 1 ], [ s+15/13, 1 ], [ s+6/5, 1 ], [ s+16/13, 1 ], [ s+17/13, 1 ] ] );
