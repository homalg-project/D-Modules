##  <#GAPDoc Label="NumeratorOfDifferentialAction:der_example">
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
##  gap> NumeratorOfDifferentialAction( 1, f, [ ] );
##  1
##  gap> NumeratorOfDifferentialAction( 1, f, [ x ] );
##  -y^4-4*x^3
##  gap> NumeratorOfDifferentialAction( 1, f, [ y ] );
##  -4*x*y^3-5*y^4
##  gap> NumeratorOfDifferentialAction( 1, f, [ x, x ] );
##  2*y^8+4*x^3*y^4-12*x^2*y^5+20*x^6
##  gap> NumeratorOfDifferentialAction( 1, f, [ x, y ] );
##  4*x*y^7+6*y^8+28*x^4*y^3+40*x^3*y^4
##  gap> NumeratorOfDifferentialAction( 1, f, [ y, y ] );
##  20*x^2*y^6+48*x*y^7+30*y^8-12*x^5*y^2-20*x^4*y^3
##  ]]></Example>
##  <#/GAPDoc>

##  <#GAPDoc Label="NumeratorOfDifferentialAction:ord_example">
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
##  gap> NumeratorOfDifferentialAction( 1, f, 2 );
##  [ x^2*y^8+2*x*y^9+y^10+2*x^5*y^4+2*x^4*y^5+x^8, 
##    -x*y^8-y^9-5*x^4*y^4-4*x^3*y^5-4*x^7, 
##    -4*x^2*y^7-9*x*y^8-5*y^9-4*x^5*y^3-5*x^4*y^4, 
##    2*y^8+4*x^3*y^4-12*x^2*y^5+20*x^6, 4*x*y^7+6*y^8+28*x^4*y^3+40*x^3*y^4, 
##    20*x^2*y^6+48*x*y^7+30*y^8-12*x^5*y^2-20*x^4*y^3 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../f_pq.g" );

NumeratorOfDifferentialAction( 1, f, [ ] );
NumeratorOfDifferentialAction( 1, f, [ x ] );
NumeratorOfDifferentialAction( 1, f, [ y ] );
NumeratorOfDifferentialAction( 1, f, [ x, x ] );
NumeratorOfDifferentialAction( 1, f, [ x, y ] );
NumeratorOfDifferentialAction( 1, f, [ y, y ] );
NumeratorOfDifferentialAction( 1, f, 2 );
