##  <#GAPDoc Label="OrderOfStability:example">
##  <Example><![CDATA[
##  gap> Qxy := HomalgFieldOfRationalsInDefaultCAS( "s" ) * "x,y";;
##  gap> A2 := RingOfDerivations( Qxy, "Dx,Dy" );;
##  gap> var := IndeterminateCoordinatesOfRingOfDerivations( A2 );
##  [ x, y ]
##  gap> x := var[1];
##  x
##  gap> y := var[2];
##  y
##  gap> Reiffen := function( p, q )
##  >    if q >= p + 1 and p + 1 >= 5 then
##  >        return ( x^p + y*y^(q-1) + x*y^(q-1) ) / A2;
##  >    fi;
##  >    Error( "We want q >= p + 1 and p + 1 >= 5\n" );
##  > end;;
##  gap> f := p -> Reiffen( p, p+1 );;
##  gap> List( [ 4 .. 8 ], p -> OrderOfStability( 1, f(p) ) );
##  [ 2, 2, 3, 4, 4 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../Reiffen.g" );

f := p -> Reiffen( p, p+1 );

kappa := List( [ 4 .. 8 ], p -> OrderOfStability( 1, f(p) ) );

Assert( 0, kappa = [ 2, 2, 3, 4, 4 ] );
