local s = game["G".."etS".."ervic".."e"]
local p = s(game, "Players")
local uis = s(game, "UserInputService")
local lp = p.LocalPlayer
local rs = s(game, "RunService")

local enabled = true
local keys = {"W", "A", "S", "D", "Space"}
local function fakeInput()
    if not enabled then return end
    local randomKey = keys[math.random(1, #keys)]
    uis.InputBegan:Fire(Enum.KeyCode[randomKey], false)
    wait(math.random(1, 3))
    uis.InputEnded:Fire(Enum.KeyCode[randomKey], false)
end

local function randomMovement()
    if not lp.Character then return end
    local hum = lp.Character:FindFirstChild("Humanoid")
    if hum then
        local moveVector = Vector3.new(math.random(-1, 1), 0, math.random(-1, 1))
        hum:Move(moveVector, true)
    end
end

local function preventAFK()
    while enabled do
        wait(math.random(10, 20)) -- Delay acak agar terlihat alami
        if math.random(1, 2) == 1 then
            fakeInput()
        else
            randomMovement()
        end
    end
end

-- GUI untuk ON/OFF
local gui = Instance.new("ScreenGui")
gui.Parent = lp:WaitForChild("PlayerGui")

local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 150, 0, 50)
btn.Position = UDim2.new(0.05, 0, 0.9, 0)
btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
btn.Text = "Anti-AFK: ON"
btn.Parent = gui

btn.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        btn.Text = "Anti-AFK: ON"
        preventAFK()
    else
        btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        btn.Text = "Anti-AFK: OFF"
    end
end)

preventAFK()
