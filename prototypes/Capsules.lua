local capsules = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local ammoUtils = require("utils/AmmoUtils")
local streamUtils = require("utils/StreamUtils")

local addEffectToTech = technologyUtils.addEffectToTech
local makeStream = streamUtils.makeStream
local makeAmmo = ammoUtils.makeAmmo
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

    data:extend(
	{
	    {
		type = "ammo-category",
		name = "capsule-launcher",
	    }	    
    })

    local slowCapsules = makeAmmo({		    
	    name = "slow-capsule",
	    ammoType = {		
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "slow-capsule",
					actions = {
					    type = "area",
					    radius = 9,
					    force = "enemy",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-sticker",
							    sticker = "slowdown-sticker"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})

    local poisonCapsules = makeAmmo({		    
	    name = "poison-capsule",
	    ammoType = {		
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "poison-capsule",
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-entity",
							    show_in_tooltip = true,
							    entity_name = "poison-cloud"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})

    local distractorCapsules = makeAmmo({		    
	    name = "distractor-capsule",
	    ammoType = {		
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "distractor-capsule",
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    {
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "distractor",
								offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
							    }
							}
						}
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local defenderCapsules = makeAmmo({		    
	    name = "defender-capsule",
	    ammoType = {		
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "defender-capsule",
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    {
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "defender",
								offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
							    }
							}
						}
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})
    
    local destroyerCapsules = makeAmmo({
	    name = "destroyer-capsule",
	    ammoType = {		
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "destroyer-capsule",
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    {
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "destroyer",
								offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
							    }
							}
						}
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local landmineCapsules = makeAmmo({
	    name = "landmine-capsule",
	    ammoType = {		
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "landmine-capsule",
					bufferSize = 5,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
							    type = "create-entity",
							    entity_name = "land-mine"
							}
						    }						
					    },
					    {
						type = "cluster",
						cluster_count = 3,
						distance = 4,
						distance_deviation = 3,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    show_in_tooltip = true,
								    entity_name = "land-mine"
								}
							    }
						    }
					}}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    
    local slowCapsuleRecipe = makeRecipe({
	    name = "slow-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = slowCapsules
    })

    local poisonCapsuleRecipe = makeRecipe({
	    name = "poison-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = poisonCapsules
    })

    local distractorCapsuleRecipe = makeRecipe({
	    name = "distractor-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = distractorCapsules
    })

    local defenderCapsuleRecipe = makeRecipe({
	    name = "defender-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = defenderCapsules
    })

    
    local destroyerCapsuleRecipe = makeRecipe({
	    name = "destroyer-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = destroyerCapsules
    })

    local landmineCapsuleRecipe = makeRecipe({
	    name = "landmind-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = landmineCapsules
    })
    
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
						    type = "stream",
						    ammo_category = "capsule-launcher",
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
						    range = 30,
						    sound = make_heavy_gunshot_sounds()
    })

    local capsuleTurretRecipe = makeRecipe({
	    name = "capsule-turret",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 1}
	    },
	    result = capsuleTurretItem,
    })

    addEffectToTech("combat-robotics",
		    {
			type = "unlock-recipe",
			recipe = defenderCapsuleRecipe,
    })

    addEffectToTech("combat-robotics-2",
		    {
			type = "unlock-recipe",
			recipe = distractorCapsuleRecipe,
    })

    addEffectToTech("combat-robotics-3",
		    {
			type = "unlock-recipe",
			recipe = destroyerCapsuleRecipe,
    })

    addEffectToTech("land-mine",
		    {
			type = "unlock-recipe",
			recipe = landmineCapsuleRecipe,
    })
    
    makeTechnology({
	    name = "capsule-turret",
	    prerequisites = {"turrets", "military-3", "explosives"},
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = capsuleTurretRecipe,
		},
		{
		    type = "unlock-recipe",
		    recipe = slowCapsuleRecipe,
		},
		{
		    type = "unlock-recipe",
		    recipe = poisonCapsuleRecipe,
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
