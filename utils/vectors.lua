--- Generic Vector Helper Functions
-- @module vectorutils

local vectorutils = {}

-----
-- @field x
-- @field y
-- @field z
-- @table position

--- Turns a Vector into a TTS x, y, z coordinate table.
-- @param v tts__VectorShape
-- @return @{position}
vectorutils.vec2pos = function(v)
  return {
    x = v.x,
    y = v.y,
    z = v.z,
  }
end

return vectorutils
