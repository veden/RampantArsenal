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


local walls = {}

local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local wallUtils = require("utils/WallUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeWall = wallUtils.makeWall
local addResistance = wallUtils.addResistance
local makeGate = wallUtils.makeGate

function walls.enable()

    local mendingWallResistance = {
        {
            type = "physical",
            decrease = 3,
            percent = 20
        },
        {
            type = "impact",
            decrease = 45,
            percent = 60
        },
        {
            type = "explosion",
            decrease = 10,
            percent = 30
        },
        {
            type = "acid",
            percent = 30
        },
        {
            type = "fire",
            percent = 100
        },
        {
            type = "laser",
            percent = 40
        },
        {
            type = "electric",
            percent = 30
        },
        {
            type = "poison",
            percent = 30
        }
    }

    if mods["bobwarfare"] then
        mendingWallResistance[#mendingWallResistance+1] = {
            type = "bob-pierce",
            percent = 25,
            decrease = 20
        }
        mendingWallResistance[#mendingWallResistance+1] = {
            type = "plasma",
            percent = 100
        }
    end

    local mendingWall,mendingWallItem = makeWall(
        {
            name = "mending",
            icon = "__RampantArsenal__/graphics/icons/mending-wall.png",
            health = 1000,
            healing = 1,
            tint = {r=0.5,g=0.60,b=0.5,a=1},
            order = "a[stone-wall]-a[zmending-wall]",
            resistances = mendingWallResistance
        },
        {
            range = 18,
            cooldown = 30,
            action = {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",

                        source_effects =
                            {
                                {
                                    type = "create-entity",
                                    trigger_created_entity = true,
                                    entity_name = "small-repair-cloud-rampant-arsenal",
                                    show_in_tooltip = true
                                }
                            }
                    }
            }
        }
    )

    local mendingGate,mendingGateItem = makeGate(
        {
            name = "mending",
            icon = "__RampantArsenal__/graphics/icons/mending-gate.png",
            health = 1000,
            healing = 1,
            tint = {r=0.5,g=0.60,b=0.5,a=1},
            order = "a[wall]-b[gatez]",
            resistances = mendingWallResistance
        },
        {
            range = 18,
            cooldown = 30,
            action = {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",

                        source_effects =
                            {
                                {
                                    type = "create-entity",
                                    trigger_created_entity = true,
                                    entity_name = "small-repair-cloud-rampant-arsenal",
                                    show_in_tooltip = true
                                }
                            }
                    }
            }
        }
    )

    makeRecipe({
            name = mendingWallItem,
            icon = "__RampantArsenal__/graphics/icons/mending-wall.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="stone-wall", amount=1},
                {type="item", name="repair-capsule-rampant-arsenal", amount=1}
            },
            results = {{type="item", name=mendingWallItem, amount=1}}
    })

    makeRecipe({
            name = mendingGateItem,
            icon = "__RampantArsenal__/graphics/icons/mending-gate.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="mending-wall-rampant-arsenal", amount=1},
                {type="item", name="steel-plate", amount=1},
                {type="item", name="advanced-circuit", amount=5}
            },
            results = {{type="item", name=mendingGateItem, amount=1}}
    })

    addEffectToTech("regeneration-walls",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = mendingGateItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = mendingWallItem
                        }
    })

    local reinforcedWallResistance = {
                {
                    type = "physical",
                    decrease = 6,
                    percent = 40
                },
                {
                    type = "impact",
                    decrease = 45,
                    percent = 80
                },
                {
                    type = "explosion",
                    decrease = 20,
                    percent = 60
                },
                {
                    type = "acid",
                    percent = 70
                },
                {
                    type = "fire",
                    percent = 100
                },
                {
                    type = "laser",
                    percent = 60
                },
                {
                    type = "electric",
                    percent = 60
                },
                {
                    type = "poison",
                    percent = 60
                }
    }

    if mods["bobwarfare"] then
        reinforcedWallResistance[#reinforcedWallResistance+1] = {
            type = "bob-pierce",
            percent = 25,
            decrease = 20
        }
        reinforcedWallResistance[#reinforcedWallResistance+1] = {
            type = "plasma",
            percent = 100
        }
    end

    local reinforcedWall,reinforcedWallItem = makeWall(
        {
            name = "reinforced",
            icon = "__RampantArsenal__/graphics/icons/reinforced-wall.png",
            health = 1500,
            tint = {r=0.5,g=0.5,b=0.60,a=1},
            order = "a[stone-wall]-a[zreinforced-wall]",
            resistances = reinforcedWallResistance
        }
    )

    local reinforcedGate,reinforcedGateItem = makeGate(
        {
            name = "reinforced",
            icon = "__RampantArsenal__/graphics/icons/reinforced-gate.png",
            health = 1500,
            tint = {r=0.5,g=0.5,b=0.9,a=1},
            order = "a[wall]-b[gatezz]",
            resistances = reinforcedWallResistance
        }
    )

    makeRecipe({
            name = reinforcedWallItem,
            icon = "__RampantArsenal__/graphics/icons/reinforced-wall.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="refined-concrete", amount=5}
            },
            results = {{type="item", name=reinforcedWallItem, amount=1}}
    })

    makeRecipe({
            name = reinforcedGateItem,
            icon = "__RampantArsenal__/graphics/icons/reinforced-gate.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="reinforced-wall-rampant-arsenal", amount=1},
                {type="item", name="steel-plate", amount=1},
                {type="item", name="advanced-circuit", amount=5}
            },
            results = {{type="item", name=reinforcedGateItem, amount=1}}
    })

    addEffectToTech("stone-walls-2",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = reinforcedGateItem
                        },
                        {
                            type = "unlock-recipe",
                            recipe = reinforcedWallItem
                        }
    })

    addResistance("wall",
                  "stone-wall",
                  {
                      type = "laser",
                      percent = 30
    })


    addResistance("wall",
                  "stone-wall",
                  {
                      type = "electric",
                      percent = 20
    })

    addResistance("wall",
                  "stone-wall",
                  {
                      type = "acid",
                      percent = 15
    })

    addResistance("wall",
                  "stone-wall",
                  {
                      type = "poison",
                      percent = 20
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "laser",
                      percent = 30
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "acid",
                      percent = 15
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "electric",
                      percent = 20
    })

    addResistance("gate",
                  "gate",
                  {
                      type = "poison",
                      percent = 20
    })
end

return walls
