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


data:extend({

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableEquipment",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableVehicle",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableAmmoTypes",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableRifleTurret",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        -- {
        --     type = "bool-setting",
        --     name = "rampant-arsenal-enablePowerArmorMK3",
        --     setting_type = 'startup',
        --     default_value = true,
        --     order = "a[projectile]-a[collide]",
        --     per_user = false
        -- },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableNuclearGeneratorEquipmentConsuming",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-hideVanillaDamageTechnologies",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-useInfiniteTechnologies",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        }

})
