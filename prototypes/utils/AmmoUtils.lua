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
                ammo_category = attributes.ammoCategory or "capsule",
                ammo_type = attributes.ammoType or
                    {		
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
