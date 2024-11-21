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


local vehicles = {}

local sounds = require("__base__.prototypes.entity.sounds")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local vehicleUtils = require("utils/VehicleUtils")
local gridUtils = require("utils/GridUtils")
local gunUtils = require("utils/GunUtils")
local equipmentUtils = require("utils/EquipmentUtils")

local addCategory = equipmentUtils.addCategory
local makeGun = gunUtils.makeGun
local makeGrid = gridUtils.makeGrid
local addEquipmentGrid = vehicleUtils.addEquipmentGrid
local addAutomaticRobotDeploy = vehicleUtils.addAutomaticRobotDeploy
local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeTank = vehicleUtils.makeTank
local makeCar = vehicleUtils.makeCar
local makeTrain = vehicleUtils.makeTrain

function vehicles.enable()

    local advancedTankMachineGun = makeGun(
        {
            name = "advanced-tank-machine-gun",
            icon = "__RampantArsenal__/graphics/icons/minigun.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 3,
            movement_slow_down_factor = 0.7,
            damage_modifier = 2.5,
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
            projectile_center = {-0.15625, -0.07812},
            projectile_creation_distance = 3,
            range = 20,
            sound = sounds.heavy_gunshot
    })

    local advancedTankCannon = makeGun(
        {
            name = "advanced-tank-cannon",
            icon = "__base__/graphics/icons/tank-cannon.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "cannon-shell",
            cooldown = 90,
            damage_modifier = 1.5,
            movement_slow_down_factor = 0,
            projectile_creation_distance = 3,
            projectile_center = {-0.15625, -0.07812},
            range = 34,
            sound =
                {
                    {
                        filename = "__base__/sound/fight/tank-cannon.ogg",
                        volume = 1.0
                    }
                }
    })

    local advancedTankFlamethrower = makeGun(
        {
            name = "advanced-tank-flamethrower",
            icon = "__base__/graphics/icons/flamethrower.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "stream",
            ammo_category = "flamethrower",
            cooldown = 1,
            projectile_creation_distance = 1,
            gun_barrel_length = 2.75,
            damage_modifier = 1.5,
            gun_center_shift = { -0.17, -1.15 },
            range = 15,
            min_range = 3,
            cyclic_sound =
                {
                    begin_sound =
                        {
                            {
                                filename = "__base__/sound/fight/flamethrower-start.ogg",
                                volume = 1
                            }
                        },
                    middle_sound =
                        {
                            {
                                filename = "__base__/sound/fight/flamethrower-mid.ogg",
                                volume = 1
                            }
                        },
                    end_sound =
                        {
                            {
                                filename = "__base__/sound/fight/flamethrower-end.ogg",
                                volume = 1
                            }
                        }
                }
    })

    local advancedTankLauncher = makeGun(
        {
            name = "advanced-tank-launcher",
            icon = "__RampantArsenal__/graphics/icons/mortar.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "stream",
            ammo_category = "capsule-launcher",
            cooldown = 350,
            movement_slow_down_factor = 0.9,
            damage_modifier = 2.5,
            gun_center_shift = {
                north = {0, 0},
                east = {0, 0},
                south = {0, 0},
                west = {0, 0}
            },
            gun_barrel_length = 3,
            range = 45,
            sound = {
                {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.9
                }
            }
    })

    local advTankGrid

    if (mods.bobvehicleequipment) then
        advTankGrid = makeGrid({
                name = "advanced-tank",
                width = 15,
                height = 15,
                categories = {"armor", "armoured-vehicle", "vehicle", "tank"}
        })
    else
        advTankGrid = makeGrid({
                name = "advanced-tank",
                width = 15,
                height = 15
        })
    end

    local nuclearTankGrid

    if (mods.bobvehicleequipment) then
        nuclearTankGrid = makeGrid({
                name = "nuclear-tank",
                width = 18,
                height = 18,
                categories = {"armor", "armoured-vehicle", "vehicle", "adv-generator", "tank"}
        })
    else
        nuclearTankGrid = makeGrid({
                name = "nuclear-tank",
                width = 18,
                height = 18,
                categories = {"armor", "adv-generator"}
        })
    end

    local spidertronGrid = data.raw["equipment-grid"]["spidertron-equipment-grid"].equipment_categories

    spidertronGrid[#spidertronGrid+1] = "adv-generator"

    local advTank = makeTank({
            name = "advanced",
            scale = 0.8,
            order = "b[personal-transport]-b[zatank]",
            icon = "__RampantArsenal__/graphics/icons/advanced-tank.png",
            health = 4500,
            consumption = "4.0MW",
            weight = 30000,
            inventorySize = 100,
            collisionBox = {{-1.5, -2.5}, {1.2, 1.8}},
            selectionBox = {{-1.7, -2.7}, {1.4, 2}},
            --drawingBox = {{-3.4, -3.4}, {3.4, 2.8}},
            brakingPower = "3MW",
            equipmentGrid = advTankGrid,
            friction = 0.006,
            immuneToTrees = true,
            -- rotationSpeed = 0.0030,
            weapons = { advancedTankMachineGun, advancedTankCannon, advancedTankFlamethrower, advancedTankLauncher},
            tint = { r = 0.85, g = 0.75, b = 0.75, a = 1 },
            energySource = {
                type = "burner",
                fuel_categories = {"chemical"},
                effectivity = 0.85,
                emissions_per_minute = { pollution = 20 },
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
            },
            resistances = {
                {
                    type = "fire",
                    decrease = 20,
                    percent = 60
                },
                {
                    type = "laser",
                    decrease = 10,
                    percent = 50
                },
                {
                    type = "electric",
                    decrease = 10,
                    percent = 50
                },
                {
                    type = "physical",
                    decrease = 25,
                    percent = 70
                },
                {
                    type = "impact",
                    decrease = 50,
                    percent = 80
                },
                {
                    type = "explosion",
                    decrease = 25,
                    percent = 70
                },
                {
                    type = "acid",
                    decrease = 30,
                    percent = 65
                }
            }
    })

    local nuclearTankMachineGun = makeGun(
        {
            name = "nuclear-tank-machine-gun",
            icon = "__RampantArsenal__/graphics/icons/minigun.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 2.5,
            movement_slow_down_factor = 0.7,
            damage_modifier = 3,
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
            projectile_center = {-0.15625, -0.07812},
            projectile_creation_distance = 4,
            range = 21,
            sound = sounds.heavy_gunshot
    })

    local nuclearTankCannon = makeGun(
        {
            name = "nuclear-tank-cannon",
            icon = "__base__/graphics/icons/tank-cannon.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "cannon-shell",
            cooldown = 90,
            damage_modifier = 2,
            movement_slow_down_factor = 0,
            projectile_creation_distance = 4,
            projectile_center = {-0.15625, -0.07812},
            range = 34,
            sound =
                {
                    {
                        filename = "__base__/sound/fight/tank-cannon.ogg",
                        volume = 1.0
                    }
                }
    })

    local nuclearTankFlamethrower = makeGun(
        {
            name = "nuclear-tank-flamethrower",
            icon = "__base__/graphics/icons/flamethrower.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "stream",
            ammo_category = "flamethrower",
            cooldown = 1,
            projectile_creation_distance = 1,
            gun_barrel_length = 3.5,
            damage_modifier = 2,
            gun_center_shift = { -0.17, -1.15 },
            range = 20,
            min_range = 3,
            cyclic_sound =
                {
                    begin_sound =
                        {
                            {
                                filename = "__base__/sound/fight/flamethrower-start.ogg",
                                volume = 1
                            }
                        },
                    middle_sound =
                        {
                            {
                                filename = "__base__/sound/fight/flamethrower-mid.ogg",
                                volume = 1
                            }
                        },
                    end_sound =
                        {
                            {
                                filename = "__base__/sound/fight/flamethrower-end.ogg",
                                volume = 1
                            }
                        }
                }
    })

    local nuclearTankLauncher = makeGun(
        {
            name = "nuclear-tank-launcher",
            icon = "__RampantArsenal__/graphics/icons/mortar.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "stream",
            ammo_category = "capsule-launcher",
            cooldown = 350,
            movement_slow_down_factor = 0.9,
            damage_modifier = 2.7,
            gun_center_shift = {
                north = {0, 0},
                east = {0, 0},
                south = {0, 0},
                west = {0, 0}
            },
            gun_barrel_length = 4,
            range = 45,
            sound = {
                {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.9
                }
            }
    })

    local nuclearTankRocket = makeGun(
        {
            name = "nuclear-tank-rocket",
            icon = "__base__/graphics/icons/rocket-launcher.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "stream",
            ammo_category = "rocket",
            cooldown = 50,
            movement_slow_down_factor = 0.8,
            damage_modifier = 1.5,
            gun_center_shift = {
                north = {0, 0},
                east = {0, 0},
                south = {0, 0},
                west = {0, 0}
            },
            gun_barrel_length = 4.5,
            range = 40,
            sound = {
                {
                    filename = "__base__/sound/fight/rocket-launcher.ogg",
                    volume = 0.7
                }
            }
    })

    local nuclearTank = makeTank({
            name = "nuclear",
            scale = 1,
            order = "b[personal-transport]-b[zbtank]",
            icon = "__RampantArsenal__/graphics/icons/nuclear-tank.png",
            collisionBox = {{-1.5, -2.8}, {1.3, 2}},
            selectionBox = {{-1.9, -3.2}, {1.7, 2.4}},
            --drawingBox = {{-3.6, -3.6}, {3.4, 2.8}},
            drawingBoxVerticalExtension = 1,
            equipmentGrid = nuclearTankGrid,
            weapons = { nuclearTankMachineGun, nuclearTankCannon, nuclearTankFlamethrower, nuclearTankLauncher, nuclearTankRocket},
            immuneToTrees = true,
            health = 7500,
            brakingForce = "80KW",
            consumption = "75.0MW",
            weight = 40000,
            friction = 0.06,
            rotationSpeed = 0.0027,
            inventorySize = 180,
            tint = { r = 0.75, g = 0.85, b = 0.75, a = 1 },
            energySource = {
                type = "burner",
                fuel_categories = {"nuclear"},
                effectivity = 0.9,
                emissions_per_minute = { pollution = 30 },
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
            },
            resistances = {
                {
                    type = "fire",
                    decrease = 20,
                    percent = 70
                },
                {
                    type = "laser",
                    decrease = 15,
                    percent = 60
                },
                {
                    type = "electric",
                    decrease = 15,
                    percent = 60
                },
                {
                    type = "physical",
                    decrease = 25,
                    percent = 80
                },
                {
                    type = "impact",
                    decrease = 50,
                    percent = 90
                },
                {
                    type = "explosion",
                    decrease = 25,
                    percent = 80
                },
                {
                    type = "acid",
                    decrease = 30,
                    percent = 75
                }
            }
    })


    local advCarGrid

    if (mods.bobvehicleequipment) then
        advCarGrid = makeGrid({
                name = "advanced-car",
                width = 10,
                height = 10,
                categories = {"armor", "vehicle", "car"}
        })
    else
        advCarGrid = makeGrid({
                name = "advanced-car",
                width = 10,
                height = 10
        })
    end

    local nuclearCarGrid

    if (mods.bobvehicleequipment) then
        nuclearCarGrid = makeGrid({
                name = "nuclear-car",
                width = 13,
                height = 13,
                categories = {"armor", "vehicle", "adv-generator","car"}
        })
    else
        nuclearCarGrid = makeGrid({
                name = "nuclear-car",
                width = 13,
                height = 13,
                categories = {"armor", "adv-generator"}
        })
    end

    local advancedCarMachineGun = makeGun(
        {
            name = "advanced-car-machine-gun",
            icon = "__RampantArsenal__/graphics/icons/minigun.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 2.7,
            movement_slow_down_factor = 0.7,
            gun_barrel_length = 0.75,
            damage_modifier = 2,
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
            projectile_center = {-0.15625, -0.07812},
            projectile_creation_distance = 0.75,
            range = 20,
            sound = sounds.heavy_gunshot
    })

    local advancedCarShotgun = makeGun(
        {
            name = "advanced-car-shotgun",
            icon = "__base__/graphics/icons/combat-shotgun.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "shotgun-shell",
            cooldown = 30,
            movement_slow_down_factor = 0.5,
            damage_modifier = 2,
            projectile_creation_distance = 0.75,
            gun_barrel_length = 0.75,
            range = 22,
            sound =
                {
                    {
                        filename = "__base__/sound/pump-shotgun.ogg",
                        volume = 0.5
                    }
                }
    })

    local advCar = makeCar({
            name = "advanced",
            scale = 0.6,
            equipmentGrid = advCarGrid,
            order = "b[personal-transport]-a[zacar]",
            icon = "__RampantArsenal__/graphics/icons/advanced-car.png",
            immuneToTrees = true,
            health = 1200,
            friction = 0.02,
            weapons = {advancedCarMachineGun, advancedCarShotgun},
            effectivity = 0.80,
            brakingForce = "250MW",
            consumption = "2.0MW",
            weight = 1600,
            inventorySize = 130,
            energySource = {
                type = "burner",
                fuel_categories = {"chemical"},
                effectivity = 0.6,
                fuel_inventory_size = 1,
                emissions_per_minute = { pollution = 15 },
                smoke =
                    {
                        {
                            name = "car-smoke",
                            deviation = {0.25, 0.25},
                            frequency = 200,
                            position = {0, 1.5},
                            starting_frame = 0,
                            starting_frame_deviation = 60
                        }
                    }
            },
            collisionBox = {{-0.9, -1.2}, {0.9, 1.2}},
            selectionBox = {{-0.9, -1.2}, {0.9, 1.2}},
            tint = { r = 0.85, g = 0.75, b = 0.75, a = 1 },
            resistances = {
                {
                    type = "fire",
                    percent = 55
                },
                {
                    type = "impact",
                    percent = 30,
                    decrease = 60
                },
                {
                    type = "physical",
                    percent = 40,
                    decrease = 10
                },
                {
                    type = "acid",
                    percent = 20,
                    decrease = 10
                },
                {
                    type = "electric",
                    percent = 40,
                    decrease = 8
                },
                {
                    type = "laser",
                    percent = 40,
                    decrease = 8
                }
            }
    })

    local nuclearCarMachineGun = makeGun(
        {
            name = "nuclear-car-machine-gun",
            icon = "__RampantArsenal__/graphics/icons/minigun.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "bullet",
            cooldown = 2.5,
            movement_slow_down_factor = 0.7,
            damage_modifier = 2.5,
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
            projectile_center = {-0.15625, -0.07812},
            projectile_creation_distance = 0.75,
            gun_barrel_length = 0.75,
            range = 21,
            sound = sounds.heavy_gunshot
    })

    local nuclearCarShotgun = makeGun(
        {
            name = "nuclear-car-shotgun",
            icon = "__base__/graphics/icons/combat-shotgun.png",
            iconSize = 64, iconMipmaps = 4,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "projectile",
            ammo_category = "shotgun-shell",
            cooldown = 25,
            movement_slow_down_factor = 0.5,
            damage_modifier = 2.5,
            projectile_creation_distance = 0.75,
            gun_barrel_length = 0.75,
            range = 22,
            sound =
                {
                    {
                        filename = "__base__/sound/pump-shotgun.ogg",
                        volume = 0.5
                    }
                }
    })

    local nuclearCarLauncher = makeGun(
        {
            name = "nuclear-car-launcher",
            icon = "__RampantArsenal__/graphics/icons/mortar.png",
            iconSize = 64, iconMipmaps = 1,
            hidden = true,
            order = "e[mortar]-b"
        },
        {
            type = "stream",
            ammo_category = "capsule-launcher",
            cooldown = 350,
            movement_slow_down_factor = 0.9,
            damage_modifier = 2.5,
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

    local nuclearCar = makeCar({
            name = "nuclear",
            scale = 0.7,
            equipmentGrid = nuclearCarGrid,
            order = "b[personal-transport]-a[zbcar]",
            immuneToTrees = true,
            health = 2000,
            effectivity = 0.85,
            friction = 0.06,
            weapons = {nuclearCarMachineGun, nuclearCarShotgun, nuclearCarLauncher},
            brakingForce = "30MW",
            consumption = "20MW",
            weight = 2500,
            inventorySize = 200,
            icon = "__RampantArsenal__/graphics/icons/nuclear-car.png",
            collisionBox = {{-1.1, -1.4}, {1.1, 1.4}},
            selectionBox = {{-1.1, -1.4}, {1.1, 1.4}},
            tint = { r = 0.75, g = 0.85, b = 0.75, a = 1 },
            energySource = {
                type = "burner",
                fuel_categories = {"nuclear"},
                effectivity = 1,
                emissions_per_minute = { pollution = 20 },
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
            },
            resistances = {
                {
                    type = "fire",
                    percent = 60
                },
                {
                    type = "impact",
                    percent = 30,
                    decrease = 70
                },
                {
                    type = "physical",
                    percent = 40,
                    decrease = 15
                },
                {
                    type = "acid",
                    percent = 35,
                    decrease = 15
                },
                {
                    type = "electric",
                    percent = 40,
                    decrease = 16
                },
                {
                    type = "laser",
                    percent = 40,
                    decrease = 8
                }
            }
    })



    local nuclearTrainGrid

    if (mods.bobvehicleequipment) then
        nuclearTrainGrid = makeGrid({
                name = "nuclear-train",
                width = 16,
                height = 16,
                categories = {"noInventory", "train", "locomotive", "vehicle", "movement", "adv-generator"}
        })
    else
        nuclearTrainGrid = makeGrid({
                name = "nuclear-train",
                width = 16,
                height = 16,
                categories = {"noInventory", "movement", "adv-generator"}
        })
    end

    local nuclearTrain = makeTrain({
            name = "nuclear",
            scale = 0.5,
            order = "a[train-system]-f[zdiesel-locomotive]",
            icon = "__RampantArsenal__/graphics/icons/nuclear-locomotive.png",
            equipmentGrid = nuclearTrainGrid,
            health = 2400,
            brakingForce = 180,
            maxSpeed = 1.4,
            maxReverse = 0.7,
            maxPower = "16MW",
            weight = 60000,
            tint = { r = 0.70, g = 0.9, b = 0.70, a = 1 },
            energySource = {
                type = "burner",
                fuel_categories = {"nuclear"},
                effectivity = 0.16,
                fuel_inventory_size = 3,
                burnt_inventory_size = 3,
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

    makeRecipe({
            name = advTank,
            icon = "__RampantArsenal__/graphics/icons/advanced-tank.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="tank", amount=1},
                {type="item", name="plastic-bar", amount=100},
                {type="item", name="steel-plate", amount=150},
                {type="item", name="processing-unit", amount=30}
            },
            results = {{type="item", name=advTank, amount=1}}
    })

    makeRecipe({
            name = nuclearTank,
            icon = "__RampantArsenal__/graphics/icons/nuclear-tank.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name=advTank, amount=1},
                {type="item", name="nuclear-reactor", amount=1},
                {type="item", name="steel-plate", amount=200},
                {type="item", name="processing-unit", amount=50}
            },
            results = {{type="item", name=nuclearTank, amount=1}}
    })

    makeRecipe({
            name = advCar,
            icon = "__RampantArsenal__/graphics/icons/advanced-car.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="car", amount=1},
                {type="item", name="steel-plate", amount=30},
                {type="item", name="copper-plate", amount=40},
                {type="item", name="processing-unit", amount=25}
            },
            results = {{type="item", name=advCar, amount=1}}
    })

    makeRecipe({
            name = nuclearCar,
            icon = "__RampantArsenal__/graphics/icons/nuclear-car.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name=advCar, amount=1},
                {type="item", name="nuclear-reactor", amount=1},
                {type="item", name="steel-plate", amount=75},
                {type="item", name="processing-unit", amount=30}
            },
            results = {{type="item", name=nuclearCar, amount=1}}
    })

    makeRecipe({
            name = nuclearTrain,
            icon = "__RampantArsenal__/graphics/icons/nuclear-locomotive.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="locomotive", amount=1},
                {type="item", name="nuclear-reactor", amount=1},
                {type="item", name="steel-plate", amount=100},
                {type="item", name="processing-unit", amount=20}
            },
            results = {{type="item", name=nuclearTrain, amount=1}}
    })

    addEquipmentGrid("locomotive",
                     "locomotive",
                     makeGrid({
                             name = "locomotive",
                             width = 12,
                             height = 12,
                             categories = {"noInventory", "movement"}
    }))

    addEquipmentGrid("artillery-wagon",
                     "artillery-wagon",
                     makeGrid({
                             name = "artillery-wagon",
                             width = 16,
                             height = 16,
                             categories = {"noInventory"}
    }))

    addAutomaticRobotDeploy("cargo-wagon", "cargo-wagon")

    addEquipmentGrid("cargo-wagon",
                     "cargo-wagon",
                     makeGrid({
                             name = "cargo-wagon",
                             width = 8,
                             height = 8,
                             categories = {"immobile"}
    }))

    addEquipmentGrid("fluid-wagon",
                     "fluid-wagon",
                     makeGrid({
                             name = "fluid-wagon",
                             width = 8,
                             height = 8,
                             categories = {"noInventory"}
    }))

    addEquipmentGrid("car",
                     "car",
                     makeGrid({
                             name = "car",
                             width = 8,
                             height = 8
    }))

    addEquipmentGrid("car",
                     "tank",
                     makeGrid({
                             name = "tank",
                             width = 10,
                             height = 10
    }))

    addEffectToTech("rampant-arsenal-technology-tanks-2",
                    {
                        type = "unlock-recipe",
                        recipe = advTank
    })

    addEffectToTech("rampant-arsenal-technology-nuclear-tanks",
                    {
                        type = "unlock-recipe",
                        recipe = nuclearTank
    })


    addEffectToTech("rampant-arsenal-technology-cars-2",
                    {
                        type = "unlock-recipe",
                        recipe = advCar
    })

    addEffectToTech("rampant-arsenal-technology-nuclear-cars",
                    {
                        type = "unlock-recipe",
                        recipe = nuclearCar
    })

    addEffectToTech("rampant-arsenal-technology-nuclear-railway",
                    {
                        type = "unlock-recipe",
                        recipe = nuclearTrain
    })

    addCategory("night-vision-equipment", "immobile")
    addCategory("energy-shield-equipment", "immobile")
    addCategory("battery-equipment", "immobile")
    addCategory("solar-panel-equipment", "immobile")
    addCategory("generator-equipment", "immobile")
    addCategory("active-defense-equipment", "immobile")
    addCategory("roboport-equipment", "immobile")

    addCategory("night-vision-equipment", "noInventory")
    addCategory("energy-shield-equipment", "noInventory")
    addCategory("battery-equipment", "noInventory")
    addCategory("solar-panel-equipment", "noInventory")
    addCategory("generator-equipment", "noInventory")
    addCategory("active-defense-equipment", "noInventory")

    addCategory("movement-bonus-equipment", "movement")
end

return vehicles
