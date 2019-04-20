local scaleUtils = {}

function scaleUtils.scalePicture(scale, pictureTable, shift)
    for k,v in pairs(pictureTable) do
        if (k == "layers") then
            scaleUtils.scalePicture(scale, v)
        elseif (k == "hr_version") then
            v.scale = scale
            pictureTable.scale = 2 * scale
        elseif (type(v) == "table") then
            scaleUtils.scalePicture(scale, v, shift)
        end
    end
end

return scaleUtils
