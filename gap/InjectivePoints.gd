#############################################################################
##
##  InjectivePoints.gd                                     D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for injective modules.
##
#############################################################################

####################################
#
# global variables:
#
####################################

## Hom
DeclareGlobalFunction( "_Functor_Hom_In_Injectives_OnModules" );

DeclareGlobalVariable( "Functor_Hom_In_Injectives" );

####################################
#
# properties:
#
####################################

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="AssociatedRingForInjectiveModules">
##  <ManSection>
##    <Attr Arg="R" Name="AssociatedRingForInjectiveModules" Label="for homalg rings"/>
##    <Returns>a &homalg; ring</Returns>
##    <Description>
##      A copy of the ring <A>R</A> in a CAS that supports <Q>injective modules</Q>.
##    </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AssociatedRingForInjectiveModules",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# constructors:

DeclareOperation( "InjectiveModule",
        [ IsHomalgRing, IsString ] );

DeclareOperation( "InjectiveLeftModule",
        [ IsHomalgRing ] );

DeclareOperation( "InjectiveRightModule",
        [ IsHomalgRing ] );

DeclareOperation( "SpaceOfSections",
        [ IsHomalgMatrix, IsHomalgRing, IsString ] );

DeclareOperation( "SpaceOfSections",
        [ IsHomalgMatrix, IsHomalgModule ] );

# basic operations:

DeclareOperation( "AssociatedSystem",
        [ IsHomalgMatrix, IsHomalgModule ] );

DeclareOperation( "AssociatedSystem",
        [ IsHomalgModule, IsHomalgModule ] );

DeclareOperation( "AssociatedSystem",
        [ IsHomalgMap, IsHomalgModule ] );

DeclareOperation( "SolutionSpace",
        [ IsHomalgMatrix, IsHomalgModule ] );

####################################
#
# synonyms:
#
####################################

