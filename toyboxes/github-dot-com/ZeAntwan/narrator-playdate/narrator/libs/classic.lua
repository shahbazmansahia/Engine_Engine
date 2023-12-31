--
-- classic
--
-- Copyright (c) 2014, rxi
--
-- This module is free software; you can redistribute it and/or modify it under
-- the terms of the MIT license. See LICENSE for details.
--

class('NarratorObject').extends(Object)
local NarratorObject = {}
NarratorObject.__index = NarratorObject


function NarratorObject:new()
end


function NarratorObject:extend()
  local cls = {}
  for k, v in pairs(self) do
    if k:find("__") == 1 then
      cls[k] = v
    end
  end
  cls.__index = cls
  cls.super = self
  setmetatable(cls, self)
  return cls
end


function NarratorObject:implement(...)
  for _, cls in pairs({...}) do
    for k, v in pairs(cls) do
      if self[k] == nil and type(v) == "function" then
        self[k] = v
      end
    end
  end
end


function NarratorObject:is(T)
  local mt = getmetatable(self)
  while mt do
    if mt == T then
      return true
    end
    mt = getmetatable(mt)
  end
  return false
end


function NarratorObject:__tostring()
  return "NarratorObject"
end


function NarratorObject:__call(...)
  local obj = setmetatable({}, self)
  obj:new(...)
  return obj
end


return NarratorObject
