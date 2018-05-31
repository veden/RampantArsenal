local oilUtils = {}

function oilUtils.addFluid(attributes)

    local name = attributes.name .. "-fluid-rampant-arsenal"
    
    data:extend({{
		type = "fluid",
		name = name,
		default_temperature = attributes.defaultTemp or 25,
		heat_capacity = attributes.heatCapacity or "0.1KJ",
		base_color = attributes.baseColor or {r=0, g=0, b=0},
		flow_color = attributes.flowColor or {r=0.5, g=0.5, b=0.5},
		max_temperature = attributes.maxTemp or 100,
		icon = attributes.icon or "__base__/graphics/icons/fluid/crude-oil.png",
		-- icons = {
		--     {icon = "__base__/graphics/icons/fluid/crude-oil.png", tint = attributes.tint},
		-- },
		icon_size = 32,
		pressure_to_speed_ratio = 0.4,
		flow_to_energy_ratio = 0.59,
		emissions_multiplier = attributes.emissionsMultiplier,
		fuel_value = attributes.fuelValue, --"8MJ"
		order = attributes.order or "a[fluid]-b[crude-oil]"
    }})
    
    return name
end

function oilUtils.addOilResource(attributes, fluidName)
    local name = attributes.name .. "-resource-rampant-arsenal"
    
    data:extend({{
		type = "resource",
		name = name,
		icons = {
		    {icon="__base__/graphics/icons/crude-oil.png"}		    
		},
		icon_size = 32,
		flags = {"placeable-neutral"},
		category = attributes.category or "basic-fluid",
		order= attributes.order or "a-b-a",
		infinite = attributes.infinite,
		highlight = true,
		minimum = attributes.minimum or 60000,
		normal = attributes.normal or 300000,
		infinite_depletion_amount = attributes.infiniteDepletion or 10,
		resource_patch_search_radius = 12,
		tree_removal_probability = 0.7,
		tree_removal_max_distance = 32 * 32,
		minable =
		    {
			hardness = 1,
			mining_time = 1,
			results =
			    {
				{
				    type = "fluid",
				    name = fluidName,
				    amount_min = 10,
				    amount_max = 10,
				    probability = 1
				}
			    }
		    },
		collision_box = {{ -1.4, -1.4}, {1.4, 1.4}},
		selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
		stage_counts = {0},
		stages =
		    {
			sheet =
			    {
				filename = attributes.picture or "__base__/graphics/entity/crude-oil/crude-oil.png",
				priority = "extra-high",
				width = 75,
				height = 61,
				frame_count = 4,
				variation_count = 1,
				tint = attributes.tint
			    }
		    },
		map_color = attributes.mapColor or {r=0.78, g=0.2, b=0.77},
		map_grid = false
    }})
    
    return name
end

function oilUtils.addOilWell(attributes)
    local fluid = oilUtils.addFluid(attributes)
    oilUtils.addOilResource(attributes, fluid)
    return fluid
end

return oilUtils
