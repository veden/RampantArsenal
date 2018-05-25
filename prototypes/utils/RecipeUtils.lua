local recipeUtils = {}

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
	    v[2] = v[2] * 2
	end
    end
    data:extend({
	    {
		type = "recipe",
		name = name,
		icon = attributes.icon,
		icon_size = 32,
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
