ServerScriptService 스크립트--
local replicatedStorage = game:GetService("ReplicatedStorage")
local placeStructure = replicatedStorage:WaitForChild("RemoteFunction")
local structures = replicatedStorage:WaitForChild("Structures")

placeStructure.OnServerInvoke = function(player, structureName, structureCFrame)		
	local realStructure = structures:FindFirstChild(structureName):Clone()

	if realStructure then
		realStructure.CFrame = structureCFrame
		realStructure.Parent = game.Workspace
		return true		
	else
		return false
	end	
end
localscript 스크립트--
local replicatedStorage = game:GetService("ReplicatedStorage")
local placeStructure = replicatedStorage:WaitForChild("RemoteFunction")
local structures = replicatedStorage:WaitForChild("Structures")

local uis = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):wait()

local frame = script.Parent.Frame
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

local mouse = player:GetMouse()

local yBuildingOffset = 5
local maxPlacingDistance = 50
local rKeyIsPressed = false
local placingStructure = false

local placedStructure		
local yOrientation = 0

for _, structureButton in pairs (frame:GetChildren()) do

	if structureButton:IsA("TextButton") then		
		structureButton.MouseButton1Up:connect(function()
			frame.Visible = false			

			if placingStructure == false then
				placingStructure = true

				clientStructure = structures:FindFirstChild(structureButton.Name):Clone()				
				clientStructure.CanCollide = false
				clientStructure.Parent = game.Workspace

				local startingCFrame = CFrame.new(0, -2, -1)
				clientStructure.CFrame = humanoidRootPart.CFrame:ToWorldSpace(startingCFrame)

				runService.RenderStepped:Connect(function()								
					local mouseRay = mouse.UnitRay
					local castRay = Ray.new(mouseRay.Origin, mouseRay.Direction * 1000)
					local ignoreList = {clientStructure, player}
					local hit, position = workspace:FindPartOnRayWithIgnoreList(castRay, ignoreList)

					local newAnglesCFrame = CFrame.Angles(0, math.rad(yOrientation), 0)
					local newCFrame = CFrame.new(position.X, position.Y + yBuildingOffset, position.Z)
					clientStructure.CFrame = newCFrame * newAnglesCFrame

				end)	

				uis.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.R then
						rKeyIsPressed = true

						local rotationSpeed = 5
						while rKeyIsPressed do
							wait()
							yOrientation = yOrientation + rotationSpeed
						end		
					end	
				end)

				uis.InputEnded:Connect(function(input)	
					if input.KeyCode == Enum.KeyCode.R then						
						rKeyIsPressed = false 
					end
				end)
			end				
		end)		
	end
end

uis.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 and placingStructure then 		
		local structureCFrame = clientStructure.CFrame
		placedStructure = placeStructure:InvokeServer(clientStructure.Name, structureCFrame)

		if placedStructure == true then
			placingStructure = false
			clientStructure:Destroy()
			frame.Visible = true
		end	
	end	
end)


uis.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.E then		
		if mouse.Target and string.match(mouse.Target.Name, "(.*)Block") then
			mouse.Target:Destroy()
		end
	end	
end)
