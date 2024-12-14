local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "YNC Scripts Phentom",
    Icon = 0, -- Icon in Topbar
    LoadingTitle = "Phentom Script",
    LoadingSubtitle = "by user",
    Theme = "Default",

    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,

    ConfigurationSaving = {
        Enabled = true,
        FileName = "YNC Phentom"
    },

    Discord = {
        Enabled = true,
        Invite = "yncscripts",
        RememberJoins = true
    },

    KeySystem = true,
    KeySettings = {
        Title = "User Made Ts",
        Subtitle = "Key System",
        Note = "No method of obtaining the key is provided",
        FileName = "Key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/mZkvPHpT"}
    }
})

local Tab = Window:CreateTab("Shooting", 4483362458)

local Button = Tab:CreateButton({
    Name = "Smooth YNC Camlock (HITS MORE SHOTS)",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local Holding = false
        local e = false
        local isdoing = false

        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = Player.PlayerGui

        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(0, 200, 0, 50)
        statusLabel.Position = UDim2.new(0.5, -100, 0, 10)
        statusLabel.BackgroundTransparency = 0.5
        statusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.TextScaled = true
        statusLabel.Text = "Not in Range"
        statusLabel.Parent = screenGui

        local noBallLabel = Instance.new("TextLabel")
        noBallLabel.Size = UDim2.new(0, 200, 0, 50)
        noBallLabel.Position = UDim2.new(0.5, -100, 0, 70)
        noBallLabel.BackgroundTransparency = 0.5
        noBallLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        noBallLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        noBallLabel.TextScaled = true
        noBallLabel.Text = "No Ball"
        noBallLabel.Parent = screenGui
        noBallLabel.Visible = true

        local dunkingRangeLabel = Instance.new("TextLabel")
        dunkingRangeLabel.Size = UDim2.new(0, 200, 0, 50)
        dunkingRangeLabel.Position = UDim2.new(0.5, -100, 0, 130)
        dunkingRangeLabel.BackgroundTransparency = 0.5
        dunkingRangeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        dunkingRangeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        dunkingRangeLabel.TextScaled = true
        dunkingRangeLabel.Text = "Dunking Range!"
        dunkingRangeLabel.Visible = false
        dunkingRangeLabel.Parent = screenGui

        -- Find all goal parts in the workspace
        local function findGoals()
            for i, v in pairs(workspace:GetDescendants()) do
                if v.Name == 'Goal' then
                    v.Parent = workspace
                end
            end
        end

        -- Find the closest goal to a position
        local function findClosestPart(position)
            local closestPart, closestPartMagnitude
            local tmpMagnitude
            for i, v in pairs(workspace:GetChildren()) do
                if v.Name == 'Goal' then
                    tmpMagnitude = (position - v.Position).magnitude
                    if not closestPart or tmpMagnitude < closestPartMagnitude then
                        closestPart = v
                        closestPartMagnitude = tmpMagnitude
                    end
                end
            end
            return closestPart
        end

        local player = game.Players.LocalPlayer
        local camera = game.Workspace.CurrentCamera
        local character = player.Character
        local head = character.Head
        local torso = character.Torso
        findGoals()

        -- Smooth camera locking function
        local function cam()
            while wait(0.03) do  -- Faster updates
                if isdoing == true then
                    local pos = head.Position
                    local partyGoal = findClosestPart(head.Position)

                    if partyGoal then
                        local lookAt = partyGoal.Position + Vector3.new(0, 90, 0)  -- Adding some height offset
                        local cameraCFrame = CFrame.new(pos, lookAt)
                        Camera.CFrame = Camera.CFrame:Lerp(cameraCFrame, 0.2)  -- Smooth transition
                    end
                else
                    return nil
                end
            end
        end

        -- Update the status labels based on distance and ball status
        local function updateStatus()
            while true do
                wait(0.1)

                local lookthat = findClosestPart(game.Players.LocalPlayer.Character.Torso.Position)
                local pvm = (lookthat.Position - game.Players.LocalPlayer.Character.Torso.Position).magnitude

                if game.Players.LocalPlayer.Character:FindFirstChild("Basketball") then
                    noBallLabel.Visible = false
                    statusLabel.Visible = true
                    dunkingRangeLabel.Visible = false

                    -- Update status label based on distance ranges
                    if pvm >= 30 and pvm <= 44 then
                        statusLabel.Text = "In Range (30-44)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 45 and pvm <= 53 then
                        statusLabel.Text = "In Range (45-53)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 54 and pvm <= 66 then
                        statusLabel.Text = "In Range (54-66)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 67 and pvm <= 76 then
                        statusLabel.Text = "In Range (67-76)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 77 and pvm <= 84 then
                        statusLabel.Text = "In Range (77-84)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 85 and pvm <= 91 then
                        statusLabel.Text = "In Range (85-91)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    else
                        statusLabel.Text = "Not in Range"
                        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end

                    -- Show dunking range if close enough
                    if pvm <= 15 then
                        dunkingRangeLabel.Visible = true
                    end
                else
                    noBallLabel.Visible = true
                    statusLabel.Visible = false
                    dunkingRangeLabel.Visible = false
                end
            end
        end

        spawn(updateStatus)

        -- Start the camera lock when the player jumps
        game.Players.LocalPlayer.Character.ChildAdded:Connect(function(child)
            local pv = game.Players.LocalPlayer.Character.Basketball
            local UIS = game:GetService('UserInputService')

            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jumping:Connect(function()
                isdoing = true
                if game.Players.LocalPlayer.Character.Basketball then
                    local lookthat = findClosestPart(game.Players.LocalPlayer.Character.Torso.Position)
                    local pvm = (lookthat.Position - game.Players.LocalPlayer.Character.Torso.Position).magnitude

                    -- Set Power Value and update status based on range
                    if pvm >= 30 and pvm <= 44 then
                        pv.PowerValue.Value = 75
                        cam()
                    elseif pvm >= 45 and pvm <= 53 then
                        pv.PowerValue.Value = 80
                        cam()
                    elseif pvm >= 54 and pvm <= 66 then
                        pv.PowerValue.Value = 85
                        cam()
                    elseif pvm >= 67 and pvm <= 76 then
                        pv.PowerValue.Value = 90
                        cam()
                    elseif pvm >= 77 and pvm <= 84 then
                        pv.PowerValue.Value = 95
                        cam()
                    elseif pvm >= 85 and pvm <= 91 then
                        pv.PowerValue.Value = 100
                        cam()
                    end
                end
            end)
        end)

        -- Stop the camera lock on mouse click
        local UIS = game:GetService('UserInputService')
        UIS.InputBegan:Connect(function(l)
            if l.UserInputType == Enum.UserInputType.MouseButton1 then
                isdoing = false
            end
        end)

    end,
})
local Button = Tab:CreateButton({
    Name = "Snap YNC Camlock",
    Callback = function()
        local Player = game.Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        Holding = false
        e = false
        isdoing = false
        
        local screenGui = Instance.new("ScreenGui")
        screenGui.Parent = Player.PlayerGui
        
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(0, 200, 0, 50)
        statusLabel.Position = UDim2.new(0.5, -100, 0, 10)
        statusLabel.BackgroundTransparency = 0.5
        statusLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        statusLabel.TextScaled = true
        statusLabel.Text = "Not in Range"
        statusLabel.Parent = screenGui
        
        local noBallLabel = Instance.new("TextLabel")
        noBallLabel.Size = UDim2.new(0, 200, 0, 50)
        noBallLabel.Position = UDim2.new(0.5, -100, 0, 70)
        noBallLabel.BackgroundTransparency = 0.5
        noBallLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        noBallLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        noBallLabel.TextScaled = true
        noBallLabel.Text = "No Ball"
        noBallLabel.Parent = screenGui
        noBallLabel.Visible = true
        
        local dunkingRangeLabel = Instance.new("TextLabel")
        dunkingRangeLabel.Size = UDim2.new(0, 200, 0, 50)
        dunkingRangeLabel.Position = UDim2.new(0.5, -100, 0, 130)
        dunkingRangeLabel.BackgroundTransparency = 0.5
        dunkingRangeLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        dunkingRangeLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        dunkingRangeLabel.TextScaled = true
        dunkingRangeLabel.Text = "Dunking Range!"
        dunkingRangeLabel.Visible = false
        dunkingRangeLabel.Parent = screenGui
        
        function findGoals()
            for i, v in pairs(workspace:GetDescendants()) do
                if v.Name == 'Goal' then
                    v.Parent = workspace
                end
            end
        end
        
        local function findClosestPart(position)
            local closestPart, closestPartMagnitude
            local tmpMagnitude
            for i, v in pairs(workspace:GetChildren()) do
                if v.Name == 'Goal' then
                    if closestPart then
                        tmpMagnitude = (position - v.Position).magnitude
                        if tmpMagnitude < closestPartMagnitude then
                            closestPart = v
                            closestPartMagnitude = tmpMagnitude
                        end
                    else
                        closestPart = v
                        closestPartMagnitude = (position - v.Position).magnitude
                    end
                end
            end
            return closestPart
        end
        
        local player = game.Players.LocalPlayer
        local camera = game.Workspace.CurrentCamera
        local character = player.Character
        local head = character.Head
        local torso = character.Torso
        findGoals()
        
        local function cam()
            while wait() do
                if isdoing == true then
                    local pos = head.Position
                    local partyGoal = findClosestPart(head.Position)
                    local lookAt = partyGoal.Position + Vector3.new(0, 90, 0)
                    local mag = (character.PrimaryPart.Position - partyGoal.Position).magnitude
                    local cameraCFrame = CFrame.new(pos, lookAt)
                    Camera.CFrame = cameraCFrame
                else
                    return nil
                end
            end
        end
        
        local function updateStatus()
            while true do
                wait(0.1)
        
                local lookthat = findClosestPart(game.Players.LocalPlayer.Character.Torso.Position)
                local pvm = (lookthat.Position - game.Players.LocalPlayer.Character.Torso.Position).magnitude
        
                if game.Players.LocalPlayer.Character:FindFirstChild("Basketball") then
                    noBallLabel.Visible = false
                    statusLabel.Visible = true
                    dunkingRangeLabel.Visible = false
        
                    if pvm >= 30 and pvm <= 44 then
                        statusLabel.Text = "In Range (30-44)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 45 and pvm <= 53 then
                        statusLabel.Text = "In Range (45-53)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 54 and pvm <= 66 then
                        statusLabel.Text = "In Range (54-66)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 67 and pvm <= 76 then
                        statusLabel.Text = "In Range (67-76)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 77 and pvm <= 84 then
                        statusLabel.Text = "In Range (77-84)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif pvm >= 85 and pvm <= 91 then
                        statusLabel.Text = "In Range (85-91)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                    else
                        statusLabel.Text = "Not in Range"
                        statusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
        
                    if pvm <= 15 then
                        dunkingRangeLabel.Visible = true
                    end
                else
                    noBallLabel.Visible = true
                    statusLabel.Visible = false
                    dunkingRangeLabel.Visible = false
                end
            end
        end
        
        spawn(updateStatus)
        
        game.Players.LocalPlayer.Character.ChildAdded:Connect(function(child)
            local pv = game.Players.LocalPlayer.Character.Basketball
            local UIS = game:GetService('UserInputService')
        
            game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Jumping:Connect(function()
                isdoing = true
                if game.Players.LocalPlayer.Character.Basketball then
                    local lookthat = findClosestPart(game.Players.LocalPlayer.Character.Torso.Position)
                    local pvm = (lookthat.Position - game.Players.LocalPlayer.Character.Torso.Position).magnitude
        
                    if pvm >= 30 and pvm <= 44 then
                        statusLabel.Text = "In Range (30-44)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        pv.PowerValue.Value = 75
                        cam()
                    elseif pvm >= 45 and pvm <= 53 then
                        statusLabel.Text = "In Range (45-53)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        pv.PowerValue.Value = 80
                        cam()
                    elseif pvm >= 54 and pvm <= 66 then
                        statusLabel.Text = "In Range (54-66)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        pv.PowerValue.Value = 85
                        cam()
                    elseif pvm >= 67 and pvm <= 76 then
                        statusLabel.Text = "In Range (67-76)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        pv.PowerValue.Value = 90
                        cam()
                    elseif pvm >= 77 and pvm <= 84 then
                        statusLabel.Text = "In Range (77-84)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        pv.PowerValue.Value = 95
                        cam()
                    elseif pvm >= 85 and pvm <= 91 then
                        statusLabel.Text = "In Range (85-91)"
                        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        pv.PowerValue.Value = 100
                        cam()
                    end
                end
            end)
        end)
        
        local UIS = game:service('UserInputService')
        UIS.InputBegan:connect(function(l)
            if l.UserInputType == Enum.UserInputType.MouseButton1 then
                isdoing = false
            end
        end)
    end,
})
local Button = Tab:CreateButton({
    Name = "Reset",
    Callback = function()
        -- This script resets the player's character

local player = game.Players.LocalPlayer

-- Check if player exists and has a character
if player and player.Character then
    -- Destroy the player's character
    player.Character:BreakJoints()
end

    end,
})

-- Notification
local player = game.Players.LocalPlayer
local gui = game:GetService("StarterGui")

local function sendNotification()
    gui:SetCore("SendNotification", {
        Title = "YNC Scripts",
        Text = "This script was made by user. ANTI TRAVEL ENABLED ALR ITS BUGGY.",
        Duration = 5
    })
end

sendNotification()
