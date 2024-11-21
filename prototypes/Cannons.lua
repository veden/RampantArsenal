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


local cannons = {}

local stickerUtils = require("utils/StickerUtils")
local sounds = require("__base__.prototypes.entity.sounds")
local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local streamUtils = require("utils/StreamUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")
local fireUtils = require("utils/FireUtils")
local scaleUtils = require("utils/ScaleUtils")

local makeCannonProjectile = projectileUtils.makeCannonProjectile
local makeAmmo = ammoUtils.makeAmmo
local makeStream = streamUtils.makeStream
local makeAcidStream = streamUtils.makeAcidStream
local makeFluidTurret = turretUtils.makeFluidTurret
local makeAmmoTurret = turretUtils.makeAmmoTurret
local makeRecipe = recipeUtils.makeRecipe
local makeAcidSticker = stickerUtils.makeAcidSticker
local makeAcidPuddle = fireUtils.makeAcidPuddle
local addEffectToTech = technologyUtils.addEffectToTech
local modifyInfiniteFormula = technologyUtils.modifyInfiniteFormula
local tintPicture = scaleUtils.tintPicture

local function cannonMkISheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/cannon-mk1-sheet.png",
                        priority = "high",
                        width = 128,
                        height = 128,
                        line_length = 8,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0.5, -0.6},
                        scale = 1.5
                    }
                }
        }
end

-- local function cannonMkIIISheet()
--     return
-- 	{
-- 	    layers =
-- 		{
-- 		    {
-- 			filename = "__RampantArsenal__/graphics/entities/cannon-mk1-sheet.png",
-- 			priority = "high",
-- 			width = 128,
-- 			height = 128,
-- 			line_length = 8,
-- 			axially_symmetrical = false,
-- 			direction_count = 64,
-- 			frame_count = 1,
-- 			shift = {0.6, -1.2},
--                         scale = 2
-- 		    }
-- 		}
-- 	}
-- end

local function shotgunTurretSheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/shotgun-turret-sheet.png",
                        priority = "high",
                        width = 90,
                        height = 90,
                        line_length = 8,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0.3, -0.5},
                        scale = 1
                    }
                }
        }
end

local function cannonMkIISheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/cannon-mk2-sheet.png",
                        priority = "high",
                        width = 128,
                        height = 128,
                        line_length = 8,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0.7, -1.2},
                        scale = 1.5
                    }
                }
        }
end

local function cannonMkIIPlace(lineLength, directionCount, frameCount, backward)
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/cannon-mk2-place.png",
                        priority = "high",
                        width = 128,
                        height = 128,
                        line_length = lineLength or 1,
                        axially_symmetrical = false,
                        direction_count = directionCount or 4,
                        frame_count = frameCount or 1,
                        run_mode = (backward and "backward") or "forward",
                        shift = {0.7, -1.2},
                        scale = 1.5
                    }
                }
        }
end


local function largeCannonSheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/cr-sheet.png",
                        priority = "high",
                        width = 256,
                        height = 256,
                        line_length = 8,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0, -0.2},
                    }
                }
        }
end


function cannons.enable()
    local cannonAttributes = {
        name = "cannon",
        icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
        miningTime = 5,
        health = 2500,
        collisionBox = {{-1.8, -1.8 }, {1.8, 1.8}},
        selectionBox = {{-2.1, -2.1 }, {2.1, 2.1}},
        order = "b[turret]-a[zzcannon-turret]",
        hasBaseDirection = true,
        foldedAnimation = cannonMkISheet(),
        foldingAnimation = cannonMkISheet(),
        preparedAnimation = cannonMkISheet(),
        preparingAnimation = cannonMkISheet(),
        rotationSpeed = 0.03,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "explosion",
                percent = 50
            },
            {
                type = "impact",
                percent = 60
            },
            {
                type = "physical",
                percent = 50
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
    local cannonTurret,cannonTurretItem = makeAmmoTurret(cannonAttributes,
                                                         {
                                                             type = "projectile",
                                                             ammo_category = "cannon-shell",
                                                             cooldown = 150,
                                                             projectile_creation_distance = 3,
                                                             lead_target_for_projectile_speed = 0.9,
                                                             damage_modifier = 1.5,
                                                             min_range = 12,
                                                             turn_range = 0.40,
                                                             projectile_center = {0, -0.2},
                                                             range = 34,
                                                             sound = {
                                                                 {
                                                                     filename = "__base__/sound/fight/tank-cannon.ogg",
                                                                     volume = 1.0
                                                                 }
                                                             }
    })


    -- local cannonIIAttributes = {
    --     name = "advanced-cannon",
    --     icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
    --     miningTime = 1,
    --     health = 3500,
    --     collisionBox = {{-2.4, -2.4 }, {2.4, 2.4}},
    --     selectionBox = {{-2.6, -2.6 }, {2.6, 2.6}},
    --     order = "b[turret]-a[zzzcannon-turret]",
    --     hasBaseDirection = true,
    --     foldedAnimation = cannonMkIIISheet(),
    --     foldingAnimation = cannonMkIIISheet(),
    --     preparedAnimation = cannonMkIIISheet(),
    --     preparingAnimation = cannonMkIIISheet(),
    --     rotationSpeed = 0.02,
    --     resistances = {
    --         {
    --             type = "fire",
    --             percent = 70
    --         },
    --         {
    --             type = "explosion",
    --             percent = 60
    --         },
    --         {
    --             type = "impact",
    --             percent = 60
    --         },
    --         {
    --             type = "physical",
    --             percent = 60
    --         },
    --         {
    --             type = "acid",
    --             percent = 40
    --         },
    --         {
    --             type = "electric",
    --             percent = 70
    --         },
    --         {
    --             type = "laser",
    --             percent = 70
    --         },
    --         {
    --             type = "poison",
    --             percent = 40
    --         }
    --     }
    -- }
    -- local cannonIITurret,cannonIITurretItem = makeAmmoTurret(cannonIIAttributes,
    --                                                          {
    --                                                              type = "projectile",
    --                                                              ammo_category = "cannon-shell",
    --                                                              cooldown = 250,
    --                                                              projectile_creation_distance = (settings.startup["rampant-arsenal-useNonCollidingProjectilesCannon"].value and 4) or 9,
    --                                                              lead_target_for_projectile_speed = 0.9,
    --                                                              damage_modifier = 3.5,
    --                                                              min_range = 15,
    --                                                              turn_range = 0.40,
    --                                                              projectile_center = {0, -0.0875},
    --                                                              range = 45,
    --                                                              sound = make_heavy_gunshot_sounds(),
    -- })

    local rapidCannonAttributes = {
        name = "rapid-cannon",
        icon = "__RampantArsenal__/graphics/icons/rapidCannonTurret.png",
        miningTime = 5,
        health = 2000,
        order = "b[turret]-a[zzrapid-cannon-turret]",
        collisionBox = {{-1.4, -1.4 }, {1.4, 1.4}},
        selectionBox = {{-1.7, -1.7 }, {1.7, 1.7}},
        foldedAnimation = cannonMkIIPlace(),
        preparingAnimation = cannonMkIIPlace(8, 4, 8),
        preparedAnimation = cannonMkIISheet(),
        attackingAnimation = cannonMkIISheet(),
        hasBaseDirection = true,
        foldingAnimation = cannonMkIIPlace(8, 4, 8, true),
        rotationSpeed = 0.06,
        resistances = {
            {
                type = "fire",
                percent = 60
            },
            {
                type = "impact",
                percent = 50
            },
            {
                type = "explosion",
                percent = 50
            },
            {
                type = "physical",
                percent = 50
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
    local rapidCannonTurret,rapidCannonTurretItem = makeAmmoTurret(rapidCannonAttributes, {
                                                                       type = "projectile",
                                                                       ammo_category = "cannon-shell",
                                                                       cooldown = 30,
                                                                       min_range = 12,
                                                                       turn_range = 0.40,
                                                                       lead_target_for_projectile_speed = 0.9,
                                                                       projectile_creation_distance = 2,
                                                                       projectile_center = {0, -0.0875},
                                                                       range = 34,
                                                                       sound = {
                                                                           {
                                                                               filename = "__base__/sound/fight/tank-cannon.ogg",
                                                                               volume = 1.0
                                                                           }
                                                                       },
    })

    local advFlamethrowerAttributes = {
        name = "suppression-cannon",
        icon = "__RampantArsenal__/graphics/icons/suppressionCannonTurret.png",
        miningTime = 5,
        health = 3000,
        collisionBox = {{-1.7, -2.2 }, {1.7, 2.2}},
        selectionBox = {{-2, -2.5 }, {2, 2.5}},
        order = "b[turret]-c[zflamethrower-turret]",
        volume = 100,
        pipeConnections = {
            { direction = defines.direction.west, position = {-1.5, 2.0} },
            { direction = defines.direction.east, position = {1.5, 2.0} }
        },
        foldedAnimation = largeCannonSheet(),
        preparingAnimation = largeCannonSheet(),
        preparedAnimation = largeCannonSheet(),
        foldingAnimation = largeCannonSheet(),
        rotationSpeed = 0.002,
        resistances = {
            {
                type = "fire",
                percent = 80
            },
            {
                type = "explosion",
                percent = 60
            },
            {
                type = "impact",
                percent = 50
            },
            {
                type = "physical",
                percent = 60
            },
            {
                type = "acid",
                percent = 60
            },
            {
                type = "electric",
                percent = 40
            },
            {
                type = "laser",
                percent = 40
            },
            {
                type = "poison",
                percent = 60
            }
        }
    }
    local fluidBonuses = {
        {type = "crude-oil", damage_modifier = 0.9},
        {type = "heavy-oil", damage_modifier = 1.0},
        {type = "light-oil", damage_modifier = 1.1}
    }
    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        fluidBonuses[#fluidBonuses+1] = {type = "napalm-fluid-rampant-arsenal", damage_modifier = 1.5}
    end
    local suppressionCannonTurret,suppressionCannonTurretItem = makeFluidTurret(advFlamethrowerAttributes,
                                                                                {
                                                                                    type = "stream",
                                                                                    ammo_category = "flamethrower",
                                                                                    cooldown = 4,
                                                                                    range = 45,
                                                                                    min_range = 15,

                                                                                    turn_range = 0.4,
                                                                                    fire_penalty = 30,

                                                                                    fluids = fluidBonuses,
                                                                                    fluid_consumption = 2.2,

                                                                                    lead_target_for_projectile_speed = 0.6,
                                                                                    gun_center_shift = {
                                                                                        north = {0, -1.8},
                                                                                        east = {0, -1.8},
                                                                                        south = {0, -3},
                                                                                        west = {0, -1.8}
                                                                                    },
                                                                                    gun_barrel_length = 3.5,

                                                                                    ammo_type =
                                                                                        {
                                                                                            category = "flamethrower",
                                                                                            action =
                                                                                                {
                                                                                                    type = "line",
                                                                                                    range = 45,
                                                                                                    force = "enemy",
                                                                                                    width = 10,
                                                                                                    action_delivery =
                                                                                                        {
                                                                                                            type = "stream",
                                                                                                            stream = makeStream({
                                                                                                                    name = advFlamethrowerAttributes.name,
                                                                                                                    bufferSize = 10,
                                                                                                                    spawnInterval = 1,
                                                                                                                    particleTimeout = 8,
                                                                                                                    particleHoizontalSpeed = 0.4,
                                                                                                                    actions = {
                                                                                                                        {
                                                                                                                            type = "direct",
                                                                                                                            action_delivery =
                                                                                                                                {
                                                                                                                                    type = "instant",
                                                                                                                                    target_effects =
                                                                                                                                        {
                                                                                                                                            {
                                                                                                                                                type = "destroy-decoratives",
                                                                                                                                                from_render_layer = "decorative",
                                                                                                                                                to_render_layer = "object",
                                                                                                                                                include_soft_decoratives = true,
                                                                                                                                                include_decals = false,
                                                                                                                                                invoke_decorative_trigger = true,
                                                                                                                                                decoratives_with_trigger_only = false,
                                                                                                                                                radius = 1
                                                                                                                                            },
                                                                                                                                            {
                                                                                                                                                type = "create-fire",
                                                                                                                                                show_in_tooltip = true,
                                                                                                                                                initial_ground_flame_count = 4,
                                                                                                                                                entity_name = "fire-flame"
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                }
                                                                                                                        },
                                                                                                                        {
                                                                                                                            type = "area",
                                                                                                                            radius = 2.5,
                                                                                                                            action_delivery =
                                                                                                                                {
                                                                                                                                    type = "instant",
                                                                                                                                    target_effects =
                                                                                                                                        {
                                                                                                                                            {
                                                                                                                                                type = "create-sticker",
                                                                                                                                                show_in_tooltip = true,
                                                                                                                                                sticker = "fire-sticker"
                                                                                                                                            },
                                                                                                                                            {
                                                                                                                                                type = "damage",
                                                                                                                                                damage = { amount = 5, type = "fire" },
                                                                                                                                                apply_damage_to_trees = false
                                                                                                                                            }
                                                                                                                                        }
                                                                                                                                }
                                                                                                                        }
                                                                                                                    }
                                                                                                            }),
                                                                                                            duration = 10,
                                                                                                            source_offset = {0.15, -0.5},
                                                                                                        }
                                                                                                }
                                                                                        },

                                                                                    cyclic_sound =
                                                                                        {
                                                                                            begin_sound =
                                                                                                {
                                                                                                    {
                                                                                                        filename = "__base__/sound/fight/flamethrower-start.ogg",
                                                                                                        volume = 0.7
                                                                                                    }
                                                                                                },
                                                                                            middle_sound =
                                                                                                {
                                                                                                    {
                                                                                                        filename = "__base__/sound/fight/flamethrower-mid.ogg",
                                                                                                        volume = 0.7
                                                                                                    }
                                                                                                },
                                                                                            end_sound =
                                                                                                {
                                                                                                    {
                                                                                                        filename = "__base__/sound/fight/flamethrower-end.ogg",
                                                                                                        volume = 0.7
                                                                                                    }
                                                                                                }
                                                                                        }
    })

    local acidTurret = util.table.deepcopy(data.raw["fluid-turret"]["flamethrower-turret"])

    acidTurret.icon = nil
    acidTurret.icons = {
        {icon="__base__/graphics/icons/flamethrower-turret.png", icon_size=64, icon_mipmaps=4, tint={r=0.6,g=0.8,b=0.6}}
    }

    tintPicture(acidTurret.graphics_set, {r=0.6,g=0.8,b=0.6})

    acidTurret.name = "acid-cannon-rampant-arsenal"
    acidTurret.minable = { mining_time = 3, result = "acid-cannon-rampant-arsenal" }
    acidTurret.health = 2000
    acidTurret.prepare_range = 40
    acidTurret.resistances = {
        {
            type = "fire",
            percent = 60
        },
        {
            type = "explosion",
            percent = 40
        },
        {
            type = "impact",
            percent = 30
        },
        {
            type = "physical",
            percent = 40
        },
        {
            type = "acid",
            percent = 40
        },
        {
            type = "electric",
            percent = 20
        },
        {
            type = "laser",
            percent = 20
        },
        {
            type = "poison",
            percent = 40
        }
    }

    local acidSticker = makeAcidSticker({
            name = "acid-cannon",
            duration = 1000,
            damage = 1
    })

    local acidPuddleName = makeAcidPuddle({
            name = "acid-cannon",
            damage = 40 / 60,
            scale = 1,
            stickerName = acidSticker
    })

    acidTurret.muzzle_animation = nil
    acidTurret.muzzle_light = nil

    acidTurret.attack_parameters = {
        type = "stream",
        ammo_category = "flamethrower",
        cooldown = 4,
        range = 36,
        min_range = 9,

        turn_range = 0.4,
        fire_penalty = 30,

        fluids = {
            {type = "sulfuric-acid", damage_modifier = 1.35}
        },
        fluid_consumption = 0.9,

        lead_target_for_projectile_speed = 0.6,
        gun_center_shift = {
            north={0,-1.5062500000000001},
            east={0.578125,-1.0218750000000001},
            south={0,-0.72500000000000009},
            west={-0.375,-1.1468750000000001}
        },
        gun_barrel_length = 0.4,

        ammo_type =
            {
                category = "flamethrower",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeAcidStream({
                                        name = "acid-cannon",
                                        bufferSize = 10,
                                        scale = 1,
                                        spawnInterval = 1,
                                        particleTimeout = 1,
                                        particleHoizontalSpeed = 0.4,
                                        actions = {
                                            {
                                                type = "direct",
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "play-sound",
                                                                    sound =
                                                                        {
                                                                            {
                                                                                filename = "__base__/sound/creatures/projectile-acid-burn-1.ogg",
                                                                                volume = 0.65
                                                                            },
                                                                            {
                                                                                filename = "__base__/sound/creatures/projectile-acid-burn-2.ogg",
                                                                                volume = 0.65
                                                                            },
                                                                            {
                                                                                filename = "__base__/sound/creatures/projectile-acid-burn-long-1.ogg",
                                                                                volume = 0.6
                                                                            },
                                                                            {
                                                                                filename = "__base__/sound/creatures/projectile-acid-burn-long-2.ogg",
                                                                                volume = 0.6
                                                                            }
                                                                        }
                                                                },
                                                                {
                                                                    type = "create-fire",
                                                                    entity_name = acidPuddleName,
                                                                    tile_collision_mask = { layers={water_tile=true} },
                                                                    show_in_tooltip = true
                                                                },
                                                                {
                                                                    type = "create-entity",
                                                                    entity_name = "water-splash",
                                                                    tile_collision_mask = { layers={ground_tile=true} }
                                                                },
                                                                {
                                                                    type = "destroy-decoratives",
                                                                    from_render_layer = "decorative",
                                                                    to_render_layer = "object",
                                                                    include_soft_decoratives = true,
                                                                    include_decals = false,
                                                                    invoke_decorative_trigger = true,
                                                                    decoratives_with_trigger_only = false,
                                                                    radius = 1
                                                                }
                                                            }
                                                    }
                                            },
                                            {
                                                type = "area",
                                                radius = 2.5,
                                                ignore_collision_condition = true,
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "create-sticker",
                                                                    sticker = acidSticker
                                                                },
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 3, type = "acid"}
                                                                }
                                                            }
                                                    }
                                            }
                                        }
                                }),
                                duration = 10,
                                source_offset = {0.15, -0.5},
                            }
                    }
            },

        cyclic_sound =
            {
                begin_sound =
                    {
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-start-1.ogg",
                            volume = 0.5
                        },
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-start-2.ogg",
                            volume = 0.5
                        },
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-start-3.ogg",
                            volume = 0.5
                        }
                    },
                middle_sound =
                    {
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-mid-1.ogg",
                            volume = 0.5
                        },
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-mid-2.ogg",
                            volume = 0.5
                        },
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-mid-3.ogg",
                            volume = 0.5
                        }
                    },
                end_sound =
                    {
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-end-1.ogg",
                            volume = 0.5
                        },
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-end-2.ogg",
                            volume = 0.5
                        },
                        {
                            filename = "__base__/sound/fight/flamethrower-turret-end-3.ogg",
                            volume = 0.5
                        }
                    }
            }
    }

    local acidCannonRecipe = util.table.deepcopy(data.raw["recipe"]["flamethrower-turret"])
    acidCannonRecipe.name = acidTurret.name
    acidCannonRecipe.results = {{type="item", name=acidTurret.name, amount=1}}
    acidCannonRecipe.energy_required = 25
    acidCannonRecipe.icon = nil
    acidCannonRecipe.icons = {
        {icon="__base__/graphics/icons/flamethrower-turret.png", icon_size=64, icon_mipmaps=4, tint={r=0.6,g=0.8,b=0.6}}
    }
    acidCannonRecipe.ingredients =
        {
            {type="item", name="steel-plate", amount=30},
            {type="item", name="iron-gear-wheel", amount=15},
            {type="item", name="plastic-bar", amount=5},
            {type="item", name="pipe", amount=10},
            {type="item", name="engine-unit", amount=10},
        }

    local acidItem = util.table.deepcopy(data.raw["item"]["flamethrower-turret"])
    acidItem.name = acidTurret.name
    acidItem.icon = nil
    acidItem.icons = {
        {icon="__base__/graphics/icons/flamethrower-turret.png", icon_size=64, icon_mipmaps=4, tint={r=0.6,g=0.8,b=0.6}}
    }
    acidItem.place_result = acidTurret.name

    data:extend({
            acidCannonRecipe,
            acidItem,
            acidTurret
    })


    addEffectToTech("flamethrower-2",
                    {
                        type = "unlock-recipe",
                        recipe = acidCannonRecipe.name,
    })

    local shotgunAttributes = {
        name = "shotgun",
        icon = "__RampantArsenal__/graphics/icons/shotgunTurret.png",
        miningTime = 1,
        health = 1000,
        hasBaseDirection = true,
        order = "b[turret]-a[shotgun-turret]",
        foldedAnimation = shotgunTurretSheet(),
        preparingAnimation = shotgunTurretSheet(),
        preparedAnimation = shotgunTurretSheet(),
        foldingAnimation = shotgunTurretSheet(),
        resistances = {
            {
                type = "fire",
                percent = 30
            },
            {
                type = "explosion",
                percent = 40
            },
            {
                type = "impact",
                percent = 50
            },
            {
                type = "physical",
                percent = 40
            },
            {
                type = "acid",
                percent = 50
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
                percent = 50
            }
        }
    }
    local shotgunTurret,shotgunTurretItem = makeAmmoTurret(shotgunAttributes, {
                                                               type = "projectile",
                                                               ammo_category = "shotgun-shell",
                                                               cooldown = 45,
                                                               min_range = 0,
                                                               damage_modifier = 1.5,
                                                               lead_target_for_projectile_speed = 0.9,
                                                               turn_range = 0.4,
                                                               projectile_creation_distance = 1.39375,
                                                               projectile_center = {0, -0.0875},
                                                               range = 17,
                                                               sound = sounds.shotgun
    })

    makeRecipe({
            name = cannonTurretItem,
            icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
            enabled = false,
            time = 30,
            ingredients = {
                {type="item", name="steel-plate", amount=45},
                {type="item", name="engine-unit", amount=5},
                {type="item", name="iron-gear-wheel", amount=15},
                {type="item", name="concrete", amount=20},
            },
            results = {{type="item", name=cannonTurretItem, amount=1}},
    })

    -- makeRecipe({
    --         name = cannonIITurretItem,
    --         icon = "__RampantArsenal__/graphics/icons/cannonTurret.png",
    --         enabled = false,
    --         time = 20,
    --         ingredients = {
    --     	{"steel-plate", 60},
    --     	{cannonTurretItem, 5},
    --     	{"iron-gear-wheel", 25},
    --     	{"concrete", 30}
    --         },
    --         result = cannonIITurretItem,
    -- })

    makeRecipe({
            name = rapidCannonTurretItem,
            icon = "__RampantArsenal__/graphics/icons/rapidCannonTurret.png",
            enabled = false,
            time = 35,
            ingredients = {
                {type="item", name="steel-plate", amount=40},
                {type="item", name="engine-unit", amount=10},
                {type="item", name="iron-gear-wheel", amount=15},
                {type="item", name="concrete", amount=20},
            },
            results = {{type="item", name=rapidCannonTurretItem, amount=1}},
    })

    makeRecipe({
            name = suppressionCannonTurretItem,
            icon = "__RampantArsenal__/graphics/icons/suppressionCannonTurret.png",
            enabled = false,
            time = 40,
            ingredients = {
                {type="item", name="steel-plate", amount=60},
                {type="item", name="engine-unit", amount=20},
                {type="item", name="advanced-circuit", amount=30},
                {type="item", name="concrete", amount=60},
            },
            results = {{type="item", name=suppressionCannonTurretItem, amount=1}},
    })

    makeRecipe({
            name = shotgunTurretItem,
            icon = "__RampantArsenal__/graphics/icons/shotgunTurret.png",
            enabled = false,
            time = 16,
            ingredients = {
                {type="item", name="steel-plate", amount=10},
                {type="item", name="copper-plate", amount=10},
                {type="item", name="iron-gear-wheel", amount=10},
            },
            results = {{type="item", name=shotgunTurretItem, amount=1}},

    })

    addEffectToTech("cannon-turret-1",
                    {
                        type = "unlock-recipe",
                        recipe = cannonTurretItem,
    })

    -- addEffectToTech("cannon-turret-3",
    --     	    {
    --     		type = "unlock-recipe",
    --     		recipe = cannonIITurretItem,
    -- })

    addEffectToTech("cannon-turret-2",
                    {
                        type = "unlock-recipe",
                        recipe = rapidCannonTurretItem,
    })

    addEffectToTech("shotgun",
                    {
                        type = "unlock-recipe",
                        recipe = shotgunTurretItem,
    })

    addEffectToTech("flamethrower-3",
                    {
                        type = "unlock-recipe",
                        recipe = suppressionCannonTurretItem,
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-1") or "physical-projectile-damage-1",
                    {
                        type = "turret-attack",
                        turret_id = shotgunTurret,
                        modifier = 0.2
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-2") or "physical-projectile-damage-2",
                    {
                        type = "turret-attack",
                        turret_id = shotgunTurret,
                        modifier = 0.2
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-3") or "physical-projectile-damage-3",
                    {
                        type = "turret-attack",
                        turret_id = shotgunTurret,
                        modifier = 0.3
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-4") or "physical-projectile-damage-4",
                    {
                        type = "turret-attack",
                        turret_id = shotgunTurret,
                        modifier = 0.3
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-5") or "physical-projectile-damage-5",
                    {
                        type = "turret-attack",
                        turret_id = shotgunTurret,
                        modifier = 0.4
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-6") or "physical-projectile-damage-6",
                    {
                        type = "turret-attack",
                        turret_id = shotgunTurret,
                        modifier = 0.6
    })

    if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "shotgun-turret-damage-7") or "physical-projectile-damage-7",
                        {
                            type = "turret-attack",
                            turret_id = shotgunTurret,
                            modifier = 0.8
        })
    end


    if settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value then

    addEffectToTech("cannon-turret-damage-1",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidCannonTurret,
                            modifier = 0.1
                        },
                        {
                            type = "turret-attack",
                            turret_id = cannonTurret,
                            modifier = 0.1
                        }
    })

    addEffectToTech("cannon-turret-damage-2",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidCannonTurret,
                            modifier = 0.1
                        },
                        {
                            type = "turret-attack",
                            turret_id = cannonTurret,
                            modifier = 0.1
                        }
    })

    addEffectToTech("cannon-turret-damage-3",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidCannonTurret,
                            modifier = 0.2
                        },
                        {
                            type = "turret-attack",
                            turret_id = cannonTurret,
                            modifier = 0.2
                        }
    })

    addEffectToTech("cannon-turret-damage-4",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidCannonTurret,
                            modifier = 0.3
                        },
                        {
                            type = "turret-attack",
                            turret_id = cannonTurret,
                            modifier = 0.3
                        }
    })
    end

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "cannon-turret-damage-5") or "physical-projectile-damage-5",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidCannonTurret,
                            modifier = 0.3
                        },
                        {
                            type = "turret-attack",
                            turret_id = cannonTurret,
                            modifier = 0.3
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "cannon-turret-damage-6") or "physical-projectile-damage-6",
                    {
                        {
                            type = "turret-attack",
                            turret_id = rapidCannonTurret,
                            modifier = 0.4
                        },
                        {
                            type = "turret-attack",
                            turret_id = cannonTurret,
                            modifier = 0.4
                        }
    })

    if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "cannon-turret-damage-7") or "physical-projectile-damage-7",
                        {
                            {
                                type = "turret-attack",
                                turret_id = rapidCannonTurret,
                                modifier = 0.5
                            },
                            {
                                type = "turret-attack",
                                turret_id = cannonTurret,
                                modifier = 0.5
                            }
        })
    end

    addEffectToTech("refined-flammables-1",
                    {
                        type = "turret-attack",
                        turret_id = suppressionCannonTurret,
                        modifier = 0.2
    })

    addEffectToTech("refined-flammables-1",
                    {
                        type = "turret-attack",
                        turret_id = acidTurret.name,
                        modifier = 0.2
    })

    addEffectToTech("refined-flammables-2",
                    {
                        type = "turret-attack",
                        turret_id = suppressionCannonTurret,
                        modifier = 0.2
    })

    addEffectToTech("refined-flammables-2",
                    {
                        type = "turret-attack",
                        turret_id = acidTurret.name,
                        modifier = 0.2
    })

    addEffectToTech("refined-flammables-3",
                    {
                        type = "turret-attack",
                        turret_id = suppressionCannonTurret,
                        modifier = 0.3
    })

    addEffectToTech("refined-flammables-3",
                    {
                        type = "turret-attack",
                        turret_id = acidTurret.name,
                        modifier = 0.3
    })

    addEffectToTech("refined-flammables-4",
                    {
                        type = "turret-attack",
                        turret_id = suppressionCannonTurret,
                        modifier = 0.3
    })

    addEffectToTech("refined-flammables-5",
                    {
                        type = "turret-attack",
                        turret_id = acidTurret.name,
                        modifier = 0.4
    })

    addEffectToTech("refined-flammables-5",
                    {
                        type = "turret-attack",
                        turret_id = suppressionCannonTurret,
                        modifier = 0.4
    })

    addEffectToTech("refined-flammables-6",
                    {
                        type = "turret-attack",
                        turret_id = acidTurret.name,
                        modifier = 0.4
    })

    addEffectToTech("refined-flammables-6",
                    {
                        type = "turret-attack",
                        turret_id = suppressionCannonTurret,
                        modifier = 0.4
    })

    if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
        addEffectToTech("refined-flammables-7",
                        {
                            type = "turret-attack",
                            turret_id = suppressionCannonTurret,
                            modifier = 0.5
        })

        modifyInfiniteFormula("refined-flammables-7", "(L-6)*20000")

        addEffectToTech("refined-flammables-7",
                        {
                            type = "turret-attack",
                            turret_id = acidTurret.name,
                            modifier = 0.5
        })
    end
    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        local incendiaryCannonShellAmmo = makeAmmo({
                name = "incendiary-cannon-shell",
                icon = "__RampantArsenal__/graphics/icons/incendiary-cannon-shell.png",
                order = "d[cannon-shell]-c[incendiary]",
                magSize = 1,
                stackSize = 200,
                ammoCategory = "cannon-shell",
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
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 1,
                                        max_range = 34,
                                        direction_deviation = 0.1,
                                        range_deviation = 0.1,
                                        min_range = 5,
                                        projectile = makeCannonProjectile({
                                                name = "incendiary",
                                                piercingDamage = 100,
                                                animation = {
                                                    filename = "__base__/graphics/entity/bullet/bullet.png",
                                                    frame_count = 1,
                                                    width = 3,
                                                    height = 50,
                                                    priority = "high"
                                                },
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 100 , type = "physical"}
                                                                        },
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 800 , type = "fire"}
                                                                        },
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 100 , type = "explosion"}
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        },
                                                                        {
                                                                            type = "create-sticker",
                                                                            sticker = "small-fire-sticker-rampant-arsenal"
                                                                        },
                                                                        {
                                                                            type = "create-fire",
                                                                            entity_name = "fire-flame",
                                                                            initial_ground_flame_count = 4
                                                                        }
                                                                    }
                                                            }
                                                    },
                                                finalAction =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        },
                                                                        {
                                                                            type = "nested-result",
                                                                            action =
                                                                                {
                                                                                    {
                                                                                        type = "cluster",
                                                                                        cluster_count = 5,
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
                                                                                        radius = 4,
                                                                                        action_delivery =
                                                                                            {
                                                                                                {
                                                                                                    type = "instant",
                                                                                                    target_effects =
                                                                                                        {
                                                                                                            {
                                                                                                                type = "create-fire",
                                                                                                                entity_name = "fire-flame",
                                                                                                                initial_ground_flame_count = 4
                                                                                                            },
                                                                                                            {
                                                                                                                type = "create-sticker",
                                                                                                                sticker = "small-fire-sticker-rampant-arsenal"
                                                                                                            }
                                                                                                        }
                                                                                                }
                                                                                            }
                                                                                }}
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "small-scorchmark",
                                                                            check_buildability = true
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
                name = incendiaryCannonShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/incendiary-cannon-shell.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="explosive-cannon-shell", amount=1},
                    {type="item", name="iron-plate", amount=1},
                    {type = "fluid", name = "light-oil", amount = 40},
                },
                results = {{type="item", name=incendiaryCannonShellAmmo, amount=1}},
        })

        addEffectToTech("incendiary-cannon-shells",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryCannonShellAmmo,
        })

        local heCannonShellAmmo = makeAmmo({
                name = "he-cannon-shell",
                icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
                order = "d[cannon-shell]-c[he]",
                magSize = 1,
                stackSize = 200,
                ammoCategory = "cannon-shell",
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
                                action_delivery =
                                    {
                                        type = "projectile",
                                        max_range = 34,
                                        direction_deviation = 0.1,
                                        range_deviation = 0.1,
                                        min_range = 5,

                                        starting_speed = 1,
                                        projectile = makeCannonProjectile({
                                                name = "he",
                                                piercingDamage = 100,
                                                animation = {
                                                    filename = "__base__/graphics/entity/bullet/bullet.png",
                                                    frame_count = 1,
                                                    width = 3,
                                                    height = 50,
                                                    priority = "high"
                                                },
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 800 , type = "physical"}
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        }
                                                                    }
                                                            }
                                                    },
                                                finalAction =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        },
                                                                        {
                                                                            type = "nested-result",
                                                                            action =
                                                                                {
                                                                                    type = "area",
                                                                                    radius = 4,
                                                                                    action_delivery =
                                                                                        {
                                                                                            type = "instant",
                                                                                            target_effects =
                                                                                                {
                                                                                                    {
                                                                                                        type = "damage",
                                                                                                        damage = {amount = 800, type = "explosion"}
                                                                                                    }
                                                                                                }
                                                                                        }
                                                                                }
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "small-scorchmark",
                                                                            check_buildability = true
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
                name = heCannonShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/he-cannon-shell.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="explosive-cannon-shell", amount=1},
                    {type="item", name="iron-plate", amount=1},
                    {type="item", name="explosives", amount=6},
                },
                results = {{type="item", name=heCannonShellAmmo, amount=1}},
        })

        addEffectToTech("he-cannon-shells",
                        {
                            type = "unlock-recipe",
                            recipe = heCannonShellAmmo,
        })

        local bioCannonShellAmmo = makeAmmo({
                name = "bio-cannon-shell",
                icon = "__RampantArsenal__/graphics/icons/bio-cannon-shell.png",
                order = "d[cannon-shell]-c[fbio]",
                magSize = 1,
                stackSize = 200,
                ammoCategory = "cannon-shell",
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
                                action_delivery =
                                    {
                                        type = "projectile",
                                        starting_speed = 1,
                                        max_range = 34,
                                        direction_deviation = 0.1,
                                        range_deviation = 0.1,
                                        min_range = 5,

                                        projectile = makeCannonProjectile({
                                                name = "bio",
                                                piercingDamage = 100,
                                                animation = {
                                                    filename = "__base__/graphics/entity/bullet/bullet.png",
                                                    frame_count = 1,
                                                    width = 3,
                                                    height = 50,
                                                    priority = "high"
                                                },
                                                action =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 100 , type = "physical"}
                                                                        },
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 800 , type = "poison"}
                                                                        },
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 100 , type = "explosion"}
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        }
                                                                    }
                                                            }
                                                    },
                                                finalAction =
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "big-explosion"
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "toxic-cloud-rampant-arsenal",
                                                                            show_in_tooltip = true
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "small-scorchmark",
                                                                            check_buildability = true
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
                name = bioCannonShellAmmo,
                icon = "__RampantArsenal__/graphics/icons/bio-cannon-shell.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="explosive-cannon-shell", amount=1},
                    {type="item", name="iron-plate", amount=1},
                    {type="item", name="poison-capsule", amount=2},
                },
                results = {{type="item", name=bioCannonShellAmmo, amount=1}},
        })

        addEffectToTech("bio-cannon-shells",
                        {
                            type = "unlock-recipe",
                            recipe = bioCannonShellAmmo,
        })


        data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids[1].damage_modifier = 0.8
        data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids[2].damage_modifier = 1.0

        local targetEffects = data.raw["projectile"]["uranium-cannon-projectile"].action.action_delivery.target_effects
        targetEffects[1].damage.amount = targetEffects[1].damage.amount * 3
        targetEffects[2].damage.amount = targetEffects[2].damage.amount * 3

        data.raw["ammo"]["cannon-shell"]["ammo_type"]["action"]["action_delivery"]["max_range"] = 34
        data.raw["ammo"]["explosive-cannon-shell"]["ammo_type"]["action"]["action_delivery"]["max_range"] = 34
        data.raw["ammo"]["explosive-uranium-cannon-shell"]["ammo_type"]["action"]["action_delivery"]["max_range"] = 34
        data.raw["ammo"]["uranium-cannon-shell"]["ammo_type"]["action"]["action_delivery"]["max_range"] = 34


        data.raw["technology"]["refined-flammables-7"].effects[2].modifier = 0.5

        targetEffects = data.raw["projectile"]["explosive-uranium-cannon-projectile"].action.action_delivery.target_effects
        targetEffects[1].damage.amount = targetEffects[1].damage.amount * 2.4

        local action = data.raw["projectile"]["explosive-uranium-cannon-projectile"].final_action.action_delivery.target_effects[2].action
        targetEffects = action.action_delivery.target_effects
        targetEffects[1].damage.amount = targetEffects[1].damage.amount * 2.4

    end
end


return cannons
