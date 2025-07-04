-- local CArtilleryProtonProjectile = import("/lua/cybranprojectiles.lua").CArtilleryProtonProjectile

-- --- Cybran Proton Artillery Projectile
-- ---@class CIFArtilleryProton03 : CArtilleryProtonProjectile
-- CIFArtilleryProton03 = ClassProjectile(CArtilleryProtonProjectile) {
--     FxLandHitScale = 1.6,
--     FxPropHitScale = 1.6,
--     FxUnitHitScale = 1.6,

--     ---@param self CIFArtilleryProton03
--     ---@param targetType string
--     ---@param targetEntity Prop|Unit
--     OnImpact = function(self, targetType, targetEntity)
--         CArtilleryProtonProjectile.OnImpact(self, targetType, targetEntity)
--         self:ShakeCamera( 20, 3, 0, 1 )
--     end,
-- }
-- TypeClass = CIFArtilleryProton03

local CArtilleryProtonProjectile = import("/lua/cybranprojectiles.lua").CArtilleryProtonProjectile
local GetDistanceBetweenTwoPoints2 = import("/lua/utilities.lua").GetDistanceBetweenTwoPoints2
-- local GetMidPoint = import("/lua/utilities.lua").GetMidPoint
local MathSqrt = math.sqrt
local MathPow = math.pow

--- Cybran Proton Artillery Projectile
---@class CIFArtilleryProton03 : CArtilleryProtonProjectile
CIFArtilleryProton03 = ClassProjectile(CArtilleryProtonProjectile) {
    FxLandHitScale = 1.6,
    FxPropHitScale = 1.6,
    FxUnitHitScale = 1.6,

    ---@param self Projectile
    ---@param inWater? boolean
    OnCreate = function(self, inWater)
        CArtilleryProtonProjectile.OnCreate(self)
        self.Trash:Add(ForkThread(self.UpdateThread, self))
    end,

    ---@param self CIFArtilleryProton03
    UpdateThread = function(self)
        -- WaitTicks(1)
        -- local currentPos = self:GetPosition()
        -- local targetPos = self:GetCurrentTargetPosition()
        -- local vx, vy, vz = self:GetVelocity()
        -- vx, vy, vz = vx*10, vy*10, vz*10
        -- LOG('vel')
        -- self:SetVelocity(vx*2, vy*2, vz*2)
        -- self:SetBallisticAcceleration(-9.8)

        -- -- calculate the vertex of the firing solution
        -- -- vy + gravity * t = 0, t = -vy
        -- time to target in seconds
        -- local t = -vy * -0.204081633 -- (1/-4.9)
        -- local vertex = Vector(vx * t, (vy * t) + (0.5 * (-4.9) * t * t) , vz * t)

        -- -- Step 2: Total time of flight is twice the time to vertex (symmetric parabolic path)
        -- local t_total = 2 * t

        -- -- Step 3: Desired time of flight is half of the original
        -- local t_desired = t_total / 2

        -- -- Step 4: Set gravity (unchanged)
        -- --SetBallisticAcceleration(gravity)

        -- -- Step 5: Compute required constant acceleration along the velocity vector to land at target in t_desired

        -- -- Displacement needed
        -- local dx = targetPos.x - currentPos.x
        -- local dy = targetPos.y - currentPos.y
        -- local dz = targetPos.z - currentPos.z
        -- local displacement = {x = dx, y = dy, z = dz}

        -- -- Velocity magnitude and direction
        -- local v_mag = math.sqrt(vx * vx + vy * vy + vz * vz)
        -- local dir = {x = vx / v_mag, y = vy / v_mag, z = vz / v_mag}
        -- LOG('vel mag dir')

        -- -- -- Dot product of displacement and velocity direction (i.e., projection of displacement along velocity)
        -- local d_along_v = dx * dir.x + dy * dir.y + dz * dir.z

        -- Equation: s = vt + 0.5at² → solve for a
        -- d_along_v = v_mag * t + 0.5 * a * t^2
        -- local t = t_desired
        -- local a = (2 * (d_along_v - v_mag * t)) / (t * t)

        -- Final acceleration vector
        -- local ax = dir.x * a
        -- local ay = dir.y * a
        -- local az = dir.z * a
        -- local accel = Vector(ax, ay, az)

        -- -- Step 6: Set acceleration along velocity vector
        -- self:SetAcceleration(accel)

        -- Step 6: Project displacement onto velocity direction (i.e., effective path length along velocity)
        -- local d_along_path = dx * dir.x + dy * dir.y + dz * dir.z

        -- Step 7: Solve for forward acceleration `a` using:
        -- s = v*t + 0.5*a*t^2 → a = 2*(s - v*t) / t^2
        -- local a_forward = -2 * (d_along_path - v_mag * t_desired) / (t_desired * t_desired)
        -- LOG('found acc'..a_forward)

        -- -- Step 8: Apply forward acceleration along current path
        -- self:SetAcceleration(a_forward)
        -- LOG('set acc')

        -- local midPoint = GetMidPoint(currentPos, targetPos)
        -- local oneQuarterPoint = GetMidPoint(currentPos, midPoint)
        -- local threeQuarterPoint = GetMidPoint(midPoint, targetPos)
        -- local fiveEighthsPoint = GetMidPoint(midPoint, threeQuarterPoint)

        -- unit (0/1) <> M2(1/4) <> M1 (1/2) <> M4(5/8) <> M3(3/4) <> target (1/1)    

        -- local remainingDistance = GetDistanceBetweenTwoPoints2(currentPos[1], currentPos[3], targetPos[1], targetPos[3])
        

        -- local accel = 1
        -- local ballisticAccel = -4.9
        -- local vx, vy, vz = self:GetVelocity()
        -- vx, vy, vz = vx*10, vy*10, vz*10
        -- while remainingDistance > 10 do
        --     WaitTicks(2)
        --     remainingDistance = GetDistanceBetweenTwoPoints2(currentPos[1], currentPos[3], targetPos[1], targetPos[3])
        --     vx, vy, vz = self:GetVelocity()
        --     -- vx, vy, vz = vx*10, vy*10, vz*10
        --     -- increase in all directions
        --     -- but needs to be magnified so it's an increase of 1 in y direction
        --     self:SetAcceleration(accel)
        --     -- self:SetVelocity(vx, vy + (accel*accel), vz)
        --     self:SetBallisticAcceleration(ballisticAccel)
        --     accel = accel + 1.2
        --     ballisticAccel = ballisticAccel - 1
        -- end
        
        -- local halfDistance = remainingDistance * 0.5
        -- local oneThirdDistance = remainingDistance * 0.3333
        -- local oneQuarterDistance = remainingDistance * 0.25
        -- local threeQuarterDistance = remainingDistance * 0.75
        -- local thresholdDistance = remainingDistance * (3/8)

        -- -- local bp = self:GetBlueprint()
        -- -- self:SetVelocity(360)
        -- -- first quarter
        -- while (remainingDistance > threeQuarterDistance) do
        --     -- LOG('current' .. remainingDistance)
        --     -- LOG('')
        --     WaitTicks(1)
        --     currentPos = self:GetPosition()
        --     remainingDistance = GetDistanceBetweenTwoPoints2(currentPos[1], currentPos[3], targetPos[1], targetPos[3])
        -- end
        -- -- second quarter
        -- while (remainingDistance > halfDistance) do
        --     -- LOG('current' .. remainingDistance)
        --     -- LOG('')
        --     WaitTicks(1)
        --     currentPos = self:GetPosition()
        --     remainingDistance = GetDistanceBetweenTwoPoints2(currentPos[1], currentPos[3], targetPos[1], targetPos[3])
        -- end
        -- -- second half
        -- -- past the speed up threshold
        -- while (remainingDistance > thresholdDistance) do
        --     -- LOG('current' .. remainingDistance)
        --     -- LOG('')
        --     WaitTicks(1)
        --     currentPos = self:GetPosition()
        --     remainingDistance = GetDistanceBetweenTwoPoints2(currentPos[1], currentPos[3], targetPos[1], targetPos[3])
        -- end
        -- self:SetAcceleration(100)
        -- self:SetBallisticAcceleration(-49)


        -- probably needs a new ballistic acceleration set now

        -- LOG('current' .. remainingDistance)
        -- LOG('third' .. oneThirdDistance)

        -- while distance to target is more than 1/3 the initial distance to target keep waiting
        -- while (remainingDistance > oneThirdDistance) do
        --     -- LOG('current' .. remainingDistance)
        --     -- LOG('')
        --     WaitTicks(5)
        --     currentPos = self:GetPosition()
        --     remainingDistance = GetDistanceBetweenTwoPoints2(currentPos[1], currentPos[3], targetPos[1], targetPos[3])
        -- end

        -- local height = currentPos[2]
        -- local vx, vy, vz = self:GetVelocity()
        -- Normalize our velocity to ogrids/second
        -- vx, vy, vz = vx*10, vy*10, vz*10
        --local vMult = (160)/(10 * self:GetCurrentSpeed()) -- muzzle velocity of 160
        --local timeToImpact = ((-vy - MathSqrt(MathPow(vy,2) - 2*(-4.9)*height))/(-4.9)) / vMult

        -- Calculate the new ballistic acceleration
        --local ballisticAcceleration = -2 * (height + vy*vMult * timeToImpact) / MathPow(timeToImpact, 2)

        -- Update our velocity values to their new lower values 
        --vx, vy, vz = vx*vMult, vy*vMult, vz*vMult

		-- One initial projectile following same directional path as the original
        --self:SetVelocity(vx, vy, vz)
        --    :SetBallisticAcceleration(ballisticAcceleration).DamageData = self.DamageData

        -- time to impact = distance of parabola / speed

        -- -- LOG('got there')
        -- self:SetVelocity(640) -- 4*160
        -- self:SetBallisticAcceleration(-19.6) -- 4*-4.9
        -- self:SetAcceleration(10)
        -- self:SetBallisticAcceleration(-19.6)
    end,

    ---@param self CIFArtilleryProton03
    ---@param targetType string
    ---@param targetEntity Prop|Unit
    OnImpact = function(self, targetType, targetEntity)
        CArtilleryProtonProjectile.OnImpact(self, targetType, targetEntity)
        self:ShakeCamera( 20, 3, 0, 1 )
    end,
}
TypeClass = CIFArtilleryProton03