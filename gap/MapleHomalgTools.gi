#############################################################################
##
##  MapleHomalgTools.gi                                    D-Modules package
##
##  Copyright 2010, Mohamed Barakat, University of Kaiserslautern
##
##  Implementations for the rings provided by the Maple implementation of homalg.
##
#############################################################################

####################################
#
# global variables:
#
####################################

InstallValue( D_ModulesHomalgTableForMapleHomalgTools,
        
        rec(
            ApplyToSection :=
              function( M, u )
                local R;
                
                R := HomalgRing( M );
                
                return homalgSendBlocking( [ "`JanetOre/JApplyMatrix`(", M, u, R, "[1][1],", R, "[1][3])" ],
                               HOMALG_IO.Pictograms.ApplyToSection );
                
              end,
            
            SolutionOfSystem :=
              function( sys )
                local R, stream, v, solver, b, where, rel, r, u, sol;
                
                if not IsBound( sys!.section_string ) then
                    Error( "missing string describing the section\n" );
                fi;
                
                R := HomalgRing( sys );
                
                stream := homalgStream( R );
                
                v := stream!.variable_name;
                
                solver := R!.solver;
                
                homalgSendBlocking( [ v, "sol := ", solver, "(map(op,convert(", sys, ",listlist)))" ],
                                                 "need_command", HOMALG_IO.Pictograms.SolutionOfSystem );
                
                b := homalgSendBlocking( [ "type(", v, "sol,set) or type(", v, "sol,`=`)" ],
                             "need_output", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                
                b := b = "false";        ## system was not solved completely
                
                if b then
                    where := homalgSendBlocking( [ "op(0,", v, ")=`&where`" ],
                                     "need_output", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                    if where = "true" then
                        homalgSendBlocking( [ v, "sol:=op(", v, "sol)" ],
                                "need_command", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                    fi;
                    rel := homalgSendBlocking( [ v, "sol[2]: ", v, "sol:=", v, "sol[1]" ],
                                   stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                fi;
                
                r := NrRows( sys!.section );
                
                u := sys!.section_string;
                
                sol := homalgSendBlocking( [ "matrix(", r,",1,subs(", v, "sol,", u, "))" ],
                               stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                
                sol!.solver := solver;
                
                if b then
                    sol!.Relations := rel;
                fi;
                
                return sol;
                
              end,
            
            NumeratorOfDifferentialAction :=
              function( section, monomial, arguments, R )
                
                return homalgSendBlocking( [ "numer(`jets/totalder`(", section, ",", monomial, ",", arguments, "))" ],
                                 R, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
              end,
            
            NumeratorOfDifferentialActionByOrder :=
              function( section, order, arguments, multiplier, R )
                local stream, v;
                
                stream := homalgStream( R );
                
                v := stream!.variable_name;
                
                homalgSendBlocking( [ v, "mon:=map(`jets/symch`,[$0..", order, "],", arguments, ")" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "lvar:=map(c->cat(__Q,op(c)),", v, "mon)" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "dop:=map(c->[cat(__Q,op(c)),c],", v, "mon)" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "res:=`jets/appmt`(", v, "dop,", section, ",", arguments, ")" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "res:=simplify(", v, "res/(", multiplier, "))" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "res:=numer(", v, "res)" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "res:=factors(", v, "res)[2]" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "res:=map(c->c[1],", v, "res)" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ v, "res:=map(c->if has(c,", v, "lvar) then return c fi,", v, "res)" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                homalgSendBlocking( [ "if nops(", v, "res)<>1 then ERROR(`factors returned more than one relevant factor`) fi" ],
                        "need_command", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
                return homalgSendBlocking( [ "op(map(convert,[`jets/jcoeffs`(", v, "res[1],", v, "lvar)],symbol))" ],
                        "need_output", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
              end,
            
        )
 );

## enrich the global homalg table for MapleHomalg:
AddToAhomalgTable( CommonHomalgTableForMapleHomalgTools, D_ModulesHomalgTableForMapleHomalgTools );
