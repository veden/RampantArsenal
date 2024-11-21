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


local streamUtils = {}

-- module code

function streamUtils.makeAcidStream(attributes)
    local softSmokeName = attributes.softSmokeName or "smoke-fast"--or makeSmokeSoft(attributes)
    local name = attributes.name .. "-acid-stream-rampant-arsenal"

    data:extend({
            {
                type = "stream",
                name = name,
                flags = {"not-on-map"},
                --stream_light = {intensity = 1, size = 4},
                --ground_light = {intensity = 0.8, size = 4},

                particle_buffer_size = attributes.bufferSize,
                particle_spawn_interval = attributes.spawnInterval,
                particle_spawn_timeout = attributes.particleTimeout,
                particle_vertical_acceleration = 0.005 * 0.60 * 1.5, --x
                particle_horizontal_speed = attributes.particleHoizontalSpeed or 0.2* 0.75 * 1.5 * 1.5, --x
                particle_horizontal_speed_deviation = 0.005 * 0.70,
                particle_start_alpha = 0.5,
                particle_end_alpha = 1,
                particle_alpha_per_part = 0.8,
                particle_scale_per_part = 0.8,
                particle_loop_frame_count = 15,
                --particle_fade_out_threshold = 0.95,
                particle_fade_out_duration = 2,
                particle_loop_exit_threshold = 0.25,
                special_neutral_target_damage = {amount = 1, type = "acid"},
                working_sound =
                    {
                        sound =
                            {
                                {
                                    filename = "__base__/sound/fight/projectile-acid-burn-loop.ogg",
                                    volume = 0.4
                                },
                            }
                    },
                -- initial_action =
                --     {

                --     },
                action = attributes.actions,
                particle = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
                    line_length = 5,
                    width = 42,
                    height = 164,
                    frame_count = 15,
                    shift = util.mul_shift(util.by_pixel(-2, 31), attributes.scale),
                    tint = attributes.tint,
                    priority = "high",
                    scale = 0.5 * attributes.scale,
                    animation_speed = 1,
                },
                spine_animation = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
                    line_length = 5,
                    width = 132,
                    height = 20,
                    frame_count = 15,
                    shift = util.mul_shift(util.by_pixel(0, -1), attributes.scale),
                    tint = attributes.tint,
                    priority = "high",
                    scale = 0.5 * attributes.scale,
                    animation_speed = 1,
                },
                shadow = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
                    line_length = 15,
                    width = 42,
                    height = 164,
                    frame_count = 15,
                    shift = util.mul_shift(util.by_pixel(-2, 31), attributes.scale),
                    draw_as_shadow = true,
                    priority = "high",
                    scale = 0.5 * attributes.scale,
                    animation_speed = 1,
                },

                oriented_particle = true,
                shadow_scale_enabled = true,
            }
    })
    return name
end


function streamUtils.makeStream(attributes)
    local softSmokeName = attributes.softSmokeName or "smoke-fast"--or makeSmokeSoft(attributes)
    local name = attributes.name .. "-stream-rampant-arsenal"

    data:extend(
        {
            {
                type = "stream",
                name = name,
                flags = {"not-on-map"},
                stream_light = {intensity = 1, size = 4},
                ground_light = {intensity = 0.8, size = 4},

                smoke_sources =
                    {
                        {
                            name = softSmokeName,
                            frequency = 0.05, --0.25,
                            position = {0.0, 0}, -- -0.8},
                            starting_frame_deviation = 60
                        }
                    },
                particle_buffer_size = attributes.bufferSize or 90,
                particle_spawn_interval = attributes.spawnInterval or 1,
                particle_spawn_timeout = attributes.particleTimeout or 1,
                particle_vertical_acceleration = attributes.particleVerticalAcceleration or 0.01,
                particle_horizontal_speed = attributes.particleHoizontalSpeed or 0.6,
                particle_horizontal_speed_deviation = attributes.particleHoizontalSpeedDeviation or 0.0025,
                particle_start_alpha = 0.5,
                particle_end_alpha = 1,
                particle_start_scale = 0.2,
                particle_loop_frame_count = 3,
                particle_fade_out_threshold = 0.9,
                particle_loop_exit_threshold = 0.25,
                action = attributes.actions,

                spine_animation =
                    {
                        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-fire-stream-spine.png",
                        blend_mode = "additive",
                        tint = attributes.spineAnimationTint,
                        line_length = 4,
                        width = 32,
                        height = 18,
                        frame_count = 32,
                        axially_symmetrical = false,
                        direction_count = 1,
                        animation_speed = 2,
                        shift = {0, 0},
                    },

                shadow =
                    {
                        filename = "__RampantArsenal__/graphics/acid-projectile-purple/acid-projectile-purple-shadow.png",
                        line_length = 5,
                        width = 28,
                        height = 16,
                        frame_count = 33,
                        priority = "high",
                        shift = {-0.09, 0.395}
                    },

                particle =
                    {
                        filename = "__base__/graphics/entity/flamethrower-fire-stream/flamethrower-explosion.png",
                        priority = "extra-high",
                        width = 64,
                        tint = attributes.particleTint,
                        height = 64,
                        frame_count = 32,
                        line_length = 8,
                        scale = attributes.particleSize
                    }
            }
        }
    )
    return name
end


function streamUtils.makeStreamProjectile(attributes)
    local softSmokeName = attributes.softSmokeName or "smoke-fast"--or makeSmokeSoft(attributes)
    local name = attributes.name .. "-stream-rampant-arsenal"

    data:extend(
        {
            {
                type = "stream",
                name = name,
                flags = {"not-on-map"},
                --stream_light = {intensity = 1, size = 4},
                --ground_light = {intensity = 0.8, size = 4},

                particle_buffer_size = 90,
                particle_spawn_interval = 1,
                particle_spawn_timeout = 1,
                particle_vertical_acceleration =  0.005 * 0.60 * 0.9, --x
                particle_horizontal_speed = 0.2* 0.75 * 1.5 * 1.5, --x
                particle_horizontal_speed_deviation = 0.005 * 0.70,
                particle_start_alpha = 0.5,
                particle_end_alpha = 1,
                particle_alpha_per_part = 0.8,
                particle_scale_per_part = 0.8,
                particle_loop_frame_count = 15,
                --particle_fade_out_threshold = 0.95,
                particle_fade_out_duration = 2,
                particle_loop_exit_threshold = 0.25,
                -- special_neutral_target_damage = {amount = 1, type = "acid"},
                initial_action = attributes.actions,

                particle = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-head.png",
                    line_length = 5,
                    width = 42,
                    height = 164,
                    frame_count = 15,
                    shift = util.mul_shift(util.by_pixel(-2, 31), 1),
                    tint = { r=0,g=0,b=0,a=1 },
                    priority = "high",
                    scale = 0.2 * 1,
                    animation_speed = 1,
                },
                spine_animation = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-tail.png",
                    line_length = 5,
                    width = 132,
                    height = 20,
                    frame_count = 15,
                    shift = util.mul_shift(util.by_pixel(0, -1), 1),
                    tint = { r=0,g=0,b=0,a=1 },
                    priority = "high",
                    scale = 0.2 * 1,
                    animation_speed = 1,
                },
                shadow = {
                    filename = "__base__/graphics/entity/acid-projectile/acid-projectile-shadow.png",
                    line_length = 15,
                    width = 42,
                    height = 164,
                    frame_count = 15,
                    shift = util.mul_shift(util.by_pixel(-2, 31), 1),
                    draw_as_shadow = true,
                    priority = "high",
                    scale = 0.2 * 1,
                    animation_speed = 1,
                },

                oriented_particle = true,
                shadow_scale_enabled = true,
            }
        }
    )
    return name
end

return streamUtils
