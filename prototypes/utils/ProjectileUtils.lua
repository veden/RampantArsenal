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


local projectileUtils = {}

function projectileUtils.makeShotgunProjectile(attributes)
    local name = attributes.name .. "-shotgun-projectile-rampant-arsenal"

    data:extend({{
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                collision_box = attributes.collisionBox or {{-0.3, -1.1}, {0.3, 1.1}},
                acceleration = attributes.acceleration or 0,
                direction_only = attributes.directionOnly,
                force_condition = "not-same",
                piercing_damage = attributes.piercingDamage,
                action = attributes.action or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = {amount = 200 , type = "physical"}
                                        },
                                        {
                                            type = "damage",
                                            damage = {amount = 100 , type = "explosion"}
                                        },
                                        {
                                            type = "create-entity",
                                            entity_name = "explosion"
                                        }
                                    }
                            }
                    },
                animation = attributes.animation or
                    {
                        filename = "__base__/graphics/entity/piercing-bullet/piercing-bullet.png",
                        frame_count = 1,
                        width = 3,
                        tint = attributes.tint,
                        height = 50,
                        priority = "high"
                    },
                shadow = attributes.shadow,
                smoke = attributes.smoke,
                hit_at_collision_position = attributes.hitAtPosition
    }})

    return name
end

function projectileUtils.makeLaserProjectile(attributes)
    local name = attributes.name .. "-laser-projectile-rampant-arsenal"

    data:extend({{
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                collision_box = attributes.collisionBox or {{-0.3, -1.1}, {0.3, 1.1}},
                acceleration = attributes.acceleration or 0,
                force_condition = "not-same",
                direction_only = attributes.directionOnly,
                piercing_damage = attributes.piercingDamage or 300,
                light = {
                    intensity = 0.75,
                    size = 8,
                    color = attributes.tint,
                },
                action = attributes.action or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = {amount = 200 , type = "physical"}
                                        },
                                        {
                                            type = "damage",
                                            damage = {amount = 100 , type = "explosion"}
                                        },
                                        {
                                            type = "create-entity",
                                            entity_name = "explosion"
                                        }
                                    }
                            }
                    },
                final_action = attributes.finalAction or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "create-entity",
                                            entity_name = "small-scorchmark",
                                            check_buildability = true
                                        }
                                    }
                            }
                    },
                animation = attributes.animation or
                    {
                        filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
                        tint = attributes.tint,
                        frame_count = 1,
                        scale = 5,
                        width = 12,
                        height = 33,
                        priority = "high",
                        blend_mode = "additive"
                    },
                shadow = attributes.shadow,
                smoke = attributes.smoke
    }})

    return name
end

function projectileUtils.makeCannonProjectile(attributes)
    local name = attributes.name .. "-cannon-projectile-rampant-arsenal"

    data:extend({{
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                collision_box = attributes.collisionBox or {{-0.3, -1.1}, {0.3, 1.1}},
                acceleration = attributes.acceleration or 0,
                direction_only = attributes.directionOnly,
                force_condition = "not-same",
                piercing_damage = attributes.piercingDamage or 300,
                action = attributes.action or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = {amount = 200 , type = "physical"}
                                        },
                                        {
                                            type = "damage",
                                            damage = {amount = 100 , type = "explosion"}
                                        },
                                        {
                                            type = "create-entity",
                                            entity_name = "explosion"
                                        }
                                    }
                            }
                    },
                final_action = attributes.finalAction or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "create-entity",
                                            entity_name = "small-scorchmark",
                                            check_buildability = true
                                        }
                                    }
                            }
                    },
                animation = attributes.animation or
                    {
                        filename = "__base__/graphics/entity/laser/laser-to-tint-medium.png",
                        tint = attributes.tint,
                        frame_count = 1,
                        scale = 5,
                        width = 12,
                        height = 33,
                        priority = "high",
                        blend_mode = "additive"
                    },
                shadow = attributes.shadow,
                smoke = attributes.smoke
    }})

    return name
end

function projectileUtils.makeCapsuleProjectile(attributes, attack)
    local name = attributes.name .. "-capsule-projectile-rampant-arsenal"

    data:extend({
            {
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                acceleration = attributes.acceleration or 0.005,
                action = attack or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        type = "create-entity",
                                        show_in_tooltip = true,
                                        entity_name = "poison-cloud"
                                    }
                            }
                    },
                light = {intensity = 0.5, size = 4},
                animation = attributes.animation or
                    {
                        filename = "__base__/graphics/entity/poison-capsule/poison-capsule.png",
                        frame_count = 1,
                        tint = attributes.tint,
                        width = 32,
                        height = 32,
                        priority = "high"
                    },
                shadow = attributes.shadow or
                    {
                        filename = "__base__/graphics/entity/poison-capsule/poison-capsule-shadow.png",
                        frame_count = 1,
                        width = 32,
                        height = 32,
                        priority = "high"
                    },
                smoke = {
                    {
                        name = "smoke-fast",
                        deviation = {0.15, 0.15},
                        frequency = 1,
                        position = {0, 0},
                        starting_frame = 3,
                        starting_frame_deviation = 5,
                        starting_frame_speed_deviation = 5
                    }
                },
            }
    })

    return name
end

function projectileUtils.makeGrenadeProjectile(attributes, attack)
    local name = attributes.name .. "-grenade-projectile-rampant-arsenal"

    data:extend({
            {
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                acceleration = attributes.acceleration or 0.005,
                action = attack or
                    {
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            {
                                                type = "create-entity",
                                                entity_name = "medium-explosion"
                                            },
                                            {
                                                type = "create-entity",
                                                entity_name = "small-scorchmark",
                                                check_buildability = true
                                            }
                                        }
                                }
                        },
                        {
                            type = "area",
                            radius = 6.5,
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            {
                                                type = "damage",
                                                damage = {amount = 35, type = "explosion"}
                                            },
                                            {
                                                type = "create-entity",
                                                entity_name = "explosion"
                                            }
                                        }
                                }
                        }
                    },
                light = {intensity = 0.5, size = 4},
                animation = attributes.animation or
                    {
                        filename = "__base__/graphics/entity/grenade/grenade.png",
                        frame_count = 1,
                        width = 24,
                        tint = attributes.tint,
                        height = 24,
                        priority = "high"
                    },
                shadow = attributes.shadow or
                    {
                        filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
                        frame_count = 1,
                        width = 24,
                        height = 24,
                        priority = "high"
                    }
            }
    })


    return name
end

function projectileUtils.makeInvisibleProjectile(attributes)
    local name = attributes.name .. "-invisible-projectile-rampant-arsenal"

    data:extend({
            {
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                collision_box = attributes.collisionBox,
                acceleration = attributes.acceleration or 0,
                direction_only = attributes.directionOnly,
                piercing_damage = attributes.piercingDamage,
                action = attributes.action,
                final_action = attributes.finalAction,
                animation = nil -- {
                --     filename = "__base__/graphics/entity/rocket/rocket.png",
                --     frame_count = 8,
                --     line_length = 8,
                --     width = 9,
                --     height = 35,
                --     shift = {0, 0},
                --     priority = "high"
                -- }
                ,
                shadow = nil,
                smoke = nil
            }
    })

    return name
end

function projectileUtils.makeRocketProjectile(attributes)
    local name = attributes.name .. "-rocket-projectile-rampant-arsenal"

    data:extend({{
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                collision_box = attributes.collisionBox,
                acceleration = attributes.acceleration or 0.005,
                direction_only = attributes.directionOnly,
                piercing_damage = attributes.piercingDamage,
                action = attributes.action or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "damage",
                                            damage = {amount = 200 , type = "physical"}
                                        },
                                        {
                                            type = "damage",
                                            damage = {amount = 100 , type = "explosion"}
                                        },
                                        {
                                            type = "create-entity",
                                            entity_name = "explosion"
                                        }
                                    }
                            }
                    },
                final_action = attributes.finalAction or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "create-entity",
                                            entity_name = "small-scorchmark",
                                            check_buildability = true
                                        }
                                    }
                            }
                    },
                animation =  require("__base__.prototypes.entity.rocket-projectile-pictures").animation({1, 0.8, 0.3}),
                shadow = require("__base__.prototypes.entity.rocket-projectile-pictures").shadow,
                smoke = require("__base__.prototypes.entity.rocket-projectile-pictures").smoke,

    }})

    return name
end

function projectileUtils.makeArtilleryShell(attributes, attack, finalAttack)
    local name = attributes.name .. "-artillery-projectile-rampant-arsenal"

    data:extend({
            {
                type = "artillery-projectile",
                name = name,
                flags = {"not-on-map"},
                acceleration = attributes.acceleration or 0,
                direction_only =  true,
                reveal_map = true,
                map_color = {r=1, g=1, b=0},
                picture =
                    {
                        filename = "__base__/graphics/entity/artillery-projectile/shell.png",
                        width = 64,
                        height = 64,
                        tint = attributes.tint,
                        scale = 0.5,
                    },
                shadow =
                    {
                        filename = "__base__/graphics/entity/artillery-projectile/shell-shadow.png",
                        width = 64,
                        height = 64,
                        tint = attributes.tint,
                        scale = 0.5,
                    },
                chart_picture =
                    {
                        filename = "__base__/graphics/entity/artillery-projectile/artillery-shoot-map-visualization.png",
                        flags = { "icon" },
                        frame_count = 1,
                        width = 64,
                        height = 64,
                        priority = "high",
                        scale = 0.25,
                    },
                action = attack -- or
                    -- {
                    --     type = "direct",
                    --     action_delivery =
                    --         {
                    --             type = "instant",
                    --             target_effects =
                    --                 {
                    --                     {
                    --                         type = "nested-result",
                    --                         action =
                    --                             {
                    --                                 type = "area",
                    --                                 radius = 4.0,
                    --                                 action_delivery =
                    --                                     {
                    --                                         type = "instant",
                    --                                         target_effects =
                    --                                             {
                    --                                                 {
                    --                                                     type = "damage",
                    --                                                     damage = {amount = 500 , type = "physical"}
                    --                                                 },
                    --                                                 {
                    --                                                     type = "damage",
                    --                                                     damage = {amount = 500 , type = "explosion"}
                    --                                                 },
                    --                                             }
                    --                                     }
                    --                             }
                    --                     },
                    --                     {
                    --                         type = "create-trivial-smoke",
                    --                         smoke_name = "artillery-smoke",
                    --                         initial_height = 0,
                    --                         speed_from_center = 0.05,
                    --                         speed_from_center_deviation = 0.005,
                    --                         offset_deviation = {{-4, -4}, {4, 4}},
                    --                         max_radius = 3.5,
                    --                         repeat_count = 4 * 4 * 15
                    --                     },
                    --                     {
                    --                         type = "create-entity",
                    --                         entity_name = "big-artillery-explosion"
                    --                     },
                    --                     {
                    --                         type = "show-explosion-on-chart",
                    --                         scale = 8/32,
                    --                     }
                    --                 }
                    --         }
                    -- }
                ,
                final_action = finalAttack -- or
                    -- {
                    --     type = "direct",
                    --     action_delivery =
                    --         {
                    --             type = "instant",
                    --             target_effects =
                    --                 {
                    --                     {
                    --                         type = "create-entity",
                    --                         entity_name = "small-scorchmark",
                    --                         check_buildability = true
                    --                     }
                    --                 }
                    --         }
                    -- }
                ,
                animation =
                    {
                        filename = "__base__/graphics/entity/bullet/bullet.png",
                        frame_count = 1,
                        width = 3,
                        height = 50,
                        priority = "high"
                    },
                height_from_ground = 280 / 64
            }
    })

    return name
end

function projectileUtils.makeBombWave(attributes, attack)
    local name = attributes.name .. "-bomb-wave-rampant-arsenal"

    data:extend({
            {
                type = "projectile",
                name = name,
                flags = {"not-on-map"},
                acceleration = 0,
                action = attack or
                    {
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            {
                                                type = "create-entity",
                                                entity_name = "explosion"
                                            }
                                        }
                                }
                        },
                        {
                            type = "area",
                            radius = 3,
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            type = "damage",
                                            damage = {amount = 400, type = "explosion"}
                                        }
                                }
                        }
                    },
                animation =
                    {
                        filename = "__core__/graphics/empty.png",
                        frame_count = 1,
                        width = 1,
                        height = 1,
                        priority = "high"
                    },
                shadow =
                    {
                        filename = "__core__/graphics/empty.png",
                        frame_count = 1,
                        width = 1,
                        height = 1,
                        priority = "high"
                    }
            }
    })

    return name
end

return projectileUtils
