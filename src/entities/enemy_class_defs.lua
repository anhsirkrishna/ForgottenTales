--[[
    Definitions for the different enemy classes
]]

ENEMY_CLASS_DEFS = {
    ["GoboGreen"] = {
        baseHp = 6,
        spellPoints = 1,
        baseMoveSpeed = 3,
        atk = 2,
        spell = 3,
        def = 1,
        res = 0,
        atkRange = 1,
        defaultWeapon = 'dagger',
        spells = {}
    },
    ["GoboBoss"] = {
        baseHp = 15,
        spellPoints = 1,
        baseMoveSpeed = 5,
        atk = 6,
        spell = 3,
        def = 4,
        res = 0,
        atkRange = 1,
        defaultWeapon = 'dagger',
        spells = {}
    },
    ["Skelebro"] = {
        baseHp = 4,
        spellPoints = 1,
        baseMoveSpeed = 5,
        atk = 12,
        spell = 3,
        def = 1,
        res = 0,
        atkRange = 1,
        defaultWeapon = 'sword',
        spells = {}
    },
    ["DarkWizard"] = {
        baseHp = 16,
        spellPoints = 6,
        baseMoveSpeed = 4,
        atk = 2,
        spell = 12,
        def = 4,
        res = 10,
        atkRange = 3,
        defaultWeapon = 'darkStaff',
        spells = {'bladeOfKallisto', 'rokeshsClaw'}
    },
    ["PuppetOfGolestandt"] = {
        baseHp = 30,
        spellPoints = 6,
        baseMoveSpeed = 0,
        atk = 12,
        spell = 12,
        def = 2,
        res = 8,
        atkRange = 1,
        defaultWeapon = 'deathsJudgement',
        spells = {'voidTrap'},
        summons = {
            {
                name = 'DarkTear',
                class = 'TearOfGolestandt',
                entity = 'TearOfGolestandt',
                loot = nil,
                cost = 2
            }
        }
    },
    ["TearOfGolestandt"] = {
        baseHp = 2,
        spellPoints = 1,
        baseMoveSpeed = 3,
        atk = 2,
        spell = 0,
        def = 0,
        res = 0,
        atkRange = 1,
        defaultWeapon = 'tearDrop',
        spells = {}
    },
}