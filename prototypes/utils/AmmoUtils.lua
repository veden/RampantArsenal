local ammoUtils = {}

function ammoUtils.makeAmmo(attributes)
    local name = attributes.name .. "-ammo-rampant-arsenal"
    
    data:extend({
            {
                type = "ammo",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/flamethrower-ammo.png",
                icon_size = 32,
                flags = {},
                ammo_type = attributes.ammoType or
                    {		
                        category = "capsuleLauncher",
                        target_type = "position",
                        clamp_position = true,

                        action =
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "stream",
                                        stream = "tank-flamethrower-fire-stream",
                                        max_length = 9,
                                        duration = 160,
                                    }
                            }
                    },
                magazine_size = attributes.magSize or 100,
                subgroup = attributes.subgroup or "ammo",
                order = attributes.order or "f[capsule]",
                stack_size = attributes.stackSize or 100
            }
    })

    return name
end

return ammoUtils
