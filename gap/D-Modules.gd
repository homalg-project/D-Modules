#############################################################################
##
##  D-Modules.gd                                           D-Modules package
##
##  Copyright 2010-2012, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for D-modules.
##
#############################################################################

####################################
#
# attributes:
#
####################################

##  <#GAPDoc Label="AssociatedOrderGradedRing">
##  <ManSection>
##    <Attr Arg="R" Name="AssociatedOrderGradedRing"/>
##    <Returns>a homalg ring</Returns>
##    <Description>
##      The graded ring associated to the filtered ring <A>R</A>.
##   </Description>
##  </ManSection>
##  <#/GAPDoc>
##
DeclareAttribute( "AssociatedOrderFilteredRing",
        IsHomalgRing );

####################################
#
# global functions and operations:
#
####################################

# constructors:

# basic operations:

DeclareOperation( "CoefficientsOfAnnihilatingOperators",
        [ IsRingElement, IsRingElement, IsInt ] );

DeclareOperation( "CoefficientsOfAnnihilatingOperators",
        [ IsString, IsInt, IsHomalgRing ] );

DeclareOperation( "AnnihilatingOperators",
        [ IsRingElement, IsRingElement, IsInt ] );

DeclareOperation( "AnnihilatingOperators",
        [ IsString, IsInt, IsHomalgRing ] );

DeclareOperation( "BasisOfAnnihilatingOperators",
        [ IsRingElement, IsRingElement, IsInt ] );

DeclareOperation( "BasisOfAnnihilatingOperators",
        [ IsString, IsInt, IsHomalgRing ] );

DeclareOperation( "Annihilator",
        [ IsRingElement, IsRingElement, IsInt ] );

DeclareOperation( "Annihilator",
        [ IsString, IsInt, IsHomalgRing ] );

DeclareOperation( "OrderOfFirstEquality",
        [ IsRingElement, IsRingElement ] );

DeclareOperation( "OrderOfFirstEquality",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "AssociatedOrderGradedModule",
        [ IsHomalgModule ] );

####################################
#
# synonyms:
#
####################################

