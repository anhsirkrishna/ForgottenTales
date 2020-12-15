--
-- libraries
--

Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Util'
require 'src/constants'
require 'src/Animation'
require 'src/StateMachine'
require 'src/Queue'

require 'src/gui/Panel'
require 'src/gui/Button'
require 'src/gui/MenuPanel'
require 'src/gui/HighlightedTile'
require 'src/gui/TextPanel'
require 'src/gui/d20Roller'
require 'src/gui/Portrait'
require 'src/gui/WoodPanel'
require 'src/gui/Sheet'
require 'src/gui/StoneSheet'
require 'src/gui/HealthBar'
require 'src/gui/BattleDisplay'
require 'src/gui/ItemSlot'
require 'src/gui/Popup'
require 'src/gui/SpellSlot'
require 'src/gui/DialogueBox'
require 'src/gui/character/CharSelectMenu'
require 'src/gui/character/MapTileSelector'
require 'src/gui/character/CharStats'
require 'src/gui/character/SpellList'

require 'src/states/BaseState'
require 'src/states/StateStack'

require 'src/states/entity/EntityBaseState'
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityBattleState'
require 'src/states/entity/EntityDeathState'

require 'src/states/game/FadeState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/CharSelectState'
require 'src/states/game/CharMoveState'
require 'src/states/game/CharActionState'
require 'src/states/game/CharAttackState'
require 'src/states/game/CharInteractState'
require 'src/states/game/CharStatsState'
require 'src/states/game/BattleState'
require 'src/states/game/RollState'
require 'src/states/game/CombatState'
require 'src/states/game/EnemyAttackState'
require 'src/states/game/EnemyMoveState'
require 'src/states/game/EnemySpellState'
require 'src/states/game/GameOverState'
require 'src/states/game/CharSpellState'
require 'src/states/game/EnemySummonState'
require 'src/states/game/SummonState'
require 'src/states/game/WinningState'
require 'src/states/game/DialogueState'
require 'src/states/game/dialogue_defs'

require 'src/entities/Camera'
require 'src/entities/spell_defs'
require 'src/entities/item_defs'
require 'src/entities/char_class_defs'
require 'src/entities/entity_defs'
require 'src/entities/Entity'
require 'src/entities/Character'
require 'src/entities/enemy_class_defs'
require 'src/entities/Enemy'

require 'src/world/Level'
require 'src/world/level_defs'
require 'src/world/battle_terrain_defs'
require 'src/world/BattleTerrain'

gTextures = {
    --RPG Nature tileset from https://stealthix.itch.io/
    ['tiles'] = love.graphics.newImage('graphics/RPG Nature Tileset.png'),
    --Background from https://edermunizz.itch.io/
    ['background'] = love.graphics.newImage('graphics/Background.png'),
    --Character sprites from https://pipoya.itch.io/
    ['mainCharacter'] = love.graphics.newImage('graphics/Male 01-1.png'),
    ['gobo'] = love.graphics.newImage('graphics/Enemy 13-1.png'),
    ['skelebro'] = love.graphics.newImage('graphics/enemies/skelebro/Enemy 06-1.png'),
    ['darkWizard'] = love.graphics.newImage('graphics/enemies/dark-wizard/Enemy 02-1.png'),
    ['puppetOfGolestandt'] = love.graphics.newImage('graphics/enemies/death-reaper/Enemy 15-1.png'),
    ['tearOfGolestandt'] = love.graphics.newImage('graphics/enemies/death-reaper/Enemy 17-2.png'),
    --GUI elements from https://mounirtohami.itch.io/
    ['GUI'] = love.graphics.newImage('graphics/GUI.png'),
    --Panels from https://karwisch.itch.io/
    ['PanelRed'] = love.graphics.newImage('graphics/panel_Example2.png'),
    ['PanelBlue'] = love.graphics.newImage('graphics/panel_Example4.png'),
    --Character animated sheet from https://rvros.itch.io/animated-pixel-hero
    ['swordsmanBattle'] = love.graphics.newImage('graphics/adventurer-v1.5-Sheet.png'),
    --Battle terrain Tileset from https://alisdaiross.itch.io/
    ['battleTerrainTiles'] = love.graphics.newImage('graphics/wooden_tile_set_006.png'),
    --Goblin tileset from https://opengameart.org/content/lpc-goblin
    ['goboGreen'] = love.graphics.newImage('graphics/goblinsword.png'),
    -- Goblin animated sheet from https://luizmelo.itch.io
    ['goboAttack'] = love.graphics.newImage('graphics/GoblinAttack.png'),
    ['goboIdle'] = love.graphics.newImage('graphics/GoblinIdle.png'),
    ['goboRun'] = love.graphics.newImage('graphics/GoblinRun.png'),
    ['goboTakeHit'] = love.graphics.newImage('graphics/GoblinTake Hit.png'),
    ['goboDeath'] = love.graphics.newImage('graphics/GoblinDeath.png'),
    ['goboCritical'] = love.graphics.newImage('graphics/GoblinCritical.png'),
    -- D20 Animated textures from https://opengameart.org/content/d20-rolling-animations
    ['d20Roll'] = GetD20Textures(),
    -- Icons from https://cheekyinkling.itch.io/shikashis-fantasy-icons-pack
    ['icons'] = love.graphics.newImage('graphics/#2 - Transparent Icons & Drop Shadow.png'),
    ['iconsBg'] = love.graphics.newImage('graphics/Background 5.png'),
    -- Health bar assets from https://adwitr.itch.io/pixel-health-bar-asset-pack
    ['healthBar'] = love.graphics.newImage('graphics/RPG Style (1).png'),
    ['spellBar'] = love.graphics.newImage('graphics/RPG Style (2).png'),
    -- Portraits from https://free-game-assets.itch.io/free-fantasy-avatar-icons-pixel-art
    ['portraits'] = GeneratePortraitTextures(),
    --Spell icons and animations from https://free-game-assets.itch.io/pixel-art-magic-sprite-sheet-effects
    ['spells'] = {}, 
    ['spellicons'] = {
        ['flare'] = love.graphics.newImage('graphics/spells/icons/1-Lightning.png'),
        ['boltStrike'] = love.graphics.newImage('graphics/spells/icons/2-Lightning-bolt.png')
    },
    -- Skeleton animated sheet from https://jesse-m.itch.io/skeleton-pack
    ['skelebroAttack'] = love.graphics.newImage('graphics/enemies/skelebro/Skeleton Attack.png'),
    ['skelebroDead'] = love.graphics.newImage('graphics/enemies/skelebro/Skeleton Dead.png'),
    ['skelebroHit'] = love.graphics.newImage('graphics/enemies/skelebro/Skeleton Hit.png'),
    ['skelebroIdle'] = love.graphics.newImage('graphics/enemies/skelebro/Skeleton Idle.png'),
    ['skelebroReact'] = love.graphics.newImage('graphics/enemies/skelebro/Skeleton React.png'),
    ['skelebroWalk'] = love.graphics.newImage('graphics/enemies/skelebro/Skeleton Walk.png'),
    -- Dark wizard animated sheet from https://luizmelo.itch.io/
    ['darkWizardAttack'] = love.graphics.newImage('graphics/enemies/dark-wizard/Attack1.png'),
    ['darkWizardAttack2'] = love.graphics.newImage('graphics/enemies/dark-wizard/Attack2.png'),
    ['darkWizardDeath'] = love.graphics.newImage('graphics/enemies/dark-wizard/Death.png'),
    ['darkWizardFall'] = love.graphics.newImage('graphics/enemies/dark-wizard/Fall.png'),
    ['darkWizardIdle'] = love.graphics.newImage('graphics/enemies/dark-wizard/Idle.png'),
    ['darkWizardJump'] = love.graphics.newImage('graphics/enemies/dark-wizard/Jump.png'),
    ['darkWizardRun'] = love.graphics.newImage('graphics/enemies/dark-wizard/Run.png'),
    ['darkWizardHit'] = love.graphics.newImage('graphics/enemies/dark-wizard/Take hit.png'),
    -- Undead executioner animated sheet from https://darkpixel-kronovi.itch.io/undead-executioner
    ['puppetOfGolestandtAttack'] = love.graphics.newImage('graphics/enemies/death-reaper/attacking.png'),
    ['puppetOfGolestandtDeath'] = love.graphics.newImage('graphics/enemies/death-reaper/death.png'),
    ['puppetOfGolestandtIdle'] = love.graphics.newImage('graphics/enemies/death-reaper/idle.png'),
    ['puppetOfGolestandtIdle2'] = love.graphics.newImage('graphics/enemies/death-reaper/idle2.png'),
    ['puppetOfGolestandtSkill'] = love.graphics.newImage('graphics/enemies/death-reaper/skill1.png'),
    ['puppetOfGolestandtSummon'] = love.graphics.newImage('graphics/enemies/death-reaper/summon.png'),
    ['tearOfGolestandtAppear'] = love.graphics.newImage('graphics/enemies/death-reaper/summonAppear.png'),
    ['tearOfGolestandtIdle'] = love.graphics.newImage('graphics/enemies/death-reaper/summonIdle.png'),
    ['tearOfGolestandtDeath'] = love.graphics.newImage('graphics/enemies/death-reaper/summonDeath.png'),
}   

gTextures['spells'] = {
    ['flare'] = love.graphics.newImage('graphics/spells/animations/Lightning.png'),
    ['boltStrike'] = love.graphics.newImage('graphics/spells/animations/Lightning-bolt.png'),
    ['rokeshsClaw'] = love.graphics.newImage('graphics/spells/animations/Spikes.png'),
    ['voidTrap'] = love.graphics.newImage('graphics/spells/animations/Black-hole.png'),
    ['bladeOfKallisto'] = love.graphics.newImage('graphics/spells/animations/Sun-strike.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 32, 32),
    ['mainCharacter'] = GenerateQuads(gTextures['mainCharacter'], 32, 32),
    ['GUI'] = {
        ['menuPanel']  = GenerateMenuPanelQuads(gTextures['GUI']),
        ['buttons']    = GenerateButtonQuads(gTextures['GUI']),
        ['woodPanel']  = GenerateWoodPanelQuads(gTextures['GUI']),
        ['sheet']      = GenerateSheetQuads(gTextures['GUI']),
        ['stoneSheet'] = GenerateStoneSheetQuads(gTextures['GUI']),
        ['popup']      = GeneratePopupQuads(gTextures['GUI'])
    },
    ['swordsmanBattle'] = GenerateQuads(gTextures['swordsmanBattle'], 50, 37),
    ['gobo'] = GenerateQuads(gTextures['gobo'], 32, 32),
    ['goboGreen'] = GenerateQuads(gTextures['goboGreen'], 64, 64),
    ['battleTerrainTiles'] = GenerateQuads(gTextures['battleTerrainTiles'], 32, 32),
    ['goboAttack'] = GenerateQuads(gTextures['goboAttack'], 150, 150),
    ['goboIdle'] = GenerateQuads(gTextures['goboIdle'], 150, 150),
    ['goboRun'] = GenerateQuads(gTextures['goboRun'], 150, 150),
    ['goboTakeHit'] = GenerateQuads(gTextures['goboTakeHit'], 150, 150),
    ['goboDeath'] = GenerateQuads(gTextures['goboDeath'], 150, 150),
    ['goboCritical'] = GenerateQuads(gTextures['goboCritical'], 150, 150),
    ['d20Roll'] = GetD20Quads(gTextures['d20Roll']),
    ['icons'] = GenerateQuads(gTextures['icons'], 32, 32),
    ['iconsBg'] = GenerateQuads(gTextures['iconsBg'], 32, 32),
    ['healthBar'] = GenerateHealthBarQuads(gTextures['healthBar']),
    ['spellBar'] = GenerateSpellBarQuads(gTextures['spellBar']),
    ['spells'] = {},
    ['skelebro'] = GenerateQuads(gTextures['skelebro'], 32, 32),
    ['skelebroAttack'] = GenerateQuads(gTextures['skelebroAttack'], 43, 37),
    ['skelebroDead'] = GenerateQuads(gTextures['skelebroDead'], 33, 32),
    ['skelebroHit'] = GenerateQuads(gTextures['skelebroHit'], 30, 32),
    ['skelebroIdle'] = GenerateQuads(gTextures['skelebroIdle'], 24, 32),
    ['skelebroReact'] = GenerateQuads(gTextures['skelebroReact'], 22, 32),
    ['skelebroWalk'] = GenerateQuads(gTextures['skelebroWalk'], 22, 33),
    ['darkWizard'] = GenerateQuads(gTextures['darkWizard'], 32, 32),
    ['darkWizardAttack'] = GenerateQuads(gTextures['darkWizardAttack'], 250, 250),
    ['darkWizardAttack2'] = GenerateQuads(gTextures['darkWizardAttack2'], 250, 250),
    ['darkWizardDeath'] = GenerateQuads(gTextures['darkWizardDeath'], 250, 250),
    ['darkWizardFall'] = GenerateQuads(gTextures['darkWizardFall'], 250, 250),
    ['darkWizardIdle'] = GenerateQuads(gTextures['darkWizardIdle'], 250, 250),
    ['darkWizardJump'] = GenerateQuads(gTextures['darkWizardJump'], 250, 250),
    ['darkWizardRun'] = GenerateQuads(gTextures['darkWizardRun'], 250, 250),
    ['darkWizardHit'] = GenerateQuads(gTextures['darkWizardHit'], 250, 250),
    ['puppetOfGolestandt'] = GenerateQuads(gTextures['puppetOfGolestandt'], 32, 32),
    ['puppetOfGolestandtAttack'] = GenerateQuads(gTextures['puppetOfGolestandtAttack'], 100, 100),
    ['puppetOfGolestandtDeath'] = GenerateQuads(gTextures['puppetOfGolestandtDeath'], 100, 100),
    ['puppetOfGolestandtIdle'] = GenerateQuads(gTextures['puppetOfGolestandtIdle'], 100, 100),
    ['puppetOfGolestandtIdle2'] = GenerateQuads(gTextures['puppetOfGolestandtIdle2'], 100, 100),
    ['puppetOfGolestandtSkill'] = GenerateQuads(gTextures['puppetOfGolestandtSkill'], 100, 100),
    ['puppetOfGolestandtSummon'] = GenerateQuads(gTextures['puppetOfGolestandtSummon'], 100, 100),
    ['tearOfGolestandt'] = GenerateQuads(gTextures['tearOfGolestandt'], 32, 32),
    ['tearOfGolestandtAppear'] = GenerateQuads(gTextures['tearOfGolestandtAppear'], 50, 50),
    ['tearOfGolestandtIdle'] = GenerateQuads(gTextures['tearOfGolestandtIdle'], 50, 50),
    ['tearOfGolestandtDeath'] = GenerateQuads(gTextures['tearOfGolestandtDeath'], 50, 50)
}

gFrames['spells'] = {
    ['flare'] = GenerateQuads(gTextures['spells']['flare'], 72, 72),
    ['boltStrike'] = GenerateQuads(gTextures['spells']['boltStrike'], 72, 72),
    ['rokeshsClaw'] = GenerateQuads(gTextures['spells']['rokeshsClaw'], 72, 72),
    ['voidTrap'] = GenerateQuads(gTextures['spells']['voidTrap'], 72, 72),
    ['bladeOfKallisto'] = GenerateQuads(gTextures['spells']['bladeOfKallisto'], 72, 72),
}

gSounds = {
    ['select-blip']   = love.audio.newSource('sounds/effects/select.wav', 'static'),
    --Menu sounds from https://noahkuehne.itch.io/menu-sounds
    ['menu-forward']  = love.audio.newSource('sounds/effects/Menu_Sound_Forward.wav', 'static'),
    ['menu-backward']  = love.audio.newSource('sounds/effects/Menu_Sound_Backward.wav', 'static'),
    ['error']  = love.audio.newSource('sounds/effects/Menu_Sound_Error.wav', 'static'),
    ['hover'] = love.audio.newSource('sounds/effects/Menu_Sound_Hover.wav', 'static'),
    --Retro effects from https://kronbits.itch.io/freesfx
    ['pickup'] = love.audio.newSource('sounds/effects/Retro PickUp 18.wav', 'static'),
    ['consume'] = love.audio.newSource('sounds/effects/Retro PowerUP StereoUP 05.wav', 'static'),
    ['equip'] = love.audio.newSource('sounds/effects/Retro Weapon Reload 03.wav', 'static'),
    ['footstep'] = love.audio.newSource('sounds/effects/Retro FootStep 03.wav', 'static'),
    ['footstep-grass'] = love.audio.newSource('sounds/effects/Retro FootStep Grass 01.wav', 'static'),
    ['hit'] = love.audio.newSource('sounds/effects/Retro Weapon Gun LoFi 03.wav', 'static'),
    ['swing1'] = love.audio.newSource('sounds/effects/Retro Swooosh 16.wav', 'static'),
    ['swing2'] = love.audio.newSource('sounds/effects/Retro Swooosh 02.wav', 'static'),
    ['miss'] = love.audio.newSource('sounds/effects/Retro Impact Punch Hurt 01.wav', 'static'),
    ['spells'] = {
        ['flare'] = love.audio.newSource('sounds/effects/Retro Missile Launcher 01.wav', 'static'),
        ['boltStrike'] = love.audio.newSource('sounds/effects/Retro Magic Electric 03.wav', 'static'),
        ['rokeshsClaw'] = love.audio.newSource('sounds/effects/Retro Explosion Short 15.wav', 'static'),
        ['voidTrap'] = love.audio.newSource('sounds/effects/Retro Electronic Burst StereoUP 04.wav', 'static'),
        ['bladeOfKallisto'] = love.audio.newSource('sounds/effects/Retro Explosion Swoshes 04.wav', 'static')
    },
    ['summon'] = love.audio.newSource('sounds/effects/Retro Crow 01.wav', 'static'),
}

gSounds['footstep-grass']:setLooping(true)

gMusic = {
    --Music from https://bakudas.itch.io/generic-rpg-pack
    ['explore-music'] = love.audio.newSource('sounds/music/Celestial.mp3', 'static'),
    ['battle-music']  = love.audio.newSource('sounds/music/The Arrival (BATTLE II).mp3', 'static'),
    --Additional music from https://richarrest.itch.io/classic-jrpg-music-pack-tiny-pack
    ['fight-music'] = love.audio.newSource('sounds/music/4_Battle_1_Master.mp3', 'static'),
    ['intro-music'] = love.audio.newSource('sounds/music/0_Menu_Master.mp3', 'static'),
    ['gameOver-music'] = love.audio.newSource('sounds/music/1_Dungeon_1_Master.mp3', 'static'),
    ['boss-music'] = love.audio.newSource('sounds/music/27 14 BOSS fixing LOOP.mp3', 'static'),
    ['win-music'] = love.audio.newSource('sounds/music/15 8 victory LOOP.mp3', 'static')
}

for i, sound in pairs(gMusic) do
    sound:setLooping(true)
    sound:setVolume(0.3)
end

gFonts = {
    ['smallFancy']  = love.graphics.newFont('fonts/ENDOR___.ttf', 16),
    ['mediumFancy'] = love.graphics.newFont('fonts/ENDOR___.ttf', 24),
    ['largeFancy']  = love.graphics.newFont('fonts/ENDOR___.ttf', 48),
    ['smallAlt']    = love.graphics.newFont('fonts/ENDORALT.ttf', 8),
    ['mediumAlt']   = love.graphics.newFont('fonts/ENDORALT.ttf', 16),
    ['largeAlt']    = love.graphics.newFont('fonts/ENDORALT.ttf', 32),
    ['smallNum']    = love.graphics.newFont('fonts/CompassPro.ttf', 16),
    ['mediumNum']   = love.graphics.newFont('fonts/CompassPro.ttf', 32),
    ['largeNum']    = love.graphics.newFont('fonts/CompassPro.ttf', 48),
    ['small']       = love.graphics.newFont('fonts/EquipmentPro.ttf', 16),
    ['medium']      = love.graphics.newFont('fonts/EquipmentPro.ttf', 24),
    ['large']       = love.graphics.newFont('fonts/EquipmentPro.ttf', 48),
    ['smallName']   = love.graphics.newFont('fonts/ExpressionPro.ttf', 16),
    ['mediumName']  = love.graphics.newFont('fonts/ExpressionPro.ttf', 24),
    ['largeName']   = love.graphics.newFont('fonts/ExpressionPro.ttf', 48),
    ['smallMain']   = love.graphics.newFont('fonts/FutilePro.ttf', 16),
    ['mediumMain']  = love.graphics.newFont('fonts/FutilePro.ttf', 24),
    ['largeMain']   = love.graphics.newFont('fonts/FutilePro.ttf', 48),
}
