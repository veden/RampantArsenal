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


local capsuleUtils = {}

function capsuleUtils.makeCapsule(attributes, attack)
    local name = attributes.name .. "-capsule-rampant-arsenal"

    data:extend({
            {
                type = "capsule",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/grenade.png",
                icon_size = 32,
                flags = {},
                capsule_action = attack or
                    {
                        type = "throw",
                        attack_parameters =
                            {
                                type = "projectile",
                                activation_type = "throw",
                                ammo_category = "grenade",
                                cooldown = 30,
                                projectile_creation_distance = 0.6,
                                range = 15,
                                ammo_type =
                                    {
                                        category = "grenade",
                                        target_type = "position",
                                        action =
                                            {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "projectile",
                                                            projectile = "grenade",
                                                            starting_speed = 0.3
                                                        }
                                                },
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "play-sound",
                                                                        sound = sounds.throw_projectile
                                                                    }
                                                                }
                                                        }
                                                }
                                            }
                                    }
                            }
                    },
                subgroup = attributes.subgroup or "capsule",
                order = attributes.order or "a[grenade]-a[normal]",
                stack_size = attributes.stackSize or 100
            }
    })

    return name
end

return capsuleUtils
