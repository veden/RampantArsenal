local lasers = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")

local makeTechnology = technologyUtils.makeTechnology
local makeRecipe = recipeUtils.makeRecipe
local makeElectricTurret = turretUtils.makeElectricTurret

local function advancedLaserSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/advanced-laser-sheet.png",
			priority = "high",
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.5, -1.6},
		    },
		    {
			filename = "__RampantArsenal__/graphics/entities/advanced-laser-sheet-mask.png",
			flags = { "mask" },
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			apply_runtime_tint = true,
			frame_count = 1,
			shift = {0.5, -1.6},
		    }
		}
	}    
end


local function lightningTowerSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/r1_sheet.png",
			priority = "high",
			width = 96,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.45, -0.25},
		    }
		}
	}
    
end


function lasers.enable()
    local entity = {
	name = "advanced-laser",
	icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
	miningTime = 1,
	health = 400,
	collisionBox = {{-1.75, -1.75 }, {1.75, 1.75}},
	selectionBox = {{-2, -2 }, {2, 2}},
	foldedAnimation = advancedLaserSheet(),
	foldingAnimation = advancedLaserSheet(),
	preparedAnimation = advancedLaserSheet(),
	preparingAnimation = advancedLaserSheet()
    }
    local _, advancedElectricTurretItem = makeElectricTurret(entity, nil)

    local entity1 = {
	name = "lightning-turret",
	icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
	miningTime = 1,
	health = 400,
	collisionBox = {{-0.35, -0.85}, {0.35, 0.85}},
	selectionBox = {{-0.5, -1}, {0.5, 1}},
	foldedAnimation = lightningTowerSheet(),
	foldingAnimation = lightningTowerSheet(),
	preparedAnimation = lightningTowerSheet(),
	preparingAnimation = lightningTowerSheet()
    }
    local _, lightningTowerTurretItem = makeElectricTurret(entity1, nil)

    local advanceLaserRecipe = makeRecipe({
		name = "advanced-laser",
		icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
		enabled = true,
		ingredients = {
		    {"steel-plate", 1}
		},
		result = advancedElectricTurretItem,
	})

    local lightningTurretRecipe = makeRecipe({
		name = "lightning-turret",
		icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
		enabled = true,
		ingredients = {
		    {"steel-plate", 1}
		},
		result = lightningTowerTurretItem,
	})

    local lightningTurretTech = makeTechnology({
	    name = "lightning-turret",
	    prerequisites = {"laser-turrets", "military-3"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = lightningTurretRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 200,
	    time = 30
    })
    
    makeTechnology({
	    name = "advanced-laser-turret",
	    prerequisites = {"laser-turret-damage-1", "advanced-electronics-2", "military-4", lightningTurretTech},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = advanceLaserRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 2000,
	    time = 30
    })

    
end

return lasers
