local turrets = {}

local capsules = require("buildings/Capsules")
local cannons = require("buildings/Cannons")
local rockets = require("buildings/Rockets")
local lasers = require("buildings/Lasers")

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
