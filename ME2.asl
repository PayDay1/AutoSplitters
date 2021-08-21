state("MassEffect2") {}
state("ME2Game") {}

init
{
    // Exclude script from running if you open the Legendary edition of the game, which shares the same .exe name
    if (game.Is64Bit()) throw new Exception("Not OG Mass Effect!");

    // Define pointer paths
    int[] boolsOffsets = new int[4] {0xE7F010, 0x11C, 0x4D0, 0x3C};      // Pointer path to the game's booleans
    int[] xyzOffsets   = new int[3] {0xE8312C, 0x0, 0x4C};               // Pointer path to character position

    // Define vars.watchers
    vars.watchers = new MemoryWatcherList();

    // isLoading variable (picked from the previous version of this autosplitter by PayDay)
    vars.watchers.Add(new MemoryWatcher<bool>(new DeepPointer(modules.First().BaseAddress + 0xE6B644)) { Name = "isLoading" });

    // Main story progression
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x14A)) { Name = "plotPrologue" });    // Used for prologue mission
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x43))  { Name = "plotCR0" });         // CR0, CR1, CR2 and CR3 are the CRitical missions that drive the story forward (Freedom's progress, Horizon, Collector Ship and Normany crew abduction)
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x27))  { Name = "plotCR123" });       // CR0, CR1, CR2 and CR3 are the CRitical missions that drive the story forward (Freedom's progress, Horizon, Collector Ship and Normany crew abduction)
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0xB3))  { Name = "plotIFF" });         // Corresponds to Legion acquisition, but that is one and the same with the reaper IFF mission
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x12E)) { Name = "crewAbduct" });      // Used in place of CR3 for "reasons"
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0xFE))  { Name = "suicideOculus" });   // Suicide mission: destroying the oculus
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x16F)) { Name = "suicideValve" });    // Suicide mission: making it through the ventilation system
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x170)) { Name = "suicideBubble" });   // Suicide mission: making it through the biotic bubble part
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x1BC)) { Name = "suicideReaper" });   // Used for signalling the end of the game

    // Dossiers
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x278)) { Name = "crewAcq1" });        // For Mordin, Jack, Garrus, Tali
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x4D))  { Name = "crewAcq2" });        // For Grunt
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x279)) { Name = "crewAcq3" });        // For Thane
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x47))  { Name = "crewAcq4" });        // For Samara
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x32))  { Name = "crewAcq5" });        // For Zaeed
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0xB9))  { Name = "crewAcq6" });        // For Kasumi

    // Loyalty missions
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0xBB)) { Name = "loyaltyMissions1" }); // Loyalty mission status for Miranda, Jacob, Jack, Legion, Kasumi, Garrus, Thane and Tali
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0xBC)) { Name = "loyaltyMissions2" }); // Loyalty mission status for Mordin, Grunt, Samara/Morinth and Zaeed

    // N7 Missions
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x1A8)) { Name = "WMF" });             // N7: Wrecked Merchant Freighter
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x225)) { Name = "ARS" });             // N7: Abandoned Research Station
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x18C)) { Name = "ADS" });             // N7: Archeological Dig Site
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x156)) { Name = "MSVE" });            // N7: MSV Estevanico
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x28A)) { Name = "ESD" });             // N7: Eclipse Smuggling Depot (and N7: Endangered Research Station)
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x288)) { Name = "LO" });              // N7: Lost Operative

    // X, Y and Z positions
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(modules.First().BaseAddress + xyzOffsets[0], xyzOffsets[1], xyzOffsets[2], 0x110)) { Name = "XPOS" });
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(modules.First().BaseAddress + xyzOffsets[0], xyzOffsets[1], xyzOffsets[2], 0x114)) { Name = "YPOS" });
    vars.watchers.Add(new MemoryWatcher<uint>(new DeepPointer(modules.First().BaseAddress + xyzOffsets[0], xyzOffsets[1], xyzOffsets[2], 0x118)) { Name = "ZPOS" });

    // Address checks put in place for avoiding unwanted splitting
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x158)) { Name = "splitchecks01" });
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0xE8)) { Name = "splitchecks02" });
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(modules.First().BaseAddress + boolsOffsets[0], boolsOffsets[1], boolsOffsets[2], boolsOffsets[3], 0x39)) { Name = "splitchecks03" });

    // Custom functions used for autosplitting
    vars.bitCheck = new Func<string, int, bool>((string plotEvent, int b) => ((byte)(vars.watchers[plotEvent].Current) & (1 << b)) != 0);
}


startup
{
    // Autosplitting settings
    settings.Add("escapeLazarus", true, "Prologue: Awakening");
    settings.Add("freedomProgress", true, "Freedom's Progress");
    settings.Add("recruitMordin", true, "Dossier: The Professor");
    settings.Add("recruitGarrus", true, "Dossier: Archangel");
    settings.Add("recruitJack", true, "Dossier: The Convict");
    settings.Add("acquireGrunt", true, "Dossier: The Warlord");
    settings.Add("horizonCompleted", true, "Horizon");
    settings.Add("N7_WMF", true, "N7: Wrecked Merchant Freighter");      // Eagle Nebula --> Amun --> Neith
    settings.Add("N7_ARS", true, "N7: Abandoned Research Station");      // Jarrahe Station
    settings.Add("N7_ADS", true, "N7: Archeological Dig Site");          // Rosetta --> Enoch (Prothean artifact)
    settings.Add("N7_MSVE", true, "N7: MSV Estevanico");                 // Hourglass --> Ploitari --> Zanethu
    settings.Add("N7_ESD", true, "N7: Eclipse Smuggling Depot");         // Hourglass --> Faryar --> Daratar
    settings.Add("collectorShip", true, "Collector ship");
    settings.Add("reaperIFF", true, "Reaper IFF");
    settings.Add("N7_ERS", true, "N7: Endangered Research Station");     // Caleston Rift --> Solveig --> Sinmara
    settings.Add("N7_LO", true, "N7: Lost Operative");                   // Omega Nebula --> Fathar --> Lorek
    settings.Add("crewAbuct", true, "Normandy crew abduction");
    settings.Add("ME2SuocideMission", true, "Suicide Mission");
    settings.Add("ME2Oculus", true, "Oculus", "ME2SuocideMission");
    settings.Add("ME2Valve", true, "Valve", "ME2SuocideMission");
    settings.Add("ME2Bubble", true, "Bubble", "ME2SuocideMission");
    settings.Add("ME2ending", true, "Human Reaper", "ME2SuocideMission");
    settings.Add("DLCcharactersRectuitment", false, "DLC Characters rectuitment");
    settings.Add("recruitKasumi", true, "Dossier: The Master Thief", "DLCcharactersRectuitment");
    settings.Add("recruitZaeed", true, "Dossier: The Veteran", "DLCcharactersRectuitment"); 
    settings.Add("ME2OptionalDossiers", true, "Optional Dossiers");
    settings.Add("recruitThane", true, "Dossier: The Assassin", "ME2OptionalDossiers");
    settings.Add("recruitSamara", true, "Dossier: The Justicar", "ME2OptionalDossiers");
    settings.Add("recruitTali", true, "Dossier: Tali", "ME2OptionalDossiers");
    settings.Add("ME2LoyaltyMissions", true, "Loyalty Missions");
    settings.Add("loyaltyMiranda", true, "Miranda", "ME2LoyaltyMissions");
    settings.Add("loyaltyJacob", true, "Jacob", "ME2LoyaltyMissions");
    settings.Add("loyaltyJack", true, "Jack", "ME2LoyaltyMissions");
    settings.Add("loyaltyLegion", true, "Legion", "ME2LoyaltyMissions");
    settings.Add("loyaltyKasumi", true, "Kasumi", "ME2LoyaltyMissions");
    settings.Add("loyaltyGarrus", true, "Garrus", "ME2LoyaltyMissions");
    settings.Add("loyaltyThane", true, "Thane", "ME2LoyaltyMissions");
    settings.Add("loyaltyTali", true, "Tali", "ME2LoyaltyMissions");
    settings.Add("loyaltyMordin", true, "Mordin", "ME2LoyaltyMissions");
    settings.Add("loyaltyGrunt", true, "Grunt", "ME2LoyaltyMissions");
    settings.Add("loyaltySamara", true, "Samara", "ME2LoyaltyMissions");
    settings.Add("loyaltyZaeed", true, "Zaeed", "ME2LoyaltyMissions");
}

update
{
    vars.watchers.UpdateAll(game);

    // Main story progression missions
    current.lazarusCompleted          = vars.bitCheck("plotPrologue", 5) && !vars.bitCheck("plotCR0", 1);
    current.FreedomProgressCompleted  = vars.bitCheck("plotCR0", 1);
    current.horizonCompleted          = vars.bitCheck("plotCR123", 0);
    current.collectorShipCompleted    = vars.bitCheck("plotCR123", 1);
    current.reaperIFFcompleted        = vars.bitCheck("plotIFF", 3);
    current.crewAbductMissionComplete = vars.bitCheck("crewAbduct", 1);

    // Suicide mission
    current.suicideOculusDestroyed = vars.bitCheck("suicideOculus", 4);
    current.suicideValveCompleted  = vars.bitCheck("suicideValve", 5);
    current.suicideBubbleCompleted = vars.bitCheck("suicideBubble", 0);
    current.suicideMissonCompleted = vars.bitCheck("suicideReaper", 3) || vars.bitCheck("suicideReaper", 5) || vars.bitCheck("suicideReaper", 6);

    // Recruitment missions Phase 1
    current.MordinRecruited    = vars.bitCheck("crewAcq1", 6);
    current.GarrusRecruited    = vars.bitCheck("crewAcq1", 5);
    current.JackRecruited      = vars.bitCheck("crewAcq1", 3);
    current.GruntTankRecovered = vars.bitCheck("crewAcq2", 2);

    // Recruitment missions Phase 2
    current.TaliRecruited   = vars.bitCheck("crewAcq1", 7);
    current.ThaneRecruited  = vars.bitCheck("crewAcq3", 1);
    current.SamaraRecruited = vars.bitCheck("crewAcq4", 4);

    // N7 missions
    current.N7WMF_completed  = vars.bitCheck("WMF", 0);
    current.N7ARS_completed  = vars.bitCheck("ARS", 6);
    current.N7ADS_completed  = vars.bitCheck("ADS", 0);
    current.N7MSVE_completed = vars.bitCheck("MSVE", 2);
    current.N7ESD_completed  = vars.bitCheck("ESD", 2);
    current.N7ERS_completed  = vars.bitCheck("ESD", 3);
    current.N7LO_completed   = vars.bitCheck("LO", 7);

    // DLC recruitments
    current.ZaeedRecruited  = vars.bitCheck("crewAcq5", 4);
    current.KasumiRecruited = vars.bitCheck("crewAcq6", 4);

    // Loyalty missions
    current.MirandaLoyaltyMissionCompleted = vars.bitCheck("loyaltyMissions1", 0);
    current.JacobLoyaltyMissionCompleted   = vars.bitCheck("loyaltyMissions1", 1);
    current.JackLoyaltyMissionCompleted    = vars.bitCheck("loyaltyMissions1", 2);
    current.LegionLoyaltyMissionCompleted  = vars.bitCheck("loyaltyMissions1", 3);
    current.KasumiLoyaltyMissionCompleted  = vars.bitCheck("loyaltyMissions1", 4);
    current.GarrusLoyaltyMissionCompleted  = vars.bitCheck("loyaltyMissions1", 5);
    current.ThaneLoyaltyMissionCompleted   = vars.bitCheck("loyaltyMissions1", 6);
    current.TaliLoyaltyMissionCompleted    = vars.bitCheck("loyaltyMissions1", 7);
    current.MordinLoyaltyMissionCompleted  = vars.bitCheck("loyaltyMissions2", 0);
    current.GruntLoyaltyMissionCompleted   = vars.bitCheck("loyaltyMissions2", 1);
    current.SamaraLoyaltyMissionCompleted  = vars.bitCheck("loyaltyMissions2", 2);
    current.ZaeedLoyaltyMissionCompleted   = vars.bitCheck("loyaltyMissions2", 3);

    // Split Checks
    // This is used for a consistency check to prevent unwanted splits (which WILL happen
    // if you load a savefile of if you return from the game to the main menu).
    // Essentially, the game checks whather the first 3 booleans of the game are set to true
    // The booleans are:
    //   1. Journal updates with the mission "Rescue Joker"
    //   2. Reached upper deck in the Normandy SR1 in the prologue
    //   3. Rescued Joker
    //   4. Normandy SR1 destroyed
    // All 4 booleans are necessarily set to true in the prologue because they are an essential part of the game progression,
    // so if even one of those 3 is not checked, it means the game is doing funny stuff in memory and LiveSplit should not split.
    current.allowsplitting = vars.bitCheck("splitchecks02", 2) && vars.bitCheck("splitchecks01", 7) && vars.bitCheck("splitchecks02", 3) && vars.bitCheck("splitchecks03", 7);
}

start
{
    // Start the timer as soon as you move from the default starting position in Lazarus Lab
    return (vars.watchers["XPOS"].Old == 1136428027 && vars.watchers["YPOS"].Old == 3338886377 && (vars.watchers["XPOS"].Changed || vars.watchers["YPOS"].Changed) && current.allowsplitting);
}

isLoading
{
    return vars.watchers["isLoading"].Current;
}

split
{
    return current.allowsplitting && old.allowsplitting && (
	
    // Main story progression
    (settings["escapeLazarus"] && current.lazarusCompleted && !old.lazarusCompleted && !current.FreedomProgressCompleted) ||
    (settings["freedomProgress"] && current.FreedomProgressCompleted && !old.FreedomProgressCompleted) ||
    (settings["horizonCompleted"] && current.horizonCompleted && !old.horizonCompleted) ||
    (settings["collectorShip"] && current.collectorShipCompleted && !old.collectorShipCompleted) ||
    (settings["reaperIFF"] && current.reaperIFFcompleted && !old.reaperIFFcompleted) ||
    (settings["crewAbuct"] && current.crewAbductMissionComplete && !old.crewAbductMissionComplete) || 

    // Suicide Mission
    (settings["ME2Oculus"] && current.suicideOculusDestroyed && !old.suicideOculusDestroyed) ||
    (settings["ME2Valve"] && current.suicideValveCompleted && !old.suicideValveCompleted) ||
    (settings["ME2Bubble"] && current.suicideBubbleCompleted && !old.suicideBubbleCompleted) ||
    (settings["ME2ending"] && current.suicideMissonCompleted && !old.suicideMissonCompleted) ||

    // N7 missions
    (settings["N7_WMF"] && current.N7WMF_completed && !old.N7WMF_completed) ||
    (settings["N7_ARS"] && current.N7ARS_completed && !old.N7ARS_completed) ||
    (settings["N7_ADS"] && current.N7ADS_completed && !old.N7ADS_completed) ||
    (settings["N7_MSVE"] && current.N7MSVE_completed && !old.N7MSVE_completed) ||
    (settings["N7_ESD"] && current.N7ESD_completed && !old.N7ESD_completed) ||
    (settings["N7_ERS"] && current.N7ERS_completed && !old.N7ERS_completed) ||
    (settings["N7_LO"] && current.N7LO_completed && !old.N7LO_completed) ||

    // Dossiers (used to split for Phase 1 of the game and for DLC characters)
    (settings["recruitMordin"] && current.MordinRecruited && !old.MordinRecruited) ||
    (settings["recruitGarrus"] && current.GarrusRecruited && !old.GarrusRecruited) ||
    (settings["acquireGrunt"] && current.GruntTankRecovered && !old.GruntTankRecovered) ||
    (settings["recruitJack"] && current.JackRecruited && !old.JackRecruited) ||
    (settings["recruitZaeed"] && current.ZaeedRecruited && !old.ZaeedRecruited) ||
    (settings["recruitKasumi"] && current.KasumiRecruited && !old.KasumiRecruited) ||

    // Phase 2 Dossiers
    (settings["recruitTali"] && current.TaliRecruited && !old.TaliRecruited) ||
    (settings["recruitSamara"] && current.SamaraRecruited && !old.SamaraRecruited) ||
    (settings["recruitThane"] && current.ThaneRecruited && !old.ThaneRecruited) ||

    // Loyalty missions
    (settings["loyaltyMiranda"] && current.MirandaLoyaltyMissionCompleted && !old.MirandaLoyaltyMissionCompleted) ||
    (settings["loyaltyJacob"] && current.JacobLoyaltyMissionCompleted && !old.JacobLoyaltyMissionCompleted) ||
    (settings["loyaltyJack"] && current.JackLoyaltyMissionCompleted && !old.JackLoyaltyMissionCompleted) ||
    (settings["loyaltyLegion"] && current.LegionLoyaltyMissionCompleted && !old.LegionLoyaltyMissionCompleted) ||
    (settings["loyaltyKasumi"] && current.KasumiLoyaltyMissionCompleted && !old.KasumiLoyaltyMissionCompleted) ||
    (settings["loyaltyGarrus"] && current.GarrusLoyaltyMissionCompleted && !old.GarrusLoyaltyMissionCompleted) ||
    (settings["loyaltyThane"] && current.ThaneLoyaltyMissionCompleted && !old.ThaneLoyaltyMissionCompleted) ||
    (settings["loyaltyTali"] && current.TaliLoyaltyMissionCompleted && !old.TaliLoyaltyMissionCompleted) ||
    (settings["loyaltyMordin"] && current.MordinLoyaltyMissionCompleted && !old.MordinLoyaltyMissionCompleted) ||
    (settings["loyaltyGrunt"] && current.GruntLoyaltyMissionCompleted && !old.GruntLoyaltyMissionCompleted) ||
    (settings["loyaltySamara"] && current.SamaraLoyaltyMissionCompleted && !old.SamaraLoyaltyMissionCompleted) ||
    (settings["loyaltyZaeed"] && current.ZaeedLoyaltyMissionCompleted && !old.ZaeedLoyaltyMissionCompleted)

    );
}
