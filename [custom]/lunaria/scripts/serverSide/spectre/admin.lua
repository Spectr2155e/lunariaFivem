RegisterCommand("bring", function(source, args)
    if args[1] then
        local result = getIdWithUuid(args[1])
        if result ~= nil then
            local location = GetEntityCoords(GetPlayerPed(source))
            local bringBack = GetEntityCoords(GetPlayerPed(result))
            setBringBack(result, bringBack)
            SetEntityCoords(result, location.x, location.y, location.z, true, false, false, true)
            TriggerClientEvent("sendNotification", source, "~g~Le joueur a été téléporté sur votre position.", 2000)
        else
            TriggerClientEvent("sendNotification", source, "~r~Veuillez préciser un uuid valide.", 2000)
        end
    else
        TriggerClientEvent("sendNotification", source, "~r~Veuillez préciser un uuid valide.", 2000)
    end
end)

RegisterCommand("back", function(source, args)
    if args[1] then
        local result = getIdWithUuid(args[1])
        if result ~= nil then
            local bringBack = getBringBack(result)
            if bringBack ~= nil then
                SetEntityCoords(result, bringBack[1], bringBack[2], bringBack[3], true, false, false, true)
                setBringBack(result, nil)
                TriggerClientEvent("sendNotification", source, "~g~Le joueur a été back à sa dernière position.", 2000)
            else
                TriggerClientEvent("sendNotification", source, "~r~Le joueur ne peux pas être back.", 2000)
            end
        else
            TriggerClientEvent("sendNotification", source, "~r~Veuillez préciser un uuid valide.", 2000)
        end
    else
        TriggerClientEvent("sendNotification", source, "~r~Veuillez préciser un uuid valide.", 2000)
    end
end)

RegisterCommand("report", function(source, args)
    if args[1] then
        if not getReportState(source) then
            setReportState(source, true)
            reason = table.concat(args, " ")
            createReport(source, reason)
            TriggerClientEvent("sendNotification", source, "~g~Report envoyé aux staffs veuillez attendre une réponse", 2000)
        else
            TriggerClientEvent("sendNotification", source, "~r~Vous ne pouvez pas créer un autre ticket.", 2000)
        end
    else
        TriggerClientEvent("sendNotification", source, "~r~Veuillez préciser une raison valide (Détaillez au plus le report).", 2000)
    end
end)

RegisterCommand("reportclaim", function(source, args)
    if args[1] then
        if getReport(args[1]) ~= nil then
            if getClaim(source) ~= nil then
                claimReport(source, args[1])
                TriggerClientEvent("sendNotification", source, "~g~Vous avez claim le ticket de l'uuid ~y~"..args[1].."~g~.", 2000)
            else
                TriggerClientEvent("sendNotification", source, "~r~Vous avez déjà claim un ticket, veuillez le fermer ou bien l'unclaim", 2000)
            end
        else
            TriggerClientEvent("sendNotification", source, "~r~Ce report n'existe pas.", 2000)
        end
    else
        TriggerClientEvent("sendNotification", source, "~r~Veuillez préciser un report.", 2000)
    end
end)
