-- Fifou

local function Notifiction(message)

    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)

end

function identification()
    local playerID = GetPlayerServerId(PlayerId())
    Notifiction(playerID)
end


RegisterCommand("arme", function(sources, args, rawCommand)

    local ped = PlayerPedId()

    local weaponName = args[1]
    local weaponHash = GetHashKey(weaponName)

    if args[1] ~= nil then
        if IsWeaponValid(weaponHash) then
            Notifiction("~g~Tenez votre " ..weaponName.. " !")
            GiveWeaponToPed(ped, weaponHash, 1000, false, true)
        else
            Notifiction("~r~La "..weaponName.." n'existe pas !")
        end
    else
        Notifiction("~y~Choisissez une arme !")
    end

    GiveWeaponToPed(ped, weaponHash, 1000, false, true)

end, false)


RegisterCommand("suicide", function(sources, args, rawCommand)

    local ped = PlayerPedId()

    SetEntityHealth(ped, 0)
    Notifiction("~r~Vous etes mort")


end, false)

RegisterCommand("monid", function(source, args, rawCommand)
    
    identification()
    
end, false)


RegisterCommand("money", function(source, args, rawCommand)

    TriggerServerEvent("getMoney", source, source)

end, false)

RegisterCommand("pos", function(sources, args, rawCommand)

    local ped = PlayerPedId()
    local playerPosition = GetEntityCoords(ped)

    Notifiction(playerPosition)

end, false)

RegisterCommand("tpspeactre", function(source, args)
    if args[1] then 
        print(args[1])
        test = GetEntityCoords(GetPlayerPed(args[1]))
        print(test.x)
        SetEntityCoords(source, test.x, test.y, test.z, true, false, false, true)
    else 
        Notifiction("sa")
    end
end)


































Citizen.CreateThread(function()

    while true do

        Citizen.Wait(0)

        if IsControlJustPressed(1, 166) then

            Notifiction("SALUT")
            menuF5()

        end

    end


end)



function menuF5()

    local menuTest = RageUI.CreateMenu("Titre","sous-titre")

    RageUI.Visible(menuTest, not RageUI.Visible(menuTest))

    while menuTest do
        
        Citizen.Wait(0)

        RageUI.IsVisible(menuTest,true,true,true,function()
        
            RageUI.ButtonWithStyle("Titre du bouton","Description", {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then    
                    print("J'ai appuyer sur le bouton")
                end
            end)  

            RageUI.Separator("TEST")

            RageUI.ButtonWithStyle("Titre du bouton",nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered, Active, Selected)
                if Selected then    
                end
            end)  

        
        end, function()
        end)

        if not RageUI.Visible(menuTest) then
            menuTest=RMenu:DeleteType("Titre", true)
        end

    end

end


