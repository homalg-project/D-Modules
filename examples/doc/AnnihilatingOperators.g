##  <#GAPDoc Label="AnnihilatingOperators:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";;
##  gap> A2 := RingOfDerivations( R, "Dx,Dy" );;
##  gap> var := IndeterminateCoordinatesOfRingOfDerivations( A2 );
##  [ x, y ]
##  gap> x := var[1];
##  x
##  gap> y := var[2];
##  y
##  gap> f := x^4+y^5+x*y^4;    ## an element of the commutative base ring
##  x*y^4+y^5+x^4
##  gap> f := f / A2;           ## an element of the Weyl algebra
##  x*y^4+y^5+x^4
##  gap> AnnihilatingOperators( 1, f, 2 );
##  <An unevaluated 5 x 1 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( last );
##  [ 4*x^2*Dx^2+5*x*y*Dx^2+3*x*y*Dx*Dy+4*y^2*Dx*Dy+24*x*Dx+25*y*Dx+3*y*Dy+16, 
##    4*x^2*Dx*Dy+5*x*y*Dx*Dy+3*x*y*Dy^2+4*y^2*Dy^2+5*x*Dx+19*x*Dy+28*y*Dy+20, 
##    -80*y^3*Dx^2+80*y^3*Dx*Dy-625*x*y*Dx^2+175*x*y*Dx*Dy-500*y^2*Dx*Dy-60*x^2*Dy\
##  ^2+10*x*y*Dy^2+120*y^2*Dy^2-6864*x^2*Dx-9140*x*y*Dx+180*y^2*Dx-5148*x*y*Dy-728\
##  4*y^2*Dy+4650*x*Dx-3125*y*Dx-130*x*Dy+4465*y*Dy-27456*x-36560*y+18600, 
##    320*x*y^2*Dx^2+320*y^3*Dx^2-625*x*y*Dx^2-325*x*y*Dx*Dy-500*y^2*Dx*Dy+180*x^2\
##  *Dy^2+30*x*y*Dy^2-280*y^2*Dy^2+20592*x^2*Dx+27420*x*y*Dx+1060*y^2*Dx+15444*x*y\
##  *Dy+21852*y^2*Dy-13850*x*Dx-3125*y*Dx+610*x*Dy-12735*y*Dy+82368*x+109680*y-554\
##  00, 
##    80*y^3*Dx^2+320*x*y^2*Dx*Dy+240*y^3*Dy^2+625*x*y*Dx^2-2675*x*y*Dx*Dy+500*y^2\
##  *Dx*Dy-20*x^2*Dy^2+90*x*y*Dy^2-2120*y^2*Dy^2-2288*x^2*Dx-1660*x*y*Dx+60*y^2*Dx\
##  -1716*x*y*Dy+132*y^2*Dy-7150*x*Dx+3125*y*Dx+230*x*Dy-18465*y*Dy-9152*x-6640*y-\
##  28600 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../Reiffen_data.g" );

AnnihilatingOperators( 1, f, 2 );
