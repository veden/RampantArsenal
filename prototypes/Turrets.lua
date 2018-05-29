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

function turrets.addTurrets()

    data:extend({
	    {
		type = "damage-type",
		name = "healing"
	    }
    })    

    enableTechnologies()
    enableStickers()
    enableClouds()
    enableLandmines()
    enableGrenades()
    enableRockets()
    enableLasers()
    enableCannons()
    enableGuns()    
    enableArtillery()
    enableFire()
    enableCapsulesLauncher()
end


return turrets
