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


local capsules = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local ammoUtils = require("utils/AmmoUtils")
local streamUtils = require("utils/StreamUtils")

local addEffectToTech = technologyUtils.addEffectToTech
local makeStreamProjectile = streamUtils.makeStreamProjectile
local makeAmmo = ammoUtils.makeAmmo
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local capsuleGrey = {r=0,g=0,b=0,a=0.9}
local particleGrey = {r=0,g=0,b=0,a=0.9}

local function CapsuleLauncherSheet()
    return
        {
            layers =
                {
                    {
                        filename = "__RampantArsenal__/graphics/yuokiTani/entities/arty2x2-sheet.png",
                        priority = "high",
                        width = 168,
                        height = 168,
                        line_length = 8,
                        axially_symmetrical = false,
                        direction_count = 64,
                        frame_count = 1,
                        shift = {0, -1.4},
                    }
                }
        }
end



function capsules.enable()

    data.raw["combat-robot"]["distractor"]["attack_parameters"]["damage_modifier"] = 2
    data.raw["combat-robot"]["destroyer"]["attack_parameters"]["damage_modifier"] = 2
    data.raw["combat-robot"]["defender"]["attack_parameters"]["damage_modifier"] = 2

    data:extend(
        {
            {
                type = "item-subgroup",
                name = "launcher-capsule",
                group = "combat",
                order = "b-b"
            },
            {
                type = "ammo-category",
                name = "capsule-launcher",
            },
            {
                type = "simple-entity-with-force",
                name = "rampant-clean-ghost-mine",
                render_layer = "object",
                icon = "__base__/graphics/icons/steel-chest.png",
                icon_size = 32,
                flags = {"placeable-neutral", "player-creation"},
                order = "s-e-w-f",
                minable = {mining_time = 1, result = "simple-entity-with-force"},
                max_health = 100,
                corpse = "small-remnants",
                -- collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
                -- selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                picture =
                    {
                        filename = "__core__/graphics/empty.png",
                        priority = "extra-high",
                        width = 1,
                        height = 1
                    }
            }
    })

    local slowCapsules = makeAmmo({
            name = "slowdown-capsule",
            icon = "__RampantArsenal__/graphics/icons/slowdown-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "h[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "slowdown-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "area",
                                            radius = 10,
                                            force = "enemy",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            type = "create-sticker",
                                                            sticker = "slowdown-sticker"
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160
                            }
                    }
    }})

    local paralysisCapsules = makeAmmo({
            name = "paralysis-capsule",
            icon = "__RampantArsenal__/graphics/icons/paralysis-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "i[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "paralysis-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            type = "create-entity",
                                                            show_in_tooltip = true,
                                                            entity_name = "big-paralysis-cloud-rampant-arsenal"
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160
                            }
                    }
    }})

    local repairCapsules = makeAmmo({
            name = "repair-capsule",
            icon = "__RampantArsenal__/graphics/icons/repair-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "j[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "repair-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            type = "create-entity",
                                                            show_in_tooltip = true,
                                                            entity_name = "big-repair-cloud-rampant-arsenal"
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160
                            }
                    }
    }})

    local poisonCapsules = makeAmmo({
            name = "poison-capsule",
            icon = "__RampantArsenal__/graphics/icons/poison-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "f[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "poison-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            type = "create-entity",
                                                            show_in_tooltip = true,
                                                            entity_name = "big-poison-cloud-rampant-arsenal"
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160
                            }
                    }
    }})

    local distractorCapsules = makeAmmo({
            name = "distractor-capsule",
            icon = "__RampantArsenal__/graphics/icons/distractor-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "l[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "distractor-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-entity",
                                                                show_in_tooltip = true,
                                                                entity_name = "distractor",
                                                                offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
                                                            }
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160,
                            }
                    }
    }})

    local defenderLaunched = util.table.deepcopy(data.raw["combat-robot"]["defender"])
    defenderLaunched.name = defenderLaunched.name .. "-launched-rampant-arsenal"
    defenderLaunched.speed = 0
    defenderLaunched.follows_player = false

    local destroyerLaunched = util.table.deepcopy(data.raw["combat-robot"]["destroyer"])
    destroyerLaunched.name = destroyerLaunched.name .. "-launched-rampant-arsenal"
    destroyerLaunched.speed = 0
    destroyerLaunched.follows_player = false

    data:extend({
            defenderLaunched,
            destroyerLaunched
    })

    local defenderCapsules = makeAmmo({
            name = "defender-capsule",
            icon = "__RampantArsenal__/graphics/icons/defender-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "k[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "defender-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-entity",
                                                                show_in_tooltip = true,
                                                                entity_name = "defender-launched-rampant-arsenal",
                                                                offsets = {{0.5, -0.5}}
                                                            }
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160,
                            }
                    }
    }})

    local destroyerCapsules = makeAmmo({
            name = "destroyer-capsule",
            icon = "__RampantArsenal__/graphics/icons/destroyer-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "m[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                -- stream = "acid-stream-spitter-behemoth",
                                stream = makeStreamProjectile({
                                        name = "destroyer-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-entity",
                                                                show_in_tooltip = true,
                                                                entity_name = "destroyer-launched-rampant-arsenal",
                                                                offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5},{-0.5, 0},{0, 0}}
                                                            }
                                                        }
                                                }
                                        }
                                }),
                                max_length = 9,
                                duration = 160,
                            }
                    }
    }})

    local landmineCapsules = makeAmmo({
            name = "landmine-capsule",
            icon = "__RampantArsenal__/graphics/icons/landmine-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "n[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "landmine-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            {
                                                type = "direct",
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects = {
                                                            type = "create-entity",
                                                            entity_name = "landmine-ghostless-rampant-arsenal"
                                                        }
                                                    }
                                            },
                                            {
                                                type = "cluster",
                                                cluster_count = 3,
                                                distance = 4,
                                                distance_deviation = 3,
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "create-entity",
                                                                    show_in_tooltip = true,
                                                                    entity_name = "landmine-ghostless-rampant-arsenal"
                                                                }
                                                            }
                                                    }
                                        }}
                                }),
                                max_length = 9,
                                duration = 160,
                            }
                    }
    }})

    local grenadeCapsules = makeAmmo({
            name = "grenade-capsule",
            icon = "__RampantArsenal__/graphics/icons/grenade-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "a[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,

                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "grenade-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            {
                                                type = "direct",
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "create-entity",
                                                                    entity_name = "medium-explosion"
                                                                },
                                                                {
                                                                    type = "create-entity",
                                                                    entity_name = "small-scorchmark",
                                                                    check_buildability = true
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
                                                                }
                                                            }
                                                    }
                                            },
                                            {
                                                type = "area",
                                                radius = 7.5,
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "damage",
                                                                    damage = {amount = 300, type = "explosion"}
                                                                },
                                                                {
                                                                    type = "create-entity",
                                                                    entity_name = "explosion"
                                                                }
                                                            }
                                                    }
                                            }
                                        }
                                }),
                                max_length = 9,
                                duration = 200,
                            }
                    }
    }})

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then

        local toxicCapsules = makeAmmo({
                name = "toxic-capsule",
                icon = "__RampantArsenal__/graphics/icons/toxic-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "g[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "toxic-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                type = "direct",
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                type = "create-entity",
                                                                show_in_tooltip = true,
                                                                entity_name = "big-toxic-launcher-cloud-rampant-arsenal"
                                                            }
                                                    }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 160
                                }
                        }
        }})

        local incendiaryLandmineCapsules = makeAmmo({
                name = "incendiary-landmine-capsule",
                icon = "__RampantArsenal__/graphics/icons/incendiary-landmine-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "w[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "incendiary-landmine-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects = {
                                                                {
                                                                    type = "create-entity",
                                                                    show_in_tooltip = true,
                                                                    entity_name = "incendiary-landmine-ghostless-rampant-arsenal"
                                                                }
                                                            }
                                                        }
                                                }-- ,
                                                -- {
                                                --     type = "cluster",
                                                --     cluster_count = 2,
                                                --     distance = 7,
                                                --     distance_deviation = 3,
                                                --     action_delivery =
                                                --         {
                                                --     	type = "instant",
                                                --     	target_effects =
                                                --     	    {
                                                --     		{
                                                --     		    type = "create-entity",
                                                --     		    show_in_tooltip = true,
                                                --     		    entity_name = "incendiary-landmine-ghostless-rampant-arsenal"
                                                --     		}
                                                --     	    }
                                                --         }
                                                -- }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 160,
                                }
                        }
        }})

        local heLandmineCapsules = makeAmmo({
                name = "he-landmine-capsule",
                icon = "__RampantArsenal__/graphics/icons/he-landmine-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "p[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "he-landmine-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects = {
                                                                {
                                                                    type = "create-entity",
                                                                    show_in_tooltip = true,
                                                                    entity_name = "he-landmine-ghostless-rampant-arsenal"
                                                                }
                                                            }
                                                        }
                                                }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 160,
                                }
                        }
        }})

        local bioLandmineCapsules = makeAmmo({
                name = "bio-landmine-capsule",
                icon = "__RampantArsenal__/graphics/icons/bio-landmine-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "o[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "bio-landmine-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects = {
                                                                {
                                                                    type = "create-entity",
                                                                    show_in_tooltip = true,
                                                                    entity_name = "bio-landmine-ghostless-rampant-arsenal"
                                                                }
                                                            }
                                                        }
                                                }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 160,
                                }
                        }
        }})

        local nuclearLandmineCapsules = makeAmmo({
                name = "nuclear-landmine-capsule",
                icon = "__RampantArsenal__/graphics/icons/nuclear-landmine-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "x[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "nuclear-landmine-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects = {
                                                                {
                                                                    type = "create-entity",
                                                                    show_in_tooltip = true,
                                                                    entity_name = "nuclear-landmine-ghostless-rampant-arsenal"
                                                                }
                                                            }
                                                        }
                                            }}
                                    }),
                                    max_length = 9,
                                    duration = 160,
                                }
                        }
        }})

        local bioGrenadeCapsules = makeAmmo({
                name = "bio-grenade-capsule",
                icon = "__RampantArsenal__/graphics/icons/bio-grenade-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "b[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "bio-grenade-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "medium-explosion"
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "small-scorchmark",
                                                                        check_buildability = true
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "toxic-cloud-rampant-arsenal",
                                                                        show_in_tooltip = true
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
                                                                    }
                                                                }
                                                        }
                                                },
                                                {
                                                    type = "area",
                                                    radius = 7.5,
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 350, type = "poison"}
                                                                    },
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 50, type = "explosion"}
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "explosion"
                                                                    }
                                                                }
                                                        }
                                                }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 200,
                                }
                        }
        }})

        local heGrenadeCapsules = makeAmmo({
                name = "he-grenade-capsule",
                icon = "__RampantArsenal__/graphics/icons/he-grenade-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "c[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "he-grenade-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
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
                                                                        entity_name = "small-scorchmark",
                                                                        check_buildability = true
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
                                                                    }
                                                                }
                                                        }
                                                },
                                                {
                                                    type = "area",
                                                    radius = 7.5,
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 675, type = "explosion"}
                                                                    },
                                                                    {
                                                                        type = "damage",
                                                                        damage = {amount = 150, type = "physical"}
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "medium-explosion"
                                                                    }
                                                                }
                                                        }
                                                }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 200,
                                }
                        }
        }})

        local incendiaryGrenadeCapsules = makeAmmo({
                name = "incendiary-grenade-capsule",
                icon = "__RampantArsenal__/graphics/icons/incendiary-grenade-capsule-ammo.png",
                magSize = 1,
                subgroup = "launcher-capsule",
                order = "d[capsule]",
                stackSize = 200,
                ammoCategory = "capsule-launcher",
                ammoType = {
                    target_type = "position",
                    clamp_position = true,

                    action =
                        {
                            type = "direct",
                            action_delivery =
                                {
                                    type = "stream",
                                    stream = makeStreamProjectile({
                                            name = "incendiary-grenade-capsule",
                                            bufferSize = 1,
                                            spineAnimationTint = capsuleGrey,
                                            particleTint = particleGrey,
                                            spawnInterval = 1,
                                            actions = {
                                                {
                                                    type = "direct",
                                                    action_delivery =
                                                        {
                                                            type = "instant",
                                                            target_effects =
                                                                {
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "medium-explosion"
                                                                    },
                                                                    {
                                                                        type = "create-entity",
                                                                        entity_name = "small-scorchmark",
                                                                        check_buildability = true
                                                                    },
                                                                    {
                                                                        type = "create-fire",
                                                                        entity_name = "fire-flame",
                                                                        initial_ground_flame_count = 4
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
                                                                    }
                                                                }
                                                        }
                                                },
                                                {
                                                    type = "cluster",
                                                    cluster_count = 10,
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
                                                    radius = 7.5,
                                                    action_delivery =
                                                        {
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 50, type = "explosion"}
                                                                        },
                                                                        {
                                                                            type = "damage",
                                                                            damage = {amount = 350, type = "fire"}
                                                                        },
                                                                        {
                                                                            type = "create-entity",
                                                                            entity_name = "explosion"
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
                                                        }}
                                                }
                                            }
                                    }),
                                    max_length = 9,
                                    duration = 200,
                                }
                        }
        }})


        makeRecipe({
                name = toxicCapsules,
                icon = "__RampantArsenal__/graphics/icons/toxic-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="toxic-capsule-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=toxicCapsules, amount=1}}
        })

        makeRecipe({
                name = incendiaryLandmineCapsules,
                icon = "__RampantArsenal__/graphics/icons/incendiary-landmine-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="incendiary-landmine-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=incendiaryLandmineCapsules, amount=1}}
        })

        makeRecipe({
                name = heLandmineCapsules,
                icon = "__RampantArsenal__/graphics/icons/he-landmine-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="he-landmine-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=heLandmineCapsules, amount=1}}
        })


        makeRecipe({
                name = bioLandmineCapsules,
                icon = "__RampantArsenal__/graphics/icons/bio-landmine-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="bio-landmine-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=bioLandmineCapsules, amount=1}}
        })

        makeRecipe({
                name = nuclearLandmineCapsules,
                icon = "__RampantArsenal__/graphics/icons/nuclear-landmine-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="nuclear-landmine-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=nuclearLandmineCapsules, amount=1}}
        })

        makeRecipe({
                name = bioGrenadeCapsules,
                icon = "__RampantArsenal__/graphics/icons/bio-grenade-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="bio-grenade-capsule-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=bioGrenadeCapsules, amount=1}}
        })

        makeRecipe({
                name = heGrenadeCapsules,
                icon = "__RampantArsenal__/graphics/icons/he-grenade-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="he-grenade-capsule-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=heGrenadeCapsules, amount=1}}
        })

        makeRecipe({
                name = incendiaryGrenadeCapsules,
                icon = "__RampantArsenal__/graphics/icons/incendiary-grenade-capsule-ammo.png",
                enabled = false,
                ingredients = {
                    {type="item", name="iron-plate", amount=2},
                    {type="item", name="incendiary-grenade-capsule-rampant-arsenal", amount=1},
                    {type="item", name="explosives", amount=1}
                },
                results = {{type="item", name=incendiaryGrenadeCapsules, amount=1}}
        })

        addEffectToTech("incendiary-landmine",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryLandmineCapsules,
        })

        addEffectToTech("he-landmine",
                        {
                            type = "unlock-recipe",
                            recipe = heLandmineCapsules,
        })

        addEffectToTech("bio-landmine",
                        {
                            type = "unlock-recipe",
                            recipe = bioLandmineCapsules,
        })

        addEffectToTech("uranium-ammo",
                        {
                            type = "unlock-recipe",
                            recipe = nuclearLandmineCapsules,
        })

        addEffectToTech("bio-grenades",
                        {
                            type = "unlock-recipe",
                            recipe = bioGrenadeCapsules,
        })

        addEffectToTech("bio-capsules",
                        {
                            type = "unlock-recipe",
                            recipe = toxicCapsules,
        })

        addEffectToTech("he-grenades",
                        {
                            type = "unlock-recipe",
                            recipe = heGrenadeCapsules,
        })

        addEffectToTech("incendiary-grenades",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryGrenadeCapsules,
        })
    end

    local clusterGrenadeCapsules = makeAmmo({
            name = "cluster-grenade-capsule",
            icon = "__RampantArsenal__/graphics/icons/cluster-grenade-capsule-ammo.png",
            magSize = 1,
            subgroup = "launcher-capsule",
            order = "e[capsule]",
            stackSize = 200,
            ammoCategory = "capsule-launcher",
            ammoType = {
                target_type = "position",
                clamp_position = true,
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = makeStreamProjectile({
                                        name = "cluster-grenade-capsule",
                                        bufferSize = 1,
                                        spineAnimationTint = capsuleGrey,
                                        particleTint = particleGrey,
                                        spawnInterval = 1,
                                        actions = {
                                            {
                                                type = "direct",
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                {
                                                                    type = "create-entity",
                                                                    entity_name = "explosion"
                                                                },
                                                                {
                                                                    type = "create-entity",
                                                                    entity_name = "small-scorchmark",
                                                                    check_buildability = true
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
                                                                }
                                                            }
                                                    }
                                            },
                                            {
                                                type = "cluster",
                                                cluster_count = 9,
                                                distance = 7,
                                                distance_deviation = 3,
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects = {
                                                            type = "create-entity",
                                                            entity_name = "cluster-grenade"
                                                        }
                                                    }
                                            }
                                        }
                                }),
                                max_length = 9,
                                duration = 200,
                            }
                    }
    }})

    makeRecipe({
            name = slowCapsules,
            icon = "__RampantArsenal__/graphics/icons/slowdown-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="slowdown-capsule", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=slowCapsules, amount=1}}
    })

    makeRecipe({
            name = poisonCapsules,
            icon = "__RampantArsenal__/graphics/icons/poison-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="poison-capsule", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=poisonCapsules, amount=1}}
    })

    makeRecipe({
            name = paralysisCapsules,
            icon = "__RampantArsenal__/graphics/icons/paralysis-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="paralysis-capsule-rampant-arsenal", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=paralysisCapsules, amount=1}}
    })

    makeRecipe({
            name = repairCapsules,
            icon = "__RampantArsenal__/graphics/icons/repair-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="repair-capsule-rampant-arsenal", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=repairCapsules, amount=1}}
    })

    makeRecipe({
            name = distractorCapsules,
            icon = "__RampantArsenal__/graphics/icons/distractor-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="distractor-capsule", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=distractorCapsules, amount=1}}
    })

    makeRecipe({
            name = defenderCapsules,
            icon = "__RampantArsenal__/graphics/icons/defender-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="defender-capsule", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=defenderCapsules, amount=1}}
    })

    makeRecipe({
            name = destroyerCapsules,
            icon = "__RampantArsenal__/graphics/icons/destroyer-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="destroyer-capsule", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=destroyerCapsules, amount=1}}
    })

    makeRecipe({
            name = landmineCapsules,
            icon = "__RampantArsenal__/graphics/icons/landmine-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="land-mine", amount=4},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=landmineCapsules, amount=1}}
    })

    makeRecipe({
            name = grenadeCapsules,
            icon = "__RampantArsenal__/graphics/icons/grenade-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="grenade", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=grenadeCapsules, amount=1}}
    })

    makeRecipe({
            name = clusterGrenadeCapsules,
            icon = "__RampantArsenal__/graphics/icons/cluster-grenade-capsule-ammo.png",
            enabled = false,
            ingredients = {
                {type="item", name="iron-plate", amount=2},
                {type="item", name="cluster-grenade", amount=1},
                {type="item", name="explosives", amount=1}
            },
            results = {{type="item", name=clusterGrenadeCapsules, amount=1}}
    })

    local entity = {
        name = "capsule",
        icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
        miningTime = 1,
        health = 1200,
        foldedAnimation = CapsuleLauncherSheet(),
        foldingAnimation = CapsuleLauncherSheet(),
        preparedAnimation = CapsuleLauncherSheet(),
        preparingAnimation = CapsuleLauncherSheet(),
        order = "b[turret]-d[acapsule-turret]",
        hasBaseDirection = true,
        rotationSpeed = 0.004,
        resistances = {
            {
                type = "fire",
                percent = 30
            },
            {
                type = "impact",
                percent = 30
            },
            {
                type = "explosion",
                percent = 20
            },
            {
                type = "physical",
                percent = 20
            },
            {
                type = "acid",
                percent = 30
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
                percent = 30
            }
        }
    }
    local capsuleTurret, capsuleTurretItem = makeAmmoTurret(entity, {
                                                                type = "stream",
                                                                ammo_category = "capsule-launcher",
                                                                cooldown = 450,
                                                                damage_modifier = 1.25,
                                                                lead_target_for_projectile_speed = 0.4,
                                                                gun_center_shift = {
                                                                    north = {0, 0},
                                                                    east = {0, -4},
                                                                    south = {0, 0},
                                                                    west = {0, -4}
                                                                },
                                                                gun_barrel_length = 4,
                                                                min_range = 20,
                                                                turn_range = 0.30,
                                                                range = 50,
                                                                sound = {
                                                                    {
                                                                        filename = "__base__/sound/fight/tank-cannon.ogg",
                                                                        volume = 1.0
                                                                    }
                                                                }
    })

    makeRecipe({
            name = capsuleTurretItem,
            icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
            enabled = false,
            ingredients = {
                {type="item", name="steel-plate", amount=10},
                {type="item", name="engine-unit", amount=5},
                {type="item", name="advanced-circuit", amount=15},
                {type="item", name="explosives", amount=30}
            },
            results = {{type="item", name=capsuleTurretItem, amount=1}}
    })

    addEffectToTech("defender",
                    {
                        type = "unlock-recipe",
                        recipe = defenderCapsules,
    })

    addEffectToTech("distractor",
                    {
                        type = "unlock-recipe",
                        recipe = distractorCapsules,
    })

    addEffectToTech("destroyer",
                    {
                        type = "unlock-recipe",
                        recipe = destroyerCapsules,
    })

    addEffectToTech("land-mine",
                    {
                        type = "unlock-recipe",
                        recipe = landmineCapsules,
    })

    addEffectToTech("military-4",
                    {
                        type = "unlock-recipe",
                        recipe = clusterGrenadeCapsules,
    })

    addEffectToTech("military-2",
                    {
                        type = "unlock-recipe",
                        recipe = grenadeCapsules,
    })

    addEffectToTech("regeneration",
                    {
                        type = "unlock-recipe",
                        recipe = repairCapsules,
    })

    addEffectToTech("paralysis",
                    {
                        type = "unlock-recipe",
                        recipe = paralysisCapsules,
    })

    addEffectToTech("capsule-turret",
                    {
                        {
                            type = "unlock-recipe",
                            recipe = capsuleTurretItem,
                        },
                        {
                            type = "unlock-recipe",
                            recipe = slowCapsules,
                        },
                        {
                            type = "unlock-recipe",
                            recipe = poisonCapsules,
                        }
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-1") or "stronger-explosives-1",
        {
            type = "turret-attack",
            turret_id = capsuleTurret,
            modifier = 0.2
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-2") or "stronger-explosives-2",
        {
            type = "turret-attack",
            turret_id = capsuleTurret,
            modifier = 0.2
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-3") or "stronger-explosives-3",
        {
            type = "turret-attack",
            turret_id = capsuleTurret,
            modifier = 0.3
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-4") or "stronger-explosives-4",
        {
            type = "turret-attack",
            turret_id = capsuleTurret,
            modifier = 0.3
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-5") or "stronger-explosives-5",
        {
            type = "turret-attack",
            turret_id = capsuleTurret,
            modifier = 0.4
    })

    addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-6") or "stronger-explosives-6",
        {
            type = "turret-attack",
            turret_id = capsuleTurret,
            modifier = 0.4
    })

    if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
        addEffectToTech((settings.startup["rampant-arsenal-hideVanillaDamageTechnologies"].value and "capsule-turret-damage-7") or "stronger-explosives-7",
            {
                type = "turret-attack",
                turret_id = capsuleTurret,
                modifier = 0.6
        })
    end

    addEffectToTech("stronger-explosives-1",
                    {
                        type = "ammo-damage",
                        ammo_category = "capsule-launcher",
                        modifier = 0.3
    })

    addEffectToTech("stronger-explosives-2",
                    {
                        type = "ammo-damage",
                        ammo_category = "capsule-launcher",
                        modifier = 0.3
    })

    addEffectToTech("stronger-explosives-3",
                    {
                        type = "ammo-damage",
                        ammo_category = "capsule-launcher",
                        modifier = 0.4
    })

    addEffectToTech("stronger-explosives-4",
                    {
                        type = "ammo-damage",
                        ammo_category = "capsule-launcher",
                        modifier = 0.4
    })

    addEffectToTech("stronger-explosives-5",
                    {
                        type = "ammo-damage",
                        ammo_category = "capsule-launcher",
                        modifier = 0.5
    })

    addEffectToTech("stronger-explosives-6",
                    {
                        type = "ammo-damage",
                        ammo_category = "capsule-launcher",
                        modifier = 0.5
    })

    if (settings.startup["rampant-arsenal-useInfiniteTechnologies"].value) then
        addEffectToTech("stronger-explosives-7",
                        {
                            type = "ammo-damage",
                            ammo_category = "capsule-launcher",
                            modifier = 0.6
        })
    end
end

return capsules
