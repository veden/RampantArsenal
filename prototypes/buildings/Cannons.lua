local cannons = {}

local function cannonMkISheet(lineLength, directionCount)
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk1-sheet.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = lineLength or 1,
			axially_symmetrical = false,
			direction_count = directionCount or 8,
			frame_count = 1,
			shift = {0, 0},
		    }
		}
	}
    
end

local function largeCannonSheet(lineLength, directionCount)
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cr-sheet.png",
			priority = "high",
			width = 256,
			height = 256,
			line_length = lineLength or 1,
			axially_symmetrical = false,
			direction_count = directionCount or 8,
			frame_count = 1,
			shift = {0, 0},
		    }
		}
	}
    
end

local function cannonMkIISheet(lineLength, directionCount)
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/cannon-mk2-sheet.png",
			priority = "high",
			width = 128,
			height = 128,
			line_length = lineLength or 1,
			axially_symmetrical = false,
			direction_count = directionCount or 8,
			frame_count = 1,
			shift = {0, 0},
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
			shift = {0, 0},
		    }
		}
	}
    
end

function cannons.enable()
    data:extend({	   

	    {
		type = "ammo-turret",
		name = "cannon-turret-rampant-arsenal",
		icon = "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = "cannon-turret-rampant-arsenal"},
		max_health = 400,
		corpse = "medium-remnants",
		collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
		selection_box = {{-1, -1 }, {1, 1}},
		rotation_speed = 0.015,
		preparing_speed = 0.08,
		folding_speed = 0.08,
		dying_explosion = "medium-explosion",
		inventory_size = 1,
		automated_ammo_count = 10,
		attacking_speed = 0.5,
		alert_when_attacking = true,
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		folded_animation = cannonMkISheet(),	   
		preparing_animation = cannonMkISheet(),
		prepared_animation = cannonMkISheet(8, 64),
		folding_animation = cannonMkISheet(),
		
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

		attack_parameters =
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
	    },

	    {
		type = "ammo-turret",
		name = "rapid-cannon-turret-rampant-arsenal",
		icon = "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = "rapid-cannon-turret-rampant-arsenal"},
		max_health = 400,
		corpse = "medium-remnants",
		collision_box = {{-0.7, -0.7 }, {0.7, 0.7}},
		selection_box = {{-1, -1 }, {1, 1}},
		rotation_speed = 0.007,
		preparing_speed = 0.08,
		folding_speed = 0.08,
		dying_explosion = "medium-explosion",
		inventory_size = 1,
		automated_ammo_count = 10,
		attacking_speed = 0.5,
		alert_when_attacking = true,
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		folded_animation = cannonMkIIPlace(),
		preparing_animation = cannonMkIIPlace(8, 4, 8),
		prepared_animation = cannonMkIISheet(8, 64),
		folding_animation = cannonMkIIPlace(8, 4, 8, true),
		attacking_animation = cannonMkIISheet(8, 64),
		
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

		attack_parameters =
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
	    },

	    {
		type = "ammo-turret",
		name = "suppression-cannon-rampant-arsenal",
		icon = "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = "suppression-cannon-rampant-arsenal"},
		max_health = 400,
		corpse = "medium-remnants",
		collision_box = {{-1.5, -1.5 }, {1.5, 1.5}},
		selection_box = {{-2, -2 }, {2, 2}},
		rotation_speed = 0.015,
		preparing_speed = 0.08,
		folding_speed = 0.08,
		dying_explosion = "medium-explosion",
		inventory_size = 1,
		automated_ammo_count = 10,
		attacking_speed = 0.5,
		alert_when_attacking = true,
		open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
		close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
		folded_animation = largeCannonSheet(),	   
		preparing_animation = largeCannonSheet(),
		prepared_animation = largeCannonSheet(8, 64),
		folding_animation = largeCannonSheet(),
		
		vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

		attack_parameters =
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
end






return cannons
