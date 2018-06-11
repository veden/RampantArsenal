local walls = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local wallUtils = require("utils/WallUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeBombWave = projectileUtils.makeBombWave
local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeWall = wallUtils.makeWall
local addResistance = wallUtils.addResistance
local makeGate = wallUtils.makeGate

function walls.enable()

    local mendingWall,mendingWallItem = makeWall(
	{
	    name = "mending",
	    icon = "__RampantArsenal__/graphics/icons/mending-wall.png",
	    health = 1000,
	    healing = 1,
	    tint = {r=0,g=0.8,b=0,a=0.8},
	    order = "a[stone-wall]-a[zmending-wall]",
	    resistances = {
		{
		    type = "physical",
		    decrease = 3,
		    percent = 20
		},
		{
		    type = "impact",
		    decrease = 45,
		    percent = 60
		},
		{
		    type = "explosion",
		    decrease = 10,
		    percent = 30
		},
		{
		    type = "fire",
		    percent = 100
		},
		{
		    type = "laser",
		    percent = 40
		},
		{
		    type = "electric",
		    percent = 30
		},
		{
		    type = "poison",
		    percent = 30
		}
	    }
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
	    order = "a[wall]-b[gatez]",
	    resistances = {
		{
		    type = "physical",
		    decrease = 3,
		    percent = 20
		},
		{
		    type = "impact",
		    decrease = 45,
		    percent = 60
		},
		{
		    type = "explosion",
		    decrease = 10,
		    percent = 30
		},
		{
		    type = "fire",
		    percent = 100
		},
		{
		    type = "laser",
		    percent = 40
		},
		{
		    type = "electric",
		    percent = 30
		},
		{
		    type = "poison",
		    percent = 30
		}
	    }
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
		{mendingWall, 1},
		{"steel-plate", 1},
		{"advanced-circuit", 5}
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
    
    local reinforcedWall,reinforcedWallItem = makeWall(
	{
	    name = "reinforced",
	    icon = "__RampantArsenal__/graphics/icons/reinforced-wall.png",
	    health = 1500,
	    tint = {r=0,g=0,b=0.8,a=0.8},
	    order = "a[stone-wall]-a[zreinforced-wall]",
	    resistances = {
		{
		    type = "physical",
		    decrease = 3,
		    percent = 40
		},
		{
		    type = "impact",
		    decrease = 45,
		    percent = 70
		},
		{
		    type = "explosion",
		    decrease = 10,
		    percent = 50
		},
		{
		    type = "fire",
		    percent = 100
		},
		{
		    type = "laser",
		    percent = 60
		},
		{
		    type = "electric",
		    percent = 50
		},
		{
		    type = "poison",
		    percent = 50
		}
	    }
	}
    )
    
    local reinforcedGate,reinforcedGateItem = makeGate(
	{
	    name = "reinforced",
	    icon = "__RampantArsenal__/graphics/icons/reinforced-gate.png",
	    health = 1500,	    
	    tint = {r=0,g=0,b=0.8,a=0.8},
	    order = "a[wall]-b[gatezz]",
	    resistances = {
		{
		    type = "physical",
		    decrease = 3,
		    percent = 40
		},
		{
		    type = "impact",
		    decrease = 45,
		    percent = 70
		},
		{
		    type = "explosion",
		    decrease = 10,
		    percent = 50
		},
		{
		    type = "fire",
		    percent = 100
		},
		{
		    type = "laser",
		    percent = 60
		},
		{
		    type = "electric",
		    percent = 50
		},
		{
		    type = "poison",
		    percent = 50
		}
	    }
	}
    )
    
    local reinforcedWallRecipe = makeRecipe({
	    name = "reinforced-wall",
	    icon = "__RampantArsenal__/graphics/icons/reinforced-wall.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"refined-concrete", 10}
	    },
	    result = reinforcedWallItem
    })

    local reinforcedGateRecipe = makeRecipe({
	    name = "reinforced-gate",
	    icon = "__RampantArsenal__/graphics/icons/reinforced-gate.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{reinforcedWall, 1},
		{"steel-plate", 1},
		{"advanced-circuit", 5}
	    },
	    result = reinforcedGateItem
    })
    
    addEffectToTech("stone-walls-2",
		    {
			{
			    type = "unlock-recipe",
			    recipe = reinforcedGateRecipe
			},
			{
			    type = "unlock-recipe",
			    recipe = reinforcedWallRecipe
			}
    })

    addResistance("wall",
		  "stone-wall",
		  {
		      type = "laser",
		      percent = 30
    })

    
    addResistance("wall",
		  "stone-wall",
		  {
		      type = "electric",
		      percent = 20
    })

    
    addResistance("wall",
		  "stone-wall",
		  {
		      type = "poison",
		      percent = 20
    })
    
    addResistance("gate",
		  "gate",
		  {
		      type = "laser",
		      percent = 30
    })

    addResistance("gate",
		  "gate",
		  {
		      type = "electric",
		      percent = 20
    })
    
    addResistance("gate",
		  "gate",
		  {
		      type = "poison",
		      percent = 20
    })
end

return walls
