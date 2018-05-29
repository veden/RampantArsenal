local guns = {}

local gunUtils = require("utils/GunUtils")
local turretUtils = require("utils/TurretUtils")
local ammoUtils = require("utils/AmmoUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local streamUtils = require("utils/StreamUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeStream = streamUtils.makeStream
local makeFluidTurret = turretUtils.makeFluidTurret
local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeAmmo = ammoUtils.makeAmmo
local makeShotgunProjectile = projectileUtils.makeShotgunProjectile
local makeTechnology = technologyUtils.makeTechnology
local addEffectToTech = technologyUtils.addEffectToTech

local makeGun = gunUtils.makeGun

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
    
    local heMagazineAmmo = makeAmmo({
	    name = "he-magazine",
	    icon = "__RampantArsenal__/graphics/icons/he-rounds-magazine.png",
	    order = "a[basic-clips]-c[he-rounds-magazine]",
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

    local bioShotgunShellAmmo = makeAmmo({
    	    name = "bio-shotgun",
    	    icon = "__RampantArsenal__/graphics/icons/bio-shotgun-shell.png",
	    order = "b[shotgun]-c[bio]",
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
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "poison-cloud"
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
					    type = "create-entity",
					    show_in_tooltip = true,
					    entity_name = "poison-cloud"
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

    local incendiaryMagazineRecipe = makeRecipe({
	    name = "incendiary-magazine",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-rounds-magazine.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-rounds-magazine", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
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
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = incendiaryShotgunShellAmmo
    })

    local heMagazineRecipe = makeRecipe({
	    name = "he-magazine",
	    icon = "__RampantArsenal__/graphics/icons/he-rounds-magazine.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-rounds-magazine", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = heMagazineAmmo
    })

    
    local heShotgunShellRecipe = makeRecipe({
	    name = "he-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/he-shotgun-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-shotgun-shell", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = heShotgunShellAmmo
    })
    
    local bioMagazineRecipe = makeRecipe({
	    name = "bio-magazine",
	    icon = "__RampantArsenal__/graphics/icons/bio-rounds-magazine.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-rounds-magazine", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = bioMagazineAmmo
    })

    
    local bioShotgunShellRecipe = makeRecipe({
	    name = "bio-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/bio-shotgun-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"piercing-shotgun-shell", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = bioShotgunShellAmmo
    })
    
    local uraniumShotgunShellRecipe = makeRecipe({
	    name = "uranium-shotgun-shell",
	    icon = "__RampantArsenal__/graphics/icons/uranium-shotgun-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
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
   
end

return guns
