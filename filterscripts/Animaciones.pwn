/*  Sistema de animaciones

	Creditos:

	Sacado del gm OSRP	 (MikeyAnims)

	Pasado a zcmd y optimizado por BadyX

	                                            */
#include <a_samp>
#include <core>
#include <float>
#include <zcmd>
#include <sscanf2>

#define GREEN 0x21DD00FF
#define RED 0xE60000FF
#define ADMIN_RED 0xFB0000FF
#define YELLOW 0xFFFF00FF
#define ORANGE 0xF97804FF
#define LIGHTRED 0xFF8080FF
#define LIGHTBLUE 0x00C2ECFF
#define PURPLE 0xB360FDFF
#define PLAYER_COLOR 0xFFFFFFFF
#define BLUE 0x1229FAFF
#define LIGHTGREEN 0x38FF06FF
#define DARKPINK 0xE100E1FF
#define DARKGREEN 0x008040FF
#define ANNOUNCEMENT 0x6AF7E1FF
#define COLOR_SYSTEM 0xEFEFF7AA
#define GREY 0xCECECEFF
#define PINK 0xD52DFFFF
#define DARKGREY    0x626262FF
#define AQUAGREEN   0x03D687FF
#define NICESKY 0x99FFFFAA
#define WHITE 			0xFFFFFFFF
#define COLOR_PRP 0xf58e2aAA
#define COLOR_AZULCLARO 0x1784ffAA
#define COLOR_NARANJA 0xe9ae30AA

#define SPECIAL_ACTION_PISSING      68
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];
new animation[200];
new Text:txtAnimHelper;
new saludoid;
#if defined FILTERSCRIPT

#else
main()
{}
#endif
//-------------------------------------------------

// ********** Funciones internas **********

//------------------------------------------------

IsKeyJustDown(key, newkeys, oldkeys)
{
	if((newkeys & key) && !(oldkeys & key)) return 1;
	return 0;
}

//-------------------------------------------------

OnePlayAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
    if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
	ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp, 1);
	gPlayerUsingLoopingAnim[playerid] = 0;
	animation[playerid]++;
}

//-------------------------------------------------

LoopingAnim(playerid,animlib[],animname[], Float:Speed, looping, lockx, locky, lockz, lp)
{
	if (gPlayerUsingLoopingAnim[playerid] == 1) TextDrawHideForPlayer(playerid,txtAnimHelper);
    gPlayerUsingLoopingAnim[playerid] = 1;
    ApplyAnimation(playerid, animlib, animname, Speed, looping, lockx, locky, lockz, lp, 1);
    animation[playerid]++;
}

//-------------------------------------------------

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

//-------------------------------------------------

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0, 1);
}

public OnFilterScriptInit()
{
      print("Sistema de ANIMACIONES cargado!");
      return 1;
}

//-------------------------------------------------

// ********** CALLBACKS **********
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(!gPlayerUsingLoopingAnim[playerid]) return 0;
	//SendClientInt(playerid, RED, "ID: %d", newkeys);
	if(IsKeyJustDown(KEY_HANDBRAKE,newkeys,oldkeys))
	{
	    StopLoopingAnim(playerid);
        TextDrawHideForPlayer(playerid,txtAnimHelper);
        animation[playerid] = 0;
		gPlayerUsingLoopingAnim[playerid] = 0;
		return 1;
    }
	return 0;
}

//------------------------------------------------
public OnPlayerDeath(playerid)
{

	if(gPlayerUsingLoopingAnim[playerid])
	{
        gPlayerUsingLoopingAnim[playerid] = 0;
        TextDrawHideForPlayer(playerid,txtAnimHelper);
	}
 	return 1;
}
//-------------------------------------------------

public OnPlayerSpawn(playerid)
{
	if(!gPlayerAnimLibsPreloaded[playerid]) {
   	PreloadAnimLib(playerid,"AIRPORT");
    PreloadAnimLib(playerid,"ATTRACTORS");
    PreloadAnimLib(playerid,"BAR");
    PreloadAnimLib(playerid,"BASEBALL");
    PreloadAnimLib(playerid,"BD_FIRE");
    PreloadAnimLib(playerid,"BEACH");
    PreloadAnimLib(playerid,"BENCHPRESS");
    PreloadAnimLib(playerid,"BF_INJECTION");
    PreloadAnimLib(playerid,"BIKED");
    PreloadAnimLib(playerid,"BIKEH");
    PreloadAnimLib(playerid,"BIKELEAP");
    PreloadAnimLib(playerid,"BIKES");
    PreloadAnimLib(playerid,"BIKEV");
    PreloadAnimLib(playerid,"BIKE_DBZ");
    PreloadAnimLib(playerid,"BMX");
    PreloadAnimLib(playerid,"BOMBER");
    PreloadAnimLib(playerid,"BOX");
    PreloadAnimLib(playerid,"BSKTBALL");
    PreloadAnimLib(playerid,"BUDDY");
    PreloadAnimLib(playerid,"BUS");
    PreloadAnimLib(playerid,"CAMERA");
    PreloadAnimLib(playerid,"CAR");
    PreloadAnimLib(playerid,"CARRY");
    PreloadAnimLib(playerid,"CAR_CHAT");
    PreloadAnimLib(playerid,"CASINO");
    PreloadAnimLib(playerid,"CHAINSAW");
    PreloadAnimLib(playerid,"CHOPPA");
    PreloadAnimLib(playerid,"CLOTHES");
    PreloadAnimLib(playerid,"COACH");
    PreloadAnimLib(playerid,"COLT45");
    PreloadAnimLib(playerid,"COP_AMBIENT");
    PreloadAnimLib(playerid,"COP_DVBYZ");
    PreloadAnimLib(playerid,"CRACK");
    PreloadAnimLib(playerid,"CRIB");
    PreloadAnimLib(playerid,"DAM_JUMP");
    PreloadAnimLib(playerid,"DANCING");
    PreloadAnimLib(playerid,"DEALER");
    PreloadAnimLib(playerid,"DILDO");
    PreloadAnimLib(playerid,"DODGE");
    PreloadAnimLib(playerid,"DOZER");
    PreloadAnimLib(playerid,"DRIVEBYS");
    PreloadAnimLib(playerid,"FAT");
    PreloadAnimLib(playerid,"FIGHT_B");
    PreloadAnimLib(playerid,"FIGHT_C");
    PreloadAnimLib(playerid,"FIGHT_D");
    PreloadAnimLib(playerid,"FIGHT_E");
    PreloadAnimLib(playerid,"FINALE");
    PreloadAnimLib(playerid,"FINALE2");
    PreloadAnimLib(playerid,"FLAME");
    PreloadAnimLib(playerid,"FLOWERS");
    PreloadAnimLib(playerid,"FOOD");
    PreloadAnimLib(playerid,"FREEWEIGHTS");
    PreloadAnimLib(playerid,"GANGS");
    PreloadAnimLib(playerid,"GHANDS");
    PreloadAnimLib(playerid,"GHETTO_DB");
    PreloadAnimLib(playerid,"GOGGLES");
    PreloadAnimLib(playerid,"GRAFFITI");
    PreloadAnimLib(playerid,"GRAVEYARD");
    PreloadAnimLib(playerid,"GRENADE");
    PreloadAnimLib(playerid,"GYMNASIUM");
    PreloadAnimLib(playerid,"HAIRCUTS");
    PreloadAnimLib(playerid,"HEIST9");
    PreloadAnimLib(playerid,"INT_HOUSE");
    PreloadAnimLib(playerid,"INT_OFFICE");
    PreloadAnimLib(playerid,"INT_SHOP");
    PreloadAnimLib(playerid,"JST_BUISNESS");
    PreloadAnimLib(playerid,"KART");
    PreloadAnimLib(playerid,"KISSING");
    PreloadAnimLib(playerid,"KNIFE");
    PreloadAnimLib(playerid,"LAPDAN1");
    PreloadAnimLib(playerid,"LAPDAN2");
    PreloadAnimLib(playerid,"LAPDAN3");
    PreloadAnimLib(playerid,"LOWRIDER");
    PreloadAnimLib(playerid,"MD_CHASE");
    PreloadAnimLib(playerid,"MD_END");
    PreloadAnimLib(playerid,"MEDIC");
    PreloadAnimLib(playerid,"MISC");
    PreloadAnimLib(playerid,"MTB");
    PreloadAnimLib(playerid,"MUSCULAR");
    PreloadAnimLib(playerid,"NEVADA");
    PreloadAnimLib(playerid,"ON_LOOKERS");
    PreloadAnimLib(playerid,"OTB");
    PreloadAnimLib(playerid,"PARACHUTE");
    PreloadAnimLib(playerid,"PARK");
    PreloadAnimLib(playerid,"PAULNMAC");
    PreloadAnimLib(playerid,"PED");
    PreloadAnimLib(playerid,"PLAYER_DVBYS");
    PreloadAnimLib(playerid,"PLAYIDLES");
    PreloadAnimLib(playerid,"POLICE");
    PreloadAnimLib(playerid,"POOL");
    PreloadAnimLib(playerid,"POOR");
    PreloadAnimLib(playerid,"PYTHON");
    PreloadAnimLib(playerid,"QUAD");
    PreloadAnimLib(playerid,"QUAD_DBZ");
    PreloadAnimLib(playerid,"RAPPING");
    PreloadAnimLib(playerid,"RIFLE");
    PreloadAnimLib(playerid,"RIOT");
    PreloadAnimLib(playerid,"ROB_BANK");
    PreloadAnimLib(playerid,"ROCKET");
    PreloadAnimLib(playerid,"RUSTLER");
    PreloadAnimLib(playerid,"RYDER");
    PreloadAnimLib(playerid,"SCRATCHING");
    PreloadAnimLib(playerid,"SHAMAL");
    PreloadAnimLib(playerid,"SHOP");
    PreloadAnimLib(playerid,"SHOTGUN");
    PreloadAnimLib(playerid,"SILENCED");
    PreloadAnimLib(playerid,"SKATE");
    PreloadAnimLib(playerid,"SMOKING");
    PreloadAnimLib(playerid,"SNIPER");
    PreloadAnimLib(playerid,"SPRAYCAN");
    PreloadAnimLib(playerid,"STRIP");
    PreloadAnimLib(playerid,"SUNBATHE");
    PreloadAnimLib(playerid,"SWAT");
    PreloadAnimLib(playerid,"SWEET");
    PreloadAnimLib(playerid,"SWIM");
    PreloadAnimLib(playerid,"SWORD");
    PreloadAnimLib(playerid,"TANK");
    PreloadAnimLib(playerid,"TATTOOS");
    PreloadAnimLib(playerid,"TEC");
    PreloadAnimLib(playerid,"TRAIN");
    PreloadAnimLib(playerid,"TRUCK");
    PreloadAnimLib(playerid,"UZI");
    PreloadAnimLib(playerid,"VAN");
    PreloadAnimLib(playerid,"VENDING");
    PreloadAnimLib(playerid,"VORTEX");
    PreloadAnimLib(playerid,"WAYFARER");
    PreloadAnimLib(playerid,"WEAPONS");
    PreloadAnimLib(playerid,"WUZI");
    PreloadAnimLib(playerid,"WOP");
    PreloadAnimLib(playerid,"GFUNK");
    PreloadAnimLib(playerid,"RUNNINGMAN");
	gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	return 1;
}

//-------------------------------------------------

public OnPlayerConnect(playerid)
{
    gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	return 1;
}

//-------------------------------------------------
forward  OnInit();
public OnInit()
{
	// Init our text display
	txtAnimHelper = TextDrawCreate(610.0, 400.0,
	"~b~~k~~PED_LOCK_TARGET~ ~w~para detener la animacion.");
	TextDrawUseBox(txtAnimHelper, 0);
	TextDrawFont(txtAnimHelper, 2);
	TextDrawSetShadow(txtAnimHelper,0); // no shadow
    TextDrawSetOutline(txtAnimHelper,1); // thickness 1
    TextDrawBackgroundColor(txtAnimHelper,0x000000FF);
    TextDrawColor(txtAnimHelper,0xFFFFFFFF);
    TextDrawAlignment(txtAnimHelper,3); // align right
}

//-------------------------------------------------
/*
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256];
	new animid;
	new tmp[256];
	new idx;
	new dancestyle;
	cmd = strtokex(cmdtext, idx);

    if(strcmp(cmd,"/saludo",true)==0)
	{
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /saludo [PlayerID] [1-7]");
			return 1;
		}
		new idsaludado = strval(tmp);
		tmp = strtokex(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, Blanco, "USO: /saludo [PlayerID] [1-7]");
			return 1;
		}
		new animid2 = strval(tmp);
		switch(animid2)
		{
			case 1:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 0;
			}
			case 2:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 1;
			}
			case 3:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 2;
			}
			case 4:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 3;
			}
			case 5:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 4;
			}
			case 6:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 5;
			}
			case 7:
			{
				PlayerInfo[idsaludado][pOfertaSaludo] = playerid;
				format(string,128,"Enviaste una petición de saludo a %s",pName(idsaludado));
				SendClientMessage(playerid,Blanco,string);
				format(string,128,"%s te envió una petición de saludo, utiliza /aceptar saludo",pName(playerid));
				SendClientMessage(idsaludado,Blanco,string);
				saludoid = 6;
			}
			default: SendClientMessage(playerid,Blanco,"Uso: /saludo ID [1-7]");
		}
		return 1;
	}




*/

CMD:brazos(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /brazos [1-6]");
    if(params[0] < 1 || params[0] > 6)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /brazos [1-6]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"CASINO","cards_in",4.1,0,1,1,1,1);
		case 2: LoopingAnim(playerid,"COP_AMBIENT","Coplook_shake",4.1,0,1,1,1,1);
		case 3: LoopingAnim(playerid,"COP_AMBIENT","Coplook_think",4.1,0,1,1,1,1);
		case 4: LoopingAnim(playerid,"COP_AMBIENT","Coplook_watch",4.1,0,1,1,1,1);
		case 5: LoopingAnim(playerid,"DEALER","DEALER_IDLE",4.1,0,1,1,1,1);
		case 6: LoopingAnim(playerid,"GRAVEYARD","prst_loopa",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:crack(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /crack [1-8]");
    if(params[0] < 1 || params[0] > 8)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /crack [1-8]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"CRACK","crckdeth1",4.1,0,1,1,1,1);
    	case 2: LoopingAnim(playerid,"CRACK","crckdeth2",4.1,1,0,0,1,1);
    	case 3: LoopingAnim(playerid,"CRACK","crckdeth3",4.1,0,1,1,1,1);
		case 4: LoopingAnim(playerid,"CRACK","crckdeth4",4.1,0,1,1,1,1);
		case 5: LoopingAnim(playerid,"CRACK","crckidle1",4.1,1,1,1,1,1);
		case 6: LoopingAnim(playerid,"CRACK","crckidle2",4.1,1,0,0,1,1);
		case 7: LoopingAnim(playerid,"CRACK","crckidle3",4.1,0,1,1,1,1);
		case 8: LoopingAnim(playerid,"CRACK","crckidle4",4.1,1,0,0,1,1);
	}
	return 1;
}

CMD:fumando(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /fumando [1-5]");
    if(params[0] < 1 || params[0] > 5)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /fumando [1-5]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"SMOKING", "M_smklean_loop", 4.0, 1, 0, 1, 1, 1);
    	case 2: LoopingAnim(playerid,"SMOKING","M_smkstnd_loop", 4.0, 1, 0, 1, 1, 1);
    	case 3: LoopingAnim(playerid,"SMOKING","M_smk_out", 4.0, 0, 0, 1, 1, 1);
		case 4: LoopingAnim(playerid,"SMOKING","M_smk_in",4.0,0,1,1,1,1);
		case 5: LoopingAnim(playerid,"GANGS","smkcig_prtl",4.1,1,1,1,1,1);
	}
	return 1;
}

CMD:sentarse(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /saludar [1-9]");
    if(params[0] < 1 || params[0] > 9)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /saludar [1-9]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"Attractors","Stepsit_in",4.1,0,0,0,1,1);
    	case 2: LoopingAnim(playerid,"Attractors","Stepsit_out",4.1,0,1,1,1,1);
    	case 3: LoopingAnim(playerid,"FOOD","FF_Sit_Eat3",4.1,0,0,0,1,1);
    	case 4: LoopingAnim(playerid,"FOOD","FF_Sit_In",4.1,0,0,0,1,1);
    	case 5: LoopingAnim(playerid,"FOOD","FF_Sit_In_L",4.1,0,0,0,1,1);
    	case 6: LoopingAnim(playerid,"FOOD","FF_Sit_In_R",4.1,0,0,0,1,1);
    	case 7: LoopingAnim(playerid,"PED","SEAT_down",4.1,0,0,0,1,1);
    	case 8: LoopingAnim(playerid,"INT_HOUSE","LOU_In",4.1,0,0,0,1,1);
    	case 9: LoopingAnim(playerid,"MISC","SEAT_LR",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:saludar(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /saludar [1-7]");
    if(params[0] < 1 || params[0] > 7)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /saludar [1-7]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"GANGS","prtial_hndshk_biz_01",4.1,0,1,1,1,1);
    	case 2: LoopingAnim(playerid,"GANGS","hndshkcb",4.1,0,1,1,1,1);
    	case 3: LoopingAnim(playerid,"GANGS","hndshkea",4.1,0,1,1,1,1);
    	case 4: LoopingAnim(playerid,"GANGS","hndshkfa",4.1,0,1,1,1,1);
    	case 5: LoopingAnim(playerid,"GANGS","hndshkba",4.1,0,1,1,1,1);
    	case 6: LoopingAnim(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 1, 1);
    	case 7: LoopingAnim(playerid,"PED","endchat_03",4.1,0,1,1,1,1);
	}
	return 1;
}





CMD:agacharse(playerid, params[])
{
  	LoopingAnim(playerid, "ped", "cower", 4.0, 0, 1, 1, 1, 1);
  	return 1;
}
CMD:vomitar(playerid, params[])
{
	LoopingAnim(playerid, "FOOD", "EAT_Vomit_P", 4.0, 0, 1, 1, 1, 1);
	return 1;
}
CMD:comiendo(playerid, params[])
{
	LoopingAnim(playerid, "FOOD", "EAT_Burger", 4.0, 0, 1, 1, 1, 1);
	return 1;
}
CMD:trato(playerid, params[])
{
	LoopingAnim(playerid, "DEALER", "DEALER_DEAL", 4.0, 0, 1, 1, 1, 1);
	return 1;
}

CMD:gro(playerid, params[])
{
      LoopingAnim(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 1, 1, 1);
	  return 1;
}
CMD:hablando(playerid, params[])
{
	 LoopingAnim(playerid,"PED","IDLE_CHAT",4.0,1,0,0,1,1);
     return 1;
}


CMD:fucku(playerid, params[])
{
	 LoopingAnim(playerid,"PED","fucku",4.0,0,0,0,1,1);
     return 1;
}

CMD:taichi(playerid, params[])
{
	 LoopingAnim(playerid,"PARK","Tai_Chi_Loop",4.0,1,1,1,1,1);
     return 1;
}

CMD:caer(playerid, params[])
{
	 LoopingAnim(playerid,"PED","KO_skid_front",4.1,0,1,1,1,1);
     return 1;
}

CMD:muerto(playerid, params[])
{
	 LoopingAnim(playerid, "PED","FLOOR_hit_f", 4.0,0,1,1,1,1);
     return 1;
}

CMD:herido(playerid, params[])
{
	 LoopingAnim(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 1, 1, 1);
     return 1;
}

CMD:carga(playerid, params[])
{
	LoopingAnim(playerid,"CARRY","crry_prtial",4.1,0,1,1,1,1);
    return 1;
}


CMD:llorar(playerid, params[])
{
	LoopingAnim(playerid,"GRAVEYARD","mrnF_loop",4.1,1,1,1,1,1);
    return 1;
}

CMD:masturb(playerid, params[])
{
	LoopingAnim(playerid,"PAULNMAC","wank_loop",4.1,1,1,1,1,1);
    return 1;
}

CMD:bofetada(playerid, params[])
{
	LoopingAnim(playerid,"MISC","bitchslap",4.1,1,0,0,1,1);
    return 1;
}
CMD:facepalm(playerid, params[])
{
	LoopingAnim(playerid,"MISC","plyr_shkhead",4.1,0,0,0,0,0);
    return 1;
}
CMD:barandilla(playerid, params[])
{
	LoopingAnim(playerid,"BD_FIRE","BD_Panic_Loop",4.1,1,1,1,1,1);
    return 1;
}


/*
CMD:rendirse(playerid, params[])
{
  	LoopingAnim(playerid, "ROB_BANK","SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 1);
	return 1;
}*/

CMD:rifle(playerid, params[])
{
	LoopingAnim(playerid,"BUDDY","buddy_reload",4.1,0,1,1,1,1);
    return 1;
}

CMD:movil(playerid, params[])
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_USECELLPHONE);
    return 1;
}
CMD:cmovil(playerid, params[])
{
	SetPlayerSpecialAction(playerid,SPECIAL_ACTION_STOPUSECELLPHONE);
	return 1;
}

CMD:bebido(playerid, params[])
{
	LoopingAnim(playerid,"PED","WALK_DRUNK",4.1,1,1,1,1,1);
	return 1;
}

CMD:bomba(playerid, params[])
{
	ClearAnimations(playerid);
	LoopingAnim(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,1);
	return 1;
}

CMD:reir(playerid, params[])
{
      LoopingAnim(playerid, "RAPPING", "Laugh_01", 4.0, 1, 1, 1, 1, 1);
	  return 1;
}






CMD:animaciones(playerid, params[])
{
    SendClientMessage(playerid, COLOR_NARANJA, "________________________________________________________________________________________________________________________");
	SendClientMessage(playerid,COLOR_PRP,"Lista de animaciones disponibles:");
    SendClientMessage(playerid,WHITE,"/rendirse - /bebido - /movil - /cmovil - /bomba - /apuntar - /reir - /tumbarse - /agacharse - /vomitar - /comiendo - /herido");
    SendClientMessage(playerid,WHITE,"/saludar - /trato - /crack - /fumando - /sentarse - /gro - /fucku - /hablando - /taichi - /caer - /muerto - /brazos - /gangsta");
    SendClientMessage(playerid,WHITE,"/spray - /medico - /golpeado - /cansado - /saltovital - /tortazo - /rodar - /cacheado - /bate - /boxing - /gritando - /facepalm");
    SendClientMessage(playerid,WHITE,"/animar - /esposado - /pis - /lanzar - /basket - /caminar - /rascarse - /apoyarse - /correr - /strip - /bailar - /trafico");
    SendClientMessage(playerid,WHITE,"/rifle - /mecanico - /carga - /bailoteo - /consola - /picado - /barandilla - /llorar - /bofetada - /billar - /beso - /dedo");
    SendClientMessage(playerid,WHITE,"/azote - /masturb - /chupete");
    SendClientMessage(playerid,WHITE," -Animaciones de uso en vehículo: /coche   |   Usa /stopanim para detener la animación.");
    SendClientMessage(playerid, COLOR_NARANJA, "¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯");
    return true;
}


CMD:gangsta(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /gangsta [1-16]");
    if(params[0] < 1 || params[0] > 12)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /gangsta [1-16]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"RAPPING","RAP_A_Loop",4.0,1,1,1,1,1);
		case 2: LoopingAnim(playerid,"RAPPING","RAP_C_Loop",4.0,1,1,1,1,1);
		case 3: LoopingAnim(playerid,"GHANDS","gsign2",4.1,0,1,1,1,1);
		case 4: LoopingAnim(playerid,"GHANDS","gsign2LH",4.1,0,1,1,1,1);
		case 5: LoopingAnim(playerid,"GHANDS","gsign3",4.1,0,1,1,1,1);
		case 6: LoopingAnim(playerid,"GHANDS","gsign3LH",4.1,0,1,1,1,1);
		case 7: LoopingAnim(playerid,"GHANDS","gsign4",4.1,0,1,1,1,1);
		case 8: LoopingAnim(playerid,"GHANDS","gsign4LH",4.1,0,1,1,1,1);
		case 9: LoopingAnim(playerid,"GHANDS","gsign5",4.1,0,1,1,1,1);
		case 10: LoopingAnim(playerid,"GHANDS","gsign5LH",4.1,0,1,1,1,1);
		case 11: LoopingAnim(playerid,"benchpress","gym_bp_celebrate",4.1,0,1,1,1,1);
		case 12: LoopingAnim(playerid,"LOWRIDER","prtial_gngtlkG",4.1,0,1,1,1,1);
		case 13: LoopingAnim(playerid,"RIOT","RIOT_ANGRY",4.1,0,1,1,1,1);
		case 14: LoopingAnim(playerid,"RIOT","RIOT_challenge",4.1,0,1,1,1,1);
		case 15: LoopingAnim(playerid,"RAPPING","RAP_B_Loop",4.1,1,1,1,1,1);
		case 16: LoopingAnim(playerid,"SCRATCHING","scdrulp",4.1,1,0,0,1,1);
	}
	return 1;
}

CMD:chupete(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /chupete [1-12]");
    if(params[0] < 1 || params[0] > 12)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /chupete [1-12]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"BLOWJOBZ","BJ_COUCH_START_P",4.1,0,1,1,1,1);
		case 2: LoopingAnim(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_P",4.1,1,1,1,1,1);
		case 3: LoopingAnim(playerid,"BLOWJOBZ","BJ_COUCH_END_P",4.1,0,1,1,1,1);
		case 4: LoopingAnim(playerid,"BLOWJOBZ","BJ_COUCH_START_W",4.1,0,1,1,1,1);
		case 5: LoopingAnim(playerid,"BLOWJOBZ","BJ_COUCH_LOOP_W",4.1,1,1,1,1,1);
		case 6: LoopingAnim(playerid,"BLOWJOBZ","BJ_COUCH_END_W",4.1,0,1,1,1,1);
		case 7: LoopingAnim(playerid,"BLOWJOBZ","BJ_STAND_START_P",4.1,0,1,1,1,1);
		case 8: LoopingAnim(playerid,"BLOWJOBZ","BJ_STAND_LOOP_P",4.1,1,1,1,1,1);
		case 9: LoopingAnim(playerid,"BLOWJOBZ","BJ_STAND_END_P",4.1,0,1,1,1,1);
		case 10: LoopingAnim(playerid,"BLOWJOBZ","BJ_STAND_START_W",4.1,0,1,1,1,1);
		case 11: LoopingAnim(playerid,"BLOWJOBZ","BJ_STAND_LOOP_W",4.1,1,1,1,1,1);
		case 12: LoopingAnim(playerid,"BLOWJOBZ","BJ_STAND_END_W",4.1,0,1,1,1,1);
	}
	return 1;
}









CMD:spray(playerid, params[])
{
    LoopingAnim(playerid,"SPRAYCAN","spraycan_full",4.0,1,1,1,1,1);
	return 1;
}


CMD:medico(playerid, params[])
{
    LoopingAnim(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
	return 1;
}

CMD:golpeado(playerid, params[])
{
    LoopingAnim(playerid,"PED","KO_shot_face",4.0,0,1,1,1,1);
	return 1;
}


CMD:saltovital(playerid, params[])
{
   	LoopingAnim(playerid,"PED","EV_dive",4.0,0,1,1,1,1);
	return 1;
}


CMD:cansado(playerid, params[])
{
    LoopingAnim(playerid,"PED","IDLE_tired",4.0,1,0,1,1,1);
	return 1;
}


CMD:tortazo(playerid, params[])
{
    OnePlayAnim(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
	return 1;
}


CMD:rodar(playerid, params[])
{
    LoopingAnim(playerid,"PED","BIKE_fallR",4.0,0,1,1,1,1);
	return 1;
}


CMD:cacheado(playerid, params[])
{
    LoopingAnim(playerid,"POLICE","crm_drgbst_01",4.0,0,1,1,1,1);
	return 1;
}


CMD:bate(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /bate [1-2]");
    if(params[0] < 1 || params[0] > 2)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /bate [1-2]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"CRACK","Bbalbat_Idle_01",4.1,0,1,1,1,1);
		case 2: LoopingAnim(playerid,"CRACK","Bbalbat_Idle_02",4.1,0,1,1,1,1);
	}
	return 1;
}




CMD:boxing(playerid, params[])
{
    LoopingAnim(playerid,"GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,1);
	return 1;
}


CMD:animar(playerid, params[])
{
    LoopingAnim(playerid,"RIOT","RIOT_CHANT",4.0,1,1,1,1,1);
	return 1;
}


CMD:dedo(playerid, params[])
{
    OnePlayAnim(playerid,"RIOT","RIOT_FUKU",4.0,0,0,0,0,0);
	return 1;
}


CMD:gritando(playerid, params[])
{
    LoopingAnim(playerid,"RIOT","RIOT_shout",4.0,1,1,1,1,1);
	return 1;
}

CMD:esposado(playerid, params[])
{
    LoopingAnim(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
	return 1;
}

CMD:lanzar(playerid, params[])
{
    LoopingAnim(playerid,"GRENADE","WEAPON_throwu",4.0,0,1,1,1,0);
	return 1;
}

CMD:pis(playerid, params[])
{
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_PISSING);
	return 1;
}
CMD:basket(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /basket [1-7]");
    if(params[0] < 1 || params[0] > 7)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /basket [1-7]");
    switch(params[0])
	{
    	case 1: LoopingAnim(playerid,"BSKTBALL","BBALL_run",4.1,1,1,0,1,1);
    	case 2: LoopingAnim(playerid,"BSKTBALL","BBALL_idleloop",4.1,1,1,1,1,1);
    	case 3: OnePlayAnim(playerid,"BSKTBALL","BBALL_Jump_Shot",4.1,0,0,0,0,0);
		case 4: LoopingAnim(playerid,"BSKTBALL","BBALL_def_loop",4.1,1,1,1,1,1);
    	case 5: LoopingAnim(playerid,"BSKTBALL","BBALL_Dnk",4.1,0,1,1,1,1);
    	case 6: LoopingAnim(playerid,"BSKTBALL","BBALL_idle",4.1,1,1,1,1,1);
    	case 7: LoopingAnim(playerid,"BSKTBALL","BBALL_idle2",4.1,1,1,1,1,1);
	}
	return 1;
}


CMD:caminar(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /caminar [1-11]");
    if(params[0] < 1 || params[0] > 11)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /caminar [1-11]");
    switch(params[0])
	{
		case 1: LoopingAnim(playerid,"PED","WALK_civi",4.1,1,1,1,1,1);
		case 2: LoopingAnim(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
		case 3: LoopingAnim(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
		case 4: LoopingAnim(playerid,"FAT","FatWalk",4.1,1,1,1,1,1);
		case 5: LoopingAnim(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
		case 6: LoopingAnim(playerid,"PED","WALK_player",4.1,1,1,1,1,1);
		case 7: LoopingAnim(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1);
		case 8: LoopingAnim(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1);
		case 9: LoopingAnim(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1);
		case 10: LoopingAnim(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1);
		case 11: LoopingAnim(playerid,"POOL","POOL_Walk",4.1,1,1,1,1,1);
	}
	return 1;
}

CMD:azote(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /azote [1-6]");
    if(params[0] < 1 || params[0] > 6)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /azote [1-6]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"SNM","SPANKINGP",4.1,1,0,0,1,1);
		case 2: LoopingAnim(playerid,"SNM","SPANKEDW",4.1,1,0,0,1,1);
		case 3: LoopingAnim(playerid,"SNM","SPANKING_ENDP",4.1,0,0,0,1,1);
		case 4: LoopingAnim(playerid,"SNM","SPANKEDP",4.1,1,0,0,1,1);
		case 5: LoopingAnim(playerid,"SNM","SPANKINGW",4.1,1,0,0,1,1);
		case 6: LoopingAnim(playerid,"SNM","SPANKING_ENDW",4.1,0,0,0,1,1);
	}
	return 1;
}

CMD:trafico(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /apuntar [1-4]");
    if(params[0] < 1 || params[0] > 3)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /apuntar [1-4]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"POLICE","CopTraf_Away",4.1,1,0,0,1,1);
		case 2: LoopingAnim(playerid,"POLICE","CopTraf_Come",4.1,1,0,0,1,1);
		case 3: LoopingAnim(playerid,"POLICE","CopTraf_Left",4.1,1,0,0,1,1);
		case 4: LoopingAnim(playerid,"POLICE","CopTraf_Stop",4.1,1,0,0,1,1);
	}
	return 1;
}


CMD:apuntar(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /apuntar [1-3]");
    if(params[0] < 1 || params[0] > 3)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /apuntar [1-3]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"SHOP","ROB_Loop_Threat",4.1,1,0,0,1,1);
    	case 2: LoopingAnim(playerid,"ped", "ARRESTgun", 4.0,0,1,1,1,1);
    	case 3: LoopingAnim(playerid,"SHOP","SHP_Gun_Aim",4.1,1,0,0,1,1);
	}
	return 1;
}

CMD:apoyarse(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /apoyarse [1-2]");
    if(params[0] < 1 || params[0] > 2)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /apoyarse [1-2]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"GANGS","leanIDLE",4.0,1,0,1,1,1);
       	case 2: LoopingAnim(playerid,"MISC","Plyrlean_loop",4.0,1,1,1,1,1);
	}
	return 1;
}

CMD:beso(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /beso [1-2]");
    if(params[0] < 1 || params[0] > 2)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /beso [1-2]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"KISSING","Grlfrd_Kiss_03",4.1,0,0,0,1,1);
        case 2: LoopingAnim(playerid,"KISSING","Playa_Kiss_03",4.1,0,0,0,1,1);
	}
	return 1;
}



CMD:billar(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /billar [1-3]");
    if(params[0] < 1 || params[0] > 3)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /billar [1-3]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"POOL","POOL_Idle_Stance",4.1,0,1,1,1,1);
    	case 2: LoopingAnim(playerid,"POOL","POOL_Med_Start",4.1,0,1,1,1,1);
    	case 3: LoopingAnim(playerid,"POOL","POOL_Med_Shot",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:correr(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /strip [1-6]");
    if(params[0] < 1 || params[0] > 6)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /strip [1-6]");
    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"PED","run_civi",4.1,1,1,1,1,1);
		case 2: LoopingAnim(playerid,"PED","run_gang1",4.1,1,1,1,1,1);
		case 3: LoopingAnim(playerid,"PED","run_old",4.1,1,1,1,1,1);
		case 4: LoopingAnim(playerid,"PED","run_fat",4.1,1,1,1,1,1);
		case 5: LoopingAnim(playerid,"PED","woman_run",4.1,1,1,1,1,1);
		case 6: LoopingAnim(playerid,"PED","WOMAN_runsexy",4.1,1,1,1,1,1);
	}
	return 1;
}
/*
CMD:stopanim(playerid, params[])
{
    OnePlayAnim(playerid, "CARRY", "crry_prtial", 1.0, 0, 0, 0, 0, 0);
    return 1;
}
*/
CMD:rascarse(playerid, params[])
{
    LoopingAnim(playerid,"MISC","Scratchballs_01",4.1,1,1,1,1,1);
    return 1;
}
CMD:strip(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /strip [1-7]");
    if(params[0] < 1 || params[0] > 5)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /strip [1-7]");

    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"STRIP", "strip_A", 4.1, 1, 1, 1, 1, 1 );
    	case 2: LoopingAnim(playerid,"STRIP", "strip_B", 4.1, 1, 1, 1, 1, 1 );
    	case 3: LoopingAnim(playerid,"STRIP", "strip_C", 4.1, 1, 1, 1, 1, 1 );
    	case 4: LoopingAnim(playerid,"STRIP", "strip_D", 4.1, 1, 1, 1, 1, 1 );
    	case 5: LoopingAnim(playerid,"STRIP", "strip_E", 4.1, 1, 1, 1, 1, 1 );
    	case 6: LoopingAnim(playerid,"STRIP", "strip_F", 4.1, 1, 1, 1, 1, 1 );
    	case 7: LoopingAnim(playerid,"STRIP", "strip_G", 4.1, 1, 1, 1, 1, 1 );
	}
	return 1;
}

CMD:tumbarse(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /tumbarse [1-5]");
    if(params[0] < 1 || params[0] > 5)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /tumbarse [1-5]");

    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"BEACH","bather",4.1,0,1,1,1,1);
		case 2: LoopingAnim(playerid,"BEACH","Lay_Bac_Loop",4.1,0,1,1,1,1);
		case 3: LoopingAnim(playerid,"BEACH","BD_Fire3",4.1,0,1,1,1,1);
		case 4: LoopingAnim(playerid,"BEACH","ParkSit_W_loop",4.1,0,1,1,1,1);
	    case 5: LoopingAnim(playerid,"BEACH","SitnWait_loop_W",4.1,0,1,1,1,1);
	}
	return 1;
}

CMD:coche(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /coche [1-7]");
    if(params[0] < 1 || params[0] > 7)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /coche [1-7]");

    switch(params[0])
	{
        case 1: OnePlayAnim(playerid,"CAR","Sit_relaxed",4.1,0,0,0,1,0);
		case 2: OnePlayAnim(playerid,"LOWRIDER","lrgirl_hair",4.1,0,0,0,1,0);
		case 3: OnePlayAnim(playerid,"GHETTO_DB","GDB_Car2_PLY",4.1,1,0,0,1,0);
		case 4: LoopingAnim(playerid,"GHETTO_DB","GDB_Car_RYD",4.1,0,0,0,1,0);
	    case 5: OnePlayAnim(playerid,"LOWRIDER","lrgirl_l0_loop",4.1,0,1,1,1,1);
	    case 6: OnePlayAnim(playerid,"LOWRIDER","lrgirl_l0_to_l1",4.1,0,0,0,1,1);
	    case 7: OnePlayAnim(playerid,"LOWRIDER","lrgirl_l2_loop",4.1,1,0,0,1,1);
	}
	return 1;
}


CMD:mecanico(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /mecanico [1-2]");
    if(params[0] < 1 || params[0] > 2)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /mecanico [1-2]");

    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"CAR","Fixn_Car_Loop",4.1,1,0,0,1,1);
	    case 2: LoopingAnim(playerid,"CAR","Fixn_Car_Out",4.1,0,0,0,1,1);
	}
	return 1;
}

CMD:bailoteo(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /bailoteo [1-10]");
    if(params[0] < 1 || params[0] > 10)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /bailoteo [1-10]");

    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"DANCING","DAN_Down_A",4.1,1,0,0,1,1);
        case 2: LoopingAnim(playerid,"DANCING","DAN_Left_A",4.1,1,0,0,1,1);
		case 3: LoopingAnim(playerid,"DANCING","DAN_Loop_A",4.1,1,0,0,1,1);
		case 4: LoopingAnim(playerid,"DANCING","DAN_Right_A",4.1,1,0,0,1,1);
		case 5: LoopingAnim(playerid,"DANCING","DAN_Up_A",4.1,1,0,0,1,1);
		case 6: LoopingAnim(playerid,"DANCING","dnce_M_a",4.1,1,0,0,1,1);
		case 7: LoopingAnim(playerid,"DANCING","dnce_M_b",4.1,1,0,0,1,1);
		case 8: LoopingAnim(playerid,"DANCING","dnce_M_c",4.1,1,0,0,1,1);
		case 9: LoopingAnim(playerid,"DANCING","dnce_M_d",4.1,1,0,0,1,1);
		case 10: LoopingAnim(playerid,"DANCING","dnce_M_e",4.1,1,0,0,1,1);
	}
	return 1;
}

CMD:consola(playerid, params[])
{
	if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /consola [1-4]");
    if(params[0] < 1 || params[0] > 4)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /consola [1-4]");

    switch(params[0])
	{
        case 1: LoopingAnim(playerid,"CRIB","PED_Console_Loop",4.1,1,1,1,1,1);
        case 2: LoopingAnim(playerid,"CRIB","PED_Console_Loose",4.1,0,1,1,1,1);
		case 3: LoopingAnim(playerid,"CRIB","PED_Console_Win",4.1,0,1,1,1,1);
	}
	return 1;
}
CMD:bailar(playerid, params[])
{
    if(sscanf(params, "i", params[0]))   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /bailar [1-4]");
    if(params[0] < 1 || params[0] > 4)   return SendClientMessage(playerid, 0xEFEFF7AA, "Utilice: /bailar [1-4]");
	switch(params[0])
	{
	    case 1:		SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE1);
		case 2:     SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		case 3:     SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		case 4:     SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
	}
    return 1;
}
