--[[
    Animation class taken from GD50 and modified for use 

    -- Animation Class --

    Authors: Colton Ogden (cogden@cs50.harvard.edu)
             Krishna S Pillai (krishna_sp@outlook.com)
]]

Animation = Class{}

function Animation:init(def)
    self.frames = def.frames
    self.interval = def.interval
    self.texture = def.texture
    if def.dX ~= nil then
        self.dX = def.dX
    else
        self.dX = 0
    end
    if def.dY ~= nil then
        self.dY = def.dY
    else
        self.dY = 0
    end
    if def.looping == nil then
        self.looping = true
    else
        self.looping = def.looping
    end

    if def.tintColor ~= nil then
        self.tintColor = def.tintColor
    else
        self.tintColor = nil
    end

    self.timer = 0
    self.currentFrame = 1

    -- used to see if we've seen a whole loop of the animation
    self.timesPlayed = 0
end

function Animation:refresh()
    self.timer = 0
    self.currentFrame = 1
    self.timesPlayed = 0
end

function Animation:update(dt)
    -- if not a looping animation and we've played at least once, exit
    if not self.looping and self.timesPlayed > 0 then
        return
    end

    -- no need to update if animation is only one frame
    if #self.frames > 1 then
        self.timer = self.timer + dt

        if self.timer > self.interval then
            self.timer = self.timer % self.interval

            self.currentFrame = math.max(1, (self.currentFrame + 1) % (#self.frames + 1))

            -- if we've looped back to the beginning, record
            if self.currentFrame == #self.frames then
                self.timesPlayed = self.timesPlayed + 1
            end
        end
    end
end

function Animation:getCurrentFrame()
    return self.frames[self.currentFrame]
end