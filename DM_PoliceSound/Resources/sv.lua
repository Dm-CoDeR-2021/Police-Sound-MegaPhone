DM = nil;
TriggerEvent(CONFIG.SharedObjectEvent, function(object)
    DM = object;
end);

DM.RegisterServerCallback('DM_SoundMenu:GetJob', function(src, callback)
    local dXp = DM.GetPlayerFromId(src);
    callback(dXp.job.name);
end);

RegisterServerEvent('DM_SoundMenu:StartSoundInDistance')
AddEventHandler('DM_SoundMenu:StartSoundInDistance', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('DM_SoundMenu:StatringClientSound', -1, source, maxDistance, soundFile, soundVolume);
end);
