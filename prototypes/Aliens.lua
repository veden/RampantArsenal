local aliens = {}

-- imports

local techUtils = require("prototypes/resources/TechUtils")
local recipeUtils = require("resources/RecipeUtils")
local oilUtils = require("resources/OilUtils")

-- imported functions

local addTechnology = techUtils.addTechnology
local addRecipe = recipeUtils.addRecipe
local addOilWell = oilUtils.addOilWell
local addFluid = oilUtils.addFluid

-- module code

local dirtyAlienGooName
local dirtyAlienGooBlueName
local dirtyAlienGooRedName
local dirtyAlienGooGreenName
local dirtyAlienGooOrangeName
local dirtyAlienGooPurpleName
local dirtyAlienGooYellowName

local alienGooName 
local alienGooBlueName
local alienGooRedName 
local alienGooGreenName
local alienGooOrangeName
local alienGooPurpleName
local alienGooYellowName

local COLOR_DIRTY_GOO = {r=0.51, g=0, b=0.47, a=0.9}
local COLOR_DIRTY_BLUE_GOO = {r=0.04, g=0, b=0.51, a=0.9}
local COLOR_DIRTY_YELLOW_GOO = {r=0.47, g=0.51, b=0.0, a=0.9}
local COLOR_DIRTY_RED_GOO = {r=0.51, g=0.04, b=0, a=0.9}
local COLOR_DIRTY_GREEN_GOO = {r=0, g=0.51, b=0.04, a=0.9}
local COLOR_DIRTY_PURPLE_GOO = {r=0.294, g=0, b=0.51, a=0.9}
local COLOR_DIRTY_ORANGE_GOO = {r=0.51, g=0.294, b=0, a=0.9}

local COLOR_GOO = {r=0.812, g=0, b=0.753, a=0.9}
local COLOR_BLUE_GOO = {r=0.04, g=0.345, b=0.812, a=0.9}
local COLOR_YELLOW_GOO = {r=0.753, g=0.812, b=0.0, a=0.9}
local COLOR_RED_GOO = {r=0.812, g=0, b=0.345, a=0.9}
local COLOR_GREEN_GOO = {r=0, g=0.812, b=0.467, a=0.9}
local COLOR_PURPLE_GOO = {r=0.467, g=0, b=0.812, a=0.9}
local COLOR_ORANGE_GOO = {r=0.812, g=0.467, b=0, a=0.9}

local function enableFluidWells()
    local infiniteWells = settings.startup["rampant-arsenal-infiniteSpouts"].value
    
    dirtyAlienGooName = addOilWell({
	    name = "dirty-alien-goo",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-goo.png"
    })
    dirtyAlienGooBlueName = addOilWell({
	    name = "dirty-alien-goo-blue",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_BLUE_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-blue-goo.png"
    })
    dirtyAlienGooRedName = addOilWell({
	    name = "dirty-alien-goo-red",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_RED_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-red-goo.png"
    })
    dirtyAlienGooGreenName = addOilWell({
	    name = "dirty-alien-goo-green",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_GREEN_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-green-goo.png"
    })
    dirtyAlienGooOrangeName = addOilWell({
	    name = "dirty-alien-goo-orange",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_ORANGE_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-orange-goo.png"
    })
    dirtyAlienGooPurpleName = addOilWell({
	    name = "dirty-alien-goo-purple",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_PURPLE_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-purple-goo.png"
    })
    dirtyAlienGooYellowName = addOilWell({
	    name = "dirty-alien-goo-yellow",
	    infinite = infiniteWells,
	    tint = COLOR_DIRTY_YELLOW_GOO,
	    icon = "__RampantArsenal__/graphics/icons/dirty-yellow-goo.png"
	    
    })
end

local function enableRefinedFluids()    
    alienGooName = addFluid({
    	    name = "alien-goo",
	    tint = COLOR_GOO,
	    icon = "__RampantArsenal__/graphics/icons/goo.png"
    })
    alienGooBlueName = addFluid({
    	    name = "alien-goo-blue",
	    tint = COLOR_BLUE_GOO,
	    icon = "__RampantArsenal__/graphics/icons/blue-goo.png"
    })
    alienGooRedName = addFluid({
    	    name = "alien-goo-red",
	    tint = COLOR_RED_GOO,
	    icon = "__RampantArsenal__/graphics/icons/red-goo.png"
    })
    alienGooGreenName = addFluid({
    	    name = "alien-goo-green",
	    tint = COLOR_GREEN_GOO,
	    icon = "__RampantArsenal__/graphics/icons/green-goo.png"
    })
    alienGooOrangeName = addFluid({
    	    name = "alien-goo-orange",
	    tint = COLOR_ORANGE_GOO,
	    icon = "__RampantArsenal__/graphics/icons/orange-goo.png"
    })
    alienGooPurpleName = addFluid({
    	    name = "alien-goo-purple",
	    tint = COLOR_PURPLE_GOO,
	    icon = "__RampantArsenal__/graphics/icons/purple-goo.png"
    })
    alienGooYellowName = addFluid({
    	    name = "alien-goo-yellow",
	    tint = COLOR_YELLOW_GOO,
	    icon = "__RampantArsenal__/graphics/icons/yellow-goo.png"
    })  
end

local function enableTechnologies()
    local function makeFilterIRecipe(name, category, ingredient, result, item, tint)
	return {
	    type = "unlock-recipe",
	    recipe = addRecipe({
		    name = name,
		    category = category,
		    tint = tint,
		    ingredients = {
			{type="fluid", name=ingredient, amount=100}
		    },
		    results = {
			{type="fluid", name=ingredient, amount=50},
			{type="fluid", name=result, amount=50},
			{type="item", name=item, amount=1}
		    }
	    })
	}	
    end

    addTechnology({
	    name = "alien-goo-filtering",
	    effects = {
		makeFilterIRecipe("alien-goo-filtering",
				  "chemistry",
				  dirtyAlienGooName,
				  alienGooName,
				  "stone",
				  COLOR_DIRTY_GOO),

		makeFilterIRecipe("alien-goo-filtering-blue",
				  "chemistry",
				  dirtyAlienGooBlueName,
				  alienGooBlueName,
				  "copper-ore",
				  COLOR_DIRTY_BLUE_GOO),

		makeFilterIRecipe("alien-goo-filtering-yellow",
				  "chemistry",
				  dirtyAlienGooYellowName,
				  alienGooYellowName,
				  "uranium-ore",
				  COLOR_DIRTY_YELLOW_GOO),

		makeFilterIRecipe("alien-goo-filtering-green",
				  "chemistry",
				  dirtyAlienGooGreenName,
				  alienGooGreenName,
				  "wood",
				  COLOR_DIRTY_GREEN_GOO),

		makeFilterIRecipe("alien-goo-filtering-red",
				  "chemistry",
				  dirtyAlienGooRedName,
				  alienGooRedName,
				  "coal",
				  COLOR_DIRTY_RED_GOO),

		makeFilterIRecipe("alien-goo-filtering-orange",
				  "chemistry",
				  dirtyAlienGooOrangeName,
				  alienGooOrangeName,
				  "sulfur",
				  COLOR_DIRTY_ORANGE_GOO),

		makeFilterIRecipe("alien-goo-filtering-purple",
				  "chemistry",
				  dirtyAlienGooPurpleName,
				  alienGooPurpleName,
				  "iron-ore",
				  COLOR_DIRTY_PURPLE_GOO)
	    }
    })

    addTechnology({
	    name = "rocket-turrets",
	    effects = {
		
		makeFilterIRecipe("alien-goo-filtering-purple",
				  "chemistry",
				  dirtyAlienGooPurpleName,
				  alienGooPurpleName,
				  "iron-ore",
				  COLOR_DIRTY_PURPLE_GOO)
	    }
    })


    -- addTechnology({
-- 	name = "alien-goo-filtering-2",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-filtering-2",
-- 			category = "chemistry",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name=alienGooName, amount=100},
-- 			    {type="item", name="stone", amount=2}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })


-- addTechnology({
-- 	name = "alien-goo-electrolysis",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-electrolysis",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })

-- addTechnology({
-- 	name = "alien-goo-combining",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-combining",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })

-- addTechnology({
-- 	name = "alien-goo-fuel",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-fuel",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })


-- addTechnology({
-- 	name = "alien-goo-aid",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-aid",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })


-- addTechnology({
-- 	name = "alien-goo-solids",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-boiling",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })

-- addTechnology({
-- 	name = "alien-goo-gel",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-gel",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })

-- addTechnology({
-- 	name = "alien-goo-web",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-gel",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })

-- addTechnology({
-- 	name = "alien-goo-combat",
-- 	effects = {
-- 	    {
-- 		type = "unlock-recipe",
-- 		recipe = addRecipe({
-- 			name = "alien-goo-bullets",
-- 			category = "centrifuging",
-- 			ingredients = {
-- 			    {type="fluid", name=dirtyAlienGooName, amount=100}
-- 			},
-- 			results = {
-- 			    {type="fluid", name="steam", amount=70},
-- 			    {type="item", name="iron-plate", amount=1}
-- 			}
-- 		})
-- 	    }
-- 	}
-- })

end

function aliens.addAlienResource()
    enableFluidWells()
    enableRefinedFluids()
    enableTechnologies()
end

return aliens
