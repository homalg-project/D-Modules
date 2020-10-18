##  <#GAPDoc Label="AnnihilatingOperators:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
##  Q[x,y]
##  gap> AssignGeneratorVariables( R );
##  #I  Global variable `x' is already defined and will be overwritten
##  #I  Global variable `y' is already defined and will be overwritten
##  #I  Assigned the global variables [ x, y ]
##  gap> f := x^4+y^5+x*y^4;
##  x*y^4+y^5+x^4
##  gap> ann := AnnihilatingOperators( 2, 1, f );
##  <An unevaluated 5 x 1 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( ann );
##  [ 4*x^2*Dx*Dy+5*x*y*Dx*Dy+3*x*y*Dy^2+4*y^2*Dy^2+5*x*Dx+19*x*Dy+28*y*Dy\
##  +20, 
##    4*x^2*Dx^2+5*x*y*Dx^2+3*x*y*Dx*Dy+4*y^2*Dx*Dy+24*x*Dx+25*y*Dx+3*y*Dy\
##  +16, 
##    80*y^3*Dx^2-80*y^3*Dx*Dy+625*x*y*Dx^2-175*x*y*Dx*Dy+500*y^2*Dx*Dy+60\
##  *x^2*Dy^2-10*x*y*Dy^2-120*y^2*Dy^2+6864*x^2*Dx+9140*x*y*Dx-180*y^2*Dx+\
##  5148*x*y*Dy+7284*y^2*Dy-4650*x*Dx+3125*y*Dx+130*x*Dy-4465*y*Dy+27456*x\
##  +36560*y-18600, 
##    80*x*y^2*Dx*Dy+20*y^3*Dx*Dy+60*y^3*Dy^2-625*x*y*Dx*Dy-20*x^2*Dy^2+25\
##  *x*y*Dy^2-500*y^2*Dy^2-2288*x^2*Dx-2700*x*y*Dx+60*y^2*Dx-1716*x*y*Dy-1\
##  788*y^2*Dy-625*x*Dx+25*x*Dy-3500*y*Dy-9152*x-10800*y-2500, 
##    320*x*y^2*Dx^2+320*y^3*Dx*Dy-3125*x*y*Dx^2+375*x*y*Dx*Dy-2500*y^2*Dx\
##  *Dy-60*x^2*Dy^2+70*x*y*Dy^2+200*y^2*Dy^2-6864*x^2*Dx-9140*x*y*Dx+1780*\
##  y^2*Dx-5148*x*y*Dy-7284*y^2*Dy+4750*x*Dx-15625*y*Dx+90*x*Dy+5125*y*Dy-\
##  27456*x-36560*y+19000 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../Reiffen_data.g" );

AnnihilatingOperators( 2, 1, f );
