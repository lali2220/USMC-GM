//----------------CREDITS------------------
// Author: KARAN007
// Filterscript: S.W.A.T Rappelling/roping v2
// Release Date: 20/03/2015
// Last Edited/Updated:    N/A
// NOTE: DO NOT CLAIM THIS FILTERSCRIPT AS YOURS!
//-----------------------------------------
#include <a_samp>
#pragma tabsize 0
#include <zcmd>

new rope[58];

public OnFilterScriptInit()
{
      print("Sistema de RAPPEL cargado!");
      return 1;
}


CMD:br(playerid,params[])
{
       if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0x33CCFFAA, "Debes estar fuera de un vehiculo!");
       if(GetPVarInt(playerid,"rappelling") == 1) return SendClientMessage(playerid, 0x33CCFFAA, "Usted ya esta usando la cuerda!");
	   new Float:X, Float:Y, Float:Z,Float:Angle;
	   GetPlayerPos(playerid, X, Y, Z);
       GetXYInFrontOfPlayer(playerid, X, Y, 5.0);
	   SetPlayerPos(playerid, X, Y, Z);
	   SetPlayerHealth(playerid, 1000);
       SetPVarInt(playerid,"rappelling",1);
       GameTextForPlayer(playerid, "~G~Bajando por la cuerda", 5000, 1);
       rope[1] = CreateObject(19089, X, Y, Z+5, 0, 0, Angle);
       rope[2] = CreateObject(19089, X, Y, Z+3, 0, 0, Angle);
       rope[3] = CreateObject(19089, X, Y, Z+1, 0, 0, Angle);
       rope[4] = CreateObject(19089, X, Y, Z-2, 0, 0, Angle);
       rope[5] = CreateObject(19089, X, Y, Z-5, 0, 0, Angle);
       rope[6] = CreateObject(19089, X, Y, Z-7, 0, 0, Angle);
       rope[7] = CreateObject(19089, X, Y, Z-9, 0, 0, Angle);
       rope[8] = CreateObject(19089, X, Y, Z-10, 0, 0, Angle);
       rope[9] = CreateObject(19089, X, Y, Z-12, 0, 0, Angle);
       rope[10] = CreateObject(19089, X, Y, Z-17, 0, 0, Angle);
       rope[11] = CreateObject(19089, X, Y, Z-25, 0, 0, Angle);
       rope[12] = CreateObject(19089, X, Y, Z-28, 0, 0, Angle);
       rope[13] = CreateObject(19089, X, Y, Z-31, 0, 0, Angle);
       rope[14] = CreateObject(19089, X, Y, Z-34, 0, 0, Angle);
       rope[15] = CreateObject(19089, X, Y, Z-38, 0, 0, Angle);
       rope[16] = CreateObject(19089, X, Y, Z-41, 0, 0, Angle);
       rope[17] = CreateObject(19089, X, Y, Z-45, 0, 0, Angle);
       rope[18] = CreateObject(19089, X, Y, Z-49, 0, 0, Angle);
       rope[19] = CreateObject(19089, X, Y, Z-51, 0, 0, Angle);
       rope[20] = CreateObject(19089, X, Y, Z-57, 0, 0, Angle);
       rope[21] = CreateObject(19089, X, Y, Z-61, 0, 0, Angle);
       rope[22] = CreateObject(19089, X, Y, Z-65, 0, 0, Angle);
       rope[23] = CreateObject(19089, X, Y, Z-69, 0, 0, Angle);
       rope[24] = CreateObject(19089, X, Y, Z-73, 0, 0, Angle);
       rope[25] = CreateObject(19089, X, Y, Z-77, 0, 0, Angle);
       rope[26] = CreateObject(19089, X, Y, Z-80, 0, 0, Angle);
       rope[27] = CreateObject(19089, X, Y, Z-85, 0, 0, Angle);
       rope[28] = CreateObject(19089, X, Y, Z-89, 0, 0, Angle);
       rope[29] = CreateObject(19089, X, Y, Z-90, 0, 0, Angle);
       rope[30] = CreateObject(19089, X, Y, Z-95, 0, 0, Angle);
       rope[31] = CreateObject(19089, X, Y, Z-87, 0, 0, Angle);
       rope[32] = CreateObject(19089, X, Y, Z-100, 0, 0, Angle);
       rope[33] = CreateObject(19089, X, Y, Z-105, 0, 0, Angle);
       rope[34] = CreateObject(19089, X, Y, Z-110, 0, 0, Angle);
       rope[35] = CreateObject(19089, X, Y, Z-115, 0, 0, Angle);
       rope[36] = CreateObject(19089, X, Y, Z-120, 0, 0, Angle);
       rope[37] = CreateObject(19089, X, Y, Z-125, 0, 0, Angle);
       rope[38] = CreateObject(19089, X, Y, Z-130, 0, 0, Angle);
       rope[39] = CreateObject(19089, X, Y, Z-135, 0, 0, Angle);
       rope[40] = CreateObject(19089, X, Y, Z-140, 0, 0, Angle);
       rope[41] = CreateObject(19089, X, Y, Z-145, 0, 0, Angle);
       rope[42] = CreateObject(19089, X, Y, Z-150, 0, 0, Angle);
       rope[43] = CreateObject(19089, X, Y, Z-155, 0, 0, Angle);
       rope[45] = CreateObject(19089, X, Y, Z-160, 0, 0, Angle);
       rope[46] = CreateObject(19089, X, Y, Z-165, 0, 0, Angle);
       rope[47] = CreateObject(19089, X, Y, Z-170, 0, 0, Angle);
       rope[48] = CreateObject(19089, X, Y, Z-175, 0, 0, Angle);
       rope[49] = CreateObject(19089, X, Y, Z-180, 0, 0, Angle);
       rope[50] = CreateObject(19089, X, Y, Z-185, 0, 0, Angle);
       rope[51] = CreateObject(19089, X, Y, Z-190, 0, 0, Angle);
       rope[52] = CreateObject(19089, X, Y, Z-195, 0, 0, Angle);
       rope[53] = CreateObject(19089, X, Y, Z-200, 0, 0, Angle);
       rope[54] = CreateObject(19089, X, Y, Z-205, 0, 0, Angle);
       rope[55] = CreateObject(19089, X, Y, Z-210, 0, 0, Angle);
       rope[56] = CreateObject(19089, X, Y, Z-215, 0, 0, Angle);
       rope[57] = CreateObject(19089, X, Y, Z-220, 0, 0, Angle);
       ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
  return 1;
}
CMD:hr(playerid,params[])
{
       if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0x33CCFFAA,"Usted debe estar en un Maverick de Policia!");
	   if(GetPVarInt(playerid,"rappelling") == 1) return SendClientMessage(playerid, 0x33CCFFAA, "Usted ya está bajando!");
       {
       RemovePlayerFromVehicle(playerid);
       new Float:X, Float:Y, Float:Z,Float:Angle;
       GetPlayerPos(playerid, X, Y, Z);
       SetPlayerPos(playerid, X, Y, Z-5);
       GetPlayerFacingAngle(playerid, Angle);
       GameTextForPlayer(playerid, "~G~Bajando por la cuerda", 5000, 1);
       SetPlayerHealth(playerid, 1000);
       SetPVarInt(playerid,"rappelling",1);
       rope[1] = CreateObject(19089, X, Y, Z+5, 0, 0, Angle);
       rope[2] = CreateObject(19089, X, Y, Z+3, 0, 0, Angle);
       rope[3] = CreateObject(19089, X, Y, Z+1, 0, 0, Angle);
       rope[4] = CreateObject(19089, X, Y, Z-2, 0, 0, Angle);
       rope[5] = CreateObject(19089, X, Y, Z-5, 0, 0, Angle);
       rope[6] = CreateObject(19089, X, Y, Z-7, 0, 0, Angle);
       rope[7] = CreateObject(19089, X, Y, Z-9, 0, 0, Angle);
       rope[8] = CreateObject(19089, X, Y, Z-10, 0, 0, Angle);
       rope[9] = CreateObject(19089, X, Y, Z-12, 0, 0, Angle);
       rope[10] = CreateObject(19089, X, Y, Z-17, 0, 0, Angle);
       rope[11] = CreateObject(19089, X, Y, Z-25, 0, 0, Angle);
       rope[12] = CreateObject(19089, X, Y, Z-28, 0, 0, Angle);
       rope[13] = CreateObject(19089, X, Y, Z-31, 0, 0, Angle);
       rope[14] = CreateObject(19089, X, Y, Z-34, 0, 0, Angle);
       rope[15] = CreateObject(19089, X, Y, Z-38, 0, 0, Angle);
       rope[16] = CreateObject(19089, X, Y, Z-41, 0, 0, Angle);
       rope[17] = CreateObject(19089, X, Y, Z-45, 0, 0, Angle);
       rope[18] = CreateObject(19089, X, Y, Z-49, 0, 0, Angle);
       rope[19] = CreateObject(19089, X, Y, Z-51, 0, 0, Angle);
       rope[20] = CreateObject(19089, X, Y, Z-57, 0, 0, Angle);
       rope[21] = CreateObject(19089, X, Y, Z-61, 0, 0, Angle);
       rope[22] = CreateObject(19089, X, Y, Z-65, 0, 0, Angle);
       rope[23] = CreateObject(19089, X, Y, Z-69, 0, 0, Angle);
       rope[24] = CreateObject(19089, X, Y, Z-73, 0, 0, Angle);
       rope[25] = CreateObject(19089, X, Y, Z-77, 0, 0, Angle);
       rope[26] = CreateObject(19089, X, Y, Z-80, 0, 0, Angle);
       rope[27] = CreateObject(19089, X, Y, Z-85, 0, 0, Angle);
       rope[28] = CreateObject(19089, X, Y, Z-89, 0, 0, Angle);
       rope[29] = CreateObject(19089, X, Y, Z-90, 0, 0, Angle);
       rope[30] = CreateObject(19089, X, Y, Z-95, 0, 0, Angle);
       rope[31] = CreateObject(19089, X, Y, Z-87, 0, 0, Angle);
       rope[32] = CreateObject(19089, X, Y, Z-100, 0, 0, Angle);
       rope[33] = CreateObject(19089, X, Y, Z-105, 0, 0, Angle);
       rope[34] = CreateObject(19089, X, Y, Z-110, 0, 0, Angle);
       rope[35] = CreateObject(19089, X, Y, Z-115, 0, 0, Angle);
       rope[36] = CreateObject(19089, X, Y, Z-120, 0, 0, Angle);
       rope[37] = CreateObject(19089, X, Y, Z-125, 0, 0, Angle);
       rope[38] = CreateObject(19089, X, Y, Z-130, 0, 0, Angle);
       rope[39] = CreateObject(19089, X, Y, Z-135, 0, 0, Angle);
       rope[40] = CreateObject(19089, X, Y, Z-140, 0, 0, Angle);
       rope[41] = CreateObject(19089, X, Y, Z-145, 0, 0, Angle);
       rope[42] = CreateObject(19089, X, Y, Z-150, 0, 0, Angle);
       rope[43] = CreateObject(19089, X, Y, Z-155, 0, 0, Angle);
       rope[45] = CreateObject(19089, X, Y, Z-160, 0, 0, Angle);
       rope[46] = CreateObject(19089, X, Y, Z-165, 0, 0, Angle);
       rope[47] = CreateObject(19089, X, Y, Z-170, 0, 0, Angle);
       rope[48] = CreateObject(19089, X, Y, Z-175, 0, 0, Angle);
       rope[49] = CreateObject(19089, X, Y, Z-180, 0, 0, Angle);
       rope[50] = CreateObject(19089, X, Y, Z-185, 0, 0, Angle);
       rope[51] = CreateObject(19089, X, Y, Z-190, 0, 0, Angle);
       rope[52] = CreateObject(19089, X, Y, Z-195, 0, 0, Angle);
       rope[53] = CreateObject(19089, X, Y, Z-200, 0, 0, Angle);
       rope[54] = CreateObject(19089, X, Y, Z-205, 0, 0, Angle);
       rope[55] = CreateObject(19089, X, Y, Z-210, 0, 0, Angle);
       rope[56] = CreateObject(19089, X, Y, Z-215, 0, 0, Angle);
       rope[57] = CreateObject(19089, X, Y, Z-220, 0, 0, Angle);
       ApplyAnimation(playerid,"ped","abseil",4.0,0,0,0,1,0);
       }
   return 1;
}
CMD:s(playerid,params[])
{
   if(GetPVarInt(playerid,"rappelling") == 0) return SendClientMessage(playerid, 0x33CCFFAA, "Tu no estas haciendo rapel!");
   for(new i = 0 ;i <58; i++)
   {
    SetPVarInt(playerid,"rappelling",0);
    DestroyObject(rope[i]);
    ClearAnimations(playerid);
    SetPlayerHealth(playerid, 100);
   }
        return 1;

}
GetXYInFrontOfPlayer(playerid, &Float:x, &Float:y, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, x, y, a);
	GetPlayerFacingAngle(playerid, a);
	if (GetPlayerVehicleID(playerid))
	{
	    GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	}
	x += (distance * floatsin(-a, degrees));
	y += (distance * floatcos(-a, degrees));
}
