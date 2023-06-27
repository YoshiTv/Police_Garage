ESX = exports["es_extended"]:getSharedObject()

TriggerEvent('gridsystem:registerMarker', {
	name = 'prendiveicolo',
    permission = Config.PoliceJobName,
	pos = Config.Garage,
	scale = vector3(2.0, 2.0, 2.0),
	size = vector3(3.2, 3.2, 3.2),
	msg = Config.msg,
	type = 36,
    show3D = Config.Show3D,
    color =  Config.ColorBlip,
    drawDistance = 38.0,
	control = Config.Control,
	action = function()
    local inveicolo = IsPedInAnyVehicle(PlayerPedId(), false)
    local bottondisabilited = false 
    if inveicolo then 
      bottondisabilited = false
    elseif not inveicolo then 
      bottondisabilited = true
    end
    lib.registerContext({
      id = 'menu',
      title = 'GARAGE POLIZIA',
      options = {
        {
          title = 'PARCHEGGIA VEICOLO', 
          description = 'Riponi il veicolo in Garage',         
          icon = Config.Icon.icon1,
          iconColor = 'orange',
          disabled = bottondisabilited,
          onSelect = function()
            depveicolo()
          end, 
        },
        {
          title = 'CLASSICO',        
          icon = Config.Icon.icon2,
          iconColor = 'orange',
          onSelect = function()
            spawnveicolo(Config.Nomeveicolo.veh1)
          end, 
        },
        {
          title = 'SUV',        
          icon = Config.Icon.icon3,
          iconColor = 'orange',
          onSelect = function()
            spawnveicolo(Config.Nomeveicolo.veh2)
          end, 
        },
        {
          title = 'BLINDATO',        
          icon = Config.Icon.icon4,
          iconColor = 'orange',
          onSelect = function()
            spawnveicolo(Config.Nomeveicolo.veh3)
          end, 
        },
      }
    })
    lib.showContext('menu')
  end
})
-------------------------------------------------------------------------------------------------
-------------------------------------- FUNZIONI GARAGE ------------------------------------------
-------------------------------------------------------------------------------------------------
function depveicolo()
  DeleteEntity(GetVehiclePedIsIn(PlayerPedId(), false))
  ESX.ShowNotification("Hai appena messo il veicolo Lavorativo in Garage")
end

function spawnveicolo(veicolo)
    if ESX.Game.IsSpawnPointClear(Config.SpawnVeicolo, 1) then
        ESX.Game.SpawnVehicle(veicolo, Config.SpawnVeicolo, 92.4997, function(vehicle)
            SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
            SetVehicleNumberPlateText(vehicle, Config.NameTarga)
            ESX.ShowNotification("Hai appena preso il tuo veicolo Lavorativo")
        end)
    else 
        ESX.ShowNotification("Il Posto è Occupato")
    end
end


