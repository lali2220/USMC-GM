#include <a_samp>
#include <zcmd>
#include <streamer>
 
#define MAX_CAMP_CARP   (100)
#define MAX_CAMP_OBJECT (80)
new Campamento[MAX_CAMP_CARP][MAX_CAMP_OBJECT],
ContarCampamento;
 

public OnFilterScriptInit()
{
      print("Sistema de CREAR ACTORS cargado!");
      return 1;
}

COMMAND:camp1(playerid, params[]){
    new Float:pos[4];
    GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
    GetPlayerFacingAngle(playerid,pos[3]);
    pos[0] = pos[0] + (2.0 * floatsin(-pos[3], degrees));
    pos[1] = pos[1] + (2.0 * floatcos(-pos[3], degrees));
   
    CreateObjectCamp(pos[0],pos[1],pos[2],pos[3]);
    return true;
}
COMMAND:camp2(playerid, params[]){
    DestroyObjectCamp();
    return true;
}
 
stock CreateObjectCamp(Float:x,Float:y,Float:z,Float:a){
    if(ContarCampamento>=MAX_CAMP_CARP)return false;
    ContarCampamento++;
    //cuerdas
    Campamento[ContarCampamento][0]=CreateObject(19087, 307.79419, 1833.44189, 18.78920,   0.00000, 90.00000, 135.00000);
    Campamento[ContarCampamento][1]=CreateObject(19087, 308.87219, 1832.36987, 18.78920,   0.00000, 90.00000, 135.00000);
    Campamento[ContarCampamento][2]=CreateObject(19089, 311.72137, 1828.64319, 19.62920,   0.00000, -42.00000, 90.00000);
    Campamento[ContarCampamento][3]=CreateObject(19089, 311.72141, 1822.50464, 19.62920,   0.00000, 42.00000, 90.00000);
    Campamento[ContarCampamento][4]=CreateObject(19089, 311.67493, 1823.13049, 19.86420,   0.00000, -53.00000, 0.00000);
    Campamento[ContarCampamento][5]=CreateObject(19089, 311.67303, 1827.79321, 19.86420,   0.00000, -53.00000, 0.00000);
    Campamento[ContarCampamento][6]=CreateObject(19089, 311.65009, 1827.76843, 19.86420,   0.00000, -53.00000, 180.00000);
    Campamento[ContarCampamento][7]=CreateObject(19089, 311.63867, 1823.11316, 19.86420,   0.00000, -53.00000, 180.00000);
    for(new index=0; index<7; index++) SetObjectMaterial(Campamento[ContarCampamento][index], 0, -1, "none", "none", 0xFF808484);
    //palos fogata
    Campamento[ContarCampamento][8]=CreateObject(1251, 310.61270, 1830.58606, 15.53550,   90.00000, 0.00000, 0.00000);
    Campamento[ContarCampamento][9]=CreateObject(1251, 307.87411, 1833.35156, 15.53550,   90.00000, 0.00000, 0.00000);
    for(new index=8; index<9; index++) SetObjectMaterial(Campamento[ContarCampamento][index], 0, 841, "gta_brokentrees", "CJ_bark", -1);
    //camas carpa
    Campamento[ContarCampamento][10]=CreateObject(1646, 310.20544, 1823.86487, 16.78320,   0.00000, 0.00000, 180.00000);
    Campamento[ContarCampamento][11]=CreateObject(1646, 312.31110, 1824.50134, 16.78320,   0.00000, 0.00000, -90.00000);
    Campamento[ContarCampamento][12]=CreateObject(1646, 312.31107, 1825.72351, 16.78320,   0.00000, 0.00000, -90.00000);
    Campamento[ContarCampamento][13]=CreateObject(1646, 314.25800, 1830.57471, 16.78320,   0.00000, 0.00000, -154.00000);
    for(new index=10; index<13; index++) SetObjectMaterial(Campamento[ContarCampamento][index], 25, -1, "none", "none", -1);
    for(new index=10; index<13; index++) SetObjectMaterial(Campamento[ContarCampamento][index], 26, -1, "none", "none", -1);
    //carpa
    Campamento[ContarCampamento][14]=CreateObject(19325, 312.76309, 1825.48145, 18.11690,   0.00000, -32.00000, 0.00000);
    Campamento[ContarCampamento][15]=CreateObject(19325, 310.53009, 1825.48145, 18.11690,   0.00000, 34.00000, 0.00000);
    Campamento[ContarCampamento][16]=CreateObject(19325, 311.59631, 1825.51514, 16.65890,   0.00000, 90.00000, 0.00000);
    for(new index=14; index<16; index++) SetObjectMaterial(Campamento[ContarCampamento][index], 0, 3066, "ammotrx", "ammotrn92tarp128", -1);
    //entrada carpa
    Campamento[ContarCampamento][17]=CreateObject(2068, 310.92621, 1829.37927, 14.26150,   138.00000, 105.00000, 78.00000);
    Campamento[ContarCampamento][18]=CreateObject(2068, 312.47238, 1821.60352, 14.26150,   138.00000, 105.00000, 260.00000);
    Campamento[ContarCampamento][19]=CreateObject(2068, 312.40381, 1828.17834, 14.26150,   138.00000, 105.00000, -99.00000);
    Campamento[ContarCampamento][20]=CreateObject(2068, 311.01590, 1822.85583, 14.26150,   138.00000, 105.00000, 79.00000);
    for(new index=17; index<20; index++) SetObjectMaterial(Campamento[ContarCampamento][index], 0, -1, "none", "none", 0xFF808484);
    //luces carpa
    Campamento[ContarCampamento][21]=CreateObject(2074, 311.69241, 1824.52930, 19.50400,   0.00000, 0.00000, 0.00000);
    Campamento[ContarCampamento][22]=CreateObject(2074, 311.71283, 1826.09229, 19.50400,   0.00000, 0.00000, 0.00000);
   
    for(new index=1; index<MAX_CAMP_OBJECT; index++){
        new Float:pos[2][6];
        GetObjectPos(Campamento[ContarCampamento][0],pos[0][0],pos[0][1],pos[0][2]);
        GetObjectPos(Campamento[ContarCampamento][index],pos[1][0],pos[1][1],pos[1][2]);
        GetObjectRot(Campamento[ContarCampamento][index],pos[1][3],pos[1][4],pos[1][5]);
        AttachObjectToObject(Campamento[ContarCampamento][index], Campamento[ContarCampamento][0], floatsub(pos[1][0], pos[0][0]),floatsub(pos[1][1], pos[0][1]),floatsub(pos[1][2], pos[0][2]), pos[1][3],pos[1][4],pos[1][5], 1);
    }
    SetObjectPos(Campamento[ContarCampamento][0],x,y,z-0.9);
    SetObjectRot(Campamento[ContarCampamento][0],0.00000, 0.00000, a-180);
    return true;
}
stock DestroyObjectCamp(){
    if(ContarCampamento<=0)return false;
    for(new index=0; index<MAX_CAMP_OBJECT; index++) DestroyObject(Campamento[ContarCampamento][index]);
    ContarCampamento--;
    return true;
}