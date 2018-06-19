local recipeUtils = {}


local function roundToFloor(number, multiple)
    return math.floor(number / multiple) * multiple
end


function recipeUtils.makeRecipe(attributes)
    local name = attributes.name .. "-recipe-rampant-arsenal"
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
		name = name,
		icon = attributes.icon,
		icon_size = 32,
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
		    result = attributes.result or "gun-turret",
		    results = attributes.results
		},
		expensive = attributes.expensive
	    }
    })

    return name
end


return recipeUtils 
