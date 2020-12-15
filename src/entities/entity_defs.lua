--[[
    The definitions for various entities using in Forgotten Tales

    Author: Krishna S Pillai 
]]

ENTITY_DEFS = {
    ['Hassle'] = {
        portrait = 2,
        animations = {
            ['walk-left'] = {
                frames = {4, 6},
                interval = 0.5,
                texture = 'mainCharacter'
            },
            ['walk-right'] = {
                frames = {7, 9},
                interval = 0.5,
                texture = 'mainCharacter'
            },
            ['walk-down'] = {
                frames = {1, 3},
                interval = 0.5,
                texture = 'mainCharacter'
            },
            ['walk-up'] = {
                frames = {10, 12},
                interval = 0.5,
                texture = 'mainCharacter'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'mainCharacter'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'mainCharacter'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'mainCharacter'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'mainCharacter'
            },
        },
        battleAnimations = {
            ['idle'] = {
                frames = {39, 40, 41, 42},
                interval = 0.2,
                texture = 'swordsmanBattle',
                looping = true
            },
            ['run'] = {
                frames = {9, 10, 11, 12, 13, 14},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = true
            },
            ['attack'] = {
                frames = {43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = false
            },
            ['critical'] = {
                frames = {95, 96, 97, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 98, 99, 100, 
                          101, 102, 103, 104, 105, 106, 107, 108, 109, 109},
                interval = 0.15,
                texture = 'swordsmanBattle',
                looping = false
            },
            ['spell'] = {
                frames = {86, 87, 88, 89, 90, 91, 92, 93, 94},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = false
            },
            ['hit'] = {
                frames = {60, 61, 62, 63, 64},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = false
            },
            ['death'] = {
                frames = {64, 65, 66, 67, 68, 69},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = false
            },
            ['retreat'] = {
                frames = {15, 16, 17, 18, 19, 20, 21, 22, 23, 24},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = false
            },
            ['dodge'] = {
                frames = {5, 6, 7, 8},
                interval = 0.1,
                texture = 'swordsmanBattle',
                looping = false
            }
        }
    },
    ["Gobo"] = {
        portrait = 4,
        animations = {
            ['walk-left'] = {
                frames = {4, 6},
                interval = 0.5,
                texture = 'gobo'
            },
            ['walk-right'] = {
                frames = {7, 9},
                interval = 0.5,
                texture = 'gobo'
            },
            ['walk-down'] = {
                frames = {1, 3},
                interval = 0.5,
                texture = 'gobo'
            },
            ['walk-up'] = {
                frames = {10, 12},
                interval = 0.5,
                texture = 'gobo'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'gobo'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'gobo'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'gobo'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'gobo'
            },
        }
    },
    ["GoboGreen"] = {
        scaleX = 0.8,
        scaleY = 0.8,
        dX = -14,
        dY = -14,
        portrait = 4,
        animations = {
            ['walk-left'] = {
                frames = {34, 35, 36, 37, 38, 39},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['walk-right'] = {
                frames = {12, 13, 14, 15, 16, 17},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4, 5, 6},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['walk-up'] = {
                frames = {23, 24, 25, 26, 27, 28},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['idle-left'] = {
                frames = {40},
                texture = 'goboGreen'
            },
            ['idle-right'] = {
                frames = {18},
                texture = 'goboGreen'
            },
            ['idle-down'] = {
                frames = {7},
                texture = 'goboGreen'
            },
            ['idle-up'] = {
                frames = {29},
                texture = 'goboGreen'
            },
            ['death'] = {
                frames = {45, 46, 47, 48, 49},
                interval = 0.1,
                texture = 'goboGreen',
                looping = false
            }
        },
        battleDX = -60,
        battleDY = -62,
        retreatDX = 150,
        battleAnimations = {
            ['idle'] = {
                frames = {1, 2, 3, 4},
                interval = 0.25,
                texture = 'goboIdle',
                looping = true
            },
            ['run'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'goboRun',
                looping = true
            },
            ['attack'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.1,
                texture = 'goboAttack',
                looping = false
            },
            ['critical'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'goboCritical',
                looping = false
            },
            ['dodge'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'goboCritical',
                looping = false
            },
            ['hit'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'goboTakeHit',
                looping = false
            },
            ['death'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'goboDeath',
                looping = false
            },
            ['retreat'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'goboRun',
                looping = true
            }
        }
    },
    ["GoboRed"] = {
        scaleX = 0.8,
        scaleY = 0.8,
        dX = -14,
        dY = -14,
        tintColor = {207/255, 114/255, 114/255, 255/255},
        portrait = 7,
        animations = {
            ['walk-left'] = {
                frames = {34, 35, 36, 37, 38, 39},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['walk-right'] = {
                frames = {12, 13, 14, 15, 16, 17},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['walk-down'] = {
                frames = {1, 2, 3, 4, 5, 6},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['walk-up'] = {
                frames = {23, 24, 25, 26, 27, 28},
                interval = 0.1,
                texture = 'goboGreen'
            },
            ['idle-left'] = {
                frames = {40},
                texture = 'goboGreen'
            },
            ['idle-right'] = {
                frames = {18},
                texture = 'goboGreen'
            },
            ['idle-down'] = {
                frames = {7},
                texture = 'goboGreen'
            },
            ['idle-up'] = {
                frames = {29},
                texture = 'goboGreen'
            },
            ['death'] = {
                frames = {45, 46, 47, 48, 49},
                interval = 0.1,
                texture = 'goboGreen',
                looping = false
            }
        },
        battleDX = -60,
        battleDY = -62,
        retreatDX = 150,
        battleAnimations = {
            ['idle'] = {
                frames = {1, 2, 3, 4},
                interval = 0.25,
                texture = 'goboIdle',
                looping = true
            },
            ['run'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'goboRun',
                looping = true
            },
            ['attack'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.1,
                texture = 'goboAttack',
                looping = false
            },
            ['critical'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'goboCritical',
                looping = false
            },
            ['dodge'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'goboCritical',
                looping = false
            },
            ['hit'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'goboTakeHit',
                looping = false
            },
            ['death'] = {
                frames = {1, 2, 3, 4},
                interval = 0.2,
                texture = 'goboDeath',
                looping = false
            },
            ['retreat'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'goboRun',
                looping = true
            }
        }
    },
    ["Skelebro"] = {
        scaleX = 1,
        scaleY = 1,
        dX = 0,
        dY = 0,
        portrait = 6,
        animations = {
            ['walk-left'] = {
                frames = {4, 5, 6},
                interval = 0.1,
                texture = 'skelebro',
                looping = true
            },
            ['walk-right'] = {
                frames = {7, 8, 9},
                interval = 0.1,
                texture = 'skelebro'
            },
            ['walk-down'] = {
                frames = {1, 2, 3},
                interval = 0.1,
                texture = 'skelebro'
            },
            ['walk-up'] = {
                frames = {10, 11, 12},
                interval = 0.1,
                texture = 'skelebro'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'skelebro'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'skelebro'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'skelebro'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'skelebro'
            },
            ['death'] = {
                frames = {2, 8, 11},
                interval = 0.2,
                texture = 'skelebro',
                looping = false,
                tintColor = {143/255, 143/255, 143/255, 255/255}
            }
        },
        battleDX = 8,
        battleDY = 2,
        retreatDX = 0,
        battleAnimations = {
            ['idle'] = {
                frames = generateTable(11),
                interval = 0.2,
                texture = 'skelebroIdle',
                looping = true
            },
            ['run'] = {
                frames = generateTable(13),
                interval = 0.1,
                texture = 'skelebroWalk',
                looping = true
            },
            ['attack'] = {
                frames = generateTable(18),
                interval = 0.2,
                texture = 'skelebroAttack',
                looping = false,
                dY = -3
            },
            ['critical'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 
                          1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
                interval = 0.2,
                texture = 'skelebroAttack',
                looping = false,
                dY = -3
            },
            ['dodge'] = {
                frames = generateTable(11),
                interval = 0.2,
                texture = 'skelebroIdle',
                looping = false
            },
            ['hit'] = {
                frames = generateTable(8),
                interval = 0.2,
                texture = 'skelebroHit',
                looping = false
            },
            ['death'] = {
                frames = generateTable(15),
                interval = 0.2,
                texture = 'skelebroDead',
                looping = false
            },
            ['retreat'] = {
                frames =  generateTable(13),
                interval = 0.2,
                texture = 'skelebroWalk',
                looping = true
            }
        }
    },
    ["DarkWizard"] = {
        scaleX = 1,
        scaleY = 1,
        dX = 0,
        dY = 0,
        portrait = 8,
        animations = {
            ['walk-left'] = {
                frames = {4, 5, 6},
                interval = 0.1,
                texture = 'darkWizard',
                looping = true
            },
            ['walk-right'] = {
                frames = {7, 8, 9},
                interval = 0.1,
                texture = 'darkWizard'
            },
            ['walk-down'] = {
                frames = {1, 2, 3},
                interval = 0.1,
                texture = 'darkWizard'
            },
            ['walk-up'] = {
                frames = {10, 11, 12},
                interval = 0.1,
                texture = 'darkWizard'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'darkWizard'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'darkWizard'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'darkWizard'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'darkWizard'
            },
            ['death'] = {
                frames = {2, 8, 11},
                interval = 0.2,
                texture = 'darkWizard',
                looping = false,
                tintColor = {143/255, 143/255, 143/255, 255/255}
            }
        },
        battleDX = -105,
        battleDY = -130,
        retreatDX = 250,
        battleRunDistance = 3,
        battleAnimations = {
            ['idle'] = {
                frames = generateTable(8),
                interval = 0.2,
                texture = 'darkWizardIdle',
                looping = true
            },
            ['run'] = {
                frames = generateTable(8),
                interval = 0.1,
                texture = 'darkWizardRun',
                looping = true
            },
            ['attack'] = {
                frames = generateTable(8),
                interval = 0.2,
                texture = 'darkWizardAttack',
                looping = false
            },
            ['spell'] = {
                frames = generateTable(8),
                interval = 0.2,
                texture = 'darkWizardAttack2',
                looping = false
            },
            ['critical'] = {
                frames = {1, 2, 3, 4, 5, 6, 7, 8, 
                          1, 2, 3, 4, 5, 6, 7, 8},
                interval = 0.2,
                texture = 'darkWizardAttack',
                looping = false
            },
            ['dodge'] = {
                frames = generateTable(2),
                interval = 0.2,
                texture = 'darkWizardFall',
                looping = false
            },
            ['hit'] = {
                frames = generateTable(3),
                interval = 0.2,
                texture = 'darkWizardHit',
                looping = false
            },
            ['death'] = {
                frames = generateTable(7),
                interval = 0.2,
                texture = 'darkWizardDeath',
                looping = false
            },
            ['retreat'] = {
                frames =  generateTable(8),
                interval = 0.2,
                texture = 'darkWizardRun',
                looping = true
            }
        }
    },
    ["PuppetOfGolestandt"] = {
        scaleX = 1,
        scaleY = 1,
        dX = 0,
        dY = 0,
        portrait = 3,
        footstepSounds = false,
        animations = {
            ['walk-left'] = {
                frames = {4, 5, 6},
                interval = 0.1,
                texture = 'puppetOfGolestandt',
                looping = true
            },
            ['walk-right'] = {
                frames = {7, 8, 9},
                interval = 0.1,
                texture = 'puppetOfGolestandt'
            },
            ['walk-down'] = {
                frames = {1, 2, 3},
                interval = 0.1,
                texture = 'puppetOfGolestandt'
            },
            ['walk-up'] = {
                frames = {10, 11, 12},
                interval = 0.1,
                texture = 'puppetOfGolestandt'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'puppetOfGolestandt'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'puppetOfGolestandt'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'puppetOfGolestandt'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'puppetOfGolestandt'
            },
            ['death'] = {
                frames = {2, 8, 11},
                interval = 0.2,
                texture = 'puppetOfGolestandt',
                looping = false,
                tintColor = {143/255, 143/255, 143/255, 255/255}
            }
        },
        battleDX = -25,
        battleDY = -25,
        retreatDX = 100,
        battleRunDistance = 4,
        battleAnimations = {
            ['idle'] = {
                frames = generateTable(4),
                interval = 0.2,
                texture = 'puppetOfGolestandtIdle',
                looping = true
            },
            ['run'] = {
                frames = generateTable(8),
                interval = 0.1,
                texture = 'puppetOfGolestandtIdle2',
                looping = true
            },
            ['attack'] = {
                frames = generateTable(6),
                interval = 0.2,
                texture = 'puppetOfGolestandtAttack',
                looping = false
            },
            ['spell'] = {
                frames = generateTable(12),
                interval = 0.2,
                texture = 'puppetOfGolestandtSkill',
                looping = false
            },
            ['summon'] = {
                frames = generateTable(5),
                interval = 0.2,
                texture = 'puppetOfGolestandtSummon',
                looping = false
            },
            ['critical'] = {
                frames = generateTable(13),
                interval = 0.2,
                texture = 'puppetOfGolestandtAttack',
                looping = false
            },
            ['dodge'] = {
                frames = {5, 6, 7, 8, 9, 10, 11, 5},
                interval = 0.2,
                texture = 'puppetOfGolestandtSkill',
                looping = false
            },
            ['hit'] = {
                frames = {5, 6, 7, 2},
                interval = 0.2,
                texture = 'puppetOfGolestandtAttack',
                looping = false
            },
            ['death'] = {
                frames = generateTable(20),
                interval = 0.2,
                texture = 'puppetOfGolestandtDeath',
                looping = false
            },
            ['retreat'] = {
                frames =  generateTable(8),
                interval = 0.2,
                texture = 'puppetOfGolestandtIdle2',
                looping = true
            }
        }
    },
    ["TearOfGolestandt"] = {
        scaleX = 0.5,
        scaleY = 0.5,
        dX = 8,
        dY = 8,
        portrait = 5,
        footstepSounds = false,
        animations = {
            ['walk-left'] = {
                frames = {4, 5, 6},
                interval = 0.1,
                texture = 'tearOfGolestandt',
                looping = true
            },
            ['walk-right'] = {
                frames = {7, 8, 9},
                interval = 0.1,
                texture = 'tearOfGolestandt'
            },
            ['walk-down'] = {
                frames = {1, 2, 3},
                interval = 0.1,
                texture = 'tearOfGolestandt'
            },
            ['walk-up'] = {
                frames = {10, 11, 12},
                interval = 0.1,
                texture = 'tearOfGolestandt'
            },
            ['idle-left'] = {
                frames = {5},
                texture = 'tearOfGolestandt'
            },
            ['idle-right'] = {
                frames = {8},
                texture = 'tearOfGolestandt'
            },
            ['idle-down'] = {
                frames = {2},
                texture = 'tearOfGolestandt'
            },
            ['idle-up'] = {
                frames = {11},
                texture = 'tearOfGolestandt'
            },
            ['death'] = {
                frames = {6},
                texture = 'tearOfGolestandtDeath'
            }
        },
        battleDX = 0,
        battleDY = 0,
        retreatDX = 50,
        battleRunDistance = 4,
        battleAnimations = {
            ['appear'] = {
                frames = generateTable(6),
                interval = 0.1,
                texture = 'tearOfGolestandtAppear',
                looping = false
            },
            ['idle'] = {
                frames = generateTable(4),
                interval = 0.3,
                texture = 'tearOfGolestandtIdle',
                looping = true
            },
            ['run'] = {
                frames = generateTable(4),
                interval = 0.3,
                texture = 'tearOfGolestandtIdle',
                looping = true
            },
            ['attack'] = {
                frames = {1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4},
                interval = 0.1,
                texture = 'tearOfGolestandtIdle',
                looping = false
            },
            ['spell'] = {
                frames = {1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4},
                interval = 0.1,
                texture = 'tearOfGolestandtIdle',
                looping = false
            },
            ['critical'] = {
                frames = {1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4},
                interval = 0.05,
                texture = 'tearOfGolestandtIdle',
                looping = false
            },
            ['dodge'] = {
                frames = generateTable(4),
                interval = 0.1,
                texture = 'tearOfGolestandtIdle',
                looping = false
            },
            ['hit'] = {
                frames = generateTable(4),
                interval = 0.5,
                texture = 'tearOfGolestandtIdle',
                looping = false
            },
            ['death'] = {
                frames = generateTable(6),
                interval = 0.2,
                texture = 'tearOfGolestandtDeath',
                looping = false
            },
            ['retreat'] = {
                frames =  generateTable(4),
                interval = 0.3,
                texture = 'tearOfGolestandtIdle',
                looping = true
            },
            ['unSummoned'] = {
                frames =  {6},
                texture = 'tearOfGolestandtDeath'
            }
        }
    }
}