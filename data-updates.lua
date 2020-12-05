
local constants = require("libs/Constants")

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


for _,wall in pairs(data.raw["wall"]) do
    wall.hide_resistances = false
end

for _,gate in pairs(data.raw["gate"]) do
    gate.hide_resistances = false
end


