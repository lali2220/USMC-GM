/*
Hecho por camilo para San Andreas Free Roam
Tomado de otros filter script en ingles
No remover creditos
*/
#include <a_samp>

#define COLOR_AZUL 0x33CCFFAA
#define rojo 0xFF0000AA
#define COLOR_ROJO  0xFF000000
#define COLOR_AZUL 0x33CCFFAA
#define amarillo 0xFFFF0044
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define PocketMoney // Amount player recieves on spawn.
#define INACTIVE_PLAYER_ID 255
#define GIVECASH_DELAY // Time in ms between /givecash commands.

enum AutoPlayer
{
pCar
};

new AccInfo[MAX_PLAYERS][AutoPlayer];


forward CarSpawner(playerid,model);
forward ResAuto(vehicleid);
forward BorrarAuto(vehicleid);


ShowPlayerDefaultDialog( playerid )
{
	ShowPlayerDialog( playerid, 10, DIALOG_STYLE_LIST, "Vehiculos Disponibles", "Aviones\nHelicopteros\nMotos\nConvertibles\nIndustriales\nLowriders\nTodoterreno\nServicio Publico\nElegantes\nDeportivos\nVagones\nBarcos\nTrailers\nCarros Unicos\nRadio Control", "Aceptar", "Cancelar" );
	return 1;
}


public OnFilterScriptInit()
{
	printf( "Sistema de VEHICULO cargado!" );
	return 1;
}

public OnPlayerCommandText( playerid, cmdtext[] )
{
	new cmd[256];
	new idx;

	cmd = strtok(cmdtext, idx);

	if ( strcmp( cmdtext, "/v", true, 8 ) == 0 )
	{
		ShowPlayerDefaultDialog( playerid );
		return 1;
	}
	if(strcmp(cmd, "/pm", true) == 0 || strcmp(cmd, "/mp", true) == 0)
	{
       	new jugador, mensaje_a_playerid[256],mensaje_a_jugador[256],tmp1[256],tmp2[256],nombre_playerid[MAX_PLAYER_NAME],nombre_jugador[MAX_PLAYER_NAME];
        tmp1 = strtok(cmdtext, idx);
        tmp2 = strtok(cmdtext, idx);
   	    if(!strlen(tmp1) ||!SonNumeros(tmp1)||!strlen(tmp2)) return SendClientMessage(playerid, rojo, "USA: /mp [jugadorid] [mensaje] o /pm [jugadorid] [mensaje]");
		jugador = strval(tmp1);
		if(!IsPlayerConnected(jugador)) return SendClientMessage(playerid, rojo, "Ese jugador no se encuentra conectado.");
		else if(jugador == playerid) return SendClientMessage(playerid, rojo, "No puedes mandarte un MP a ti mismo.");
		else
		{
			GetPlayerName(playerid,nombre_playerid,sizeof(nombre_playerid));
			GetPlayerName(jugador,nombre_jugador,sizeof(nombre_jugador));
			format(mensaje_a_playerid,sizeof(mensaje_a_playerid),">>%s: %s",nombre_jugador,cmdtext[strlen(tmp1)+5]);
			SendClientMessage(playerid, amarillo, mensaje_a_playerid);
			printf(">>%s (%d) A %s (%d): %s",nombre_playerid,playerid,nombre_jugador,jugador,cmdtext[strlen(tmp1)+5]);
			format(mensaje_a_jugador,256,">> %s (%d): %s",nombre_playerid,playerid,cmdtext[strlen(tmp1)+5]);
			SendClientMessage(jugador, amarillo, mensaje_a_jugador);
		}
		return 1;
	}
	return 0;
}

public OnDialogResponse( playerid, dialogid, response, listitem, inputtext[] )
{
	if ( response )
	{
		switch ( dialogid )
		{
			case 10 :
			{
		    	switch ( listitem )
				{
					case 0 : ShowPlayerDialog( playerid, 11, DIALOG_STYLE_LIST, "Aviones", "Andromada\nAT-400\nBeagle\nCropduster\nDodo\nHydra\nNevada\nRustler\nShamal\nSkimmer\nStuntplane\nAtras", "Aceptar", "Cancelar" );
					case 1 : ShowPlayerDialog( playerid, 12, DIALOG_STYLE_LIST, "Helicopteros", "Cargobob\nHunter\nLeviathan\nMaverick\nMaverick SATV\nMaverick De Policia\nRaindance\nSeasparrow\nSparrow\nAtras", "Aceptar", "Cancelar" );
					case 2 : ShowPlayerDialog( playerid, 13, DIALOG_STYLE_LIST, "Motos", "BF-400\nBike\nBMX\nFaggio\nFCR-900\nFreeway\nMountain Bike\nNRG-500\nPCJ-600\nPizzaboy\nQuad\nSanchez\nWayfarer\nAtras", "Aceptar", "Cancelar" );
					case 3 : ShowPlayerDialog( playerid, 14, DIALOG_STYLE_LIST, "Convertibles", "Comet\nFeltzer\nStallion\nWindsor\nAtras", "Aceptar", "Cancelar" );
					case 4 : ShowPlayerDialog( playerid, 15, DIALOG_STYLE_LIST, "Industriales", "Benson\nBobcat\nBurrito\nBoxville\nBoxburg\nCement Truck\nDFT-30\nFlatbed\nLinerunner\nMule\nVan SATV\nPacker\nPetrol Tanker\nPony\nRoadtrain\nRumpo\nSadler\nSadler Shit\nTopfun\nTractor\nTrashmaster\nUtility Van\nWalton\nYankee\nYosemite\nAtras", "Aceptar", "Cancelar" );
					case 5 : ShowPlayerDialog( playerid, 16, DIALOG_STYLE_LIST, "Lowriders", "Blade\nBroadway\nRemington\nSavanna\nSlamvan\nTahoma\nTornado\nVoodoo\nAtras", "Aceptar", "Cancelar" );
					case 6 : ShowPlayerDialog( playerid, 17, DIALOG_STYLE_LIST, "Todoterreno", "Bandito\nBF Injection\nDune\nHuntley\nLandstalker\nMesa\nMonster\nMonster A\nMonster B\nPatriot\nRancher A\nRancher B\nSandking\nAtras", "Aceptar", "Cancelar" );
					case 7 : ShowPlayerDialog( playerid, 18, DIALOG_STYLE_LIST, "Servicio Publico", "Ambulancia\nBarracks\nBus\nCabbie\nCoach\nMoto Policia (HPV-1000)\nEnforcer\nFBI Rancher\nFBI Truck\nFiretruck\nFiretruck LA\nPatrulla (LSPD)\nPatrulla (LVPD)\nPatrulla (SFPD)\nRanger\nRhino\nS.W.A.T\nTaxi\nAtras", "Aceptar", "Cancelar" );
					case 8 : ShowPlayerDialog( playerid, 19, DIALOG_STYLE_LIST, "Elegantes", "Admiral\nBloodring Banger\nBravura\nBuccaneer\nCadrona\nClover\nElegant\nElegy\nEmperor\nEsperanto\nFortune\nGlendale Shit\nGlendale\nGreenwood\nHermes\nIntruder\nMajestic\nManana\nMerit\nNebula\nOceanic\nPicador\nPremier\nPrevion\nPrimo\nSentinel\nStafford\nSultan\nSunrise\nTampa\nVincent\nVirgo\nWillard\nWashington\nAtras", "Aceptar", "Cancelar" );
					case 9 : ShowPlayerDialog( playerid, 20, DIALOG_STYLE_LIST, "Deportivos", "Alpha\nBanshee\nBlista Compact\nBuffalo\nBullet\nCheetah\nClub\nEuros\nFlash\nHotring Racer\nHotring Racer A\nHotring Racer B\nInfernus\nJester\nPhoenix\nSabre\nSuper GT\nTurismo\nUranus\nZR-350\nAtras", "Aceptar", "Cancelar" );
					case 10 : ShowPlayerDialog( playerid, 21, DIALOG_STYLE_LIST, "Vagones", "Moonbeam\nPerenniel\nRegina\nSolair\nStratum\nAtras", "Aceptar", "Cancelar" );
					case 11 : ShowPlayerDialog( playerid, 22, DIALOG_STYLE_LIST, "Barcos", "Guardia Costera\nDinghy\nJetmax\nLaunch\nMarquis\nPredator\nReefer\nSpeeder\nSqualo\nTropic\nAtras", "Aceptar", "Cancelar" );
					case 12 : ShowPlayerDialog( playerid, 23, DIALOG_STYLE_LIST, "Trailers", "Article Trailer\nArticle Trailer 2\nArticle Trailer 3\nBaggage Trailer A\nBaggage Trailer B\nFarm Trailer\nFreight Flat Trailer (Train)\nFreight Box Trailer (Train)\nPetrol Trailer\nStreak Trailer (Train)\nStairs Trailer\nUtility Trailer\nAtras", "Aceptar", "Cancelar" );
					case 13 : ShowPlayerDialog( playerid, 24, DIALOG_STYLE_LIST, "Carros Unicos", "Baggage\nBrownstreak (Train)\nCaddy\nCamper\nCamper A\nCombine Harvester\nDozer\nDumper\nForklift\nFreight (Train)\nHotknife\nHustler\nHotdog\nKart\nMower\nMr Whoopee\nRomero\nSecuricar\nStretch\nSweeper\nTram\nTowtruck\nTug\nVortex\nAtras", "Aceptar", "Cancelar" );
					case 14 : ShowPlayerDialog( playerid, 25, DIALOG_STYLE_LIST, "Radio Control", "RC Bandit\nRC Baron\nRC Raider\nRC Goblin\nRC Tiger\nRC Cam\nAtras", "Aceptar", "Cancelar" );
				}
			}
			case 11 :
			{
				if ( listitem > 10 ) return ShowPlayerDefaultDialog( playerid );

   				new
      				modelo[] = { 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 12 :
			{
				if ( listitem > 8 ) return ShowPlayerDefaultDialog( playerid );

		        new
	    	        modelo[] = { 548, 425, 417, 487, 488, 497, 563, 447, 469 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 13 :
			{
				if ( listitem > 12 ) return ShowPlayerDefaultDialog( playerid );

				new
   					modelo[] = { 581, 509, 481, 462, 521, 463, 510, 522, 461, 448, 471, 468, 586 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 14 :
			{
				if ( listitem > 3 ) return ShowPlayerDefaultDialog( playerid );

   				new
					modelo[] = { 480, 533, 439, 555 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 15 :
			{
				if ( listitem > 24 ) return ShowPlayerDefaultDialog( playerid );

				new
			        modelo[] = { 499, 422, 482, 498, 609, 524, 578, 455, 403, 414, 582, 443, 514, 413, 515, 440, 543, 605, 459, 531, 408, 552, 478, 456, 554 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 16 :
			{
				if ( listitem > 7 ) return ShowPlayerDefaultDialog( playerid );

		        new
		            modelo[] = { 536, 575, 534, 567, 535, 566, 576, 412 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 17 :
			{
				if ( listitem > 12 ) return ShowPlayerDefaultDialog( playerid );

    			new
		    	    modelo[] = { 568, 424, 573, 579, 400, 500, 444, 556, 557, 470, 489, 505, 495 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 18 :
			{
				if ( listitem > 17 ) return ShowPlayerDefaultDialog( playerid );

				new
			        modelo[] = { 416, 433, 431, 438, 437, 523, 427, 490, 528, 407, 544, 596, 598, 597, 599, 432, 601, 420 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 19 :
			{
				if ( listitem > 33 ) return ShowPlayerDefaultDialog( playerid );

			    new
	        	    modelo[] = { 445, 504, 401, 518, 527, 542, 507, 562, 585, 419, 526, 604, 466, 492, 474, 546, 517, 410, 551, 516, 467, 600, 426, 436, 547, 405, 580, 560, 550, 549, 540, 491, 529, 421 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 20 :
			{
				if ( listitem > 19 ) return ShowPlayerDefaultDialog( playerid );

    			new
	        	    modelo[] = { 602, 429, 496, 402, 541, 415, 589, 587, 565, 494, 502, 503, 411, 559, 603, 475, 506, 451, 558, 477 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 21 :
			{
				if ( listitem > 4 ) return ShowPlayerDefaultDialog( playerid );

				new
			        modelo[] = { 418, 404, 479, 458, 561 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 22 :
			{
				if ( listitem > 9 ) return ShowPlayerDefaultDialog( playerid );

	    	    new
	        	    modelo[] = { 472, 473, 493, 595, 484, 430, 453, 452, 446, 454 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 23 :
			{
				if ( listitem > 11 ) return ShowPlayerDefaultDialog( playerid );

		        new
		            modelo[] = { 435, 450, 591, 606, 607, 610, 569, 590, 584, 570, 608, 611 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 24 :
			{
				if ( listitem > 23 ) return ShowPlayerDefaultDialog( playerid );

	    	    new
	        	    modelo[] = { 485, 537, 457, 483, 508, 532, 486, 406, 530, 538, 434, 545, 588, 571, 572, 423, 442, 428, 409, 574, 449, 525, 583, 539 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
			case 25 :
			{
				if ( listitem > 5 ) return ShowPlayerDefaultDialog( playerid );

	    	    new
	        	    modelo[] = { 441, 464, 465, 501, 564, 594 };

				return CarSpawner( playerid, modelo[ listitem ] );
			}
		}
	}
	return 0;
}

//====================================================================================================

public OnPlayerConnect(playerid)
{
	AccInfo[playerid][pCar]			= -1;
	return 1;
}

public OnPlayerDisconnect(playerid)
{
if(AccInfo[playerid][pCar] != -1) BorrarAuto(AccInfo[playerid][pCar]);
return 1;
}
//=============================================NUEVA FUNCION===============================================
public CarSpawner(playerid,model)
{
	if(IsPlayerInAnyVehicle(playerid))
	SendClientMessage(playerid, rojo, "ERROR: Ya Estas En Un Auto!");
	else
	{
	    new Float:x, Float:y, Float:z, Float:angle;
		GetPlayerPos(playerid, x, y, z);
	 	GetPlayerFacingAngle(playerid, angle);

		if(AccInfo[playerid][pCar] != -1)
		BorrarAuto(AccInfo[playerid][pCar]);
	    new vehicleid=CreateVehicle(model, x, y, z+2, angle, -1, -1, -1);
		PutPlayerInVehicle(playerid, vehicleid, 0);
		SetVehicleVirtualWorld(vehicleid, GetPlayerVirtualWorld(playerid));
		LinkVehicleToInterior(vehicleid, GetPlayerInterior(playerid));
        AccInfo[playerid][pCar] = vehicleid;
	}
	return 1;
}


public BorrarAuto(vehicleid)
{
    for(new i=0;i<MAX_PLAYERS;i++)
	{
        new Float:X,Float:Y,Float:Z;
    	if(IsPlayerInVehicle(i, vehicleid))
		{
  		RemovePlayerFromVehicle(i);
  		GetPlayerPos(i,X,Y,Z);
 		SetPlayerPos(i,X,Y+3,Z);
	    }
	    SetVehicleParamsForPlayer(vehicleid,i,0,1);
	}
    SetTimerEx("ResAuto",1500,0,"i",vehicleid);
}
public ResAuto(vehicleid)
{
    DestroyVehicle(vehicleid);
}

public OnVehicleSpawn(vehicleid)
{
	for(new i=0;i<MAX_PLAYERS;i++)
	{
        if(vehicleid==AccInfo[i][pCar])
		{
		    BorrarAuto(vehicleid);
	        AccInfo[i][pCar]=-1;
        }
	}
	return 1;
}

stock SonNumeros(string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}