local fireUtils = {}

function fireUtils.makeFireFlame(attributes)

    data:extend({
	    {
		type = "fire",
		name = "fire-flame",
		flags = {"placeable-off-grid", "not-on-map"},
		damage_per_tick = {amount = 13 / 60, type = "fire"},
		maximum_damage_multiplier = 6,
		damage_multiplier_increase_per_added_fuel = 1,
		damage_multiplier_decrease_per_tick = 0.005,

		spawn_entity = "fire-flame-on-tree",

		spread_delay = 300,
		spread_delay_deviation = 180,
		maximum_spread_count = 100,

		flame_alpha = 0.35,
		flame_alpha_deviation = 0.05,

		emissions_per_tick = 0.005,

		add_fuel_cooldown = 10,
		fade_in_duration = 30,
		fade_out_duration = 30,

		initial_lifetime = 120,
		lifetime_increase_by = 150,
		lifetime_increase_cooldown = 4,
		maximum_lifetime = 1800,
		delay_between_initial_flames = 10,
		--initial_flame_count = 1,
		burnt_patch_lifetime = 1800,

		on_fuel_added_action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "instant",
				target_effects =
				    {
					{
					    type = "create-trivial-smoke",
					    smoke_name = "fire-smoke-on-adding-fuel",
					    -- speed = {-0.03, 0},
					    -- speed_multiplier = 0.99,
					    -- speed_multiplier_deviation = 1.1,
					    offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
					    speed_from_center = 0.01
					}
				    }
			    }
		    },

		pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.5}),

		smoke_source_pictures =
		    {
			{
			    filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
			    line_length = 8,
			    width = 101,
			    height = 138,
			    frame_count = 31,
			    axially_symmetrical = false,
			    direction_count = 1,
			    shift = {-0.109375, -1.1875},
			    animation_speed = 0.5,
			},
			{
			    filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
			    line_length = 8,
			    width = 99,
			    height = 138,
			    frame_count = 31,
			    axially_symmetrical = false,
			    direction_count = 1,
			    shift = {-0.203125, -1.21875},
			    animation_speed = 0.5,
			},
		    },

		burnt_patch_pictures = fireutil.create_burnt_patch_pictures(),
		burnt_patch_alpha_default = 0.4,
		burnt_patch_alpha_variations = {
		    { tile = "stone-path", alpha = 0.26 },
		    { tile = "concrete", alpha = 0.24 },
		},

		smoke =
		    {
			{
			    name = "fire-smoke",
			    deviation = {0.5, 0.5},
			    frequency = 0.25 / 2,
			    position = {0.0, -0.8},
			    starting_vertical_speed = 0.05,
			    starting_vertical_speed_deviation = 0.005,
			    vertical_speed_slowdown = 0.99,
			    starting_frame_deviation = 60,
			    height = -0.5,
			}
		    },

		light = {intensity = 1, size = 20},

		working_sound =
		    {
			sound = { filename = "__base__/sound/furnace.ogg" },
			max_sounds_per_type = 3
		    },

	    },
	    {
		type = "fire",
		name = "fire-flame-on-tree",
		flags = {"placeable-off-grid", "not-on-map"},

		damage_per_tick = {amount = 35 / 60, type = "fire"},

		spawn_entity = "fire-flame-on-tree",
		maximum_spread_count = 100,

		spread_delay = 300,
		spread_delay_deviation = 180,
		flame_alpha = 0.35,
		flame_alpha_deviation = 0.05,

		tree_dying_factor = 0.8,
		emissions_per_tick = 0.005,

		fade_in_duration = 120,
		fade_out_duration = 100,
		smoke_fade_in_duration = 100,
		smoke_fade_out_duration = 130,
		delay_between_initial_flames = 20,

		small_tree_fire_pictures = fireutil.create_small_tree_flame_animations({ blend_mode = "additive", animation_speed = 0.5, scale = 0.7 * 0.75 }),

		pictures = fireutil.create_fire_pictures({ blend_mode = "additive", animation_speed = 1, scale = 0.5 * 1.25}),

		smoke_source_pictures =
		    {
			{
			    filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
			    line_length = 8,
			    width = 101,
			    height = 138,
			    frame_count = 31,
			    axially_symmetrical = false,
			    direction_count = 1,
			    scale = 0.6,
			    shift = {-0.109375 * 0.6, -1.1875 * 0.6},
			    animation_speed = 0.5,
			    tint = make_color(1,1,1, 0.75),
			},
			{
			    filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
			    line_length = 8,
			    width = 99,
			    height = 138,
			    frame_count = 31,
			    axially_symmetrical = false,
			    direction_count = 1,
			    scale = 0.6,
			    shift = {-0.203125 * 0.6, -1.21875 * 0.6},
			    animation_speed = 0.5,
			    tint = make_color(1,1,1, 0.75),
			},
		    },

		trivial_smoke =
		    {
			{
			    name = "fire-smoke-without-glow",
			    deviation = {0.5, 0.5},
			    frequency = 0.25 / 2,
			    position = {0.0, -0.8},
			    starting_vertical_speed = 0.008,
			    starting_vertical_speed_deviation = 0.05,
			    starting_frame_deviation = 60,
			    height = -0.5,
			}
		    },

		light = {intensity = 1, size = 20},

		working_sound =
		    {
			sound = { filename = "__base__/sound/furnace.ogg" },
			max_sounds_per_type = 3
		    },
    }})
end

return fireUtils
