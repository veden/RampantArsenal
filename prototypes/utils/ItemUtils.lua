-- Copyright (C) 2022  veden

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


local itemUtils = {}

function itemUtils.makeItem(attributes, item)
    local name = attributes.name .. "-item-rampant-arsenal"
    data:extend({
	    {
		type = "item",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/gun-turret.png",
		icon_size = 32,
		flags = attributes.flags or {},
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
