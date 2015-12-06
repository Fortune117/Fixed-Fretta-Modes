include( "shared.lua" );
include( "cl_hud.lua" );
include( "cl_umsg.lua" );

language.Add( "til_tile", "An errant tile" );

surface.CreateFont( "PowerupText", {
	font =  "Tahoma", 
	size = 160,
	weight = 1000,
	antialias = true,
	shadow = false
 }); 