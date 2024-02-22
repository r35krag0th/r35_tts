local class = require('middleclass')
local DieInstance = require('ge_tts.DieInstance')
local Json = require('ge_tts.Json')
local TableUtils = require('ge_tts.TableUtils')

-- Local Version
local VERSION = "1.0.0"

instance = { }

---@class CoreDice
local CoreDice = class("CoreDice")

---@shape CoreDiceSavedState
---@field instance ge_tts__DieInstance

---@shape CoreDiceOptions
---@field name string
---@field description string
---@field image string
---@field rotationValues []tts__Object_RotationValue
---@field announceRolls boolean
---@field announceManualRotations boolean
---@field object tts__Object

---@param options CoreDiceOptions
function CoreDice:initialize(options)
    self.name = options.name
    self.description = options.description or ""
    self.image = options.image
    self.rotationValues = options.rotationValues
    self.announceRolls = options.announceRolls
    self.announceManualRotations = options.announceManualRotations
    self.object = options.object
end

function CoreDice:onLoadHook(state)
    local isBlankSave = state == ""
    object.setName("")
    object.setDescription(self.description .. "\n\nv" .. VERSION)
    self:updateRotationValues()

    if isBlankSave then
        instance = DieInstance(self.object)
    else
        local savedState = --[[---@type GameSavedState]] Json.decode(state)
    end


end

function CoreDice:updateRotationValues()

end

function CoreDice:onRolled() end
function CoreDice:onRotationValueUpdated() end