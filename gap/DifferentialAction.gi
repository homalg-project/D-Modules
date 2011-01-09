#############################################################################
##
##  DifferentialAction.gi                                  D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
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
##    <Oper Arg="f,g,der" Name="NumeratorOfDifferentialAction"/>
##    <Description>
##      <#Include Label="NumeratorOfDifferentialAction:der_example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NumeratorOfDifferentialAction,
        "for two ring elements and list of variables",
        [ IsRingElement, IsHomalgRingElement, IsList ],
        
  function( f, g, der )
    local A;
    
    A := HomalgRing( g );
    
    return NumeratorOfDifferentialAction( f / A, g, der );
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for two ring elements and list of variables",
        [ IsHomalgRingElement, IsRingElement, IsList ],
        
  function( f, g, der )
    local A, f_g, var, ivar, R;
    
    A := HomalgRing( f );
    
    f_g := Concatenation( "(", String( f ), ")/(",  String( g ), ")" );
    
    var := List( der, String );
    
    var := JoinStringsWithSeparator( var );
    
    var := Concatenation( "[", var, "]" );
    
    ivar := IndeterminateCoordinatesOfRingOfDerivations( A );
    
    ivar := List( ivar, String );
    
    ivar := JoinStringsWithSeparator( ivar );
    
    ivar := Concatenation( "[", ivar, "]" );
    
    R := AssociatedRingForInjectiveModules( A );
    
    return NumeratorOfDifferentialAction( f_g, var, ivar, R ) / BaseRing( A );
    
end );

##  <#GAPDoc Label="NumeratorOfDifferentialAction:ord">
##  <ManSection>
##    <Oper Arg="f,g,der" Name="NumeratorOfDifferentialAction"/>
##    <Description>
##      <#Include Label="NumeratorOfDifferentialAction:ord_example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( NumeratorOfDifferentialAction,
        "for two ring elements and an integer",
        [ IsRingElement, IsHomalgRingElement, IsInt ],
        
  function( f, g, order )
    local A;
    
    A := HomalgRing( g );
    
    return NumeratorOfDifferentialAction( f / A, g, order );
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for two ring elements and an integer",
        [ IsHomalgRingElement, IsRingElement, IsInt ],
        
  function( f, g, order )
    local A, ivar, monomials, gg;
    
    A := HomalgRing( f );
    
    ivar := IndeterminateCoordinatesOfRingOfDerivations( A );
    
    ivar := List( ivar, String );
    
    monomials := List( [ 0 .. order ], o -> UnorderedTuples( ivar, o ) );
    
    monomials := Concatenation( monomials );
    
    gg := g / BaseRing( A );
    
    return List( monomials, m ->  gg^(order - Length( m )) * NumeratorOfDifferentialAction( f, g, m ) );
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for string, an integer, and a ring",
        [ IsString, IsInt, IsHomalgRing ],
        
  function( f, order, A )
    local ivar, monomials, R, coeffs;
    
    ivar := IndeterminateCoordinatesOfRingOfDerivations( A );
    
    ivar := List( ivar, String );
    
    ivar := JoinStringsWithSeparator( ivar );
    
    ivar := Concatenation( "[", ivar, "]" );
    
    R := AssociatedRingForInjectiveModules( A );
    
    coeffs := NumeratorOfDifferentialAction( f, order, ivar, f, R );
    
    coeffs := SplitString( coeffs, "," );
    
    return List( coeffs, c -> c / A );
    
end );

