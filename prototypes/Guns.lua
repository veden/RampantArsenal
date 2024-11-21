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


local guns = {}

local sounds = require("__base__.prototypes.entity.sounds")
local gunUtils = require("utils/GunUtils")
local turretUtils = require("utils/TurretUtils")
local ammoUtils = require("utils/AmmoUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeAmmo = ammoUtils.makeAmmo
local makeShotgunProjectile = projectileUtils.makeShotgunProjectile
local removeEffect = technologyUtils.removeEffect
local addEffectToTech = technologyUtils.addEffectToTech

local makeGun = gunUtils.makeGun


local function gunTurretMkIISheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/gluegun_anim.png",
                        priority = "high",
                        width = 80,
                        height = 72,
                        line_length = 16,
                        scale=1.5,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0, -0.5},
                    }
                }
        }
end


local function rifleTurretSheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/entities/rifle-turret.png",
                        priority = "high",
                        width = 34,
                        height = 49,
                        line_length = 8,
                        scale=1,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0, -0.25}
                    }
                }
        }
end


function guns.enable()

    local mortar = makeGun(
        {
            name = "mortar",
            icon = "__RampantArsenal__/graphics/icons/mortar.png",
            iconSize = 64,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "capsule-launcher",
            cooldown = 175,
            movement_slow_down_factor = 0.9,
            damage_modifier = 1.25,
            gun_center_shift = {
                north = {0, 0},
                east = {0, 0},
                south = {0, 0},
                west = {0, 0}
            },
            gun_barrel_length = 1,
            range = 45,
            sound = {
                {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.9
                }
            }
    })

    local rocketLauncher = makeGun(
        {
            name = "rocket-launcher",
            icon = "__RampantArsenal__/graphics/icons/upgraded-rocket-launcher.png",
            iconSize = 64, iconMipmaps = 4,
            order = "d[rocket-launcher]-b"
        },
        {
            type = "projectile",
            ammo_category = "rocket",
            cooldown = 70,
            movement_slow_down_factor = 0.8,
            damage_modifier = 1.5,
            gun_center_shift = {
                north = {0, 0},
                east = {0, 0},
                south = {0, 0},
                west = {0, 0}
            },
            gun_barrel_length = 1,
            range = 38,
            sound = {
                {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.8
                }
            }
    })

    local minigun = makeGun(
        {
            name = "minigun",
            icon = "__RampantArsenal__/graphics/icons/minigun.png",
            iconSize = 64,
            order = "a[basic-clips]-e[minigun]"
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 3,
            movement_slow_down_factor = 0.7,
            damage_modifier = 1.2,
            -- lead_target_for_projectile_speed = 0.9,
            shell_particle =
                {
                    name = "shell-particle",
                    direction_deviation = 0.1,
                    speed = 0.1,
                    speed_deviation = 0.03,
                    center = {0, 0},
                    creation_distance = -0.6875,
                    starting_frame_speed = 0.4,
                    starting_frame_speed_deviation = 0.1
                },
            projectile_center = {-0, -0},
            gun_barrel_length = 1,
            projectile_creation_distance = 1,
            range = 20,
            sound = sounds.heavy_gunshot
    })

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then

        local uraniumShotgunShellAmmo = makeAmmo({
                name = "uranium-shotgun",
                icon = "__RampantArsenal__/graphics/icons/uranium-shotgun-shell.png",
                order = "b[shotgun]-d[uranium]",
                magSize = 10,
                stackSize = 200,
                ammoCategory = "shotgun-shell",
                ammoType = {
                    target_type = "direction",
                    clamp_position = true,
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
                                repeat_count = 18,
                                action_delivery =
                                    {
                                        type = "projectile",
                                        projectile = makeShotgunProjectile({
                                                name = "uranium",
                                                tint = {r=0.4,g=0.8,b=0.4,a=0.7},
                                                piercingDamage = 250,
                                                directionOnly = true,
                                                action = {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects ={
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 26, type = "physical"}
                                                                }
                                                            }
                                                        }
                                                }
                                        }),
                                        starting_speed = 1,
                                        direction_deviation = 0.3,
                                        range_deviation = 0.3,
                                        max_range = 22
                                    }
                            }
                        }
                }
        })

        local incendiaryShotgunShellAmmo = makeAmmo({
                name = "incendiary-shotgun",
                icon = "__RampantArsenal__/graphics/icons/incendiary-shotgun-shell.png",
                order = "b[shotgun]-c[incendiary]",
                magSize = 10,
                stackSize = 200,
                ammoCategory = "shotgun-shell",
                ammoType = {
                    target_type = "direction",
                    clamp_position = true,
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
                                repeat_count = 16,
                                action_delivery =
                                    {
                                        type = "projectile",
                                        projectile = makeShotgunProjectile({
                                                name = "incendiary",
                                                tint = {r=0.8,g=0.5,b=0,a=0.8},
                                                directionOnly = true,
                                                action = {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects ={
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 2, type = "physical"}
                                                                },
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 22, type = "fire"}
                                                                },
                                                                {
                                                                    type = "create-sticker",
                                                                    sticker = "fire-sticker"
                                                                },
                                                                {
                                                                    type = "create-fire",
                                                                    entity_name = "fire-flame",
                                                                    initial_ground_flame_count = 1
                                                                }
                                                            }
                                                        }
                                                }
                                        }),
                                        starting_speed = 1,
                                        direction_deviation = 0.3,
                                        range_deviation = 0.3,
                                        max_range = 22
                                    }
                            }
                        }
                }
        })

        local incendiaryMagazineAmmo = makeAmmo({
                name = "incendiary-magazine",
                icon = "__RampantArsenal__/graphics/icons/incendiary-rounds-magazine.png",
                order = "a[basic-clips]-c[incendiary-rounds-magazine]",
                magSize = 10,
                stackSize = 200,
                ammoCategory = "bullet",
                ammoType = {
                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "instant",
                                    source_effects =
                                        {
                                            type = "create-explosion",
                                            entity_name = "explosion-gunshot"
                                        },
                                    target_effects =
                                        {
                                            {
                                                type = "create-fire",
                                                entity_name = "fire-flame",
                                                initial_ground_flame_count = 1
                                            },
                                            {
                                                type = "create-sticker",
                                                sticker = "fire-sticker"
                                            },
                                            {
                                                type = "damage",
                                                damage = { amount = 2, type = "physical"}
                                            },
                                            {
                                                type = "damage",
                                                damage = { amount = 22, type = "fire"}
                                            }
                                        }
                                }
                        }
                }
        })

        local heShotgunShellAmmo = makeAmmo({
                name = "he-shotgun",
                icon = "__RampantArsenal__/graphics/icons/he-shotgun-shell.png",
                order = "b[shotgun]-c[he]",
                magSize = 10,
                stackSize = 200,
                ammoCategory = "shotgun-shell",
                ammoType = {
                    target_type = "direction",
                    clamp_position = true,
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
                                repeat_count = 16,
                                action_delivery =
                                    {
                                        type = "projectile",
                                        projectile = makeShotgunProjectile({
                                                name = "he",
                                                directionOnly = true,
                                                tint = {r=0,g=0,b=0.9,a=0.8},
                                                action = {
                                                    type = "area",
                                                    radius = 1.5,
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            source_effects =
                                                                {
                                                                    type = "create-explosion",
                                                                    entity_name = "explosion-gunshot"
                                                                },
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "create-explosion",
                                                                        entity_name = "explosion"
                                                                    },
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 2, type = "physical"}
                                                                    },
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 22, type = "explosion"}
                                                                    },
                                                                    {
                                                                        type = "push-back",
                                                                        distance = 0.5,
                                                                        show_in_tooltip = true
                                                                    }
                                                                }
                                                        }
                                                }
                                        }),
                                        starting_speed = 1,
                                        direction_deviation = 0.3,
                                        range_deviation = 0.3,
                                        max_range = 22
                                    }
                            }
                        }
                }
        })

        local heMagazineAmmo
        -- if (settings.startup["rampant-arsenal-"]) then
        -- end
            = makeAmmo({
                    name = "he-magazine",
                    icon = "__RampantArsenal__/graphics/icons/he-rounds-magazine.png",
                    order = "a[basic-clips]-c[he-rounds-magazine]",
                    magSize = 10,
                    stackSize = 200,
                    ammoCategory = "bullet",
                    ammoType = {
                        -- target_type = "position",
                        -- clamp_position = true,
                        action =
                            {
                                type = "direct",
                                action_delivery =
                                    {

                                        type = "instant",
                                        source_effects =
                                            {
                                                type = "create-explosion",
                                                entity_name = "explosion-gunshot"
                                            }
                                        ,
                                        target_effects = {
                                            {
                                                type = "create-explosion",
                                                entity_name = "explosion"
                                            },
                                            {
                                                type = "damage",
                                                damage = {amount = 2, type = "physical"}
                                            },
                                            {
                                                type = "damage",
                                                damage = {amount = 22, type = "explosion"}
                                            },
                                            {
                                                type = "push-back",
                                                distance = 0.5,
                                                show_in_tooltip = true
                                            }
                                        }
                                        -- {
                                        --     type = "projectile",
                                        --     projectile = makeShotgunProjectile({
                                        --             name = "heMagazine",
                                        --             directionOnly = false,
                                        --             tint = {r=0.4,g=0,b=0.8,a=0.8},
                                        --             hitAtPosition = true,
                                        --              action = {
                                        --                 type = "direct",
                                        --                 action_delivery =
                                        --                     {
                                        --                         type = "instant",
                                        --                         target_effects = {
                                        --                             {
                                        --                                 type = "create-explosion",
                                        --                                 entity_name = "explosion"
                                        --                             },
                                        --                             {
                                        --                                 type = "damage",
                                        --                                 damage = {amount = 2, type = "physical"}
                                        --                             },
                                        --                             {
                                        --                                 type = "damage",
                                        --                                 damage = {amount = 20, type = "explosion"}
                                        --                             },
                                        --                             {
                                        --                                 type = "push-back",
                                        --                                 distance = 0.5,
                                        --                                 show_in_tooltip = true
                                        --                             }
                                        --                         }
                                        --                     }
                                        --             }
                                        --     }),
                                        --     starting_speed = 1,
                                        --     direction_deviation = 0.1,
                                        --     range_deviation = 0.1,
                                        --     max_range = 40
                                        -- }
                                    }
                            }
                    }
                      })

        local bioShotgunShellAmmo = makeAmmo({
                name = "bio-shotgun",
                icon = "__RampantArsenal__/graphics/icons/bio-shotgun-shell.png",
                order = "b[shotgun]-c[bio]",
                magSize = 10,
                stackSize = 200,
                ammoCategory = "shotgun-shell",
                ammoType = {
                    target_type = "direction",
                    clamp_position = true,
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
                                repeat_count = 16,
                                action_delivery =
                                    {
                                        type = "projectile",
                                        projectile = makeShotgunProjectile({
                                                name = "bio",
                                                directionOnly = true,
                                                tint = {r=0.4,g=0,b=0.8,a=0.8},
                                                action = {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects ={
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 2, type = "physical"}
                                                                },
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 20, type = "poison"}
                                                                },
                                                                {
                                                                    type = "create-sticker",
                                                                    sticker = "bullet-toxic-sticker-rampant-arsenal",
                                                                    show_in_tooltip = true
                                                                }
                                                            }
                                                        }
                                                }
                                        }),
                                        starting_speed = 1,
                                        direction_deviation = 0.3,
                                        range_deviation = 0.3,
                                        max_range = 22
                                    }
                            }
                        }
                }
        })

        local bioMagazineAmmo = makeAmmo({
                name = "bio-magazine",
                icon = "__RampantArsenal__/graphics/icons/bio-rounds-magazine.png",
                order = "a[basic-clips]-c[bio-rounds-magazine]",
                magSize = 10,
                stackSize = 200,
                ammoCategory = "bullet",
                ammoType = {
                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "instant",
                                    source_effects =
                                        {
                                            type = "create-explosion",
                                            entity_name = "explosion-gunshot"
                                        },
                                    target_effects =
                                        {
                                            {
                                                type = "create-sticker",
                                                sticker = "bullet-toxic-sticker-rampant-arsenal",
                                                show_in_tooltip = true
                                            },
                                            {
                                                type = "damage",
                                                damage = { amount = 2, type = "physical"}
                                            },
                                            {
                                                type = "damage",
                                                damage = { amount = 22, type = "poison"}
                                            }
                                        }
                                }
                        }
                }
        })

        makeRecipe({
                name = incendiaryMagazineAmmo,
                icon = "__RampantArsenal__/graphics/icons/incendiary-rounds-magazine.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="piercing-rounds-magazine", amount=1},
                    {type="item", name="copper-plate", amount=2},
                    {type="fluid", name="light-oil", amount=20}
                },
                results = {{type="item", name=incendiaryMagazineAmmo, amount=1}}
        })

        makeRecipe({
                name = incendiaryShotgunShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/incendiary-shotgun-shell.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="piercing-shotgun-shell", amount=1},
                    {type="item", name="steel-plate", amount=1},
                    {type="fluid", name="light-oil", amount=20}
                },
                results = {{type="item", name=incendiaryShotgunShellAmmo, amount=1}}
        })

        makeRecipe({
                name = heMagazineAmmo,
                icon = "__RampantArsenal__/graphics/icons/he-rounds-magazine.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="piercing-rounds-magazine", amount=1},
                    {type="item", name="copper-plate", amount=2},
                    {type="item", name="explosives", amount=2}
                },
                results = {{type="item", name=heMagazineAmmo, amount=1}}
        })

        makeRecipe({
                name = heShotgunShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/he-shotgun-shell.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="piercing-shotgun-shell", amount=1},
                    {type="item", name="steel-plate", amount=2},
                    {type="item", name="explosives", amount=2}
                },
                results = {{type="item", name=heShotgunShellAmmo, amount=1}}
        })

        makeRecipe({
                name = bioMagazineAmmo,
                icon = "__RampantArsenal__/graphics/icons/bio-rounds-magazine.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="piercing-rounds-magazine", amount=1},
                    {type="item", name="copper-plate", amount=2},
                    {type="item", name="poison-capsule", amount=1}
                },
                results = {{type="item", name=bioMagazineAmmo, amount=1}}
        })

        makeRecipe({
                name = bioShotgunShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/bio-shotgun-shell.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="piercing-shotgun-shell", amount=1},
                    {type="item", name="steel-plate", amount=1},
                    {type="item", name="poison-capsule", amount=1}
                },
                results = {{type="item", name=bioShotgunShellAmmo, amount=1}}
        })

        makeRecipe({
                name = uraniumShotgunShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/uranium-shotgun-shell.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="piercing-shotgun-shell", amount=1},
                    {type="item", name="uranium-238", amount=1},
                    {type="item", name="steel-plate", amount=1}
                },
                results = {{type="item", name=uraniumShotgunShellAmmo, amount=1}}
        })

        local uraniumBullets = data.raw["ammo"]["uranium-rounds-magazine"]
        uraniumBullets.ammo_category = "bullet"
        uraniumBullets.ammo_type = {
            action =
                {
                    type = "direct",
                    action_delivery =
                        {
                            type = "instant",
                            source_effects =
                                {
                                    type = "create-explosion",
                                    entity_name = "explosion-gunshot"
                                },
                            target_effects =
                                {
                                    {
                                        type = "create-entity",
                                        entity_name = "explosion-hit"
                                    },
                                    {
                                        type = "damage",
                                        damage = { amount = 26, type = "physical"}
                                    }
                                }
                        }
                }
        }

        data.raw["ammo"]["shotgun-shell"]["ammo_type"]["action"][2]["action_delivery"]["max_range"] = 20

        data.raw["ammo"]["piercing-shotgun-shell"]["ammo_type"]["action"][2]["action_delivery"]["max_range"] = 22

        data.raw["gun"]["shotgun"]["attack_parameters"]["range"] = 22

        data.raw["gun"]["combat-shotgun"]["attack_parameters"]["range"] = 22

        addEffectToTech("uranium-ammo",
                        {
                            type = "unlock-recipe",
                            recipe = uraniumShotgunShellAmmo
        })

        addEffectToTech("incendiary-bullets",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryMagazineAmmo
        })

        addEffectToTech("incendiary-shotgun-shells",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryShotgunShellAmmo
        })

        addEffectToTech("he-bullets",
                        {
                            type = "unlock-recipe",
                            recipe = heMagazineAmmo
        })

        addEffectToTech("he-shotgun-shells",
                        {
                            type = "unlock-recipe",
                            recipe = heShotgunShellAmmo
        })

        addEffectToTech("bio-bullets",
                        {
                            type = "unlock-recipe",
                            recipe = bioMagazineAmmo
        })

        addEffectToTech("bio-shotgun-shells",
                        {
                            type = "unlock-recipe",
                            recipe = bioShotgunShellAmmo
        })

        removeEffect("military-3", "unlock-recipe", "poison-capsule")
        removeEffect("military-3", "unlock-recipe", "slowdown-capsule")

        addEffectToTech("military-2",
                        {
                            {
                                type = "unlock-recipe",
                                recipe = "poison-capsule"
                            },
                            {
                                type = "unlock-recipe",
                                recipe = "slowdown-capsule"
                            }
        })

        removeEffect("military-4", "unlock-recipe", "piercing-shotgun-shell")

        -- removeEffect("physical-projectile-damage-1", "turret-attack", "gun-turret")
        -- removeEffect("physical-projectile-damage-2", "turret-attack", "gun-turret")
        -- removeEffect("physical-projectile-damage-3", "turret-attack", "gun-turret")
        -- removeEffect("physical-projectile-damage-4", "turret-attack", "gun-turret")
        -- removeEffect("physical-projectile-damage-5", "turret-attack", "gun-turret")
        -- removeEffect("physical-projectile-damage-6", "turret-attack", "gun-turret")
        -- removeEffect("physical-projectile-damage-7", "turret-attack", "gun-turret")

        addEffectToTech("military-3",
                        {
                            type = "unlock-recipe",
                            recipe = "piercing-shotgun-shell"
        })

        addEffectToTech("military-4",
                        {
                            type = "unlock-recipe",
                            recipe = rocketLauncher
        })
    end

    makeRecipe({
            name = mortar,
            icon = "__RampantArsenal__/graphics/icons/recipe-mortar.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=15},
                {type="item", name="iron-gear-wheel", amount=5},
                {type="item", name="copper-plate", amount=10},
                {type="item", name="explosives", amount=5}
            },
            results = {{type="item", name=mortar, amount=1}}
    })

    makeRecipe({
            name = minigun,
            icon = "__RampantArsenal__/graphics/icons/recipe-minigun.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=10},
                {type="item", name="iron-gear-wheel", amount=5},
                {type="item", name="engine-unit", amount=3},
                {type="item", name="electronic-circuit", amount=5}
            },
            results = {{type="item", name=minigun, amount=1}}
    })

    makeRecipe({
            name = rocketLauncher,
            icon = "__RampantArsenal__/graphics/icons/recipe-upgraded-rocket-launcher.png",
            iconSize = 32, iconMipmaps = 1,
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=10},
                {type="item", name="iron-gear-wheel", amount=5},
                {type="item", name="rocket-launcher", amount=1},
                {type="item", name="electronic-circuit", amount=5}
            },
            results = {{type="item", name=rocketLauncher, amount=1}}
    })

    addEffectToTech("explosives",
                    {
                        type = "unlock-recipe",
                        recipe = mortar
    })

    addEffectToTech("military-3",
                    {
                        type = "unlock-recipe",
                        recipe = minigun
    })

    local gunTurretAttributes = {
        name = "gun",
        icon = "__RampantArsenal__/graphics/icons/gluegun-icon.png",
        order = "b[turret]-a[sgun-turret]",
        miningTime = 1,
        health = 1400,
        collisionBox = {{-1.2, -1.2 }, {1.2, 1.2}},
        selectionBox = {{-1.4, -1.4 }, {1.4, 1.4}},
        foldedAnimation = gunTurretMkIISheet(),
        foldingAnimation = gunTurretMkIISheet(),
        preparedAnimation = gunTurretMkIISheet(),
        preparingAnimation = gunTurretMkIISheet(),
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 40
            },
            {
                type = "explosion",
                percent = 30
            },
            {
                type = "physical",
                percent = 30
            },
            {
                type = "acid",
                percent = 40
            },
            {
                type = "electric",
                percent = 30
            },
            {
                type = "laser",
                percent = 30
            },
            {
                type = "poison",
                percent = 40
            }
        }
    }
    local gunTurret,gunTurretItem = makeAmmoTurret(gunTurretAttributes,
                                                   {
                                                       type = "projectile",
                                                       ammo_category = "bullet",
                                                       cooldown = 3.3,
                                                       projectile_creation_distance = 2,
                                                       damage_modifier = 2,
                                                       projectile_center = {0, 0},
                                                       range = 24,
                                                       sound = sounds.heavy_gunshot,
    })

    makeRecipe({
            name = gunTurretItem,
            icon = "__RampantArsenal__/graphics/icons/gluegun-icon.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="gun-turret", amount=1},
                {type="item", name="advanced-circuit", amount=5},
                {type="item", name="steel-plate", amount=15}
            },
            results = {{type="item", name=gunTurretItem, amount=1}}
    })

    local rifleTurret,rifleTurretItem
    if settings.startup["rampant-arsenal-enableRifleTurret"].value then
        local rifleTurretAttributes = {
            name = "rifle",
            icon = "__RampantArsenal__/graphics/icons/rifle-turret.png",
            miningTime = 1,
            health = 200,
            order = "b[turret]-a[aun-turret]",
            collisionBox = {{-0.4, -0.4 }, {0.4, 0.4}},
            selectionBox = {{-0.5, -0.5 }, {0.5, 0.5}},
            foldedAnimation = rifleTurretSheet(),
            foldingAnimation = rifleTurretSheet(),
            preparedAnimation = rifleTurretSheet(),
            preparingAnimation = rifleTurretSheet()
        }
        rifleTurret,rifleTurretItem = makeAmmoTurret(rifleTurretAttributes,
                                                     {
                                                         type = "projectile",
                                                         ammo_category = "bullet",
                                                         cooldown = 16,
                                                         projectile_creation_distance = 1,
                                                         damage_modifier = 1.2,
                                                         projectile_center = {0, 0.2},
                                                         range = 16,
                                                         sound = sounds.light_gunshot,
        })

        makeRecipe({
                name = rifleTurretItem,
                icon = "__RampantArsenal__/graphics/icons/rifle-turret.png",
                enabled = true,
                category = "crafting",
                ingredients = {
                    {type="item", name="copper-plate", amount=10},
                    {type="item", name="wood", amount=5},
                    {type="item", name="iron-plate", amount=15}
                },
                results = {{type="item", name=rifleTurretItem, amount=1}}
        })

        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-1") or "physical-projectile-damage-1",
            {
                {
                    type = "turret-attack",
                    turret_id = rifleTurret,
                    modifier = 0.1
                }
        })

        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-2") or "physical-projectile-damage-2",
            {
                {
                    type = "turret-attack",
                    turret_id = rifleTurret,
                    modifier = 0.1
                }
        })

        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-3") or "physical-projectile-damage-3",
            {
                {
                    type = "turret-attack",
                    turret_id = rifleTurret,
                    modifier = 0.2
                }
        })

        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-4") or "physical-projectile-damage-4",
            {
                {
                    type = "turret-attack",
                    turret_id = rifleTurret,
                    modifier = 0.3
                }
        })

        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-5") or "physical-projectile-damage-5",
            {
                {
                    type = "turret-attack",
                    turret_id = rifleTurret,
                    modifier = 0.4
                }
        })

        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-6") or "physical-projectile-damage-6",
            {
                {
                    type = "turret-attack",
                    turret_id = rifleTurret,
                    modifier = 0.4
                }
        })

        if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
            addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "gun-turret-damage-7") or "physical-projectile-damage-7",
                {
                    {
                        type = "turret-attack",
                        turret_id = rifleTurret,
                        modifier = 0.8
                    }
            })
        end

    end

    addEffectToTech("turrets-2",
                    {
                        type = "unlock-recipe",
                        recipe = gunTurretItem
    })

    if settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value then
        addEffectToTech("gun-turret-damage-1",
                        {
                            {
                                type = "turret-attack",
                                turret_id = "gun-turret",
                                modifier = 0.1
                            },
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.1
        }})

        addEffectToTech("gun-turret-damage-2",
                        {
                            {
                                type = "turret-attack",
                                turret_id = "gun-turret",
                                modifier = 0.1
                            },
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.1
        }})

        addEffectToTech("gun-turret-damage-3",
                        {
                            {
                                type = "turret-attack",
                                turret_id = "gun-turret",
                                modifier = 0.2
                            },
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.2
        }})

        addEffectToTech("gun-turret-damage-4",
                        {
                            {
                                type = "turret-attack",
                                turret_id = "gun-turret",
                                modifier = 0.3
                            },
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.3
        }})

        addEffectToTech("gun-turret-damage-5",
                        {
                            {
                                type = "turret-attack",
                                turret_id = "gun-turret",
                                modifier = 0.4
                            },
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.4
        }})

        addEffectToTech("gun-turret-damage-6",
                        {
                            {
                                type = "turret-attack",
                                turret_id = "gun-turret",
                                modifier = 0.4
                            },
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.4
                            }
        })


        if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
            addEffectToTech("gun-turret-damage-7",
                            {
                                {
                                    type = "turret-attack",
                                    turret_id = "gun-turret",
                                    modifier = 0.8
                                },
                                {
                                    type = "turret-attack",
                                    turret_id = gunTurret,
                                    modifier = 0.8
            }})
        end

    else
        addEffectToTech("physical-projectile-damage-1",
                        {
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.1
        }})

        addEffectToTech("physical-projectile-damage-2",
                        {
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.1
        }})

        addEffectToTech("physical-projectile-damage-3",
                        {
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.2
        }})

        addEffectToTech("physical-projectile-damage-4",
                        {
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.3
        }})

        addEffectToTech("physical-projectile-damage-5",
                        {
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.4
        }})

        addEffectToTech("physical-projectile-damage-6",
                        {
                            {
                                type = "turret-attack",
                                turret_id = gunTurret,
                                modifier = 0.4
                            }
        })

        if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
            addEffectToTech("physical-projectile-damage-7",
                            {
                                {
                                    type = "turret-attack",
                                    turret_id = gunTurret,
                                    modifier = 0.8
            }})
        end

    end

    data.raw["projectile"]["shotgun-pellet"].force_condition = "not-same"
    data.raw["projectile"]["piercing-shotgun-pellet"].force_condition = "not-same"

    data.raw["projectile"]["cannon-projectile"].force_condition = "not-same"
    data.raw["projectile"]["uranium-cannon-projectile"].force_condition = "not-same"
    data.raw["projectile"]["explosive-uranium-cannon-projectile"].force_condition = "not-same"
    data.raw["projectile"]["explosive-cannon-projectile"].force_condition = "not-same"
end

return guns
