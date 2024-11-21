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


local landmineUtils = {}

function landmineUtils.makeLandmine(attributes, attack)
    local name = attributes.name .. "-landmine-rampant-arsenal"
    local nameGhostless = attributes.name .. "-landmine-ghostless-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = nameGhostless,
                icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
                icon_size = 32,
                hidden = true,
                subgroup = attributes.subgroup or "enemies",
                order = attributes.order or "b[turret]-a[gun-turret]",
                place_result = nameGhostless,
                stack_size = attributes.stackSize or 50
            },
            {
                type = "item",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
                icon_size = 32,
                flags = attributes.itemFlags or {},
                subgroup = attributes.subgroup or "gun",
                order = attributes.order or "b[turret]-a[gun-turret]",
                place_result = name,
                stack_size = attributes.stackSize or 50
            },
            {
                type = "land-mine",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/land-mine.png",
                icon_size = 32,
                flags =
                    {
                        "placeable-player",
                        "placeable-enemy",
                        "player-creation",
                        "placeable-off-grid",
                        "not-on-map"
                    },
                minable = {mining_time = 1, result = name},
                mined_sound = { filename = "__core__/sound/deconstruct-small.ogg" },
                max_health = 15,
                corpse = "small-remnants",
                collision_box = {{-0.4,-0.4}, {0.4, 0.4}},
                selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                dying_explosion = "explosion-hit",
                create_ghost_on_death = true,
                resistances = attributes.resistances,
                picture_safe = attributes.pictureSafe or
                    {
                        filename = "__base__/graphics/entity/land-mine/land-mine.png",
                        priority = "medium",
                        tint = attributes.tint,
                        width = 32,
                        height = 32
                    },
                picture_set = attributes.pictureSet or
                    {
                        filename = "__base__/graphics/entity/land-mine/land-mine-set.png",
                        priority = "medium",
                        tint = attributes.tint,
                        width = 32,
                        height = 32
                    },
                picture_set_enemy = attributes.pictureSetEnemy or
                    {
                        filename = "__base__/graphics/entity/land-mine/land-mine-set-enemy.png",
                        priority = "medium",
                        tint = attributes.tint,
                        width = 32,
                        height = 32
                    },
                trigger_radius = attributes.triggerRadius or 2.5,
                ammo_category = "landmine",
                action = attack or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                source_effects =
                                    {
                                        {
                                            type = "nested-result",
                                            affects_target = true,
                                            action =
                                                {
                                                    type = "area",
                                                    radius = 6,
                                                    force = "enemy",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "damage",
                                                                        damage = { amount = 300, type = "explosion"}
                                                                    },
                                                                    {
                                                                        type = "create-sticker",
                                                                        sticker = "stun-sticker"
                                                                    }
                                                                }
                                                        }
                                                },
                                        },
                                        {
                                            type = "create-entity",
                                            entity_name = "explosion"
                                        },
                                        {
                                            type = "damage",
                                            damage = { amount = 1000, type = "explosion"}
                                        }
                                    }
                            }
                    }
            },
            {
                type = "land-mine",
                name = nameGhostless,
                icon = attributes.icon or "__base__/graphics/icons/land-mine.png",
                icon_size = 32,
                flags =
                    {
                        "player-creation",
                        "placeable-off-grid",
                        "not-on-map"
                    },
                hidden = true,
                minable = {mining_time = 1, result = name},
                mined_sound = { filename = "__core__/sound/deconstruct-small.ogg" },
                max_health = 15,
                corpse = "small-remnants",
                collision_box = {{-0.4,-0.4}, {0.4, 0.4}},
                selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                dying_explosion = "explosion-hit",
                create_ghost_on_death = false,
                resistances = attributes.resistances,
                timeout = 60,
                picture_safe = attributes.pictureSafe or
                    {
                        filename = "__base__/graphics/entity/land-mine/land-mine.png",
                        priority = "medium",
                        tint = attributes.tint,
                        width = 32,
                        height = 32
                    },
                picture_set = attributes.pictureSet or
                    {
                        filename = "__base__/graphics/entity/land-mine/land-mine-set.png",
                        priority = "medium",
                        tint = attributes.tint,
                        width = 32,
                        height = 32
                    },
                picture_set_enemy = attributes.pictureSetEnemy or
                    {
                        filename = "__base__/graphics/entity/land-mine/land-mine-set-enemy.png",
                        priority = "medium",
                        tint = attributes.tint,
                        width = 32,
                        height = 32
                    },
                trigger_radius = attributes.triggerRadius or 2.5,
                ammo_category = "landmine",
                action = attack or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                source_effects =
                                    {
                                        {
                                            type = "nested-result",
                                            affects_target = true,
                                            action =
                                                {
                                                    type = "area",
                                                    radius = 6,
                                                    force = "enemy",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "damage",
                                                                        damage = { amount = 300, type = "explosion"}
                                                                    },
                                                                    {
                                                                        type = "create-sticker",
                                                                        sticker = "stun-sticker"
                                                                    }
                                                                }
                                                        }
                                                },
                                        },
                                        {
                                            type = "create-entity",
                                            entity_name = "explosion"
                                        },
                                        {
                                            type = "damage",
                                            damage = { amount = 1000, type = "explosion"}
                                        }
                                    }
                            }
                    }
            }
    })


    return name
end

return landmineUtils
