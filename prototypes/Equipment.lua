local Equipment = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local armorUtils = require("utils/ArmorUtils")
local gridUtils = require("utils/GridUtils")
local equipmentUtils = require("utils/EquipmentUtils")

local makeGrid = gridUtils.makeGrid
local changeAmmoCategory = equipmentUtils.changeAmmoCategory
local addEffectToTech = technologyUtils.addEffectToTech
local makeRecipe = recipeUtils.makeRecipe
local addResistance = armorUtils.addResistance
local makeArmor = armorUtils.makeArmor

function Equipment.enable()

    local powerArmor = makeArmor({
	    name = "power-armor-mk3",
	    inventoryBonus = 60,
	    icon = "__RampantArsenal__/graphics/icons/power-armor-mk3.png",
	    durability = 40000,
	    order = "e[power-armor-mk3]",
	    equipmentGrid = makeGrid({
		    name = "power-armor-mk3",
		    width = 12,
		    height = 12
	    }),
	    resistances = {
		{
		    type = "physical",
		    decrease = 20,
		    percent = 70
		},
		{
		    type = "acid",
		    decrease = 24,
		    percent = 70
		},
		{
		    type = "explosion",
		    decrease = 60,
		    percent = 70
		},
		{
		    type = "fire",
		    decrease = 0,
		    percent = 80
		},
		{
		    type = "electric",
		    decrease = 15,
		    percent = 70
		},
		{
		    type = "poison",
		    decrease = 10,
		    percent = 70
		}
	    }
    })

    addResistance("power-armor-mk2", {
		      type = "poison",
		      decrease = 5,
		      percent = 30
    })

    addResistance("power-armor-mk2", {
		      type = "electric",
		      decrease = 10,
		      percent = 50
    })

    addResistance("power-armor-mk2", {
		      type = "acid",
		      decrease = 15,
		      percent = 50
    })

    addResistance("power-armor", {
		      type = "electric",
		      decrease = 5,
		      percent = 40
    })

    addResistance("power-armor", {
		      type = "poison",
		      decrease = 0,
		      percent = 30
    })

    addResistance("modular-armor", {
		      type = "poison",
		      decrease = 0,
		      percent = 20
    })

    addResistance("modular-armor", {
		      type = "electric",
		      decrease = 0,
		      percent = 30
    })


    local beltImmunityRecipe = makeRecipe({
    	    name = "belt-immunity",
    	    icon = "__base__/graphics/equipment/belt-immunity-equipment.png",
    	    enabled = false,
    	    ingredients = {
    		{"steel-plate", 5},
    		{"electric-engine-unit", 5},
    		{"advanced-circuit", 15},
    		{"battery", 5}
    	    },
    	    result = "belt-immunity-equipment"
    })

    local powerArmorRecipe = makeRecipe({
    	    name = "power-armor-mk3",
    	    icon = "__RampantArsenal__/graphics/icons/power-armor-mk3.png",
    	    enabled = false,
    	    ingredients = {
    		{"steel-plate", 30},
    		{"power-armor-mk2", 1},
    		{"processing-unit", 30},
    		{"nuclear-reactor", 1}
    	    },
    	    result = powerArmor
    })

    
    addEffectToTech("rampant-arsenal-technology-power-armor-mk3",
    		    {
    			type = "unlock-recipe",
    			recipe = powerArmorRecipe
    })

    addEffectToTech("modular-armor",
    		    {
    			type = "unlock-recipe",
    			recipe = beltImmunityRecipe
    })

    changeAmmoCategory("active-defense-equipment",
    		       "personal-laser-defense-equipment",
    		       "laser-turret")

    changeAmmoCategory("active-defense-equipment",
    		       "discharge-defense-equipment",
    		       "laser-turret")

    
end

return Equipment
