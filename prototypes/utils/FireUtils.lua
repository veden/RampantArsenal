-- Copyright (C) 2022  veden

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


local fireUtils = {}

local fireutil = require("__base__.prototypes.fire-util")

function fireUtils.makeAcidPuddle(attributes)
    local name = attributes.name .. "-acid-puddle-rampant-arsenal"
    data:extend({
            {
                type = "fire",
                name = name,
                localised_name = {"entity-name.acid-splash"},
                flags = {"placeable-off-grid", "not-on-map"},
                damage_per_tick = {amount = attributes.damage, type = "acid"},
                maximum_damage_multiplier = 5,
                damage_multiplier_increase_per_added_fuel = 1,
                damage_multiplier_decrease_per_tick = 0.005,

                --spawn_entity = "fire-flame-on-tree",
                uses_alternative_behavior = true,
                limit_overlapping_particles = true,
                initial_render_layer = "object",
                render_layer = "lower-object-above-shadow",
                secondary_render_layer = "higher-object-above",
                secondary_picture_fade_out_start = 30,
                secondary_picture_fade_out_duration = 60,

                spread_delay = 300,
                spread_delay_deviation = 180,
                maximum_spread_count = 100,

                particle_alpha = 0.6,
                particle_alpha_blend_duration = 60*5,
                --flame_alpha = 0.35,
                --flame_alpha_deviation = 0.05,

                emissions_per_second = { pollution = 0 },

                add_fuel_cooldown = 10,
                fade_in_duration = 1,
                fade_out_duration = 30,

                initial_lifetime = attributes.duration or 1200,
                lifetime_increase_by = 60,
                lifetime_increase_cooldown = 4,
                maximum_lifetime = 3000,
                delay_between_initial_flames = 10,
                initial_flame_count = 1,
                burnt_patch_lifetime = 0,

                on_damage_tick_effect =
                    {
                        type = "direct",
                        ignore_collision_condition = true,
                        trigger_target_mask = { "ground-unit" },
                        filter_enabled = true,
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "create-sticker",
                                            sticker = attributes.stickerName,
                                            show_in_tooltip = true
                                        }
                                    }
                            }
                    },

                pictures =
                    {
                        {
                            layers =
                                    {
                                        {
                                            filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                                            line_length = 8,
                                            direction_count = 1,
                                            width = 210,
                                            height = 224,
                                            frame_count = 26,
                                            shift = util.mul_shift(util.by_pixel(-12, -8), attributes.scale),
                                            tint = attributes.tint,
                                            scale = 0.5 * attributes.scale,
                                        },
                                        {
                                            
                                            filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                                            line_length = 8,
                                            direction_count = 1,
                                            width = 266,
                                            height = 188,
                                            frame_count = 26,
                                            shift = util.mul_shift(util.by_pixel(2, 2), attributes.scale),
                                            draw_as_shadow = true,
                                            scale = 0.5 * attributes.scale,
                                        }
                                    },
                        },
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 174,
                                        height = 150,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(-9, -17), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 238,
                                        height = 266,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(6, 29), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                },
                        },
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 236,
                                        height = 208,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(22, -16), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 214,
                                        height = 140,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(17, 2), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                },
                        },
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 252,
                                        height = 154,
                                        frame_count = 24,
                                        shift = util.mul_shift(util.by_pixel(17, -19), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 248,
                                        height = 160,
                                        frame_count = 24,
                                        shift = util.mul_shift(util.by_pixel(18, -16), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                }
                        },
            },

                secondary_pictures =
                    {
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 210,
                                        height = 224,
                                        frame_count = 26,
                                        shift = util.mul_shift(util.by_pixel(-12, -8), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 266,
                                        height = 188,
                                        frame_count = 26,
                                        shift = util.mul_shift(util.by_pixel(2, 2), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                },
                        },
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 174,
                                        height = 150,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(-9, -17), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 238,
                                        height = 266,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(6, 29), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                },
                        },
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 236,
                                        height = 208,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(22, -16), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 214,
                                        height = 140,
                                        frame_count = 29,
                                        shift = util.mul_shift(util.by_pixel(17, 2), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                },
                        },
                        {
                            layers =
                                {
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 252,
                                        height = 154,
                                        frame_count = 24,
                                        shift = util.mul_shift(util.by_pixel(17, -19), attributes.scale),
                                        tint = attributes.tint,
                                        scale = 0.5 * attributes.scale,
                                    },
                                    {
                                        filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
                                        line_length = 8,
                                        direction_count = 1,
                                        width = 248,
                                        height = 160,
                                        frame_count = 24,
                                        shift = util.mul_shift(util.by_pixel(18, -16), attributes.scale),
                                        draw_as_shadow = true,
                                        scale = 0.5 * attributes.scale,
                                    }
                                }
                        },
                    }
                }
    })
    return name
end

function fireUtils.makeFireFlame(attributes, action)
    local name = attributes.name .. "-fire-rampant-arsenal"
    data:extend({
            {
                type = "fire",
                name = name,
                flags = {"placeable-off-grid", "not-on-map"},
                damage_per_tick = {amount = attributes.damagePerTick, type = "fire"},
                maximum_damage_multiplier = 10,
                damage_multiplier_increase_per_added_fuel = 1,
                damage_multiplier_decrease_per_tick = 0.000,

                spawn_entity = "fire-flame-on-tree",

                uses_alternative_behavior = attributes.useTickEffect,
                spread_delay = 300,
                spread_delay_deviation = 180,
                maximum_spread_count = 100,

                flame_alpha = 0.35,
                flame_alpha_deviation = 0.05,

                emissions_per_tick = 0.015,

                add_fuel_cooldown = 30,
                fade_in_duration = 30,
                fade_out_duration = 30,

                initial_lifetime = attributes.duration,
                lifetime_increase_by = 500,
                lifetime_increase_cooldown = 4,
                maximum_lifetime = attributes.duration * 2,
                delay_between_initial_flames = 10,
                initial_flame_count = 1,
                burnt_patch_lifetime = attributes.duration * 2,

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

                on_damage_tick_effect = action,

                pictures = fireutil.create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.75}),

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

            }
    })
    return name
end

return fireUtils
