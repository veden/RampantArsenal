local gridUtils = {}

function gridUtils.makeGrid(attributes)
    local name = attributes.name .. "-grid-rampant-arsenal"
    
    data:extend({
	    {
		type = "equipment-grid",
		name = name,
		width = attributes.width or 5,
		height = attributes.height or 5,
		equipment_categories = attributes.categories or {"armor"}
	    }
    })

    return name
end

return gridUtils
