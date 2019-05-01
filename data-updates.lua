
local constants = require("libs/Constants")

-- data.raw.fluid["alien-goo"].emissions_multiplier = 3
-- data.raw.fluid["alien-goo"].fuel_value = "2.5MJ"

-- data.raw["assembling-machine"]["centrifuge"].fluid_boxes =
--     {
-- 	{
-- 	    production_type = "input",
-- 	    pipe_covers = pipecoverspictures(),
-- 	    base_area = 10,
-- 	    base_level = -1,
-- 	    pipe_connections = {{ type="input", position = {-1, -2} }}
-- 	},
-- 	{
-- 	    production_type = "input",
-- 	    pipe_covers = pipecoverspictures(),
-- 	    base_area = 10,
-- 	    base_level = -1,
-- 	    pipe_connections = {{ type="input", position = {1, -2} }}
-- 	},
-- 	{
-- 	    production_type = "output",
-- 	    pipe_covers = pipecoverspictures(),
-- 	    base_level = 2,
-- 	    pipe_connections = {{ position = {-1, 2} }}
-- 	},
-- 	{
-- 	    production_type = "output",
-- 	    pipe_covers = pipecoverspictures(),
-- 	    base_level = 2,
-- 	    pipe_connections = {{ position = {1, 2} }}
-- 	}
--     }

if mods["Power Armor MK3"] then
    local grids = data.raw["equipment-grid"]["larger-equipment-grid"].equipment_categories
    grids[#grids+1] = "adv-generator"

    grids = data.raw["equipment-grid"]["largest-equipment-grid"].equipment_categories
    grids[#grids+1] = "adv-generator"
end

if mods["Power Armor MK4"] then
    local grids = data.raw["equipment-grid"]["gigantic-equipment-grid"].equipment_categories
    grids[#grids+1] = "adv-generator"
end

if mods["bobwarfare"] then
    local grids = data.raw["equipment-grid"]["power-armor-equipment-grid-mk3"].equipment_categories
    if grids then
        grids[#grids+1] = "adv-generator"
    end

    grids = data.raw["equipment-grid"]["power-armor-equipment-grid-mk4"].equipment_categories
    if grids then
        grids[#grids+1] = "adv-generator"
    end

    grids = data.raw["equipment-grid"]["power-armor-equipment-grid-mk5"].equipment_categories
    if grids then
        grids[#grids+1] = "adv-generator"
    end
end
