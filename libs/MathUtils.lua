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
