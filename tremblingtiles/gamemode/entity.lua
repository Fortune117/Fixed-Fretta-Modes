function DoRandomTileFall()
	
	local tiles = ents.GetAllAliveTiles();
	
	if( #tiles > 0 ) then
		
		local ent = table.Random( tiles );

		if IsValid( ent ) then 
			
			if ent.ActivateSounds then 
				ent:EmitSound( table.Random( ent.ActivateSounds ), 66, math.random( 70, 130 ) );
			end 
			ent:SetColor( Color( 255, 0, 0, 255 ) );
			ent.Dropped = true;

		end 
		
		timer.Simple( 1, function()
			
			if IsValid( ent ) then 

				if ent.FallSounds then 
					ent:EmitSound( table.Random( ent.FallSounds ), 33, math.random( 70, 130 ) );
				end 
				ent:Drop();

			end 
			
		end );
		
	end
	
end

function ents.GetAllAliveTiles()
	
	local tab = { };
	
	for _, v in pairs( ents.FindByClass( "til_tile" ) ) do
		
		if( !v.Dropped ) then
			
			table.insert( tab, v );
			
		end
		
	end
	
	return tab;
	
end
