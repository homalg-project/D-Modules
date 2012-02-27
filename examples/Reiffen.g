LoadPackage( "GradedRingForHomalg" );

Qs := HomalgFieldOfRationalsInDefaultCAS( ) * "s";
Qsxy := Qs * "x,y";
Ds := RingOfDerivations( Qsxy, "Ds,Dx,Dy" );

x := "x" / Ds;
y := "y" / Ds;

Dx := "Dx" / Ds;
Dy := "Dy" / Ds;

SetIsWeylRing( Ds, true );
SetCenter( Ds, Qs );
SetBaseRing( Ds, Qsxy );
SetCoefficientsRing( Ds, Qs );

SetRelativeIndeterminateCoordinatesOfRingOfDerivations( Ds, [ x, y ] );
ResetFilterObj( Ds, IndeterminateDerivationsOfRingOfDerivations );
SetIndeterminateDerivationsOfRingOfDerivations( Ds, [ Dx, Dy ] );

f_pq := "x^p + y*y^(q-1) + x*y^(q-1)";

Reiffen := function( p, q )
    if q >= p + 1 and p + 1 >= 5 then
        return ( x^p + y*y^(q-1) + x*y^(q-1) ) / Ds;
    fi;
    Error( "We want q >= p + 1 and p + 1 >= 5\n" );
end;

f := Reiffen( 6, 7 );

g := Concatenation( "(", String( f ), ")^s" );

I := HomalgMatrix( "[ \
4*x^2*Dx+5*x*y*Dx+3*x*y*Dy+4*y^2*Dy+16*x+20*y, \
16*x*y^2*Dx+4*y^3*Dx+12*y^3*Dy-125*x*y*Dx-4*x^2*Dy+5*x*y*Dy-100*y^2*Dy+64*y^2-500*y, \
16*y^3*Dx^2-16*y^3*Dx*Dy+125*x*y*Dx^2-35*x*y*Dx*Dy+100*y^2*Dx*Dy+12*x^2*Dy^2-2*x*y*Dy^2-24*y^2*Dy^2+112*x*y*Dx-36*y^2*Dx+84*y^2*Dy-930*x*Dx+625*y*Dx+26*x*Dy-893*y*Dy+448*y-3720 \
]", 3, 1, Ds );

J := HomalgMatrix( "[ \
(4*x^3+y^4)+(x^4+y^5+x*y^4)*Dx, \
(5*y^4+4*y^3*x)+(x^4+y^5+x*y^4)*Dy \
]", 2, 1, Ds );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

I := LeftSubmodule( I );

M := FactorObject( I );

J := LeftSubmodule( J );

N := FactorObject( J );

Ann := Annihilator( g, 3, Ds );

Dsf := LeftSubmodule( [ f ] );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );
