##  <#GAPDoc Label="BasisOfAnnihilatingOperators:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
##  Q[x,y]
##  gap> AssignGeneratorVariables( R );
##  #I  Global variable `x' is already defined and will be overwritten
##  #I  Global variable `y' is already defined and will be overwritten
##  #I  Assigned the global variables [ x, y ]
##  gap> f := x^4+y^5+x*y^4;
##  x*y^4+y^5+x^4
##  gap> BasisOfAnnihilatingOperators( 1, 1, f );
##  <A non-zero right regular 4 x 1 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( last );
##  [ 4*x^2*Dx+5*x*y*Dx+3*x*y*Dy+4*y^2*Dy+16*x+20*y, 
##    16*x*y^2*Dx+4*y^3*Dx+12*y^3*Dy-125*x*y*Dx-4*x^2*Dy+5*x*y*Dy-100*y^2*Dy+64*y^\
##  2-500*y, 
##    256*y^4*Dx-256*y^4*Dy-500*y^3*Dx-256*x^3*Dy+64*x^2*y*Dy-80*x*y^2*Dy+100*y^3*\
##  Dy-1024*y^3+15625*x*y*Dx+500*x^2*Dy-625*x*y*Dy+12500*y^2*Dy+62500*y, 
##    x*y^4*Dy+y^5*Dy+x^4*Dy+4*x*y^3+5*y^4 ]
##  gap> BasisOfAnnihilatingOperators( 2, 1, f );
##  <A non-zero right regular 5 x 1 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( last );
##  [ 4*x^2*Dx+5*x*y*Dx+3*x*y*Dy+4*y^2*Dy+16*x+20*y, 
##    16*x*y^2*Dx+4*y^3*Dx+12*y^3*Dy-125*x*y*Dx-4*x^2*Dy+5*x*y*Dy-100*y^2*Dy+64*y^\
##  2-500*y, 
##    16*y^3*Dx^2-16*y^3*Dx*Dy+125*x*y*Dx^2-35*x*y*Dx*Dy+100*y^2*Dx*Dy+12*x^2*Dy^2\
##  -2*x*y*Dy^2-24*y^2*Dy^2+112*x*y*Dx-36*y^2*Dx+84*y^2*Dy-930*x*Dx+625*y*Dx+26*x*\
##  Dy-893*y*Dy+448*y-3720, 
##    256*y^4*Dx-256*y^4*Dy-500*y^3*Dx-256*x^3*Dy+64*x^2*y*Dy-80*x*y^2*Dy+100*y^3*\
##  Dy-1024*y^3+15625*x*y*Dx+500*x^2*Dy-625*x*y*Dy+12500*y^2*Dy+62500*y, 
##    x*y^4*Dy+y^5*Dy+x^4*Dy+4*x*y^3+5*y^4 ]
##  gap> BasisOfAnnihilatingOperators( 3, 1, f );
##  <A non-zero right regular 5 x 1 matrix over an external ring>
##  gap> EntriesOfHomalgMatrix( last );
##  [ 4*x^2*Dx+5*x*y*Dx+3*x*y*Dy+4*y^2*Dy+16*x+20*y, 
##    16*x*y^2*Dx+4*y^3*Dx+12*y^3*Dy-125*x*y*Dx-4*x^2*Dy+5*x*y*Dy-100*y^2*Dy+64*y^\
##  2-500*y, 
##    16*y^3*Dx^2-16*y^3*Dx*Dy+125*x*y*Dx^2-35*x*y*Dx*Dy+100*y^2*Dx*Dy+12*x^2*Dy^2\
##  -2*x*y*Dy^2-24*y^2*Dy^2+112*x*y*Dx-36*y^2*Dx+84*y^2*Dy-930*x*Dx+625*y*Dx+26*x*\
##  Dy-893*y*Dy+448*y-3720, 
##    256*y^4*Dx-256*y^4*Dy-500*y^3*Dx-256*x^3*Dy+64*x^2*y*Dy-80*x*y^2*Dy+100*y^3*\
##  Dy-1024*y^3+15625*x*y*Dx+500*x^2*Dy-625*x*y*Dy+12500*y^2*Dy+62500*y, 
##    x*y^4*Dy+y^5*Dy+x^4*Dy+4*x*y^3+5*y^4 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../Reiffen_data.g" );

BasisOfAnnihilatingOperators( 2, 1, f );
