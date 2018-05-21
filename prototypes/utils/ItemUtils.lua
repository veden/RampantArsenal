local itemUtils = {}

function itemUtils.makeItem(attributes, item)
    local name = attributes.name .. "-item-rampant-arsenal"
    data:extend({
	    {
		type = "item",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.flags or {"goes-to-quickbar"},
		subgroup = attributes.subgroup or "defensive-structure",
		order = attributes.order or "b[turret]-a[gun-turret]",
		place_result = item or "gun-turret",
		stack_size = attributes.stackSize or 50
	    }
    })

    return name
end


return itemUtils 
