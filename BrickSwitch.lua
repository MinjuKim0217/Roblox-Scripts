local timeControl = game.Lighting

local timeval=12
local brick=game.Workspace.ShiningBrick

while true do
  timeControl.ClockTime=timeval
  print(timeval)
  wait(2)
  
  if timeval==25 then
    timeval=0
    if timeval>18 then
      brick.Material='Neon'
     elseif timeval<7 then
      brick.Material='Neon'
     else
      brick.Material='Plastic'
 end
 
 timeval=timeval+1
 end
