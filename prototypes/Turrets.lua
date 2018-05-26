local turrets = {}

local capsules = require("Capsules")
local cannons = require("Cannons")
local rockets = require("Rockets")
local lasers = require("Lasers")
local landmines = require("Landmines")
local guns = require("Guns")

local enableRockets = rockets.enable
local enableLasers = lasers.enable
local enableCannons = cannons.enable
local enableCapsulesLauncher = capsules.enable
local enableLandmines = landmines.enable
local enableGuns = guns.enable

function turrets.addTurrets()
    enableLandmines()
    enableCapsulesLauncher()
    enableRockets()
    enableLasers()
    enableCannons()
    enableGuns()
end


return turrets
