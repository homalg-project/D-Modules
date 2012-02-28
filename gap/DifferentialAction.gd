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
        [ IsRingElement, IsRingElement, IsList ] );

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsRingElement, IsRingElement, IsInt ] );

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsString, IsInt, IsHomalgRing ] );

####################################
#
# synonyms:
#
####################################

