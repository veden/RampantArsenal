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
	    tint = {r=0,g=0.8,b=0,a=1},
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
	    tint = {r=0.8,g=0,b=0,a=1},
	    triggerRadius = 2.5,
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
	    tint = {r=0.5,g=0,b=0.5,a=1},
	    triggerRadius = 2.5,
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
							    type = "create-sticker",
							    sticker = "small-toxic-sticker-rampant-arsenal"
							},							
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
	    tint = {r=0,g=0,b=0.8,a=1},
	    triggerRadius = 2.5,
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
			    damage = { amount = 1250, type = "explosion"}
			},
			{
			    type = "nested-result",
			    affects_target = true,
			    action =
				{
				    {
					type = "area",
					radius = 10,
					action_delivery =
					    {
						type = "instant",
						target_effects =
						    {
							{
							    type = "push-back",
							    distance = 1.5
							},
							{
							    type = "damage",
							    damage = { amount = 700, type = "explosion" }
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
    
    local nuclearLandmineRecipe = makeRecipe({
	    name = "nuclear-landmine",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-landmine.png",
	    enabled = false,
	    ingredients = {
		{"land-mine", 1},
		{"atomic-bomb", 1}
	    },	 
	    result = nuclearLandmine
    })

    local incendiaryLandmineRecipe = makeRecipe({
	    name = "incendiary-landmine",
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


    local heLandmineRecipe = makeRecipe({
	    name = "he-landmine",
	    icon = "__RampantArsenal__/graphics/icons/he-landmine.png",
	    enabled = false,
	    category = "chemistry",
	    ingredients = {
		{"land-mine", 1},
		{"steel-plate", 1},
		{"explosives", 5}
	    },
	    result = heLandmine
    })

    
    local bioLandmineRecipe = makeRecipe({
	    name = "bio-landmine",
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
    
    addEffectToTech("uranium-ammo",
		    {
			type = "unlock-recipe",
			recipe = nuclearLandmineRecipe,
    })

    addEffectToTech("incendiary-landmine",
		    {
			type = "unlock-recipe",
			recipe = incendiaryLandmineRecipe,
    })

    addEffectToTech("he-landmine",
		    {
			type = "unlock-recipe",
			recipe = heLandmineRecipe,
    })

    addEffectToTech("bio-landmine",
		    {
			type = "unlock-recipe",
			recipe = bioLandmineRecipe,
    })
end

return landmines
