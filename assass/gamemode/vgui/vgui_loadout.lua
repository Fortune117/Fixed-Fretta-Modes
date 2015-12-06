local menu = {}

function menu:Init()	

	self.Guns = GAMEMODE.PrimaryWeapons;

	local w,h = 450, 350
	for k, v in pairs( self.Guns ) do
		local btn = vgui.Create( "DButton" );
		btn:SetParent( self );
		
		btn:Dock( TOP )
		btn:SetText( v.class );
		btn:SetTall( h/(table.Count( self.Guns)+1) )
		function btn:DoClick()
			GAMEMODE:PrintCenter( "Primary Set!" )
			RunConsoleCommand( "as_cl_primaryweapon", string.sub( k, 11 ) )
		end 
		
	end
	
	self:SetSize( w, h );

end

vgui.Register("DHudLoadout", menu, "DFrame" )

local lpanel;
function OpenLoadout( )

	if( !lpanel || !lpanel:IsValid() ) then
		lpanel = vgui.Create( "DHudLoadout" );
	end
	
	lpanel:SetVisible( true );
	lpanel:SetMouseInputEnabled( true );
	lpanel:MakePopup();
	lpanel:Center();
	
end
concommand.Add( "open_loadout_menu", OpenLoadout );
