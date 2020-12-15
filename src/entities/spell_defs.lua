--[[
    The definitions for spells
]]

SPELL_DEFS = {
    ['flare'] = {
        name = 'flare',
        cost = 1,
        dmg = 3,
        range = 3,
        description = "A burst of Lightning ",
        dmgDescription = "DMG : 3 | Enemy Atk Mod : -10",
        animation = {
            frames = generateTable(10),
            texture = 'flare',
            interval = 0.1,
            looping =  false
        },
        scaleX = 2,
        scaleY = 1,
        startX = 3 * TILE_SIZE + 8,
        startY = 4 * TILE_SIZE - 20,
        effect = {
            duration = 1,
            apply = 
                function(enemy)
                    table.insert(enemy.atkMod, -10)
                end,
            action = 
                function(enemy)
                end,
            remove =
                function(enemy)
                    table.insert(enemy.atkMod, 10)
                end
        }
    },
    ["boltStrike"] = {
        name = "boltStrike",
        cost = 2,
        dmg = 8,
        range = 6,
        description = "A powerful bolt of lightning",
        dmgDescription = "DMG : 8",
        animation = {
            frames = generateTable(10),
            texture = 'boltStrike',
            interval = 0.1,
            looping = false
        },
        scaleX = 1,
        scaleY = 1,
        startX = 6 * TILE_SIZE + 12,
        startY = 4 * TILE_SIZE - 26,
        effect = {
            duration = 0,
            apply = 
                function(enemy)
                end,
            action = 
                function(enemy)
                end,
            remove =
                function(enemy)
                end
        }
    },
    ["rokeshsClaw"] = {
        name = "rokeshsClaw",
        cost = 3,
        dmg = 6,
        range = 4,
        description = "Spikes that erupt from the earth and pierce the target.",
        dmgDescription = "DMG : 6 | MOV : 0 (1 Turn)",
        animation = {
            frames = generateTable(10),
            texture = 'rokeshsClaw',
            interval = 0.1,
            looping = false
        },
        scaleX = 1,
        scaleY = 1,
        startX = 6 * TILE_SIZE + 12,
        startY = 4 * TILE_SIZE - 26,
        effect = {
            duration = 2,
            apply = 
                function(enemy)
                    table.insert(enemy.moveSpeedMod, -10)
                end,
            action = 
                function(enemy)
                end,
            remove =
                function(enemy)
                    table.insert(enemy.moveSpeedMod, 10)
                end
        }
    },
    ["voidTrap"] = {
        name = "voidTrap",
        cost = 3,
        dmg = 6,
        range = 6,
        description = "An inescapable pull of dark power.",
        dmgDescription = "DMG : 6 | DEF : -3(2 Turns)",
        animation = {
            frames = {1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6, 7, 8},
            texture = 'voidTrap',
            interval = 0.2,
            looping = false
        },
        scaleX = 1,
        scaleY = 1,
        startX = 6 * TILE_SIZE + 12,
        startY = 4 * TILE_SIZE - 26,
        effect = {
            duration = 0,
            apply = 
                function(enemy)
                    table.insert(enemy.defMod, -3)
                end,
            action = 
                function(enemy)
                end,
            remove =
                function(enemy)
                    table.insert(enemy.defMod, 3)
                end
        }
    },
    ["bladeOfKallisto"] = {
        name = "bladeOfKallisto",
        cost = 4,
        dmg = 12,
        range = 8,
        description = "A beam of light called down from the sun",
        dmgDescription = "DMG : 12",
        animation = {
            frames = generateTable(10),
            texture = 'bladeOfKallisto',
            interval = 0.1,
            looping = false
        },
        scaleX = 1,
        scaleY = 1,
        startX = 6 * TILE_SIZE + 12,
        startY = 4 * TILE_SIZE - 26,
        effect = {
            duration = 0,
            apply = 
                function(enemy)
                end,
            action = 
                function(enemy)
                end,
            remove =
                function(enemy)
                end
        }
    }
}

