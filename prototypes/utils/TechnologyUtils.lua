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


local technologyUtils = {}

function technologyUtils.addEffectToTech(tech, recipe)
    local t = data.raw["technology"]["rampant-arsenal-technology-"..tech]
    if not t then
        t = data.raw["technology"][tech]
    end
    if t then
        if (recipe.type == nil) then
            for _,v in pairs(recipe) do
                t.effects[#t.effects+1] = v
            end
        else
            t.effects[#t.effects+1] = recipe
        end
    else
        error("lookup bad tech - ".. tech)
    end
end

function technologyUtils.modifyInfiniteFormula(tech, formula)
    local t = data.raw["technology"]["rampant-arsenal-technology-"..tech]
    if not t then
        t = data.raw["technology"][tech]
    end
    if t then
        t.unit.count_formula = formula
    else
        error("lookup bad tech - ".. tech)
    end
end

function technologyUtils.removeEffect(tech, field, name)
    local t = data.raw["technology"]["rampant-arsenal-technology-"..tech]
    if not t then
        t = data.raw["technology"][tech]
    end

    local results = {}
    for _,v in pairs(t.effects) do
        if (v.type == field) then
            if (field == "unlock-recipe") and (v.recipe ~= name) then
                results[#results+1] = v
            elseif (field == "turret-attack") and (v.turret_id ~= name) then
                results[#results+1] = v
            end
        else
            results[#results+1] = v
        end
    end
    t.effects = results
end

function technologyUtils.makeTechnology(attributes)
    local name = "rampant-arsenal-technology-" .. attributes.name
    data:extend({
            {
                type = "technology",
                name = name,
                icon_size = attributes.iconSize or 128,
                icon_mipmaps = attributes.iconMipmaps or 1,
                icon = attributes.icon,
                icons = attributes.icons,
                prerequisites = attributes.prerequisites or {},
                effects = attributes.effects or
                    {
                        {
                            type = "unlock-recipe",
                            recipe = "gun-turret"
                        }
                    },
                unit = {
                    count = attributes.count,
                    count_formula = attributes.countForumla, --"2^(L-7)*1000"
                    ingredients = attributes.ingredients or {{"automation-science-pack", 1}},
                    time = attributes.time
                },
                upgrade = attributes.upgrade,
                max_level = attributes.maxLevel,
                order = attributes.order or "a-j-a"
            }
    })

    return name
end

function technologyUtils.makeTechnologies(attributesSet)


end

return technologyUtils
