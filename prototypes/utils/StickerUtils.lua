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


local stickerUtils = {}
local math3d = require "math3d"

function stickerUtils.makeAcidSticker(attributes)
    local name = attributes.name .. "-acid-sticker-rampant-arsenal"
    data:extend({
            {
                type = "sticker",
                name = name,
                flags = {"not-on-map"},

                animation =
                    {
                        filename = "__base__/graphics/entity/acid-sticker/acid-sticker.png",
                        line_length = 5,
                        width = 30,
                        height = 34,
                        frame_count = 50,
                        animation_speed = 0.5,
                        tint = {r = 0.714, g = 0.669, b = 0.291, a = 0.745}, -- #b6aa4abe
                        shift = util.by_pixel(1.5, 0),
                        scale = 0.5
                    },
                duration_in_ticks = attributes.duration,
                target_movement_modifier_from = 1,
                target_movement_modifier_to = 1,
                vehicle_speed_modifier_from = 1,
                vehicle_speed_modifier_to = 1,
                vehicle_friction_modifier_from = 1,
                vehicle_friction_modifier_to = 1,
                damage_per_tick = { amount = attributes.damage, type = "acid" }
            }
    })

    return name
end

function stickerUtils.makeSticker(attributes)
    local name = attributes.name .. "-sticker-rampant-arsenal"

    data:extend(
        {
            {
                type = "sticker",
                name = name,
                flags = {"not-on-map"},

                animation =
                {
                    filename = "__base__/graphics/entity/fire-flame/fire-flame-01.png",
                    line_length = 10,
                    width = 84,
                    height = 130,
                    frame_count = 90,
                    blend_mode = "normal",
                    animation_speed = 1,
                    scale = 0.4,
                    tint = { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }, --{ r = 1, g = 1, b = 1, a = 0.35 },
                    shift = math3d.vector2.mul({-0.078125, -1.8125}, 0.1),
                    draw_as_glow = true
                },
                    
                duration_in_ticks = attributes.duration or 30 * 60,
                target_movement_modifier = attributes.movementModifier, -- or 0.8,
                damage_per_tick = attributes.damagePerTick, --or { amount = 100 / 60, type = "fire" },
                spread_fire_entity = attributes.spreadFireEntity, -- or "fire-flame-on-tree",
                fire_spread_cooldown = attributes.spreadCooldown or 30,
                fire_spread_radius = attributes.spreadRadius or 0.75
            }
    })

    return name
end

return stickerUtils
