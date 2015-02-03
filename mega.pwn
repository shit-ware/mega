//MEGA.pwn
//THE MEGA FILTERSCRIPT
//Made to bypass script limit
//TODO: Maybe make "id" global

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#define GOD_SQUAD "YOU ARE NOT PART OF THE GOD SQUAD"
new IsInGod[MAX_PLAYERS];

new skin[MAX_PLAYERS];
new slut[MAX_PLAYERS];
new constSkin[MAX_PLAYERS];
new isGod[MAX_PLAYERS];

public OnPlayerDisconnect(playerid,reason)
{
	IsInGod[playerid] = 0;
	isGod[playerid] = 0;
	//security fixes
	return 1;
}

COMMAND:jp(playerid, params[])
{
	new id;
	
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not an admin.");
	}
	else
	{
	    if(sscanf(params,"i", id))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/jp [id]");
		}
		
		SetPlayerSpecialAction(id,2);
		return 1;
	}
}

CMD:give(playerid, params[])
{
	new gun;
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not admin.");
	}
	else
	{
	    if(sscanf(params,"i",gun))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/give [id]");
		}
		
		if(gun>47||gun<1)
		{
			return SendClientMessage(playerid, 0xFFFFFF, "IDs: 1-47");
		}
		
		GivePlayerWeapon(playerid, gun, 9999);
		return 1;
	}

}

COMMAND:god(playerid, params[])
{
    if(IsPlayerAdmin(playerid))
    {
        if(IsInGod[playerid] == 0)
        {
            IsInGod[playerid] = 1;
            SetPlayerHealth(playerid, 999);
        	SendClientMessage(playerid, 0xFFFFFF, "You are now ready to slay minorities.");
		}
		else if(IsInGod[playerid] == 1)
        {
            IsInGod[playerid] = 0;
            SetPlayerHealth(playerid, 100);
        	SendClientMessage(playerid, 0xFFFFFF, "Minorities can now kill you");
		}

    }
    else SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	return 1;
}

COMMAND:rpg(playerid)
{
//this command has now been deemed "legacy" 
	if(!IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	    return 0;
	}
	else
	{
	    GivePlayerWeapon(playerid, 35, 9999);
	    SendClientMessage(playerid, 0xFFFFFF, "u got an RPG fgt");
	    return 1;
	}
}

COMMAND:money(playerid)
{
	if(!IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	    return 0;
	    }
	    
	    else
	    {
	        GivePlayerMoney(playerid, 1000000000);
	        SendClientMessage(playerid, 0xFFFFFF, "u rollin liek a tril niga nao");
	        return 1;
	        }
}

COMMAND:heal(playerid)
{
	if(!IsPlayerAdmin(playerid))
	{
	    SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	    return 0;
	    }
	    else
	    {
	        SetPlayerHealth(playerid,100);
	        SetPlayerArmour(playerid, 100);
	        SendClientMessage(playerid, 0xFFFFFF, "u rolin deep nao sun");
	        return 1;
	        }
}

COMMAND:kick(playerid, params[])
{
	new target;
	
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not an admin.");
	}
	else
	{
	    if(sscanf(params,"i",target))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/kick [id]");
		}
		
		Kick(target);
		return 1;
	}
}

CMD:kill(playerid, params[])
{
	new id;
	new reason[512];
	new real_reason[512];
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not an admin.");
	}
	else
	{
	    if(sscanf(params, "is", id, real_reason))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/kill [id] [reason]");
		}
		
		if(!IsPlayerConnected(id))
		{
		    return SendClientMessage(playerid, 0xFFFFFF, "Player not connected.");
		}
		
		SetPlayerHealth(id, 0);
		//SendClientMessageToAll(0xFFFFFF, reason);
		format(reason,sizeof(reason),"%s killed %s because: %s", ReturnPlayerName(playerid),ReturnPlayerName(id),real_reason);
		SendClientMessageToAll(0xFFFFFF,reason);
		return 1;
	}
	
}

ReturnPlayerName(playerid)
{
	new name[MAX_PLAYER_NAME];
	
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

public OnPlayerUpdate(playerid)
{
	if(slut[playerid] == 1)
	{
	    new gun;
	    gun = GetPlayerWeapon(playerid);
	    if(gun != 10)
	    {
	        ResetPlayerWeapons(playerid);
	        GivePlayerWeapon(playerid, 10, 999);
			return 1;
	    }
	}
	
	if(isGod[playerid] == 1)
	{
	    SetVehicleHealth(GetPlayerVehicleID(playerid),999);
	    RepairVehicle(GetPlayerVehicleID(playerid));
	    return 1;
	}
	
	if(IsInGod[playerid] == 1) SetPlayerHealth(playerid, 999);
	
	return 1;
}

public OnPlayerDeath(playerid, killerid,reason)
{
	if(slut[playerid] == 1)
	{
		slut[playerid] = 0;
		return 1;
	}
	
	if(IsInGod[playerid] == 1)
	{
	    IsInGod[playerid] = 0;
	    SendClientMessage(playerid, 0xFFFFFF, "God mode disabled.");
	    return 1;
	    //added because this breaks it for some reason
	}
	return 1;
}

COMMAND:cargod(playerid)
{
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not an admin.");
	}
	else
	{
	    if(IsPlayerInAnyVehicle(playerid))
	    {
	    	if(isGod[playerid] == 0)
	    	{
	        	isGod[playerid] = 1;
	        	RepairVehicle(GetPlayerVehicleID(playerid));
	        	SetVehicleHealth(GetPlayerVehicleID(playerid), 999);
	        	SendClientMessage(playerid, 0xFFFFFF, "Car god mode is on.");
		 		return 1;
	    	}
	    	else if(isGod[playerid] == 1)
	    	{
	        	isGod[playerid] = 0;
	        	SetVehicleHealth(GetPlayerVehicleID(playerid),100);
	        	SendClientMessage(playerid, 0xFFFFFF, "Car god mode is off.");
	        	return 1;
			}
	    }
	    else
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "Not in a vehicle.");
  		}
	}
	return 0;
}

COMMAND:clearcar(playerid)
{
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF,GOD_SQUAD);
	}
	else
	{
	    for(new veh;veh < MAX_VEHICLES; veh++)
	    {
	        DestroyVehicle(veh);
		}
		SendClientMessage(playerid, 0xFFFFFF, "Cars removed.");
	}
	return 1;
}

COMMAND:respawn(playerid)
{
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	}
	else
	{
	    for(new veh;veh<MAX_VEHICLES;veh++)
	    {
	        SetVehicleToRespawn(veh);
		}
	}
	return 1;
}

//annoying commands go here

COMMAND:setdrunk(playerid, params[])
{
	new id;
	
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	}
	else
	{
	    if(sscanf(params,"i",id))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/setdrunk [id]");
	    }
	    
	    ApplyAnimation(id, "PED", "WALK_DRUNK", 4.1, 1, 1, 1, 1, 1, 1);
	    return 1;
	}
}

COMMAND:insult(playerid, params[])
{
	new id;
	new insult[512];
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not an admin.");
	}
	else
	{
	    if(sscanf(params,"is",id,insult))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/insult [id] [insult]");
		}

		SendPlayerMessageToAll(id,insult);
		return 1;
	}
}

COMMAND:slut(playerid, params[])
{
	new id;
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, "Not an admin.");
	}
	else
	{
	    if(sscanf(params,"i",id))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/slut [id]");
		}

		if(slut[id]==0)
		{
		    slut[id] = 1;
		    constSkin[id] = GetPlayerSkin(id);
			ResetPlayerWeapons(id);
			GivePlayerWeapon(id,10,999);
			SetPlayerSkin(id,63);
			skin[id] = 63;
		}
		else if(slut[id]==1)
		{
		    slut[id] = 0;
		    SetPlayerSkin(id,constSkin[id]);
		    return 1;
		}

	}
	return 1;
}

COMMAND:freeze(playerid, params[])
{
	new id;
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	}
	else
	{
	    if(sscanf(params, "i", id))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/freeze [id]");
		}
		
		TogglePlayerControllable(id, 0);
		return 1;
	}
}

COMMAND:unfreeze(playerid, params[])
{
	new id;
	if(!IsPlayerAdmin(playerid))
	{
	    return SendClientMessage(playerid, 0xFFFFFF, GOD_SQUAD);
	}
	else
	{
	    if(sscanf(params, "i", id))
	    {
	        return SendClientMessage(playerid, 0xFFFFFF, "/unfreeze [id]");
		}

		TogglePlayerControllable(id, 1);
		return 1;
	}
}

//end annoying commands
