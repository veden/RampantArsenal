-- imports

local constants = require("libs/Constants")
local mathUtils = require("libs/MathUtils")

-- constants

local DEFAULT_SPOUT_SIZE = constants.DEFAULT_SPOUT_SIZE

local RAW_GOO_TYPES = constants.RAW_GOO_TYPES
local RAMPANT_PREFIX_TABLE = constants.RAMPANT_PREFIX_TABLE
local DEFAULT_GOO_TYPE = constants.DEFAULT_GOO_TYPE

local ENABLE_NORMAL_GOO = constants.ENABLE_NORMAL_GOO
local ENABLE_ALL_GOO = constants.ENABLE_ALL_GOO
local MENDING_WALL_COOLDOWN = constants.MENDING_WALL_COOLDOWN

local CHUNK_SIZE = constants.CHUNK_SIZE
local CHUNK_SIZE_DIVIDER = constants.CHUNK_SIZE_DIVIDER

-- imported functions

local gaussianRandomRange = mathUtils.gaussianRandomRange

local strFind = string.find
local substr = string.sub
local mRandom = math.random
local mFloor = math.floor
local mCeil = math.ceil

-- local references

local world

-- module code

local function onModSettingsChange(event)

    if event and (string.sub(event.setting, 1, 18) ~= "rampant-arsenal") then
        return false
    end

    world.airFilterCooldown = settings.global["rampant-arsenal-airFilterCooldown"].value

    -- world.spoutThreshold = settings.global["rampant-arsenal-spoutThreshold"].value
    -- world.spoutScaler = settings.global["rampant-arsenal-spoutScaler"].value
    -- world.spoutDefaultValue = world.spoutScaler * DEFAULT_SPOUT_SIZE

    -- world.bobsEnabled = (mods and mods["bobenemies"] ~= nil) or game.active_mods["bobenemies"]
    -- world.bobsEnabled = (mods and mods["bobenemies"] ~= nil) or game.active_mods["bobenemies"]

    return true
end


local function onConfigChanged()
    onModSettingsChange()
    if not world.version then

        world.version = 1
    end
    -- if (world.version < 5) then

    --     world.version = 5
    -- end
    if (world.version < 6) then

        world.areaTop = {}
        world.areaBottom = {}
        world.area = {
            world.areaTop,
            world.areaBottom
        }

        world.mineChecks = 0
        world.mineCheckNextTick = 0

        world.version = 6
    end
    if (world.version < 7) then

        world.nextTick = nil
        world.count = nil

        world.version = 7
    end
    if (world.version < 11) then

        game.forces.player.reset_technology_effects()

        world.version = 11
    end
    if (world.version < 14) then

        world.createSmallMendingCloudQuery = {
            name = "small-repair-cloud-rampant-arsenal",
            position = 0,
            force = 0
        }

        world.mendingWalls = {}
        world.airFilterTick = {}
        world.position = {x=0,y=0}
        world.airFilterCount = 0
        world.playerSelection = {}

        for _,surface in pairs(game.surfaces) do
            local entities = surface.count_entities_filtered({
                    name = "air-filter-rampant-arsenal"
            })
            entities = entities + surface.count_entities_filtered({
                    name = "air-filter-2-rampant-arsenal"
                                                                 })
            -- world.airFilterTick
            world.airFilterCount = world.airFilterCount + entities
        end
        world.airFilterPerTick = (world.airFilterCount / world.airFilterCooldown)

        -- for _, surface in pairs(game.surfaces) do
        --     world.airFilterTick =
        -- end

        world.insertFluidQuery = {
            name="pollution-fluid-rampant-arsenal",
            amount=10
        }

        for i,p in ipairs(game.connected_players) do
            p.print("Rampant Arsenal - Version 0.18.7")
        end
        world.version = 14
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

local function onDeath(event)
    local entity = event.entity
    if (event.cause and event.cause.force.name == "player") and (entity.force.name == "enemy") then
        if (mRandom() < world.spoutThreshold) then
            if (entity.type == "unit-spawner") then
                local name = entity.name
                local gooType
                if ENABLE_ALL_GOO then
                    if (substr(name, -7) == "rampant") then
                        local prefix = (strFind(name,"-")) - 1
                        gooType = RAMPANT_PREFIX_TABLE[(substr(name,1,prefix))]
                    else
                        gooType = RAW_GOO_TYPES[mRandom(#RAW_GOO_TYPES)]
                    end
                elseif ENABLE_NORMAL_GOO then
                    gooType = DEFAULT_GOO_TYPE
                end
                local position = entity.position
                local x = position.x
                local y = position.y
                local potentialYield = (((x * x) + (y * y)) ^ 0.5) * world.spoutDefaultValue

                local yield = gaussianRandomRange(potentialYield, 0.15, potentialYield * 0.7, potentialYield * 1.3)
                entity.surface.create_entity({name=gooType, amount=yield, position=entity.position})
            end
        end
    end
    if (entity.name == "air-filter-rampant-arsenal") or (entity.name == "air-filter-2-rampant-arsenal") then
        world.airFilterCount = world.airFilterCount - 1
    end
end

local function onTriggerEntityCreated(event)
    local entity = event.entity
    if entity and entity.valid then
        if (event.entity.name == "dummy-small-repair-cloud-rampant-arsenal") then
            local sourceEntity = event.source
            entity.destroy()
            local entityId = sourceEntity.unit_number
            local cooldownTick = world.mendingWalls[entityId]
            if (not cooldownTick) or (cooldownTick < event.tick) then
                world.mendingWalls[entityId] = event.tick + MENDING_WALL_COOLDOWN
                world.createSmallMendingCloudQuery.position = sourceEntity.position
                world.createSmallMendingCloudQuery.force = sourceEntity.force.name
                sourceEntity.surface.create_entity(world.createSmallMendingCloudQuery)
            end
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

local function onBuilding(event)
    local entity = event.created_entity or event.entity
    if (entity.name == "air-filter-rampant-arsenal") or (entity.name == "air-filter-2-rampant-arsenal") then
        local nextTick = event.tick + world.airFilterCooldown

        world.airFilterCount = world.airFilterCount + 1
        world.airFilterPerTick = (world.airFilterCount / world.airFilterCooldown)

        local tickSlot = world.airFilterTick[nextTick]
        if not tickSlot then
            tickSlot = {}
            world.airFilterTick[nextTick] = tickSlot
        end
        tickSlot[#tickSlot+1] = entity

    end
end

local function onRemoval(event)
    local entity = event.created_entity or event.entity
    if (entity.name == "air-filter-rampant-arsenal") or (entity.name == "air-filter-2-rampant-arsenal") then
        world.airFilterCount = world.airFilterCount - 1
        world.airFilterPerTick = (world.airFilterCount / world.airFilterCooldown)
    end
end

local function calculatePollution(surface, position)
    local chunkX = position.x
    local chunkY = position.y

    local position = world.position
    local totalPollution = 0

    position.x = chunkX
    position.y = chunkY
    totalPollution = totalPollution + surface.get_pollution(position)

    position.x = chunkX + CHUNK_SIZE
    position.y = chunkY
    totalPollution = totalPollution + surface.get_pollution(position)

    position.x = chunkX - CHUNK_SIZE
    position.y = chunkY
    totalPollution = totalPollution + surface.get_pollution(position)

    position.x = chunkX
    position.y = chunkY + CHUNK_SIZE
    totalPollution = totalPollution + surface.get_pollution(position)

    position.x = chunkX
    position.y = chunkY - CHUNK_SIZE
    totalPollution = totalPollution + surface.get_pollution(position)

    return mCeil(totalPollution)
end

local function onAirFiltering(event)
    local entities = world.airFilterTick[event.tick]
    if entities then
        local nextTick = event.tick + world.airFilterCooldown
        local tickSlot = world.airFilterTick[nextTick]
        local airFilterPerTick = world.airFilterPerTick
        for i=1,#entities do
            local entity = entities[i]
            if (entity.valid) then
                if entity.is_connected_to_electric_network() and
                ((entity.energy / entity.prototype.max_energy_usage) > 0.65) then
                    local amount = calculatePollution(entity.surface, entity.position)
                    if (amount > 0) then
                        world.insertFluidQuery.amount = amount
                        entity.insert_fluid(world.insertFluidQuery)
                    end
                end

                if not tickSlot then
                    tickSlot = {}
                    world.airFilterTick[nextTick] = tickSlot
                    tickSlot[#tickSlot+1] = entity
                else
                    if (#tickSlot > airFilterPerTick) then
                        while (#tickSlot > airFilterPerTick) do
                            nextTick = nextTick + 1
                            tickSlot = world.airFilterTick[nextTick]
                            if not tickSlot then
                                tickSlot = {}
                                world.airFilterTick[nextTick] = tickSlot
                                tickSlot[#tickSlot+1] = entity
                            elseif (#tickSlot < airFilterPerTick) then
                                tickSlot[#tickSlot+1] = entity
                            end
                        end
                    else
                        tickSlot[#tickSlot+1] = entity
                    end
                end
            end
        end
        world.airFilterTick[event.tick] = nil
    end
end

local function onSelectionChanged(event)
    local player = game.players[event.player_index]
    local selection = game.players[event.player_index].selected
    if selection then
        local previousSelection = world.playerSelection[event.player_index]

        if previousSelection then
            if (selection ~= previousSelection[1]) then
                for i=2,#previousSelection do
                    rendering.destroy(previousSelection[i])
                end
            end
        end

        if (selection.name == "air-filter-rampant-arsenal") then
            local chunkX = mFloor(selection.position.x / 32) * 32
            local chunkY = mFloor(selection.position.y / 32) * 32

            local graphicId = rendering.draw_rectangle({
                    color = {0.1, 0.3, 0.1, 0.6},
                    width = 32 * 32,
                    filled = true,
                    left_top = {chunkX, chunkY},
                    right_bottom = {chunkX+32, chunkY+32},
                    surface = selection.surface,
                    draw_on_ground = true,
                    visible = true
            })
            world.playerSelection[event.player_index] = {selection.unit_number, graphicId}
        elseif (selection.name == "air-filter-2-rampant-arsenal") then
            local chunkX = mFloor(selection.position.x / 32) * 32
            local chunkY = mFloor(selection.position.y / 32) * 32

            local graphicId = rendering.draw_rectangle({
                    color = {0.1, 0.3, 0.1, 0.6},
                    width = 32 * 32,
                    filled = true,
                    left_top = {chunkX, chunkY-32},
                    right_bottom = {chunkX+32, chunkY+64},
                    surface = selection.surface,
                    draw_on_ground = true,
                    visible = true
            })
            local graphicId2 = rendering.draw_rectangle({
                    color = {0.1, 0.3, 0.1, 0.6},
                    width = 32 * 32,
                    filled = true,
                    left_top = {chunkX-32, chunkY},
                    right_bottom = {chunkX+64, chunkY+32},
                    surface = selection.surface,
                    draw_on_ground = true,
                    visible = true
            })
            world.playerSelection[event.player_index] = {selection.unit_number, graphicId, graphicId2}
        end
    end
end

local function removePlayerSelection(event)
    for player,pair in pairs(world.playerSelection) do
        local selection = game.players[player].selected
        local previousSelection = world.playerSelection[player]

        if previousSelection then
            if not selection or (previousSelection[1] ~= selection.unit_number) then
                for i=2,#previousSelection do
                    rendering.destroy(previousSelection[i])
                end
                world.playerSelection[player] = nil
            end
        end
    end
end

-- hooks

script.on_init(onInit)
script.on_load(onLoad)
script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChange)
script.on_configuration_changed(onConfigChanged)
script.on_nth_tick(360, onMendingWallsTick)

script.on_nth_tick(15, removePlayerSelection)
script.on_event(defines.events.on_tick, onAirFiltering)

script.on_event(defines.events.on_selected_entity_changed, onSelectionChanged)

script.on_event(defines.events.on_entity_died, onRemoval, {
                    {
                        name = "air-filter-rampant-arsenal",
                        filter = "name"
                    },
                    {
                        name = "air-filter-2-rampant-arsenal",
                        filter = "name"
                    }
})

script.on_event(defines.events.on_robot_mined_entity, onRemoval, {
                    {
                        name = "air-filter-rampant-arsenal",
                        filter = "name"
                    },
                    {
                        name = "air-filter-2-rampant-arsenal",
                        filter = "name"
                    }
})

script.on_event(defines.events.on_player_mined_entity, onRemoval, {
                    {
                        name = "air-filter-rampant-arsenal",
                        filter = "name"
                    },
                    {
                        name = "air-filter-2-rampant-arsenal",
                        filter = "name"
                    }
})

script.on_event(defines.events.on_built_entity, onBuilding, {
                    {
                        name = "air-filter-rampant-arsenal",
                        filter = "name"
                    },
                    {
                        name = "air-filter-2-rampant-arsenal",
                        filter = "name"
                    }
})

script.on_event(defines.events.on_robot_built_entity, onBuilding, {
                    {
                        name = "air-filter-rampant-arsenal",
                        filter = "name"
                    },
                    {
                        name = "air-filter-2-rampant-arsenal",
                        filter = "name"
                    }
})

script.on_event({defines.events.script_raised_destroy}, onRemoval)

script.on_event({ defines.events.script_raised_built,
                  defines.events.script_raised_revive }, onBuilding)


script.on_event(defines.events.on_trigger_created_entity, onTriggerEntityCreated)
