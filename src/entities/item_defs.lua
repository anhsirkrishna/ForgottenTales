--[[
    Definitions for various items
]]

WEAPON_DEFS = {
    ['sword'] = {
        name = 'sword',
        icon = 82,
        dmg = 4,
        description = "An average sword | 4 Dmg",
        specialProperties = nil,
        use = 
            function(character)
                character:equipWeapon('sword')
            end
    },
    ['staff'] = {
        name = 'staff',
        icon = 104,
        dmg = 3,
        description = "Grants the wielder +3 SPL",
        specialProperties = {
            add = 
                function(character)
                    table.insert(character.spellMod, 3)
                end,
            remove = 
                function(character)
                    table.insert(character.spellMod, -3)
                end
        }
    },
    ['darkStaff'] = {
        name = 'DarkStaff',
        icon = 106,
        dmg = 6,
        description = "Grants the wielder +4 SPL",
        specialProperties = {
                add = 
                    function(character)
                        table.insert(character.spellMod, 4)
                    end,
                remove = 
                    function(character)
                        table.insert(character.spellMod, -4)
                    end
            }
    },
    ['dagger'] = {
        name = 'dagger',
        icon = 88,
        dmg = 3,
        description = "A short and stubby blade",
        specialProperties = nil
    },
    ['longSword'] = {
        name = 'longSword',
        icon = 85,
        dmg = 6,
        description = "A longer than average sword | 6 Dmg +4 Atk",
        specialProperties = {
            add = 
                function(character)
                    table.insert(character.atkMod, 4)
                end,
            remove = 
                function(character)
                    table.insert(character.atkMod, -4)
                end
        },
        use = 
            function(character)
                character:equipWeapon('longSword')
            end
    },
    ['deathsJudgement'] = {
        name = 'deathsJudgement',
        icon = 282,
        dmg = 8,
        description = "The sycthe used to pass judgement on those who've died",
        specialProperties = {
            add = 
                function(character)
                    character:applyDebuff({
                        duration = 10,
                        apply = 
                            function(character)
                            end,
                        action = 
                            function(character)
                                character.currentSpellPoints = math.min(character.currentSpellPoints + 1, character.spellPoints)
                            end,
                        remove =
                            function(character)
                            end
                    })
                end,
            remove = 
                function(character)
                end
        },
        use = 
            function(character)
                character:equipWeapon('deathsJudgement')
            end
    },
    ['tearDrop'] = {
        name = 'tearDrop',
        icon = 3,
        dmg = 1,
        description = "...",
        specialProperties = nil
    },
}

ARMOUR_DEFS = {
    ['light'] = {
        name = 'light',
        icon = 122,
        hpAdd = 4,
        description = "Light vestements. +4 HP",
        specialProperties = nil,
        use = 
            function(character)
                character:equipArmour('light')
                character.baseHp = character.baseHp + 4
            end
    },
    ['medium'] = {
        name = 'medium',
        icon = 119,
        hpAdd = 4,
        description = "Sturdy Leather Armor. +4 HP | +4 DEF RES",
        specialProperties = {
            add = 
                function(character)
                    table.insert(character.defMod, 4)
                    table.insert(character.resMod, 4)
                end,
            remove = 
                function(character)
                    table.insert(character.defMod, -4)
                    table.insert(character.resMod, -4)
                end
        },
        use = 
            function(character)
                character:equipArmour('medium')
            end
        },
    ['heavy'] = {
        name = 'heavy',
        icon = 120,
        hpAdd = 6,
        description = "Plated Heavy Armor. +6 HP | +4 DEF",
        specialProperties = {
            add = 
                function(character)
                    table.insert(character.defMod, 4)
                end,
            remove = 
                function(character)
                    table.insert(character.defMod, -4)
                end
        },
        use = 
            function(character)
                character:equipArmour('heavy')
            end
        },
}

POTION_DEFS = {
    ['hpPotion'] = {
        name = 'hpPotion',
        icon = 145,
        description = "Use to restore 5 HP",
        use = 
            function(character)
                character.currentHp = math.min(character.currentHp + 5, character.baseHp)
                gSounds['consume']:play()
                character:removeItem('hpPotion')
            end
    },
    ['spPotion'] = {
        name = 'spPotion',
        icon = 146,
        description = "Use to restore 2 SP",
        use = 
            function(character)
                character.currentSpellPoints = math.min(character.currentSpellPoints + 2, character.spellPoints)
                gSounds['consume']:play()
                character:removeItem('spPotion')
            end
    },
    ['hpPotionLarge'] = {
        name = 'hpPotionLarge',
        icon = 157,
        description = "Use to restore 15 HP",
        use = 
            function(character)
                character.currentHp = math.min(character.currentHp + 15, character.baseHp)
                gSounds['consume']:play()
                character:removeItem('hpPotionLarge')
            end
    },
}
