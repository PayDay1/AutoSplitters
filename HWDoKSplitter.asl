state("DesertsOfKharak64")
{
	bool isLoading : 0x01116788, 0x50, 0x470, 0x678, 0x3A0, 0x7F4; // 1.3.0
	int sceneID : 0x0106F6D0, 0x4B0, 0xC0, 0x60, 0x7A0, 0x3DC;
}

startup
{
}

init
{
	refreshRate = 30;
}

start
{ 
	if(old.isLoading == false && current.isLoading == true) //Epsilon Base start
		return true;
		
	return false;
}

split
{
	bool switchedToNextMission = (current.sceneID == 0 || current.sceneID == 1 || current.sceneID == 2 || current.sceneID == 3);
	
	if(switchedToNextMission)
	{
		if(old.sceneID > 4)
			return true;
		/*if(old.sceneID == 20 || old.sceneID == 47 || old.sceneID == 48) //Epsilon Base ending
			return true;
		if(old.sceneID == 15 || old.sceneID == 16) //The Boneyard ending
			return true;
		if(old.sceneID == 134 || old.sceneID == 135) //Cape Wrath ending
			return true;
		if(old.sceneID == 51 || old.sceneID == 52) //Kalash Site ending
			return true;
		if(old.sceneID == 17 || old.sceneID == 66 || old.sceneID == 67) //Kalash Wreck ending
			return true;
		if(old.sceneID == 444 || old.sceneID == 445) //Beladin Dune Sea ending
			return true;
		if(old.sceneID == 164 || old.sceneID == 165) //Gaalsien Base ending
			return true;
		if(old.sceneID == 418 || old.sceneID == 419) //Tombs of the Ancients ending
			return true;
		if(old.sceneID == 133 || old.sceneID == 134) //The Whispering Gallery ending
			return true;
		if(old.sceneID == 167 || old.sceneID == 168 || old.sceneID == 5) //Kashar Approach/Kashar Plateau ending
			return true;
		if(old.sceneID == 45 || old.sceneID == 46) //Torin Crater ending
			return true;*/
	}
	
	if(old.sceneID == 291 && current.sceneID == 292) //Khar-Toba Fathership destruction cutscene start
		return true;
	
	return false;
}

exit
{
	timer.IsGameTimePaused = true;
}

isLoading
{
	return current.isLoading;
}
