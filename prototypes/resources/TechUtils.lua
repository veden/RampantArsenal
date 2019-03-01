local techUtils = {}

function techUtils.addTechnology(attributes)
    local name = attributes.name .. "-technology-rampant-arsenal"

    data:extend({{
		type = "technology",
		name = name,
		icon_size = 128,
		icon = attributes.icon or "__base__/graphics/technology/oil-gathering.png",
		prerequisites = attributes.prerequisites or {"steel-processing"},
		effects = attributes.effects or 
		    {
			{
			    type = "unlock-recipe",
			    recipe = "pumpjack"
			},
			{
			    type = "unlock-recipe",
			    recipe = "oil-refinery"
			},
			{
			    type = "unlock-recipe",
			    recipe = "chemical-plant"
			},
			{
			    type = "unlock-recipe",
			    recipe = "lubricant"
			}
		    },
		unit = attributes.unit or 
		    {
			count = 100,
			ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
			time = 30
		    },
		order = attributes.order or "d-a"
    }})

    return name
end


return techUtils
