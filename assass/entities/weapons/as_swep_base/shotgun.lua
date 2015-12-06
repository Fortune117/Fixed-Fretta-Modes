SWEP.SingleReload				= false; -- shotgun style reload
SWEP.ReloadDelay				= 0.3;
SWEP.ReloadThenPump				= true;
SWEP.NeedsPumpAfterReload		= false; // needed for HL2 shotgun

function SWEP:NeedsPump()
	return self:GetNWBool( "NeedsPump", false );
end

function SWEP:Pump()
	self:SetNWBool( "NeedsPump", false );
	self:SendWeaponAnim( ACT_SHOTGUN_PUMP );
	
	if( self.Owner and self.Owner:GetViewModel() ) then
		self.NextIdleTime = CurTime() + self.Owner:GetViewModel():SequenceDuration();
		self:SetNextPrimaryFire( CurTime() + self.Owner:GetViewModel():SequenceDuration() );
	else
		self.NextIdleTime = CurTime() + 0.5	
	end
	
	if( self.PumpSound ) then
		self:EmitSound( self.PumpSound );
	end
end

function SWEP:ShotgunReloadStart()

	if( CurTime() < (self.NextPrimaryFire or 0) ) then return end
	
	if( self:GetNWBool( "reload", false ) == false and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 and self:Clip1() < self.Primary.ClipSize ) then
		self.BurstQueue = 0;
		self.BurstAmount = 0;
		
		self:SetIronsights( false );
		self:SetNWBool( "reload", true );
		
		if( self:Clip1() > 0 ) then
			self:SetNWFloat( "nextreload", CurTime() );
			self:SetNWBool( "chambered", true );
		else
			self:SetNWFloat( "nextreload", CurTime() + self.ReloadDelay );
			self:SetNWBool( "chambered", false );
		end
	end
end

function SWEP:ShotgunReloadThink( )

	// unironsight if sprinting
	if( self:GetNWBool( "Ironsights" ) == true and self.Owner:KeyDown( IN_SPEED ) ) then
		self:SetIronsights( false );
	end 

	// interrupt reload with primary fire
	if( self.Owner and self.Owner:IsPlayer() and self.Owner:KeyPressed( IN_ATTACK ) and self:Clip1() > 0 and self:GetNWBool( "reload", false ) == true ) then
		self:SetNWBool( "finishreload", true ); -- reload interrupt
		self:SetNextPrimaryFire( CurTime() + self.ReloadDelay );
		
	// end of reload sequence
	elseif( self:GetNWBool( "finishreload", false ) == true and CurTime() >= self:GetNWFloat( "nextreload", 0 ) ) then
		self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH );
		self:SetNWBool( "reload", false );
		self:SetNWBool( "finishreload", false );
		self:SetNextPrimaryFire( CurTime() + self.ReloadDelay );

		if( self.Owner and self.Owner:GetViewModel() ) then
			self.NextIdleTime = CurTime() + self.Owner:GetViewModel():SequenceDuration();
		else
			self.NextIdleTime = CurTime() + 0.5	
		end

		self:SetNWBool( "NeedsPump", self.NeedsPumpAfterReload );
		self.Owner:SetAnimation( PLAYER_RELOAD );
		
	// feed it a shell
	elseif( self:GetNWBool( "reload", false )  and CurTime() >= self:GetNWFloat( "nextreload", 0 ) ) then
		
		local chambered = self:GetNWBool( "chambered", false );
		local clipsize = self.Primary.ClipSize;
		
		if( self:Clip1() >= clipsize ) then
			self:SetNWBool( "reload", false );
			return;
		end
		
		self:SendWeaponAnim( ACT_VM_RELOAD );
		self.Owner:SetAnimation( PLAYER_RELOAD );
	
		if( self.ReloadSound ) then
			self:EmitSound( self.ReloadSound );
		end
		
		self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
		self:SetClip1( self:Clip1() + 1 )
		
		self:SetNWFloat( "nextreload", CurTime() + self.ReloadDelay );
		
		if( self:Clip1() >= clipsize ) then
			if( self.ReloadThenPump == true ) then
				self:SetNWBool( "finishreload", true );
				self:SetNextPrimaryFire( CurTime() + self.ReloadDelay );
			else
				self:SendWeaponAnim( ACT_SHOTGUN_RELOAD_FINISH );
				self.Owner:SetAnimation( PLAYER_RELOAD );
			end
		end
	end
	
end

function SWEP:ReloadThink()

	if( self:GetNWBool( "reload", false ) == true ) then
		if( CurTime() >= self:GetNWFloat( "reloadfinishtime" ) ) then
			self:FinishReload();
		end
	end
	
end

function SWEP:CustomReload( seq )

	if( CurTime() < (self.NextPrimaryFire or 0) ) then return end
	if( self:Clip1() >= self.Primary.ClipSize ) then return end
	
	local speed = self.Primary.ReloadSpeed or 1;
	
	if( self.Primary.ReloadSound ) then
		self:EmitSound( self.Primary.ReloadSound )
	end
	
	self:SetNWBool( "reload", true );
	self:SendWeaponAnim( seq );
	
	local vm = self.Owner:GetViewModel();
	local delay = CurTime() + ( 3 / speed );
	
	if( vm && speed != 1 ) then
		vm:SetPlaybackRate( speed );
	end
	
	if( vm and vm:IsValid() ) then
		delay = CurTime() + ( vm:SequenceDuration() / speed );
	end
	
	self.BurstQueue = 0;
	self.BurstAmount = 0;
		
	self:SetNWFloat( "reloadfinishtime", delay );
	self:SetNextPrimaryFire( delay );
	
	self.Owner:SetAnimation( PLAYER_RELOAD );
	self:SetIronsights( false );
end

function SWEP:DoAmmo()

	self:SetNWBool( "reload", false );
	
	if( self:Clip1() > 0 ) then
		self:SetClip1( self.Primary.ClipSize + 1 )
	else
		self:SetClip1( self.Primary.ClipSize )
	end
	
end

function SWEP:FinishReload()
	self:DoAmmo( );
end
