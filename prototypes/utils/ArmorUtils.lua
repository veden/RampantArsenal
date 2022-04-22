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


local armorUtils = {}

function armorUtils.addResistance(name, resistance)
    if data.raw["armor"][name] then
        for i=1,#data.raw["armor"][name].resistances do
            if (resistance.type == data.raw["armor"][name].resistances[i].type) then
                data.raw["armor"][name].resistances[i] = resistance
                return
            end
        end
        data.raw["armor"][name].resistances[#data.raw["armor"][name].resistances+1] = resistance
    end
end

function armorUtils.makeArmor(attributes)
    local name = attributes.name .. "-armor-rampant-arsenal"
    
    data:extend({
            {
                type = "armor",
                name = name,
                icon = attributes.icon or "__base__/graphics/icons/power-armor-mk2.png",
                icon_size = 32,
                flags = {},
                resistances = attributes.resistances or
                    {
                        {
                            type = "physical",
                            decrease = 10,
                            percent = 40
                        },
                        {
                            type = "acid",
                            decrease = 10,
                            percent = 40
                        },
                        {
                            type = "explosion",
                            decrease = 60,
                            percent = 50
                        },
                        {
                            type = "fire",
                            decrease = 0,
                            percent = 70
                        }
                    },
                durability = attributes.durability,
                infinite = (not attributes.durability) or nil,
                subgroup = "armor",
                order = attributes.order or "e[power-armor-mk2]",
                stack_size = 1,
                equipment_grid = attributes.equipmentGrid,
                inventory_size_bonus = attributes.inventoryBonus or 30
            }
    })

    return name
end

return armorUtils
