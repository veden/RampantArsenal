local cannons = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local streamUtils = require("utils/StreamUtils")

local makeStream = streamUtils.makeStream
local makeFluidTurret = turretUtils.makeFluidTurret
local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeTechnology = technologyUtils.makeTechnology
local addEffectToTech = technologyUtils.addEffectToTech

local function cannonMkISheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk1-sheet.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.3, -0.6},
		    }
		}
	}    
end


local function shotgunTurretSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/shotgun-turret-sheet.png",
			priority = "high",
			width = 90,
			height = 90,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.3, -0.5},
		    }
		}
	}    
end

local function cannonMkIISheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk2-sheet.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.37, -0.7},
		    }
		}
	}    
end

local function cannonMkIIPlace(lineLength, directionCount, frameCount, backward)
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk2-place.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = lineLength or 1,
			axially_symmetrical = false,
			direction_count = directionCount or 4,
			frame_count = frameCount or 1,
			run_mode = (backward and "backward") or "forward",
			shift = {0.37, -0.7},
		    }
		}
	}    
end


local function largeCannonSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cr-sheet.png",
			priority = "high",
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0, -0.2},
		    }
		}
	}
end


function cannons.enable()
    local entity = {
	name = "cannon",
	icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
	miningTime = 1,
	health = 3500,
	collisionBox = {{-1.2, -1.2 }, {1.2, 1.2}},
	selectionBox = {{-1.4, -1.4 }, {1.4, 1.4}},
	hasBaseDirection = true,
	foldedAnimation = cannonMkISheet(),
	foldingAnimation = cannonMkISheet(),
	preparedAnimation = cannonMkISheet(),
	preparingAnimation = cannonMkISheet()
    }
    local cannonTurret,cannonTurretItem = makeAmmoTurret(entity,
							 {
							     type = "projectile",
							     ammo_category = "cannon-shell",
							     cooldown = 150,
							     projectile_creation_distance = 9,
							     damage_modifier = 2,
							     min_range = 7,
							     turn_range = 0.40,
							     projectile_center = {0, -0.0875},
							     range = 30,
							     sound = make_heavy_gunshot_sounds(),
    })

    local entity1 = {
	name = "rapid-cannon",
	icon = "__RampantArsenal__/graphics/icons/rapidCannonTurret.png",
	miningTime = 1,
	health = 3000,
	foldedAnimation = cannonMkIIPlace(),
	preparingAnimation = cannonMkIIPlace(8, 4, 8),
	preparedAnimation = cannonMkIISheet(),
	attackingAnimation = cannonMkIISheet(),
	hasBaseDirection = true,
	foldingAnimation = cannonMkIIPlace(8, 4, 8, true)
    }
    local rapidCannonTurret,rapidCannonTurretItem = makeAmmoTurret(entity1, {
								       type = "projectile",
								       ammo_category = "cannon-shell",
								       cooldown = 30,
								       min_range = 7,
								       turn_range = 0.40,
								       projectile_creation_distance = 9,
								       projectile_center = {0, -0.0875},
								       range = 30,
								       sound = make_heavy_gunshot_sounds(),
    })
    
    local entity2 = {
    	name = "suppression-cannon",
    	icon = "__RampantArsenal__/graphics/icons/suppressionCannonTurret.png",
    	miningTime = 1,
    	health = 4000,
    	collisionBox = {{-1.7, -2.2 }, {1.7, 2.2}},
    	selectionBox = {{-2, -2.5 }, {2, 2.5}},
	pipeConnections = {
	    { position = {-2.5, 2.0} },
	    { position = {2.5, 2.0} }
	},
    	foldedAnimation = largeCannonSheet(),
    	preparingAnimation = largeCannonSheet(),
    	preparedAnimation = largeCannonSheet(),
    	foldingAnimation = largeCannonSheet()
    }
    local suppressionCannonTurret,suppressionCannonTurretItem = makeFluidTurret(entity2,
										{
										    type = "stream",
										    ammo_category = "flamethrower",
										    cooldown = 4,
										    range = 45,
										    min_range = 6,

										    turn_range = 0.4,
										    fire_penalty = 30,

										    fluids = {
											{type = "crude-oil"},
											{type = "heavy-oil", damage_modifier = 1.05},
											{type = "light-oil", damage_modifier = 1.1}
										    },
										    fluid_consumption = 0.6,

										    gun_center_shift = {
											north = {0, -0.65},
											east = {0, 0},
											south = {0, 0},
											west = {0, 0}
										    },
										    gun_barrel_length = 0.4,

										    ammo_type =
											{
											    category = "flamethrower",
											    action =
												{
												    type = "line",
												    range = 45,
												    force = "enemy",
												    width = 20,
												    action_delivery =
													{
													    type = "stream",
													    stream = makeStream({
														    name = entity2.name,
														    bufferSize = 10,
														    spawnInterval = 2,
														    particleHoizontalSpeed = 2.6,
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
																		entity_name = "fire-flame"
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
																		sticker = "fire-sticker"
																	    },
																	    {
																		type = "damage",
																		damage = { amount = 5, type = "fire" },
																		apply_damage_to_trees = false
																	    }
																	}
																}
															}
														    }
													    }),
													    duration = 10,
													    source_offset = {0.15, -0.5},
													}
												}
											},

										    cyclic_sound =
											{
											    begin_sound =
												{
												    {
													filename = "__base__/sound/fight/flamethrower-start.ogg",
													volume = 0.7
												    }
												},
											    middle_sound =
												{
												    {
													filename = "__base__/sound/fight/flamethrower-mid.ogg",
													volume = 0.7
												    }
												},
											    end_sound =
												{
												    {
													filename = "__base__/sound/fight/flamethrower-end.ogg",
													volume = 0.7
												    }
												}
											}
    })
    
    local entity3 = {
	name = "shotgun",
	icon = "__RampantArsenal__/graphics/icons/shotgunTurret.png",
	miningTime = 1,
	health = 3000,
	hasBaseDirection = true,
	foldedAnimation = shotgunTurretSheet(),
	preparingAnimation = shotgunTurretSheet(),
	preparedAnimation = shotgunTurretSheet(),
	foldingAnimation = shotgunTurretSheet()
    }
    local shotgunTurret,shotgunTurretItem = makeAmmoTurret(entity3, {
							       type = "projectile",
							       ammo_category = "shotgun-shell",
							       cooldown = 45,
							       damage_modifier = 2.0,
							       turn_range = 0.4,
							       projectile_creation_distance = 1.39375,
							       projectile_center = {0, -0.0875},
							       range = 18,
							       sound = make_heavy_gunshot_sounds(),
    })

    local cannonRecipe = makeRecipe({
	    name = "cannon",
	    icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
	    enabled = false,
	    time = 20,
	    ingredients = {
		{"steel-plate", 45},
		{"engine-unit", 5},
		{"iron-gear-wheel", 15},
		{"concrete", 20}
	    },
	    result = cannonTurretItem,
    })

    local rapidCannonRecipe = makeRecipe({
	    name = "rapid-cannon",
	    icon = "__RampantArsenal__/graphics/icons/rapidCannonTurret.png",
	    enabled = false,
	    time = 30,
	    ingredients = {
		{"steel-plate", 40},
		{"engine-unit", 10},
		{"advanced-circuit", 15},
		{"concrete", 20}
	    },
	    result = rapidCannonTurretItem,
    })

    local suppresionCannonRecipe = makeRecipe({
    	    name = "suppression-cannon",	
    	    icon = "__RampantArsenal__/graphics/icons/suppressionCannonTurret.png",
    	    enabled = false,
	    time = 40,
    	    ingredients = {
		{"steel-plate", 60},
		{"engine-unit", 20},
		{"advanced-circuit", 30},
		{"concrete", 60}
    	    },
    	    result = suppressionCannonTurretItem,
    })

    local shotgunTurretRecipe = makeRecipe({
	    name = "shotgun",	
	    icon = "__RampantArsenal__/graphics/icons/shotgunTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 10},
		{"copper-plate", 10},
		{"iron-gear-wheel", 10}
	    },
	    result = shotgunTurretItem,

    })
    
    local cannonTech = makeTechnology({
	    name = "cannon-turret-1",
	    prerequisites = {"turrets","tanks","concrete","steel-processing"},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turrets.png",
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = cannonRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 75,
	    time = 30
    })

    local rapidCannonTech = makeTechnology({
	    name = "cannon-turret-2",
	    prerequisites = {"explosives", "cannon-shell-speed-1", cannonTech},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turrets.png",
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = rapidCannonRecipe,
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}		
	    },
	    count = 120,
	    time = 30
    })

    local shotgunTurretTech = makeTechnology({
	    name = "shotgun",
	    prerequisites = {"turrets","steel-processing","military"},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turrets.png",
	    effects = {
		{
		    type = "unlock-recipe",
		    recipe = shotgunTurretRecipe,
		}
	    },
	    ingredients = {{"science-pack-1", 1}},
	    count = 20,
	    time = 10
    })

    makeTechnology({
    	    name = "flamethrower",
    	    prerequisites = {"flamethrower-damage-2", "military-4", "advanced-electronics-2", "concrete"},
	    icon = "__base__/graphics/technology/flamethrower.png",
    	    effects = {
    		{
    		    type = "unlock-recipe",
    		    recipe = suppresionCannonRecipe,
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


    local r1 = makeTechnology({
	    name = "shotgun-turret-damage-1",
	    prerequisites = {shotgunTurretTech},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1}
	    },
	    count = 50,
	    time = 30,
	    order = "e-z-a"
    })

    local r2 = makeTechnology({
	    name = "shotgun-turret-damage-2",
	    prerequisites = {r1},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
		    modifier = 0.1
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1}
	    },
	    count = 100,
	    time = 45,
	    order = "e-z-b"
    })

    local r3 = makeTechnology({
	    name = "shotgun-turret-damage-3",
	    prerequisites = {r2},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 50,
	    order = "e-z-c"
    })

    local r4 = makeTechnology({
	    name = "shotgun-turret-damage-4",
	    prerequisites = {r3},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"military-science-pack", 1}
	    },
	    count = 300,
	    time = 60,
	    order = "e-z-d"
    })


    local r5 = makeTechnology({
	    name = "shotgun-turret-damage-5",
	    prerequisites = {r4},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
		    modifier = 0.2
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1}
	    },
	    count = 1000,
	    time = 60,
	    order = "e-z-e"
    })

    local r6 = makeTechnology({
	    name = "shotgun-turret-damage-6",
	    prerequisites = {r5},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
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
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "shotgun-turret-damage-7",
	    prerequisites = {r6},
	    icon = "__RampantArsenal__/graphics/technology/shotgun-turret-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = shotgunTurret,
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })

    
    local t1 = makeTechnology({
	    name = "cannon-turret-damage-1",
	    prerequisites = {cannonTech},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
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
	    time = 30,
	    order = "e-z-a"
    })

    local t2 = makeTechnology({
	    name = "cannon-turret-damage-2",
	    prerequisites = {t1},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
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
	    time = 45,
	    order = "e-z-b"
    })

    local t3 = makeTechnology({
	    name = "cannon-turret-damage-3",
	    prerequisites = {t2},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
		    modifier = 0.2
		},
		{
		    type = "turret-attack",
		    turret_id = rapidCannonTurret,
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
	    time = 50,
	    order = "e-z-c"
    })

    local t4 = makeTechnology({
	    name = "cannon-turret-damage-4",
	    prerequisites = {t3},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
		    modifier = 0.3
		},
		{
		    type = "turret-attack",
		    turret_id = rapidCannonTurret,
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
	    time = 60,
	    order = "e-z-d"
    })


    local t5 = makeTechnology({
	    name = "cannon-turret-damage-5",
	    prerequisites = {t4},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
		    modifier = 0.3
		},
		{
		    type = "turret-attack",
		    turret_id = rapidCannonTurret,
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
	    time = 60,
	    order = "e-z-e"
    })

    local t6 = makeTechnology({
	    name = "cannon-turret-damage-6",
	    prerequisites = {t5},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
		    modifier = 0.4
		},		
		{
		    type = "turret-attack",
		    turret_id = rapidCannonTurret,
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
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "cannon-turret-damage-7",
	    prerequisites = {t6},
	    icon = "__RampantArsenal__/graphics/technology/cannon-turret-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = cannonTurret,
		    modifier = 0.4
		},
		{
		    type = "turret-attack",
		    turret_id = rapidCannonTurret,
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L-7)*1000",
	    time = 60,
	    order = "e-z-f"
    })

    makeTechnology({
	    name = "artillery-shell-damage-1",
	    prerequisites = {"artillery"},
	    icon = "__RampantArsenal__/graphics/technology/artillery-shell-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "ammo-damage",
		    ammo_category = "artillery-shell",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L)*1000",
	    time = 60,
	    order = "e-z-f"
    })   

    makeTechnology({
	    name = "artillery-turret-damage-1",
	    prerequisites = {"artillery"},
	    icon = "__RampantArsenal__/graphics/technology/artillery-damage.png",
	    upgrade = true,
	    maxLevel = "infinite",
	    effects = {
		{
		    type = "turret-attack",
		    turret_id = "artillery-wagon",
		    modifier = 0.4
		},
		{
		    type = "turret-attack",
		    turret_id = "artillery-turret",
		    modifier = 0.4
		}
	    },
	    ingredients = {
		{"science-pack-1", 1},
		{"science-pack-2", 1},
		{"science-pack-3", 1},
		{"military-science-pack", 1},
		{"high-tech-science-pack", 1},
		{"space-science-pack", 1}
	    },
	    countForumla = "2^(L)*1000",
	    time = 60,
	    order = "e-z-f"
    })


    
    addEffectToTech("flamethrower-damage-1",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.2
    })

    addEffectToTech("flamethrower-damage-2",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.2
    })

    addEffectToTech("flamethrower-damage-3",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.3
    })

    addEffectToTech("flamethrower-damage-4",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.3
    })

    addEffectToTech("flamethrower-damage-5",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.4
    })

    addEffectToTech("flamethrower-damage-6",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.2
    })

    addEffectToTech("flamethrower-damage-7",
		    {
			type = "turret-attack",
			turret_id = suppressionCannonTurret,
			modifier = 0.2
    })
end


return cannons
