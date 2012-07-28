LoadPackage( "GradedRingForHomalg" );

Qs := HomalgFieldOfRationalsInDefaultCAS( ) * "s";
Qsxyz := Qs * "x,y,z";

rp := homalgSendBlocking( "0,(s,x,y,z,Dx,Dy,Dz),(dp(1),dp)", [ "ring" ], Qs, HOMALG_IO.Pictograms.initialize );

homalgSendBlocking( "option(redSB)", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "option(redTail)", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "matrix @M[7][7]", "need_command", rp, HOMALG_IO.Pictograms.initialize );
homalgSendBlocking( "@M[2,5] = 1; @M[3,6] = 1; @M[4,7] = 1", "need_command", rp, HOMALG_IO.Pictograms.initialize );
ext_obj := homalgSendBlocking( "nc_algebra(1,@M)", [ "def" ], TheTypeHomalgExternalRingObjectInSingular, rp, HOMALG_IO.Pictograms.CreateHomalgRing );
Ds := CreateHomalgExternalRing( ext_obj, TheTypeHomalgExternalRingInSingular );
_Singular_SetRing( Ds );

RP := homalgTable( Ds );

homalgSendBlocking( "proc BasisOfRowModule (matrix M) { return(std(M));}", "need_command", Ds, HOMALG_IO.Pictograms.initialize );

RP!.SetInvolution :=
  function( R )
    homalgSendBlocking( Concatenation(
            [ "\nproc Involution (matrix M)\n{\n" ],
            [ "  map F = ", R, ", s, x, y, z, -Dx, -Dy, -Dz" ],
            [ ";\n  return( transpose( involution( M, F ) ) );\n}\n\n" ]
            ), "need_command", HOMALG_IO.Pictograms.define );
end;

## reseting the "Involution" must be after "imapall":
RP!.SetInvolution( Ds );

RP!.Compose :=
  function( A, B )
    
    return homalgSendBlocking( [ "transpose( transpose(", A, ") * transpose(", B, ") )" ], [ "matrix" ], HOMALG_IO.Pictograms.Compose ); # FIXME : this has to be extensively documented to be understandable!
    
end;

SetName( Ds, "Q[s][x,y,z]<Dx,Dy,Dz>" );

x := "x" / Ds;
y := "y" / Ds;
z := "z" / Ds;

Dx := "Dx" / Ds;
Dy := "Dy" / Ds;
Dz := "Dz" / Ds;

SetIsWeylRing( Ds, true );
SetCenter( Ds, Qs );
SetBaseRing( Ds, Qsxyz );
SetCoefficientsRing( Ds, Qs );

SetRelativeIndeterminateCoordinatesOfRingOfDerivations( Ds, [ x, y, z ] );
ResetFilterObj( Ds, IndeterminateDerivationsOfRingOfDerivations );
SetIndeterminateDerivationsOfRingOfDerivations( Ds, [ Dx, Dy, Dz ] );

f := x^2*y*z + x^2*z^2 - y^3*z - y^3;

f := f / Ds;

g := Concatenation( "(", String( f ), ")^s" );

LoadPackage( "D-Modules" );

F := InjectiveLeftModule( Ds );

A := HomalgRing( MatrixOfGenerators( F ) );

sec := Concatenation( "[", g, "]" );

sec := HomalgMatrix( sec, 1, 1, A );

Ann := Annihilator( g, 1, Ds );

Dsf := LeftSubmodule( [ f ] );

Annf := Ann + Dsf;

s := Indeterminate( Rationals, "s" );

#Read( ".Geisha_rest.g" );
