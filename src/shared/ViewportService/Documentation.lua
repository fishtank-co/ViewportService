--[[

     _   _ _                                _   _____                 _          
    | | | (_)                              | | /  ___|               (_)         
    | | | |_  _____      ___ __   ___  _ __| |_\ `--.  ___ _ ____   ___  ___ ___ 
    | | | | |/ _ \ \ /\ / / '_ \ / _ \| '__| __|`--. \/ _ \ '__\ \ / / |/ __/ _ \
    \ \_/ / |  __/\ V  V /| |_) | (_) | |  | |_/\__/ /  __/ |   \ V /| | (_|  __/
     \___/|_|\___| \_/\_/ | .__/ \___/|_|   \__\____/ \___|_|    \_/ |_|\___\___|
                          | |                                                    
                          |_|                                                                                                           

    Introduction

        Welcome to ViewportService! The easy-to-use service for creating viewportframes!

    Documentation

        Properties

            Module.Cache (Table)
            Cache of viewportframes. Can access via Module.Cache[FrameName]

            Module.ModelCache (Table)
            Cache of models inside viewportframes. Accessible via Module.ModelCache[FrameName][ModelName]

            Module.Camera (Camera)
            Main camera object.

        Functions

            Indexing and Editing

                Module:Index(Name (string), Parent (guiobject), Properties (table))
                Creates a new ViewportFrame. Requires a name and parent.

                Module:Set(FrameName (string), Properties (table))
                Sets properties for an already existing frame.

                Module:Destroy(FrameName (string))
                Removes an existing frame.

            Viewport Properties

                Module:SetView(CFrame)
                Sets the camera's CFrame. WorldModels will always be at 0, 0, 0, so point towards the center of the world.

                Module:Lighting(FrameName (string), Vector3)
                Sets lighting direction. Defaults to -1, -1, -1

                Module:Tween(FrameName (string), Time (number), Properties (table), EasingDirection (Enum, optional), EasingStyle (Enum, optional))
                Tweens the properties of a viewport.

            Model Editing

                Module:Insert(FrameName (string), ModelName (string), Model (worldmodel), Angle (CFrame, optional))
                Inserts a worldmodel into a frame.

                Module:Remove(FrameName (string), ModelName (string))
                Removes a model from a frame.

                Module:Angle(FrameName (string), ModelName (string), Angle (CFrame))
                Sets the angle of a model.

                Module:Orientate(FrameName (string), ModelName (string), Angle (CFrame))
                Changes the angle of a model.

    Example

        local ReplicatedStorage = game:GetService("ReplicatedStorage")

        -- Grab the module
        local Module = require(ReplicatedStorage.ViewportService.Module)

        -- Set the distance from the center
        Module:SetView(CFrame.new(0, 0, 3.5))

        -- Index the viewportframe
        Module:Index("MyFrame", script.Parent, {
            Size = UDim2.fromOffset(200, 200),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            BackgroundColor3 = Color3.new(0.5, 0.5, 0.5),
            LightColor = Color3.new(1, 1, 1)
        })

        -- Set the viewportframe's lighting
        Module:Lighting("MyFrame", Vector3.new(-1, 0, -1))

        -- Insert a sword model, no cloning required!
        Module:Insert("MyFrame", "Sword", ReplicatedStorage.Sword)

        -- Set the angle of the sword
        Module:Angle("MyFrame", "Sword", CFrame.Angles(math.rad(270), math.rad(45), math.rad(180)))

        -- Spin the sword for a second
        for i = 1, 360 do
            Module:Orientate("MyFrame", "Sword", CFrame.Angles(0, math.rad(1), 0))
            
            task.wait(1 / 360)
        end

        -- Fade using Tweening
        Module:Tween("MyFrame", 5, {ImageTransparency = 1})

        -- The thread will wait for the tween to complete

        -- Destroy sword
        Module:Destroy("MyFrame")

--]]
