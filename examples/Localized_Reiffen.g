#! @Chapter Examples and tests

#! @Section Tests

#! @Example

LoadPackage( "RingsForHomalg", false );
#! true

B2 := RingForHomalgInMapleUsingJanet( "[x,y]" );
#! B(x,y)

K := HomalgMatrix( "[ \
[ [[4*x^2+5*x*y,[x]],[3*x*y+4*y^2,[y]],[16*x+20*y,[]]] ], \
[ [[16*x*y^2+4*y^3-125*x*y,[x]],[12*y^3-4*x^2+5*x*y-100*y^2,[y]],[64*y^2-500*y,[]]] ] \
]", B2 );;

I := HomalgMatrix( "[ \
[ [[4*x^2+5*x*y,[x]],[3*x*y+4*y^2,[y]],[16*x+20*y,[]]] ], \
[ [[16*x*y^2+4*y^3-125*x*y,[x]],[12*y^3-4*x^2+5*x*y-100*y^2,[y]],[64*y^2-500*y,[]]] ], \
[ [[16*y^3+125*x*y,[x,x]],[-16*y^3-35*x*y+100*y^2,[x,y]],[12*x^2-2*x*y-24*y^2,[y,y]],[112*x*y-36*y^2-930*x+625*y,[x]],[84*y^2+26*x-893*y,[y]],[448*y-3720,[]]] ] \
]", B2 );;

J := HomalgMatrix( "[ \
[ [[x^4+y^5+x*y^4,[x]], [4*x^3+y^4,[]]] ], \
[ [[x^4+y^5+x*y^4,[y]], [5*y^4+4*y^3*x,[]]] ] \
]", B2 );;

LoadPackage( "D-Modules", true );
#! true

K := LeftSubmodule( K );
#! <A torsion-free left ideal given by 2 generators>

L := FactorObject( K );
#! <A cyclic torsion left module presented by yet unknown relations for a\
#!  cyclic generator>

I := LeftSubmodule( I );
#! <A torsion-free left ideal given by 3 generators>

M := FactorObject( I );
#! <A cyclic torsion left module presented by yet unknown relations for a\
#!  cyclic generator>

J := LeftSubmodule( J );
#! <A torsion-free left ideal given by 2 generators>

N := FactorObject( J );
#! <A cyclic torsion left module presented by yet unknown relations for a\
#!  cyclic generator>

Assert( 0, I = J );

Assert( 0, I = K );

#! @EndExample
