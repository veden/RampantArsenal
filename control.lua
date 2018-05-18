-- imports

local worldProcessor = require("libs/WorldProcessor")
local constants = require("libs/Constants")

-- constants

local INTERVAL_LOGIC = constants.INTERVAL_LOGIC

-- imported functions

local processWorld = worldProcessor.processWorld

-- local references

local world

-- module code

-- local function onModSettingsChange(event)

--     return true
-- 


local function onModSettingsChange(event)
    
    if event and (string.sub(event.setting, 1, 18) ~= "rampant-industries") then
	return false
    end

    
    
    return true
end


local function onConfigChanged()
    if not world.version then
	
	world.version = 1
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
	if (entity.type == "unit-spawner") then
	    entity.surface.create_entity({name="alien-goo-resource-alien-resource", amount=100, position=entity.position})
	elseif (entity.type == "turret") then
	    
	end	
    end
end


-- hooks

script.on_nth_tick(INTERVAL_LOGIC,
		   function (event)
--		       processWorld(world)
end)

script.on_init(onInit)
script.on_load(onLoad)
script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChange)
script.on_configuration_changed(onConfigChanged)

script.on_event(defines.events.on_entity_died, onDeath)
-- script.on_event(defines.events.on_chunk_generated, onChunkGenerated)
