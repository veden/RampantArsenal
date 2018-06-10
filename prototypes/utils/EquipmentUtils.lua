local equipmentUtils = {}

function equipmentUtils.addCategory(eType, category)
    for _,v in pairs(data.raw[eType]) do
	if not v.categories then
	    v.categories = {}
	end
	v.categories[#v.categories+1] = category
    end
end

return equipmentUtils
