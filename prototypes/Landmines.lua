local landmines = {}

local itemUtils = require("utils/ItemUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeTechnology = technologyUtils.makeTechnology
local makeItem = itemUtils.makeItem


function landmines.enable()

    local r1 = makeTechnology({
	    name = "landmine-damage-1",
	    prerequisites = {"land-mine"},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 50,
	    time = 30,
	    order = "e-z-a"
    })

    local r2 = makeTechnology({
	    name = "landmine-damage-2",
	    prerequisites = {r1},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 45,
	    order = "e-z-b"
    })

    local r3 = makeTechnology({
	    name = "landmine-damage-3",
	    prerequisites = {r2},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local r4 = makeTechnology({
	    name = "landmine-damage-4",
	    prerequisites = {r3},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local r5 = makeTechnology({
	    name = "landmine-damage-5",
	    prerequisites = {r4},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local r6 = makeTechnology({
	    name = "landmine-damage-6",
	    prerequisites = {r5},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "landmine-damage-7",
	    prerequisites = {r6},
	    icon = "__RampantArsenal__/graphics/technology/landmine-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "landmine",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })

    -- local nuclearMine = makeItem({
	    
    -- })
    
end

return landmines
