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


local scaleUtils = {}

function scaleUtils.scalePicture(scale, pictureTable, shift)
    for k,v in pairs(pictureTable) do
        if (k == "layers") then
            scaleUtils.scalePicture(scale, v, shift)
        elseif (k == "hr_version") then
            v.scale = scale
            if (shift) then
                v.shift[1] = v.shift[1] * shift
                v.shift[2] = v.shift[2] * shift
                pictureTable.shift[1] = pictureTable.shift[1] * shift
                pictureTable.shift[2] = pictureTable.shift[2] * shift
            end
            pictureTable.scale = 2 * scale
        elseif (type(v) == "table") then
            scaleUtils.scalePicture(scale, v, shift)
        end
    end
end

function scaleUtils.tintPicture(pictureTable, tint)
    for _,v in pairs(pictureTable) do
        if (type(v) == "table") then
            if (v.filename) then
                v.tint = tint
            end
            scaleUtils.tintPicture(v, tint)
        end
    end
end

function scaleUtils.scaleBoundingBox(scale, box)
    return {
        {box[1][1] * scale, box[1][2] * scale},
        {box[2][1] * scale, box[2][2] * scale}
    }
end

return scaleUtils
