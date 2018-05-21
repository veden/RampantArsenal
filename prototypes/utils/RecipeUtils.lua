local recipeUtils = {}

function recipeUtils.makeRecipe(attributes)
    local name = attributes.name .. "-recipe-rampant-arsenal"
    data:extend({
	    {
		type = "recipe",
		name = name,
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
	    }
    })

    return name
end


return recipeUtils 
