##  <#GAPDoc Label="OrderOfFirstEquality:example">
##  <Example><![CDATA[
##  gap> R := HomalgFieldOfRationalsInDefaultCAS( ) * "x,y";
##  Q[x,y]
##  gap> AssignGeneratorVariables( R );
##  #I  Global variable `x' is already defined and will be overwritten
##  #I  Global variable `y' is already defined and will be overwritten
##  #I  Assigned the global variables [ x, y ]
##  gap> Reiffen := function( p, q )
##  >    if q >= p + 1 and p + 1 >= 5 then
##  >        return ( x^p + y*y^(q-1) + x*y^(q-1) );
##  >    fi;
##  >    Error( "We want q >= p + 1 and p + 1 >= 5\n" );
##  > end;;
##  gap> f := p -> Reiffen( p, p+1 );;
##  gap> List( [ 4 .. 8 ], p -> OrderOfFirstEquality( 1, f(p) ) );
##  [ 2, 2, 3, 4, 4 ]
##  ]]></Example>
##  <#/GAPDoc>

Read( "../Reiffen_data.g" );

f := p -> Reiffen( p, p+1 );

kappa := List( [ 4 .. 8 ], p -> OrderOfFirstEquality( 1, f( p ) ) );

Assert( 0, kappa = [ 2, 2, 3, 4, 4 ] );
