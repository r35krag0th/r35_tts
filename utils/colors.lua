--- Utilities for converting colors
---@module colorutils

local colorutils = {}

colorutils.hex2rgb = function()
end

colorutils.hex2rgba = function()
end

return colorutils


-----
--- Color Table with Alpha channel
-- @field r
-- @field g
-- @field b
-- @field a
-- @table color_with_alpha

--- Color Table without alpha channel
-- @field r
-- @field g
-- @field b
-- @field a
-- @table color_without_alpha

-- --- Basic Color manipulation utils and handy converters
-- -- module: ColorUtils
-- local class = require 'middleclass'
--
-- ---@class RGBColor
-- ---@field r number
-- ---@field g number
-- ---@field b number
-- local RGBColor = class('RGBColor')
--
-- ---Creates an RGB Color Instance
-- ---@param r number
-- ---@param g number
-- ---@param b number
-- function RGBColor:initialize(r, g, b)
--   self.r = r
--   self.g = g
--   self.b = b
-- end
--
-- ---Returns the rgb keyed table format of this color
-- ---@return table<string,number>
-- function RGBColor:asTable()
--   return {
--     r = self.r,
--     g = self.g,
--     b = self.b,
--   }
-- end
--
-- ---@class RGBColorWithAlpha
-- ---@field r number
-- ---@field g number
-- ---@field b number
-- ---@field a number
-- local RGBColorWithAlpha = class('RGBColorWithAlpha', RGBColor)
--
-- function RGBColorWithAlpha:initialize(r, g, b, a)
--   RGBColor.initialize(self, r, g, b)
--   self.a = a
-- end
--
-- ---Returns the rgba keyed table format of this color
-- ---@return table<string,number>
-- function RGBColorWithAlpha:asTable()
--   return {
--     r = self.r,
--     g = self.g,
--     b = self.b,
--     a = self.a,
--   }
-- end
--
-- --[ HEX COLOR ]--
--
-- local HexColor = class('HexColor')
--
-- ---Initialize the Hex Color
-- ---@param hex string
-- function HexColor:initialize(hex)
--   self.hex = hex:gsub("#", "")
-- end
--
-- local hexAsRGBTable = function(self, alpha)
--   local r = tonumber("0x" .. self.hex:sub(1, 2), 16)
--   local g = tonumber("0x" .. self.hex:sub(3, 4), 16)
--   local b = tonumber("0x" .. self.hex:sub(5, 6), 16)
--   if alpha ~= nil then
--     if alpha > 1 then
--       alpha = 1
--     elseif alpha < 0 then
--       alpha = 0
--     end
--     return {
--       r = r,
--       g = g,
--       b = b,
--       a = alpha,
--     }
--   end
--
--   return {
--     r = r,
--     g = g,
--     b = b,
--   }
-- end
--
-- ---Converts a Hex color to RGB Percent
-- ---@param alpha number
-- ---@return RGBColor
-- function HexColor:asRGBPercent(alpha)
--   local t = hexAsRGBTable(self, alpha)
--   t.r = t.r / 255
--   t.g = t.g / 255
--   t.b = t.b / 255
--
--   if alpha ~= nil then
--     if alpha > 100 then
--       alpha = 100
--     elseif alpha < 0 then
--       alpha = 0
--     end
--     alpha = alpha / 100
--     return RGBColorWithAlpha:new(t.r, t.g, t.b, alpha)
--   end
--
--   return RGBColor:new(t.r, t.g, t.b)
-- end
--
-- function HexColor:asRGB(alpha)
--   local t = hexAsRGBTable(self, alpha)
--   if alpha ~= nil then
--     if alpha > 100 then
--       alpha = 100
--     elseif alpha < 0 then
--       alpha = 0
--     end
--     return RGBColorWithAlpha:new(t.r, t.g, t.b, alpha)
--   end
--
--   return RGBColor:new(t.r, t.g, t.b)
-- end
--
-- local ColorUtils = class('ColorUtils')
--
-- ---Converts Hex to RGBA table
-- ---@param hex string
-- ---@param alpha integer
-- ---@return RGBColorWithAlpha
-- function ColorUtils.HexToRGBA(hex, alpha)
--
-- end
