local vehicles = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local vehicleUtils = require("utils/VehicleUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeTank = vehicleUtils.makeTank
local makeCar = vehicleUtils.makeCar
local makeTrain = vehicleUtils.makeTrain

function vehicles.enable()

    local advTank = makeTank({
	    name = "advanced",
	    scale = 0.8,
	    collisionBox = {{-1.8, -2.4}, {1.8, 2.4}},
	    selectionBox = {{-1.8, -2.4}, {1.8, 2.4}},
	    drawingBox = {{-3.4, -3.4}, {3.4, 2.8}},
	    tint = { r = 0.35, g = 0, b = 0, a = 1 },
	    {
		fuel_category = "chemical",
		effectivity = 0.75,
		fuel_inventory_size = 2,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    }
    })

    local nuclearTank = makeTank({
	    name = "nuclear",
	    scale = 1,
	    collision_box = {{-0.9, -1.3}, {0.9, 1.3}},
	    selection_box = {{-0.9, -1.3}, {0.9, 1.3}},
	    drawing_box = {{-1.8, -1.8}, {1.8, 1.5}},
    
	    collisionBox = {{-1.8, -2.6}, {1.9, 2.6}},
	    selectionBox = {{-1.8, -2.6}, {1.9, 2.6}},
	    drawingBox = {{-3.6, -3.6}, {3.4, 2.8}},
	    tint = { r = 0, g = 0.35, b = 0, a = 1 },
	    energySource = {
		fuel_category = "nuclear",
		effectivity = 0.9,
		fuel_inventory_size = 2,
		burnt_inventory_size = 2,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    }
    })

    local advCar = makeCar({
	    name = "advanced",
	    scale = 0.6,
	    collisionBox = {{-0.9, -1.2}, {0.9, 1.2}},
	    selectionBox = {{-0.9, -1.2}, {0.9, 1.2}},
	    tint = { r = 0.35, g = 0, b = 0, a = 1 },
    })

    local nuclearCar = makeCar({
	    name = "nuclear",
	    scale = 0.7,
	    collisionBox = {{-1.1, -1.4}, {1.1, 1.4}},
	    selectionBox = {{-1.1, -1.4}, {1.1, 1.4}},
	    tint = { r = 0, g = 0.35, b = 0, a = 1 },
	    energySource = {
		fuel_category = "nuclear",
		effectivity = 1,
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    }
    })

    local advTrain = makeTrain({
	    name = "advanced",
	    scale = 0.5,
	    tint = { r = 0.35, g = 0, b = 0, a = 1 },
    })
    
    local nuclearTrain = makeTrain({
	    name = "nuclear",
	    scale = 0.5,
	    tint = { r = 0, g = 0.35, b = 0, a = 1 },
	    energySource = {
		fuel_category = "nuclear",
		effectivity = 0.9,
		fuel_inventory_size = 2,
		burnt_inventory_size = 2,
		smoke =
		    {
			{
			    name = "tank-smoke",
			    deviation = {0.25, 0.25},
			    frequency = 50,
			    position = {0, 1.5},
			    starting_frame = 0,
			    starting_frame_deviation = 60
			}
		    }
	    }
    })    

    
    local advTankRecipe = makeRecipe({
	    name = "advanced-tank",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"iron-plate", 1},
		{"explosives", 6}
	    },
	    result = advTank,
    })

    local nuclearTankRecipe = makeRecipe({
	    name = "nuclear-tank",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"iron-plate", 1},
		{"explosives", 6}
	    },
	    result = nuclearTank,
    })

    
    local advCarRecipe = makeRecipe({
	    name = "advanced-car",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"iron-plate", 1},
		{"explosives", 6}
	    },
	    result = advCar,
    })

    
    local nuclearCarRecipe = makeRecipe({
	    name = "nuclear-car",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"iron-plate", 1},
		{"explosives", 6}
	    },
	    result = nuclearCar,
    })

    local advTrainRecipe = makeRecipe({
	    name = "advanced-train",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"iron-plate", 1},
		{"explosives", 6}
	    },
	    result = advTrain,
    })

    
    local nuclearTrainRecipe = makeRecipe({
	    name = "nuclear-train",
	    icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
	    enabled = false,
	    category = "crafting",
	    ingredients = {
		{"explosive-cannon-shell", 1},
		{"iron-plate", 1},
		{"explosives", 6}
	    },
	    result = nuclearTrain,
    })


    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = advTankRecipe
    })
    
    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = nuclearTankRecipe
    })

    
    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = advCarRecipe
    })
    
    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = nuclearCarRecipe
    })

    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = advTrainRecipe
    })
    
    addEffectToTech("he-cannon-shells",
		    {
			type = "unlock-recipe",
			recipe = nuclearTrainRecipe
    })

end

return vehicles
