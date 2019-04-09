local power = {}

local recipeUtils = require("utils/RecipeUtils")
local itemUtils = require("utils/ItemUtils")
local powerUtils = require("utils/PowerUtils")
local technologyUtils = require("utils/TechnologyUtils")

local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local makeOilBurner = powerUtils.makeOilBurner
local addFuelToItem = itemUtils.addFuelToItem

function power.enable()

    local oilBurner = makeOilBurner({
	    name = "basic",
	    icon = "__RampantArsenal__/graphics/icons/oil-burner.png",
	    burnFluid = true,
	    scaleFluidUsage = true,
	    fluidPerTick = 1,
	    effectivity = 0.60,
	    maxTemp = 25,
	    emissions = 0.00004,
	    scale = 0.5,
	    tint = { r = 0.7, g = 0.4, b = 0, a = 1 }
    })
        
    makeRecipe({
	    name = oilBurner,
	    icon = "__RampantArsenal__/graphics/icons/oil-burner.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"chemical-plant", 1},
		{"steel-furnace", 1},
		{"electronic-circuit", 30},
		{"copper-plate", 20}
	    },
	    result = oilBurner
    })
        
    addEffectToTech("rampant-arsenal-technology-oil-burner",
		    {
			type = "unlock-recipe",
			recipe = oilBurner
    })
    
    addFuelToItem({
	    eType = "fluid",
	    eName = "light-oil",
	    fuelValue = "0.75MJ",
	    fuelEmissionsMultipler = 2
    })
    
    addFuelToItem({
	    eType = "fluid",
	    eName = "crude-oil",
	    
	    fuelValue = "1.15MJ",
	    fuelEmissionsMultipler = 4
    })
    
    addFuelToItem({
	    eType = "fluid",
	    eName = "heavy-oil",
	    fuelValue = "0.5MJ",
	    fuelEmissionsMultipler = 3
    })

    addFuelToItem({
	    eType = "fluid",
	    eName = "petroleum-gas",
	    fuelValue = "1.75MJ",
	    fuelEmissionsMultipler = 1.5
    })
    
end

return power
