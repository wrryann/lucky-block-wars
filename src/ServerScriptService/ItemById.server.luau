local Players = game:GetService("Players")
local Items = {
	{
		Name = "Knights of the Splintered Skies Wind Summoner",
		Id = 127506257,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of the Splintered Skies Lightning Staff",
		Id = 395205750,
		Rarity = "NotDefined"
	},
	{
		Name = "Farmers Revenge",
		Id = 101106419,
		Rarity = "NotDefined"
	},
	{
		Name = "Trusty Blade",
		Id = 96669687,
		Rarity = "NotDefined"
	},
	{
		Name = "Interplanetary Light Sword",
		Id = 1033136271,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights Elder Blade",
		Id = 48395736,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of Redcliff Battle Axe",
		Id = 49929724,
		Rarity = "NotDefined"
	},
	{
		Name = "Earths Might Staff",
		Id = 102705386,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of Redcliff Bow and Arrow",
		Id = 49929776,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of the Splintered Skies Ballista",
		Id = 55917432,
		Rarity = "NotDefined"
	},
	{
		Name = "Emerald Knights of the Seventh Sanctum Staff",
		Id = 128162713,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of RedCliff Battle Horn",
		Id = 114020505,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of the Seventh Sanctum Sword and Shield",
		Id = 60357959,
		Rarity = "NotDefined"
	},
	{
		Name = "Knights of Redcliff Sword and Shield",
		Id = 49929767,
		Rarity = "NotDefined"
	},
	{
		Name = "Bat Knight Bat Sword",
		Id = 17680660,
		Rarity = "NotDefined"
	},
	{
		Name = "Emerald Knights of the Seventh Sanctum Spellbook",
		Id = 128162639,
		Rarity = "NotDefined"
	},
	{
		Name = "Rubber Chicken Launcher",
		Id = 121385193,
		Rarity = "NotDefined"
	},
	{
		Name = "Gear Cloner",
		Id = 97161295,
		Rarity = "NotDefined"
	},
	{
		Name = "8 Bit Blaster",
		Id = 542755101,
		Rarity = "NotDefined"
	},
	{
		Name = "Disintergrex Blast Gun",
		Id = 18268645,
		Rarity = "NotDefined"
	},
	{
		Name = "Suit Up Gun",
		Id = 91360052,
		Rarity = "NotDefined"
	},
	{
		Name = "Land Shark Shooter",
		Id = 118281463,
		Rarity = "NotDefined"
	},
	{
		Name = "Z Ray Gun",
		Id = 65082275,
		Rarity = "NotDefined"
	},
	{
		Name = "Transmorph Ray Gun",
		Id = 29099749,
		Rarity = "NotDefined"
	},
	{
		Name = "Laser Electrocutor",
		Id = 82357123,
		Rarity = "NotDefined"
	},
	{
		Name = "Colossal Blade",
		Id = 83704154,
		Rarity = "NotDefined"
	},
	{
		Name = "Darksteel Katana of Ancient Illuminators",
		Id = 86494893,
		Rarity = "NotDefined"
	},
	{
		Name = "Sledge Hammer",
		Id = 45177979,
		Rarity = "NotDefined"
	},
	{
		Name = "Guitar Sword",
		Id = 60357982,
		Rarity = "NotDefined"
	},
	{
		Name = "Mostly Ghostly Potion",
		Id = 527384527,
		Rarity = "NotDefined"
	},
	{
		Name = "Laser Electrocutor Blade",
		Id = 50938773,
		Rarity = "NotDefined"
	},
	{
		Name = "Poseidons Quake Trident",
		Id = 54130559,
		Rarity = "NotDefined"
	},
	{
		Name = "Staff of Shifting Polarity",
		Id = 61459706,
		Rarity = "NotDefined"
	},
	{
		Name = "Polar Mount",
		Id = 332747874,
		Rarity = "NotDefined"
	},
	{
		Name = "Polar Bear Attack Claws",
		Id = 187688069,
		Rarity = "NotDefined"
	},
	{
		Name = "Beehive",
		Id = 117498775,
		Rarity = "NotDefined"
	},
	{
		Name = "Korblox Ice Claws",
		Id = 223785065,
		Rarity = "NotDefined"
	},
	{
		Name = "Earth Summoning Horn",
		Id = 236403380,
		Rarity = "NotDefined"
	},
	{
		Name = "Flying Dragon",
		Id = 610133821,
		Rarity = "NotDefined"
	},
	{
		Name = "Dragon Warrior Spear",
		Id = 1320966419,
		Rarity = "NotDefined"
	},
	{
		Name = "Flaming Dragon Slayer Bo Staff",
		Id = 73232786,
		Rarity = "NotDefined"
	},
	{
		Name = "Chopper Broom",
		Id = 1132884456,
		Rarity = "NotDefined"
	},
	{
		Name = "Zoom Broom 5000",
		Id = 511930668,
		Rarity = "NotDefined"
	},
	{
		Name = "Mega Mallet",
		Id = 746687364,
		Rarity = "NotDefined"
	},
	{
		Name = "Lightning Horn of the Heavens",
		Id = 321582427,
		Rarity = "NotDefined"
	},
	{
		Name = "Korblox Flying Oblivion Horn",
		Id = 101734094,
		Rarity = "NotDefined"
	},
	{
		Name = "Superhero Potion",
		Id = 76262706,
		Rarity = "NotDefined"
	},
	{
		Name = "Kami Potion",
		Id = 66426498,
		Rarity = "NotDefined"
	},
	{
		Name = "Leprechaun Potion",
		Id = 380210977,
		Rarity = "NotDefined"
	},
	{
		Name = "Staff of Sparks",
		Id = 10760425,
		Rarity = "NotDefined"
	},
	{
		Name = "Vine Staff",
		Id = 30847733,
		Rarity = "NotDefined"
	},
	{
		Name = "Staff of the Winds",
		Id = 18462637,
		Rarity = "NotDefined"
	},
	{
		Name = "Ice Staff",
		Id = 19704064,
		Rarity = "NotDefined"
	},
	{
		Name = "Deluxe Snowball Cannon 3000",
		Id = 67755182,
		Rarity = "NotDefined"
	},
	{
		Name = "Snowball",
		Id = 19328185,
		Rarity = "NotDefined"
	},
	{
		Name = "Carnagecopia",
		Id = 98346415,
		Rarity = "NotDefined"
	},
	{
		Name = "Danger Dagger",
		Id = 96669682,
		Rarity = "NotDefined"
	},
	{
		Name = "Gigantic Bat Wings",
		Id = 1074738432,
		Rarity = "NotDefined"
	},
	{
		Name = "Bat tle Axe",
		Id = 2409286506,
		Rarity = "NotDefined"
	},
	{
		Name = "Enchanted Bat Flying Potion",
		Id = 63721732,
		Rarity = "NotDefined"
	},
	{
		Name = "Dual Monster Axes",
		Id = 315617026,
		Rarity = "NotDefined"
	},
	{
		Name = "Super Spy Laser Blaster",
		Id = 208659734,
		Rarity = "NotDefined"
	},
	{
		Name = "Super Freeze Ray 2011",
		Id = 42845853,
		Rarity = "NotDefined"
	},
	{
		Name = "Freeze Ray",
		Id = 26013203,
		Rarity = "NotDefined"
	},
	{
		Name = "Penguin Shooter",
		Id = 192537346,
		Rarity = "NotDefined"
	},
	{
		Name = "Spectral Sword of Illusions",
		Id = 68848741,
		Rarity = "NotDefined"
	},
	{
		Name = "Sheriff Steves Six Shooter",
		Id = 25317304,
		Rarity = "NotDefined"
	},
	{
		Name = "M1 Garand",
		Id = 94233286,
		Rarity = "NotDefined"
	},
	{
		Name = "Remote Mine",
		Id = 33383241,
		Rarity = "NotDefined"
	},
	{
		Name = "Gold Eagle Sword",
		Id = 264990158,
		Rarity = "NotDefined"
	},
	{
		Name = "Glorious Eagle Mount",
		Id = 2014805757,
		Rarity = "NotDefined"
	},
	{
		Name = "Blade of the Dusekkar",
		Id = 501942750,
		Rarity = "NotDefined"
	},
	{
		Name = "The Dukes Blade of Due Process",
		Id = 1360077860,
		Rarity = "NotDefined"
	},
	{
		Name = "Skeleton Scythe",
		Id = 95951330,
		Rarity = "NotDefined"
	},
	{
		Name = "RAIG Table",
		Id = 110789105,
		Rarity = "NotDefined"
	},
	{
		Name = "Red Convertible",
		Id = 164207580,
		Rarity = "NotDefined"
	},
}

Players.PlayerAdded:Connect(function(player)
    for _, item in ipairs(Items) do
		local Model = game:GetService("InsertService"):LoadAsset(item.Id)
		local tool = Model:FindFirstChildOfClass("Tool")
		tool.Parent = player.Backpack
    end
end)


    