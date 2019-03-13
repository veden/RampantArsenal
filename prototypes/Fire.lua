local fire = {}

local technologyUtils = require("utils/TechnologyUtils")
local ammoUtils = require("utils/AmmoUtils")
local streamUtils = require("utils/StreamUtils")
local recipeUtils = require("utils/RecipeUtils")
local oilUtils = require("resources/OilUtils")

local makeStream = streamUtils.makeStream
local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local addFluid = oilUtils.addFluid

function fire.enable()

    local napalm = addFluid({
	    name = "napalm",
	    icon = "__RampantArsenal__/graphics/icons/napalm.png",
	    baseColor = { r = 0.57, g = 0.37, b = 0, a = 0.9 },
	    flowColor = { r = 0.57, g = 0.37, b = 0, a = 0.9 },
	    emissionsMultiplier = 4.5,
	    fuelValue = "1.25MJ",
	    order = "e[napalm]"
    })

    local napalmAmmo = makeAmmo({
    	    name = "napalm",
    	    icon = "__RampantArsenal__/graphics/icons/napalm-ammo.png",
	    order = "e[napalm]",
    	    ammoType = {
		{
		    source_type = "default",
		    category = "flamethrower",
		    target_type = "position",
		    clamp_position = true,

		    action =
			{
			    type = "direct",
			    action_delivery =
				{
				    type = "stream",
				    stream = makeStream({
					    name = "napalm-handheld",
					    bufferSize = 65,
					    spawnInterval = 2,
					    particleTimeout = 2,
					    particleVerticalAcceleration = 0.005,
					    particleHoizontalSpeed = 0.25,
					    actions = {
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "create-fire",
									entity_name = "fire-flame",
									initial_ground_flame_count = 6,
								    }
								}
							}
						},
						{
						    type = "area",
						    radius = 2.5,
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "create-sticker",
									sticker = "small-fire-sticker-rampant-arsenal"
								    },
								    {
									type = "create-fire",
									entity_name = "fire-flame",
									initial_ground_flame_count = 6,
								    },
								    {
									type = "damage",
									damage = { amount = 9, type = "fire" },
									apply_damage_to_trees = false
								    }
								}
							}
						}
					    }
				    }),
				    max_length = 15,
				    duration = 160,
				}
			}
		},
		{
		    source_type = "vehicle",
		    consumption_modifier = 1.125,
		    category = "flamethrower",
		    target_type = "position",
		    clamp_position = true,

		    action =
			{
			    type = "direct",
			    action_delivery =
				{
				    type = "stream",
				    stream = makeStream({
					    name = "napalm-tank",
					    bufferSize = 65,
					    spawnInterval = 2,
					    particleTimeout = 2,
					    particleVerticalAcceleration = 0.015,
					    particleHoizontalSpeed = 0.45,
					    particleHoizontalSpeedDeviation = 0.0035,
					    particleSize = 1.5,
					    actions = {
						{
						    type = "area",
						    radius = 6,
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "damage",
									damage = { amount = 25, type = "fire" },
									apply_damage_to_trees = true
								    }
								}
							}
						}
					    }
				    }),
				    max_length = 9,
				    duration = 160,
				}
			}
		}
	    }
    })

    local napalmAmmoRecipe = makeRecipe({
	    name = "napalm-ammo",
	    icon = "__RampantArsenal__/graphics/icons/napalm-ammo.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"steel-plate", 5},
		{"copper-plate", 2},
		{type="fluid", name=napalm, amount=100}
	    },
	    result = napalmAmmo,
    })

    local napalmRecipe = makeRecipe({
	    name = "napalm",
	    icon = "__RampantArsenal__/graphics/icons/napalm.png",
	    enabled = false,
	    category = "chemistry",
	    subgroup = "fluid-recipes",
	    ingredients = {
		{"plastic-bar", 1},
		{type="fluid", name="petroleum-gas", amount=30},
		{type="fluid", name="sulfuric-acid", amount=20}
	    },
	    results = {
		{type="fluid", name=napalm, amount=50}
	    }
    })

    addEffectToTech("incendiary-napalm",
		    {
			{
			    type = "unlock-recipe",
			    recipe = napalmAmmoRecipe,
			},
			{
			    type = "unlock-recipe",
			    recipe = napalmRecipe,
			}
    })

    local fluids = data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids
    fluids[#fluids+1] = {type=napalm, damage_modifier=1.5}
end

return fire
