if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
	
	SWEP.HoldType				= "pistol";
end

if( CLIENT ) then
	SWEP.PrintName				= "Five Seven";
	
	SWEP.Slot					= 1;
	SWEP.SlotPos				= 0;
end

SWEP.Base						= "as_swep_base";

SWEP.Contact					= "" 
SWEP.Purpose					= "" 
SWEP.Instructions				= "" 
 
SWEP.ViewModel  = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"

SWEP.Primary.Sound 				= Sound( "Weapon_FiveSeven.Single" )
SWEP.Primary.ReloadSound		= Sound( "Weapon_FiveSeven.Reload" );
SWEP.Primary.Recoil				= 0.95;
SWEP.Primary.Damage				= 32;
SWEP.Primary.Cone				= 0.015;
SWEP.Primary.Automatic			= false;
SWEP.Primary.ClipSize			= 15;
SWEP.Primary.Delay				= 0.1;
SWEP.Primary.Ammo				= "357"; 
SWEP.Primary.DefaultClip		= 500;

SWEP.Secondary.ClipSize			= -1;
SWEP.Secondary.DefaultClip		= -1;
SWEP.Secondary.Automatic		= false; 
SWEP.Secondary.Ammo				= "none"; 

SWEP.SprayAccuracy				= 0.55;
SWEP.SprayTime					= 0.15;
SWEP.CanRunAndShoot				= false;

SWEP.RunArmOffset				= Vector (2.4702, -2.8634, 1.2694)
SWEP.RunArmAngle				= Vector (-20.2139, 25.6592, -18.5775)


SWEP.IronSightsTime				= 0.25;

SWEP.HasIronsights 				= true;


SWEP.IronSightsPos = Vector (-3.6938, -7.2348, 2.2581)
SWEP.IronSightsAng = Vector (0.1877, 0.1851, 0.0024)


SWEP.IronsightsFOV				= 0;
SWEP.IronsightAccuracy			= 2.5;

