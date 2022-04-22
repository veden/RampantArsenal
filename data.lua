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


-- imports

local turrets = require("prototypes/Turrets")

-- imported functions

local addTurrets = turrets.addTurrets

-- module code

addTurrets()

if settings.startup["rampant-arsenal-enableEquipment"].value then
    for _, animation in ipairs(data.raw["character"]["character"]["animations"]) do
        if animation.armors then
            for _, armor in ipairs(animation.armors) do
                if armor == "power-armor-mk2" then
                    animation.armors[#animation.armors + 1] = "power-armor-mk3-armor-rampant-arsenal"
                    break
                end
            end
        end
    end
end
