local turretUtils = {}

function turretUtils.makeAmmoTurret(attributes, attack)
    local name = attributes.name .. "-ammo-turret-rampant-arsenal"
    local itemName = attributes.name .. "-item-rampant-arsenal"
    
    data:extend({
	    {
		type = "item",
		name = itemName,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.itemFlags or {"goes-to-quickbar"},
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
		minable = {mining_time = attributes.miningTime or 0.5, result = itemName},
		max_health = attributes.health or 400,
		corpse = "medium-remnants",
		collision_box = attributes.collisionBox or {{-0.7, -0.7 }, {0.7, 0.7}},
		selection_box = attributes.selectionBox or {{-1, -1 }, {1, 1}},
		rotation_speed = attributes.rotationSpeed or 0.007,
		preparing_speed = attributes.preparingSpeed or 0.08,
		turret_base_has_direction = attributes.lockedDirection,
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

		call_for_help_radius = 40
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
		flags = attributes.itemFlags or {"goes-to-quickbar"},
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
		minable = { mining_time = 0.5, result = itemName },
		max_health = attributes.health or 1000,
		corpse = "medium-remnants",
		collision_box = attributes.collisionBox or {{ -0.7, -0.7}, {0.7, 0.7}},
		selection_box = attributes.selectionBox or {{ -1, -1}, {1, 1}},
		rotation_speed = attributes.rotationSpeed or 0.01,
		preparing_speed = attributes.preparingSpeed or 0.05,
		dying_explosion = "medium-explosion",
		turret_base_has_direction = attributes.lockedDirection,
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
		call_for_help_radius = 40
	    }
    })

    return name, itemName
end

return turretUtils
