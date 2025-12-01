expose("Construct API", function ()
  _G.Construct = require("construct")

  it("can be imported", function()
    assert.are.equal(type(Construct), "function")
    assert.are_not.equal(Construct, nil)
  end)
end)

describe("Construct", function()
  it("returns an entity with the given components", function ()
    local C = function(v) return v end
    local entity = Construct {
      [C] = 15
    }
    assert.are.equal(type(entity), "table")
    assert.are.equal(entity[C], 15)
  end)

  it("flattens constructs into a single top-level entity", function ()
    local Component1 = function(v) return v end
    local Component2 = function(v) return v end
    local NestedConstruct = Construct {
      [Component1] = "nested",
    }
    local entity = Construct {
      [Component2] = "outter",
      NestedConstruct,
    }
    assert.are.equal(entity[Component1], "nested")
    assert.are.equal(entity[Component2], "outter")
  end)
end)
