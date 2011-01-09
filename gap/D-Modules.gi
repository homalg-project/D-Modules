#############################################################################
##
##  D-Modules.gi                                           D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for D-modules.
##
#############################################################################

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="CoefficientsOfAnnihilatingOperators">
##  <ManSection>
##    <Oper Arg="f,g,order" Name="CoefficientsOfAnnihilatingOperators"/>
##    <Description>
##      <#Include Label="CoefficientsOfAnnihilatingOperators:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( CoefficientsOfAnnihilatingOperators,
        "for two ring elements and an integer",
        [ IsRingElement, IsRingElement, IsInt ],
        
  function( f, g, order )
    local numerator, A;
    
    numerator := NumeratorOfDifferentialAction( f, g, order );
    
    A := HomalgRing( numerator[1] );
    
    numerator := HomalgMatrix( numerator, Length( numerator ), 1, A );
    
    return SyzygiesOfRows( numerator );
    
end );

##
InstallMethod( CoefficientsOfAnnihilatingOperators,
        "for string, an integer, and a ring",
        [ IsString, IsInt, IsHomalgRing ],
        
  function( f, order, A )
    local numerator;
    
    numerator := NumeratorOfDifferentialAction( f, order, A );
    
    numerator := HomalgMatrix( numerator, Length( numerator ), 1, A );
    
    return SyzygiesOfRows( numerator );
    
end );

##  <#GAPDoc Label="AnnihilatingOperators">
##  <ManSection>
##    <Oper Arg="f,g,order" Name="AnnihilatingOperators"/>
##    <Description>
##      <#Include Label="AnnihilatingOperators:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( AnnihilatingOperators,
        "for two ring elements and an integer",
        [ IsRingElement, IsHomalgRingElement, IsInt ],
        
  function( f, g, order )
    local A;
    
    A := HomalgRing( g );
    
    return AnnihilatingOperators( f / A, g, order );
    
end );

##
InstallMethod( AnnihilatingOperators,
        "for two ring elements and an integer",
        [ IsHomalgRingElement, IsRingElement, IsInt ],
        
  function( f, g, order )
    local A, dvar, monomials, coeffs;
    
    A := HomalgRing( f );
    
    dvar := IndeterminateDerivationsOfRingOfDerivations( A );
    
    dvar := List( dvar, String );
    
    monomials := List( [ 0 .. order ], o -> UnorderedTuples( dvar, o ) );
    
    monomials := Concatenation( monomials );
    
    monomials := List( monomials, a -> Product( List( a, b -> b / A ) ) );
    
    monomials := HomalgMatrix( monomials, Length( monomials ), 1, A );
    
    coeffs := CoefficientsOfAnnihilatingOperators( f, g, order );
    
    coeffs := A * coeffs;
    
    return coeffs * monomials;
    
end );

##
InstallMethod( AnnihilatingOperators,
        "for string, an integer, and a ring",
        [ IsString, IsInt, IsHomalgRing ],
        
  function( f, order, A )
    local dvar, monomials, coeffs;
    
    dvar := IndeterminateDerivationsOfRingOfDerivations( A );
    
    dvar := List( dvar, String );
    
    monomials := List( [ 0 .. order ], o -> UnorderedTuples( dvar, o ) );
    
    monomials := Concatenation( monomials );
    
    monomials := List( monomials, a -> Product( List( a, b -> b / A ) ) );
    
    monomials := HomalgMatrix( monomials, Length( monomials ), 1, A );
    
    coeffs := CoefficientsOfAnnihilatingOperators( f, order, A );
    
    coeffs := A * coeffs;
    
    return coeffs * monomials;
    
end );

##  <#GAPDoc Label="BasisOfAnnihilatingOperators">
##  <ManSection>
##    <Oper Arg="f,g,order" Name="BasisOfAnnihilatingOperators"/>
##    <Description>
##      <#Include Label="BasisOfAnnihilatingOperators:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( BasisOfAnnihilatingOperators,
        "for two ring elements and an integer",
        [ IsRingElement, IsRingElement, IsInt ],
        
  function( f, g, order )
    
    return BasisOfRows( AnnihilatingOperators( f, g, order ) );
    
end );

##
InstallMethod( BasisOfAnnihilatingOperators,
        "for string, an integer, and a ring",
        [ IsString, IsInt, IsHomalgRing ],
        
  function( f, order, A )
    
    return BasisOfRows( AnnihilatingOperators( f, order, A ) );
    
end );

##
InstallMethod( Annihilator,
        "for two ring elements and an integer",
        [ IsRingElement, IsRingElement, IsInt ],
        
  function( f, g, order )
    
    ## don't use BasisOfAnnihilatingOperators as it could trigger
    ## a huge computation that we might not even need
    return LeftSubmodule( AnnihilatingOperators( f, g, order ) );
    
end );

##
InstallMethod( Annihilator,
        "for string, an integer, and a ring",
        [ IsString, IsInt, IsHomalgRing ],
        
  function( f, order, A )
    
    ## don't use BasisOfAnnihilatingOperators as it could trigger
    ## a huge computation that we might not even need
    return LeftSubmodule( AnnihilatingOperators( f, order, A ) );
    
end );
