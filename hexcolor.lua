--- Helper function to work with hex colors
-- @module HexColor

local class = require('r35_tts.middleclass')

local HexColor = class('HexColor')

local _private = setmetatable({}, {
  __mode = "k",
})

function HexColor:initialize(hex)
  -- self._hex = hex:gsub("#", "")
  _private[self] = {
    hex = hex:gsub("#", ""),
  }
end

local _toTable = function(self, alpha)
  assert(self ~= nil)
  local r = tonumber("0x" .. self.hex():sub(1, 2), 16)
  local g = tonumber("0x" .. self.hex():sub(3, 4), 16)
  local b = tonumber("0x" .. self.hex():sub(5, 6), 16)

  if alpha ~= nil then
    alpha = math.max(0, math.min(1, alpha))
    return {
      r = r,
      g = g,
      b = b,
      a = alpha,
    }
  end

  return {
    r = r,
    g = g,
    b = b,
  }
end

function HexColor:hex()
  return _private[self].hex
end

function HexColor:rgb()
  return _toTable()
end

function HexColor:rgba(alpha)
  return _toTable(alpha)
end

return HexColor
