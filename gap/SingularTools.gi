#############################################################################
##
##  SingularTools.gi                                       D-Modules package
##
##  Copyright 2011, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for the rings provided by Singular.
##
#############################################################################

####################################
#
# global variables:
#
####################################

##
InstallValue( D_ModulesMacrosForSingular,
        rec(
            
    _CAS_name := "Singular",
    
    _Identifier := "D-Modules",
    
    $D_Modules_init := "\n\
LIB \"bfun.lib\";\n\
\n\n",
    
    )

);

##
UpdateMacrosOfCAS( D_ModulesMacrosForSingular, SingularMacros );
UpdateMacrosOfLaunchedCASs( D_ModulesMacrosForSingular );

##
InstallValue( D_ModulesTableForSingularTools,
        
        rec(
               IntersectWithSubalgebra :=
                 function( I, s )
                   
                   return homalgSendBlocking( [ "vec2poly(pIntersect(", s, ",slimgb(", I, ")),1)" ], [ "poly" ], HOMALG_IO.Pictograms.IntersectWithSubalgebra );
                   
                 end,
               
        )
 );

## enrich the global homalg table for Singular:
AppendToAhomalgTable( CommonHomalgTableForSingularTools, D_ModulesTableForSingularTools );
AppendTohomalgTablesOfCreatedExternalRings( D_ModulesTableForSingularTools, IsHomalgExternalRingInSingularRep );
