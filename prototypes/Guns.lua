local guns = {}

local gunUtils = require("utils/GunUtils")
local turretUtils = require("utils/TurretUtils")
local ammoUtils = require("utils/AmmoUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeAmmo = ammoUtils.makeAmmo
local makeShotgunProjectile = projectileUtils.makeShotgunProjectile
local removeEffect = technologyUtils.removeEffect
local addEffectToTech = technologyUtils.addEffectToTech

local makeGun = gunUtils.makeGun


local function gunTurretMkIISheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/gluegun_anim.png",
			priority = "high",
			width = 80,
			height = 72,
			line_length = 16,
			scale=1.5,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0, -0.5},
		    }
		}
	}    
end


local function rifleTurretSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/rifle-turret.png",
			priority = "high",
			width = 34,
			height = 49,
			line_length = 8,
			scale=1,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0, -0.25},
		    }
		}
	}    
end


function guns.enable()
    
    local mortar = makeGun(
	{
	    name = "mortar",
	    icon = "__RampantArsenal__/graphics/icons/mortar.png",
	    order = "e[mortar]-b"
	},
	{
	    type = "stream",
	    ammo_category = "capsule-launcher",
	    cooldown = 350,
	    movement_slow_down_factor = 0.9,
	    damage_modifier = 2,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 1,
	    range = 30,
	    sound = make_heavy_gunshot_sounds()
    })

    local rocketLauncher = makeGun(
	{
	    name = "rocket-launcher",
	    icon = "__RampantArsenal__/graphics/icons/upgraded-rocket-launcher.png",
	    order = "d[rocket-launcher]-b"
	},
	{
	    type = "stream",
	    ammo_category = "rocket",
	    cooldown = 50,
	    movement_slow_down_factor = 0.8,
	    damage_modifier = 1.5,
	    gun_center_shift = {
		north = {0, 0},
		east = {0, 0},
		south = {0, 0},
		west = {0, 0}
	    },
	    gun_barrel_length = 1,
	    range = 27,
	    sound = {
		{
		    filename = "__base__/sound/fight/rocket-launcher.ogg",
		    volume = 0.7
		}
	    }
    })

    local minigun = makeGun(
	{
	    name = "minigun",
	    icon = "__RampantArsenal__/graphics/icons/minigun.png",
	    order = "a[basic-clips]-e[minigun]"
	},
	{
	    type = "projectile",
	    ammo_category = "bullet",
	    cooldown = 3.5,
	    movement_slow_down_factor = 0.7,
	    damage_modifier = 1.2,
	    shell_particle =
		{
		    name = "shell-particle",
		    direction_deviation = 0.1,
		    speed = 0.1,
		    speed_deviation = 0.03,
		    center = {0, 0},
		    creation_distance = -0.6875,
		    starting_frame_speed = 0.4,
		    starting_frame_speed_deviation = 0.1
		},
	    projectile_center = {-0.15625, -0.07812},
	    projectile_creation_distance = 1,
	    range = 20,
	    sound = make_heavy_gunshot_sounds()
    })

    local uraniumShotgunShellAmmo = makeAmmo({
    	    name = "uranium-shotgun",
    	    icon = "__RampantArsenal__/graphics/icons/uranium-shotgun-shell.png",
	    order = "b[shotgun]-d[uranium]",
	    magSize = 10,
	    stackSize = 200,
    	    ammoType = {
    		category = "shotgun-shell",
    		target_type = "direction",
    		clamp_position = true,
    		action =
    		    {
    			{
    			    type = "direct",
    			    action_delivery =
    				{
    				    type = "instant",
    				    source_effects =
    					{
    					    {
    						type = "create-explosion",
    						entity_name = "explosion-gunshot"
    					    }
    					}
    				}
    			},
    			{
    			    type = "direct",
    			    repeat_count = 18,
    			    action_delivery =
    				{
    				    type = "projectile",
    				    projectile = makeShotgunProjectile({
					    name = "uranium",
					    tint = {r=0,g=0.4,b=0,a=0.7},
					    piercingDamage = 50,
					    directionOnly = true,
					    action = {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects ={
							    {
								type = "damage",
								damage = {amount = 20, type = "physical"}
							    }
							}
						    }
					    }
				    }),
    				    starting_speed = 1,
    				    direction_deviation = 0.3,
    				    range_deviation = 0.3,
    				    max_range = 20
    				}
    			}
    		    }
    	    }
    })

    
    local incendiaryShotgunShellAmmo = makeAmmo({
    	    name = "incendiary-shotgun",
    	    icon = "__RampantArsenal__/graphics/icons/incendiary-shotgun-shell.png",
	    order = "b[shotgun]-c[incendiary]",
	    magSize = 10,
	    stackSize = 200,
    	    ammoType = {
    		category = "shotgun-shell",
    		target_type = "direction",
    		clamp_position = true,
    		action =
    		    {
    			{
    			    type = "direct",
    			    action_delivery =
    				{
    				    type = "instant",
    				    source_effects =
    					{
    					    {
    						type = "create-explosion",
    						entity_name = "explosion-gunshot"
    					    }
    					}
    				}
    			},
    			{
    			    type = "direct",
    			    repeat_count = 16,
    			    action_delivery =
    				{
    				    type = "projectile",
    				    projectile = makeShotgunProjectile({
					    name = "incendiary",
					    tint = {r=0.5,g=0.3,b=0,a=0.8},
					    animation = {
						filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
						frame_count = 1,
						width = 3,
						height = 50,
						priority = "high"
					    },
					    action = {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects ={
							    {
								type = "damage",
								damage = {amount = 2, type = "physical"}
							    },
							    {
								type = "damage",
								damage = {amount = 6, type = "fire"}
							    },
							    {
								type = "create-sticker",
								sticker = "fire-sticker"
							    },
							    {
								type = "create-fire",
								entity_name = "fire-flame",
								initial_ground_flame_count = 1
							    }
							}
						    }
					    }
				    }),
    				    starting_speed = 1,
    				    direction_deviation = 0.3,
    				    range_deviation = 0.3,
    				    max_range = 18
    				}
    			}
    		    }
    	    }
    })
    
    local incendiaryMagazineAmmo = makeAmmo({
	    name = "incendiary-magazine",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-rounds-magazine.png",
	    order = "a[basic-clips]-c[incendiary-rounds-magazine]",
	    magSize = 10,
	    stackSize = 200,
	    ammoType = {
		category = "bullet",
		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				source_effects =
				    {
					type = "create-explosion",
					entity_name = "explosion-gunshot"
				    },
				target_effects =
				    {
					{
					    type = "create-fire",
					    entity_name = "fire-flame",
					    initial_ground_flame_count = 1
					},
					{
					    type = "create-sticker",
					    sticker = "fire-sticker"
					},					
					{
					    type = "damage",
					    damage = { amount = 4, type = "physical"}
					},
					{
					    type = "damage",
					    damage = { amount = 12, type = "fire"}
					}
				    }
			    }
		    }
	    }
    })

    local heShotgunShellAmmo = makeAmmo({
    	    name = "he-shotgun",
    	    icon = "__RampantArsenal__/graphics/icons/he-shotgun-shell.png",
	    order = "b[shotgun]-c[he]",
	    magSize = 10,
	    stackSize = 200,
    	    ammoType = {
    		category = "shotgun-shell",
    		target_type = "direction",
    		clamp_position = true,
    		action =
    		    {
    			{
    			    type = "direct",
    			    action_delivery =
    				{
    				    type = "instant",
    				    source_effects =
    					{
    					    {
    						type = "create-explosion",
    						entity_name = "explosion-gunshot"
    					    }
    					}
    				}
    			},
    			{
    			    type = "direct",
    			    repeat_count = 16,
    			    action_delivery =
    				{
    				    type = "projectile",
    				    projectile = makeShotgunProjectile({
					    name = "he",
					    directionOnly = true,
					    tint = {r=0,g=0,b=0.8,a=0.8},
					    animation = {
						filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
						frame_count = 1,
						width = 3,
						height = 50,
						priority = "high"
					    },
					    action = {
						type = "area",
						radius = 1.5,
						action_delivery =
						    {
							type = "instant",
							source_effects =
							    {
								type = "create-explosion",
								entity_name = "explosion-gunshot"
							    },
							target_effects =
							    {
								{
								    type = "create-explosion",
								    entity_name = "explosion"
								},
								{
								    type = "damage",
								    damage = {amount = 4, type = "physical"}
								},
								{
								    type = "damage",
								    damage = {amount = 10, type = "explosion"}
								},
								{
								    type = "push-back",
								    distance = 0.5
								}
							    }
						    }
					    }
				    }),
    				    starting_speed = 1,
    				    direction_deviation = 0.3,
    				    range_deviation = 0.3,
    				    max_range = 18
    				}
    			}
    		    }
    	    }
    })
    
    local heMagazineAmmo = makeAmmo({
	    name = "he-magazine",
	    icon = "__RampantArsenal__/graphics/icons/he-rounds-magazine.png",
	    order = "a[basic-clips]-c[he-rounds-magazine]",
	    magSize = 10,
	    stackSize = 200,
	    ammoType = {
		category = "bullet",
		action =
		    {
			type = "area",
			radius = 1.5,
			action_delivery =
			    {
				type = "instant",
				source_effects =
				    {
					type = "create-explosion",
					entity_name = "explosion-gunshot"
				    },
				target_effects =
				    {
					{
					    type = "create-explosion",
					    entity_name = "explosion"
					},
					{
					    type = "damage",
					    damage = {amount = 4, type = "physical"}
					},
					{
					    type = "damage",
					    damage = {amount = 12, type = "explosion"}
					},
					{
					    type = "push-back",
					    distance = 0.5
					}
				    }
			    }
		    }
	    }
    })

    local bioShotgunShellAmmo = makeAmmo({
    	    name = "bio-shotgun",
    	    icon = "__RampantArsenal__/graphics/icons/bio-shotgun-shell.png",
	    order = "b[shotgun]-c[bio]",
	    magSize = 10,
	    stackSize = 200,
    	    ammoType = {
    		category = "shotgun-shell",
    		target_type = "direction",
    		clamp_position = true,
    		action =
    		    {
    			{
    			    type = "direct",
    			    action_delivery =
    				{
    				    type = "instant",
    				    source_effects =
    					{
    					    {
    						type = "create-explosion",
    						entity_name = "explosion-gunshot"
    					    }
    					}
    				}
    			},
    			{
    			    type = "direct",
    			    repeat_count = 16,
    			    action_delivery =
    				{
    				    type = "projectile",
    				    projectile = makeShotgunProjectile({
					    name = "bio",
					    directionOnly = true,
					    tint = {r=0.5,g=0,b=0.5,a=0.8},
					    animation = {
						filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
						frame_count = 1,
						width = 3,
						height = 50,
						priority = "high"
					    },
					    action = {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects ={
							    {
								type = "damage",
								damage = {amount = 2, type = "physical"}
							    },
							    {
								type = "damage",
								damage = {amount = 6, type = "poison"}
							    },
							    {
								type = "create-sticker",
								sticker = "bullet-toxic-sticker-rampant-arsenal"
							    }
							}
						    }
					    }
				    }),
    				    starting_speed = 1,
    				    direction_deviation = 0.3,
    				    range_deviation = 0.3,
    				    max_range = 18
    				}
    			}
    		    }
    	    }
    })
    
    local bioMagazineAmmo = makeAmmo({
	    name = "bio-magazine",
	    icon = "__RampantArsenal__/graphics/icons/bio-rounds-magazine.png",
	    order = "a[basic-clips]-c[bio-rounds-magazine]",
	    magSize = 10,
	    stackSize = 200,
	    ammoType = {
		category = "bullet",
		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				source_effects =
				    {
					type = "create-explosion",
					entity_name = "explosion-gunshot"
				    },
				target_effects =
				    {
					{
					    type = "create-sticker",
					    sticker = "bullet-toxic-sticker-rampant-arsenal"
					},
					{
					    type = "damage",
					    damage = { amount = 4, type = "physical"}
					},
					{
					    type = "damage",
					    damage = { amount = 12, type = "poison"}
					}
				    }
			    }
		    }
	    }
    })
    
    local mortarRecipe = makeRecipe({
	    name = "mortar",
	    icon = "__RampantArsenal__/graphics/icons/mortar.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 15},
		{"iron-gear-wheel", 5},
		{"copper-plate", 10},
		{"explosives", 5}
	    },
	    result = mortar
    })

    local minigunRecipe = makeRecipe({
	    name = "minigun",
	    icon = "__RampantArsenal__/graphics/icons/minigun.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 10},
		{"iron-gear-wheel", 5},
		{"engine-unit", 3},
		{"electronic-circuit", 5}
	    },
	    result = minigun
    })

    local rocketLauncherRecipe = makeRecipe({
	    name = "rocket-launcher",
	    icon = "__RampantArsenal__/graphics/icons/upgraded-rocket-launcher.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 10},
		{"iron-gear-wheel", 5},
		{"rocket-launcher", 1},
		{"electronic-circuit", 5}
	    },
	    result = rocketLauncher
    })


    local incendiaryMagazineRecipe = makeRecipe({
	    name = "incendiary-magazine",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-rounds-magazine.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-rounds-magazine", 1},
		{"copper-plate", 2},
		{type="fluid", name="light-oil", amount=20}
	    },
	    result = incendiaryMagazineAmmo
    })
    
    local incendiaryShotgunShellRecipe = makeRecipe({
	    name = "incendiary-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-shotgun-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-shotgun-shell", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=20}
	    },
	    result = incendiaryShotgunShellAmmo
    })

    local heMagazineRecipe = makeRecipe({
	    name = "he-magazine",
	    icon = "__RampantArsenal__/graphics/icons/he-rounds-magazine.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"piercing-rounds-magazine", 1},
		{"copper-plate", 2},
		{"explosives", 2}
	    },
	    result = heMagazineAmmo
    })

    
    local heShotgunShellRecipe = makeRecipe({
	    name = "he-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/he-shotgun-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"piercing-shotgun-shell", 1},
		{"steel-plate", 2},
		{"explosives", 2}
	    },
	    result = heShotgunShellAmmo
    })
    
    local bioMagazineRecipe = makeRecipe({
	    name = "bio-magazine",
	    icon = "__RampantArsenal__/graphics/icons/bio-rounds-magazine.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"piercing-rounds-magazine", 1},
		{"copper-plate", 2},
		{"poison-capsule", 1}
	    },
	    result = bioMagazineAmmo
    })

    
    local bioShotgunShellRecipe = makeRecipe({
	    name = "bio-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/bio-shotgun-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"piercing-shotgun-shell", 1},
		{"steel-plate", 1},
		{"poison-capsule", 1}
	    },
	    result = bioShotgunShellAmmo
    })
    
    local uraniumShotgunShellRecipe = makeRecipe({
	    name = "uranium-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/uranium-shotgun-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"piercing-shotgun-shell", 1},
		{"uranium-238", 1},
		{"steel-plate", 1}		
	    },
	    result = uraniumShotgunShellAmmo
    })
    
    addEffectToTech("explosives",
		    {
			type = "unlock-recipe",
			recipe = mortarRecipe
    })

    addEffectToTech("military-3",
		    {
			type = "unlock-recipe",
			recipe = minigunRecipe
    })    

    addEffectToTech("uranium-ammo",
		    {
			type = "unlock-recipe",
			recipe = uraniumShotgunShellRecipe
    })

    addEffectToTech("incendiary-bullets",
		    {
			type = "unlock-recipe",
			recipe = incendiaryMagazineRecipe
    })

    addEffectToTech("incendiary-shotgun-shells",
		    {
			type = "unlock-recipe",
			recipe = incendiaryShotgunShellRecipe
    })
    
    addEffectToTech("he-bullets",
		    {
			type = "unlock-recipe",
			recipe = heMagazineRecipe
    })

    addEffectToTech("he-shotgun-shells",
		    {
			type = "unlock-recipe",
			recipe = heShotgunShellRecipe
    })

    addEffectToTech("bio-bullets",
		    {
			type = "unlock-recipe",
			recipe = bioMagazineRecipe
    })

    addEffectToTech("bio-shotgun-shells",
		    {
			type = "unlock-recipe",
			recipe = bioShotgunShellRecipe
    })

    local gunTurretAttributes = {
	name = "gun",
	icon = "__RampantArsenal__/graphics/icons/gluegun-icon.png",
	order = "b[turret]-a[sgun-turret]",
	miningTime = 1,
	health = 1400,
	collisionBox = {{-1.2, -1.2 }, {1.2, 1.2}},
	selectionBox = {{-1.4, -1.4 }, {1.4, 1.4}},
	foldedAnimation = gunTurretMkIISheet(),
	foldingAnimation = gunTurretMkIISheet(),
	preparedAnimation = gunTurretMkIISheet(),
	preparingAnimation = gunTurretMkIISheet()
    }
    local gunTurret,gunTurretItem = makeAmmoTurret(gunTurretAttributes,
						   {
						       type = "projectile",
						       ammo_category = "bullet",
						       cooldown = 3.3,
						       projectile_creation_distance = 2,
						       damage_modifier = 2,
						       projectile_center = {0, 0},
						       range = 21,
						       sound = make_heavy_gunshot_sounds(),
    })
    
    local gunTurretRecipe = makeRecipe({
	    name = "gun-turret",
	    icon = "__RampantArsenal__/graphics/icons/gluegun-icon.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"gun-turret", 1},
		{"advanced-circuit", 5},
		{"steel-plate", 15}		
	    },
	    result = gunTurretItem
    })

    local rifleTurretAttributes = {
	name = "rifle",
	icon = "__RampantArsenal__/graphics/icons/rifle-turret.png",
	miningTime = 1,
	health = 200,
	order = "b[turret]-a[aun-turret]",
	collisionBox = {{-0.4, -0.4 }, {0.4, 0.4}},
	selectionBox = {{-0.5, -0.5 }, {0.5, 0.5}},
	foldedAnimation = rifleTurretSheet(),
	foldingAnimation = rifleTurretSheet(),
	preparedAnimation = rifleTurretSheet(),
	preparingAnimation = rifleTurretSheet()
    }
    local rifleTurret,rifleTurretItem = makeAmmoTurret(rifleTurretAttributes,
						       {
							   type = "projectile",
							   ammo_category = "bullet",
							   cooldown = 16,
							   projectile_creation_distance = 1,
							   damage_modifier = 1.2,
							   projectile_center = {0, 0.2},
							   range = 16,
							   sound = make_heavy_gunshot_sounds(),
    })
    
    makeRecipe({
	    name = "rifle-turret",
	    icon = "__RampantArsenal__/graphics/icons/rifle-turret.png",
	    enabled = true,
	    category = "crafting",
	    ingredients = {
		{"copper-plate", 10},
		{"wood", 5},
		{"iron-plate", 15}
	    },
	    result = rifleTurretItem
    })


    addEffectToTech("turrets-2",
		    {
			type = "unlock-recipe",
			recipe = gunTurretRecipe
    })

    addEffectToTech("gun-turret-damage-1",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.1
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.1
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.1
    }})

    addEffectToTech("gun-turret-damage-2",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.1
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.1
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.1
    }})

    addEffectToTech("gun-turret-damage-3",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.2
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.2
    }})

    addEffectToTech("gun-turret-damage-4",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.2
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.2
    }})

    addEffectToTech("gun-turret-damage-5",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.2
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.2
    }})

    addEffectToTech("gun-turret-damage-6",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.4
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.4
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.4
			}
    })

    addEffectToTech("gun-turret-damage-7",
		    {
			{
			    type = "turret-attack",
			    turret_id = rifleTurret,
			    modifier = 0.7
			},
                        {
			    type = "turret-attack",
			    turret_id = "gun-turret",
			    modifier = 0.7
			},
			{
			    type = "turret-attack",
			    turret_id = gunTurret,
			    modifier = 0.7
    }})

    
    removeEffect("military-3", "unlock-recipe", "poison-capsule")
    removeEffect("military-3", "unlock-recipe", "slowdown-capsule")

    addEffectToTech("military-2",
		    {
			{
			    type = "unlock-recipe",
			    recipe = "poison-capsule"
			},
			{
			    type = "unlock-recipe",
			    recipe = "slowdown-capsule"
			}
    })

    removeEffect("military-4", "unlock-recipe", "piercing-shotgun-shell")
    removeEffect("physical-projectile-damage-1", "turret-attack", "gun-turret")
    removeEffect("physical-projectile-damage-2", "turret-attack", "gun-turret")
    removeEffect("physical-projectile-damage-3", "turret-attack", "gun-turret")
    removeEffect("physical-projectile-damage-4", "turret-attack", "gun-turret")
    removeEffect("physical-projectile-damage-5", "turret-attack", "gun-turret")
    removeEffect("physical-projectile-damage-6", "turret-attack", "gun-turret")
    removeEffect("physical-projectile-damage-7", "turret-attack", "gun-turret")

    addEffectToTech("military-3",
		    {
			type = "unlock-recipe",
			recipe = "piercing-shotgun-shell"
    })

    addEffectToTech("military-4",
		    {
			type = "unlock-recipe",
			recipe = rocketLauncherRecipe
    })
end

return guns
