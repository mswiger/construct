--[[
Copyright (c) 2025 Michael Swiger

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]--

local ConstructMetatable = {
  --- Internal value used for flattening constructs into entities.
  __construct = true,
}

--- Constructs an entity from the given construct. A construct is represented as a mapping of components to their
--- respective values. A component is represented as a function that is called with its value as its parameter.
--- Nested constructs will be flattened into the top-level construct.
--- @param construct table<fun, any> a mapping of components to their values that represent the construct
--- @param entity table<fun, any> the entity to attach the construct to, or nil to create a new entity
--- @return table<fun, any> the entity representation of the given construct
local function Construct(construct, entity)
  local e = entity or {}

  for Component, value in pairs(construct) do
    local mt = getmetatable(value)
    if mt and mt.__construct == true then
      Construct(value, e)
    else
      e[Component] = Component(value)
    end
  end

  setmetatable(e, ConstructMetatable)

  return e
end

return Construct
