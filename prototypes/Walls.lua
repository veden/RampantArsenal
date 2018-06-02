local walls = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local wallUtils = require("utils/WallUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeBombWave = projectileUtils.makeBombWave
local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeWall = wallUtils.makeWall
local makeGate = wallUtils.makeGate

function walls.enable()

    local mendingWall,mendingWallItem = makeWall(
	{
	    name = "mending",
	    icon = "__RampantArsenal__/graphics/icons/mending-wall.png",
	    health = 1000,
	    healing = 1,
	    tint = {r=0,g=0.8,b=0,a=0.8},
	    order = "a[wall]-b[zmending-wall]"
	},
	{
	    range = 18,
	    action = {
		type = "direct",
		action_delivery =
		    {
			type = "instant",
			
			source_effects =
			    {
				{
				    type = "create-entity",
				    trigger_created_entity = true,
				    entity_name = "small-repair-cloud-rampant-arsenal"
				}
			    }
		    }
	    }
	}
    )

    local mendingGate,mendingGateItem = makeGate(
	{
	    name = "mending",
	    icon = "__RampantArsenal__/graphics/icons/mending-gate.png",
	    health = 1000,
	    healing = 1,	    
	    tint = {r=0,g=0.8,b=0,a=0.8},
	    order = "a[stone-wall]-a[zmending-gate]"
	},
	{
	    range = 18,
	    action = {
		type = "direct",
		action_delivery =
		    {
			type = "instant",
			
			source_effects =
			    {
				{
				    type = "create-entity",
				    trigger_created_entity = true,
				    entity_name = "small-repair-cloud-rampant-arsenal"
				}
			    }
		    }
	    }
	}
    )

    local mendingWallRecipe = makeRecipe({
	    name = "mending-wall",
	    icon = "__RampantArsenal__/graphics/icons/mending-wall.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"stone-wall", 1},
		{"repair-capsule-rampant-arsenal", 1}
	    },
	    result = mendingWallItem
    })

    local mendingGateRecipe = makeRecipe({
	    name = "mending-gate",
	    icon = "__RampantArsenal__/graphics/icons/mending-gate.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"gate", 1},
		{"repair-capsule-rampant-arsenal", 1}
	    },
	    result = mendingGateItem
    })

    addEffectToTech("regeneration-walls",
		    {
			{
			    type = "unlock-recipe",
			    recipe = mendingGateRecipe
			},
			{
			    type = "unlock-recipe",
			    recipe = mendingWallRecipe
			}
    })

end

return walls
