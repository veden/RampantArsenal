-- Copyright (C) 2022  veden

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


-- imports

local constants = require("libs/Constants")

-- constants

local MENDING_WALL_COOLDOWN = constants.MENDING_WALL_COOLDOWN

-- imported functions

-- local references

local world

-- module code

local function onModSettingsChange(event)

    if (remote.interfaces["flammable_oils"]) then
        remote.call("flammable_oils", "add_flammable_type", "napalm-fluid-rampant-arsenal")
    end

    if event and (string.sub(event.setting, 1, #"rampant-arsenal") ~= "rampant-arsenal") then
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

        for _,p in ipairs(game.connected_players) do
            p.print("Rampant Arsenal - Version 1.1.3")
        end
        world.version = 16
    end
end

local function onInit()
    storage.world = {}

    world = storage.world

    onConfigChanged()
end

local function onLoad()
    world = storage.world
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
    local tick = event.tick
    for k,v in pairs(world.mendingWalls) do
        if (v < tick) then
            world.mendingWalls[k] = nil
        end
        if (counter > 5) then
            return
        else
            counter = counter + 1
        end
    end
end

local function onDamaged(event)

end

-- hooks

script.on_init(onInit)
script.on_load(onLoad)
script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChange)
-- script.on_event(defines.events.on_entity_damaged, onDamaged)

script.on_configuration_changed(onConfigChanged)
script.on_nth_tick(5, onMendingWallsTick)

script.on_event(defines.events.on_trigger_created_entity, onTriggerEntityCreated)
