local capsules = {}


local function CapsuleLauncherSheet(lineLength, directionCount)
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
			shift = {0, 0},
		    }
		}
	}    
end

function capsules.enable()
    data:extend({	    
	    {
		type = "ammo-turret",
		name = "capsule-launcher-rampant-arsenal",
		icon = "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = {"placeable-player", "player-creation"},
		minable = {mining_time = 0.5, result = "capsule-launcher-rampant-arsenal"},
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
		folded_animation = CapsuleLauncherSheet(),
		preparing_animation = CapsuleLauncherSheet(),
		prepared_animation = CapsuleLauncherSheet(),
		folding_animation = CapsuleLauncherSheet(),
		
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

return capsules
