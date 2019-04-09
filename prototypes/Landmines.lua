local landmines = {}

local landmineUtils = require("utils/LandmineUtils")
local technologyUtils = require("utils/TechnologyUtils")
local recipeUtils = require("utils/RecipeUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeLandmine = landmineUtils.makeLandmine

function landmines.enable()

    local nuclearLandmine = makeLandmine(
	{
	    name = "nuclear",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-landmine.png",
	    tint = {r=0.70,g=0.9,b=0.70,a=1},
	    triggerRadius = 10,
	    stackSize = 100,
	    order="f[land-mine]-c[nuclear]"
	},
	{
	    type = "direct",
	    action_delivery =
		{
		    type = "instant",
		    source_effects =
			{
			    {
				repeat_count = 100,
				type = "create-trivial-smoke",
				smoke_name = "nuclear-smoke",
				offset_deviation = {{-1, -1}, {1, 1}},
				slow_down_factor = 1,
				starting_frame = 3,
				starting_frame_deviation = 5,
				starting_frame_speed = 0,
				starting_frame_speed_deviation = 5,
				speed_from_center = 0.5,
				speed_deviation = 0.2
			    },
			    {
				type = "create-entity",
				entity_name = "small-scorchmark",
				check_buildability = true
			    },
			    {
				type = "nested-result",
				action =
				    {
					type = "area",
					target_entities = false,
					repeat_count = 2000,
					radius = 35,
					action_delivery =
					    {
						type = "projectile",
						projectile = "atomic-bomb-wave",
						starting_speed = 0.5
					    }
				    }
			    },
			    {
				type = "create-entity",
				entity_name = "explosion"
			    },
			    {
				type = "damage",
				damage = { amount = 1000, type = "explosion"}
			    }
			}
		}
	}
    )

    local incendiaryLandmine = makeLandmine(
	{
	    name = "incendiary",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-landmine.png",
	    tint = {r=0.9,g=0.70,b=0.70,a=1},
	    triggerRadius = 3.5,
	    stackSize = 100,
	    resistances = {
		{
		    type = "fire",
		    percent = 100
		}
	    },
	    order="f[land-mine]-b[incendiary]"
	},
	{
	    type = "direct",
	    action_delivery =
		{
		    type = "instant",
		    source_effects = {
			{
			    type = "create-entity",
			    entity_name = "big-explosion"
			},
			{
			    type = "damage",
			    damage = { amount = 500, type = "explosion"}
			},
			{
			    type = "damage",
			    damage = { amount = 750, type = "fire"}
			},
			{
			    type = "nested-result",
			    affects_target = true,
			    action =
				{
				    {
					type = "area",
					radius = 6,
					force = "enemy",
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
							    type = "damage",
							    damage = { amount = 500, type = "fire" },
							    apply_damage_to_trees = false
							},
							{
							    type = "create-fire",
							    entity_name = "fire-flame",
							    initial_ground_flame_count = 7,
							    check_buildability = true
							}
						    }
					    }
				    },
				    {
					type = "cluster",
					cluster_count = 15,
					distance = 4,
					distance_deviation = 3,
					action_delivery =
					    {
						type = "instant",
						target_effects =
						    {
							{
							    type = "create-fire",
							    entity_name = "fire-flame",
							    initial_ground_flame_count = 7,
							    check_buildability = true
							}
						    }
					    }
				}}
			}
		    }
		}
	}
    )

    local bioLandmine = makeLandmine(
	{
	    name = "bio",
	    icon = "__RampantArsenal__/graphics/icons/bio-landmine.png",
	    tint = {r=0.9,g=0.60,b=0.9,a=1},
	    triggerRadius = 5.5,
            stackSize = 100,
	    order="f[land-mine]-c[bio]"
	},
	{
	    type = "direct",
	    action_delivery =
		{
		    type = "instant",
		    source_effects = {
			{
			    type = "create-entity",
			    entity_name = "big-explosion"
			},
			{
			    type = "damage",
			    damage = { amount = 500, type = "explosion"}
			},
			{
			    type = "damage",
			    damage = { amount = 750, type = "poison"}
			},
                        {
                            type = "create-entity",
                            entity_name = "toxic-cloud-rampant-arsenal",
                            show_in_tooltip = true
                        },
			{
			    type = "nested-result",
			    affects_target = true,
			    action =
				{
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
							    damage = { amount = 450, type = "poison" }
							}
						    }
					    }
				    }
				}
			}
		    }
		}
	}
    )

    local heLandmine = makeLandmine(
	{
	    name = "he",
	    icon = "__RampantArsenal__/graphics/icons/he-landmine.png",
	    tint = {r=0.70,g=0.70,b=0.9,a=1},
	    triggerRadius = 7.5,
            stackSize = 100,
	    order="f[land-mine]-c[bio]"
	},
	{
	    type = "direct",
	    action_delivery =
		{
		    type = "instant",
		    source_effects = {
			{
			    type = "create-entity",
			    entity_name = "big-artillery-explosion"
			},
			{
			    type = "damage",
			    damage = { amount = 4500, type = "explosion"}
			},
			{
			    type = "nested-result",
			    affects_target = true,
			    action =
				{
				    {
					type = "area",
					radius = 8,
					action_delivery =
					    {
						type = "instant",
						target_effects =
						    {
							{
							    type = "push-back",
							    distance = 2.5
							},
							{
							    type = "damage",
							    damage = { amount = 2250, type = "explosion" }
							}
						    }
					    }
				    }
				}
			}
		    }
		}
	}
    )

    makeRecipe({
	    name = nuclearLandmine,
	    icon = "__RampantArsenal__/graphics/icons/nuclear-landmine.png",
	    enabled = false,
	    ingredients = {
		{"land-mine", 1},
		{"atomic-bomb", 1}
	    },
	    result = nuclearLandmine
    })

    makeRecipe({
	    name = incendiaryLandmine,
	    icon = "__RampantArsenal__/graphics/icons/incendiary-landmine.png",
	    enabled = false,
	    category = "chemistry",
	    ingredients = {
		{"land-mine", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=40}
	    },
	    result = incendiaryLandmine
    })


    makeRecipe({
	    name = heLandmine,
	    icon = "__RampantArsenal__/graphics/icons/he-landmine.png",
	    enabled = false,
	    category = "chemistry",
	    ingredients = {
		{"land-mine", 1},
		{"steel-plate", 1},
		{"explosives", 4}
	    },
	    result = heLandmine
    })


    makeRecipe({
	    name = bioLandmine,
	    icon = "__RampantArsenal__/graphics/icons/bio-landmine.png",
	    enabled = false,
	    category = "chemistry",
	    ingredients = {
		{"land-mine", 1},
		{"steel-plate", 1},
		{"poison-capsule", 2}
	    },
	    result = bioLandmine
    })

    local landmine = data.raw["land-mine"]["land-mine"]
    
    landmine.action = {
        type = "direct",
        action_delivery =
            {
                type = "instant",
                source_effects =
                    {
                        {
                            type = "nested-result",
                            affects_target = true,
                            action =
                                {
                                    type = "area",
                                    radius = 6,
                                    force = "enemy",
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    {
                                                        type = "damage",
                                                        damage = { amount = 250, type = "explosion"}
                                                    },
                                                    {
                                                        type = "create-sticker",
                                                        sticker = "lite-slow-sticker-rampant-arsenal"
                                                    }
                                                }
                                        }
                                }
                        },
                        {
                            type = "create-entity",
                            entity_name = "explosion"
                        },
                        {
                            type = "damage",
                            damage = { amount = 1000, type = "explosion"}
                        }
                    }
            }
    }
    landmine = table.deepcopy(data.raw["land-mine"]["land-mine"])
    -- local landmineRecipe = table.deepcopy(data.raw["recipe"]["land-mine"])
    local landmineItem = table.deepcopy(data.raw["item"]["land-mine"])

    landmineItem.hidden = true
    landmineItem.name = "landmine-ghostless-rampant-arsenal"
    landmineItem.place_result = "landmine-ghostless-rampant-arsenal"

    landmine.name = "landmine-ghostless-rampant-arsenal"
    landmine.create_ghost_on_death = false
    landmine.flags[#landmine.flags+1] = "hidden"

    data:extend({
            landmine,
            landmineItem
    })

    addEffectToTech("uranium-ammo",
		    {
			type = "unlock-recipe",
			recipe = nuclearLandmine,
    })

    addEffectToTech("incendiary-landmine",
		    {
			type = "unlock-recipe",
			recipe = incendiaryLandmine,
    })

    addEffectToTech("he-landmine",
		    {
			type = "unlock-recipe",
			recipe = heLandmine,
    })

    addEffectToTech("bio-landmine",
		    {
			type = "unlock-recipe",
			recipe = bioLandmine,
    })
end

return landmines
