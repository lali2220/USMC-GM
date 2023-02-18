/*
		RESPETA CREDITOS DEL CREADOR ° | ° Reinner - Lali2220
		Servidor echo para el clan USMC.
*/

#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <foreach>

#define COLOR_CRIMSON 		0xDC143CFF

new nombre[24];

enum
{
	RECLUTA_TEAM,
	INFANTERIA_TEAM,
	FUERZA_AEREA_TEAM
}

new gTeam[MAX_PLAYERS];
new gPlayerClass[MAX_PLAYERS];

main()
{
	print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
	print("                      GAMEMODE CARGADA EN EXITO!");
	print("                    SERVIDOR DE ENTRENAMIENTO USMC");
	print("||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||");
}


public OnPlayerConnect(playerid)
{
	USMCMessage(playerid, -1, "Bienvenido a los entrenamientos de USMC -2023");
	SetNameTagDrawDistance(8.0);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	switch(gTeam[playerid])
	{
		case RECLUTA_TEAM:
		{
			SetPlayerPos(playerid,     146.2042, 1913.8431, 18.8691);
			SetPlayerColor(playerid,   0xebedf0AA); // BLANCO
			SetPlayerSkin(playerid,    71);
		}
		case INFANTERIA_TEAM:
		{
			SetPlayerColor(playerid,   0xede900AA); // AMARILLO
			SetPlayerPos(playerid,     212.2924, 1920.3949, 17.6406);
			SetPlayerSkin(playerid,    287);
		}
		case FUERZA_AEREA_TEAM:
		{
			SetPlayerColor(playerid,   0xba0900AA); // ROJO
			SetPlayerPos(playerid,     -1396.7592, 504.7343, 3.0996);
			SetPlayerSkin(playerid,    255);
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(killerid != INVALID_PLAYER_ID)
	{
		SetPlayerScore(killerid,(GetPlayerScore(killerid))+1); //Esto da al asesino 1 punto de score.
		GivePlayerMoney(killerid, 1000);
		GameTextForPlayer(killerid, "~r~Abatido +1", 1000, 5);
		SendDeathMessage(killerid, reason, playerid);
	}
	GivePlayerMoney(playerid, 1000);
	GameTextForPlayer(playerid, "~r~Abatido", 1000, 0);
	return 1;
}


public OnPlayerRequestClass(playerid, classid)
{
	gPlayerClass[playerid] = classid;

	switch (classid)
	{
		case 0:
		{
			gTeam[playerid] = RECLUTA_TEAM;
			GameTextForPlayer(playerid, "~b~Recluta - MCRT", 2000, 5);//
		}
		case 1:
		{
			gTeam[playerid] = INFANTERIA_TEAM;
			GameTextForPlayer(playerid, "~b~Infanteria - USMC", 2000, 5);//
		}
		case 2:
		{
			gTeam[playerid] = FUERZA_AEREA_TEAM;
			GameTextForPlayer(playerid, "~b~Fuerza Aerea - MCA", 2000, 5);//
		}
	}
	SetPlayerPos(playerid, 1108.9287,-1413.3531,13.5839);
	SetPlayerFacingAngle(playerid, 4.9588);
	SetPlayerCameraPos(playerid, 1113.2992,-1407.1909,13.4056);
	SetPlayerCameraLookAt(playerid, 1108.9287,-1413.3531,13.5839);
	return 1;
}

public OnGameModeInit()
{
	SendRconCommand("hostname USMC | Servidor De Entrenamiento [Ultra-H.com]");
	SendRconCommand("mapname USA");
	SetGameModeText("USMC | SDP");
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_OFF);
	UsePlayerPedAnims();

	SendRconCommand("loadfs sytem-general");
	SendRconCommand("loadfs vehiculos");
	SendRconCommand("loadfs badmin");
	SendRconCommand("loadfs Rappel");
	SendRconCommand("loadfs CrearActors");
	SendRconCommand("loadfs Animaciones");
	SendRconCommand("loadfs maps");

			   // skin				    posiciones y angulo			armas y balas
	AddPlayerClass(71,  146.2042,   1913.8431,  18.8691,  4.7053,   0,0,0,0,0,0); // Recluta
	AddPlayerClass(287, 212.2924,   1920.3949,  17.6406,  176.9738, 0,0,0,0,0,0); // Infanteria
	AddPlayerClass(255,	2496.5444,	-1670.4746,	13.3359,  84.2291,	0,0,0,0,0,0); // Fuerza Aerea
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID) // Detecta si el que produce el daÃ±o es un jugador fÃ­sico.
	{
        if(weaponid > 21 && weaponid < 35) // Detecta si el daÃ±o es producido por un arma del ID 22 al ID 34 (armas de fuego).
 		{
		    PlayerPlaySound(issuerid, 17802, 0.0, 0.0, 0.0); // Reproduce el sonido ID 17802 al jugador que efectÃºa el disparo (issuerid).
        }
		else if( (weaponid == 34 || weaponid == 33) && bodypart == 9)
		{
			SetPlayerHealth(playerid, 0.0);
		}
	}
	return 1;
}



CMD:r(playerid, params[])
{
	if( isnull( params ) ) return SendClientMessage(playerid, COLOR_CRIMSON, "/r [MENSAJE - RADIO]");
	new text[128];
	if(sscanf(params, "s[128]", text)) SendClientMessage(playerid, COLOR_CRIMSON, "/r <texto>");

	GetPlayerName(playerid, nombre, 24);
	format(text, 128, "[RADIO] %s: %s", nombre, text);

	foreach(new i:Player)
	{
		if(gTeam[i] == gTeam[playerid] || GetPVarInt(playerid, "EscucharRadios") == 1 )
		{
			SendClientMessage(i, 0x09ff00AA, text);
		}
	}
	return 1;
}


stock USMCMessage(playerid, colorid, text[])
{
	new string[144];
	format(string, 144, "{ede900}[SDP - USMC] {FFFFFF}%s", text);
	SendClientMessage(playerid, colorid, string);
	return 1;
}

