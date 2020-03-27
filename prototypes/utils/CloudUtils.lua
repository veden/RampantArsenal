local cloudUtils = {}

function cloudUtils.makeCloud(attributes, attack)
    local name = attributes.name .. "-cloud-rampant-arsenal"
    
    local dummyName = attributes.name .. "-visual-dummy-rampant"
    
    local dummy = {
        type = "smoke-with-trigger",
        name = dummyName,
        flags = {"not-on-map"},
        show_when_smoke_off = true,
        particle_count = 24,
        particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
        particle_distance_scale_factor = 0.5,
        particle_scale_factor = { 1, 0.707 },
        particle_duration_variation = 60 * 3;
        wave_speed = { 0.5 / 80, 0.5 / 60 },
        wave_distance = { 1, 0.5 },
        spread_duration_variation = 300 - 20;

        render_layer = "object",

        affected_by_wind = false,
        cyclic = true,
        duration = attributes.duration or 60 * 20,
        fade_away_duration = 3 * 60,
        spread_duration = (300 - 20) / 2 ,
        color = attributes.tint or {r = 0.014, g = 0.358, b = 0.395, a = 0.322}, -- #035b6452

        animation =
            {
                width = 152,
                height = 120,
                line_length = 5,
                frame_count = 60,
                shift = {-0.53125, -0.4375},
                priority = "high",
                animation_speed = 0.25,
                filename = "__base__/graphics/entity/smoke/smoke.png",
                flags = { "smoke" },
                scale = attributes.scale or 1
            }
    }
    
    data:extend({
            dummy,
            {
                type = "smoke-with-trigger",
                name = name,
                flags = {"not-on-map"},
                show_when_smoke_off = true,
                animation =
                    {
                        width = 152,
                        height = 120,
                        line_length = 5,
                        frame_count = 60,
                        shift = {-0.53125, -0.4375},
                        priority = "high",
                        animation_speed = 0.25,
                        filename = "__base__/graphics/entity/smoke/smoke.png",
                        flags = { "smoke" },
                        scale = attributes.scale or 3
                    },
                slow_down_factor = attributes.movementModifier,
                affected_by_wind = false,
                cyclic = true,
                working_sound =
                    {
                        sound =
                            {
                                filename = "__base__/sound/fight/poison-cloud.ogg",
                                volume = 0.7
                            },
                    },
                particle_count = 16,
                particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
                particle_distance_scale_factor = 0.5,
                particle_scale_factor = { 1, 0.707 },
                wave_speed = { 1/80, 1/60 },
                wave_distance = { 0.3, 0.2 },
                spread_duration_variation = 20;
                particle_duration_variation = 60 * 3;
                render_layer = "object",
                duration = attributes.duration or 60 * 20,
                fade_away_duration = attributes.outDuration or 2 * 60,
                spread_duration = attributes.inDuration or 10,
                color = attributes.tint or { r = 0.2, g = 0.9, b = 0.2 },
                created_effect =
                    {
                        {
                            type = "cluster",
                            cluster_count = 10,
                            distance = 2 * attributes.scale,
                            distance_deviation = 2.5 * attributes.scale,
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            type = "create-smoke",
                                            show_in_tooltip = false,
                                            entity_name = dummyName,
                                            initial_height = 0
                                        }
                                }
                        },
                        {
                            type = "cluster",
                            cluster_count = 11,
                            distance = 4.4 * attributes.scale,
                            distance_deviation = 1 * attributes.scale,
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            type = "create-smoke",
                                            show_in_tooltip = false,
                                            entity_name = dummyName,
                                            initial_height = 0
                                        }
                                }
                        }
                    },
                action = attack or 
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        type = "nested-result",
                                        action =
                                            {
                                                type = "area",
                                                radius = 11,
                                                entity_flags = {"breaths-air"},
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 8, type = "poison"}
                                                            }
                                                    }
                                            }
                                    }
                            }
                    },
                action_cooldown = attributes.cooldown or 30
            }
    })
    
    return name
end

return cloudUtils
