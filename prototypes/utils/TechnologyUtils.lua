local technologyUtils = {}

function technologyUtils.addEffectToTech(tech, recipe)
    local t = data.raw["technology"][tech]
    if t then
	t.effects[#t.effects+1] = recipe
    end
end

function technologyUtils.makeTechnology(attributes)
    local name = attributes.name .. "-technology-rampant-arsenal"
    data:extend({
	    {
		type = "technology",
		name = name,
		icon_size = 128,
		icon = attributes.icon or "__base__/graphics/technology/turrets.png",
		prerequisites = attributes.prerequisites or {"laser-turrets"},
		effects = attributes.effects or 
		    {
			{
			    type = "unlock-recipe",
			    recipe = "gun-turret"
			}
		    },
		unit = {
		    count = attributes.count,
		    ingredients = attributes.ingredients or {{"science-pack-1", 1}},
		    time = attributes.time
		},
		upgrade = attributes.upgrade,
		order = attributes.order or "a-j-a"
	    }	    
    })

    return name
end


return technologyUtils 


