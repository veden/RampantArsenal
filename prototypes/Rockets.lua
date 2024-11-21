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


local rockets = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")

local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeRocketProjectile = projectileUtils.makeRocketProjectile
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local function rocketSheetMk1()
    return
        {
            layers =
            {
                {
                    filename = "__RampantArsenal__/graphics/yuokiTani/entities/rocket-mk1-sheet.png",
                    priority = "high",
                    width = 72,
                    height = 80,
                    line_length = 16,
                    axially_symmetrical = false,
                    direction_count = 64,
                    frame_count = 1,
                    shift = {0.35, 0},
                }
            }
        }

end

local function rocketSheetMk2()
    return
        {
            layers =
            {
                {
                    filename = "__RampantArsenal__/graphics/yuokiTani/entities/rocket-mk2-sheet.png",
                    priority = "high",
                    width = 88,
                    height = 80,
                    line_length = 16,
                    axially_symmetrical = false,
                    direction_count = 64,
                    frame_count = 1,
                    shift = {0.1, -0.15},
                }
            }
        }

end

function rockets.enable()

    local entity = {
        name = "rocket",
        icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
        miningTime = 1,
        health = 800,
        order = "b[turret]-a[zzzracket-turret]",
        collisionBox = {{-0.75, -0.75}, {0.75, 0.75}},
        selectionBox = {{-0.5, -1}, {0.5, 1}},
        foldedAnimation = rocketSheetMk1(),
        foldingAnimation = rocketSheetMk1(),
        preparedAnimation = rocketSheetMk1(),
        preparingAnimation = rocketSheetMk1(),
        hasBaseDirection = true,
        rotationSpeed = 0.002,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 60
            },
            {
                type = "laser",
                percent = 60
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local rocketTurret, rocketTurretItem = makeAmmoTurret(entity,
                                                          {
                                                              type = "projectile",
                                                              ammo_category = "rocket",
                                                              cooldown = 300,
                                                              projectile_creation_distance = 1.39375,
                                                              projectile_center = {0, -0.0875},
                                                              min_range = 20,
                                                              turn_range = 0.30,
                                                              range = 52,
                                                              sound = {
                                                                  {
                                                                      filename = "__base__/sound/fight/rocket-launcher.ogg",
                                                                      volume = 0.7
                                                                  }
                                                              }
    })

    local entity1 = {
        name = "rapid-rocket",
        icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
        miningTime = 1,
        health = 1800,
        order = "b[turret]-a[zzzrzcket-turret]",
        foldedAnimation = rocketSheetMk2(),
        foldingAnimation = rocketSheetMk2(),
        preparedAnimation = rocketSheetMk2(),
        preparingAnimation = rocketSheetMk2(),
        hasBaseDirection = true,
        rotationSpeed = 0.005,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 10
            },
            {
                type = "physical",
                percent = 10
            },
            {
                type = "acid",
                percent = 30
            },
            {
                type = "electric",
                percent = 60
            },
            {
                type = "laser",
                percent = 60
            },
            {
                type = "poison",
                percent = 30
            }
        }
    }
    local rapidRocketTurret, rapidRocketTurretItem = makeAmmoTurret(entity1, {
                                                                        type = "projectile",
                                                                        ammo_category = "rocket",
                                                                        cooldown = 50,
                                                                        projectile_creation_distance = 1.39375,
                                                                        projectile_center = {0, -0.0875},
                                                                        min_range = 20,
                                                                        turn_range = 0.30,
                                                                        range = 42,
                                                                        sound = {
                                                                            {
                                                                                filename = "__base__/sound/fight/rocket-launcher.ogg",
                                                                                volume = 0.7
                                                                            }
                                                                        }
    })

    makeRecipe({
            name = rocketTurretItem,
            icon = "__RampantArsenal__/graphics/icons/rocketTurret.png",
            enabled = false,
            ingredients = {
                {type="item", name="electronic-circuit", amount=20},
                {type="item", name="steel-plate", amount=10},
                {type="item", name="iron-gear-wheel", amount=15},
            },
            results = {{type="item", name=rocketTurretItem, amount=1}}
    })

    makeRecipe({
            name = rapidRocketTurretItem,
            icon = "__RampantArsenal__/graphics/icons/rapidRocketTurret.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=30},
                {type="item", name="advanced-circuit", amount=30},
                {type="item", name="engine-unit", amount=10},
                {type="item", name="copper-plate", amount=20}
            },
            results = {{type="item", name=rapidRocketTurretItem, amount=1}}
    })

    addEffectToTech("rocket-turret-1",
                    {
                        type = "unlock-recipe",
                        recipe = rocketTurretItem,
    })


    addEffectToTech("rocket-turret-2",
                    {
                        type = "unlock-recipe",
                        recipe = rapidRocketTurretItem,
    })

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then

        local incendiaryRocketAmmo = makeAmmo({
                name = "incendiary-rocket",
                icon = "__RampantArsenal__/graphics/icons/incendiary-rocket.png",
                order = "d[rocket-launcher]-b[incendiary]",
                magSize = 1,
                stackSize = 200,
                ammoCategory = "rocket",
                ammoType = {
                    action =
                        {
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "instant",
                                        source_effects =
                                            {
                                                {
                                                    type = "create-explosion",
                                                    entity_name = "explosion-gunshot"
                                                }
                                            }
                                    }
                            },
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 0.1,
                                        projectile = makeRocketProjectile({
                                                name = "incendiary",
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "nested-result",
                                                                            affects_target = true,
                                                                            action =
                                                                                {
                                                                                    {
                                                                                        type = "cluster",
                                                                                        cluster_count = 7,
                                                                                        distance = 4,
                                                                                        distance_deviation = 3,
                                                                                        action_delivery =
                                                                                            {
                                                                                                type = "instant",
                                                                                                target_effects =
                                                                                                    {
                                                                                                        {
                                                                                                            type = "create-fire",
                                                                                                            entity_name = "fire-flame",
                                                                                                            initial_ground_flame_count = 4,
                                                                                                            check_buildability = true,
                                                                                                            show_in_tooltip = true
                                                                                                        }
                                                                                                    }
                                                                                            }
                                                                                    },
                                                                                    {
                                                                                        type = "area",
                                                                                        radius = 6.5,
                                                                                        action_delivery =
                                                                                            {
                                                                                                type = "instant",
                                                                                                target_effects =
                                                                                                    {
                                                                                                        {
                                                                                                            type = "create-fire",
                                                                                                            entity_name = "fire-flame",
                                                                                                            initial_ground_flame_count = 7
                                                                                                        },
                                                                                                        {
                                                                                                            type = "create-sticker",
                                                                                                            sticker = "small-fire-sticker-rampant-arsenal"
                                                                                                        },
                                                                                                        {
                                                                                                            type = "damage",
                                                                                                            damage = {amount = 600 , type = "fire"},
                                                                                                            apply_damage_to_trees = false
                                                                                                        },
                                                                                                        {
                                                                                                            type = "damage",
                                                                                                            damage = {amount = 50 , type = "explosion"},
                                                                                                            apply_damage_to_trees = false
                                                                                                        }
                                                                                                    }
                                                                                            }
                                                                                    }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "invoke-tile-trigger",
                                                                            repeat_count = 1,
                                                                        },
                                                                        {
                                                                            type = "destroy-decoratives",
                                                                            from_render_layer = "decorative",
                                                                            to_render_layer = "object",
                                                                            include_soft_decoratives = true,
                                                                            include_decals = false,
                                                                            invoke_decorative_trigger = true,
                                                                            decoratives_with_trigger_only = false,
                                                                            radius = 3
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "explosion"
                                                                        }
                                                                    }
                                                            }
                                                    }
                                        })
                                    }
                            }
                        }
                }
        })

        makeRecipe({
                name = incendiaryRocketAmmo,
                icon = "__RampantArsenal__/graphics/icons/incendiary-rocket.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="explosive-rocket", amount=1},
                    {type="item", name="steel-plate", amount=1},
                    {type="fluid", name="light-oil", amount=40}
                },
                results = {{type="item", name=incendiaryRocketAmmo, amount=1}}
        })

        addEffectToTech("incendiary-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryRocketAmmo,
        })

        local heRocketAmmo = makeAmmo({
                name = "he-rocket",
                icon = "__RampantArsenal__/graphics/icons/he-rocket.png",
                iconSize = 32,
                order = "d[rocket-launcher]-b[he]",
                magSize = 1,
                stackSize = 200,
                ammoCategory = "rocket",
                ammoType = {
                    action =
                        {
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "instant",
                                        source_effects =
                                            {
                                                {
                                                    type = "create-explosion",
                                                    entity_name = "explosion-gunshot"
                                                }
                                            }
                                    }
                            },
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 0.1,
                                        projectile = makeRocketProjectile({
                                                name = "he",
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "nested-result",
                                                                            affects_target = true,
                                                                            action =
                                                                                {
                                                                                    type = "area",
                                                                                    radius = 6.5,
                                                                                    action_delivery =
                                                                                        {
                                                                                            type = "instant",
                                                                                            target_effects =
                                                                                                {
                                                                                                    {
                                                                                                        type = "push-back",
                                                                                                        distance = 1
                                                                                                    },
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 1050 , type = "explosion"}
                                                                                                    }
                                                                                                }
                                                                                        }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "invoke-tile-trigger",
                                                                            repeat_count = 1,
                                                                        },
                                                                        {
                                                                            type = "destroy-decoratives",
                                                                            from_render_layer = "decorative",
                                                                            to_render_layer = "object",
                                                                            include_soft_decoratives = true,
                                                                            include_decals = false,
                                                                            invoke_decorative_trigger = true,
                                                                            decoratives_with_trigger_only = false,
                                                                            radius = 3
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        }
                                                                    }
                                                            }
                                                    }
                                        })
                                    }
                            }
                        }
                }
        })

        makeRecipe({
                name = heRocketAmmo,
                icon = "__RampantArsenal__/graphics/icons/he-rocket.png",
                iconSize = 32,
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="explosive-rocket", amount=1},
                    {type="item", name="steel-plate", amount=1},
                    {type="item", name="explosives", amount=6}
                },
                results = {{type="item", name=heRocketAmmo, amount=1}}
        })

        addEffectToTech("he-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = heRocketAmmo,
        })

        local bioRocketAmmo = makeAmmo({
                name = "bio-rocket",
                icon = "__RampantArsenal__/graphics/icons/bio-rocket.png",
                order = "d[rocket-launcher]-b[fbio]",
                magSize = 1,
                stackSize = 200,
                ammoCategory = "rocket",
                ammoType = {
                    action =
                        {
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "instant",
                                        source_effects =
                                            {
                                                {
                                                    type = "create-explosion",
                                                    entity_name = "explosion-gunshot"
                                                }
                                            }
                                    }
                            },
                            {
                                type = "direct",
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 0.1,
                                        projectile = makeRocketProjectile({
                                                name = "bio",
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "nested-result",
                                                                            affects_target = true,
                                                                            action =
                                                                                {
                                                                                    type = "area",
                                                                                    radius = 6.5,
                                                                                    action_delivery =
                                                                                        {
                                                                                            type = "instant",
                                                                                            target_effects =
                                                                                                {
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 600 , type = "poison"}
                                                                                                    },
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 50 , type = "explosion"}
                                                                                                    }
                                                                                                }
                                                                                        }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "invoke-tile-trigger",
                                                                            repeat_count = 1,
                                                                        },
                                                                        {
                                                                            type = "destroy-decoratives",
                                                                            from_render_layer = "decorative",
                                                                            to_render_layer = "object",
                                                                            include_soft_decoratives = true,
                                                                            include_decals = false,
                                                                            invoke_decorative_trigger = true,
                                                                            decoratives_with_trigger_only = false,
                                                                            radius = 3
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "toxic-cloud-rampant-arsenal",
                                                                            show_in_tooltip = true
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        }
                                                                    }
                                                            }
                                                    }
                                        })
                                    }
                            }
                        }
                }
        })

        makeRecipe({
                name = bioRocketAmmo,
                icon = "__RampantArsenal__/graphics/icons/bio-rocket.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="explosive-rocket", amount=1},
                    {type="item", name="steel-plate", amount=1},
                    {type="item", name="poison-capsule", amount=2}
                },
                results = {{type="item", name=bioRocketAmmo, amount=1}}
        })

        addEffectToTech("bio-rockets",
                        {
                            type = "unlock-recipe",
                            recipe = bioRocketAmmo,
        })
    end

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-1") or "stronger-explosives-1",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidRocketTurret,
                            modifier = 0.1
                        },
                        {
                            type = "turret-attack",
                            turret_id = rocketTurret,
                            modifier = 0.1
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-2") or "stronger-explosives-2",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidRocketTurret,
                            modifier = 0.1
                        },
                        {
                            type = "turret-attack",
                            turret_id = rocketTurret,
                            modifier = 0.1
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-3") or "stronger-explosives-3",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidRocketTurret,
                            modifier = 0.2
                        },
                        {
                            type = "turret-attack",
                            turret_id = rocketTurret,
                            modifier = 0.2
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-4") or "stronger-explosives-4",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidRocketTurret,
                            modifier = 0.3
                        },
                        {
                            type = "turret-attack",
                            turret_id = rocketTurret,
                            modifier = 0.3
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-5") or "stronger-explosives-5",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidRocketTurret,
                            modifier = 0.3
                        },
                        {
                            type = "turret-attack",
                            turret_id = rocketTurret,
                            modifier = 0.3
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-6") or "stronger-explosives-6",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidRocketTurret,
                            modifier = 0.4
                        },
                        {
                            type = "turret-attack",
                            turret_id = rocketTurret,
                            modifier = 0.4
                        }
    })

    if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "rocket-turret-damage-7") or "stronger-explosives-7",
                        {
                            {
                                type = "turret-attack",
                                turret_id = rapidRocketTurret,
                                modifier = 0.5
                            },
                            {
                                type = "turret-attack",
                                turret_id = rocketTurret,
                                modifier = 0.5
                            }
        })
    end
end

return rockets
