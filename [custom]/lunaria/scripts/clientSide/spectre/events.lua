RegisterNetEvent("giveAllWeapons")
AddEventHandler("giveAllWeapons", function(source)
    local ped = PlayerPedId()
    local weaponslist = {
        "weapon_dagger",
        "weapon_smg",
        "weapon_hammer",
        "weapon_bat",
        "weapon_machete",
        "weapon_pistol",
        "weapon_pistol_mk2",
        "weapon_stungun",
        "weapon_snspistol",
        "weapon_heavypistol",
        "weapon_raypistol",
        "weapon_ceramicpistol",
        "weapon_stungun_mp",
        "weapon_microsmg",
        "weapon_smg_mk2",
        "weapon_assaultsmg",
        "weapon_combatpdw",
        "weapon_machinepistol",
        "weapon_minismg",
        "weapon_raycarbine",
        "weapon_pumpshotgun",
        "weapon_pumpshotgun_mk2",
        "weapon_heavyshotgun",
        "weapon_assaultrifle",
        "weapon_assaultrifle_mk2",
        "weapon_carbinerifle_mk2",
        "weapon_carbinerifle",
        "weapon_advancedrifle",
        "weapon_specialcarbine",
        "weapon_specialcarbine_mk2",
        "weapon_bullpuprifle",
        "weapon_compactrifle",
        "weapon_heavyrifle",
        "weapon_tacticalrifle",
        "weapon_gusenberg",
        "weapon_mg",
        "weapon_sniperrifle",
        "weapon_heavysniper",
        "weapon_heavysniper_mk2",
        "weapon_precisionrifle",
        "weapon_rpg",
        "weapon_grenadelauncher",
        "weapon_minigun",
        "weapon_firework",
        "weapon_hominglauncher",
        "weapon_grenade",
        "weapon_bzgas",
        "weapon_molotov",
        "weapon_stickybomb",
        "weapon_proxmine",
        "weapon_pipebomb",
        "weapon_smokegrenade",
        "weapon_petrolcan",
        "weapon_hazardcan",
        "weapon_fertilizercan",
    }
    for k,v in pairs(weaponslist) do
        GiveWeaponToPed(ped, GetHashKey(v), 1000, false, true)
    end
end)

RegisterNetEvent("sendNotification")
AddEventHandler("sendNotification", function(message, duration)
    sendSubTitle(message, duration)
end)

RegisterNetEvent("output")
AddEventHandler("output", function()
    TriggerEvent("chatMessage", "TEST3")
end)

RegisterNetEvent("teleportLastPos")
AddEventHandler("teleportLastPos", function(x, y, z)
    StartPlayerTeleport(PlayerId(), x, y, z, 0.0, false, false, true)
end)

AddEventHandler("playerSpawned", function()
    TriggerServerEvent("Lunaria:SpawnPlayer")
end)

RegisterCommand("sync", function(source)
    TriggerServerEvent("Lunaria:saveUser", source)
    TriggerEvent("chatMessage", "~g~✓ Synchronisation effectué avec succès !")
end)