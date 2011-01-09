##  <#GAPDoc Label="CoefficientsOfAnnihilatingOperators:example">
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
##  gap> CoefficientsOfAnnihilatingOperators( 1, f, 2 );
##  <A non-zero 5 x 6 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( last );
##  [ 16, 24*x+25*y, 3*y, 4*x^2+5*x*y, 3*x*y+4*y^2, 0, 20, 5*x, 19*x+28*y, 0, 
##    4*x^2+5*x*y, 3*x*y+4*y^2, -27456*x-36560*y+18600, 
##    -6864*x^2-9140*x*y+180*y^2+4650*x-3125*y, -5148*x*y-7284*y^2-130*x+4465*y, 
##    -80*y^3-625*x*y, 80*y^3+175*x*y-500*y^2, -60*x^2+10*x*y+120*y^2, 
##    82368*x+109680*y-55400, 20592*x^2+27420*x*y+1060*y^2-13850*x-3125*y, 
##    15444*x*y+21852*y^2+610*x-12735*y, 320*x*y^2+320*y^3-625*x*y, 
##    -325*x*y-500*y^2, 180*x^2+30*x*y-280*y^2, -9152*x-6640*y-28600, 
##    -2288*x^2-1660*x*y+60*y^2-7150*x+3125*y, -1716*x*y+132*y^2+230*x-18465*y, 
##    80*y^3+625*x*y, 320*x*y^2-2675*x*y+500*y^2, 240*y^3-20*x^2+90*x*y-2120*y^2 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../f_pq.g" );

CoefficientsOfAnnihilatingOperators( 1, f, 2 );
