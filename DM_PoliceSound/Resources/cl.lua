DM = nil;
CreateThread(function()
    while true do
        Wait(0);
        TriggerEvent(CONFIG.SharedObjectEvent, function(object)
            DM = object;
        end);
    end;
end);

CreateThread(function()
    while true do
	Wait(0);
        local ped = PlayerPedId();
        if (IsControlJustPressed(0, 56)) then
            if (IsPedInAnyVehicle(ped)) then
                DM.TriggerServerCallback('DM_SoundMenu:GetJob', function(job)
                    for u = 1, #CONFIG.Jobs do
                        for o = 1, #CONFIG.Vehicles do
                            if (job == CONFIG.Jobs[u]) then
                                if (IsVehicleModel(GetVehiclePedIsIn(ped),GetHashKey(CONFIG.Vehicles[o]))) then
                                    OpenSoundMenu(job);
                                else
                                    DM.ShowNotification('~r~In Mashin Dar List Mashin Haye Bolandgu Dar Nist!')
                                end;
                            end;
                        end;
                    end;
		        end);
            end;
        end;
    end;
end);


OpenSoundMenu = function(job)
    DM.UI.Menu.CloseAll();
    local menus = CONFIG.SoundMenu;
    local dm = {};
    for m = 1, #menus do
        table.insert(dm,{label = menus[m].name, value = menus[m].soundFile});
        DM.UI.Menu.Open('default',GetCurrentResourceName(),'sound_menu',{
            title = 'Warning Sounds',
            align = 'top-left',
            elements = dm,
        },function(d,m)
            TriggerServerEvent('DM_SoundMenu:StartSoundInDistance',31.3,d.current.value,6.0);
        end,function(d,m)
            m.close();
        end);
    end;
end;

RegisterNetEvent('DM_SoundMenu:StatringClientSound')
AddEventHandler('DM_SoundMenu:StatringClientSound', function(playerNetId, maxDistance, soundFile, soundVolume)
    local lCoords = GetEntityCoords(GetPlayerPed(-1));
    local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)));
    local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z);
    if (distIs <= maxDistance) then
        SendNUIMessage({
            transactionType     = 'playSound',
            transactionFile     = soundFile,
            transactionVolume   = soundVolume
        });
    end
end)