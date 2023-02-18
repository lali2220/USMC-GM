#include <a_samp>
#include <zcmd>
#include <sscanf2>

enum
{
	DIALOGO_CREDITOS,
	DIALOG_EQUIPAR
}

public OnFilterScriptInit()
{
	print("Sistema de COMANDO GENERALES cargado!");
	return 1;
}

CMD:skin(playerid, params[])
{
    new skin;
    if (sscanf(params, "d", skin)) return SendClientMessage(playerid, -1, "Utiliza /skin (id skin)");
    SetPlayerSkin(playerid, skin);
    USMCMessage(playerid, -1, "Te acabas de cambiar de skin!");
    return 1;
}

CMD:kill(playerid, params[])
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:sandstorm(playerid, params[])
{
	SetPlayerWeather(playerid, 19);
	return 1;
}

CMD:lluvia(playerid, params[])
{
	SetPlayerWeather(playerid, 8);
	return 1;
}

CMD:neblina(playerid, params[])
{
	SetPlayerWeather(playerid, 9);
	return 1;
}

CMD:dia(playerid, params)
{
	SetPlayerTime(playerid, 10, 0);
	USMCMessage(playerid, -1, "Has puesto de dia");
	return 1;
}

CMD:noche(playerid, params)
{
	SetPlayerTime(playerid, 0, 0);
	USMCMessage(playerid, -1, "Has puesto de noche");
	return 1;
}

CMD:anochecer(playerid, params)
{
	SetPlayerTime(playerid, 20, 0);
	USMCMessage(playerid, -1, "Has puesto la hora en el anochecer");
	return 1;
}

CMD:amanecer(playerid, params)
{
	SetPlayerTime(playerid, 5, 30);
	USMCMessage(playerid, -1, "Has puesto la hora en el amanecer");
	return 1;
}

CMD:negro (playerid, params)
{
   SetPlayerColor(playerid, 0x000000FF);
   USMCMessage(playerid, -1, "Tu nuevo color es negro");
   return 1;
}

CMD:azul(playerid, params)
{
   SetPlayerColor(playerid, 0x0000FFFF);
   USMCMessage(playerid, -1, "Tu nuevo color es azul");
   return 1;
}

CMD:verde(playerid, params)
{
   SetPlayerColor(playerid, 0x006900FF);
   USMCMessage(playerid, -1, "Tu nuevo color es verde");
   return 1;
}

CMD:amarillo(playerid, params)
{
   SetPlayerColor(playerid, 0xFFFF00AA);
   USMCMessage(playerid, -1, "Tu nuevo color es amarillo");
   return 1;
}


CMD:rojo(playerid, params)
{
   SetPlayerColor(playerid, 0xFF000044);
   USMCMessage(playerid, -1, "Tu nuevo color es rojo");
   return 1;
}

CMD:creditos(playerid, params[])
{
	return ShowPlayerDialog(playerid, DIALOGO_CREDITOS, DIALOG_STYLE_MSGBOX, "Creditos", "Reinner", "Cerrar", "");
}

CMD:equipar(playerid, params[])
{
	new str[274+1];
	format(str, sizeof(str), "%sVida\nChaleco\nPistola 9mm\nTaser\nDesert Eagle\nEscopeta\nEscopeta de goma\nEscopeta recortada\nUzi\nMP5\nAK47\nM4\nTec4\nParacaidas\nSniper\nEDC\nRifle de caza\nPorra\nCuchillo\nBate\nSpray\nExtintor\nGranada explosiva\nMolotov\nGas lacrimogeno\nExplosivo\nDetonador\nCamara", str);
	ShowPlayerDialog(playerid, DIALOG_EQUIPAR, DIALOG_STYLE_LIST, "Equipar", str, "Coger", "Salir");
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_EQUIPAR)
    {
        if(response)
        {
            switch(listitem)
            {
				case 0: //Vida
				{
                    SetPlayerHealth(playerid, 100);
                    USMCMessage(playerid, -1, "Usted se acaba de llenar de su vida");
				}
				case 1: //Chaleco
				{
                    SetPlayerArmour(playerid, 50);
                    USMCMessage(playerid, -1, "Usted se acaba de llenar su chaleco");
				}
				case 2: //9mm
				{
                    GivePlayerWeapon(playerid, 22 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un 9mm");
				}
				case 3: //Taser
				{
                    GivePlayerWeapon(playerid, 23 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un taser");
				}
				case 4: //Desert
				{
                    GivePlayerWeapon(playerid, 24 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un desert");
				}
				case 5: //Escopeta
				{
                    GivePlayerWeapon(playerid, 25 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un escopeta");
				}
				case 6: //Escopeta de goma
				{
                    GivePlayerWeapon(playerid, 27 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un escopeta de goma");
				}
				case 7: //Escopeta recortada
				{
                    GivePlayerWeapon(playerid, 26 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un escopeta recortada");
				}
				case 8: //Uzi
				{
                    GivePlayerWeapon(playerid, 28 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un uzi");
				}
				case 9: //MP5
				{
                    GivePlayerWeapon(playerid, 29 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un mp5");
				}
				case 10: //AK47
				{
                    GivePlayerWeapon(playerid, 30 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un ak47");
				}
				case 11: //M4
				{
                    GivePlayerWeapon(playerid, 31 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un m4");
				}
				case 12: //tec9
				{
                    GivePlayerWeapon(playerid, 32 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un tec9");
				}
				case 13: //Paracaidas
				{
                    GivePlayerWeapon(playerid, 46 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un paracaidas");
				}
				case 14: //Sniper
				{
                    GivePlayerWeapon(playerid, 34 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un sniper");
				}
				case 15: //EDC
				{
                    GivePlayerWeapon(playerid, 27 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un edc");
				}
				case 16: //Rifle de caza
				{
                    GivePlayerWeapon(playerid, 33 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un rifle de caza");
				}
				case 17: //Porra
				{
                    GivePlayerWeapon(playerid, 3 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un porra");
				}
				case 18: //Cuchillo
				{
                    GivePlayerWeapon(playerid, 4 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un cuchillo");
				}
				case 19: //Bate
				{
                    GivePlayerWeapon(playerid, 5 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un bate");
				}
				case 20: //Spray
				{
                    GivePlayerWeapon(playerid, 41 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un spray");
				}
				case 21: //Extintor
				{
                    GivePlayerWeapon(playerid, 42 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un extintor");
				}
				case 22: //granada explosiva
				{
                    GivePlayerWeapon(playerid, 16 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un granada explosiva");
				}
				case 23: //molotov
				{
                    GivePlayerWeapon(playerid, 18 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un molotov");
				}
				case 24: //gas lacrimogeno
				{
                    GivePlayerWeapon(playerid, 17 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un gas lacrimogeno");
				}
				case 25: //explosivo
				{
                    GivePlayerWeapon(playerid, 39 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un explosivo");
				}
				case 26: //detonador
				{
                    GivePlayerWeapon(playerid, 40 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un detonador");
				}
				case 27: //camara
				{
                    GivePlayerWeapon(playerid, 43 , 500);
                    USMCMessage(playerid, -1, "Usted acaba generar un camara");
				}
            }
        }
    }
	return 0;
}








CMD:anfibio(playerid, params)
{
	SetPlayerPos(playerid, 257.6411, 2902.6387, 8.4388);
	return 1;
}

CMD:monte(playerid, params)
{
	SetPlayerPos(playerid, -2322.30396, -1634.84583, 483.18939);
	return 1;
}

CMD:gym(playerid, params)
{
	SetPlayerPos(playerid, 2218.5071, -1728.9443, 12.8937);
	return 1;
}

CMD:campo1(playerid, params)
{
	SetPlayerPos(playerid, 802.0491, 1698.0173, 5.5374);
	return 1;
}

CMD:angelpine(playerid, params)
{
	SetPlayerPos(playerid, -2252.1396, -2547.6367, 32.9373);
	return 1;
}

CMD:aerosf(playerid, params)
{
	SetPlayerPos(playerid, -1362.2463, -247.2097, 14.1440);
	USMCMessage(playerid, -1, "Has sido teleportado al Aeropuerto de San Fierro");
	return 1;
}

CMD:aerols(playerid, params)
{
	SetPlayerPos(playerid, 1928.8539, -2472.3022, 13.5391);
	USMCMessage(playerid, -1, "Has sido teleportado al Aeropuerto de Los Santos");
	return 1;
}

CMD:aerolv(playerid, params)
{
	SetPlayerPos(playerid, 1507.3119, 1492.0270, 10.8344);
	USMCMessage(playerid, -1, "Has sido teleportado al Aeropuerto de Las Venturas");
	return 1;
}

CMD:lv(playerid, params)
{
	SetPlayerPos(playerid, 2031.9473, 1007.3376, 10.8203);
	USMCMessage(playerid, -1, "Has sido teleportado a Las Venturas");
	return 1;
}

CMD:sf(playerid, params)
{
	SetPlayerPos(playerid, -2021.4829, 146.6924, 28.7517);
	USMCMessage(playerid, -1, "Has sido teleportado a San Fierro");
	return 1;
}

CMD:ls(playerid, params)
{
	SetPlayerPos(playerid, 1479.5699,-1740.1569,13.5469);
	USMCMessage(playerid, -1, "Has sido teleportado a Los Santos");
	return 1;
}

CMD:casino(playerid, params)
{
	SetPlayerPos(playerid, 1006.7594, 2521.5303, 10.7891);
	return 1;
}

CMD:entrels(playerid, params)
{
	SetPlayerPos(playerid, 1951.3647, -2052.5933, 13.3828);
	return 1;
}

CMD:parkour(playerid, params)
{
	SetPlayerPos(playerid, -3404.9995, 1569.8923, 18.5673);
	return 1;
}

CMD:favelas(playerid, params)
{
	SetPlayerPos(playerid, 2216.8501,-1125.9211,25.6250);
	return 1;
}

CMD:wingsuit(playerid, params)
{
	SetPlayerPos(playerid, -273.31302, -596.37622, 16526.75586);
	return 1;
}

CMD:oceandocks(playerid, params)
{
	SetPlayerPos(playerid, 2753.7964, -2458.9495, 13.6432);
	return 1;
}

CMD:removerarmas(playerid, params[])
{
	ResetPlayerWeapons(playerid);
	return 1;
}





stock USMCMessage(playerid, colorid, text[])
{
	new string[144];
	format(string, 144, "{ede900}[SDP - USMC] {FFFFFF}%s", text);
	SendClientMessage(playerid, colorid, string);
	return 1;
}
