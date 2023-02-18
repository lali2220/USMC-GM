// Badmin v1.0 por bruunosoniico
// Post oficial: http://www.pawnoscripting.com/foro/viewtopic.php?f=15&t=1023
// Comentarios del autor:
// Doy derecho a editar este script siempre y cuando no se modifiquen los creditos.
// bruunosoniico
// Gracias a:
// Gantzyo - Ayuda en la compilacion del script.
// DracoBlue - Dini include.
// Pawno Scripting - Apoyo durante el proyecto.

/* ------------------------> [Includes] <------------------------- */
#include <a_samp>
#include <dini>

/* ------------------------> [Colores] <------------------------- */
#define COLOR_ROJO 0xFF0000FF
#define COLOR_NARANJA 0xFF9600FF
#define COLOR_AMARILLO 0xFFC800FF
#define COLOR_DORADO 0x966400FF
#define COLOR_AZUL 0x0000FFFF
#define COLOR_CELESTE 0x0096FFFF
#define COLOR_AQUA 0x009696FF
#define COLOR_VERDE_OSCURO 0x00C800FF
#define COLOR_VERDE_CLARO 0x00FF00FF
#define COLOR_ROJO 0xFF0000FF
#define COLOR_NARANJA 0xFF9600FF
#define COLOR_AMARILLO 0xFFC800FF
#define COLOR_DORADO 0x966400FF
#define COLOR_AZUL 0x0000FFFF
#define COLOR_CELESTE 0x0096FFFF
#define COLOR_AQUA 0x009696FF
#define COLOR_VERDE_OSCURO 0x00C800FF
#define COLOR_VERDE 0x00C200FF
#define COLOR_CRIMSON2 		0xDC143CFF
/* ------------------------> [Filterscript] <------------------------- */
#define FILTERSCRIPT

/* ------------------------> [Estados] <------------------------- */
new Ingreso[MAX_PLAYERS];
new NivelAdmin[MAX_PLAYERS];
new EsAdmin[MAX_PLAYERS];
new Espiando[MAX_PLAYERS];
new Dios[MAX_PLAYERS];
new VDios[MAX_PLAYERS];
new Callado[MAX_PLAYERS];
new Advertido[MAX_PLAYERS];
new Encarcelado[MAX_PLAYERS];
new Congelado[MAX_PLAYERS];
//////////////

/* ------------------------> [Timers] <------------------------- */
forward tvdios(playerid);
forward tdescongelar(playerid);
forward tdesencarcelar(playerid);
forward pingcheck(playerid);

/* ------------------------> [KillTimers] <------------------------- */
new ktvdios;
new ktdescongelar;
new ktdesencarcelar;

/* ------------------------> [Vehiculos] <------------------------- */
new Vehiculos[212][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

////////////////////////////////////////////////////
public OnFilterScriptInit()
{
	print("Sistema de ADMIN cargado!");
	return 1;
}
////////////////////////////////////////////////////
public OnPlayerConnect(playerid)
{
	Ingreso[playerid] = 0;
	EsAdmin[playerid] = 0;
	Espiando[playerid] = 0;
	Dios[playerid] = 0;
	VDios[playerid] = 0;
	Callado[playerid] = 0;
	Advertido[playerid] = 0;
	SetTimerEx("pingcheck", 0, true, "d", playerid);
    new nombre[MAX_PLAYER_NAME], string[256];
	GetPlayerName(playerid, nombre, MAX_PLAYER_NAME);
	format(string, sizeof(string), "%s ha entrado al servidor.", nombre);
	SendClientMessageToAll(COLOR_NARANJA, string);
	new archivo[256], usuario[MAX_PLAYER_NAME];
	GetPlayerName(playerid, usuario, sizeof(usuario));
	format(archivo, sizeof(string), "Badmin/Usuarios/%s.ini", usuario);
	if (dini_Exists(archivo)) return SendClientMessage(playerid, COLOR_VERDE_CLARO, "Tu nombre se encuentra registrado. Usa /ingreso [Contraseña] para ingresar.");
	if (!dini_Exists(archivo)) return SendClientMessage(playerid, COLOR_VERDE_CLARO, "Tu nombre no se encuentra registrado. Usa /registro [Contraseña] para registrarte.");
	return 1;
}
////////////////////////////////////////////////////
public OnPlayerDisconnect(playerid, reason)
{
    new nombre[MAX_PLAYER_NAME], string[256];
	GetPlayerName(playerid, nombre, MAX_PLAYER_NAME);
	switch(reason)
	{
	    case 0: format(string, sizeof(string), "%s ha dejado el servidor. (Error de Conexion)", nombre);
	    case 1: format(string, sizeof(string), "%s ha dejado el servidor.", nombre);
	    case 2: format(string, sizeof(string), "%s ha dejado el servidor. (Kickeado/Baneado)", nombre);
    }
	SendClientMessageToAll(COLOR_NARANJA, string);
	new archivo[256], usuario[MAX_PLAYER_NAME];
	GetPlayerName(playerid, usuario, sizeof(usuario));
	format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", usuario);
	dini_IntSet(archivo, "Puntaje", GetPlayerScore(playerid));
	dini_IntSet(archivo, "Dinero", GetPlayerMoney(playerid));
	return 1;
}
////////////////////////////////////////////////////
public OnPlayerSpawn(playerid)
{
	if (Dios[playerid] == 1)
	{
	    SetPlayerHealth(playerid, 100000);
	}
	return 1;
}
////////////////////////////////////////////////////
public OnPlayerDeath(playerid, killerid, reason)
{
    new archivo1[256], archivo2[256], asesino[MAX_PLAYER_NAME], jugador[MAX_PLAYER_NAME];
    GetPlayerName(killerid, asesino, sizeof(asesino));
	GetPlayerName(playerid, jugador, sizeof(jugador));
	format(archivo1, sizeof(archivo1), "Badmin/Usuarios/%s.ini", asesino);
	format(archivo2, sizeof(archivo2), "Badmin/Usuarios/%s.ini", jugador);
	dini_IntSet(archivo1, "Asesinatos", dini_Int(archivo1, "Asesinatos")+1);
	dini_IntSet(archivo2, "Muertes", dini_Int(archivo2, "Muertes")+1);
	return 1;
}
////////////////////////////////////////////////////
public OnPlayerText(playerid, text[])
{
	new archivo[256], usuario[MAX_PLAYER_NAME];
	GetPlayerName(playerid, usuario, sizeof(usuario));
    format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", usuario);
    if(dini_Exists(archivo))
    {
        if(Ingreso[playerid] == 0)
        {
     		SendClientMessage(playerid, COLOR_ROJO, "Debes ingresar para poder hablar. Usa /ingreso [Contraseña].");
            return 0;
		}
	}
	else if(!dini_Exists(archivo))
	{
		SendClientMessage(playerid, COLOR_ROJO, "Debes ingresar para poder hablar. Como no estas registrado, primero usa /registro [Contraseña].");
		return 0;
	}
	if(Callado[playerid] == 1)
	{
	    SendClientMessage(playerid, COLOR_ROJO, "No puedes hablar, ya que te han echo callar.");
	    return 0;
	}
	new string[256];
	format(string, sizeof(string), "[%d]: %s", playerid, text);
	SendPlayerMessageToAll(playerid, string);
	return 0;
}
////////////////////////////////////////////////////
public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[256], idx;
	cmd = strtok(cmdtext, idx);
	
	/* ------------------------> [Comandos de usuarios] <------------------------- */
	if (strcmp("/reportar", cmd, true) == 0)
	{
	    new tmp1[256], tmp2[256], nombrejugador[MAX_PLAYER_NAME], nombrereportado[MAX_PLAYER_NAME], string[256], reportadoid;
	    {
	        tmp1 = strtok(cmdtext, idx);
	        tmp2 = strtok(cmdtext, idx);
	        reportadoid = strval(tmp1);
	        GetPlayerName(playerid, nombrejugador, sizeof(nombrejugador));
	        GetPlayerName(reportadoid, nombrereportado, sizeof(nombrereportado));
	        if (!strlen(tmp1) ||!strlen(tmp2)) return SendClientMessage(playerid, COLOR_ROJO, "Usa: /reportar [ID] [Razon]");
	        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	        format(string, sizeof(string), "El usuario %s [%d] ha reportado al usuario %s [%d] por %s.", nombrejugador, playerid, nombrereportado, reportadoid, cmdtext[10+strval(tmp1)]);
	        SendClientMessage(playerid, COLOR_VERDE_CLARO, "Mensaje enviado a los administradores conectados.");
	        EnviarReporte(string);
	    }
	    return 1;
	}
	if (strcmp("/veradmins", cmd, true) == 0)
	{
		new cantidadadmins;
		for(new i=0; i < MAX_PLAYERS; i++)
		{
			if (EsAdmin[i] == 1) cantidadadmins++;
		}
		if (cantidadadmins == 0) return SendClientMessage(playerid, COLOR_CRIMSON2, "No hay administradores conectados.");
		SendClientMessage(playerid, COLOR_VERDE, "Administradores conectados:");
		for(new i=0; i < MAX_PLAYERS; i++)
		{
			if (EsAdmin[i] == 1)
			{
				new nombre[MAX_PLAYER_NAME], string[256];
				GetPlayerName(i, nombre, MAX_PLAYER_NAME);
				format(string, sizeof(string), "%s - Nivel %d", nombre, NivelAdmin);
				SendClientMessage(playerid, COLOR_VERDE, string);
			}
		}
		return 1;
	}
	if (strcmp("/registro", cmd, true) == 0)
	{
		new tmp[256], usuario[MAX_PLAYER_NAME], archivo[256], string[256];
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, usuario, sizeof(usuario));
		format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", usuario);
        if (dini_Exists(archivo)) return SendClientMessage(playerid, COLOR_ROJO, "Tu nombre ya se encuentra registrado. Usa /ingreso [contraseña] para ingresar.");
        if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_ROJO, "Usa: /registro [Contraseña].");
        if (strlen(tmp) < 4 || strlen(tmp) > 12) return SendClientMessage(playerid, COLOR_ROJO, "Su contraseña debe contener entre 4 y 12 caracteres.");
		dini_Create(archivo);
		dini_Set(archivo, "Usuario", usuario);
		dini_Set(archivo, "Contraseña", cmdtext[10]);
		dini_IntSet(archivo, "Baneado", 0);
		dini_IntSet(archivo, "NivelAdmin", 0);
		dini_IntSet(archivo, "Asesinatos", 0);
		dini_IntSet(archivo, "Muertes", 0);
		dini_IntSet(archivo, "Puntaje", GetPlayerScore(playerid));
		dini_IntSet(archivo, "Dinero", GetPlayerMoney(playerid));
		dini_IntSet(archivo, "PosGuardada(X)", 0);
		dini_IntSet(archivo, "PosGuardada(Y)", 0);
		dini_IntSet(archivo, "PosGuardada(Z)", 0);
		dini_IntSet(archivo, "PosGuardada(Angulo)", 0);
		format(string, sizeof(string), "Te has registrado correctamente! Usa /ingreso %s para ingresar.", cmdtext[10]);
		SendClientMessage(playerid, COLOR_VERDE_OSCURO, string);
		PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
		return 1;
	}
	if (strcmp("/ingreso", cmd, true) == 0)
	{
	    new tmp[256], archivo[256], usuario[MAX_PLAYER_NAME], comprobante1[256], comprobante2[256], string[256];
	    tmp = strtok(cmdtext, idx);
	    GetPlayerName(playerid, usuario, sizeof(usuario));
		format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", usuario);
		if (Ingreso[playerid] == 1) return SendClientMessage(playerid, COLOR_ROJO, "Ya te encuentras identificado.");
        if (!dini_Exists(archivo)) return SendClientMessage(playerid, COLOR_ROJO, "Tu nombre no se encuentra registrado. Usa /registro [contraseña] para registrarte.");
        if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_ROJO, "Usa /ingreso [Contraseña].");
		format(comprobante1, sizeof(comprobante1), "%s", cmdtext[9]);
		format(comprobante2, sizeof(comprobante2), "%s", dini_Get(archivo, "Contraseña"));
		if (!strcmp(comprobante1, comprobante2))
		{
			if (dini_Int(archivo, "Baneado") == 0)
			{
				Ingreso[playerid] = 1;
				NivelAdmin[playerid] = dini_Int(archivo, "NivelAdmin");
				SetPlayerScore(playerid, dini_Int(archivo, "Puntaje"));
				GivePlayerMoney(playerid, dini_Int(archivo, "Dinero")-GetPlayerMoney(playerid));
				SendClientMessage(playerid, COLOR_VERDE_OSCURO, "Has ingresado correctamente!");
				PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
				if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
				{
				    EsAdmin[playerid] = 1;
				}
			}
			else
			{
				format(string, sizeof(string), "%s ha sido auto-kickeado. (Razon: Usuario baneado.)", usuario);
				SendClientMessageToAll(COLOR_NARANJA, string);
				Kick(playerid);
			}
		}
		else return SendClientMessage(playerid, COLOR_ROJO, "Contraseña incorrecta.");
		return 1;
	}
	/* ------------------------> [Comandos de administradores] <------------------------- */
	if (strcmp(cmd, "/acomandos", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new str[477+1];
			format(str, sizeof(str), "%s/anunciar\n/darvida\n/darchaleco\n/darscore\n/eradio\n/dardinero\n/dararma\n/darcolor\n/anuncio\n/darvauto\n/repararveh\n/destruirveh\n/flip\n", str);
			format(str, sizeof(str), "%s/darnitro\n/darcolorveh\n/spec\n/congelar\n/descongelar\n/ir\n/traer\n/limpiarchat\n/cambiarmundo\n/warn\n/mute\n/kick\n/jail\n/quitarjail\n/cambiarinterior\n/darvehiculo\n/darskin\n", str);
			format(str, sizeof(str), "%scambiarhora\n/cambiarclima\n/ban\n/daradmin\n/god\n/vehiculogod\n/jetpack\n/nombreoff\n/nombreon\n/cambiarnombre", str);
			ShowPlayerDialog(playerid, 8531, DIALOG_STYLE_LIST, "Comandos STAFF - Servidor de entrenamientos", str, "Aceptar", "Cancelar");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/anunciar", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], string[256], nombre[MAX_PLAYER_NAME];
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/anunciar [Texto].");
			GetPlayerName(playerid, nombre, MAX_PLAYER_NAME);
			format(string, sizeof(string), "[Admin] %s: %s", nombre, cmdtext[7]);
			SendClientMessageToAll(COLOR_AQUA, string);
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darvida", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:vida;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darvida [ID] [Cantidad].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			vida = float(strval(tmp2));
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has puesto la vida de %s en %f.", nombrejugador, vida);
				format(string2, sizeof(string2), "%s ha puesto tu vida en %f.", nombreadmin, vida);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerHealth(jugador, vida);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darchaleco", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:blindaje;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darchaleco [ID] [Cantidad].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			blindaje = float(strval(tmp2));
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has puesto el blindaje de %s en %f.", nombrejugador, blindaje);
				format(string2, sizeof(string2), "%s ha puesto tu blindaje en %f.", nombreadmin, blindaje);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerArmour(jugador, blindaje);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darscore", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], puntos;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darscore [ID] [Cantidad].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			puntos = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has puesto los puntos de %s en %d.", nombrejugador, puntos);
				format(string2, sizeof(string2), "%s ha puesto tus puntos en %d.", nombreadmin, puntos);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerScore(jugador, puntos);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/eradio", true) == 0)
	{
		if(NivelAdmin[playerid] < 5) return SendClientMessage(playerid, COLOR_CRIMSON2, "Debes tener administrador nivel 5 para usar este comando.");

		if(GetPVarInt(playerid, "EscucharRadios") == 0)
		{
			SetPVarInt(playerid, "EscucharRadios", 1);
			SendClientMessage(playerid, COLOR_NARANJA, "Ahora puedes escuchar todas las radios");
		} else if(GetPVarInt(playerid, "EscucharRadios") == 1){
			SetPVarInt(playerid, "EscucharRadios", 0);
			SendClientMessage(playerid, COLOR_NARANJA, "Ya no puedes escuchar todas las radios");
		}
		return 1;
	}
	if (strcmp(cmd, "/dardinero", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], dinero;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/dardinero [ID] [Cantidad].");
			if (strval(tmp2) < 100 || strval(tmp2) > 1000000) return SendClientMessage(playerid, COLOR_CRIMSON2, "Debes dar entre $100 y $1000000.");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			dinero = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Le has dado $%d a %s.", dinero, nombrejugador);
				format(string2, sizeof(string2), "%s te ha dado $%d.", nombreadmin, dinero);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				GivePlayerMoney(jugador, dinero);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/dararma", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], tmp3[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], arma, municion;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			tmp3 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/dararma [ID] [Arma] [Municion].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			arma = strval(tmp2);
			municion = strval(tmp3);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Le has dado a %s un arma. (ID: %d - Municion: %d)", nombrejugador, arma, municion);
				format(string2, sizeof(string2), "%s te ha dado un arma. (ID: %d - Municion: %d)", nombreadmin, arma, municion);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				GivePlayerWeapon(jugador, arma, municion);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darcolor", true) == 0)
	{
		if (NivelAdmin[playerid] == 1 || NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], color;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darcolor [ID] [ID-Color].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			color = cmdtext[8+strval(tmp1)];
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has cambiado el color de %s. (ID: %d)", nombrejugador, color);
				format(string2, sizeof(string2), "%s ha cambiado tu color. (ID: %d)", nombreadmin, color);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerColor(jugador, color);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/anuncio", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256];
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/anuncio [Texto].");
			GameTextForAll(cmdtext[9], 5000, 3);
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 2 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darvauto", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:vvida;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darvauto [ID] [Cantidad].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			vvida = float(strval(tmp2));
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has puesto la vida del vehiculo de %s en %f.", nombrejugador, vvida);
				format(string2, sizeof(string2), "%s ha puesto la vida de tu vehiculo en %f.", nombreadmin, vvida);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetVehicleHealth(GetPlayerVehicleID(jugador), vvida);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 2 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/repararveh", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/repararveh [ID].");
			jugador = strval(tmp);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (IsPlayerInAnyVehicle(jugador))
			    {
					format(string1, sizeof(string1), "Has reparado el vehiculo de %s.", nombrejugador);
					format(string2, sizeof(string2), "%s ha reparado tu vehiculo.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					RepairVehicle(GetPlayerVehicleID(jugador));
				}
				else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra en un vehiculo.");
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 2 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/destruirveh", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp1 = strtok(cmdtext, idx);
			if (!strlen(tmp1)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/destruirveh [ID].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (IsPlayerInAnyVehicle(jugador))
			    {
					format(string1, sizeof(string1), "Has destruido el vehiculo de %s.", nombrejugador);
					format(string2, sizeof(string2), "%s ha destruido tu vehiculo.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					DestroyVehicle(GetPlayerVehicleID(jugador));
				}
				else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra en un vehiculo.");
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nviel 2 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/flip", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], vehiculo, Float:angulo_z;
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/flip [ID].");
			jugador = strval(tmp);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			vehiculo = GetPlayerVehicleID(jugador);
			angulo_z = GetVehicleZAngle(vehiculo, angulo_z);
			if (IsPlayerConnected(jugador))
			{
			    if (IsPlayerInAnyVehicle(jugador))
			    {
					format(string1, sizeof(string1), "Has flipeado el vehiculo de %s.", nombrejugador);
					format(string2, sizeof(string2), "%s ha flipeado tu vehiculo.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					SetVehicleZAngle(vehiculo, angulo_z);
				}
				else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra en un vehiculo.");
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 1 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darnitro", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darnitro [ID].");
			jugador = strval(tmp);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (IsPlayerInAnyVehicle(jugador))
			    {
					format(string1, sizeof(string1), "Le has añadido nitro al vehiculo de %s.", nombrejugador);
					format(string2, sizeof(string2), "%s le ha añadido nitro a tu vehiculo.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					AddVehicleComponent(GetPlayerVehicleID(jugador), 1010);
				}
				else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra en un vehiculo.");
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 2 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darcolorveh", true) == 0)
	{
		if (NivelAdmin[playerid] == 2 || NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], tmp3[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], vehiculo, color1, color2;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			tmp3 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2) || strlen(tmp3)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darcolorveh [ID] [Color1] [Color2].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			vehiculo = GetVehicleModel(GetPlayerVehicleID(jugador));
			color1 = strval(tmp2);
			color2 = strval(tmp3);
			if (IsPlayerConnected(jugador))
			{
			    if (IsPlayerInAnyVehicle(jugador))
			    {
					format(string1, sizeof(string1), "Has cambiado el color del vehiculo de %s. (Color 1: %d Color 2: %d)", nombrejugador, color1, color2);
					format(string2, sizeof(string2), "%s ha cambiado el color de tu vehiculo. (Color 1: %d Color 2: %d)", nombreadmin, color1, color2);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					ChangeVehicleColor(vehiculo, color1, color2);
				}
				else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra en un vehiculo.");
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 2 para usar este comando.");
		return 1;
	}
    if (strcmp(cmd, "/spec", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, Float:x, Float:y, Float:z, Float:angulo;
		    if (Espiando[playerid] == 0)
		    {
				tmp = strtok(cmdtext, idx);
				if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/spec [ID]. Para dejar de espiar usa /spec nuevamente.");
				jugador = strval(tmp);
				admin = playerid;
				if (strval(tmp) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes espiarte a ti mismo.");
				if (IsPlayerConnected(jugador))
				{
				    Espiando[playerid] = 1;
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					TogglePlayerSpectating(admin, true);
					PlayerSpectatePlayer(admin, jugador, SPECTATE_MODE_NORMAL);
					GetPlayerPos(admin, Float:x, Float:y, Float:z);
					GetPlayerFacingAngle(admin, Float:angulo);
				}
				else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
			}
			else if (Espiando[playerid] == 1)
			{
			    if (strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/spec para dejar de espiar.");
			    Espiando[admin] = 0;
			    TogglePlayerSpectating(admin, false);
			    SetPlayerPos(admin, Float:x, Float:y, Float:z);
				SetPlayerFacingAngle(admin, Float:angulo);
				SetCameraBehindPlayer(admin);
			    PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
			}
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
 }
	if (strcmp(cmd, "/congelar", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], tmp3[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], minutos;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			tmp3 = strtok(cmdtext, idx);
			jugador = strval(tmp1);
			admin = playerid;
			if (!strlen(tmp1) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/congelar [ID] [Minutos] [Razon].");
        	if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes congelarte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			minutos = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
			    if (Congelado[jugador] == 1) return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador se encuentra congelado.");
			    Congelado[jugador] = 1;
				format(string1, sizeof(string1), "%s ha sido congelado durante %d minutos. (Razon: %s.)", nombrejugador, minutos, cmdtext[12+strlen(tmp1)+strlen(tmp2)]);
				format(string2, sizeof(string2), "Has sido congelado por %s durante %d minutos. (Razon: %s.)", nombreadmin, minutos, cmdtext[12+strlen(tmp1)+strlen(tmp2)]);
				format(string3, sizeof(string3), "%s ha sido congelado por %s durante %d minutos. (Razon: %s.)", nombrejugador, nombreadmin, minutos, cmdtext[12+strlen(tmp1)+strlen(tmp2)]);
				SendClientMessage(admin, COLOR_AZUL, string1);
			    SendClientMessage(jugador, COLOR_VERDE, string2);
			    SendClientMessageToAll(COLOR_NARANJA, string3);
				TogglePlayerControllable(jugador, false);
			    SetCameraBehindPlayer(jugador);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				ktdescongelar = SetTimerEx("tdescongelar", minutos*60000, false, "d", jugador);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/descongelar", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp = strtok(cmdtext, idx);
			jugador = strval(tmp);
			admin = playerid;
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/descongelar [ID].");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (Congelado[jugador] == 0) return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra congelado.");
			    Congelado[jugador] = 0;
				format(string1, sizeof(string1), "%s ha sido descongelado.", nombrejugador);
				format(string2, sizeof(string2), "Has sido descongelado por %s.", nombreadmin);
				format(string3, sizeof(string3), "%s ha sido descongelado por %s.", nombrejugador, nombreadmin);
				SendClientMessage(admin, COLOR_AZUL, string1);
			    SendClientMessage(jugador, COLOR_VERDE, string2);
			    SendClientMessageToAll(COLOR_NARANJA, string3);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
			    TogglePlayerControllable(jugador, true);
				SetCameraBehindPlayer(jugador);
				KillTimer(ktdescongelar);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/ir", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, vehiculo, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:x, Float:y, Float:z, Float:angulo;
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/ir [ID].");
			jugador = strval(tmp);
			admin = playerid;
			vehiculo = GetPlayerVehicleID(admin);
			if (strval(tmp) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes ir hacia ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			GetPlayerPos(jugador, Float:x, Float:y, Float:z);
			GetPlayerFacingAngle(jugador, Float:angulo);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has ido a la posicion de %s.", nombrejugador);
				format(string2, sizeof(string2), "%s ha ido a tu posicion.", nombreadmin);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerPos(admin, Float:x+2, Float:y, Float:z);
				SetPlayerInterior(admin, GetPlayerInterior(jugador));
				if (IsPlayerInAnyVehicle(admin))
				{
					SetVehiclePos(vehiculo, Float:x+2, Float:y, Float:z);
					PutPlayerInVehicle(admin, vehiculo, 0);
				}
				SetPlayerFacingAngle(admin, Float:angulo);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/traer", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, vehiculo, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:x, Float:y, Float:z, Float:angulo;
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/traer [ID].");
			jugador = strval(tmp);
			admin = playerid;
			vehiculo = GetPlayerVehicleID(jugador);
			if (strval(tmp) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes traerte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			GetPlayerPos(admin, Float:x, Float:y, Float:z);
			GetPlayerFacingAngle(admin, Float:angulo);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has traido a %s a tu posicion.", nombrejugador);
				format(string2, sizeof(string2), "Has sido traido a la posicion de %s.", nombreadmin);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerPos(jugador, Float:x+2, Float:y, Float:z);
				SetPlayerInterior(jugador, GetPlayerInterior(admin));
				if(IsPlayerInAnyVehicle(jugador))
				{
					SetVehiclePos(vehiculo, Float:x+2, Float:y, Float:z);
					PutPlayerInVehicle(jugador, vehiculo, 0);
				}
				SetPlayerFacingAngle(jugador, Float:angulo);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/limpiarchat", true) == 0)
	{
	    if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
	    {
	 	   new nombre[MAX_PLAYER_NAME], string[256];
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	       SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   SendClientMessageToAll(COLOR_CRIMSON2, " ");
	 	   GetPlayerName(playerid, nombre, sizeof(nombre));
	 	   format(string, sizeof(string), "%s ha limpiado el chat.", nombre);
	 	   SendClientMessageToAll(COLOR_VERDE, string);
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/cambiarmundo", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], mundo;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/cambiarmundo [ID] [Mundo].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			mundo = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has puesto a %s en el mundo %d.", nombrejugador, mundo);
				format(string2, sizeof(string2), "%s te ha puesto en el mundo %d.", nombreadmin, mundo);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerVirtualWorld(jugador, mundo);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/warn", true) == 0)
	{
		if (NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/warn [ID] [Razon].");
			jugador = strval(tmp1);
			admin = playerid;
			if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes advertirte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (Advertido[jugador] == 0)
			    {
			        Advertido[jugador] = 1;
					format(string1, sizeof(string1), "%s ha sido advertido. (Razon: %s.) (1/3)", nombrejugador, cmdtext[11+strlen(tmp1)]);
					format(string2, sizeof(string2), "Has sido advertido por %s. (Razon: %s.) (1/3)", nombreadmin, cmdtext[11+strlen(tmp1)]);
					format(string3, sizeof(string3), "%s ha sido advertido por %s. (Razon: %s.) (1/3)", nombrejugador, nombreadmin, cmdtext[11+strlen(tmp1)]);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					SendClientMessageToAll(COLOR_NARANJA, string3);
    				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
    				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				}
				else if (Advertido[jugador] == 1)
				{
				    Advertido[jugador] = 2;
				    format(string1, sizeof(string1), "%s ha sido advertido. (Razon: %s.) (2/3)", nombrejugador, cmdtext[11+strlen(tmp1)]);
					format(string2, sizeof(string2), "Has sido advertido por %s. (Razon: %s.) (2/3)", nombreadmin, cmdtext[11+strlen(tmp1)]);
					format(string3, sizeof(string3), "%s ha sido advertido por %s. (Razon: %s.) (2/3)", nombrejugador, nombreadmin, cmdtext[11+strlen(tmp1)]);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					SendClientMessageToAll(COLOR_NARANJA, string3);
    				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
    				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				}
				else if (Advertido[jugador] == 2)
				{
				    format(string1, sizeof(string1), "%s ha sido advertido. (Razon: %s.) (3/3)", nombrejugador, cmdtext[11+strlen(tmp1)]);
					format(string2, sizeof(string2), "Has sido advertido por %s. (Razon: %s.) (3/3)", nombreadmin, cmdtext[11+strlen(tmp1)]);
					format(string3, sizeof(string3), "%s ha sido advertido por %s. (Razon: %s.) (3/3)", nombrejugador, nombreadmin, cmdtext[11+strlen(tmp1)]);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					SendClientMessageToAll(COLOR_NARANJA, string3);
    				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
    				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
    				Kick(jugador);
				}
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/mute", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], string3[256], string4[256], string5[256], string6[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/mute [ID] [Razon]. Para que deje de estar callado, usa /mute [ID].");
			jugador = strval(tmp1);
			admin = playerid;
			if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes callarte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (Callado[jugador] == 0)
			    {
					format(string4, 256, "%s ha sido callado. (Razon: %s.)", nombrejugador, cmdtext[9+strlen(tmp1)]);
					format(string5, 256, "Has sido callado por %s. (Razon: %s.)", nombreadmin, cmdtext[9+strlen(tmp1)]);
					format(string6, 256, "%s ha sido callado por %s. (Razon: %s.)", nombrejugador, nombreadmin, cmdtext[9+strlen(tmp1)]);
					SendClientMessage(admin, COLOR_AZUL, string4);
					SendClientMessage(jugador, COLOR_VERDE, string5);
					SendClientMessageToAll(COLOR_NARANJA, string6);
    				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
    				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
    				Callado[jugador] = 1;
				}
				else if (Callado[jugador] == 1)
				{
				    format(string1, sizeof(string1), "%s ha dejado de ser callado.", nombrejugador, cmdtext[9+strlen(tmp1)]);
					format(string2, sizeof(string2), "Has dejado de estar callado por %s.", nombreadmin, cmdtext[9+strlen(tmp1)]);
					format(string3, sizeof(string3), "%s ha dejado de estar callado por %s.", nombrejugador, nombreadmin, cmdtext[9+strlen(tmp1)]);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					SendClientMessageToAll(COLOR_NARANJA, string3);
    				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
    				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
    				Callado[jugador] = 0;
				}
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/kick", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			jugador = strval(tmp1);
			admin = playerid;
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/kick [ID] [Razon].");
        	if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes kickearte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "%s ha sido kickeado. (Razon: %s.)", nombrejugador, cmdtext[7+strlen(tmp1)]);
				format(string2, sizeof(string2), "Has sido kickeado por %s. (Razon: %s.)", nombreadmin, cmdtext[7+strlen(tmp1)]);
				format(string3, sizeof(string3), "%s ha sido kickeado por %s. (Razon: %s.)", nombrejugador, nombreadmin, cmdtext[7+strlen(tmp1)]);
				SendClientMessage(admin, COLOR_AZUL, string1);
			    SendClientMessage(jugador, COLOR_VERDE, string2);
			    SendClientMessageToAll(COLOR_NARANJA, string3);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				Kick(jugador);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/jail", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], tmp3[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], minutos;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			tmp3 = strtok(cmdtext, idx);
			jugador = strval(tmp1);
			admin = playerid;
			if (!strlen(tmp1) || !strlen(tmp2) || !strlen(tmp3)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/jail [ID] [Minutos] [Razon].");
        	if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes encarcelarte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			minutos = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
			    if (Encarcelado[jugador] == 1) return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador se encuentra encarcelado.");
			    Encarcelado[jugador] = 1;
				format(string1, sizeof(string1), "%s ha sido encarcelado durante %d minutos. (Razon: %s.)", nombrejugador, minutos, cmdtext[14+strlen(tmp1)+strlen(tmp2)]);
				format(string2, sizeof(string2), "Has sido encarcelado por %s durante %d minutos. (Razon: %s.)", nombreadmin, minutos, cmdtext[14+strlen(tmp1)+strlen(tmp2)]);
				format(string3, sizeof(string3), "%s ha sido encarcelado por %s durante %d minutos. (Razon: %s.)", nombrejugador, nombreadmin, minutos, cmdtext[14+strlen(tmp1)+strlen(tmp2)]);
				SendClientMessage(admin, COLOR_AZUL, string1);
			    SendClientMessage(jugador, COLOR_VERDE, string2);
			    SendClientMessageToAll(COLOR_NARANJA, string3);
			    SetPlayerPos(jugador, 264.3726, 77.2826, 1001.0391);
			    SetPlayerFacingAngle(jugador, 269.9999);
			    SetPlayerInterior(jugador, 6);
			    SetCameraBehindPlayer(jugador);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				ktdesencarcelar = SetTimerEx("tdesencarcelar", minutos*60000, false, "d", jugador);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/quitarjail", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME];
			tmp = strtok(cmdtext, idx);
			jugador = strval(tmp);
			admin = playerid;
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "Usa: /quitarjail [ID].");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
			    if (Encarcelado[jugador] == 0) return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra encarcelado.");
			    Encarcelado[jugador] = 0;
				format(string1, sizeof(string1), "%s ha sido desencarcelado.", nombrejugador);
				format(string2, sizeof(string2), "Has sido desencarcelado por %s.", nombreadmin);
				format(string3, sizeof(string3), "%s ha sido desencarcelado por %s.", nombrejugador, nombreadmin);
				SendClientMessage(admin, COLOR_AZUL, string1);
			    SendClientMessage(jugador, COLOR_VERDE, string2);
			    SendClientMessageToAll(COLOR_NARANJA, string3);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
			    SetPlayerPos(jugador, 264.1163, 82.0803, 1001.0391);
				SetPlayerFacingAngle(jugador, 269.0000);
				SetPlayerInterior(jugador, 6);
				SetCameraBehindPlayer(jugador);
				KillTimer(ktdesencarcelar);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/cambiarinterior", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], interior;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "Usa: /cambiarinterior [ID] [Interior].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			interior = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has puesto a %s en el interior %d.", nombrejugador, interior);
				format(string2, sizeof(string2), "%s  te ha puesto en el interior %d.", nombreadmin, interior);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerInterior(jugador, interior);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darvehiculo", true) == 0)
	{
		if (NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], tmp3[256], tmp4[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:x, Float:y, Float:z, Float:angulo, vehiculo, color1, color2, idvehiculo;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			tmp3 = strtok(cmdtext, idx);
			tmp4 = strtok(cmdtext, idx);
			if (!strlen(tmp1)) return SendClientMessage(playerid, COLOR_CRIMSON2, "Debes especificar un jugador.");
			if (!strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "Debes especificar un vehiculo.");
			jugador = strval(tmp1);
			admin = playerid;
			if (IsPlayerInAnyVehicle(jugador)) return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador se encuentra en un vehiculo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			GetPlayerPos(jugador, Float:x, Float:y, Float:z);
			GetPlayerFacingAngle(jugador, Float:angulo);
			vehiculo = strval(tmp2);
			color1 = strval(tmp3);
			color2 = strval(tmp4);
			if (!IsNumeric(tmp2)) vehiculo = GetVehicleModelIDFromName(tmp2);
			//if (strval(tmp2) < 400 || strval(tmp2) > 611) return SendClientMessage(playerid, COLOR_CRIMSON2, "Vehiculo invalido. Elige entre 400 y 611.");
			if (!strlen(tmp3)) color1 = random(126); else color1 = strval(tmp3);
			if (!strlen(tmp4)) color2 = random(126); else color2 = strval(tmp4);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Le has dado a %s un vehiculo. (ID: %d - Color 1: %d - Color 2: %d)", nombrejugador, vehiculo, color1, color2);
				format(string2, sizeof(string2), "%s te ha dado un vehiculo. (ID: %d - Color 1: %d - Color 2: %d)", nombreadmin, vehiculo, color1, color2);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				idvehiculo = CreateVehicle(vehiculo, Float:x, Float:y, Float:z, Float:angulo, color1, color2, 0);
				PutPlayerInVehicle(jugador, idvehiculo, 0);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/darskin", true) == 0)
	{
		if (NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], skin;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/darskin [ID] [Skin].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			skin = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has cambiado el skin de %s. (ID: %d)", nombrejugador, skin);
				format(string2, sizeof(string2), "%s ha cambiado tu skin. (ID: %d)", nombreadmin, skin);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerSkin(jugador, skin);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/cambiarhora", true) == 0)
	{
		if (NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], admin, string[256], nombreadmin[MAX_PLAYER_NAME], hora, minuto;
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/cambiarhora [Hora] [Minuto].");
			admin = playerid;
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			hora = strval(tmp1);
			minuto = strval(tmp2);
			format(string, sizeof(string), "%s ha puesto la hora en %d:%d.", nombreadmin, hora, minuto);
			SendClientMessageToAll(COLOR_NARANJA, string);
			PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
			for(new i=0; i < MAX_PLAYERS; i++)
			{
				SetPlayerTime(i, hora, minuto);
			}
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/cambiarclima", true) == 0)
	{
		if (NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp[256], admin, string[256], nombreadmin[MAX_PLAYER_NAME], clima;
			tmp = strtok(cmdtext, idx);
			if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/cambiarclima [Clma].");
			admin = playerid;
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			clima = strval(tmp);
			format(string, sizeof(string), "%s ha cambiado el clima. (ID: %d.)", nombreadmin, clima);
			SendClientMessageToAll(COLOR_NARANJA, string);
			PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
			for(new i=0; i < MAX_PLAYERS; i++)
			{
				SetPlayerWeather(i, clima);
			}
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 4 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/ban", true) == 0)
	{
		if (NivelAdmin[playerid] == 3 || NivelAdmin[playerid] == 4 || NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], string3[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], archivo[256];
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			jugador = strval(tmp1);
			admin = playerid;
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/ban [ID] [Razon].");
			if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes banearte a ti mismo.");
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "%s ha sido baneado. (Razon: %s.)", nombrejugador, cmdtext[6+strlen(tmp1)]);
				format(string2, sizeof(string2), "Has sido baneado por %s. (Razon: %s.)", nombreadmin, cmdtext[6+strlen(tmp1)]);
				format(string3, sizeof(string3), "%s ha sido baneado por %s. (Razon: %s.)", nombrejugador, nombreadmin, cmdtext[6+strlen(tmp1)]);
				SendClientMessage(admin, COLOR_AZUL, string1);
			    SendClientMessage(jugador, COLOR_VERDE, string2);
			    SendClientMessageToAll(COLOR_NARANJA, string3);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				Ban(jugador);
				format(archivo, sizeof(archivo), "%s.ini", nombrejugador);
				dini_IntSet(archivo, "Baneado", 1);
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 3 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/daradmin", true) == 0)
	{
		if (NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], nivel, archivo[256];
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/daradmin [ID] [Nivel].");
			if (strval(tmp2) < 0 || strval(tmp2) > 5) return SendClientMessage(playerid, COLOR_CRIMSON2, "Debes elegir un nivel de 0 a 5.");
			if (strval(tmp1) == admin) return SendClientMessage(playerid, COLOR_CRIMSON2, "No puedes cambiar tu propio nivel.");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			nivel = strval(tmp2);
			if (IsPlayerConnected(jugador))
			{
			    NivelAdmin[jugador] = nivel;
			    EsAdmin[jugador] = 1;
				format(string1, sizeof(string1), "Has puesto el nivel de administrador de %s en %d.", nombrejugador, nivel);
				format(string2, sizeof(string2), "%s ha puesto tu nivel de administrador en %d.", nombreadmin, nivel);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", nombrejugador);
				if (dini_Exists(archivo))
				{
					dini_IntSet(archivo, "NivelAdmin", nivel);
				}
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/god", true) == 0)
	{
	    if (NivelAdmin[playerid] == 5)
	    {
	        new tmp[256], jugador, admin, string1[256], string2[256], string3[256], string4[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:vida;
	        tmp = strtok(cmdtext, idx);
	        if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/dios [ID]. Para desactivar el modo dios, usa /god [ID] nuevamente.");
	        jugador = strval(tmp);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
	        GetPlayerHealth(jugador, vida);
	        if (IsPlayerConnected(jugador))
	        {
	    		if (Dios[jugador] == 0)
	    		{
	    			Dios[jugador] = 1;
                    format(string1, sizeof(string1), "Has echo imortal a %s.", nombrejugador);
					format(string2, sizeof(string2), "%s te ha echo imortal.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					SetPlayerHealth(jugador, 100000);
				}
				else if (Dios[jugador] == 1)
				{
				    Dios[jugador] = 0;
				    format(string3, sizeof(string3), "Le has quitado la imortalidad a %s.", nombrejugador);
					format(string4, 256, "%s te ha quitado la imortalidad.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string3);
					SendClientMessage(jugador, COLOR_VERDE, string4);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					SetPlayerHealth(jugador, vida);
			    }
			}
            else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando.");
		return 1;
	}
	if (strcmp(cmd, "/vehiculogod", true) == 0)
	{
	    if (NivelAdmin[playerid] == 5)
	    {
	        new tmp[256], jugador, admin, string1[256], string2[256], string3[256], string4[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], Float:vida;
	        tmp = strtok(cmdtext, idx);
	        if (!strlen(tmp)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/vehiculogod [ID]. Para desactivar el modo dios, usa /vehiculogod [ID] nuevamente.");
	        jugador = strval(tmp);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
	        GetVehicleHealth(GetPlayerVehicleID(jugador), vida);
	        if (IsPlayerConnected(jugador))
	        {
	    		if (VDios[jugador] == 0)
	    		{
	    			VDios[jugador] = 1;
                    format(string1, sizeof(string1), "Has echo indestructibles los vehiculos de %s.", nombrejugador);
					format(string2, sizeof(string2), "%s ha echo que tus vehiculos sean indestructibles.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string1);
					SendClientMessage(jugador, COLOR_VERDE, string2);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					ktvdios = SetTimerEx("tvdios", 0, true, "d", jugador);
				}
				else if (VDios[jugador] == 1)
				{
				    VDios[jugador] = 0;
				    format(string3, sizeof(string3), "Le has quitado la idestructibilidad de vehiculos a %s.", nombrejugador);
					format(string4, 256, "%s te ha quitado la indestructibilidad de vehiculos.", nombreadmin);
					SendClientMessage(admin, COLOR_AZUL, string3);
					SendClientMessage(jugador, COLOR_VERDE, string4);
					PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
					PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
					KillTimer(ktvdios);
			    }
			}
            else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando.");
		return 1;
	}
	if (strcmp("/jetpack", cmd, true) == 0)
	{
		if(NivelAdmin[playerid] == 5)
		{
		SetPlayerSpecialAction(playerid, 2);
		SendClientMessage(playerid, COLOR_CRIMSON2, "Has spawneado un jetpack");
		SendClientMessage(playerid, COLOR_CRIMSON2, "No debes dejar el jetpack tirado o un recluta lo recogera y podría ser baneado");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando");
		return 1;
	}
	if (strcmp("/nombreoff", cmd, true) == 0)
	{
		if(NivelAdmin[playerid] == 5)
			{
				ShowNameTags(0);
				SendClientMessageToAll(COLOR_CRIMSON2, "Los nombres de los jugadores se han ocultado");
			}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando");
		return 1;
	}
	if (strcmp("/nombreon", cmd, true) == 0)
	{
		if(NivelAdmin[playerid] == 5)
			{
			ShowNameTags(1);
			SendClientMessageToAll(COLOR_CRIMSON2, "Los nombres de los jugadores se han restablecido");
			}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando");
		return 1;
	}


	if (strcmp(cmd, "/cambiarnombre", true) == 0)
	{
		if (NivelAdmin[playerid] == 5)
		{
			new tmp1[256], tmp2[256], jugador, admin, string1[256], string2[256], nombrejugador[MAX_PLAYER_NAME], nombreadmin[MAX_PLAYER_NAME], archivo[256];
			tmp1 = strtok(cmdtext, idx);
			tmp2 = strtok(cmdtext, idx);
			if (!strlen(tmp1) || !strlen(tmp2)) return SendClientMessage(playerid, COLOR_CRIMSON2, "/cambiarnombre [ID] [Nombre].");
			jugador = strval(tmp1);
			admin = playerid;
			GetPlayerName(jugador, nombrejugador, sizeof(nombrejugador));
			GetPlayerName(admin, nombreadmin, sizeof(nombreadmin));
			if (IsPlayerConnected(jugador))
			{
				format(string1, sizeof(string1), "Has cambiado el nombre de de %s a %s.", nombrejugador, cmdtext[9+strlen(tmp1)]);
				format(string2, sizeof(string2), "%s ha cambiado tu nombre a %s.", nombreadmin, cmdtext[9+strlen(tmp1)]);
				SendClientMessage(admin, COLOR_AZUL, string1);
				SendClientMessage(jugador, COLOR_VERDE, string2);
				PlayerPlaySound(admin, 1057, 0.0, 0.0, 0.0);
				PlayerPlaySound(jugador, 1057, 0.0, 0.0, 0.0);
				SetPlayerName(jugador, cmdtext[9+strlen(tmp1)]);
				ForceClassSelection(jugador);
				SetPlayerHealth(jugador, 0.0);
				Ingreso[jugador] = 0;
				format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", cmdtext[9+strlen(tmp1)]);
				if (dini_Exists(archivo)) return SendClientMessage(playerid, COLOR_VERDE, "Tu nombre se encuentra registrado. Usa /ingreso [contraseña] para ingresar.");
				if (!dini_Exists(archivo)) return SendClientMessage(playerid, COLOR_VERDE, "Tu nombre no se encuentra registrado. Usa /registro [contraseña] para registrarte.");
			}
			else return SendClientMessage(playerid, COLOR_CRIMSON2, "El jugador no se encuentra conectado.");
		}
		else return SendClientMessage(playerid, COLOR_CRIMSON2, "Necesitas ser administrador nivel 5 para usar este comando.");
		return 1;
	}
	return 0;
}

public OnPlayerRequestSpawn(playerid)
{
    new archivo[256], usuario[MAX_PLAYER_NAME];
	GetPlayerName(playerid, usuario, sizeof(usuario));
    format(archivo, sizeof(archivo), "Badmin/Usuarios/%s.ini", usuario);
    if(dini_Exists(archivo))
    {
        if(Ingreso[playerid] == 0)
        {
     		SendClientMessage(playerid, COLOR_ROJO, "Debes ingresar antes de spawnear. Usa /ingreso [Contraseña].");
            return 0;
		}
	}
	else if(!dini_Exists(archivo))
	{
		SendClientMessage(playerid, COLOR_ROJO, "Debes ingresar antes de spawnear. Como no estas registrado, primero usa /registro [Contraseña].");
		return 0;
	}
	return 1;
}
////////////////////////////////////////////////////
public tvdios(playerid)
{
	if (IsPlayerInAnyVehicle(playerid))
	{
	    RepairVehicle(GetPlayerVehicleID(playerid));
	}
	return 1;
}
////////////////////////////////////////////////////
public tdescongelar(playerid)
{
    Congelado[playerid] = 0;
    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    TogglePlayerControllable(playerid, true);
	SetCameraBehindPlayer(playerid);
	return 1;
}
////////////////////////////////////////////////////
public tdesencarcelar(playerid)
{
    Encarcelado[playerid] = 0;
    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    SetPlayerPos(playerid, 264.1163, 82.0803, 1001.0391);
	SetPlayerFacingAngle(playerid, 269.0000);
	SetPlayerInterior(playerid, 6);
	SetCameraBehindPlayer(playerid);
	return 1;
}
////////////////////////////////////////////////////

////////////////////////////////////////////////////
stock MensajeAdmin(playerid, const str[])
{
	new nombre[MAX_PLAYER_NAME], string[256];
	GetPlayerName(playerid, nombre, sizeof(nombre));
	format(string, sizeof(string), "[Administrador] %s les recuerda no usar hacks, mods o cualquier otro tipo de cheats.", nombre, str);
	for(new adminid=0; adminid <MAX_PLAYERS; adminid++)
	{
		if (EsAdmin[adminid] == 1)
		{
			SendClientMessage(adminid, COLOR_AMARILLO, string);
		}
	}
	return 1;
}
////////////////////////////////////////////////////
stock EnviarReporte(const string[])
{
	for(new adminid=0; adminid <MAX_PLAYERS; adminid++)
	{
		if (EsAdmin[adminid] == 1)
		{
			SendClientMessage(adminid, COLOR_AMARILLO, string);
		}
	}
	return 1;
}
////////////////////////////////////////////////////
stock GetVehicleModelIDFromName(vname[])
{
	for(new i = 0; i < 211; i++)
	{
		if ( strfind(Vehiculos[i], vname, true) != -1 )
			return i + 400;
	}
	return -1;
}
////////////////////////////////////////////////////
stock IsNumeric(const string[])
{
	new length=strlen(string);
	if(length==0)
	{
		return 0;
	}
	for (new i=0; i<length; i++)
	{
		if (!((string[i] <= '9' && string[i] >= '0') || (i==0 && (string[i]=='-' || string[i]=='+'))))
		{
			return false;
		}
	}
	return 0;
}
////////////////////////////////////////////////////
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
/* ------------------------> [Fin del script] <------------------------- */
// Por bruunosoniico
