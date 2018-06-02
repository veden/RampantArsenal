local rockets = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")

local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeRocketProjectile = projectileUtils.makeRocketProjectile
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local function rocketSheetMk1()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/rocket-mk1-sheet.png",
			priority = "high",
			width = 72,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.35, 0},
		    }
		}
	}
    
end

local function rocketSheetMk2()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/rocket-mk2-sheet.png",
			priority = "high",
			width = 88,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.1, -0.15},
		    }
		}
	}
    
end

function rockets.enable()

    local entity = {
	name = "rocket",
	icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
	miningTime = 1,
	health = 800,
	order = "b[turret]-a[zzzracket-turret]",
	collisionBox = {{-0.35, -0.85}, {0.35, 0.85}},
	selectionBox = {{-0.5, -1}, {0.5, 1}},
	foldedAnimation = rocketSheetMk1(),
	foldingAnimation = rocketSheetMk1(),
	preparedAnimation = rocketSheetMk1(),
	preparingAnimation = rocketSheetMk1()
    }
    local rocketTurret, rocketTurretItem = makeAmmoTurret(entity,
							  {
							      type = "projectile",
							      ammo_category = "rocket",
							      cooldown = 150,
							      projectile_creation_distance = 1.39375,
							      projectile_center = {0, -0.0875},
							      range = 45,
							      sound = make_heavy_gunshot_sounds(),
    })

    local entity1 = {
	name = "rapid-rocket",
	icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
	miningTime = 1,
	health = 1800,
	order = "b[turret]-a[zzzrzcket-turret]",
	foldedAnimation = rocketSheetMk2(),
	foldingAnimation = rocketSheetMk2(),
	preparedAnimation = rocketSheetMk2(),
	preparingAnimation = rocketSheetMk2()
    }
    local rapidRocketTurret, rapidRocketTurretItem = makeAmmoTurret(entity1, {
									type = "projectile",
									ammo_category = "rocket",
									cooldown = 50,
									projectile_creation_distance = 1.39375,
									projectile_center = {0, -0.0875},
									range = 35,
									sound = make_heavy_gunshot_sounds(),
    })

    local rocketTurretRecipe = makeRecipe({
	    name = "rocket-turret",
	    icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
	    enabled = false,
	    ingredients = {
		{"electronic-circuit", 20},
		{"steel-plate", 10},
		{"iron-gear-wheel", 15}
	    },
	    result = rocketTurretItem,
    })

    local rapidRocketRecipe = makeRecipe({
	    name = "rapid-rocket",
	    icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 30},
		{"advanced-circuit", 30},
		{"engine-unit", 10},
		{"copper-plate", 20}
	    },
	    result = rapidRocketTurretItem,
    })

    addEffectToTech("rocket-turret-1",
		    {
			type = "unlock-recipe",
			recipe = rocketTurretRecipe,
    })
    

    addEffectToTech("rocket-turret-2",
		    {
			type = "unlock-recipe",
			recipe = rapidRocketRecipe,
    })
    

    local incendiaryRocketAmmo = makeAmmo({
    	    name = "incendiary-rocket",
    	    icon = "__RampantArsenal__/graphics/icons/incendiary-rocket.png",
	    order = "d[rocket-launcher]-b[incendiary]",
	    magSize = 1,
	    stackSize = 200,
    	    ammoType = {
    		category = "rocket",
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
    			    action_delivery =
    				{
    				    type = "projectile",
				    starting_speed = 0.1,				    
    				    projectile = makeRocketProjectile({
					    name = "incendiary",
					    action =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "nested-result",
									affects_target = true,
									action =
									    {
										type = "area",
										radius = 10,
										action_delivery =
										    {
											type = "instant",
											target_effects =
											    {
												{
												    type = "create-fire",
												    entity_name = "fire-flame",
												    initial_ground_flame_count = 2
												},
												{
												    type = "create-sticker",
												    sticker = "small-fire-sticker-rampant-arsenal"
												},
												{
												    type = "damage",
												    damage = {amount = 400 , type = "fire"},
												    apply_damage_to_trees = false
												},
												{
												    type = "damage",
												    damage = {amount = 50 , type = "explosion"},
												    apply_damage_to_trees = false
												}
											    }
										    }
									    }
								    },
								    {
									type = "create-entity",
									entity_name = "explosion"
								    }
								}
							}
						}
				    })
    				}
    			}
    		    }
    	    }
    })
    
    local incendiaryRocketRecipe = makeRecipe({
	    name = "incendiary-rocket",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-rocket.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"explosive-rocket", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=40}
	    },
	    result = incendiaryRocketAmmo,
    })

    addEffectToTech("incendiary-rockets",
		    {
			type = "unlock-recipe",
			recipe = incendiaryRocketRecipe,
    })

    local heRocketAmmo = makeAmmo({
    	    name = "he-rocket",
    	    icon = "__RampantArsenal__/graphics/icons/he-rocket.png",
	    order = "d[rocket-launcher]-b[he]",
	    magSize = 1,
	    stackSize = 200,
    	    ammoType = {
    		category = "rocket",
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
    			    action_delivery =
    				{
    				    type = "projectile",
				    starting_speed = 0.1,				    
    				    projectile = makeRocketProjectile({
					    name = "he",
					    action =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "nested-result",
									affects_target = true,
									action =
									    {
										type = "area",
										radius = 12,
										action_delivery =
										    {
											type = "instant",
											target_effects =
											    {
												{
												    type = "push-back",
												    distance = 1
												},
												{
												    type = "damage",
												    damage = {amount = 650 , type = "explosion"}
												}
											    }
										    }
									    }
								    },
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    }								    
								}
							}
						}
				    })
    				}
    			}
    		    }
    	    }
    })
    
    local heRocketRecipe = makeRecipe({
	    name = "he-rocket",
	    icon = "__RampantArsenal__/graphics/icons/he-rocket.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-rocket", 1},
		{"steel-plate", 1},
		{"explosives", 6}
	    },
	    result = heRocketAmmo,
    })

    addEffectToTech("he-rockets",
		    {
			type = "unlock-recipe",
			recipe = heRocketRecipe,
    })

    local bioRocketAmmo = makeAmmo({
    	    name = "bio-rocket",
    	    icon = "__RampantArsenal__/graphics/icons/bio-rocket.png",
	    order = "d[rocket-launcher]-b[fbio]",
	    magSize = 1,
	    stackSize = 200,
    	    ammoType = {
    		category = "rocket",
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
    			    action_delivery =
    				{
    				    type = "projectile",
				    starting_speed = 0.1,				    
    				    projectile = makeRocketProjectile({
					    name = "bio",
					    action =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "nested-result",
									affects_target = true,
									action =
									    {
										type = "area",
										radius = 11,
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
												    damage = {amount = 400 , type = "poison"}
												},
												{
												    type = "damage",
												    damage = {amount = 50 , type = "explosion"}
												}
											    }
										    }
									    }
								    },
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    }
								}
							}
						}
				    })
    				}
    			}
    		    }
    	    }
    })
    
    local bioRocketRecipe = makeRecipe({
	    name = "bio-rocket",
	    icon = "__RampantArsenal__/graphics/icons/bio-rocket.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"explosive-rocket", 1},
		{"steel-plate", 1},
		{"poison-capsule", 2}
	    },
	    result = bioRocketAmmo,
    })

    addEffectToTech("bio-rockets",
		    {
			type = "unlock-recipe",
			recipe = bioRocketRecipe,
    })
    
    addEffectToTech("rocket-turret-damage-1",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.1
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.1
			}
    })

    addEffectToTech("rocket-turret-damage-2",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.1
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.1
			}
    })

    addEffectToTech("rocket-turret-damage-3",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.2
			}
    })

    addEffectToTech("rocket-turret-damage-4",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.3
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.3
			}
    })
    
    addEffectToTech("rocket-turret-damage-5",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.3
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.3
			}
    })

    addEffectToTech("rocket-turret-damage-6",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.4
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.4
			}
    })

    addEffectToTech("rocket-turret-damage-7",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidRocketTurret,
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = rocketTurret,
			    modifier = 0.2
			}
    })
end

return rockets
