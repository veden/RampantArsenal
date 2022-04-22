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


local equipmentUtils = {}

function equipmentUtils.addCategory(eType, category)
    for _,v in pairs(data.raw[eType]) do
        if not v.categories then
            v.categories = {}
        end
        v.categories[#v.categories+1] = category
    end
end

function equipmentUtils.changeAmmoCategory(eType, eName, category)
    local ap = data.raw[eType][eName].attack_parameters
    ap.ammo_category = category
    ap.ammo_type.category = category
end

function equipmentUtils.makeShield(attributes)
    local name = attributes.name .. "-shield-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/energy-shield-equipment.png",
                icon_size = 32,
                placed_as_equipment_result = name,
                flags = {},
                subgroup = attributes.subgroup or "equipment",
                order = attributes.order or "b[shield]-a[energy-shield-equipment]",
                stack_size = 50,
                default_request_amount = 10
            },
            {
                type = "energy-shield-equipment",
                name = name,
                sprite =
                    {
                        filename = attributes.picture or "__base__/graphics/equipment/energy-shield-mk2-equipment.png",
                        width = 64,
                        height = 64,
                        priority = "medium"
                    },
                shape = attributes.shape or
                    {
                        width = 2,
                        height = 3,
                        type = "full"
                    },
                max_shield_value = attributes.maxShield or 500,
                energy_source = attributes.energySource or
                    {
                        type = "electric",
                        buffer_capacity = "360kJ",
                        input_flow_limit = "720kW",
                        usage_priority = "primary-input"
                    },
                energy_per_shield = attributes.energyPerShield or "150kJ",
                categories = {"armor"}
            }
    })


    return name
end


function equipmentUtils.makeBattery(attributes)
    local name = attributes.name .. "-battery-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = name,
                localised_description = {"item-description." .. name},
                icon = attributes.icon or "__base__/graphics/icons/battery-mk2-equipment.png",
                icon_size = 32,
                placed_as_equipment_result = name,
                flags = {},
                subgroup = "equipment",
                order = attributes.order or "c[battery]-b[battery-equipment-mk2]",
                stack_size = 50,
                default_request_amount = 10
            },
            {
                type = "battery-equipment",
                name = name,
                sprite =
                    {
                        filename = attributes.picture or "__base__/graphics/equipment/battery-mk2-equipment.png",
                        width = 32,
                        height = 64,
                        priority = "medium"
                    },
                shape = attributes.shape or
                    {
                        width = 1,
                        height = 2,
                        type = "full"
                    },
                energy_source = attributes.energySource or
                    {
                        type = "electric",
                        buffer_capacity = "100MJ",
                        input_flow_limit = "1GW",
                        output_flow_limit = "1GW",
                        usage_priority = "tertiary"
                    },
                categories = {"armor"}
            }
    })

    return name
end


function equipmentUtils.makeGenerator(attributes)
    local name = attributes.name .. "-generator-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/fusion-reactor-equipment.png",
                icon_size = 32,
                placed_as_equipment_result = name,
                flags = {},
                subgroup = "equipment",
                order = attributes.order or "a[energy-source]-b[fusion-reactor]",
                stack_size = 20
            },
            {
                type = "generator-equipment",
                name = name,
                sprite =
                    {
                        filename = attributes.picture or "__base__/graphics/equipment/fusion-reactor-equipment.png",
                        width = 128,
                        height = 128,
                        priority = "medium"
                    },
                shape = attributes.shape or
                    {
                        width = 4,
                        height = 4,
                        type = "full"
                    },
                burner = attributes.burner,
                energy_source = attributes.energySource or
                    {
                        type = "electric",
                        usage_priority = "primary-output"
                    },
                power = attributes.power or "750kW",
                categories = attributes.categories or {"armor"}
            }
    })

    return name
end



function equipmentUtils.makeActiveDefense(attributes, attack)
    local name = attributes.name .. "-active-defense-rampant-arsenal"
    local nameRemote = attributes.name .. "-active-defense-remote-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/personal-laser-defense-equipment.png",
                icon_size = 32,
                placed_as_equipment_result = name,
                flags = {},
                subgroup = "equipment",
                order = attributes.order or "d[active-defense]-a[personal-laser-defense-equipment]",
                stack_size = 20
            },
            {
                type = "capsule",
                name = nameRemote,
                icon = attributes.remoteIcon or "__base__/graphics/equipment/discharge-defense-equipment-ability.png",
                icon_size = 32,
                flags = {},
                capsule_action =
                    {
                        type = "equipment-remote",
                        equipment = name
                    },
                subgroup = "capsule",
                order = "z",
                stack_size = 1
            },
            {
                type = "recipe",
                name = nameRemote,
                enabled = false,
                ingredients = {{"electronic-circuit", 1}},
                result = nameRemote
            },
            {
                type = "active-defense-equipment",
                name = name,
                ability_icon =
                    {
                        filename = attributes.abilityPicture or "__base__/graphics/equipment/discharge-defense-equipment-ability.png",
                        width = 32,
                        height = 32,
                        priority = "medium"
                    },
                sprite =
                    {
                        filename = attributes.picture or "__base__/graphics/equipment/discharge-defense-equipment.png",
                        width = 64,
                        height = 64,
                        priority = "medium"
                    },
                shape = attributes.shape or
                    {
                        width = 2,
                        height = 2,
                        type = "full"
                    },
                energy_source = attributes.energySource or
                    {
                        type = "electric",
                        usage_priority = "secondary-input",
                        buffer_capacity = "4040kJ"
                    },

                attack_parameters = attack or
                    {
                        type = "projectile",
                        ammo_category = "electric",
                        damage_modifier = 10,
                        cooldown = 150,
                        projectile_center = {0, 0},
                        projectile_creation_distance = 0.6,
                        range = 10,
                        sound =
                            {
                                filename = "__base__/sound/fight/pulse.ogg",
                                volume = 0.7
                            },
                        ammo_type =
                            {
                                type = "projectile",
                                category = "electric",
                                energy_consumption = "2MJ",
                                speed = 1,
                                action =
                                    {
                                        {
                                            type = "area",
                                            radius = 8,
                                            force = "enemy",
                                            action_delivery =
                                                {
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "create-sticker",
                                                                    sticker = "stun-sticker"
                                                                },
                                                                {
                                                                    type = "push-back",
                                                                    distance = 4
                                                                }
                                                            }
                                                    },
                                                    {
                                                        type = "beam",
                                                        beam = "electric-beam-no-sound",
                                                        max_length = 16,
                                                        duration = 15,
                                                        source_offset = {0, -0.5},
                                                        add_to_shooter = false
                                                    }
                                                }
                                        }
                                    }
                            }
                    },

                automatic = false,
                categories = {"armor"}
            }
    })

    return name, nameRemote
end

function equipmentUtils.makePassiveDefense(attributes, attack)
    local name = attributes.name .. "-passive-defense-rampant-arsenal"

    data:extend({
            {
                type = "item",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/personal-laser-defense-equipment.png",
                icon_size = 32,
                placed_as_equipment_result = name,
                flags = {},
                subgroup = attributes.subgroup or "equipment",
                order = attributes.order or "d[active-defense]-a[personal-laser-defense-equipment]",
                stack_size = 20
            },
            {
                type = "active-defense-equipment",
                name = name,
                sprite =
                    {
                        filename = attributes.picture or "__base__/graphics/equipment/personal-laser-defense-equipment.png",
                        width = 64,
                        height = 64,
                        priority = "medium"
                    },
                shape = attributes.shape or
                    {
                        width = 2,
                        height = 2,
                        type = "full"
                    },
                energy_source = attributes.energySource or
                    {
                        type = "electric",
                        usage_priority = "secondary-input",
                        buffer_capacity = "220kJ"
                    },
                attack_parameters = attack or
                    {
                        type = "projectile",
                        ammo_category = "electric",
                        cooldown = 20,
                        damage_modifier = 15,
                        projectile_center = {0, 0},
                        projectile_creation_distance = 0.6,
                        range = 15,
                        sound = make_laser_sounds(),
                        ammo_type =
                            {
                                type = "projectile",
                                category = "electric",
                                energy_consumption = "200kJ",
                                projectile = "laser",
                                speed = 1,
                                action =
                                    {
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    {
                                                        type = "projectile",
                                                        projectile = "laser",
                                                        starting_speed = 0.28
                                                    }
                                                }
                                        }
                                    }
                            }
                    },
                automatic = true,
                categories = {"armor"}
            }
    })

    return name
end


return equipmentUtils
