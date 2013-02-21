#############################################################################
##
##  Tools.gd                                               D-Modules package
##
##  Copyright 2010-2011, Mohamed Barakat, University of Kaiserslautern
##
##  Declarations of tool procedures.
##
#############################################################################

####################################
#
# global functions and operations:
#
####################################

# basic operations:

DeclareOperation( "UnorderedTuplesRespectingOrder",
        [ IsList, IsInt ] );

DeclareOperation( "ApplyToSection",
        [ IsHomalgMatrix, IsHomalgMatrix ] );

DeclareOperation( "SolutionOfSystem",
        [ IsHomalgMatrix ] );

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsList, IsString, IsString, IsString, IsHomalgRing ] );

DeclareOperation( "NumeratorOfDifferentialAction",
        [ IsInt, IsString, IsString, IsString, IsHomalgRing ] );
