-- imports

local constants = require("libs/Constants")
local mathUtils = require("libs/MathUtils")

-- constants

local MENDING_WALL_COOLDOWN = constants.MENDING_WALL_COOLDOWN

-- imported functions

local gaussianRandomRange = mathUtils.gaussianRandomRange

local strFind = string.find
local substr = string.sub
local mRandom = math.random
local mFloor = math.floor

-- local references

local world

-- module code

local function onModSettingsChange(event)

    if (remote.interfaces["flammable_oils"]) then
        remote.call("flammable_oils", "add_flammable_type", "napalm-fluid-rampant-arsenal")
    end
    
    if event and (string.sub(event.setting, 1, 18) ~= "rampant-arsenal") then
        return false
    end
    
    return true
end


local function onConfigChanged()
    onModSettingsChange()
    if not world.version then

        world.version = 1
    end
    if (world.version < 11) then

        game.forces.player.reset_technology_effects()

        world.version = 11
    end
    if (world.version < 16) then

        world.createSmallMendingCloudQuery = nil

        world.mendingWalls = {}

        for i,p in ipairs(game.connected_players) do
            p.print("Rampant Arsenal - Version 1.0.1")
        end
        world.version = 16
    end
end

local function onInit()
    global.world = {}

    world = global.world

    onConfigChanged()
end

local function onLoad()
    world = global.world
end

local function onTriggerEntityCreated(event)
    local entity = event.entity
    if entity and entity.valid and (entity.name == "small-repair-cloud-rampant-arsenal") then
        local entityId = event.source.unit_number
        local tick = event.tick
        local cooldownTick = world.mendingWalls[entityId]
        if not cooldownTick or (cooldownTick and cooldownTick < tick) then
            world.mendingWalls[entityId] = tick + MENDING_WALL_COOLDOWN
        else
            entity.destroy()
        end
    end
end

local function onMendingWallsTick(event)
    local counter = 0
    for k,v in pairs(world.mendingWalls) do
        if (v < event.tick) then
            world.mendingWalls[k] = nil
        end
        if (counter > 5) then
            return
        else
            counter = counter + 1
        end
    end
end

-- hooks

script.on_init(onInit)
script.on_load(onLoad)
script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChange)

script.on_configuration_changed(onConfigChanged)
script.on_nth_tick(72, onMendingWallsTick)

script.on_event(defines.events.on_trigger_created_entity, onTriggerEntityCreated)
