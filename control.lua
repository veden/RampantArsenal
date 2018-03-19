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
    if (entity.type == "unit-spawner") and (entity.force.name == "enemy") and (entity.surface.index == 1) and (event.cause and event.cause.force.name == "player") then
	entity.surface.create_entity({name="alien-goo-resource-alien-resource", amount=100, position=entity.position})
    end
end

script.on_nth_tick(INTERVAL_LOGIC,
		   function (event)
--		       processWorld(world)
end)

-- hooks

script.on_init(onInit)
script.on_load(onLoad)
script.on_configuration_changed(onConfigChanged)

script.on_event(defines.events.on_entity_died, onDeath)
