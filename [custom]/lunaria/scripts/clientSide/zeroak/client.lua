-- Zeroak
local blips = {
    
    {title="Fête Foraine", colour=69, id=266, x = -1602.98, y = -1044.529, z = 13.04562},
    {title="Aéroport",colour=15, id=90, x=1743.6820, y=3286.2510, z=40.087},
    {title="Tequil-La La",colour=15, id=93, x=-565.171, y=276.625, z=83.286},
    {title="comissariat",colour=38, id=60, x=444.9351, y=-983.6454, z=30.68958},
    {title="Franprix",colour= 66, id=52, x=-711.149, y=-911.7175, z=19.21559},
    {title="Franprix",colour= 66, id=52, x=-49.93649, y=-1753.362, z=29.42102},
    {title="Franprix",colour= 66, id=52, x=28.85352, y=-1344.926, z=29.49702},
    {title="Franprix",colour= 66, id=52, x=377.5115, y=328.1326, z=103.5664},
    {title="Franprix",colour= 66, id=52, x=-3042.81, y=588.6979, z=11.97413},
    {title="Franprix",colour= 66, id=52, x=-3244.928, y=1005.782, z=16.63542},
    {title="Franprix",colour= 66, id=52, x=-2968.759, y=388.1103, z=3127077},
    {title="Franprix",colour= 66, id=52, x=-1488.542, y=-379.9479, z=57.53136},
    {title="Franprix",colour= 66, id=52, x=-1217.167, y=-912.1155, z=32.70803},
    {title="Franprix",colour= 66, id=52, x=1962.167, y=3744.107, z=50.07772},
    {title="Franprix",colour= 66, id=52, x=1393.642, y=3601.976, z=48.41128},
    {title="base militaire",colour=0, id=419, x=-2371.25, y=3097.617, z=52.39176},
    {title="Franprix",colour= 66, id=52, x=1159.386, y=-323.2328, z=73.715166}
    
  
   }
  
  Citizen.CreateThread(function()
  
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
      end
  end)

  NetworkSetFriendlyFireOption(true)
  
  

  
  
  