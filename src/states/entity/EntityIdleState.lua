--[[
    Forgotten Tales

    Author: Krishna S Pillai(krishna_sp@outlook.com)
]]

EntityIdleState = Class{__includes = EntityBaseState}

function EntityIdleState:init(entity)
    self.entity = entity
    self.entity:changeAnimation('idle-' .. self.entity.direction)
end