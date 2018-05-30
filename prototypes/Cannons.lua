local cannons = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local streamUtils = require("utils/StreamUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")

local makeCannonProjectile = projectileUtils.makeCannonProjectile
local makeAmmo = ammoUtils.makeAmmo
local makeStream = streamUtils.makeStream
local makeFluidTurret = turretUtils.makeFluidTurret
local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
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
    local cannonAttributes = {
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
    local cannonTurret,cannonTurretItem = makeAmmoTurret(cannonAttributes,
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

    local rapidCannonAttributes = {
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
    local rapidCannonTurret,rapidCannonTurretItem = makeAmmoTurret(rapidCannonAttributes, {
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
    
    local advFlamethrowerAttributes = {
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
    local suppressionCannonTurret,suppressionCannonTurretItem = makeFluidTurret(advFlamethrowerAttributes,
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
														    name = advFlamethrowerAttributes.name,
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
    
    local shotgunAttributes = {
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
    local shotgunTurret,shotgunTurretItem = makeAmmoTurret(shotgunAttributes, {
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

    addEffectToTech("cannon-turret-1",
		    {
			type = "unlock-recipe",
			recipe = cannonRecipe,
    })

    addEffectToTech("cannon-turret-2",
		    {
			type = "unlock-recipe",
			recipe = rapidCannonRecipe,
    })

    addEffectToTech("shotgun",
		    {
			type = "unlock-recipe",
			recipe = shotgunTurretRecipe,
    })

    addEffectToTech("flamethrower-2",
		    {
			type = "unlock-recipe",
			recipe = suppresionCannonRecipe,
    })

    addEffectToTech("shotgun-turret-damage-1",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.1
    })

    addEffectToTech("shotgun-turret-damage-2",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.1
    })

    addEffectToTech("shotgun-turret-damage-3",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.2
    })

    addEffectToTech("shotgun-turret-damage-4",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.3
    })
    
    addEffectToTech("shotgun-turret-damage-5",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.3
    })

    addEffectToTech("shotgun-turret-damage-6",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.4
    })

    addEffectToTech("shotgun-turret-damage-7",
		    {
			type = "turret-attack",
			turret_id = shotgunTurret,
			modifier = 0.2
    })

    
    addEffectToTech("cannon-turret-damage-1",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.1
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.1
			}
    })

    addEffectToTech("cannon-turret-damage-2",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.1
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.1
			}
    })

    addEffectToTech("cannon-turret-damage-3",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.2
			}
    })

    addEffectToTech("cannon-turret-damage-4",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.3
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.3
			}
    })
    
    addEffectToTech("cannon-turret-damage-5",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.3
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.3
			}
    })

    addEffectToTech("cannon-turret-damage-6",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.4
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.4
			}
    })

    addEffectToTech("cannon-turret-damage-7",
		    {
			{
			    type = "turret-attack",
			    turret_id = rapidCannonTurret,
			    modifier = 0.2
			},
			{
			    type = "turret-attack",
			    turret_id = cannonTurret,
			    modifier = 0.2
			}
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
    
    local incendiaryCannonShellAmmo = makeAmmo({
    	    name = "incendiary-cannon-shell",
    	    icon = "__RampantArsenal__/graphics/icons/incendiary-cannon-shell.png",
	    order = "d[cannon-shell]-c[incendiary]",
	    magSize = 1,
	    stackSize = 200,
    	    ammoType = {
    		category = "cannon-shell",
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
    			    action_delivery =
    				{
    				    type = "projectile",
				    starting_speed = 1,				    
    				    projectile = makeCannonProjectile({
					    name = "incendiary-cannon",
					    piercingDamage = 100,
					    animation = {
						filename = "__base__/graphics/entity/bullet/bullet.png",
						frame_count = 1,
						width = 3,
						height = 50,
						priority = "high"
					    },
					    action =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "damage",
									damage = {amount = 100 , type = "physical"}
								    },
								    {
									type = "damage",
									damage = {amount = 600 , type = "fire"}
								    },
								    {
									type = "damage",
									damage = {amount = 100 , type = "explosion"}
								    },
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    },
								    {
									type = "create-sticker",
									sticker = "small-fire-sticker-rampant-arsenal"
								    },
								    {
									type = "create-fire",
									entity_name = "fire-flame",
									initial_ground_flame_count = 4
								    }
								}
							}
						},
					    finalAction =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    },
								    {
									type = "nested-result",
									action =
									    {
										type = "area",
										radius = 4,
										action_delivery =
										    {
											type = "instant",
											target_effects =
											    {
												{
												    type = "create-fire",
												    entity_name = "fire-flame",
												    initial_ground_flame_count = 4
												},
												{
												    type = "create-sticker",
												    sticker = "small-fire-sticker-rampant-arsenal"
												}
											    }
										    }
									    }
								    },
								    {
									type = "create-entity",
									entity_name = "small-scorchmark",
									check_buildability = true
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

    local incendiaryCannonShellRecipe = makeRecipe({
	    name = "incendiary-cannon-shell",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-cannon-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = incendiaryCannonShellAmmo,
    })

    addEffectToTech("incendiary-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = incendiaryCannonShellRecipe,
    })


    local heCannonShellAmmo = makeAmmo({
    	    name = "he-cannon-shell",
    	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    order = "d[cannon-shell]-c[he]",
	    magSize = 1,	    
	    stackSize = 200,
    	    ammoType = {
    		category = "cannon-shell",
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
    			    action_delivery =
    				{
    				    type = "projectile",
				    starting_speed = 1,
				    max_range = 30,
				    direction_deviation = 0.1,
				    range_deviation = 0.1,
				    min_range = 5,
    				    projectile = makeCannonProjectile({
					    name = "he-cannon",
					    piercingDamage = 100,
					    animation = {
						filename = "__base__/graphics/entity/bullet/bullet.png",
						frame_count = 1,
						width = 3,
						height = 50,
						priority = "high"
					    },
					    action =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "damage",
									damage = {amount = 200 , type = "physical"}
								    },
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    }
								}
							}
						},
					    finalAction =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    },
								    {
									type = "nested-result",
									action =
									    {
										type = "area",
										radius = 9,
										action_delivery =
										    {
											type = "instant",
											target_effects =
											    {
												{
												    type = "damage",
												    damage = {amount = 800, type = "explosion"}
												},
												{
												    type = "create-entity",
												    entity_name = "big-explosion"
												}
											    }
										    }
									    }
								    },
								    {
									type = "create-entity",
									entity_name = "small-scorchmark",
									check_buildability = true
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
    
    local heCannonShellRecipe = makeRecipe({
	    name = "he-cannon-shell",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = heCannonShellAmmo,
    })

    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = heCannonShellRecipe,
    })

    local bioCannonShellAmmo = makeAmmo({
    	    name = "bio-cannon-shell",
    	    icon = "__RampantArsenal__/graphics/icons/bio-cannon-shell.png",
	    order = "d[cannon-shell]-c[fbio]",
	    magSize = 1,
	    stackSize = 200,
    	    ammoType = {
    		category = "cannon-shell",
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
    			    action_delivery =
    				{
    				    type = "projectile",
				    starting_speed = 1,				    
    				    projectile = makeCannonProjectile({
					    name = "bio-cannon",
					    piercingDamage = 100,
					    animation = {
						filename = "__base__/graphics/entity/bullet/bullet.png",
						frame_count = 1,
						width = 3,
						height = 50,
						priority = "high"
					    },
					    action =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "damage",
									damage = {amount = 100 , type = "physical"}
								    },
								    {
									type = "damage",
									damage = {amount = 600 , type = "poison"}
								    },
								    {
									type = "damage",
									damage = {amount = 100 , type = "explosion"}
								    },
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    }
								}
							}
						},
					    finalAction =
						{
						    type = "direct",
						    action_delivery =
							{
							    type = "instant",
							    target_effects =
								{
								    {
									type = "create-entity",
									entity_name = "big-explosion"
								    },
								    {
									type = "nested-result",
									action =
									    {
										type = "area",
										radius = 7.5,
										action_delivery =
										    {
											type = "instant",
											target_effects =
											    {											
												{
												    type = "create-sticker",
												    sticker = "small-toxic-sticker-rampant-arsenal"
												}
											    }
										    }
									    }
								    },
								    {
									type = "create-entity",
									entity_name = "small-scorchmark",
									check_buildability = true
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
    
    local bioCannonShellRecipe = makeRecipe({
	    name = "bio-cannon-shell",
	    icon = "__RampantArsenal__/graphics/icons/bio-cannon-shell.png",
	    enabled = false,
	    category = "crafting-with-fluid",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"steel-plate", 1},
		{type="fluid", name="light-oil", amount=15}
	    },
	    result = bioCannonShellAmmo,
    })

    addEffectToTech("bio-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = bioCannonShellRecipe,
    })

    local targetEffects = data.raw["projectile"]["uranium-cannon-projectile"].action.action_delivery.target_effects
    targetEffects[1].damage.amount = targetEffects[1].damage.amount * 2
    targetEffects[2].damage.amount = targetEffects[2].damage.amount * 2

    targetEffects = data.raw["projectile"]["explosive-uranium-cannon-projectile"].action.action_delivery.target_effects
    targetEffects[1].damage.amount = targetEffects[1].damage.amount * 2

    local action = data.raw["projectile"]["explosive-uranium-cannon-projectile"].final_action.action_delivery.target_effects[2].action
    action.radius = action.radius * 2
    targetEffects = action.action_delivery.target_effects
    targetEffects[1].damage.amount = targetEffects[1].damage.amount * 2
end


return cannons
