#############################################################################
##
##  DifferentialAction.gd                                  D-Modules package
##
##  Copyright 2010-2012, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations for differential actions.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# constructors:

# basic operations:

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsList, IsRingElement, IsRingElement ] );

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsInt, IsRingElement, IsRingElement ] );

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsInt, IsString, IsHomalgRing ] );

####################################
#
# synonyms:
#
####################################

