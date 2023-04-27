-- fonction Notification
function sendNotification(message)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end

function sendSubTitle(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message)
    EndTextCommandPrint(duration, true)
end