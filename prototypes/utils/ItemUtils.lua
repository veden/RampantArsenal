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
		fuel_category = attributes.fuelCategory, -- "chemical",
		fuel_value = attributes.fuelValue, --"225MJ",
		fuel_acceleration_multiplier = attributes.accelerationMutlipler, --1.8,
		fuel_top_speed_multiplier = attributes.topSpeedMultipler, --1.15,
		fuel_emissions_multiplier = attributes.fuelEmissionsMultipler,
		fuel_glow_color = attributes.tint, --{r = 0.1, g = 1, b = 0.1},
		place_result = item or "gun-turret",
		stack_size = attributes.stackSize or 50
	    }
    })

    return name
end

function itemUtils.addFuelToItem(attributes)
    
    if data.raw[attributes.eType] and data.raw[attributes.eType][attributes.eName] then
	if attributes.fuelEmissionsMultipler then
	    data.raw[attributes.eType][attributes.eName].fuel_emissions_multiplier = attributes.fuelEmissionsMultipler
	end
	if attributes.fuelCategory then
	    data.raw[attributes.eType][attributes.eName].fuel_category = attributes.fuelCategory
	end
	if attributes.fuelValue then
	    data.raw[attributes.eType][attributes.eName].fuel_value = attributes.fuelValue
	end
	if attributes.accelerationMutlipler then
	    data.raw[attributes.eType][attributes.eName].fuel_acceleration_multiplier = attributes.accelerationMutlipler
	end
	if attributes.topSpeedMultipler then
	    data.raw[attributes.eType][attributes.eName].fuel_top_speed_multiplier = attributes.topSpeedMultipler
	end
	if attributes.tint then
	    data.raw[attributes.eType][attributes.eName].fuel_glow_color = attributes.tint
	end	
    end
end

function itemUtils.modifyItem(attributes)
    
    if data.raw[attributes.eType] and data.raw[attributes.eType][attributes.eName] then
	if attributes.stackSize then
	    data.raw[attributes.eType][attributes.eName].stack_size = attributes.stackSize
	end	
    end
end

return itemUtils 
