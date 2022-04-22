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


local mathUtils = {}

local mLog10 = math.log10
local mSqrt = math.sqrt
local mRandom = math.random

function mathUtils.gaussianRandomRange(mean, std_dev, min, max)
    if (min == max) then
	return min
    end
    local r
    repeat
	local iid1
	local iid2
	local q
	repeat
	    iid1 = 2 * mRandom() + -1
	    iid2 = 2 * mRandom() + -1
	    q = (iid1 * iid1) + (iid2 * iid2)
	until (q ~= 0) and (q < 1)
	local s = mSqrt((-2 * mLog10(q)) / q)
	local v = iid1 * s

	r = mean + (v * std_dev)
    until (r >= min) and (r <= max)
    return r
end

return mathUtils
