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
                icon_size = 128,
                icon = attributes.icon or "__base__/graphics/technology/turrets.png",
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
