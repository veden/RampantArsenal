local armorUtils = {}

function armorUtils.addResistance(name, resistance)
    if data.raw["armor"][name] then
	for i=1,#data.raw["armor"][name].resistances do
	    if (resistance.type == data.raw["armor"][name].resistances[i].type) then
		data.raw["armor"][name].resistances[i] = resistance
		return
	    end
	end
	data.raw["armor"][name].resistances[#data.raw["armor"][name].resistances+1] = resistance
    end
end

function armorUtils.makeArmor(attributes)
    local name = attributes.name .. "-armor-rampant-arsenal"
    
    data:extend({
	    {
		type = "armor",
		name = name,
		icon = attributes.icon or "__base__/graphics/icons/power-armor-mk2.png",
		icon_size = 32,
		flags = {},
		resistances = attributes.resistances or
		    {
			{
			    type = "physical",
			    decrease = 10,
			    percent = 40
			},
			{
			    type = "acid",
			    decrease = 10,
			    percent = 40
			},
			{
			    type = "explosion",
			    decrease = 60,
			    percent = 50
			},
			{
			    type = "fire",
			    decrease = 0,
			    percent = 70
			}
		    },
		durability = attributes.durability,
		subgroup = "armor",
		order = attributes.order or "e[power-armor-mk2]",
		stack_size = 1,
		equipment_grid = attributes.equipmentGrid,
		inventory_size_bonus = attributes.inventoryBonus or 30
	    }
    })

    return name
end

return armorUtils
