--- A collection of string utility Functions
---@module stringutils
local stringutils = {}


--- Converts a boolean value to string with optional replacements.
-- @tparam boolean value
-- @tparam string trueText
-- @tparam string falseText
-- @treturn tsring
stringutils.booleanToString = function(value, trueText, falseText)
  if value == nil then return "nil" end
  if trueText == nil then trueText = "true" end
  if falseText == nil then falseText = "false" end

  if value then return trueText end
  return falseText
end

stringutils.valueOrNilString = function(value)
  if value == nil then return "nil" end
  return value
end

return stringutils
