local clouds = {}

local cloudUtils = require("utils/CloudUtils")
local fireUtils = require("utils/FireUtils")

local makeCloud = cloudUtils.makeCloud
local makeFireFlame = fireUtils.makeFireFlame

function clouds.enable()

    makeCloud(
        {
            name = "big-toxic",
            duration = 160,
            inDuration = 120,
            outDuration = 40,
            movementModifier = 0,
            spreadDuration = 120,
            tint = {r=0.5,g=0,b=0.5,a=0.4},
            scale = 2
    })

    makeCloud(
        {
            name = "big-toxic-launcher",
            duration = 160,
            inDuration = 120,
            outDuration = 40,
            movementModifier = 0,
            spreadDuration = 120,
            tint = {r=0.5,g=0,b=0.5,a=0.4},
            scale = 2
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 12,
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    {
                                                        type = "damage",
                                                        damage = { amount = 400, type = "poison" }
                                                    },
                                                    {
                                                        type = "create-sticker",
                                                        sticker = "big-toxic-sticker-rampant-arsenal"
                                                    }
                                                }
                                        }
                                }
                        }
                }
        }
    )

    makeFireFlame(
        {
            name = "massive",
            duration = 1600,
            inDuration = 120,
            outDuration = 30,
            damagePerTick = 3.67
        }
    )

    makeCloud(
        {
            name = "massive-fire",
            duration = 1600,
            inDuration = 160,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.5,g=0.3,b=0,a=0.4},
            scale = 3
        }
    )

    makeCloud(
        {
            name = "big-poison",
            duration = 1200,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0,g=0.8,b=0,a=0.4},
            scale = 2
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 13,
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = { amount = 32, type = "poison"}
                                                }
                                        }
                                }
                        }
                }
    })

    makeCloud(
        {
            name = "big-repair",
            duration = 800,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.5,g=0.3,b=0,a=0.4},
            scale = 2
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 12,
                                    entity_flags = {"player-creation"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = { amount = -110, type = "healing" }
                                                }
                                        }
                                }
                        }
                }
    })

    makeCloud(
        {
            name = "massive-repair",
            duration = 1200,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.5,g=0.3,b=0,a=0.4},
            scale = 4,
            cooldown = 60
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 20,
                                    entity_flags = {"player-creation"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = { amount = -20, type = "healing" }
                                                }
                                        }
                                }
                        }
                }
    })

    makeCloud(
        {
            name = "big-paralysis",
            duration = 600,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0,g=0,b=0.8,a=0.4},
            scale = 2
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 9.5,
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "create-sticker",
                                                    sticker = "big-paralysis-sticker-rampant-arsenal"
                                                }
                                        }
                                }
                        }
                }
    })


    local toxicCloud = makeCloud(
        {
            name = "toxic",
            duration = 1200,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.5,g=0,b=0.5,a=0.4},
            scale = 1.5
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 9,
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    {
                                                        type = "damage",
                                                        damage = { amount = 300, type = "poison" }
                                                    },
                                                    {
                                                        type = "create-sticker",
                                                        sticker = "toxic-sticker-rampant-arsenal"
                                                    }
                                                }
                                        }
                                }
                        }
                }
    })

    local paralysisCloud = makeCloud(
        {
            name = "paralysis",
            duration = 560,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0,g=0,b=0.8,a=0.4},
            scale = 1
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 6.5,
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "create-sticker",
                                                    sticker = "paralysis-sticker-rampant-arsenal"
                                                }
                                        }
                                }
                        }
                }
    })

    local repairCloud = makeCloud(
        {
            name = "repair",
            duration = 1200,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.5,g=0.3,b=0,a=0.4},
            scale = 1.5
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 9,
                                    entity_flags = {"player-creation"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = { amount = -80, type = "healing" }
                                                }
                                        }
                                }
                        }
                }
    })

    local healingCloud = makeCloud(
        {
            name = "healing",
            duration = 800,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.8,g=0,b=0,a=0.4},
            scale = 2
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 12,
                                    force = "ally",
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = { amount = -80, type = "healing" }
                                                }
                                        }
                                }
                        }
                }
    })

    data:extend({
            {
                type = "simple-entity-with-force",
                name = "dummy-small-repair-cloud-rampant-arsenal",
                render_layer = "object",
                icon = "__base__/graphics/icons/steel-chest.png",
                icon_size = 64, icon_mipmaps = 4,
                flags = {"placeable-neutral", "player-creation"},
                order = "s-e-w-f",
                minable = {mining_time = 0.1, result = "simple-entity-with-force"},
                max_health = 100,
                corpse = "small-remnants",
                collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
                selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                picture =
                    {
                        filename = "__core__/graphics/empty.png",
                        priority = "low",
                        width = 1,
                        height = 1
                    }
            }
    })

    makeCloud(
        {
            name = "small-toxic",
            duration = 800,
            inDuration = 45,
            outDuration = 30,
            movementModifier = 0,
            spreadRadius = 2,
            tint = {r=0.5,g=0,b=0.5,a=0.4},
            scale = 0.75
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 4.5,
                                    entity_flags = {"breaths-air"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    {
                                                        type = "damage",
                                                        damage = { amount = 300, type = "poison" }
                                                    },
                                                    {
                                                        type = "create-sticker",
                                                        sticker = "small-toxic-sticker-rampant-arsenal"
                                                    }
                                                }
                                        }
                                }
                        }
                }
    })

    local smallRepairCloud = makeCloud(
        {
            name = "small-repair",
            duration = 3000,
            skipSubEntity = true,
            inDuration = 10,
            outDuration = 10,
            movementModifier = 0,
            cooldown = 125,
            spreadRadius = 2,
            tint = {r=0.3,g=0.1,b=0,a=0.01},
            scale = 0.5
        },
        {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    target_effects =
                        {
                            type = "nested-result",
                            action =
                                {
                                    type = "area",
                                    radius = 4,
                                    entity_flags = {"player-creation"},
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = { amount = -6, type = "healing" }
                                                }
                                        }
                                }
                        }
                }
    })
end

return clouds
