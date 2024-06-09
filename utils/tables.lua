--- Generic Table Helper Functions
-- @module tableutils

local tableutils = {}

--- Get the length (count of items) in a table.
---
--- **NOTE:** This does use iteration to get an accurate count.
-- @tparam table t
tableutils.length = function(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end

return tableutils
