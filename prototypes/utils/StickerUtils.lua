local stickerUtils = {}

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
                        priority = "extra-high",
                        line_length = 5,
                        width = 16,
                        height = 18,
                        frame_count = 50,
                        animation_speed = 0.5,
                        tint = {r = 0.714, g = 0.669, b = 0.291, a = 0.745}, -- #b6aa4abe
                        shift = util.by_pixel (2,0),
                        hr_version =
                            {
                                filename = "__base__/graphics/entity/acid-sticker/hr-acid-sticker.png",
                                line_length = 5,
                                width = 30,
                                height = 34,
                                frame_count = 50,
                                animation_speed = 0.5,
                                tint = {r = 0.714, g = 0.669, b = 0.291, a = 0.745}, -- #b6aa4abe
                                shift = util.by_pixel(1.5, 0),
                                scale = 0.5
                            }
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
                        filename = "__base__/graphics/entity/fire-flame/fire-flame-13.png",
                        line_length = 8,
                        width = 60,
                        height = 118,
                        frame_count = 25,
                        axially_symmetrical = false,
                        direction_count = 1,
                        blend_mode = "normal",
                        animation_speed = 1,
                        scale = 0.2,
                        tint = attributes.tint or { r = 0.5, g = 0.5, b = 0.5, a = 0.18 }, --{ r = 1, g = 1, b = 1, a = 0.35 },
                        shift = {-0.078125, -0.18125},
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
