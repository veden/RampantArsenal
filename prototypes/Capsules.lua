local capsules = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeTechnology = technologyUtils.makeTechnology
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local function CapsuleLauncherSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/arty2x2-sheet.png",
			priority = "high",
			width = 168,
			height = 168,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0, -1.4},
		    }
		}
	}    
end

function capsules.enable()
    local entity = {
	name = "capsule",
	icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	miningTime = 1,
	health = 400,
	foldedAnimation = CapsuleLauncherSheet(),
	foldingAnimation = CapsuleLauncherSheet(),
	preparedAnimation = CapsuleLauncherSheet(),
	preparingAnimation = CapsuleLauncherSheet()
    }
    local _, capsuleTurretItem = makeAmmoTurret(entity, {
						   type = "projectile",
						   ammo_category = "capsule",
						   cooldown = 45,
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
						   range = 18,
						   sound = make_heavy_gunshot_sounds(),
    })

    local capsuleTurretRecipe = makeRecipe({
	    name = "capsule-turret",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = true,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = capsuleTurretItem,
    })
    
    makeTechnology({
	    name = "capsule-turret",
	    prerequisites = {"turrets", "military-3", "explosives"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = capsuleTurretRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 100,
	    time = 30
    })

    
end

return capsules
