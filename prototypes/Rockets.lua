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
	health = 400,
	collisionBox = {{-0.35, -0.85}, {0.35, 0.85}},
	selectionBox = {{-0.5, -1}, {0.5, 1}},
	foldedAnimation = rocketSheetMk1(),
	foldingAnimation = rocketSheetMk1(),
	preparedAnimation = rocketSheetMk1(),
	preparingAnimation = rocketSheetMk1()
    }
    local _, rocketTurretItem = makeAmmoTurret(entity,
					       {
						   type = "projectile",
						   ammo_category = "rocket",
						   cooldown = 150,
						   projectile_creation_distance = 1.39375,
						   projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
						   -- shell_particle =
						   --     {
						   -- 	   name = "shell-particle",
						   -- 	   direction_deviation = 0.1,
						   -- 	   speed = 0.1,
						   -- 	   speed_deviation = 0.03,
						   -- 	   center = {-0.0625, 0},
						   -- 	   creation_distance = -1.925,
						   -- 	   starting_frame_speed = 0.2,
						   -- 	   starting_frame_speed_deviation = 0.1
						   --     },
						   range = 45,
						   sound = make_heavy_gunshot_sounds(),
    })

    local entity1 = {
	name = "rapid-rocket",
	icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
	miningTime = 1,
	health = 400,
	foldedAnimation = rocketSheetMk2(),
	foldingAnimation = rocketSheetMk2(),
	preparedAnimation = rocketSheetMk2(),
	preparingAnimation = rocketSheetMk2()
    }
    local _, rapidRocketTurretItem = makeAmmoTurret(entity1, {
							type = "projectile",
							ammo_category = "rocket",
							cooldown = 50,
							projectile_creation_distance = 1.39375,
							projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
							-- shell_particle =
							--     {
							-- 	   name = "shell-particle",
							-- 	   direction_deviation = 0.1,
							-- 	   speed = 0.1,
							-- 	   speed_deviation = 0.03,
							-- 	   center = {-0.0625, 0},
							-- 	   creation_distance = -1.925,
							-- 	   starting_frame_speed = 0.2,
							-- 	   starting_frame_speed_deviation = 0.1
							--     },
							range = 35,
							sound = make_heavy_gunshot_sounds(),
    })

    local rocketTurretRecipe = makeRecipe({
	    name = "rocket-turret",
	    icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
	    enabled = true,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = rocketTurretItem,
    })

    local rapidRocketRecipe = makeRecipe({
	    name = "rapid-rocket",
	    icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
	    enabled = true,
	    ingredients = {
		{"steel-plate", 1}
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
	    prerequisites = {"rocket-speed-1", "explosive-rocketry", "advanced-electronics-2", "military-3", rocketTurretTech},
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
end

return rockets
