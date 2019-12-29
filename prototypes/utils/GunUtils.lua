local gunUtils = {}

function gunUtils.makeGun(attributes, attack)
    local name = attributes.name .. "-gun-rampant-arsenal"

    data:extend({
            {
                type = "gun",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/submachine-gun.png",
                icon_size = 32,
                flags = attributes.flags or {},
                subgroup = "gun",
                order = attributes.order or "a[basic-clips]-b[submachine-gun]",
                attack_parameters = attack or
                    {
                        type = "projectile",
                        ammo_category = "bullet",
                        cooldown = 6,
                        movement_slow_down_factor = 0.7,
                        shell_particle =
                            {
                                name = "shell-particle",
                                direction_deviation = 0.1,
                                speed = 0.1,
                                speed_deviation = 0.03,
                                center = {0, 0.1},
                                creation_distance = -0.5,
                                starting_frame_speed = 0.4,
                                starting_frame_speed_deviation = 0.1
                            },
                        projectile_creation_distance = 1.125,
                        lead_target_for_projectile_speed = attributes.leadDistance,
                        range = 18,
                        sound = make_light_gunshot_sounds(),
                    },
                stack_size = attributes.stackSize or 5
            }
    })

    return name
end

return gunUtils
