--[[
    Class to show the death state

    Author: Krishna S Pillai(krishna_sp@outlook.com)
]]

EntityDeathState = Class{__includes = EntityBaseState}

function EntityDeathState:init(entity)
    self.entity = entity
end

function EntityDeathState:enter(params)
    self.entity.dead = true
    self.entity:changeAnimation('death')
end