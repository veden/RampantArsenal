local lasers = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeLaserProjectile = projectileUtils.makeLaserProjectile
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local makeElectricTurret = turretUtils.makeElectricTurret

local function make_laser_beam()
    local result =
        {
            type = "beam",
            flags = {"not-on-map"},
            width = 0.5,
            damage_interval = 20,
            random_target_offset = true,
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
                                        damage = { amount = 10, type = "laser"}
                                    }
                                }
                        }
                },
            head =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-body.png",
                    flags = {"mipmap"},
                    line_length = 8,
                    width = 64,
                    height = 12,
                    frame_count = 8,
                    scale = 1,
                    animation_speed = 0.5,
                    tint = {r=0.0,g=0.8,b=0.9,a=1},
                    blend_mode = laser_beam_blend_mode
                },
            tail =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-end.png",
                    flags = { "no-crop", "mipmap" },
                    width = 110,
                    height = 62,
                    frame_count = 8,
                    shift = util.by_pixel(11.5, 1),
                    scale = 1,
                    animation_speed = 0.5,
                    tint = {r=0.0,g=0.8,b=0.9,a=1},                    
                    blend_mode = laser_beam_blend_mode
                },
            body =
                {
                    {
                        filename = "__base__/graphics/entity/laser-turret/hr-laser-body.png",
                        flags = {"mipmap"},
                        line_length = 8,
                        width = 64,
                        height = 12,
                        frame_count = 8,
                        scale = 1,
                        animation_speed = 0.5,
                        tint = {r=0.0,g=0.7,b=0.9,a=1},
                        blend_mode = laser_beam_blend_mode
                    }
                }
        }

    result.working_sound =
        {
            {
                filename = "__base__/sound/fight/electric-beam.ogg",
                volume = 0.7
            }
        }
    result.name = "laser-beam-rampant-arsenal"
    data:extend({
            result
    })
    
    return result.name
end

local function laser_turret_extension(inputs)
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-raising.png",
            priority = "medium",
            width = 66,
            height = 64,
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            tint = {r=0.5,g=0.7,b=0.7,a=1},
            direction_count = 4,
            shift = util.by_pixel(0, -37),
            scale = 2,
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-raising.png",
                    priority = "medium",
                    width = 130,
                    height = 126,
                    tint = {r=0.5,g=0.7,b=0.7,a=1},
                    frame_count = inputs.frame_count and inputs.frame_count or 15,
                    line_length = inputs.line_length and inputs.line_length or 0,
                    run_mode = inputs.run_mode and inputs.run_mode or "forward",
                    axially_symmetrical = false,
                    direction_count = 4,
                    shift = util.by_pixel(0, -37.5),
                    scale = 1
                }
        }
end

local function laser_turret_extension_shadow(inputs)
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-shadow.png",
            width = 92,
            height = 50,
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            direction_count = 4,
            draw_as_shadow = true,
            shift = util.by_pixel(47, 3),
            scale = 2,  
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-raising-shadow.png",
                    width = 182,
                    height = 96,
                    frame_count = inputs.frame_count and inputs.frame_count or 15,
                    line_length = inputs.line_length and inputs.line_length or 0,
                    run_mode = inputs.run_mode and inputs.run_mode or "forward",
                    axially_symmetrical = false,
                    direction_count = 4,
                    draw_as_shadow = true,
                    shift = util.by_pixel(47, 2.5),
                    scale = 1
                }
        }
end

local function laser_turret_extension_mask(inputs)
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-raising-mask.png",
            flags = { "mask" },
            width = 44,
            height = 40,
            frame_count = inputs.frame_count and inputs.frame_count or 15,
            line_length = inputs.line_length and inputs.line_length or 0,
            run_mode = inputs.run_mode and inputs.run_mode or "forward",
            axially_symmetrical = false,
            apply_runtime_tint = true,
            direction_count = 4,
            shift = util.by_pixel(0, -59),
            scale = 2,
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-raising-mask.png",
                    flags = { "mask" },
                    width = 86,
                    height = 80,
                    frame_count = inputs.frame_count and inputs.frame_count or 15,
                    line_length = inputs.line_length and inputs.line_length or 0,
                    run_mode = inputs.run_mode and inputs.run_mode or "forward",
                    axially_symmetrical = false,
                    apply_runtime_tint = true,
                    direction_count = 4,
                    shift = util.by_pixel(0, -59),
                    scale = 1
                }
        }
end

local function laser_turret_shooting()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting.png",
            line_length = 8,
            width = 64,
            height = 60,
            frame_count = 1,
            tint = {r=0.5,g=0.7,b=0.7,a=1},
            direction_count = 64,
            shift = util.by_pixel(0, -35),
            scale = 2,    
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-shooting.png",
                    line_length = 8,
                    width = 126,
                    height = 120,
                    tint = {r=0.5,g=0.7,b=0.7,a=1},                    
                    frame_count = 1,
                    direction_count = 64,
                    shift = util.by_pixel(0, -35),
                    scale = 1
                }
        }
end

local function laser_turret_shooting_glow()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-light.png",
            line_length = 8,
            width = 62,
            height = 58,
            frame_count = 1,
            direction_count = 64,
            blend_mode = "additive",
            shift = util.by_pixel(0, -35),
            scale = 2,    
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-shooting-light.png",
                    line_length = 8,
                    width = 122,
                    height = 116,
                    frame_count = 1,
                    direction_count = 64,
                    shift = util.by_pixel(-0.5, -35),
                    blend_mode = "additive",
                    scale = 1
                }
        }
end

local function laser_turret_shooting_mask()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-mask.png",
            flags = { "mask" },
            line_length = 8,
            width = 46,
            height = 42,
            frame_count = 1,
            apply_runtime_tint = true,
            direction_count = 64,
            shift = util.by_pixel(0, -53),
            scale = 2,
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-shooting-mask.png",
                    flags = { "mask" },
                    line_length = 8,
                    width = 92,
                    height = 80,
                    frame_count = 1,
                    apply_runtime_tint = true,
                    direction_count = 64,
                    shift = util.by_pixel(0, -53.5),
                    scale = 1
                }
        }
end

local function laser_turret_shooting_shadow()
    return
        {
            filename = "__base__/graphics/entity/laser-turret/laser-turret-shooting-shadow.png",
            line_length = 8,
            width = 86,
            height = 46,
            frame_count = 1,
            direction_count = 64,
            draw_as_shadow = true,
            shift = util.by_pixel(51, 2),
            scale = 2,    
            hr_version =
                {
                    filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-shooting-shadow.png",
                    line_length = 8,
                    width = 170,
                    height = 92,
                    frame_count = 1,
                    direction_count = 64,
                    draw_as_shadow = true,
                    shift = util.by_pixel(50.5, 2.5),
                    scale = 1
                }
        }
end


local function advancedLaserSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/advanced-laser-sheet.png",
			priority = "high",
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.5, -1.6},
		    },
		    {
			filename = "__RampantArsenal__/graphics/entities/advanced-laser-sheet-mask.png",
			flags = { "mask" },
			width = 256,
			height = 256,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			apply_runtime_tint = true,
			frame_count = 1,
			shift = {0.5, -1.6},
		    }
		}
	}
end


local function lightningTowerSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/r1_sheet.png",
			priority = "high",
			width = 96,
			height = 80,
			line_length = 16,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0.45, -0.25},
		    }
		}
	}

end


function lasers.enable()
    make_laser_beam()
    
    local entity = {
	name = "advanced-laser",
	icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
	miningTime = 1,
	health = 2000,
	collisionBox = {{-1.75, -1.75 }, {1.75, 1.75}},
	selectionBox = {{-2, -2 }, {2, 2}},
	hasBaseDirection = true,
	order = "b[turret]-b[zzlaser-turret]",
	energySource = {
	    type = "electric",
	    buffer_capacity = "439MJ",
	    input_flow_limit = "1000MW",
	    drain = "150kW",
	    usage_priority = "primary-input"
	},
	foldedAnimation = advancedLaserSheet(),
	foldingAnimation = advancedLaserSheet(),
	preparedAnimation = advancedLaserSheet(),
	preparingAnimation = advancedLaserSheet(),
        rotationSpeed = 0.002,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local _, advancedElectricTurretItem = makeElectricTurret(entity, {
								 type = "projectile",
								 ammo_category = "electric",
								 cooldown = 120,
								 projectile_center = {-0.09375, -0.2},
								 turn_range = 0.35,
								 projectile_creation_distance = 13,
								 range = 42,
								 min_range = 13,
								 damage_modifier = 7,
								 ammo_type =
								     {
									 type = "projectile",
									 category = "laser-turret",
									 direction_deviation = 0.1,
									 range_deviation = 0.1,
									 clamp_position = true,
									 target_type = "position",
									 energy_consumption = "438MJ",
									 action =
									     {
										 {
										     type = "direct",
										     action_delivery =
											 {
											     {
												 type = "projectile",
												 projectile = makeLaserProjectile({
													 name = entity.name,
													 acceleration = 1,
													 piercingDamage = 2000,
													 tint = {r=0.8, g=0.0, b=0.0,a=0.9},
													 action = {
													     type = "area",
													     radius = 5,
													     action_delivery =
														 {
														     type = "instant",
														     target_effects =
															 {
															     {
																 type = "damage",
																 damage = {amount = 200 , type = "laser"}
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
													 finalAction = {
													     type = "direct",
													     action_delivery =
														 {
														     type = "instant",
														     target_effects =
															 {
															     {
																 type = "create-entity",
																 entity_name = "small-scorchmark",
																 check_buildability = true
															     },
															     {
																 type = "create-entity",
																 entity_name = "big-artillery-explosion",
																 check_buildability = true
															     }
															 }
														 }
													 }
												 }),
												 starting_speed = 0.5
											     }
											 }
										 }
									     }
								     },
								 sound = make_laser_sounds()
    })

    local entity1 = {
	name = "lightning",
	icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
	miningTime = 1,
	health = 1200,
        hasBaseDirection = true,
	energySource = {
	    type = "electric",
	    buffer_capacity = "45MJ",
	    input_flow_limit = "150MW",
	    drain = "50kW",
	    usage_priority = "primary-input"
	},
	order = "b[turret]-b[zlaser-turret]",
	collisionBox = {{-0.35, -0.85}, {0.35, 0.85}},
	selectionBox = {{-0.5, -1}, {0.5, 1}},
	foldedAnimation = lightningTowerSheet(),
	foldingAnimation = lightningTowerSheet(),
	preparedAnimation = lightningTowerSheet(),
	preparingAnimation = lightningTowerSheet(),
        rotationSpeed = 0.010,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local _, lightningTowerTurretItem = makeElectricTurret(entity1, {
							       type = "projectile",
							       ammo_category = "electric",
							       cooldown = 80,
							       range = 23,
                                                               turn_range = 0.45,
                                                               min_range = 8,
							       projectile_creation_distance = 1,
                                                               damage_modifier = 18,
                                                               piercingDamage = 0,
							       ammo_type =
								   {
								       category = "laser-turret",
								       energy_consumption = "20MJ",
                                                                       type = "projectile",
                                                                       direction_deviation = 0.1,
                                                                       range_deviation = 0.1,
                                                                       clamp_position = true,
                                                                       target_type = "position",
								       action =
                                                                           
									   {
									       type = "direct",
                                                                               action_delivery =
                                                                                   {
                                                                                       {
                                                                                           type = "projectile",
                                                                                           projectile = makeLaserProjectile({
                                                                                                   name = "lightning",
                                                                                                   collisionBox = {{0,0},{0,0}},
                                                                                                   action = {
                                                                                                       {
                                                                                                           type = "area",
                                                                                                           radius = 3,
                                                                                                           force = "enemy",
                                                                                                           action_delivery =
                                                                                                               {
                                                                                                                   {
                                                                                                                       type = "beam",
                                                                                                                       beam = "electric-beam",
                                                                                                                       max_length = 8,
                                                                                                                       duration = 20
                                                                                                                   }
                                                                                                               }
                                                                                                       }    
                                                                                                   }
                                                                                           }),
                                                                                           starting_speed = 1
                                                                                       }
                                                                                   }
                                                                           }
                                                                   }
    })


    local entity2 = {
        name = "advanced-beam",
        icon = "__RampantArsenal__/graphics/icons/advanced-beam-turret.png",
        miningTime = 1,
        health = 1400,
        energySource = {
            type = "electric",
            buffer_capacity = "30MJ",
            input_flow_limit = "100MW",
            drain = "80kW",
            usage_priority = "primary-input"
        },
        order = "b[turret]-b[zzlaser-turret]",
        collisionBox = {{-1.4, -1.4}, {1.4, 1.4}},
        selectionBox = {{-2, -2}, {2, 2}},
        rotationSpeed = 0.01,
        preparingSpeed = 0.05,        
        basePicture = {
            layers =
                {
                    {
                        filename = "__base__/graphics/entity/laser-turret/laser-turret-base.png",
                        priority = "high",
                        width = 70,
                        height = 52,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(0, 2),                        
                        scale = 2,
                        tint = {r=0.5,g=0.7,b=0.7,a=1},
                        hr_version =
                            {
                                filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-base.png",
                                priority = "high",
                                width = 138,
                                height = 104,
                                direction_count = 1,
                                tint = {r=0.5,g=0.7,b=0.7,a=1},
                                frame_count = 1,
                                shift = util.by_pixel(-0.5, 2),
                                scale = 1
                            }
                    },
                    {
                        filename = "__base__/graphics/entity/laser-turret/laser-turret-base-shadow.png",
                        flags = { "mask" },
                        line_length = 1,
                        width = 66,
                        height = 42,
                        draw_as_shadow = true,
                        direction_count = 1,
                        frame_count = 1,
                        shift = util.by_pixel(6, 3),
                        scale = 2,
                        hr_version =
                            {
                                filename = "__base__/graphics/entity/laser-turret/hr-laser-turret-base-shadow.png",
                                flags = { "mask" },
                                line_length = 1,
                                width = 132,
                                height = 82,
                                draw_as_shadow = true,
                                direction_count = 1,
                                frame_count = 1,
                                shift = util.by_pixel(6, 3),
                                scale = 1
                            }
                    }
                }
        },
        foldedAnimation = {
            layers =
                {
                    laser_turret_extension{frame_count=1, line_length = 1},
                    laser_turret_extension_shadow{frame_count=1, line_length=1},
                    laser_turret_extension_mask{frame_count=1, line_length=1}
                }
        },
        foldingAnimation = {
            layers =
                {
                    laser_turret_extension{run_mode = "backward"},
                    laser_turret_extension_shadow{run_mode = "backward"},
                    laser_turret_extension_mask{run_mode = "backward"}
                }
        },
        preparedAnimation = {
            layers =
                {
                    laser_turret_shooting(),
                    laser_turret_shooting_shadow(),
                    laser_turret_shooting_mask()
                }
        },
        preparingAnimation = {
            layers =
                {
                    laser_turret_extension{},
                    laser_turret_extension_shadow{},
                    laser_turret_extension_mask{}
                }
        },
        rotationSpeed = 0.010,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local _, advancedBeamTurret = makeElectricTurret(entity2, {
                                                         type = "beam",
                                                         ammo_category = "electric",
                                                         cooldown = 13,
                                                         range = 28,
                                                         damage_modifier = 14,
                                                         source_direction_count = 64,
                                                         source_offset = {0, -3.423489 / 2},
                                                         projectile_creation_distance = 1.5,
                                                         ammo_type =
                                                             {
                                                                 category = "laser-turret",
                                                                 energy_consumption = "5MJ",
                                                                 action =
                                                                     {
                                                                         type = "direct",
                                                                         action_delivery =
                                                                             {
                                                                                 type = "beam",
                                                                                 beam = "laser-beam-rampant-arsenal",
                                                                                 max_length = 28,
                                                                                 duration = 20,
                                                                                 source_offset = {0, -1.3}
                                                                             }
                                                                     }
                                                             }
    })

    makeRecipe({
            name = advancedElectricTurretItem,
            icon = "__RampantArsenal__/graphics/icons/advancedLaserTurret.png",
            enabled = false,
            ingredients = {
                {"steel-plate", 30},
                {"electric-engine-unit", 20},
                {"processing-unit", 30},
                {"accumulator", 15}
            },
            result = advancedElectricTurretItem,
    })

    makeRecipe({
            name = advancedBeamTurret,
            icon = "__RampantArsenal__/graphics/icons/advanced-beam-turret.png",
            enabled = false,
            ingredients = {
                {"steel-plate", 15},
                {"engine-unit", 10},
                {"advanced-circuit", 15},
                {"laser-turret", 4}
            },
            result = advancedBeamTurret
    })

    makeRecipe({
            name = lightningTowerTurretItem,
            icon = "__RampantArsenal__/graphics/icons/lightningTurret.png",
            enabled = false,
            ingredients = {
                {"steel-plate", 15},
                {"iron-gear-wheel", 10},
                {"advanced-circuit", 10},
                {"battery", 15}
            },
            result = lightningTowerTurretItem,
    })


    addEffectToTech("lightning",
                    {
                        type = "unlock-recipe",
                        recipe = lightningTowerTurretItem
    })

    addEffectToTech("advanced-laser-turret-3",
                    {
                        type = "unlock-recipe",
                        recipe = advancedElectricTurretItem
    })

    addEffectToTech("advanced-laser-turret-2",
                    {
                        type = "unlock-recipe",
                        recipe = advancedBeamTurret
    })

end

return lasers
