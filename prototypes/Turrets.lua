local turrets = {}

local capsules = require("Capsules")
local cannons = require("Cannons")
local rockets = require("Rockets")
local lasers = require("Lasers")

local enableRockets = rockets.enable
local enableLasers = lasers.enable
local enableCannons = cannons.enable
local enableCapsulesLauncher = capsules.enable

function turrets.addTurrets()
    enableCapsulesLauncher()
    enableRockets()
    enableLasers()
    enableCannons()
end


return turrets
