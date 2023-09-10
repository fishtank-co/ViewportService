-- Services

local Services = {
    TweenService = game:GetService("TweenService")
}

-- App

local Module = {
    Cache = {},
    ModelCache = {},
    Camera = Instance.new("Camera")
}

function Module:SetView(Angle: CFrame)
    Module.Camera.CFrame = Angle
end

function Module:Lighting(FrameName: string, Direction: Vector3)
    if not Module.Cache[FrameName] then return end

    local Frame = Module.Cache[FrameName]

    Frame.LightDirection = Direction
end

function Module:Index(FrameName: string, Parent: GuiObject, Properties: {})
    if Module.Cache[FrameName] then return end

    local Frame = Instance.new("ViewportFrame")

    Frame.Name = FrameName
    Frame.CurrentCamera = Module.Camera
    Frame.BackgroundColor3 = Color3.fromRGB(127, 127, 127)
    Frame.BackgroundTransparency = 1

    Module.ModelCache[FrameName] = {}

    for i,v in pairs(Properties) do
        pcall(function()
            Frame[i] = v
        end)
    end

    Frame.Parent = Parent
    Module.Cache[FrameName] = Frame
end

function Module:Tween(FrameName: string, Time: number, Properties: {}, EasingDirection: Enum, EasingStyle: Enum)
    if not Module.Cache[FrameName] or not Time or not Properties then return end

    local Direction = EasingDirection or Enum.EasingDirection.Out
    local Style = EasingStyle or Enum.EasingStyle.Quad

    local Info = TweenInfo.new(Time, Style, Direction)

    local Tween = Services.TweenService:Create(Module.Cache[FrameName], Info, Properties)

    Tween:Play()

    Tween.Completed:Wait()
end

function Module:Insert(FrameName: string, ModelName: string, Model: WorldModel, Angle: CFrame)
    if not Module.Cache[FrameName] then return end

    local Frame = Module.Cache[FrameName]
    local WorldModel = Model:Clone()

    if Angle then
        WorldModel:PivotTo(CFrame.new(0, 0, 0) * Angle)
    else
        WorldModel:PivotTo(CFrame.new(0, 0, 0))
    end

    WorldModel.Parent = Frame

    Module.ModelCache[FrameName][ModelName] = WorldModel
end

function Module:Remove(FrameName: string, ModelName: string)
    if not Module.ModelCache[FrameName][ModelName] then return end

    Module.ModelCache[FrameName][ModelName]:Destroy()
    Module.ModelCache[FrameName][ModelName] = nil
end

function Module:Set(FrameName: string, Properties: {})
    if not Module.Cache[FrameName] then return end

    local Frame = Module.Cache[FrameName]

    for i,v in pairs(Properties) do
        pcall(function()
            Frame[i] = v
        end)
    end
end

function Module:Destroy(FrameName: string)
    if not Module.Cache[FrameName] then return end

    Module.Cache[FrameName]:Destroy()
    Module.Cache[FrameName] = nil
    Module.ModelCache[FrameName] = nil
end

function Module:Angle(FrameName: string, ModelName: string, Angle: CFrame)
    if not Module.ModelCache[FrameName][ModelName] then return end

    Module.ModelCache[FrameName][ModelName]:PivotTo(CFrame.new(0, 0, 0) * Angle)
end

function Module:Orientate(FrameName: string, ModelName: string, Angle: CFrame)
    if not Module.ModelCache[FrameName][ModelName] then return end

    Module.ModelCache[FrameName][ModelName]:PivotTo(Module.ModelCache[FrameName][ModelName]:GetPivot() * Angle)
end

return Module