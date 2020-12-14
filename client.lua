PlayerData = {}

local done = false

ESX = nil
 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    done = true
end)


local blips = {
    -- Example {title="", colour=, id=, x=, y=, z=},

    {title="Makelaar", colour=5, id=475, x = -829.52, y = 173.25, z = 70.51},
    {title="Mcdonalds", colour=46, id=383, x = 270.09, y = -962.66, z = 29.29},
  }
      
local mafiablips = {
    {title="Mafia", colour=24, id=419, x = -1526.36, y = 90.74, z = 56.55},

}

-- General blips
Citizen.CreateThread(function()
  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 1.0)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)

-- Mafia
Citizen.CreateThread(function() 
  while not done do
      Citizen.Wait(10)
  end
  if PlayerData.job.name == 'mafia' then 
      for _, info in pairs(mafiablips) do 
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 1.0)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    done = true
  end
end
end)

