#############################################################################
##
##  Tools.gi                                               D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations of tool procedures.
##
#############################################################################

####################################
#
# global variables:
#
####################################

HOMALG_IO.Pictograms.ApplyToSection := "sec";
HOMALG_IO.Pictograms.SolutionOfSystem := "sol";
HOMALG_IO.Pictograms.NumeratorOfDifferentialAction := "tot";

####################################
#
# methods for operations:
#
####################################

##
InstallMethod( ApplyToSection,
        "for two homalg matrices",
        [ IsHomalgMatrix, IsHomalgMatrix ],
        
  function( mat, u )
    local R, RP, sec;
    
    R := HomalgRing( mat );
    
    RP := homalgTable( R );
    
    if not IsBound( RP!.ApplyToSection ) then
        Error( "could not find a procedure called ApplyToSection in the homalgTable of the ring\n" );
    fi;
    
    sec := RP!.ApplyToSection( mat, u );	## the external object
    
    return HomalgMatrix( sec, NrRows( mat ), 1, R );
    
end );

##
InstallMethod( SolutionOfSystem,
        "for a homalg matrix",
        [ IsHomalgMatrix ],
        
  function( sys )
    local R, RP, c, sol, rel, cas, solver;
    
    R := HomalgRing( sys );
    
    RP := homalgTable( R );
    
    if not IsBound( RP!.SolutionOfSystem ) then
        Error( "could not find a procedure called SolutionOfSystem in the homalgTable of the ring\n" );
    fi;
    
    if not IsBound( sys!.section ) then
        Error( "missing section\n" );
    fi;
    
    c := NrRows( sys!.section );
    
    sol := RP!.SolutionOfSystem( sys );	## the external object
    
    if IsBound( sol!.Relations ) then
        
        rel := sol!.Relations;
        Unbind( sol!.Relations );	## will bind it to the output matrix below
        
        cas := homalgExternalCASystem( R );
        
        solver := sol!.solver;
        
        if IsBound( R!.SystemNotCompletelySolvable ) and
           R!.SystemNotCompletelySolvable = "warn" then
            Info( InfoWarning, 1, "\033[01;31;47m",
                  cas, "'s ", solver,
                  " was not able to solve the system completely",
                  "\033[0m" );
        else
            Error( cas, "'s ", solver,
                   " was not able to solve the system completely" );
        fi;
    fi;
    
    sol := HomalgMatrix( sol, c, 1, R );
    
    ## store any relations in the solution matrix
    if IsBound( rel ) then
        sol!.Relations := rel;
    fi;
    
    return sol;
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for strings",
        [ IsString, IsString, IsString, IsHomalgRing ],
        
  function( section, monomial, arguments, R )
    local RP, tot;
    
    RP := homalgTable( R );
    
    if not IsBound( RP!.NumeratorOfDifferentialAction ) then
        Error( "could not find a procedure called NumeratorOfDifferentialAction in the homalgTable of the ring\n" );
    fi;
    
    tot := RP!.NumeratorOfDifferentialAction( section, monomial, arguments, R );
    
    tot := HomalgRingElement( tot, R );
    
    return tot;
    
end );

##
InstallMethod( NumeratorOfDifferentialAction,
        "for strings",
        [ IsString, IsInt, IsString, IsString, IsHomalgRing ],
        
  function( section, order, arguments, multiplier, R )
    local RP, tot;
    
    RP := homalgTable( R );
    
    if not IsBound( RP!.NumeratorOfDifferentialActionByOrder ) then
        Error( "could not find a procedure called NumeratorOfDifferentialActionByOrder in the homalgTable of the ring\n" );
    fi;
    
    tot := RP!.NumeratorOfDifferentialActionByOrder( section, order, arguments, multiplier, R );
    
    return tot;
    
end );

