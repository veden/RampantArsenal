-- overlays

local radar = util.table.deepcopy(data.raw["radar"]["radar"])
radar.name = "item-collector-base-item-collector"
radar.icon = "__ItemCollector__/graphics/icon/itemCollectorIcon.png"
radar.collision_box = {{-0.35, -0.35}, {0.35, 0.35}}
radar.selection_box = {{-0.485, -0.7}, {0.465, -0.1}}
radar.energy_per_sector = "27MJ"
radar.max_distance_of_nearby_sector_revealed = 1
radar.max_distance_of_sector_revealed = 0
radar.energy_per_nearby_scan = "27MJ"
radar.energy_usage = "450KW"
radar.flags[#radar.flags+1] = "not-deconstructable"
radar.pictures = {
    filename = "__ItemCollector__/graphics/entities/chest/itemCollector.png",
    priority = "low",
    width = 46,
    height = 49,
    apply_projection = false,
    direction_count = 64,
    line_length = 8,
    shift = {0.1875, -0.24}
}
radar.minable = nil

local radarOverlay = util.table.deepcopy(radar)
radarOverlay.name = "item-collector-base-overlay-item-collector"
radarOverlay.pictures.filename = "__ItemCollector__/graphics/entities/chest/itemCollectorOverlay2.png"
radarOverlay.pictures.width = 2048
radarOverlay.pictures.height = 2048
radarOverlay.pictures.direction_count = 1
radarOverlay.pictures.line_length = 1
radarOverlay.pictures.shift[2] = 0.07
radarOverlay.pictures.hr_version = {
    filename = "__ItemCollector__/graphics/entities/chest/itemCollectorOverlay2.5.png",
    priority = "low",
    width = 3200,
    height = 3200,
    apply_projection = false,
    direction_count = 1,
    line_length = 1,
    shift = {0.1875, -0.24}
}

local chest = util.table.deepcopy(data.raw["container"]["steel-chest"])
chest.name = "item-collector-chest-item-collector"
chest.picture = {
    filename = "__core__/graphics/empty.png",
    priority = "low",
    width = 46,
    height = 49,
    line_length = 1,
    shift = {0.1875, -0.2}
}
chest.selection_box = {{-0.485, -0.1}, {0.465, 0.6}}
chest.collision_mask = {}
chest.minable.result = "item-collector-base-item-collector"


data:extend({
	radar,
	radarOverlay,
	chest
})

data:extend({
	{
	    type = "recipe",
	    name = "item-collector-base-item-collector",
	    normal = {
		enabled = false,
		energy_required = 10,
		ingredients = {
		    {"steel-chest", 1},
		    {"accumulator", 1},
		    {"radar", 1}
		},
		result = "item-collector-base-item-collector",
		requester_paste_multiplier = 4
	    },
	    expensive = {
		enabled = false,
		energy_required = 10,
		ingredients = {
		    {"steel-chest", 2},
		    {"accumulator", 2},
		    {"radar", 2}
		},
		result = "item-collector-base-item-collector",
		requester_paste_multiplier = 4
	    }
	},

	{
	    type = "item",
	    name = "item-collector-base-item-collector",
	    icon = "__ItemCollector__/graphics/icon/itemCollectorIcon.png",
	    icon_size = 32,
	    flags = {"goes-to-quickbar"},
	    subgroup = "storage",
	    order = "a[items]-c[steel-collector]",
	    place_result = "item-collector-base-item-collector",
	    stack_size = 50
	},

	{
	    type = "item",
	    name = "item-collector-base-overlay-item-collector",
	    icon = "__ItemCollector__/graphics/icon/itemCollectorIcon.png",
	    icon_size = 32,
	    flags = {"goes-to-quickbar"},
	    subgroup = "storage",
	    order = "a[items]-c[steel-collector]",
	    place_result = "item-collector-base-overlay-item-collector",
	    stack_size = 50
	},
	
	{
	    type = "item",
	    name = "item-collector-chest-item-collector",
	    icon = "__ItemCollector__/graphics/icon/itemCollectorIcon.png",
	    icon_size = 32,
	    flags = {"goes-to-quickbar"},
	    subgroup = "storage",
	    order = "a[items]-c[steel-collector]",
	    place_result = "item-collector-chest-item-collector",
	    stack_size = 50
	}
})

-- technology insertions

data:extend({
	{
	    type = "technology",
	    name = "short-range-electrodynamics-1-item-collector",
	    icon = "__ItemCollector__/graphics/technology/itemCollectorTech.png",
	    icon_size = 128,
	    localised_name = {"technology-name.short-range-electrodynamics-1-item-collector"},
	    effects =
		{
		    {
			type = "unlock-recipe",
			recipe = "item-collector-base-item-collector"
		    }
		},
	    prerequisites = {"electric-energy-accumulators-1"},
	    unit =
		{
		    count = 200,
		    ingredients =
			{
			    {"science-pack-1", 1},
			    {"science-pack-2", 1}
			},
		    time = 22
		},
	    order = "c-e-a",
	},
})

