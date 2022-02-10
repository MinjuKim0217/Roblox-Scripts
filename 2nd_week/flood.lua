ServerScriptService 스크립트--
local gamePlayers = game:GetService("Players")
local runService = game:GetService("RunService")

local map = workspace.Map
local water = map.Water

local start = game.Workspace.Map.Start
local stop = game.Workspace.Map.Stop

local watereffect = true

local function start_water()	
	wait(5)
	--move water
	local startPosition = Vector3.new(0, 0, 0)
	local waterX, waterZ = water.Size.X / 2, water.Size.Z / 2
	local waterHeight = 0

	spawn(function()
		local finishHeight = 65

		water.Position = startPosition

		local startTime = tick()
		while true do
			waterHeight = (tick() - startTime) * 5

			if waterHeight >= finishHeight or watereffect == false then
				break
			end

			water.Size = Vector3.new(55, waterHeight, 55)
			water.Position = startPosition + Vector3.new(0, waterHeight / 2, 0)

			runService.Heartbeat:Wait()
		end
	end)

	while true do
		for _,player in next, gamePlayers:GetPlayers() do
			if player.Character then
				local root = player.Character:FindFirstChild("HumanoidRootPart")
				if root then
					if root.Position.Y <= startPosition.Y + waterHeight and root.Position.X >= startPosition.X - waterX and root.Position.X <= startPosition.X + waterX and root.Position.Z >= startPosition.Z - waterZ and root.Position.Z <= startPosition.Z + waterZ then						
						local human = player.Character:FindFirstChildOfClass("Humanoid")
						if human then						
							human:TakeDamage(20)
						end
					end
				end
			end
		end

		wait(1)
	end
end

local function stop_water()	
	watereffect = false
end

start.Touched:Connect(start_water)
stop.Touched:Connect(stop_water)
Timer 스크립트--
local start = game.Workspace.Map.Start
local stop = game.Workspace.Map.Stop

local time_val = 40
local timer_started = false
local completed = false

local time_label = script.Parent
time_label.Visible = false

local LPlayer = game.Players.LocalPlayer

local function start_timer(otherPart)
	local player = game.Players:FindFirstChild(otherPart.Parent.Name)
	if player.Name == LPlayer.Name and not timer_started then
		timer_started = true		
		time_label.Text = time_val
		player.PlayerGui.Timer.Label.Visible = true
		local time_num = tonumber(player.PlayerGui.Timer.Label.Text)
		while time_num > 0 do
			wait(1)
			time_num = time_num - 1
			player.PlayerGui.Timer.Label.Text = tostring(time_num)
		end
		if not completed then
			player.PlayerGui.Timer.Label.Visible = false
			player.Character.Humanoid.Health = 0
		end
		timer_started = false
		completed = false
		player.PlayerGui.Timer.Label.Text = time_val
	end
end

local function finish_timer(otherPart)
	local player = game.Players:FindFirstChild(otherPart.Parent.Name)	
	if player.Name == LPlayer.Name then
		player.PlayerGui.Timer.Label.Visible = false		
		completed = true
	end
end

start.Touched:Connect(start_timer)
stop.Touched:Connect(finish_timer)
