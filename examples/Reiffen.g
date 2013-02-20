Read( "Reiffen_data.g" );

Ann := AnnihilatorOfPower( f, "s", 3 );

Ds := HomalgRing( Ann );

Dsf := LeftSubmodule( f / Ds );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );

b := IntersectWithSubalgebra( Annf, s );

factors := Collected( Factors( b ) );

Assert( 0, factors =
        [ [ s+13/42, 1 ], [ s+5/14, 1 ], [ s+8/21, 1 ], [ s+17/42, 1 ],
          [ s+19/42, 1 ], [ s+10/21, 1 ], [ s+11/21, 1 ], [ s+23/42, 1 ],
          [ s+25/42, 1 ], [ s+13/21, 1 ], [ s+9/14, 1 ], [ s+29/42, 1 ],
          [ s+31/42, 1 ], [ s+16/21, 1 ], [ s+11/14, 1 ], [ s+17/21, 1 ],
          [ s+37/42, 1 ], [ s+19/21, 1 ], [ s+13/14, 1 ], [ s+20/21, 1 ],
          [ s+41/42, 1 ], [ s+1, 1 ], [ s+43/42, 1 ], [ s+22/21, 1 ],
          [ s+15/14, 1 ], [ s+23/21, 1 ], [ s+47/42, 1 ], [ s+25/21, 1 ],
          [ s+17/14, 1 ], [ s+26/21, 1 ], [ s+53/42, 1 ] ] );

I := HomalgMatrix( "[ \
4*x^2*Dx+5*x*y*Dx+3*x*y*Dy+4*y^2*Dy+16*x+20*y, \
16*x*y^2*Dx+4*y^3*Dx+12*y^3*Dy-125*x*y*Dx-4*x^2*Dy+5*x*y*Dy-100*y^2*Dy+64*y^2-500*y, \
16*y^3*Dx^2-16*y^3*Dx*Dy+125*x*y*Dx^2-35*x*y*Dx*Dy+100*y^2*Dx*Dy+12*x^2*Dy^2-2*x*y*Dy^2-24*y^2*Dy^2+112*x*y*Dx-36*y^2*Dx+84*y^2*Dy-930*x*Dx+625*y*Dx+26*x*Dy-893*y*Dy+448*y-3720 \
]", 3, 1, Ds );

J := HomalgMatrix( "[ \
(4*x^3+y^4)+(x^4+y^5+x*y^4)*Dx, \
(5*y^4+4*y^3*x)+(x^4+y^5+x*y^4)*Dy \
]", 2, 1, Ds );

I := LeftSubmodule( I );

M := FactorObject( I );

J := LeftSubmodule( J );

N := FactorObject( J );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

g := Concatenation( "(", String( f ), ")^s" );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );
