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
                icon_size = attributes.iconSize or 32,
                icon_mipmaps = attributes.iconMipmaps or 1,
                hidden = attributes.hidden,
                category = attributes.category,
                subgroup = attributes.subgroup,
                normal = {
                    enabled = attributes.enabled,
                    energy_required = attributes.time or 8,		
                    ingredients = attributes.ingredients or 
                        {
                            {"iron-gear-wheel", 10},
                            {"copper-plate", 10},
                            {"iron-plate", 20}
                        },
                    result = attributes.result,
                    results = attributes.results
                },
                expensive = attributes.expensive
            }
    })

    return name
end


return recipeUtils 
