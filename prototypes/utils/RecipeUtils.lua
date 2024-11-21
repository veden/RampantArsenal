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


local recipeUtils = {}


local function roundToFloor(number, multiple)
    return math.floor(number / multiple) * multiple
end


function recipeUtils.makeRecipe(attributes)
    if not attributes.expensive then
        attributes.expensive = {
            enabled = attributes.enabled,
            energy_required = (attributes.time or 8) * 2,
            results = attributes.results,
            result = attributes.result,
            ingredients = util.table.deepcopy(attributes.ingredients)
        }
        for _,v in pairs(attributes.expensive.ingredients) do
            if (v.amount ~= nil) then
                v.amount = roundToFloor(v.amount * 1.5, 1)
            else
                v[2] = roundToFloor(v[2] * 1.5, 1)
            end

        end
    end
    data:extend({
            {
                type = "recipe",
                name = attributes.name,
                icon = attributes.icon,
                icons = attributes.icons or {
                    {icon=attributes.icon, tint=attributes.tint, icon_size = attributes.iconSize or 32}
                },
                icon_mipmaps = attributes.iconMipmaps or 1,
                hidden = attributes.hidden,
                category = attributes.category,
                subgroup = attributes.subgroup,
                enabled = attributes.enabled,
                energy_required = attributes.time or 8,		
                ingredients = attributes.ingredients or 
                    {
                        {type="item", name="iron-gear-wheel", amount=10},
                        {type="item", name="copper-plate", amount=10},
                        {type="item", name="iron-plate", amount=20},
                    },
                result = attributes.result,
                results = attributes.results
            }
    })

    return name
end


return recipeUtils 
