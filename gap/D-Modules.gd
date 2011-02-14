#############################################################################
##
##  D-Modules.gd                                           D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for D-modules.
##
#############################################################################

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

DeclareOperation( "OrderOfStability",
        [ IsRingElement, IsRingElement ] );

DeclareOperation( "OrderOfStability",
        [ IsString, IsHomalgRing ] );

####################################
#
# synonyms:
#
####################################

