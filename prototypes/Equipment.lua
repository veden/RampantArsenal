local Equipment = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local armorUtils = require("utils/ArmorUtils")
local gridUtils = require("utils/GridUtils")
local equipmentUtils = require("utils/EquipmentUtils")

local makeGrid = gridUtils.makeGrid
local changeAmmoCategory = equipmentUtils.changeAmmoCategory
local makeShield = equipmentUtils.makeShield
local makeBattery = equipmentUtils.makeBattery
local makeActiveDefense = equipmentUtils.makeActiveDefense
local makeGenerator = equipmentUtils.makeGenerator
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
		},
		{
		    type = "laser",
		    decrease = 15,
		    percent = 50
		}
	    }
    })

    addResistance("power-armor-mk2", {
		      type = "poison",
		      decrease = 5,
		      percent = 30
    })

    addResistance("power-armor-mk2", {
		      type = "laser",
		      decrease = 10,
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
		      type = "laser",
		      decrease = 5,
		      percent = 20
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

    addResistance("module-armor", {
		      type = "laser",
		      decrease = 5,
		      percent = 10
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

    local shieldMk3 = makeShield({
	    name = "mk3",
	    icon = "__RampantArsenal__/graphics/icons/energy-shield-mk3-equipment.png",
	    picture = "__RampantArsenal__/graphics/equipment/energy-shield-mk3-equipment.png",
	    order = "b[shield]-b[energy-shield-equipment-mk3]",
	    energyPerShield = "50kJ",
	    energySource = {
		type = "electric",
		buffer_capacity = "700kJ",
		input_flow_limit = "1020kW",
		usage_priority = "primary-input"
	    },
	    shape = {
		width = 3,
		height = 3,
		type = "full"
	    }
    })
    
    local shieldMk3Recipe = makeRecipe({
    	    name = "shield-mk3-equipment",
    	    icon = "__RampantArsenal__/graphics/icons/energy-shield-mk3-equipment.png",
    	    enabled = false,
    	    ingredients = {
    		{"energy-shield-mk2-equipment", 10},
    		{"speed-module-3", 20}
    	    },	    
    	    result = shieldMk3
    })

    addEffectToTech("rampant-arsenal-technology-shield-equipment-2",
    		    {
    			type = "unlock-recipe",
    			recipe = shieldMk3Recipe
    })

    local batteryMk3 = makeBattery({
	    name = "mk3",
	    icon = "__RampantArsenal__/graphics/icons/battery-mk3-equipment.png",
	    picture = "__RampantArsenal__/graphics/equipment/battery-mk3-equipment.png",
	    order = "c[battery]-b[battery-equipment-mk3]",
	    energySource = {
		type = "electric",
		buffer_capacity = "750MJ",
		input_flow_limit = "1.25GW",
		output_flow_limit = "1.25GW",
		usage_priority = "terciary"
	    },
	    shape = {
		width = 3,
		height = 2,
		type = "full"
	    }
    })
    
    local batteryMk3Recipe = makeRecipe({
    	    name = "battery-mk3-equipment",
    	    icon = "__RampantArsenal__/graphics/icons/battery-mk3-equipment.png",
    	    enabled = false,
    	    ingredients = {
    		{"battery-mk2-equipment", 10},
		{"effectivity-module-3", 20}
    	    },
    	    result = batteryMk3
    })

    addEffectToTech("rampant-arsenal-technology-battery-equipment-2",
    		    {
    			type = "unlock-recipe",
    			recipe = batteryMk3Recipe
    })

    
    local generatorMk3 = makeGenerator({
	    name = "mk3",
	    icon = "__RampantArsenal__/graphics/icons/generator-mk3-equipment.png",
	    picture = "__RampantArsenal__/graphics/equipment/generator-mk3-equipment.png",
	    order = "a[energy-source]-b[zfusion-reactor]",
	    power = "1300kW",
	    shape = {
		width = 5,
		height = 5,
		type = "full"
	    }
    })
    
    local generatorMk3Recipe = makeRecipe({
    	    name = "generator-mk3-equipment",
    	    icon = "__RampantArsenal__/graphics/icons/generator-mk3-equipment.png",
    	    enabled = false,
    	    ingredients = {
    		{"fusion-reactor-equipment", 5},
		{"productivity-module-3", 20}
    	    },
    	    result = generatorMk3
    })

    addEffectToTech("rampant-arsenal-technology-generator-equipment-2",
    		    {
    			type = "unlock-recipe",
    			recipe = generatorMk3Recipe
    })   
    
    changeAmmoCategory("active-defense-equipment",
    		       "personal-laser-defense-equipment",
    		       "laser-turret")

    changeAmmoCategory("active-defense-equipment",
    		       "discharge-defense-equipment",
    		       "laser-turret")

    
end

return Equipment
