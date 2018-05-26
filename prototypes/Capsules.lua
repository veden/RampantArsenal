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

local capsuleGrey = {r=0,g=0,b=0,a=0.9}
local particleGrey = {r=0,g=0,b=0,a=0.9}

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
	    name = "slowdown-capsule",
	    icon = "__RampantArsenal__/graphics/icons/slowdown-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					name = "slowdown-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
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
	    icon = "__RampantArsenal__/graphics/icons/poison-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
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
	    icon = "__RampantArsenal__/graphics/icons/distractor-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
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
	    icon = "__RampantArsenal__/graphics/icons/defender-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
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
	    icon = "__RampantArsenal__/graphics/icons/destroyer-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
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
	    icon = "__RampantArsenal__/graphics/icons/landmine-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
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

    local grenadeCapsules = makeAmmo({
	    name = "grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/grenade-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					name = "grenade-capsule",
					bufferSize = 5,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
							    type = "create-entity",
							    entity_name = "grenade"
							}
						    }						
					    },
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})


    local clusterGrenadeCapsules = makeAmmo({
	    name = "cluster-grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/cluster-grenade-capsule-ammo.png",
	    magSize = 1,
	    order = "f[capsule]",
	    stackSize = 200,
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
					name = "cluster-grenade-capsule",
					bufferSize = 5,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
							    type = "create-entity",
							    entity_name = "cluster-grenade"
							}
						    }						
					    },
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})
    
    local slowCapsuleRecipe = makeRecipe({
	    name = "slow-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/slowdown-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"slowdown-capsule", 1},
		{"explosives", 1}
	    },
	    result = slowCapsules
    })

    local poisonCapsuleRecipe = makeRecipe({
	    name = "poison-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/poison-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"poison-capsule", 1},
		{"explosives", 1}
	    },
	    result = poisonCapsules
    })

    local distractorCapsuleRecipe = makeRecipe({
	    name = "distractor-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/distractor-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"distractor-capsule", 1},
		{"explosives", 1}
	    },
	    result = distractorCapsules
    })

    local defenderCapsuleRecipe = makeRecipe({
	    name = "defender-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/defender-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"defender-capsule", 1},
		{"explosives", 1}
	    },
	    result = defenderCapsules
    })
    
    local destroyerCapsuleRecipe = makeRecipe({
	    name = "destroyer-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/destroyer-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"destroyer-capsule", 1},
		{"explosives", 1}
	    },
	    result = destroyerCapsules
    })

    local landmineCapsuleRecipe = makeRecipe({
	    name = "landmind-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/landmine-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"land-mine", 4},
		{"explosives", 1}
	    },
	    result = landmineCapsules
    })

    local grenadeCapsuleRecipe = makeRecipe({
	    name = "grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"grenade", 1},
		{"explosives", 1}
	    },
	    result = grenadeCapsules
    })

    local clusterGrenadeCapsuleRecipe = makeRecipe({
	    name = "cluster-grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/cluster-grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"cluster-grenade", 1},
		{"explosives", 1}
	    },
	    result = clusterGrenadeCapsules
    })
    
    local entity = {
	name = "capsule",
	icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	miningTime = 1,
	health = 1200,
	foldedAnimation = CapsuleLauncherSheet(),
	foldingAnimation = CapsuleLauncherSheet(),
	preparedAnimation = CapsuleLauncherSheet(),
	preparingAnimation = CapsuleLauncherSheet(),
	order = "c[launcher]"
    }
    local _, capsuleTurretItem = makeAmmoTurret(entity, {
						    type = "stream",
						    ammo_category = "capsule-launcher",
						    cooldown = 150,
						    damage_modifier = 3,
						    gun_center_shift = {
							north = {0, 0},
							east = {0, -4},
							south = {0, 0},
							west = {0, -4}
						    },
						    gun_barrel_length = 4,
						    range = 32,
						    sound = make_heavy_gunshot_sounds()
    })

    local capsuleTurretRecipe = makeRecipe({
	    name = "capsule-turret",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 10},
		{"engine-unit", 5},
		{"advanced-circuit", 15},
		{"explosives", 30}
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

    addEffectToTech("military-4",
		    {
			type = "unlock-recipe",
			recipe = clusterGrenadeCapsuleRecipe,
    })

    addEffectToTech("military-2",
		    {
			type = "unlock-recipe",
			recipe = grenadeCapsuleRecipe,
    })


    
    local capsuleTurretTech = makeTechnology({
	    name = "capsule-turret",
	    prerequisites = {"turrets", "military-3", "explosives"},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turrets.png",
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

    local t1 = makeTechnology({
	    name = "capsule-turret-speed-1",
	    prerequisites = {capsuleTurretTech},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.1
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

    local t2 = makeTechnology({
	    name = "capsule-turret-speed-2",	    
	    prerequisites = {t1},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 150,
	    time = 45
    })

    local t3 = makeTechnology({
	    name = "capsule-turret-speed-3",
	    prerequisites = {t2},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50
    })

    local t4 = makeTechnology({
	    name = "capsule-turret-speed-4",
	    prerequisites = {t3},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.3
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 300,
	    time = 60
    })


    local t5 = makeTechnology({
	    name = "capsule-turret-speed-5",
	    prerequisites = {t4},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.3
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 1000,
	    time = 60
    })

    makeTechnology({
	    name = "capsule-turret-speed-6",
	    prerequisites = {t5},
	    icon = "__RampantArsenal__/graphics/technology/capsule-turret-speed.png",
	    upgrade = true,
	    effects = {
		{
		    type = "gun-speed",
		    ammo_category = "capsule-launcher",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1}
	    },
	    count = 3000,
	    time = 60
    })


end

return capsules
