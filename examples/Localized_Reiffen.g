LoadPackage( "RingsForHomalg" );

B2 := RingForHomalgInMapleUsingJanet( "[x,y]" );

K := HomalgMatrix( "[ \
[ [[4*x^2+5*x*y,[x]],[3*x*y+4*y^2,[y]],[16*x+20*y,[]]] ], \
[ [[16*x*y^2+4*y^3-125*x*y,[x]],[12*y^3-4*x^2+5*x*y-100*y^2,[y]],[64*y^2-500*y,[]]] ] \
]", B2 );

I := HomalgMatrix( "[ \
[ [[4*x^2+5*x*y,[x]],[3*x*y+4*y^2,[y]],[16*x+20*y,[]]] ], \
[ [[16*x*y^2+4*y^3-125*x*y,[x]],[12*y^3-4*x^2+5*x*y-100*y^2,[y]],[64*y^2-500*y,[]]] ], \
[ [[16*y^3+125*x*y,[x,x]],[-16*y^3-35*x*y+100*y^2,[x,y]],[12*x^2-2*x*y-24*y^2,[y,y]],[112*x*y-36*y^2-930*x+625*y,[x]],[84*y^2+26*x-893*y,[y]],[448*y-3720,[]]] ] \
]", B2 );

J := HomalgMatrix( "[ \
[ [[x^4+y^5+x*y^4,[x]], [4*x^3+y^4,[]]] ], \
[ [[x^4+y^5+x*y^4,[y]], [5*y^4+4*y^3*x,[]]] ] \
]", B2 );

LoadPackage( "D-Modules" );

K := LeftSubmodule( K );

L := FactorObject( K );

I := LeftSubmodule( I );

M := FactorObject( I );

J := LeftSubmodule( J );

N := FactorObject( J );

Assert( 0, I = J );

Assert( 0, I = K );
