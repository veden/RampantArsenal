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
local equipment = require("Equipment")

local enableEquipment = equipment.enable
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
            },
            {
                type = "equipment-category",
                name = "movement"
            },
            {
                type = "equipment-category",
                name = "adv-generator"
            }
    })

    data:extend({
            {
                type = "damage-type",
                name = "healing"
            }
    })

    data.raw["character"]["character"].damage_hit_tint = {r = 0, g = 0.2, b = 0, a = 0}

    enableTechnologies()
    enableStickers()
    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        enableFire()
    end
    enableClouds()
    enableLasers()
    enableLandmines()
    enableGrenades()
    enableRockets()
    enableCannons()
    enableGuns()
    enableWalls()
    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        enableArtillery()
    end
    enableMedic()
    enableCapsulesLauncher()
    if settings.startup["rampant-arsenal-enableEquipment"].value then
        enableEquipment()
    end
    if settings.startup["rampant-arsenal-enableVehicle"].value then
        enableVehicles()
    end
end


return turrets
