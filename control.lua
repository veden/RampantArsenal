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

-- imported functions

local gaussianRandomRange = mathUtils.gaussianRandomRange

local strFind = string.find
local substr = string.sub
local mRandom = math.random

-- local references

local world

-- module code

local function onModSettingsChange(event)

    if event and (string.sub(event.setting, 1, 18) ~= "rampant-arsenal") then
	return false
    end

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
end

local function onTriggerEntityCreated(event)
    local entity = event.entity
    if entity and entity.valid then
        local tick = event.tick
        if (event.entity.name == "small-repair-cloud-rampant-arsenal") then
            if (mRandom() < 0.75) then
                entity.destroy()
            end
        elseif (event.entity.name == "rampant-clean-ghost-mine") then
            if (tick >= world.mineCheckNextTick) then
                world.mineCheckNextTick = tick + 60
                world.mineChecks = 0
            end

            if (world.mineChecks > 2) then
                entity.destroy()
                return
            else
                world.mineChecks = world.mineChecks + 1
            end

            local surface = entity.surface
            world.areaTop.x = entity.position.x - 5
            world.areaTop.y = entity.position.y - 5
            world.areaBottom.x = entity.position.x + 5
            world.areaBottom.y = entity.position.y + 5
            local entities = surface.find_entities_filtered({
                    ghost_type = "land-mine",
                    area = world.area
            })
            for i=1,#entities do
                if (entities[i].valid) then
                    entities[i].destroy()
                end
            end
            entity.destroy()
        end
    end
end

-- hooks

script.on_init(onInit)
script.on_load(onLoad)
script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChange)
script.on_configuration_changed(onConfigChanged)

script.on_event(defines.events.on_trigger_created_entity, onTriggerEntityCreated)
