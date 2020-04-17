##  <#GAPDoc Label="CoefficientsOfAnnihilatingOperators:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
##  Q[x,y]
##  gap> AssignGeneratorVariables( R );
##  #I  Assigned the global variables [ x, y ]
##  gap> f := x^4+y^5+x*y^4;
##  x*y^4+y^5+x^4
##  gap> CoefficientsOfAnnihilatingOperators( 2, 1, f );
##  <A non-zero 5 x 6 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( last );
##  [ 20, 5*x, 19*x+28*y, 0, 4*x^2+5*x*y, 3*x*y+4*y^2, 16, 24*x+25*y, 
##    3*y, 4*x^2+5*x*y, 3*x*y+4*y^2, 0, 27456*x+36560*y-18600, 
##    6864*x^2+9140*x*y-180*y^2-4650*x+3125*y, 
##    5148*x*y+7284*y^2+130*x-4465*y, 80*y^3+625*x*y, 
##    -80*y^3-175*x*y+500*y^2, 60*x^2-10*x*y-120*y^2, 
##    -9152*x-10800*y-2500, -2288*x^2-2700*x*y+60*y^2-625*x, 
##    -1716*x*y-1788*y^2+25*x-3500*y, 0, 80*x*y^2+20*y^3-625*x*y, 
##    60*y^3-20*x^2+25*x*y-500*y^2, -27456*x-36560*y+19000, 
##    -6864*x^2-9140*x*y+1780*y^2+4750*x-15625*y, 
##    -5148*x*y-7284*y^2+90*x+5125*y, 320*x*y^2-3125*x*y, 
##    320*y^3+375*x*y-2500*y^2, -60*x^2+70*x*y+200*y^2 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../Reiffen_data.g" );

CoefficientsOfAnnihilatingOperators( 2, 1, f );
