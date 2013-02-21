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
                
                return homalgSendBlocking( [ "simplify(`JanetOre/JApplyMatrix`(", M, u, R, "[1][1],", R, "[1][3]))" ],
                               HOMALG_IO.Pictograms.ApplyToSection );
                
              end,
            
            SolutionOfSystem :=
              function( sys )
                local R, stream, v, solver, b, u, cas, where, list, rel, r, sol;
                
                if not IsBound( sys!.section_string ) then
                    Error( "missing string describing the section\n" );
                fi;
                
                R := HomalgRing( sys );
                
                stream := homalgStream( R );
                
                v := stream!.variable_name;
                
                solver := R!.solver;
                
                homalgSendBlocking( [ v, "sol := ", solver, "(map(op,convert(", sys, ",listlist)))" ],
                                                 "need_command", HOMALG_IO.Pictograms.SolutionOfSystem );
                
                ####
                ## pdsolve( \
                ## [[D[1](f1)(x,y,z)+1/3*f2(x,y,z)-1/9*x*f3(x,y,z)], [D[2](f2)(x,y,z)+1/6*f3(x,\
                ##             y,z)], [D[1](f2)(x,y,z)-1/2*f3(x,y,z)], [D[3](f3)(x,y,z)], [D[2](f3)(x,y\
                ##            ,z)], [D[1](f3)(x,y,z)]] )
                ## ->
                ## {f1(x,y,z) = -1/36*_C1*x^2+(-1/3*_F1(z)+1/18*_C1*y)*x+_F2(y,z), f2(x,y,z) = \
                ##     _F1(z)+1/6*(3*x-y)*_C1, f3(x,y,z) = _C1}
                
                b := homalgSendBlocking( [ "type(", v, "sol,set(`=`)) or type(", v, "sol,`=`)" ],
                             "need_output", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                
                b := b = "false";        ## the system was not solved completely
                
                u := sys!.section_string;
                
                if b then
                    cas := homalgExternalCASystem( R );
                    
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
                    
                    where := homalgSendBlocking( [ "evalb(op(0,", v, "sol)=`&where`)" ],
                                     "need_output", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                    if where = "true" then
                        homalgSendBlocking( [ v, "sol:=op(", v, "sol)" ],
                                "need_command", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                    fi;
                    
                    list := homalgSendBlocking( [ "type(", v, "sol,list) and nops(", v, "sol)=1 and type(", v, "sol[1],list)" ],
                                    "need_output", stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                    
                    if list = "true" then
                        
                        ## ->
                        ## [[diff(f1(x1,x2,x3,x4),x2) = (x1*x3*diff(f1(x1,x2,x3,x4),x4)-x2*x4*diff(f1(x\
                        ##     1,x2,x3,x4),x4)+x2*x3*diff(f1(x1,x2,x3,x4),x3)-x1*x4*diff(f1(x1,x2,x3,x4\
                        ##     ),x3))/(x3^2-x4^2), diff(f1(x1,x2,x3,x4),x1) = (x2*x3*diff(f1(x1,x2,x3,x\
                        ##     4),x4)-x1*x4*diff(f1(x1,x2,x3,x4),x4)+x1*x3*diff(f1(x1,x2,x3,x4),x3)-x2*\
                        ##     x4*diff(f1(x1,x2,x3,x4),x3))/(x3^2-x4^2)]]
                        
                        rel := homalgSendBlocking( [ v, "sol[1]: ", v, "sol:=[]" ],
                                       stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                        
                    else
                        
                        ####
                        ## pdsolve( \
                        ## [[3*D[2,3](f1)(x,y,z)-D[3,3](f1)(x,y,z)+D[1](f1)(x,y,z)+3*D[2](f1)(x,y,z)-D[\
                        ##     3](f1)(x,y,z)+3*D[2,3](f2)(x,y,z)-D[3,3](f2)(x,y,z)], [D[1,3](f1)(x,y,z)\
                        ##     +D[3,3](f1)(x,y,z)+D[3](f1)(x,y,z)+D[1,3](f2)(x,y,z)+D[3,3](f2)(x,y,z)],\
                        ##      [D[1,2](f1)(x,y,z)], [D[3,3](f1)(x,y,z)-D[1](f1)(x,y,z)+D[3](f1)(x,y,z)\
                        ##     +3*D[1,2](f2)(x,y,z)+D[3,3](f2)(x,y,z)], [D[1,1](f1)(x,y,z)], [-D[3,3](f\
                        ##     1)(x,y,z)+D[1](f1)(x,y,z)-D[3](f1)(x,y,z)+3*D[1,1](f2)(x,y,z)-D[3,3](f2)\
                        ##     (x,y,z)], [D[3,3,3](f1)(x,y,z)-D[1,3](f1)(x,y,z)+D[3,3](f1)(x,y,z)+D[3,3\
                        ##     ,3](f2)(x,y,z)], [2*x*D[3,3](f1)(x,y,z)-2*x*D[1](f1)(x,y,z)+2*x*D[3](f1)\
                        ##     (x,y,z)+3*D[1](f1)(x,y,z)+3*D[3](f1)(x,y,z)+3*f1(x,y,z)+2*x*D[3,3](f2)(x\
                        ##     ,y,z)+3*D[1](f2)(x,y,z)+3*D[3](f2)(x,y,z)]]
                        ## ->
                        ## [{f1(x,y,z) = _F3(z)*x+_F2(y,z)}, [diff(f2(x,y,z),x) = -1/3*_F3(z)*x-2/3*dif\
                        ##     f(diff(_F3(z),z),z)*x^2-2/3*x*diff(diff(f2(x,y,z),z),z)-2/3*x*diff(diff(\
                        ##     _F2(y,z),z),z)-2/3*diff(_F3(z),z)*x^2-2/3*x*diff(_F2(y,z),z)-diff(_F3(z)\
                        ##     ,z)*x-diff(f2(x,y,z),z)-diff(_F2(y,z),z)-_F2(y,z)-_F3(z), diff(diff(f2(x\
                        ##     ,y,z),y),z) = -1/3*_F3(z)+1/3*diff(diff(_F3(z),z),z)*x-diff(diff(_F2(y,z\
                        ##     ),y),z)-diff(_F2(y,z),y)+1/3*diff(diff(f2(x,y,z),z),z)+1/3*diff(diff(_F2\
                        ##     (y,z),z),z)+1/3*diff(_F3(z),z)*x+1/3*diff(_F2(y,z),z), diff(diff(diff(f2\
                        ##     (x,y,z),z),z),z) = diff(_F3(z),z)-diff(diff(diff(_F3(z),z),z),z)*x-diff(\
                        ##     diff(diff(_F2(y,z),z),z),z)-diff(diff(_F3(z),z),z)*x-diff(diff(_F2(y,z),\
                        ##     z),z)]]
			
                        rel := homalgSendBlocking( [ v, "sol[2]: ", v, "sol:=", v, "sol[1]" ],
                                       stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                    fi;
                fi;
                
                r := NrRows( sys!.section );
                
                sol := homalgSendBlocking( [ "matrix(", r,",1,subs(", v, "sol,", u, "))" ],
                               stream, HOMALG_IO.Pictograms.SolutionOfSystem );
                
                sol!.solver := solver;
                
                if b then
                    sol!.Relations := rel;
                fi;
                
                return sol;
                
              end,
            
            NumeratorOfDifferentialAction :=
              function( monomial, numer, denom, arguments, R )
                local section, order;
                
                section := Concatenation( numer, "/", denom );
                
                order := Length( monomial );
                
                monomial := List( monomial, String );
                
                monomial := JoinStringsWithSeparator( monomial );
                
                monomial := Concatenation( "[", monomial, "]" );
                
                return homalgSendBlocking( [ "normal((", denom, ")^", order + 1, "*`jets/totalder`(", section, ",", monomial, ",", arguments, "))" ],
                                 R, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
              end,
            
            NumeratorOfDifferentialActionByOrder :=
              function( order, section, arguments, multiplier, R )
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
                
                return homalgSendBlocking( [ "op(map(convert,map(i->`jets/jcoeff`(", v, "res[1],i,", v, "lvar),", v, "lvar),symbol))" ],
                        "need_output", stream, HOMALG_IO.Pictograms.NumeratorOfDifferentialAction );
                
              end,
            
        )
 );

## enrich the global homalg table for MapleHomalg:
AppendToAhomalgTable( CommonHomalgTableForMapleHomalgTools, D_ModulesHomalgTableForMapleHomalgTools );
