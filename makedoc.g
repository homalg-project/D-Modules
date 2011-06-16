##  this creates the documentation, needs: GAPDoc package, latex, pdflatex,
##  mkindex, dvips
##  
##  Call this with GAP.
##

LoadPackage( "GAPDoc" );

SetGapDocLaTeXOptions( "utf8" );

bib := ParseBibFiles( "doc/D-Modules.bib" );
WriteBibXMLextFile( "doc/D-ModulesBib.xml", bib );

Read( "ListOfDocFiles.g" );

PrintTo( "VERSION", PackageInfo( "D-Modules" )[1].Version );

MakeGAPDocDoc( "doc", "D-ModulesForHomalg", list, "D-ModulesForHomalg" );

GAPDocManualLab("D-Modules");

quit;

