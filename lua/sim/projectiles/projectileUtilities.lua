local g = -4.9 -- gravity constant
local gRec = -0.204081633 -- 1/g

function ComputeTimeToVertexOfParabolicArc(velocityY)
    return -velocityY * gRec
end

-- make sure to pass in velocity per second NOT per tick
function ComputeVertexOfParabolicArc(velX, velY, velZ)
    local t = ComputeTimeToVertexOfParabolicArc(velY)
    return Vector(
        velX * t,
        velY * t + 0.5 * g * t * t,
        velZ * t
    )
end

function ComputeAccelerationIncreaseForLaunch()

end

function ComputeAccelerationDecreaseForLaunch()

end

function ComputeAccelerationIncreaseForDescent()

end

-- take in a maximum velocity multiplier to multiply up until
-- or a maximum acceleration? the velocity thing would need to be math'd
--    somehow to set an acceleration that gets to that velocity or lower
function ComputeFiringSolution(projectile)
    local currentPos = projectile:GetPosition()
    local targetPos = projectile:GetCurrentTargetPosition()
    local initialVelocity = projectile:GetVelocity()
    local vx, vy, vz = projectile:GetVelocity()
    vx, vy, vz = vx*10, vy*10, vz*10

    local t = ComputeTimeToVertexOfParabolicArc(vy)

    local vertex = ComputeVertexOfParabolicArc(vx, vy, vz)

    -- increase acceleration
    -- wait ticks until it will get 1/4 of total travel with added acceleration
    -- decrease acceleration
    -- wait ticks until it will get to vertex
    -- increase acceleration until landing

    -- OR

    -- increase acceleration and ballistic acceleration per-tick type of thing
    -- interesting
end

