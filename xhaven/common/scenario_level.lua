---@module ScenarioLevel

local class = require 'r35_tts.middleclass'
local ScenarioLevel = class('ScenarioLevel')

--- Updates the total player count based on the TTS Players
---
--- This is based on the number of players contained in `players` that
--- are not null.
-- @param self self
local _updateTotalPlayers = function(self)
  self.totalPlayers = 0

  for _, v in pairs(self.players) do
    if v ~= nil then
      self.totalPlayers = self.totalPlayers + 1
    end
  end
end

--- Update the player's level with the given `levelDifference` and then calls @{_updateTotalPlayers}
--- to update the total player count.
---
--- - If the player's level would go below **zero** then it will be set to **one**.
--- - If the player's level would go above **nine** then it will be set to **nine**.
---
-- @param self self
-- @param playerNumber number is the index representing the color slots for Players
-- @param levelDifference number is the amount the player's level will change by.
local _changePlayerLevel = function(self, playerNumber, levelDifference)
  assert(playerNumber <= 4, "X-Haven games only support a max of 4 players")
  assert(playerNumber > 0, "Player number must be a positive number")

  local playerKey = "P" .. playerNumber
  if self.players[playerKey] == nil then
    self.players[playerKey] = 1
  end

  self.players[playerKey] = self.players[playerKey] + levelDifference

  -- Ensure the levels remain within the bounds
  -- TODO: Change this to use math.min and math.max
  if self.players[playerKey] <= 0 then
    self.players[playerKey] = 1
  elseif self.players[playerKey] > 9 then
    self.players[playerKey] = 9
  end

  _updateTotalPlayers(self)
end

--- Initializes a Scenario Level with the given player levels.
---
--- After initialization @{_updateTotalPlayers} is automatically
--- called.
---
-- @tparam int a Red Player's level
-- @tparam int b White Player's level
-- @tparam int c Blue Player's level
-- @tparam int d Green Player's level
function ScenarioLevel:initialize(a, b, c, d)
  self.players = {
    ["P1"] = a,
    ["P2"] = b,
    ["P3"] = c,
    ["P4"] = d,
  }
  self.totalPlayers = 0

  _updateTotalPlayers(self)
end

--- The actual scenario level, or more frequently called "L" in the game's
--- printed materials.
---
-- @return a table containing `raw`, `roundedUp`, and `roundedDown` values.
function ScenarioLevel:L()
  local totalLevels = 0
  for _, v in pairs(self.players) do
    if v ~= nil then
      totalLevels = totalLevels + v
    end
  end

  local scenarioLevel = 0

  if self.totalPlayers > 0 then
    local averageLevel = math.min(math.max(totalLevels / self.totalPlayers, 0), 9)
    scenarioLevel = averageLevel / 2
  end

  return {
    raw = scenarioLevel,
    roundedUp = math.ceil(scenarioLevel),
    roundedDown = math.ceil(scenarioLevel),
  }
end

--- Gets the player level for the given `playerNumber` or returns `1` if
--- not found.
-- @tparam int playerNumber The player number to look up (1-4)
-- @treturn int The player's level
function ScenarioLevel:getLevel(playerNumber)
  local key = "P" .. playerNumber
  if self.players[key] ~= nil then
    return self.players[key]
  end

  return 1
end

--- Increment the player's level by 1.
-- @see _changePlayerLevel
-- @tparam int playerNumber the player number to alter.
function ScenarioLevel:increment(playerNumber)
  _changePlayerLevel(self, playerNumber, 1)
end

--- Decrement the player's level by 1.
-- @see _changePlayerLevel
-- @tparam int playerNumber the player number to alter.
function ScenarioLevel:decrement(playerNumber)
  _changePlayerLevel(self, playerNumber, -1)
end

--- Get the gold-per-coin value for the current Scenario Level.
-- @treturn int gold earned per coin looted
function ScenarioLevel:goldPerCoin()
  local L = self:L().roundedUp
  if L == 0 or L == 1 then return 2
  elseif L == 2 or L == 3 then return 3
  elseif L == 4 or L == 5 then return 5
  elseif L == 6 then return 5
  elseif L == 7 then return 6
  end
end

--- Get the monster level for the current Scenario level.
-- @treturn int monster level
function ScenarioLevel:monsterLevel()
  return self:L().roundedUp
end

--- Get the bonus experience rewarded for completing a scenario successfully.
-- @treturn int bonus experience points awarded
function ScenarioLevel:bonusExperience()
  local L = self:L().roundedUp
  return (L * 2) + 4
end

--- Get the trap damage for the current Scenario Level.
-- @treturn int damage amount
function ScenarioLevel:trapDamage()
  local L = self:L().roundedUp
  return L + 2
end

--- Get the hazardous terrain damage for the current Scenario Level.
-- @treturn int damage amount
function ScenarioLevel:hazardousTerrainDamage()
  local L = self:L().roundedUp
  if L == 0 then return 1
  elseif L >= 1 and L <= 3 then return 2
  elseif L >= 4 and L <= 6 then return 3
  elseif L == 7 then return 4
  end
end

--- Get the persistable state so it can be saved on the TTS object.
-- @return state table
function ScenarioLevel:toState()
  return {
    playerLevels = self["players"],
    difficultyModifier = 0,
    computed = {
      L = self:L(),
      C = self["totalPlayers"],
      trap = self:trapDamage(),
      hazardous = self:hazardousTerrainDamage(),
      gold = self:goldPerCoin(),
      bonusExperience = self:bonusExperience(),
      monsterLevel = self:monsterLevel(),
    },
    -- I don't like that we're doing this here...
    -- locked = state.locked,
    -- bottomRowAlpha = state.bottomRowAlpha,
  }
end

--- Create a new @{ScenarioLevel} using defaults.
-- @treturn ScenarioLevel
function ScenarioLevel.static:usingDefaults()
  return self:new()
end

---Hydrate a @{ScenarioLevel} using persisted state.
-- @param state table
-- @treturn ScenarioLevel
function ScenarioLevel.static:fromState(state)
  assert(state ~= nil, "state was nil")
  assert(state["playerLevels"] ~= nil, "state does not contain playerLevels")
  -- assert(#state.playerLevels == 4, "state does not contain 4 player level items")
  --
  assert(state.playerLevels["P1"] ~= nil, "player 1's level is nil")
  assert(state.playerLevels["P2"] ~= nil, "player 2's level is nil")
  assert(state.playerLevels["P3"] ~= nil, "player 3's level is nil")
  assert(state.playerLevels["P4"] ~= nil, "player 4's level is nil")
  --
  -- assert(state["difficultyModifier"] ~= nil)

  return self:new(
    state.playerLevels.P1,
    state.playerLevels.P2,
    state.playerLevels.P3,
    state.playerLevels.P4
  )
end

return ScenarioLevel
