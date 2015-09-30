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

DeclareAttribute( "AssociatedOrderGradedModule",
        IsHomalgModule );

DeclareAttribute( "PrimaryIdealOfGrAnn1AtTheOrigin",
        IsDivisor );

####################################
#
# global functions and operations:
#
####################################

# constructors:

# basic operations:

DeclareOperation( "CoefficientsOfAnnihilatingOperators",
        [ IsInt, IsRingElement, IsRingElement ] );

DeclareOperation( "CoefficientsOfAnnihilatingOperators",
        [ IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "AnnihilatingOperators",
        [ IsInt, IsRingElement, IsRingElement ] );

DeclareOperation( "AnnihilatingOperators",
        [ IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "BasisOfAnnihilatingOperators",
        [ IsInt, IsRingElement, IsRingElement ] );

DeclareOperation( "BasisOfAnnihilatingOperators",
        [ IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "Annihilator",
        [ IsInt, IsRingElement, IsRingElement ] );

DeclareOperation( "Annihilator",
        [ IsInt, IsString, IsHomalgRing ] );

DeclareOperation( "AnnihilatorOfPower",
        [ IsInt, IsRingElement, IsObject ] );

DeclareOperation( "AnnihilatorOfPower",
        [ IsInt, IsDivisor, IsObject ] );

DeclareOperation( "AnnihilatorOfPower",
        [ IsInt, IsDivisor ] );

DeclareOperation( "OrderOfFirstEquality",
        [ IsRingElement, IsRingElement ] );

DeclareOperation( "OrderOfFirstEquality",
        [ IsString, IsHomalgRing ] );

DeclareOperation( "FiltrationByOrder",
        [ IsInt, IsHomalgModule ] );

DeclareOperation( "PrimaryIdealOfGrAnnOfPowerAtTheOrigin",
        [ IsInt, IsDivisor ] );

DeclareOperation( "SubmoduleOfGrAnnOfPowerAtTheOrigin",
        [ IsInt, IsDivisor, IsInt, IsInt ] );

####################################
#
# synonyms:
#
####################################
