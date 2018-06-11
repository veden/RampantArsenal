local turrets = {}

local capsules = require("Capsules")
local cannons = require("Cannons")
local rockets = require("Rockets")
local lasers = require("Lasers")
local landmines = require("Landmines")
local guns = require("Guns")
local artillery = require("Artillery")
local grenades = require("Grenades")
local fire = require("Fire")
local stickers = require("Stickers")
local technologies = require("Technologies")
local clouds = require("Clouds")
local medic = require("Medic")
local wall = require("Walls")
local vehicle = require("Vehicles")
local power = require("Power")
local equipment = require("Equipment")

local enableEquipment = equipment.enable
local enablePower = power.enable
local enableVehicles = vehicle.enable
local enableWalls = wall.enable
local enableStickers = stickers.enable
local enableFire = fire.enable
local enableRockets = rockets.enable
local enableLasers = lasers.enable
local enableCannons = cannons.enable
local enableCapsulesLauncher = capsules.enable
local enableLandmines = landmines.enable
local enableGuns = guns.enable
local enableArtillery = artillery.enable
local enableGrenades = grenades.enable
local enableClouds = clouds.enable
local enableTechnologies = technologies.enable
local enableMedic = medic.enable

function turrets.addTurrets()

    data:extend({	    
	    {
		type = "equipment-category",
		name = "immobile"
	    },
	    {
		type = "equipment-category",
		name = "noInventory"
	    }
    })
    
    data:extend({
	    {
		type = "damage-type",
		name = "healing"
	    }
    })    

    data.raw["player"]["player"].damage_hit_tint = {r = 0, g = 0.2, b = 0, a = 0}
    
    enableTechnologies()
    enableStickers()
    enableFire()
    enableClouds()
    enableLasers()
    enableLandmines()
    enableGrenades()
    enableRockets()
    enableCannons()
    enableGuns()
    enableWalls()
    enableArtillery()
    enableMedic()
    enablePower()
    enableCapsulesLauncher()
    enableEquipment()
    enableVehicles()
end


return turrets
