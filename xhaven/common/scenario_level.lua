local class = require 'r35_tts.middleclass'
local ScenarioLevel = class('ScenarioLevel')

local _updateTotalPlayers = function(self)
  self.totalPlayers = 0

  for _, v in pairs(self.players) do
    if v ~= nil then
      self.totalPlayers = self.totalPlayers + 1
    end
  end
end

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

function ScenarioLevel:getLevel(playerNumber)
  local key = "P" .. playerNumber
  if self.players[key] ~= nil then
    return self.players[key]
  end

  return 1
end

function ScenarioLevel:increment(playerNumber)
  _changePlayerLevel(self, playerNumber, 1)
end

function ScenarioLevel:decrement(playerNumber)
  _changePlayerLevel(self, playerNumber, -1)
end

function ScenarioLevel:goldPerCoin()
  local L = self:L().roundedUp
  if L == 0 or L == 1 then return 2
  elseif L == 2 or L == 3 then return 3
  elseif L == 4 or L == 5 then return 5
  elseif L == 6 then return 5
  elseif L == 7 then return 6
  end

  -- error("Scenario Level (L) is unexpected: " .. L)
end

function ScenarioLevel:monsterLevel()
  return self:L().roundedUp
end

function ScenarioLevel:bonusExperience()
  local L = self:L().roundedUp
  return (L * 2) + 4
end

function ScenarioLevel:trapDamage()
  local L = self:L().roundedUp
  return L + 2
end

function ScenarioLevel:hazardousTerrainDamage()
  local L = self:L().roundedUp
  if L == 0 then return 1
  elseif L >= 1 and L <= 3 then return 2
  elseif L >= 4 and L <= 6 then return 3
  elseif L == 7 then return 4
  end
end

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

function ScenarioLevel.static:usingDefaults()
  return self:new()
end

---@params state table
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
