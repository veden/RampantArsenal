local equipmentUtils = {}

function equipmentUtils.addCategory(eType, category)
    for _,v in pairs(data.raw[eType]) do
	if not v.categories then
	    v.categories = {}
	end
	v.categories[#v.categories+1] = category
    end
end

function equipmentUtils.changeAmmoCategory(eType, eName, category)
    local ap = data.raw[eType][eName].attack_parameters
    ap.ammo_category = category
    ap.ammo_type.category = category
end

function equipmentUtils.makeShield(attributes)
    local name = attributes.name .. "-shield-rampant-arsenal"

    data:extend({
	    {
		type = "energy-shield-equipment",
		name = name,
		sprite =
		    {
			filename = "__base__/graphics/equipment/energy-shield-mk2-equipment.png",
			width = 64,
			height = 64,
			priority = "medium"
		    },
		shape =
		    {
			width = 2,
			height = 3,
			type = "full"
		    },
		max_shield_value = attributes.maxShield or 500,
		energy_source = attributes.energySource or 
		    {
			type = "electric",
			buffer_capacity = "360kJ",
			input_flow_limit = "720kW",
			usage_priority = "primary-input"
		    },
		energy_per_shield = attributes.energyPerShield or "150kJ",
		categories = {"armor"}
	    }	    
    })

    
    return name
end


function equipmentUtils.makeBattery(attributes)
    local name = attributes.name .. "-battery-rampant-arsenal"

    data:extend({
	    {
		type = "battery-equipment",
		name = name,
		sprite =
		    {
			filename = "__base__/graphics/equipment/battery-mk2-equipment.png",
			width = 32,
			height = 64,
			priority = "medium"
		    },
		shape =
		    {
			width = 1,
			height = 2,
			type = "full"
		    },
		energy_source =
		    {
			type = "electric",
			buffer_capacity = "100MJ",
			input_flow_limit = "1GW",
			output_flow_limit = "1GW",
			usage_priority = "terciary"
		    },
		categories = {"armor"}
	    }	    
    })

    
    return name
end


function equipmentUtils.makeGenerator(attributes)
    local name = attributes.name .. "-generator-rampant-arsenal"

    data:extend({
	    {
		type = "generator-equipment",
		name = name,
		sprite =
		    {
			filename = "__base__/graphics/equipment/fusion-reactor-equipment.png",
			width = 128,
			height = 128,
			priority = "medium"
		    },
		shape =
		    {
			width = 4,
			height = 4,
			type = "full"
		    },
		energy_source =
		    {
			type = "electric",
			usage_priority = "primary-output"
		    },
		power = "750kW",
		categories = {"armor"}
	    }	    
    })

    
    return name
end



function equipmentUtils.makeActiveDefense(attributes, attack)
    local name = attributes.name .. "-active-defense-rampant-arsenal"

    data:extend({
	    {
		type = "active-defense-equipment",
		name = name,
		sprite =
		    {
			filename = "__base__/graphics/equipment/personal-laser-defense-equipment.png",
			width = 64,
			height = 64,
			priority = "medium"
		    },
		shape =
		    {
			width = 2,
			height = 2,
			type = "full"
		    },
		energy_source =
		    {
			type = "electric",
			usage_priority = "secondary-input",
			buffer_capacity = "220kJ"
		    },
		attack_parameters = attack or
		    {
			type = "projectile",
			ammo_category = "electric",
			cooldown = 20,
			damage_modifier = 15,
			projectile_center = {0, 0},
			projectile_creation_distance = 0.6,
			range = 15,
			sound = make_laser_sounds(),
			ammo_type =
			    {
				type = "projectile",
				category = "electric",
				energy_consumption = "200kJ",
				projectile = "laser",
				speed = 1,
				action =
				    {
					{
					    type = "direct",
					    action_delivery =
						{
						    {
							type = "projectile",
							projectile = "laser",
							starting_speed = 0.28
						    }
						}
					}
				    }
			    }
		    },
		automatic = true,
		categories = {"armor"}
	    }
    })

    
    return name
end

return equipmentUtils
