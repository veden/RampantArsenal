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


