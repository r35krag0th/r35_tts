describe("Tests Vector Utilities", function()
  describe("converts a vector to position table", function()
    local vectorutils = require("utils.vectors")
    local expectedX = 123
    local expectedY = 456
    local expectedZ = 789
    local t = {
      x = expectedX,
      y = expectedY,
      z = expectedZ,
    }
    local o = vectorutils.vec2pos(t)
    assert.are.equal(o.x, expectedX)
    assert.are.equal(o.y, expectedY)
    assert.are.equal(o.z, expectedZ)
  end)
end)
