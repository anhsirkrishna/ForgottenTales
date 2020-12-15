--[[
    Dialogue state for Forgotten Tales

    Author: Krishna S Pillai (krishna_sp@outlook.com)
]]

DialogueState = Class{__includes = BaseState}

function DialogueState:init(level, character, dialogue)
    self.level = level
    self.character = character
    self.currentDialogue = nil
    self.dialogueBoxes = {}
    self.speakers = {}
    self.dialoguedefs = DIALOGUE_DEFS[dialogue]
    local newDialogueBox = nil

    for i, speaker in pairs(self.dialoguedefs.characters) do
        if speaker == self.character.name then
            self.speakers[self.character.name]  = self.character
        else
            for i, enemy in pairs(self.level.enemyList) do
                if speaker == enemy.name then
                    self.speakers[enemy.name] = enemy
                end
            end
        end
    end
    for i, dialogue in pairs(self.dialoguedefs.dialogues) do
        for speaker, dialogueText in pairs(dialogue) do
            newDialogueBox = DialogueBox(self.speakers[speaker], dialogueText)
            newDialogueBox.visible = false
            table.insert(self.dialogueBoxes, newDialogueBox)
        end
    end

    self.currentDialogue = 1
    self.dialogueBoxes[self.currentDialogue].visible = true
end

function DialogueState:update(dt)
    if self.dialogueBoxes[self.currentDialogue].closed == true then
        self.dialogueBoxes[self.currentDialogue].visible = false
        self.currentDialogue = self.currentDialogue + 1
        if self.currentDialogue > #self.dialogueBoxes then
            gStateStack:pop()
            return
        end
        self.dialogueBoxes[self.currentDialogue].visible = true
    end
    self.dialogueBoxes[self.currentDialogue]:update(dt)
end

function DialogueState:render()
    self.dialogueBoxes[self.currentDialogue]:render(dt)
end
