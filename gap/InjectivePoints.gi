#############################################################################
##
##  InjectivePoints.gi                                     D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for injective modules.
##
#############################################################################

####################################
#
# representations:
#
####################################

##  <#GAPDoc Label="IsSymbolicallyPresentedModuleRep">
##  <ManSection>
##    <Filt Type="Representation" Arg="M" Name="IsSymbolicallyPresentedModuleRep"/>
##    <Returns><C>true</C> or <C>false</C></Returns>
##    <Description>
##      The &GAP; representation of <Q>symbolically presented</Q> &homalg; modules.
##    <Listing Type="Code"><![CDATA[
DeclareRepresentation( "IsSymbolicallyPresentedModuleRep",
        IsHomalgModule,
        [ "SetsOfGenerators", "SetsOfRelations",
          "TransitionMatrices",
          "PositionOfTheDefaultPresentation" ] );
##  ]]></Listing>
##    </Description>
##  </ManSection>
##  <#/GAPDoc>

####################################
#
# families and types:
#
####################################

# two new types:
BindGlobal( "TheTypeHomalgLeftSymbolicallyPresentedModule",
        NewType( TheFamilyOfHomalgModules,
                IsSymbolicallyPresentedModuleRep and IsHomalgLeftObjectOrMorphismOfLeftObjects ) );

BindGlobal( "TheTypeHomalgRightSymbolicallyPresentedModule",
        NewType( TheFamilyOfHomalgModules,
                IsSymbolicallyPresentedModuleRep and IsHomalgRightObjectOrMorphismOfRightObjects ) );

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( AssociatedSystem,
        "for a homalg matrix and a homalg module",
        [ IsHomalgMatrix,
          IsHomalgModule and
          IsHomalgLeftObjectOrMorphismOfLeftObjects and
          IsInjective ],
        
  function( mat, F )
    local R, S, operator, c, var, u, sec, sys;
    
    R := HomalgRing( F );
    
    if not IsWeylRing( R ) then
        TryNextMethod( );
    fi;
    
    S := HomalgRing( MatrixOfGenerators( F ) );
    
    if not IsBound( mat!.operator ) then
        mat!.operator := S * mat;
    fi;
    
    operator := mat!.operator;
    
    c := NrColumns( operator );
    
    if IsBound(F!.variable_names) then
        var := F!.variable_names;
    fi;
    
    u := HOMALG_D_Modules.smooth_function_name;
    
    u := List( [ 1 .. c ], i -> Concatenation( u, String( i ), "(", var, ")" ) );
    
    u := JoinStringsWithSeparator( u );
    
    u := Concatenation( "[", u, "]" );
    
    sec := HomalgMatrix( u, c, 1, S );
    
    sys := ApplyToSection( operator, sec );
    
    ## store the input in the result
    sys!.section_string := u;
    sys!.section := sec;
    
    return sys;
    
end );

##
InstallMethod( AssociatedSystem,
        "for two homalg module",
        [ IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( M, F )
    
    CheckIfTheyLieInTheSameCategory( M, F );
    
    return AssociatedSystem( MatrixOfRelations( M ), F );
    
end );

##
InstallMethod( AssociatedSystem,
        "for a homalg map and a homalg module",
        [ IsHomalgMap and IsHomalgLeftObjectOrMorphismOfLeftObjects,
          IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi, F )
    
    CheckIfTheyLieInTheSameCategory( phi, F );
    
    return AssociatedSystem( MatrixOfMap( phi ), F );
    
end );

##
InstallMethod( AssociatedSystem,
        "for a homalg module",
        [ IsHomalgModule and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( M )
    
    return MatrixOfRelations( RelationsOfModule( M ) * GeneratorsOfModule( M ) );
    
end );

##
InstallMethod( AssociatedSystem,
        "for a homalg map",
        [ IsHomalgMap and IsHomalgLeftObjectOrMorphismOfLeftObjects ],
        
  function( phi )
    
    return MatrixOfGenerators( MatrixOfMap( phi ) * GeneratorsOfModule( Range( phi ) ) );
    
end );

##
InstallMethod( SolutionSpace,
        "for a homalg matrix and a homalg module",
        [ IsHomalgMatrix, IsHomalgModule ],
        
  function( sys, M )
    local sol;
    
    sol := SolutionOfSystem( sys );
    
    return SpaceOfSections( sol, M );
    
end );

##
## Hom
##

InstallGlobalFunction( _Functor_Hom_In_Injectives_OnModules,		### defines: Hom (object part)
  function( M, F )
    local s, proc_to_readjust_generators, emb, sys, sol, gen;
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        
        proc_to_readjust_generators :=
          function( gen, M_with_s )
            local M, s, T, S;
            
            ## M_with_s = [ M, s ]
            M := M_with_s[1];
            s := M_with_s[2];
            
            T := TransitionMatrix( M, 0, s );
            
            S := HomalgRing( MatrixOfGenerators( F ) );
            
            if not IsBound( T!.operator ) then
                T!.operator := S * T;
            fi;
            
            return ApplyToSection( T!.operator, gen );
            
        end;
        
    else
        
        ## TODO
        
    fi;
    
    if IsTorsionFree( M ) then
        
        emb := Parametrization( M );
        
        sol := AssociatedSystem( emb, F );
        
        sol := SpaceOfSections( sol, M );
        
    else
        
        sys := AssociatedSystem( M, F );
        
        sol := SolutionSpace( sys, M );
        
    fi;
    
    gen := GeneratorsOfModule( sol );
    
    s := PositionOfTheDefaultSetOfGenerators( M );
    
    SetProcedureToReadjustGenerators( gen, [ proc_to_readjust_generators, [ M, s ] ] );
    
    return sol;
    
end );

##
InstallValue( Functor_Hom_In_Injectives,
        CreateHomalgFunctor(
                [ "name", "Hom with values in an injective module" ],
                [ "operation", "Hom" ],
                [ "number_of_arguments", 2 ],
                [ "1", [ [ "contravariant", "right adjoint", "distinguished" ] ] ],
                [ "2", [ [ "covariant", "left exact" ], [ IsSymbolicallyPresentedModuleRep ] ] ],
                [ "OnObjects", _Functor_Hom_In_Injectives_OnModules ]
                #[ "OnMorphisms", _Functor_Hom_OnMaps ],
                #[ "ConstructMorphism", HOMALG_MODULES.ConstructMorphism ]
                )
        );

##
InstallFunctorOnObjects( Functor_Hom_In_Injectives );

####################################
#
# constructor functions and methods:
#
####################################

##
InstallMethod( AssociatedRingForInjectiveModules,
        "constructor for homalg rings",
        [ IsHomalgRing and IsWeylRing ],
        
  function( R )
    local var, der, S, A;
    
    if HasRelativeIndeterminateCoordinatesOfRingOfDerivations( R ) then
        var := RelativeIndeterminateCoordinatesOfRingOfDerivations( R );
    else
        var := IndeterminateCoordinatesOfRingOfDerivations( R );
    fi;
    der := IndeterminateDerivationsOfRingOfDerivations( R );
    
    var := List( var, Name );
    der := List( der, Name );
    
    S := HomalgFieldOfRationalsInMaple( ) * var;
    
    A := RingOfDerivations( S, der );
    
    A!.SystemNotCompletelySolvable := "warn";
    
    if Length( var ) = 1 then
        A!.solver := "dsolve";
    else
        A!.solver := "pdsolve";
    fi;
    
    return A;
    
end );

##
InstallMethod( InjectiveModule,
        "constructor for homalg modules",
        [ IsHomalgRing, IsString ],
        
  function( R, string )
    local A, var, left, gens, rels, type, domain, I;
    
    A := AssociatedRingForInjectiveModules( R );
    
    var := IndeterminateCoordinatesOfRingOfDerivations( A );
    var := List( var, Name );
    var := JoinStringsWithSeparator( var );
    
    gens := Concatenation( "[", HOMALG_D_Modules.smooth_function_name, "(", var, ")]" );
    gens := HomalgMatrix( gens, 1, 1, A );
    
    left := string = "left";
    
    if left then
        type := TheTypeHomalgLeftSymbolicallyPresentedModule;
        domain := LeftActingDomain;
        gens := HomalgGeneratorsForLeftModule( gens );
        gens := CreateSetsOfGeneratorsForLeftModule( gens );
    else
        type := TheTypeHomalgRightSymbolicallyPresentedModule;
        domain := RightActingDomain;
        gens := HomalgGeneratorsForRightModule( gens );
        gens := CreateSetsOfGeneratorsForRightModule( gens );
    fi;
    
    I := rec( string := "module",
              string_plural := "modules",
              ring := R,
              SetsOfGenerators := gens,
              #SetsOfRelations := rels,
              variable_names := var,
              DisplayString := Concatenation( "SomeSmoothFunctions( ", var, " )" ),
              TransitionMatrices := rec( ),
              PositionOfTheDefaultPresentation := 1 );
    
    ObjectifyWithAttributes(
            I, type,
            domain, R,
            GeneratorsOfRightOperatorAdditiveGroup, I!.SetsOfGenerators!.1,
            IsInjective, true );
    
    return I;
    
end );

##
InstallMethod( InjectiveLeftModule,
        "constructor for homalg modules",
        [ IsHomalgRing ],
        
  function( R )
    
    return InjectiveModule( R, "left" );
    
end );

##
InstallMethod( InjectiveRightModule,
        "constructor for homalg modules",
        [ IsHomalgRing ],
        
  function( R )
    
    return InjectiveModule( R, "right" );
    
end );

##
InstallMethod( SpaceOfSections,
        "constructor for homalg modules",
        [ IsHomalgMatrix, IsHomalgRing, IsString ],
        
  function( sec, R, string )
    local left, gens, rels, type, domain, space;
    
    left := string = "left";
    
    if left then
        type := TheTypeHomalgLeftSymbolicallyPresentedModule;
        domain := LeftActingDomain;
        gens := HomalgGeneratorsForLeftModule( sec );
        gens := CreateSetsOfGeneratorsForLeftModule( gens );
    else
        type := TheTypeHomalgRightSymbolicallyPresentedModule;
        domain := RightActingDomain;
        gens := HomalgGeneratorsForRightModule( sec );
        gens := CreateSetsOfGeneratorsForRightModule( gens );
    fi;
    
    space := rec( string := "module",
                  string_plural := "modules",
                  ring := R,
                  SetsOfGenerators := gens,
                  #SetsOfRelations := rels,
                  TransitionMatrices := rec( ),
                  PositionOfTheDefaultPresentation := 1 );
    
    ObjectifyWithAttributes(
            space, type,
            domain, R,
            GeneratorsOfRightOperatorAdditiveGroup, space!.SetsOfGenerators!.1 );
    
    return space;
    
end );

##
InstallMethod( SpaceOfSections,
        "constructor for homalg modules",
        [ IsHomalgMatrix, IsHomalgModule ],
        
  function( sec, M )
    local C, string;
    
    C := Center( HomalgRing( M ) );
    
    if IsHomalgLeftObjectOrMorphismOfLeftObjects( M ) then
        string := "right";	## this is not a mistake
    else
        string := "left";
    fi;
    
    return SpaceOfSections( sec, C, string );
    
end );

####################################
#
# View, Print, and Display methods:
#
####################################

##
InstallMethod( ViewObj,
        "for homalg modules",
        [ IsSymbolicallyPresentedModuleRep ],
        
  function( M )
    
    Print( "<A" );
    
    if HasIsInjective( M ) and IsInjective( M ) then
        Print( "n injective" );
    fi;
    
    
    
    Print( " homalg module>" );
    
end );

##
InstallMethod( Display,
        "for homalg modules",
        [ IsSymbolicallyPresentedModuleRep ],
        
  function( M )
    local mat, gen;
    
    gen := GeneratorsOfModule( M );
    
    mat := MatrixOfGenerators( gen );
    
    if IsBound( mat!.Relations ) then
        
        homalgDisplay( mat!.Relations );
        
        Print( "\nsolution subject to the above relations:\n\n" );
        
    fi;
    
    Display( gen );
    
    if IsBound( mat!.Relations ) then
        
        Print( "\n(solution subject to the above relations)\n" );
        
    fi;
    
end );
