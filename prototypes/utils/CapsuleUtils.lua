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
