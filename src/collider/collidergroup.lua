local ColliderGroup, super = Class(Collider)

function ColliderGroup:init(parent, ...)
    super:init(self, 0, 0, parent)

    self.colliders = {}
    for _,v in ipairs({...}) do
        self:addCollider(v)
    end
end

function ColliderGroup:addCollider(collider)
    collider.parent = self.parent
    table.insert(self.colliders, collider)
end

function ColliderGroup:collidesWith(other)
    other = self:getOtherCollider(other)
    if not other then return false end

    for _,collider in ipairs(self.colliders) do
        if collider:collidesWith(other) then
            return true
        end
    end

    return super:collidesWith(self, other)
end

function ColliderGroup:draw(r,g,b,a)
    for _,collider in ipairs(self.colliders) do
        collider:draw(r,g,b,a)
    end
end

return ColliderGroup