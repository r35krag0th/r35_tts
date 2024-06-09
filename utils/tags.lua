--- Generic TTS Tag Helper Functions
---@module tagutils

local tableutils = require('r35_tts.utils.tables')

local tagutils = {}

--- Attempts to locate objects that are decks, stacks, or containers
--- bearing the specified tag.
-- @within Containers
-- @tparam string tag
-- @return a list (table) of objects found
tagutils.findContainersByTag = function(tag)
  local objects = getObjectsWithTag(tag)
  local output = {}
  for _, obj in pairs(objects) do
    if obj.getQuantity() >= 0 then
      output = table.insert(output, obj)
    end
  end
  return output
end

--- Attempts to locate objects that are not decks, stacks, or containers
--- bearing the specified tag.
-- @within Non-Containers
-- @tparam string tag
-- @return a list (table) of objects found
tagutils.findNonContainersByTag = function(tag)
  local objects = getObjectsWithTag(tag)
  local output = {}
  for _, obj in pairs(objects) do
    if obj.getQuantity() < 0 then
      output = table.insert(output, obj)
    end
  end
  return output
end

--- Gets a count of objects that are decks, containers, or stacks
--- bearing the specifed tag.
-- @within Containers
-- @tparam string tag
-- @treturn int
tagutils.countOfContainersByTag = function(tag)
  return tableutils.length(tagutils.findContainersByTag(tag))
end

--- Gets a count of objects that are not decks, containers, or stacks
--- bearing the specifed tag.
-- @within Non-Containers
-- @tparam string tag
-- @treturn int
tagutils.countOfNonContainersByTag = function(tag)
  return tableutils.length(tagutils.findNonContainersByTag(tag))
end

return tagutils
