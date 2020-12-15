--[[
    Forgotten Tales

    Author: Krishna S Pillai(krishna_sp@outlook.com)
]]

EntityWalkState = Class{__includes = EntityBaseState}

function EntityWalkState:init(entity)
    self.entity = entity
    
    self.canWalk = false
end

function EntityWalkState:enter(params)
    self.entity:changeAnimation('walk-' .. tostring(self.entity.direction))
end
