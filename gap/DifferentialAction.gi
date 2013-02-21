#############################################################################
##
##  DifferentialAction.gi                                  D-Modules package
##
##  Copyright 2010-2012, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for differential actions.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="NumeratorOfDifferentialAction:der">
##  <ManSection>
##    <Oper Arg="der,f,g" Name="NumeratorOfDifferentialAction" Label="given a list of variables"/>
##    <Description>
##      <#Include Label="NumeratorOfDifferentialAction:der_example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NumeratorOfDifferentialAction,
        "for a list of variables and two ring elements",
        [ IsList, IsRingElement, IsHomalgRingElement ],
        
  function( der, f, g )
    local A;
    
    A := HomalgRing( g );
    
    if not HasIndeterminateCoordinatesOfRingOfDerivations( A ) then
        A := RingOfDerivations( A );
        g := g / A;
    fi;
    
    return NumeratorOfDifferentialAction( der, f / A, g );
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for a list of variables and two ring elements",
        [ IsList, IsHomalgRingElement, IsRingElement ],
        
  function( der, f, g )
    local A, B, ivar, R, f_g, var;
    
    A := HomalgRing( f );
    
    if not HasIndeterminateCoordinatesOfRingOfDerivations( A ) then
        A := RingOfDerivations( A );
        f := f / A;
    fi;
    
    B := BaseRing( A );
    
    if HasRelativeIndeterminateCoordinatesOfRingOfDerivations( A ) then
        ivar := RelativeIndeterminateCoordinatesOfRingOfDerivations( A );
    else
        ivar := IndeterminateCoordinatesOfRingOfDerivations( A );
    fi;
    
    ivar := List( ivar, String );
    
    ivar := JoinStringsWithSeparator( ivar );
    
    ivar := Concatenation( "[", ivar, "]" );
    
    R := AssociatedRingForInjectiveModules( A );
    
    g := Concatenation( "(",  String( g ), ")" );
    
    f := Concatenation( "(", String( f ), ")" );
    
    return NumeratorOfDifferentialAction( der, f, g, ivar, R ) / B;
    
end );

##  <#GAPDoc Label="NumeratorOfDifferentialAction:ord">
##  <ManSection>
##    <Oper Arg="order,f,g" Name="NumeratorOfDifferentialAction" Label="given an order"/>
##    <Description>
##      <#Include Label="NumeratorOfDifferentialAction:ord_example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NumeratorOfDifferentialAction,
        "for an integer and two ring elements",
        [ IsInt, IsRingElement, IsHomalgRingElement ],
        
  function( order, f, g )
    local A;
    
    A := HomalgRing( g );
    
    return NumeratorOfDifferentialAction( order, f / A, g );
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for an integer and two ring elements",
        [ IsInt, IsHomalgRingElement, IsRingElement ],
        
  function( order, f, g )
    local A, B, ivar, monomials, gg;
    
    A := HomalgRing( f );
    
    if not HasIndeterminateCoordinatesOfRingOfDerivations( A ) then
        A := RingOfDerivations( A );
        f := f / A;
    fi;
    
    B := BaseRing( A );
    
    if HasRelativeIndeterminateCoordinatesOfRingOfDerivations( A ) then
        ivar := RelativeIndeterminateCoordinatesOfRingOfDerivations( A );
    else
        ivar := IndeterminateCoordinatesOfRingOfDerivations( A );
    fi;
    
    ivar := List( ivar, String );
    
    monomials := List( [ 0 .. order ], o -> UnorderedTuplesRespectingOrder( ivar, o ) );
    
    monomials := Concatenation( monomials );
    
    gg := g / BaseRing( A );
    
    return List( monomials, m ->  gg^(order - Length( m )) * NumeratorOfDifferentialAction( m, f, g ) );
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for an integer, a string, and a ring",
        [ IsInt, IsString, IsHomalgRing ],
        
  function( order, f, A )
    local B, ivar, R, coeffs;
    
    B := BaseRing( A );
    
    if HasRelativeIndeterminateCoordinatesOfRingOfDerivations( A ) then
        ivar := RelativeIndeterminateCoordinatesOfRingOfDerivations( A );
    else
        ivar := IndeterminateCoordinatesOfRingOfDerivations( A );
    fi;
    
    ivar := List( ivar, String );
    
    ivar := JoinStringsWithSeparator( ivar );
    
    ivar := Concatenation( "[", ivar, "]" );
    
    R := AssociatedRingForInjectiveModules( A );
    
    coeffs := NumeratorOfDifferentialAction( order, f, ivar, f, R );
    
    coeffs := SplitString( coeffs, "," );
    
    return List( coeffs, c -> c / B );
    
end );
