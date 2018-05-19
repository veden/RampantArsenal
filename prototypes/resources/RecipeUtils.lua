local recipeUtils = {}

function recipeUtils.addRecipe(attributes)
    local name = attributes.name .. "-recipe-rampant-arsenal"

    data:extend({{
		type = "recipe",
		name = name,
		category = attributes.category or "oil-processing",
		enabled = attributes.enabled,
		energy_required = attributes.energyRequired or 5,
		ingredients = attributes.ingredients or
		    {
			{type="fluid", name="crude-oil", amount=100}
		    },
		results= attributes.results or
		    {
			{type="fluid", name="heavy-oil", amount=30},
			{type="item", name="solid-fuel", amount=1},
			{type="fluid", name="petroleum-gas", amount=40}
		    },
		icon = attributes.icon or "__base__/graphics/icons/fluid/basic-oil-processing.png",
		icon_size = 32,
		subgroup = attributes.subgroup or "fluid-recipes",
		order = attributes.order or "a[oil-processing]-a[basic-oil-processing]"
    }})

    return name
end


return recipeUtils
