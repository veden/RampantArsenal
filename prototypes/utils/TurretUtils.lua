local turretUtils = {}

require "util"



local function foreach(table_, fun_)
    for k, tab in pairs(table_) do fun_(tab) end
    return table_
end


local indicator_pictures =
    {
        north =
            {
                filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-north.png",
                line_length = 2,
                width = 4,
                height = 10,
                frame_count = 2,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(8, 20),
                hr_version =
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-led-indicator-north.png",
                        line_length = 2,
                        width = 10,
                        height = 18,
                        frame_count = 2,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(7, 20),
                        scale = 0.5
                    }
            },
        east =
            {
                filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-east.png",
                line_length = 2,
                width = 12,
                height = 6,
                frame_count = 2,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(-34, -6),
                hr_version =
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-led-indicator-east.png",
                        line_length = 2,
                        width = 18,
                        height = 8,
                        frame_count = 2,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(-33, -5),
                        scale = 0.5
                    }
            },
        south =
            {
                filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-south.png",
                line_length = 2,
                width = 4,
                height = 12,
                frame_count = 2,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(-8, -46),
                hr_version =
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-led-indicator-south.png",
                        line_length = 2,
                        width = 8,
                        height = 18,
                        frame_count = 2,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(-8, -45),
                        scale = 0.5
                    }
            },
        west =
            {
                filename = "__base__/graphics/entity/flamethrower-turret/flamethrower-turret-led-indicator-west.png",
                line_length = 2,
                width = 10,
                height = 10,
                frame_count = 2,
                axially_symmetrical = false,
                direction_count = 1,
                shift = util.by_pixel(32, -22),
                hr_version =
                    {
                        filename = "__base__/graphics/entity/flamethrower-turret/hr-flamethrower-turret-led-indicator-west.png",
                        line_length = 2,
                        width = 20,
                        height = 10,
                        frame_count = 2,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = util.by_pixel(32, -20),
                        scale = 0.5
                    }
            }
    }

local function set_shift(shift, tab)
    tab.shift = shift
    if tab.hr_version then
	tab.hr_version.shift = shift
    end
    return tab
end


local function flamethrower_turret_pipepictures()
    local pipe_sprites = pipepictures()

    return {
	north = set_shift({0, 1}, util.table.deepcopy(pipe_sprites.straight_vertical)),
	south = set_shift({0, -1}, util.table.deepcopy(pipe_sprites.straight_vertical)),
	east = set_shift({-1, 0}, util.table.deepcopy(pipe_sprites.straight_horizontal)),
	west = set_shift({1, 0}, util.table.deepcopy(pipe_sprites.straight_horizontal))
    }
end


function turretUtils.makeAmmoTurret(attributes, attack)
    local name = attributes.name .. "-ammo-turret-rampant-arsenal"
    local itemName = attributes.name .. "-item-rampant-arsenal"
    
    data:extend({
	    {
		type = "item",
		name = itemName,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.itemFlags or {},
		subgroup = attributes.subgroup or "defensive-structure",
		order = attributes.order or "b[turret]-a[gun-turret]",
		place_result = name,
		stack_size = attributes.stackSize or 50
	    },
	    {
		type = "ammo-turret",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.flags or {"placeable-player", "player-creation"},
		-- healing_per_tick = -0.04,
		minable = {mining_time = attributes.miningTime or 0.5, result = itemName},
		max_health = attributes.health or 400,
		corpse = "medium-remnants",
		collision_box = attributes.collisionBox or {{-0.7, -0.7 }, {0.7, 0.7}},
		selection_box = attributes.selectionBox or {{-1, -1 }, {1, 1}},
		rotation_speed = attributes.rotationSpeed or 0.007,
		preparing_speed = attributes.preparingSpeed or 0.08,
		folding_speed = attributes.foldingSpeed or 0.08,
		dying_explosion = "medium-explosion",
		inventory_size = attributes.inventorySize or 1,
		automated_ammo_count = attributes.autoAmmoCount or 10,
		attacking_speed = attributes.attackingSpeed or 0.5,
		alert_when_attacking = true,
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		folded_animation = attributes.foldedAnimation,
		preparing_animation = attributes.preparingAnimation,
		prepared_animation = attributes.preparedAnimation,
		folding_animation = attributes.foldingAnimation,
		energy_source = attributes.energySource,
		attacking_animation = attributes.attackingAnimation,
		turret_base_has_direction = attributes.hasBaseDirection,
		
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

		attack_parameters = attack or
		    {
			type = "projectile",
			ammo_category = "bullet",
			cooldown = 6,
			projectile_creation_distance = 1.39375,
			projectile_center = {0, -0.0875}, -- same as gun_turret_attack shift
			shell_particle =
			    {
				name = "shell-particle",
				direction_deviation = 0.1,
				speed = 0.1,
				speed_deviation = 0.03,
				center = {-0.0625, 0},
				creation_distance = -1.925,
				starting_frame_speed = 0.2,
				starting_frame_speed_deviation = 0.1
			    },
			range = 18,
			sound = make_heavy_gunshot_sounds(),
		    },

		call_for_help_radius = 40,
		order = attributes.order		
	    }
    })

    return name, itemName
end

function turretUtils.makeFluidTurret(attributes, attack)
    local name = attributes.name .. "-fluid-turret-rampant-arsenal"
    local itemName = attributes.name .. "-item-rampant-arsenal"

    data:extend({
	    {
		type = "item",
		name = itemName,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.itemFlags or {},
		subgroup = attributes.subgroup or "defensive-structure",
		order = attributes.order or "b[turret]-a[gun-turret]",
		place_result = name,
		stack_size = attributes.stackSize or 50
	    },	  
	    {
		type = "fluid-turret",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/flamethrower-turret.png",
		icon_size = 32,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = attributes.miningTime or 0.5, result = itemName},
		max_health = attributes.health or 1400,
		corpse = "medium-remnants",
		collision_box = attributes.collisionBox or {{-1.7, -2.2 }, {1.7, 2.2}},
		selection_box = attributes.selectionBox or {{-2, -2.5 }, {2, 2.5}},
		rotation_speed = attributes.rotationSpeed or 0.015,
		preparing_speed = attributes.preparingSpeed or 0.08,
		folding_speed = attributes.foldingSpeed or 0.08,
		attacking_speed = attributes.attackingSpeed or 1,
		ending_attack_speed = attributes.attackingEndSpeed or 0.2,
		dying_explosion = "medium-explosion",
		inventory_size = 1,
		automated_ammo_count = 10,
		attacking_animation_fade_out = 10,
		turret_base_has_direction = true,

		resistances =
		    {
			{
			    type = "fire",
			    percent = 100,
			},
		    },

		fluid_box = 
		    {
			pipe_picture = flamethrower_turret_pipepictures(),
			render_layer = "lower-object",
			secondary_draw_order = 0,
			pipe_covers = pipecoverspictures(),
			base_area = 1,
			pipe_connections = attributes.pipeConnections or {
			    { position = {-2.5, 2.0} },
			    { position = {2.5, 2.0} }
									 }
		    },
		fluid_buffer_size = attributes.fluidBuffer or 100,
		fluid_buffer_input_flow = attributes.fluidBufferFlow or 250 / 60 / 5, -- 5s to fill the buffer
		activation_buffer_ratio = attributes.fluidBufferRation or 0.25,

		folded_animation = attributes.foldedAnimation,

		preparing_animation = attributes.preparingAnimation,
		prepared_animation = attributes.preparedAnimation,
		
		folding_animation = attributes.foldingAnimation,

		not_enough_fuel_indicator_picture = indicator_pictures,
		enough_fuel_indicator_picture = foreach(util.table.deepcopy(indicator_pictures), function (tab) tab.x = tab.width end),
		indicator_light = { intensity = 0.8, size = 0.9 },
		
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

		prepare_range = attributes.prepareRange or 55,
		shoot_in_prepare_state = false,
		attack_parameters = attack or 
		    {
			type = "stream",
			ammo_category = "flamethrower",
			cooldown = 4,
			range = 45,
			min_range = 6,

			turn_range = 1.0/3.0,
			fire_penalty = 30,

			fluids = {
			    {type = "crude-oil"},
			    {type = "heavy-oil", damage_modifier = 1.05},
			    {type = "light-oil", damage_modifier = 1.1}
			},
			fluid_consumption = 0.2,

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
						stream = "flamethrower-fire-stream2",
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
		    }, -- {0,  0.625}
		call_for_help_radius = 40,
		order = attributes.order
	    }
    })

    return name, itemName
end

function turretUtils.makeElectricTurret(attributes, attack)
    local name = attributes.name .. "-electric-turret-rampant-arsenal"
    local itemName = attributes.name .. "-item-rampant-arsenal"
    
    data:extend({
	    {
		type = "item",
		name = itemName,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.itemFlags or {},
		subgroup = attributes.subgroup or "defensive-structure",
		order = attributes.order or "b[turret]-a[gun-turret]",
		place_result = name,
		stack_size = attributes.stackSize or 50
	    },
	    {
		type = "electric-turret",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/laser-turret.png",
		icon_size = 32,
		flags = attributes.flags or { "placeable-player", "placeable-enemy", "player-creation"},
		minable = { mining_time = attributes.miningTime or 0.5, result = itemName },
		max_health = attributes.health or 1000,
		corpse = "medium-remnants",
		collision_box = attributes.collisionBox or {{ -0.7, -0.7}, {0.7, 0.7}},
		selection_box = attributes.selectionBox or {{ -1, -1}, {1, 1}},
		rotation_speed = attributes.rotationSpeed or 0.01,
		preparing_speed = attributes.preparingSpeed or 0.05,
		dying_explosion = "medium-explosion",
		turret_base_has_direction = attributes.hasBaseDirection,
		folding_speed = attributes.foldingSpeed or 0.05,
		energy_source = attributes.energySource or 
		    {
			type = "electric",
			buffer_capacity = "801kJ",
			input_flow_limit = "9600kW",
			drain = "24kW",
			usage_priority = "primary-input"
		    },
		folded_animation = attributes.foldedAnimation,
		preparing_animation = attributes.preparingAnimation,
		prepared_animation = attributes.preparedAnimation,
		folding_animation = attributes.foldingAnimation,
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

		attack_parameters = attack or
		    {
			type = "projectile",
			ammo_category = "electric",
			cooldown = 20,
			projectile_center = {-0.09375, -0.2},
			turn_range = 1.0/3.0,
			projectile_creation_distance = 1.4,
			range = 24,
			damage_modifier = 4,
			ammo_type =
			    {
				type = "projectile",
				category = "laser-turret",
				energy_consumption = "800kJ",
				action =
				    {
					{
					    type = "direct",
					    action_delivery =
						{
						    {
							type = "projectile",
							projectile = "laser",
							starting_speed = 0.35
						    }
						}
					}
				    }
			    },
			sound = make_laser_sounds()
		    },
		call_for_help_radius = 40,
		order = attributes.order
	    }
    })

    return name, itemName
end

return turretUtils
