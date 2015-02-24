#############################################################################
##
##  D-Modules.gi                                           D-Modules package
##
##  Copyright 2010 - 2012, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for D-modules.
##
#############################################################################

####################################
#
# methods for attributes:
#
####################################

##
InstallMethod( AssociatedOrderFilteredRing,
        "for homalg Weyl rings",
        [ IsHomalgRing and IsWeylRing ],
        
  function( A )
    local R, der, n;
    
    R := BaseRing( A );
    der := IndeterminateDerivationsOfRingOfDerivations( A );
    der := List( der, String );
    
    n := Length( der );
    
    return RingOfDerivations(
                   R, der,
                   Concatenation( [ ListWithIdenticalEntries( n, 0 ),
                     ListWithIdenticalEntries( n, 1 ) ] ) );
    
end );

##
InstallMethod( PrimaryIdealOfGrAnn1AtTheOrigin,
        "for a homalg divisor",
        [ IsDivisorRep ],
        
  function( D )
    local ann1, grann1, R, m, pr;
    
    ann1 := Annihilator1( D );
    
    grann1 := AssociatedOrderGradedModule( ann1 );
    
    R := HomalgRing( grann1 );
    
    m := Indeterminates( BaseRing( R ) );
    m := LeftSubmodule( m );
    m := R * m;
    
    pr := PrimaryDecomposition( grann1 );
    
    pr := First( pr, a -> a[2] = m );
    
    if pr = fail then
        return fail;
    fi;
    
    SetAssociatedPrimes( pr[1], [ pr[2] ] );
    
    return pr[1];
    
end );

####################################
#
# methods for operations:
#
####################################

##  <#GAPDoc Label="CoefficientsOfAnnihilatingOperators">
##  <ManSection>
##    <Oper Arg="order,f,g" Name="CoefficientsOfAnnihilatingOperators"/>
##    <Description>
##      <#Include Label="CoefficientsOfAnnihilatingOperators:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( CoefficientsOfAnnihilatingOperators,
        "for an integer and two ring elements",
        [ IsInt, IsRingElement, IsRingElement ],
        
  function( order, f, g )
    local numerator, B;
    
    numerator := NumeratorOfDifferentialAction( order, f, g );
    
    B := HomalgRing( numerator[1] );
    
    numerator := HomalgMatrix( numerator, Length( numerator ), 1, B );
    
    return SyzygiesOfRows( numerator );
    
end );

##
InstallMethod( CoefficientsOfAnnihilatingOperators,
        "for an integer, a string, and a ring",
        [ IsInt, IsString, IsHomalgRing ],
        
  function( order, f, A )
    local numerator, B;
    
    numerator := NumeratorOfDifferentialAction( order, f, A );
    
    B := BaseRing( A );
    
    numerator := HomalgMatrix( numerator, Length( numerator ), 1, B );
    
    return SyzygiesOfRows( numerator );
    
end );

##  <#GAPDoc Label="AnnihilatingOperators">
##  <ManSection>
##    <Oper Arg="order,f,g" Name="AnnihilatingOperators"/>
##    <Description>
##      <#Include Label="AnnihilatingOperators:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( AnnihilatingOperators,
        "for an integer and two ring elements",
        [ IsInt, IsRingElement, IsHomalgRingElement ],
        
  function( order, f, g )
    local A;
    
    A := HomalgRing( g );
    
    if not HasIndeterminateCoordinatesOfRingOfDerivations( A ) then
        A := RingOfDerivations( A );
        g := g / A;
    fi;
    
    return AnnihilatingOperators( order, f / A, g );
    
end );

##
InstallMethod( AnnihilatingOperators,
        "for an integer and two ring elements",
        [ IsInt, IsHomalgRingElement, IsRingElement ],
        
  function( order, f, g  )
    local A, dvar, monomials, coeffs;
    
    A := HomalgRing( f );
    
    if not HasIndeterminateCoordinatesOfRingOfDerivations( A ) then
        A := RingOfDerivations( A );
        f := f / A;
    fi;
    
    dvar := IndeterminateDerivationsOfRingOfDerivations( A );
    
    dvar := List( dvar, String );
    
    monomials := List( [ 0 .. order ], o -> UnorderedTuplesRespectingOrder( dvar, o ) );
    
    monomials := Concatenation( monomials );
    
    monomials := List( monomials, a -> Product( List( a, b -> b / A ) ) );
    
    monomials := HomalgMatrix( monomials, Length( monomials ), 1, A );
    
    coeffs := CoefficientsOfAnnihilatingOperators( order, f, g );
    
    coeffs := A * coeffs;
    
    return coeffs * monomials;
    
end );

##
InstallMethod( AnnihilatingOperators,
        "for an integer, a string, and a ring",
        [ IsInt, IsString, IsHomalgRing ],
        
  function( order, f, A )
    local dvar, monomials, coeffs;
    
    dvar := IndeterminateDerivationsOfRingOfDerivations( A );
    
    dvar := List( dvar, String );
    
    monomials := List( [ 0 .. order ], o -> UnorderedTuplesRespectingOrder( dvar, o ) );
    
    monomials := Concatenation( monomials );
    
    monomials := List( monomials, a -> Product( List( a, b -> b / A ) ) );
    
    monomials := HomalgMatrix( monomials, Length( monomials ), 1, A );
    
    coeffs := CoefficientsOfAnnihilatingOperators( order, f, A );
    
    coeffs := A * coeffs;
    
    return coeffs * monomials;
    
end );

##  <#GAPDoc Label="BasisOfAnnihilatingOperators">
##  <ManSection>
##    <Oper Arg="order,f,g" Name="BasisOfAnnihilatingOperators"/>
##    <Description>
##      <#Include Label="BasisOfAnnihilatingOperators:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( BasisOfAnnihilatingOperators,
        "for an integer and two ring elements",
        [ IsInt, IsRingElement, IsRingElement ],
        
  function( order, f, g )
    
    return BasisOfRows( AnnihilatingOperators( order, f, g ) );
    
end );

##
InstallMethod( BasisOfAnnihilatingOperators,
        "for an integer, a string, and a ring",
        [ IsInt, IsString, IsHomalgRing ],
        
  function( order, f, A )
    
    return BasisOfRows( AnnihilatingOperators( order, f, A ) );
    
end );

##
InstallMethod( Annihilator,
        "for an integer and two ring elements",
        [ IsInt, IsRingElement, IsRingElement ],
        
  function( order, f, g )
    
    ## don't use BasisOfAnnihilatingOperators as it could trigger
    ## a huge computation that we might not even need
    return LeftSubmodule( AnnihilatingOperators( order, f, g ) );
    
end );

##
InstallMethod( Annihilator,
        "for an integer, a string, and a ring",
        [ IsInt, IsString, IsHomalgRing ],
        
  function( order, f, A )
    
    ## don't use BasisOfAnnihilatingOperators as it could trigger
    ## a huge computation that we might not even need
    return LeftSubmodule( AnnihilatingOperators( order, f, A ) );
    
end );

##
InstallMethod( AnnihilatorOfPower,
        "for an integer, a ring element, and an object",
        [ IsInt, IsRingElement, IsObject ],
        
  function( order, f, power )
    local R, k, ks, A;
    
    R := HomalgRing( f );
    
    if HasIsWeylRing( R ) and IsWeylRing( R ) and HasBaseRing( R ) then
        R := BaseRing( R );
    elif not ( HasIsFreePolynomialRing( R ) and IsFreePolynomialRing( R ) and
            HasIndeterminatesOfPolynomialRing( R ) ) then
        Error( "the ring element is not defined over a polynomial ring\n" );
    fi;
    
    if IsChar( power ) then
        power := [ power ];
        ConvertToStringRep( power );	## just to be sure
    fi;
    
    if IsString( power ) then
        if not IsBound( R!.(power) ) then
            k := CoefficientsRing( R );
            ks := k * power;
            R!.(power) := ks * List( IndeterminatesOfPolynomialRing( R ), Name );
        fi;
        R := R!.(power);
    fi;
    
    A := RingOfDerivations( R );
    
    f := Concatenation( "(", String( f ), ")^(", String( power ), ")" );
    
    return Annihilator( order, f, A );
    
end );

##
InstallMethod( AnnihilatorOfPower,
        "for an integer, a divisor, and an object",
        [ IsInt, IsDivisorRep, IsObject ],
        
  function( order, D, power )
    local f;
    
    f := DefiningPolynomial( D );
    
    return AnnihilatorOfPower( order, f, power );
    
end );

##
InstallMethod( AnnihilatorOfPower,
        "for an integer, a divisor",
        [ IsInt, IsDivisorRep ],
        
  function( order, D )
    local f;
    
    f := DefiningPolynomial( D );
    
    return AnnihilatorOfPower( order, f, -1 );
    
end );

##  <#GAPDoc Label="OrderOfFirstEquality">
##  <ManSection>
##    <Oper Arg="f,g" Name="OrderOfFirstEquality"/>
##    <Description>
##      <#Include Label="OrderOfFirstEquality:example">
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
InstallMethod( OrderOfFirstEquality,
        "for two ring elements and an integer",
        [ IsRingElement, IsRingElement ],
        
  function( f, g )
    local L, o;
    
    L := List( [ 1, 2 ], o -> Annihilator( o, f, g ) );
    
    o := Length( L );
    
    while not IsSubset( L[o-1], L[o] ) do
        o := o + 1;
        Add( L, Annihilator( o, f, g ) );
    od;
    
    return o - 1;
    
end );

##
InstallMethod( AssociatedOrderGradedModule,
        "for a homalg module",
        [ IsFinitelyPresentedModuleRep ],
        
  function( M )
    local A, R;
    
    A := HomalgRing( M );
    
    R := AssociatedOrderFilteredRing( A );
    
    ## did not speed up computations when considering
    ## Paco's favorite non-free arrangement in dim 4
    #OnBasisOfPresentation( M );
    
    return AssociatedGradedModule( R * M );
    
end );

##
InstallMethod( AssociatedOrderGradedModule,
        "for a homalg submodule",
        [ IsFinitelyPresentedSubmoduleRep ],
        
  function( J )
    local A, R;
    
    A := HomalgRing( J );
    
    R := AssociatedOrderFilteredRing( A );
    
    return AssociatedGradedModule( R * J );
    
end );

##
InstallMethod( FiltrationByOrder,
        "for an integer and a homalg module",
        [ IsInt, IsFinitelyPresentedModuleRep ],
        
  function( order, M )
    local W, R, der, mon, mat, symb, range, FiM,
          gens, prefilt, i, map, degrees, filt;
    
    W := HomalgRing( M );
    R := BaseRing( W );
    
    der := IndeterminateDerivationsOfRingOfDerivations( W );
    
    mon := List( [ 0 .. order ],
                 o -> UnorderedTuples( [ 1 .. Length( der ) ], o ) );
    
    mon := List( mon, a -> List( a, m -> Product( der{m} ) ) );
    mon[1][1] := One( W );
    
    W := AssociatedOrderFilteredRing( W );
    
    M := W * M;
    
    mat := Concatenation( mon );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        mat := HomalgMatrix( mat, Length( mat ), 1, W );
        mat := SyzygiesGeneratorsOfRows( mat, MatrixOfRelations( M ) );
    else
        mat := HomalgMatrix( mat, 1, Length( mat ), W );
        mat := SyzygiesGeneratorsOfColumns( mat, MatrixOfRelations( M ) );
    fi;
    
    symb := MatrixOfSymbols( mat );
    if not IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        symb := Involution( symb );
    fi;
    symb := EntriesOfHomalgMatrixAsListList( symb );
    
    range := Filtered( [ 1 .. NrRows( mat ) ],
                     r -> ForAll( symb[r], d -> Degree( d ) < 1 ) );

    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        mat := CertainRows( mat, range );
        FiM := LeftPresentation( mat );
    else
        mat := CertainColumns( mat, range );
        FiM := RightPresentation( mat );
    fi;
    
    gens := GeneratingElements( FiM );
    
    prefilt := [ ];
    
    for i in [ 2 .. Length( mon ) ] do
        map := gens{[ 1 .. Sum( List( mon{[ 1 .. i ]}, Length ) ) ]};
        map := List( map, UnderlyingMorphism );
        map := Iterated( map, CoproductMorphism );
        Add( prefilt, map );
    od;
    
    degrees := [ 1 .. order ];
    
    filt := rec( degrees := degrees, tower := true );
    
    Perform( degrees, function( i ) filt.(String( i )) := prefilt[i]; end );
    
    return HomalgAscendingFiltration( filt );
    
end );
