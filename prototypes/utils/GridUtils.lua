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


local gridUtils = {}

function gridUtils.makeGrid(attributes)
    local name = attributes.name .. "-grid-rampant-arsenal"
    
    data:extend({
            {
                type = "equipment-grid",
                name = name,
                width = attributes.width or 5,
                height = attributes.height or 5,
                equipment_categories = attributes.categories or {"armor"}
            }
    })

    return name
end

return gridUtils
