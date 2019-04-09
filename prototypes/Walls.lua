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
	    tint = {r=0.5,g=0.60,b=0.5,a=1},
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
		    type = "acid",
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
	    tint = {r=0.5,g=0.60,b=0.5,a=1},
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
		    type = "acid",
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

    makeRecipe({
	    name = mendingWallItem,
	    icon = "__RampantArsenal__/graphics/icons/mending-wall.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"stone-wall", 1},
		{"repair-capsule-rampant-arsenal", 1}
	    },
	    result = mendingWallItem
    })

    makeRecipe({
	    name = mendingGateItem,
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
			    recipe = mendingGateItem
			},
			{
			    type = "unlock-recipe",
			    recipe = mendingWallItem
			}
    })

    local reinforcedWall,reinforcedWallItem = makeWall(
	{
	    name = "reinforced",
	    icon = "__RampantArsenal__/graphics/icons/reinforced-wall.png",
	    health = 1500,
	    tint = {r=0.5,g=0.5,b=0.60,a=1},
	    order = "a[stone-wall]-a[zreinforced-wall]",
	    resistances = {
		{
		    type = "physical",
		    decrease = 6,
		    percent = 40
		},
		{
		    type = "impact",
		    decrease = 45,
		    percent = 80
		},
		{
		    type = "explosion",
		    decrease = 20,
		    percent = 60
		},
                {
		    type = "acid",
		    percent = 70
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
		    percent = 60
		},
		{
		    type = "poison",
		    percent = 60
		}
	    }
	}
    )

    local reinforcedGate,reinforcedGateItem = makeGate(
	{
	    name = "reinforced",
	    icon = "__RampantArsenal__/graphics/icons/reinforced-gate.png",
	    health = 1500,
	    tint = {r=0.5,g=0.5,b=0.9,a=1},
	    order = "a[wall]-b[gatezz]",
	    resistances = {
		{
		    type = "physical",
		    decrease = 6,
		    percent = 40
		},
		{
		    type = "impact",
		    decrease = 45,
		    percent = 80
		},
		{
		    type = "explosion",
		    decrease = 20,
		    percent = 60
		},
                {
		    type = "acid",
		    percent = 70
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
		    percent = 60
		},
		{
		    type = "poison",
		    percent = 60
		}
	    }
	}
    )

    makeRecipe({
	    name = reinforcedWallItem,
	    icon = "__RampantArsenal__/graphics/icons/reinforced-wall.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"refined-concrete", 5}
	    },
	    result = reinforcedWallItem
    })

    makeRecipe({
	    name = reinforcedGateItem,
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
			    recipe = reinforcedGateItem
			},
			{
			    type = "unlock-recipe",
			    recipe = reinforcedWallItem
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
		      type = "acid",
		      percent = 15
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
		      type = "acid",
		      percent = 15
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
