
include('shared.lua')

ENT.Material = Material( "sprites/sent_ball" )
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Initialize()
	if self:GetOwner() and self:GetOwner():IsValid() then
		self.Color = team.GetColor(self:GetOwner():Team())
	end
end

function ENT:Draw()
	
	if not self.Color then
		if self:GetOwner() and self:GetOwner():IsValid() then
			self.Color = team.GetColor(self:GetOwner():Team())
		else
			self.Color = Color(200,200,200,255)
		end
	end
	
	local pos = self.Entity:GetPos()
	local vel = self.Entity:GetVelocity()
		
	render.SetMaterial( self.Material )
	
	local lcolor = render.GetLightColor( self:GetPos() ) * 2
	
	lcolor.x = self.Color.r * math.Clamp( lcolor.x, 0, 1 )
	lcolor.y = self.Color.g * math.Clamp( lcolor.y, 0, 1 )
	lcolor.z = self.Color.b * math.Clamp( lcolor.z, 0, 1 )
		
	if ( vel:Length() > 1 ) then
	
		for i = 1, 10 do
		
			local col = Color( lcolor.x, lcolor.y, lcolor.z, 200 / i )
			render.DrawSprite( pos + vel*(i*-0.005), 32, 32, col )
			
		end
	
	end
		
	render.DrawSprite( pos, 32, 32, Color( lcolor.x, lcolor.y, lcolor.z, 255 ) )
	
end