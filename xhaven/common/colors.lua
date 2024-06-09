--- A collection of canned colors for the XHaven games (and TTS)
-- @module XHavenColors

local class = require 'r35_tts.middleclass'

local XHavenColors = class('XHavenColors')

local colors = {
  ["Gold"] = {
    r = 1.00,
    g = 0.75,
    b = 0.04,
    a = 1.00,
  },
  ["XP"] = {
    r = 0.02,
    g = 0.28,
    b = 0.54,
    a = 1.0,
  },
  ["EasyDifficulty"] = {
    r = 0.36,
    g = 0.55,
    b = 0.35,
    a = 1.0,
  },
  ["NormalDifficulty"] = {
    r = 0.93,
    g = 0.95,
    b = 0.94,
    a = 1.0,
  },
  ["HardDifficulty"] = {
    r = 0.72,
    g = 0.43,
    b = 0.0,
    a = 1.0,
  },
  ["VeryHardDifficulty"] = {
    r = 0.33,
    g = 0.04,
    b = 0.05,
    a = 1.0,
  },
  ["Trap"] = {
    r = 0.62,
    g = 0.17,
    b = 0.15,
    a = 1.0,
  },
  ["HazardousTerrain"] = {
    r = 0.9568,
    g = 0.3921,
    b = 0.1137,
    a = 1.0000,
  },
  ["L"] = {
    r = 0.1568,
    g = 0.8156,
    b = 0.7725,
    a = 1.0000,
  },
  ["White"] = {
    r = 1,
    g = 1,
    b = 1,
    a = 1,
  },
  ["Black"] = {
    r = 0,
    g = 0,
    b = 0,
    a = 1,
  },
  ["Red"] = {
    r = 0.8588,
    g = 0.1019,
    b = 0.0941,
    a = 1,
  },
  ["Blue"] = {
    r = 0.1215,
    g = 0.5333,
    b = 1.0000,
    a = 1,
  },
  ["Green"] = {
    r = 0.1921,
    g = 0.7019,
    b = 0.1686,
    a = 1,
  },
  ["Wound"] = {},
  ["Immobilize"] = {},
  ["Strengthen"] = {},
  ["Disarm"] = {},
  ["Curse"] = {},
  ["Damage"] = {},
  ["Bless"] = {},
}

--- Check if a named color exists
---
---@param name string
---@return bool
function XHavenColors.static:has(name)
  return colors[name] ~= nil
end

--- Returns the named color as a table with RGB values
---
---@param name string
---@return tts__Color
function XHavenColors.static:rgb(name)
  if XHavenColors:has(name) then
    return {
      r = colors[name].r,
      g = colors[name].g,
      b = colors[name].b,
    }
  end

  return nil
end

--- Returns the named color as a table with RGBA values
---
---@param name string Color name to look up
---@param alphaOverride string Override the alpha channel value (0-100)
---@return tts__Color
function XHavenColors.static:rgba(name, alphaOverride)
  if XHavenColors:has(name) then
    local usedAlpha = colors[name].a
    if alphaOverride ~= nil then
      usedAlpha = alphaOverride
    end

    return {
      r = colors[name].r,
      g = colors[name].g,
      b = colors[name].b,
      a = usedAlpha,
    }
  end
end

return XHavenColors
