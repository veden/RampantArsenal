-- imports

local oilUtils = require("prototypes/resources/OilUtils")
local techUtils = require("prototypes/resources/TechUtils")
local recipeUtils = require("prototypes/resources/RecipeUtils")

-- imported functions

local addFluid = oilUtils.addFluid
local addTechnology = techUtils.addTechnology
local addRecipe = recipeUtils.addRecipe
local addOilResource = oilUtils.addOilResource

-- moduld code

local dirtyAlienGooName = addFluid({
	name = "dirty-alien-goo"
})
local dirtyAlienGooBlueName = addFluid({
	name = "dirty-alien-goo-blue"
})
local dirtyAlienGooRedName = addFluid({
	name = "dirty-alien-goo-red"
})
local dirtyAlienGooGreenName = addFluid({
	name = "dirty-alien-goo-green"
})
local dirtyAlienGooOrangeName = addFluid({
	name = "dirty-alien-goo-orange"
})
local dirtyAlienGooPurpleName = addFluid({
	name = "dirty-alien-goo-purple"
})
local dirtyAlienGooYellowName = addFluid({
	name = "dirty-alien-goo-yellow"
})

local alienGooName = addFluid({
	name = "alien-goo"
})
local alienGooBlueName = addFluid({
	name = "alien-goo-blue"
})
local alienGooRedName = addFluid({
	name = "alien-goo-red"
})
local alienGooGreenName = addFluid({
	name = "alien-goo-green"
})
local alienGooOrangeName = addFluid({
	name = "alien-goo-orange"
})
local alienGooPurpleName = addFluid({
	name = "alien-goo-purple"
})
local alienGooYellowName = addFluid({
	name = "alien-goo-yellow"
})

addTechnology({
	name = "alien-goo-filtering",
	effects = {
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooName, amount=50},
			    {type="fluid", name=alienGooName, amount=50},
			    {type="item", name="stone", amount=1}
			}
		})
	    },
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-blue",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooBlueName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooBlueName, amount=50},
			    {type="fluid", name=alienGooBlueName, amount=50},
			    {type="item", name="iron-ore", amount=1}
			}
		})
	    },
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-yellow",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooName, amount=50},
			    {type="fluid", name=alienGooName, amount=50},
			    {type="item", name="copper-ore", amount=1}
			}
		})
	    },
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-green",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooName, amount=50},
			    {type="fluid", name=alienGooName, amount=50},
			    {type="item", name="uranium-ore", amount=1}
			}
		})
	    },
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-red",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooName, amount=50},
			    {type="fluid", name=alienGooName, amount=50},
			    {type="item", name="wood", amount=1}
			}
		})
	    },
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-orange",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooName, amount=50},
			    {type="fluid", name=alienGooName, amount=50},
			    {type="item", name="stone", amount=1}
			}
		})
	    },
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-purple",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=dirtyAlienGooName, amount=50},
			    {type="fluid", name=alienGooName, amount=50},
			    {type="item", name="stone", amount=1}
			}
		})
	    }
	}
})

addTechnology({
	name = "alien-goo-filtering-2",
	effects = {
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-filtering-2",
			category = "chemistry",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name=alienGooName, amount=100},
			    {type="item", name="stone", amount=2}
			}
		})
	    }
	}
})

addOilResource(
    {
	name = "dirty-alien-goo",
	infinite = true
    },
    dirtyAlienGooName
)

addOilResource(
    {
	name = "dirty-alien-goo-blue",
	infinite = true
    },
    dirtyAlienGooName
)

addOilResource(
    {
	name = "dirty-alien-goo-yellow",
	infinite = true
    },
    dirtyAlienGooName
)

addOilResource(
    {
	name = "dirty-alien-goo-red",
	infinite = true
    },
    dirtyAlienGooName
)

addOilResource(
    {
	name = "dirty-alien-goo-green",
	infinite = true
    },
    dirtyAlienGooName
)

addTechnology({
	name = "alien-goo-electrolysis",
	effects = {
	    {
		type = "unlock-recipe",
		recipe = addRecipe({
			name = "alien-goo-electrolysis",
			category = "centrifuging",
			ingredients = {
			    {type="fluid", name=dirtyAlienGooName, amount=100}
			},
			results = {
			    {type="fluid", name="steam", amount=70},
			    {type="item", name="iron-plate", amount=1}
			}
		})
	    }
	}
})

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


