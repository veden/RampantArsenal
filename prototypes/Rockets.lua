local rockets = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeTechnology = technologyUtils.makeTechnology
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local function rocketSheetMk1()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/rocket-mk1-sheet.png",
			priority = "high",
			width = 72,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.35, 0},
		    }
		}
	}
    
end

local function rocketSheetMk2()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/rocket-mk2-sheet.png",
			priority = "high",
			width = 88,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.1, -0.15},
		    }
		}
	}
    
end

function rockets.enable()

    local entity = {
	name = "rocket",
	icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
	miningTime = 1,
	health = 800,
	collisionBox = {{-0.35, -0.85}, {0.35, 0.85}},
	selectionBox = {{-0.5, -1}, {0.5, 1}},
	foldedAnimation = rocketSheetMk1(),
	foldingAnimation = rocketSheetMk1(),
	preparedAnimation = rocketSheetMk1(),
	preparingAnimation = rocketSheetMk1()
    }
    local rocketTurret, rocketTurretItem = makeAmmoTurret(entity,
							  {
							      type = "projectile",
							      ammo_category = "rocket",
							      cooldown = 150,
							      projectile_creation_distance = 1.39375,
							      projectile_center = {0, -0.0875},
							      range = 45,
							      sound = make_heavy_gunshot_sounds(),
    })

    local entity1 = {
	name = "rapid-rocket",
	icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
	miningTime = 1,
	health = 1800,
	foldedAnimation = rocketSheetMk2(),
	foldingAnimation = rocketSheetMk2(),
	preparedAnimation = rocketSheetMk2(),
	preparingAnimation = rocketSheetMk2()
    }
    local rapidRocketTurret, rapidRocketTurretItem = makeAmmoTurret(entity1, {
									type = "projectile",
									ammo_category = "rocket",
									cooldown = 50,
									projectile_creation_distance = 1.39375,
									projectile_center = {0, -0.0875},
									range = 35,
									sound = make_heavy_gunshot_sounds(),
    })

    local rocketTurretRecipe = makeRecipe({
	    name = "rocket-turret",
	    icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
	    enabled = false,
	    ingredients = {
		{"electronic-circuit", 20},
		{"steel-plate", 10},
		{"iron-gear-wheel", 15}
	    },
	    result = rocketTurretItem,
    })

    local rapidRocketRecipe = makeRecipe({
	    name = "rapid-rocket",
	    icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 30},
		{"advanced-circuit", 30},
		{"engine-unit", 10},
		{"copper-plate", 20}
	    },
	    result = rapidRocketTurretItem,
    })

    
    local rocketTurretTech = makeTechnology({
	    name = "rocket-turret",
	    prerequisites = {"turrets", "military-2", "rocketry"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = rocketTurretRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 200,
	    time = 30
    })

    makeTechnology({
	    name = "rapid-rocket-turret",
	    prerequisites = {"rocket-speed-1", "explosive-rocketry", "advanced-electronics-2", "military-3", rocketTurretTech, "engine"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = rapidRocketRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 300,
	    time = 30
    })
    
    local t1 = makeTechnology({
	    name = "rocket-turret-damage-1",
	    prerequisites = {rocketTurretTech},
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30,
	    order = "e-z-a"
    })

    local t2 = makeTechnology({
	    name = "rocket-turret-damage-2",
	    prerequisites = {t1},
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 150,
	    time = 45,
	    order = "e-z-b"
    })

    local t3 = makeTechnology({
	    name = "rocket-turret-damage-3",
	    prerequisites = {t2},
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.2
		},
		{
		    type = "turret-attack",
		    turret_id = rapidRocketTurret,
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local t4 = makeTechnology({
	    name = "rocket-turret-damage-4",
	    prerequisites = {t3},
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.3
		},
		{
		    type = "turret-attack",
		    turret_id = rapidRocketTurret,
		    modifier = 0.3
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local t5 = makeTechnology({
	    name = "rocket-turret-damage-5",
	    prerequisites = {t4},
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.3
		},
		{
		    type = "turret-attack",
		    turret_id = rapidRocketTurret,
		    modifier = 0.3
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local t6 = makeTechnology({
	    name = "rocket-turret-damage-6",
	    prerequisites = {t5},
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.4
		},		
		{
		    type = "turret-attack",
		    turret_id = rapidRocketTurret,
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
	    name = "rocket-turret-damage-7",
	    prerequisites = {t6},
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = rocketTurret,
		    modifier = 0.4
		},
		{
		    type = "turret-attack",
		    turret_id = rapidRocketTurret,
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
end

return rockets
