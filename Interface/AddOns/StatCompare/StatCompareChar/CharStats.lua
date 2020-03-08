CharStats_fullvals = {};

CharStats_base = {
	{ race = "NightElf", class = "DRUID", level = 70,
	  str = 75, agi = 77, sta = 84, int = 148, spi = 136,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 4274, mana = 4310 },
	{ race = "Tauren", class = "DRUID", level = 70,
	  str = 81, agi = 65, sta = 85, int = 115, spi = 155,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 4624, mana = 3815 },
	{ race = "Draenei", class = "HUNTER", level = 70, 
	  str = 65, agi = 148, sta = 107, int = 78, spi = 85,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 4524, mana = 4273 },
	{ race = "Draenei", class = "MAGE", level = 70, 
	  str = 34, agi = 36, sta = 50, int = 174, spi = 147,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 3713, mana = 4571 },
	{ race = "Draenei", class = "PALADIN", level = 70, 
	  str = 127, agi = 74, sta = 119, int = 92, spi = 91,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 4387, mana = 4053 },
	{ race = "Draenei", class = "PRIEST", level = 70, 
	  str = 40, agi = 42, sta = 57, int = 146, spi = 153,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 3781, mana = 4530 },
	{ race = "Draenei", class = "SHAMAN", level = 70, 
	  str = 103, agi = 61, sta = 113, int = 109, spi = 122,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 4109, mana = 4736 },
	{ race = "Draenei", class = "WARRIOR", level = 70, 
	  str = 146, agi = 93, sta = 132, int = 34, spi = 53,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 5584, mana = 0 },
	{ race = "Dwarf", class = "HUNTER", level = 70, 
	  str = 66, agi = 147, sta = 111, int = 76, spi = 82,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 4796, mana = 4244 },
	{ race = "Dwarf", class = "PALADIN", level = 70,
	  str = 128, agi = 73, sta = 123, int = 90, spi = 88,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 4427, mana = 4023 },
	{ race = "Dwarf", class = "PRIEST", level = 70,
	  str = 41, agi = 41, sta = 61, int = 144, spi = 157,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 3821, mana = 4687 },
	{ race = "Dwarf", class = "ROGUE", level = 70,
	  str = 97, agi = 157, sta = 95, int = 38, spi = 57,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 4474, mana = 0 },
	{ race = "Dwarf", class = "WARRIOR", level = 70,
	  str = 161, agi = 92, sta = 142, int = 32, spi = 50,
	  ar = 0, fr = 0, nr = 0, ir = 10, sr=0,
	  health = 5684, mana = 0 },
	{ race = "Gnome", class = "MAGE", level = 70,
	  str = 28, agi = 42, sta = 50, int = 161, spi = 145,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 3713, mana = 4376 },
	{ race = "Gnome", class = "ROGUE", level = 70,
	  str = 90, agi = 161, sta = 88, int = 44, spi = 58,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4404, mana = 0 },
	{ race = "Gnome", class = "WARLOCK", level = 70,
	  str = 46, agi = 61, sta = 86, int = 142, spi = 132,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4444, mana = 4729 },
	{ race = "Gnome", class = "WARRIOR", level = 70,
	  str = 140, agi = 99, sta = 132, int = 37, spi = 51,
	  ar = 10, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 5584, mana = 0 },
	{ race = "Human", class = "MAGE", level = 70,
	  str = 33, agi = 39, sta = 51, int = 151, spi = 159,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 3723, mana = 4226 },
  	{ race = "Human", class = "PALADIN", level = 70,
	  str = 126, agi = 77, sta = 120, int = 91, spi = 97,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4397, mana = 4038 },
	{ race = "Human", class = "PRIEST", level = 70,
	  str = 39, agi = 45, sta = 58, int = 145, spi = 166,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 3791, mana = 4515 },
	{ race = "Human", class = "ROGUE", level = 70,
	  str = 95, agi = 158, sta = 89, int = 39, spi = 63,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4414, mana = 0 },
	{ race = "Human", class = "WARLOCK", level = 70,
	  str = 51, agi = 58, sta = 87, int = 133, spi = 145,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4475, mana = 4597 },
	{ race = "Human", class = "WARRIOR", level = 70,
	  str = 140, agi = 99, sta = 132, int = 37, spi = 51,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 5584, mana = 0 },
	{ race = "NightElf", class = "HUNTER", level = 70,
	  str = 61, agi = 156, sta = 107, int = 77, spi = 83,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 4877, mana = 4258 },
	{ race = "NightElf", class = "PRIEST", level = 70,
	  str = 36, agi = 50, sta = 57, int = 145, spi = 151,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 3781, mana = 4515 },
	{ race = "NightElf", class = "ROGUE", level = 70,
	  str = 92, agi = 166, sta = 91, int = 39, spi = 58,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 4434, mana = 0 },
	{ race = "NightElf", class = "WARRIOR", level = 70,
	  str = 142, agi = 101, sta = 132, int = 33, spi = 51,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 5584, mana = 0 },
	{ race = "Orc", class = "HUNTER", level = 70,
	  str = 67, agi = 148, sta = 110, int = 74, spi = 86,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 5636, mana = 4213 },
	{ race = "Orc", class = "ROGUE", level = 70,
	  str = 98, agi = 155, sta = 91, int = 36, spi = 63,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4434, mana = 0 },
	{ race = "Orc", class = "SHAMAN", level = 70,
	  str = 105, agi = 61, sta = 116, int = 105, spi = 123,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4139, mana = 4253 },
	{ race = "Orc", class = "WARLOCK", level = 70,
	  str = 54, agi = 55, sta = 89, int = 130, spi = 134,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4554, mana = 4521 },
	{ race = "Orc", class = "WARRIOR", level = 70,
	  str = 148, agi = 93, sta = 135, int = 30, spi = 54,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 5614, mana = 0 },
	{ race = "Tauren", class = "HUNTER", level = 70,
	  str = 69, agi = 146, sta = 110, int = 72, spi = 85,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 6080, mana = 4183 },
	{ race = "Tauren", class = "SHAMAN", level = 70,
	  str = 107, agi = 59, sta = 116, int = 103, spi = 122,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 4548, mana = 4636 },
	{ race = "Tauren", class = "WARRIOR", level = 70,
	  str = 150, agi = 91, sta = 135, int = 28, spi = 53,
	  ar = 0, fr = 0, nr = 10, ir = 0, sr=0,
	  health = 6192, mana = 0 },
	{ race = "Troll", class = "HUNTER", level = 70,
	  str = 65, agi = 153, sta = 109, int = 73, spi = 84,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 5513, mana = 4198 },
	{ race = "Troll", class = "MAGE", level = 70,
	  str = 34, agi = 41, sta = 52, int = 147, spi = 146,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 3753, mana = 4166 },
	{ race = "Troll", class = "PRIEST", level = 70,
	  str = 40, agi = 47, sta = 59, int = 141, spi = 152,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 3801, mana = 4455 },
	{ race = "Troll", class = "ROGUE", level = 70,
	  str = 96, agi = 160, sta = 90, int = 35, spi = 59,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4424, mana = 0 },
	{ race = "Troll", class = "SHAMAN", level = 70,
	  str = 103, agi = 66, sta = 115, int = 104, spi = 121,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 4129, mana = 4501 },
	{ race = "Troll", class = "WARRIOR", level = 70,
	  str = 146, agi = 98, sta = 134, int = 29, spi = 54,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=0,
	  health = 5604, mana = 0 },
	{ race = "Scourge", class = "MAGE", level = 70,
	  str = 32, agi = 37, sta = 52, int = 171, spi = 150,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 3733, mana = 4526 },
	{ race = "Scourge", class = "PRIEST", level = 70,
	  str = 38, agi = 43, sta = 59, int = 143, spi = 163,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 3801, mana = 4666 },
	{ race = "Scourge", class = "ROGUE", level = 70,
	  str = 94, agi = 156, sta = 90, int = 37, spi = 63,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 4424, mana = 0 },
	{ race = "Scourge", class = "WARLOCK", level = 70,
	  str = 50, agi = 56, sta = 88, int = 131, spi = 136,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 4190, mana = 4300 },
	{ race = "Scourge", class = "WARRIOR", level = 70,
	  str = 144, agi = 94, sta = 134, int = 31, spi = 58,
	  ar = 0, fr = 0, nr = 0, ir = 0, sr=10,
	  health = 5604, mana = 0 },
	{ race = "BloodElf", class = "HUNTER", level = 70,
	  str = 61, agi = 153, sta = 106, int = 81, spi = 82,
	  ar = 5, fr = 5, nr = 5, ir = 5, sr=5,
	  health = 5546, mana = 4318 },
	{ race = "BloodElf", class = "MAGE", level = 70,
	  str = 30, agi = 41, sta = 49, int = 155, spi = 144,
	  ar = 5, fr = 5, nr = 5, ir = 5, sr=5,
	  health = 3723, mana = 4286 },
	{ race = "BloodElf", class = "PALADIN", level = 70,
	  str = 133, agi = 79, sta = 118, int = 95, spi = 88,
	  ar = 5, fr = 5, nr = 5, ir = 5, sr=5,
	  health = 4377, mana = 4098 },
	{ race = "BloodElf", class = "PRIEST", level = 70,
	  str = 36, agi = 47, sta = 56, int = 149, spi = 150,
	  ar = 5, fr = 5, nr = 5, ir = 5, sr=5,
	  health = 3771, mana = 4575 },
	{ race = "BloodElf", class = "ROGUE", level = 70,
	  str = 92, agi = 160, sta = 87, int = 43, spi = 57,
	  ar = 5, fr = 5, nr = 5, ir = 5, sr=5,
	  health = 4394, mana = 0 },
	{ race = "BloodElf", class = "WARLOCK", level = 70,
	  str = 48, agi = 60, sta = 85, int = 137, spi = 131,
	  ar = 5, fr = 5, nr = 5, ir = 5, sr=5,
	  health = 4160, mana = 4390 },
};

local SCClassNameToID = {
	"WARRIOR",
	"PALADIN",
	"HUNTER",
	"ROGUE",
	"PRIEST",
	"SHAMAN",
	"MAGE",
	"WARLOCK",
	"DRUID",
	["WARRIOR"] = 1,
	["PALADIN"] = 2,
	["HUNTER"] = 3,
	["ROGUE"] = 4,
	["PRIEST"] = 5,
	["SHAMAN"] = 6,
	["MAGE"] = 7,
	["WARLOCK"] = 8,
	["DRUID"] = 9,
}

-- some codes steal from RatingBuster module
-- Numbers derived by Whitetooth@Cenarius (hotdogee@bahamut.twbbs.org)
local SCBaseDodge = {
	0.7580, 0.6520, -5.4500, -0.5900, 3.1830, 1.6750, 3.4575, 2.0350, -1.8720,
	--["WARRIOR"] = 0.7580,
	--["PALADIN"] = 0.6520,
	--["HUNTER"] = -5.4500,
	--["ROGUE"] = -0.5900,
	--["PRIEST"] = 3.1830,
	--["SHAMAN"] = 1.6750,
	--["MAGE"] = 3.4575,
	--["WARLOCK"] = 2.0350,
	--["DRUID"] = -1.8720,
}

function StatCompare_GetBaseDodge(class)
	class = SCClassNameToID[strupper(class)]
	return SCBaseDodge[class]
end

local SCDodgePerAgi = {
	23.57, 25, 20.73, 14.08, 22.01, 19.55, 3.4575, 20.24, 11.93,
	--["WARRIOR"] = 23.57,
	--["PALADIN"] = 25,
	--["HUNTER"] = 20.73,
	--["ROGUE"] = 14.08,
	--["PRIEST"] = 22.01,
	--["SHAMAN"] = 19.55,
	--["MAGE"] = 22.69,
	--["WARLOCK"] = 20.24,
	--["DRUID"] = 11.93,
}

function StatCompare_GetDodgeFromAgi(agi, class)
	class = SCClassNameToID[strupper(class)]
	return agi / SCDodgePerAgi[class]
end

-- Numbers reverse engineered by Whitetooth@Cenarius (hotdogee@bahamut.twbbs.org)
local SCCritPerAgi = {
	 [1] = {0.2500, 0.2174, 0.2840, 0.4476, 0.0909, 0.1663, 0.0771, 0.1500, 0.2020, },
	 [2] = {0.2381, 0.2070, 0.2834, 0.4290, 0.0909, 0.1663, 0.0771, 0.1500, 0.2020, },
	 [3] = {0.2381, 0.2070, 0.2711, 0.4118, 0.0909, 0.1583, 0.0771, 0.1429, 0.1923, },
	 [4] = {0.2273, 0.1976, 0.2530, 0.3813, 0.0865, 0.1583, 0.0735, 0.1429, 0.1923, },
	 [5] = {0.2174, 0.1976, 0.2430, 0.3677, 0.0865, 0.1511, 0.0735, 0.1429, 0.1836, },
	 [6] = {0.2083, 0.1890, 0.2337, 0.3550, 0.0865, 0.1511, 0.0735, 0.1364, 0.1836, },
	 [7] = {0.2083, 0.1890, 0.2251, 0.3321, 0.0865, 0.1511, 0.0735, 0.1364, 0.1756, },
	 [8] = {0.2000, 0.1812, 0.2171, 0.3217, 0.0826, 0.1446, 0.0735, 0.1364, 0.1756, },
	 [9] = {0.1923, 0.1812, 0.2051, 0.3120, 0.0826, 0.1446, 0.0735, 0.1304, 0.1683, },
	[10] = {0.1923, 0.1739, 0.1984, 0.2941, 0.0826, 0.1385, 0.0701, 0.1304, 0.1553, },
	[11] = {0.1852, 0.1739, 0.1848, 0.2640, 0.0826, 0.1385, 0.0701, 0.1250, 0.1496, },
	[12] = {0.1786, 0.1672, 0.1670, 0.2394, 0.0790, 0.1330, 0.0701, 0.1250, 0.1496, },
	[13] = {0.1667, 0.1553, 0.1547, 0.2145, 0.0790, 0.1330, 0.0701, 0.1250, 0.1443, },
	[14] = {0.1613, 0.1553, 0.1441, 0.1980, 0.0790, 0.1279, 0.0701, 0.1200, 0.1443, },
	[15] = {0.1563, 0.1449, 0.1330, 0.1775, 0.0790, 0.1231, 0.0671, 0.1154, 0.1346, },
	[16] = {0.1515, 0.1449, 0.1267, 0.1660, 0.0757, 0.1188, 0.0671, 0.1111, 0.1346, },
	[17] = {0.1471, 0.1403, 0.1194, 0.1560, 0.0757, 0.1188, 0.0671, 0.1111, 0.1303, },
	[18] = {0.1389, 0.1318, 0.1117, 0.1450, 0.0757, 0.1147, 0.0671, 0.1111, 0.1262, },
	[19] = {0.1351, 0.1318, 0.1060, 0.1355, 0.0727, 0.1147, 0.0671, 0.1071, 0.1262, },
	[20] = {0.1282, 0.1242, 0.0998, 0.1271, 0.0727, 0.1073, 0.0643, 0.1034, 0.1122, },
	[21] = {0.1282, 0.1208, 0.0962, 0.1197, 0.0727, 0.1073, 0.0643, 0.1000, 0.1122, },
	[22] = {0.1250, 0.1208, 0.0910, 0.1144, 0.0727, 0.1039, 0.0643, 0.1000, 0.1092, },
	[23] = {0.1190, 0.1144, 0.0872, 0.1084, 0.0699, 0.1039, 0.0643, 0.0968, 0.1063, },
	[24] = {0.1163, 0.1115, 0.0829, 0.1040, 0.0699, 0.1008, 0.0617, 0.0968, 0.1063, },
	[25] = {0.1111, 0.1087, 0.0797, 0.0980, 0.0699, 0.0978, 0.0617, 0.0909, 0.1010, },
	[26] = {0.1087, 0.1060, 0.0767, 0.0936, 0.0673, 0.0950, 0.0617, 0.0909, 0.1010, },
	[27] = {0.1064, 0.1035, 0.0734, 0.0903, 0.0673, 0.0950, 0.0617, 0.0909, 0.0985, },
	[28] = {0.1020, 0.1011, 0.0709, 0.0865, 0.0673, 0.0924, 0.0617, 0.0882, 0.0962, },
	[29] = {0.1000, 0.0988, 0.0680, 0.0830, 0.0649, 0.0924, 0.0593, 0.0882, 0.0962, },
	[30] = {0.0962, 0.0945, 0.0654, 0.0792, 0.0649, 0.0875, 0.0593, 0.0833, 0.0878, },
	[31] = {0.0943, 0.0925, 0.0637, 0.0768, 0.0649, 0.0875, 0.0593, 0.0833, 0.0859, },
	[32] = {0.0926, 0.0925, 0.0614, 0.0741, 0.0627, 0.0853, 0.0593, 0.0811, 0.0859, },
	[33] = {0.0893, 0.0887, 0.0592, 0.0715, 0.0627, 0.0831, 0.0571, 0.0811, 0.0841, },
	[34] = {0.0877, 0.0870, 0.0575, 0.0691, 0.0627, 0.0831, 0.0571, 0.0789, 0.0824, },
	[35] = {0.0847, 0.0836, 0.0556, 0.0664, 0.0606, 0.0792, 0.0571, 0.0769, 0.0808, },
	[36] = {0.0833, 0.0820, 0.0541, 0.0643, 0.0606, 0.0773, 0.0551, 0.0750, 0.0792, },
	[37] = {0.0820, 0.0820, 0.0524, 0.0628, 0.0606, 0.0773, 0.0551, 0.0732, 0.0777, },
	[38] = {0.0794, 0.0791, 0.0508, 0.0609, 0.0586, 0.0756, 0.0551, 0.0732, 0.0777, },
	[39] = {0.0781, 0.0776, 0.0493, 0.0592, 0.0586, 0.0756, 0.0551, 0.0714, 0.0762, },
	[40] = {0.0758, 0.0750, 0.0481, 0.0572, 0.0586, 0.0723, 0.0532, 0.0698, 0.0709, },
	[41] = {0.0735, 0.0737, 0.0470, 0.0556, 0.0568, 0.0707, 0.0532, 0.0682, 0.0696, },
	[42] = {0.0725, 0.0737, 0.0457, 0.0542, 0.0568, 0.0707, 0.0532, 0.0682, 0.0696, },
	[43] = {0.0704, 0.0713, 0.0444, 0.0528, 0.0551, 0.0693, 0.0532, 0.0667, 0.0685, },
	[44] = {0.0694, 0.0701, 0.0433, 0.0512, 0.0551, 0.0679, 0.0514, 0.0667, 0.0673, },
	[45] = {0.0676, 0.0679, 0.0421, 0.0497, 0.0551, 0.0665, 0.0514, 0.0638, 0.0651, },
	[46] = {0.0667, 0.0669, 0.0413, 0.0486, 0.0534, 0.0652, 0.0514, 0.0625, 0.0641, },
	[47] = {0.0649, 0.0659, 0.0402, 0.0474, 0.0534, 0.0639, 0.0498, 0.0625, 0.0641, },
	[48] = {0.0633, 0.0639, 0.0391, 0.0464, 0.0519, 0.0627, 0.0498, 0.0612, 0.0631, },
	[49] = {0.0625, 0.0630, 0.0382, 0.0454, 0.0519, 0.0627, 0.0498, 0.0600, 0.0621, },
	[50] = {0.0610, 0.0612, 0.0373, 0.0440, 0.0519, 0.0605, 0.0482, 0.0588, 0.0585, },
	[51] = {0.0595, 0.0604, 0.0366, 0.0431, 0.0505, 0.0594, 0.0482, 0.0577, 0.0577, },
	[52] = {0.0588, 0.0596, 0.0358, 0.0422, 0.0505, 0.0583, 0.0482, 0.0577, 0.0569, },
	[53] = {0.0575, 0.0580, 0.0350, 0.0412, 0.0491, 0.0583, 0.0467, 0.0566, 0.0561, },
	[54] = {0.0562, 0.0572, 0.0341, 0.0404, 0.0491, 0.0573, 0.0467, 0.0556, 0.0561, },
	[55] = {0.0549, 0.0557, 0.0334, 0.0394, 0.0478, 0.0554, 0.0467, 0.0545, 0.0546, },
	[56] = {0.0543, 0.0550, 0.0328, 0.0386, 0.0478, 0.0545, 0.0454, 0.0536, 0.0539, },
	[57] = {0.0532, 0.0544, 0.0321, 0.0378, 0.0466, 0.0536, 0.0454, 0.0526, 0.0531, },
	[58] = {0.0521, 0.0530, 0.0314, 0.0370, 0.0466, 0.0536, 0.0454, 0.0517, 0.0525, },
	[59] = {0.0510, 0.0524, 0.0307, 0.0364, 0.0454, 0.0528, 0.0441, 0.0517, 0.0518, },
	[60] = {0.0500, 0.0512, 0.0301, 0.0355, 0.0454, 0.0512, 0.0441, 0.0500, 0.0493, },
	[61] = {0.0469, 0.0491, 0.0297, 0.0334, 0.0443, 0.0496, 0.0435, 0.0484, 0.0478, },
	[62] = {0.0442, 0.0483, 0.0290, 0.0322, 0.0444, 0.0486, 0.0432, 0.0481, 0.0472, },
	[63] = {0.0418, 0.0472, 0.0284, 0.0307, 0.0441, 0.0470, 0.0424, 0.0470, 0.0456, },
	[64] = {0.0397, 0.0456, 0.0279, 0.0296, 0.0433, 0.0456, 0.0423, 0.0455, 0.0447, },
	[65] = {0.0377, 0.0446, 0.0273, 0.0286, 0.0426, 0.0449, 0.0422, 0.0448, 0.0438, },
	[66] = {0.0360, 0.0437, 0.0270, 0.0276, 0.0419, 0.0437, 0.0411, 0.0435, 0.0430, },
	[67] = {0.0344, 0.0425, 0.0264, 0.0268, 0.0414, 0.0427, 0.0412, 0.0436, 0.0424, },
	[68] = {0.0329, 0.0416, 0.0259, 0.0262, 0.0412, 0.0417, 0.0408, 0.0424, 0.0412, },
	[69] = {0.0315, 0.0408, 0.0254, 0.0256, 0.0410, 0.0408, 0.0404, 0.0414, 0.0406, },
	[70] = {0.0303, 0.0400, 0.0250, 0.0250, 0.0400, 0.0400, 0.0400, 0.0405, 0.0400, },
	[71] = {0.0297, 0.0393, 0.0246, 0.0244, 0.0390, 0.0392, 0.0396, 0.0396, 0.0394, },
	[72] = {0.0292, 0.0385, 0.0242, 0.0238, 0.0381, 0.0384, 0.0393, 0.0387, 0.0388, },
	[73] = {0.0287, 0.0378, 0.0238, 0.0233, 0.0372, 0.0377, 0.0389, 0.0379, 0.0383, },
}

function StatCompare_GetCritFromAgi(agi, class, level)
	class = SCClassNameToID[strupper(class)]
	return agi * SCCritPerAgi[level][class]
end

-- Numbers reverse engineered by Whitetooth@Cenarius (hotdogee@bahamut.twbbs.org)
local SCSpellCritPerInt = {
	 [1] = {0.0000, 0.0832, 0.0699, 0.0000, 0.1710, 0.1333, 0.1637, 0.1500, 0.1431, },
	 [2] = {0.0000, 0.0793, 0.0666, 0.0000, 0.1636, 0.1272, 0.1574, 0.1435, 0.1369, },
	 [3] = {0.0000, 0.0793, 0.0666, 0.0000, 0.1568, 0.1217, 0.1516, 0.1375, 0.1312, },
	 [4] = {0.0000, 0.0757, 0.0635, 0.0000, 0.1505, 0.1217, 0.1411, 0.1320, 0.1259, },
	 [5] = {0.0000, 0.0757, 0.0635, 0.0000, 0.1394, 0.1166, 0.1364, 0.1269, 0.1211, },
	 [6] = {0.0000, 0.0724, 0.0608, 0.0000, 0.1344, 0.1120, 0.1320, 0.1222, 0.1166, },
	 [7] = {0.0000, 0.0694, 0.0608, 0.0000, 0.1297, 0.1077, 0.1279, 0.1179, 0.1124, },
	 [8] = {0.0000, 0.0694, 0.0583, 0.0000, 0.1254, 0.1037, 0.1240, 0.1138, 0.1124, },
	 [9] = {0.0000, 0.0666, 0.0583, 0.0000, 0.1214, 0.1000, 0.1169, 0.1100, 0.1086, },
	[10] = {0.0000, 0.0666, 0.0559, 0.0000, 0.1140, 0.1000, 0.1137, 0.1065, 0.0984, },
	[11] = {0.0000, 0.0640, 0.0559, 0.0000, 0.1045, 0.0933, 0.1049, 0.0971, 0.0926, },
	[12] = {0.0000, 0.0616, 0.0538, 0.0000, 0.0941, 0.0875, 0.0930, 0.0892, 0.0851, },
	[13] = {0.0000, 0.0594, 0.0499, 0.0000, 0.0875, 0.0800, 0.0871, 0.0825, 0.0807, },
	[14] = {0.0000, 0.0574, 0.0499, 0.0000, 0.0784, 0.0756, 0.0731, 0.0767, 0.0750, },
	[15] = {0.0000, 0.0537, 0.0466, 0.0000, 0.0724, 0.0700, 0.0671, 0.0717, 0.0684, },
	[16] = {0.0000, 0.0537, 0.0466, 0.0000, 0.0684, 0.0666, 0.0639, 0.0688, 0.0656, },
	[17] = {0.0000, 0.0520, 0.0451, 0.0000, 0.0627, 0.0636, 0.0602, 0.0635, 0.0617, },
	[18] = {0.0000, 0.0490, 0.0424, 0.0000, 0.0597, 0.0596, 0.0568, 0.0600, 0.0594, },
	[19] = {0.0000, 0.0490, 0.0424, 0.0000, 0.0562, 0.0571, 0.0538, 0.0569, 0.0562, },
	[20] = {0.0000, 0.0462, 0.0399, 0.0000, 0.0523, 0.0538, 0.0505, 0.0541, 0.0516, },
	[21] = {0.0000, 0.0450, 0.0388, 0.0000, 0.0502, 0.0518, 0.0487, 0.0516, 0.0500, },
	[22] = {0.0000, 0.0438, 0.0388, 0.0000, 0.0470, 0.0500, 0.0460, 0.0493, 0.0477, },
	[23] = {0.0000, 0.0427, 0.0368, 0.0000, 0.0453, 0.0474, 0.0445, 0.0471, 0.0463, },
	[24] = {0.0000, 0.0416, 0.0358, 0.0000, 0.0428, 0.0459, 0.0422, 0.0446, 0.0437, },
	[25] = {0.0000, 0.0396, 0.0350, 0.0000, 0.0409, 0.0437, 0.0405, 0.0429, 0.0420, },
	[26] = {0.0000, 0.0387, 0.0341, 0.0000, 0.0392, 0.0424, 0.0390, 0.0418, 0.0409, },
	[27] = {0.0000, 0.0387, 0.0333, 0.0000, 0.0376, 0.0412, 0.0372, 0.0398, 0.0394, },
	[28] = {0.0000, 0.0370, 0.0325, 0.0000, 0.0362, 0.0394, 0.0338, 0.0384, 0.0384, },
	[29] = {0.0000, 0.0362, 0.0318, 0.0000, 0.0348, 0.0383, 0.0325, 0.0367, 0.0366, },
	[30] = {0.0000, 0.0347, 0.0304, 0.0000, 0.0333, 0.0368, 0.0312, 0.0355, 0.0346, },
	[31] = {0.0000, 0.0340, 0.0297, 0.0000, 0.0322, 0.0354, 0.0305, 0.0347, 0.0339, },
	[32] = {0.0000, 0.0333, 0.0297, 0.0000, 0.0311, 0.0346, 0.0294, 0.0333, 0.0325, },
	[33] = {0.0000, 0.0326, 0.0285, 0.0000, 0.0301, 0.0333, 0.0286, 0.0324, 0.0318, },
	[34] = {0.0000, 0.0320, 0.0280, 0.0000, 0.0289, 0.0325, 0.0278, 0.0311, 0.0309, },
	[35] = {0.0000, 0.0308, 0.0269, 0.0000, 0.0281, 0.0314, 0.0269, 0.0303, 0.0297, },
	[36] = {0.0000, 0.0303, 0.0264, 0.0000, 0.0273, 0.0304, 0.0262, 0.0295, 0.0292, },
	[37] = {0.0000, 0.0297, 0.0264, 0.0000, 0.0263, 0.0298, 0.0254, 0.0284, 0.0284, },
	[38] = {0.0000, 0.0287, 0.0254, 0.0000, 0.0256, 0.0289, 0.0248, 0.0277, 0.0276, },
	[39] = {0.0000, 0.0282, 0.0250, 0.0000, 0.0249, 0.0283, 0.0241, 0.0268, 0.0269, },
	[40] = {0.0000, 0.0273, 0.0241, 0.0000, 0.0241, 0.0272, 0.0235, 0.0262, 0.0256, },
	[41] = {0.0000, 0.0268, 0.0237, 0.0000, 0.0235, 0.0267, 0.0230, 0.0256, 0.0252, },
	[42] = {0.0000, 0.0264, 0.0237, 0.0000, 0.0228, 0.0262, 0.0215, 0.0248, 0.0244, },
	[43] = {0.0000, 0.0256, 0.0229, 0.0000, 0.0223, 0.0254, 0.0211, 0.0243, 0.0240, },
	[44] = {0.0000, 0.0256, 0.0225, 0.0000, 0.0216, 0.0248, 0.0206, 0.0236, 0.0233, },
	[45] = {0.0000, 0.0248, 0.0218, 0.0000, 0.0210, 0.0241, 0.0201, 0.0229, 0.0228, },
	[46] = {0.0000, 0.0245, 0.0215, 0.0000, 0.0206, 0.0235, 0.0197, 0.0224, 0.0223, },
	[47] = {0.0000, 0.0238, 0.0212, 0.0000, 0.0200, 0.0231, 0.0192, 0.0220, 0.0219, },
	[48] = {0.0000, 0.0231, 0.0206, 0.0000, 0.0196, 0.0226, 0.0188, 0.0214, 0.0214, },
	[49] = {0.0000, 0.0228, 0.0203, 0.0000, 0.0191, 0.0220, 0.0184, 0.0209, 0.0209, },
	[50] = {0.0000, 0.0222, 0.0197, 0.0000, 0.0186, 0.0215, 0.0179, 0.0204, 0.0202, },
	[51] = {0.0000, 0.0219, 0.0194, 0.0000, 0.0183, 0.0210, 0.0176, 0.0200, 0.0198, },
	[52] = {0.0000, 0.0216, 0.0192, 0.0000, 0.0178, 0.0207, 0.0173, 0.0195, 0.0193, },
	[53] = {0.0000, 0.0211, 0.0186, 0.0000, 0.0175, 0.0201, 0.0170, 0.0191, 0.0191, },
	[54] = {0.0000, 0.0208, 0.0184, 0.0000, 0.0171, 0.0199, 0.0166, 0.0186, 0.0186, },
	[55] = {0.0000, 0.0203, 0.0179, 0.0000, 0.0166, 0.0193, 0.0162, 0.0182, 0.0182, },
	[56] = {0.0000, 0.0201, 0.0177, 0.0000, 0.0164, 0.0190, 0.0154, 0.0179, 0.0179, },
	[57] = {0.0000, 0.0198, 0.0175, 0.0000, 0.0160, 0.0187, 0.0151, 0.0176, 0.0176, },
	[58] = {0.0000, 0.0191, 0.0170, 0.0000, 0.0157, 0.0182, 0.0149, 0.0172, 0.0173, },
	[59] = {0.0000, 0.0189, 0.0168, 0.0000, 0.0154, 0.0179, 0.0146, 0.0168, 0.0169, },
	[60] = {0.0000, 0.0185, 0.0164, 0.0000, 0.0151, 0.0175, 0.0143, 0.0165, 0.0164, },
	[61] = {0.0000, 0.0157, 0.0157, 0.0000, 0.0148, 0.0164, 0.0143, 0.0159, 0.0162, },
	[62] = {0.0000, 0.0153, 0.0154, 0.0000, 0.0145, 0.0159, 0.0143, 0.0154, 0.0157, },
	[63] = {0.0000, 0.0148, 0.0150, 0.0000, 0.0143, 0.0152, 0.0143, 0.0148, 0.0150, },
	[64] = {0.0000, 0.0143, 0.0144, 0.0000, 0.0139, 0.0147, 0.0142, 0.0143, 0.0146, },
	[65] = {0.0000, 0.0140, 0.0141, 0.0000, 0.0137, 0.0142, 0.0142, 0.0138, 0.0142, },
	[66] = {0.0000, 0.0136, 0.0137, 0.0000, 0.0134, 0.0138, 0.0138, 0.0135, 0.0137, },
	[67] = {0.0000, 0.0133, 0.0133, 0.0000, 0.0132, 0.0134, 0.0133, 0.0130, 0.0133, },
	[68] = {0.0000, 0.0131, 0.0130, 0.0000, 0.0130, 0.0131, 0.0131, 0.0127, 0.0131, },
	[69] = {0.0000, 0.0128, 0.0128, 0.0000, 0.0127, 0.0128, 0.0128, 0.0125, 0.0128, },
	[70] = {0.0000, 0.0125, 0.0125, 0.0000, 0.0125, 0.0125, 0.0125, 0.0122, 0.0125, },
	[71] = {0.0000, 0.0122, 0.0123, 0.0000, 0.0123, 0.0122, 0.0122, 0.0119, 0.0122, },
	[72] = {0.0000, 0.0120, 0.0120, 0.0000, 0.0121, 0.0120, 0.0119, 0.0116, 0.0120, },
	[73] = {0.0000, 0.0118, 0.0118, 0.0000, 0.0119, 0.0117, 0.0117, 0.0114, 0.0118, },
}

function StatCompare_GetSpellCritFromInt(int, class, level)
	-- if class is a class string, convert to class id
	class = SCClassNameToID[strupper(class)]
	return int * SCSpellCritPerInt[level][class]
end

CHARSTAT_EFFECTS = {
	{ effect = "STR",		name = STATCOMPARE_STR},
	{ effect = "AGI",		name = STATCOMPARE_AGI},
	{ effect = "STA",		name = STATCOMPARE_STA},
	{ effect = "INT",		name = STATCOMPARE_INT},
	{ effect = "SPI",		name = STATCOMPARE_SPI},
	{ effect = "ARMOR",		name = STATCOMPARE_ARMOR},
	{ effect = "ENARMOR",		name = STATCOMPARE_ENARMOR},
	{ effect = "DAMAGEREDUCE",	name = STATCOMPARE_DAMAGEREDUCE},

	{ effect = "ARCANERES",		name = STATCOMPARE_ARCANERES},
	{ effect = "FIRERES",		name = STATCOMPARE_FIRERES},
	{ effect = "NATURERES", 	name = STATCOMPARE_NATURERES},
	{ effect = "FROSTRES",		name = STATCOMPARE_FROSTRES},
	{ effect = "SHADOWRES",		name = STATCOMPARE_SHADOWRES},
	{ effect = "DETARRES",		name = STATCOMPARE_DETARRES},

	{ effect = "DEFENSE",		name = STATCOMPARE_DEFENSE},

	{ effect = "ATTACKPOWER",	name = STATCOMPARE_ATTACKPOWER},
	{ effect = "ATTACKPOWERUNDEAD",	name = STATCOMPARE_ATTACKPOWERUNDEAD},
	{ effect = "BEARAP",		name = STATCOMPARE_ATTACKPOWER},
	{ effect = "CATAP",		name = STATCOMPARE_ATTACKPOWER},
	{ effect = "CRIT",		name = STATCOMPARE_CRIT},
	{ effect = "BLOCK",		name = STATCOMPARE_BLOCK},
	{ effect = "TOBLOCK",		name = STATCOMPARE_TOBLOCK},
	{ effect = "DODGE",		name = STATCOMPARE_DODGE},
	{ effect = "PARRY", 		name = STATCOMPARE_PARRY},
	--{ effect = "TOHIT", 		name = STATCOMPARE_TOHIT},
	{ effect = "RANGEDATTACKPOWER", name = STATCOMPARE_RANGEDATTACKPOWER},
	--{ effect = "RANGEDCRIT",	name = STATCOMPARE_RANGEDCRIT},

	{ effect = "DMG",		name = STATCOMPARE_DMG},
	{ effect = "DMGUNDEAD",		name = STATCOMPARE_DMGUNDEAD},
	{ effect = "HEAL",		name = STATCOMPARE_HEAL},
	{ effect ="FLASHHOLYLIGHTHEAL", name = STATCOMPARE_FLASHHOLYLIGHT_HEAL},
	--{ effect = "HOLYCRIT", 		name = STATCOMPARE_HOLYCRIT},
	--{ effect = "SPELLCRIT", 	name = STATCOMPARE_SPELLCRIT},
	--{ effect = "SPELLTOHIT", 	name = STATCOMPARE_SPELLTOHIT},
	--{ effect = "ARCANEDMG", 	name = STATCOMPARE_ARCANEDMG},
	--{ effect = "FIREDMG", 		name = STATCOMPARE_FIREDMG},
	--{ effect = "FROSTDMG",		name = STATCOMPARE_FROSTDMG},
	--{ effect = "HOLYDMG",		name = STATCOMPARE_HOLYDMG},
	--{ effect = "NATUREDMG",		name = STATCOMPARE_NATUREDMG},
	--{ effect = "SHADOWDMG",		name = STATCOMPARE_SHADOWDMG},

	{ effect = "HEALTH",		name = STATCOMPARE_HEALTH},
	{ effect = "MANA",		name = STATCOMPARE_MANA},
	{ effect = "MANAREG",		name = STATCOMPARE_MANAREG},

};

function StatCompare_CharStats_Scan(bonuses, unit)
	local sunit;
	local found = false;
	local CharStats_basevals = {};
	CharStats_fullvals = {};

	if(unit) then
		sunit = unit;
	else
		sunit = "target";
	end

	if ( not UnitIsPlayer(sunit)) then
		return;
	end

	local level = UnitLevel(sunit);
	if (UnitLevel(sunit) ~= 70) then
		return;
	end

	local _, race = UnitRace(sunit);
	local _, class = UnitClass(sunit);
	for i=1, getn(CharStats_base) do
		if(CharStats_base[i].race == race and CharStats_base[i].class == class) then
			CharStats_basevals["STR"] = CharStats_base[i].str;
			CharStats_basevals["AGI"] = CharStats_base[i].agi;
			CharStats_basevals["STA"] = CharStats_base[i].sta;
			CharStats_basevals["SPI"] = CharStats_base[i].spi;
			CharStats_basevals["INT"] = CharStats_base[i].int;
			CharStats_basevals["ARCANERES"] = CharStats_base[i].ar;
			CharStats_basevals["FIRERES"]   = CharStats_base[i].fr;
			CharStats_basevals["NATURERES"] = CharStats_base[i].nr;
			CharStats_basevals["FROSTRES"] = CharStats_base[i].ir;
			CharStats_basevals["SHADOWRES"] = CharStats_base[i].sr;
			CharStats_basevals["HEALTH"] = CharStats_base[i].health;
			CharStats_basevals["MANA"] = CharStats_base[i].mana;
			found = true;
			break;
		end
	end

	if(not found) then
		return;
	end

	-- Defence = 350
	CharStats_basevals["DEFENSE"] = 350;
	
	for i,e in pairs(CHARSTAT_EFFECTS) do
		if(bonuses[e.effect]) then
			CharStats_fullvals[e.effect] = bonuses[e.effect];
		end
		if(CharStats_basevals[e.effect]) then
			if(CharStats_fullvals[e.effect]) then
				CharStats_fullvals[e.effect] = CharStats_fullvals[e.effect] + CharStats_basevals[e.effect];
			else
				CharStats_fullvals[e.effect] = CharStats_basevals[e.effect];
			end
		end
	end

	-- for paladin's bless of king 
	if(SC_Buffer_King and SC_Buffer_King == 1) then
		SC_Buffer_King = 0;
		CharStats_fullvals["STA"] = math.ceil(CharStats_fullvals["STA"] * 1.10);
		CharStats_fullvals["INT"] = math.ceil(CharStats_fullvals["INT"] * 1.10);
		CharStats_fullvals["STR"] = math.ceil(CharStats_fullvals["STR"] * 1.10);
		CharStats_fullvals["AGI"] = math.ceil(CharStats_fullvals["AGI"] * 1.10);
		CharStats_fullvals["SPI"] = math.ceil(CharStats_fullvals["SPI"] * 1.10);
	end
	
	-- Health = 10 * Sta
	if(CharStats_fullvals["HEALTH"]) then
		CharStats_fullvals["HEALTH"] = CharStats_fullvals["HEALTH"] + 10 * (CharStats_fullvals["STA"] - CharStats_basevals["STA"]);
	else
		CharStats_fullvals["HEALTH"] = CharStats_basevals["HEALTH"] + 10 * (CharStats_fullvals["STA"] - CharStats_basevals["STA"]);
	end

	-- Mana = 15 * Int
	if(CharStats_basevals["MANA"] and CharStats_fullvals["MANA"]) then
		CharStats_fullvals["MANA"] = CharStats_fullvals["MANA"] + 15 * (CharStats_fullvals["INT"] - CharStats_basevals["INT"]);
	elseif(CharStats_basevals["MANA"]) then
		CharStats_fullvals["MANA"] = CharStats_basevals["MANA"] + 15 * (CharStats_fullvals["INT"] - CharStats_basevals["INT"]);
	end

	if (class == "ROGUE" or class == "WARRIOR" ) then
		CharStats_fullvals["MANA"] = 0;
	end

	-- Armor = 2 * Agi + EnArmor + equip_armor
	if(CharStats_fullvals["AGI"]) then
		if(CharStats_fullvals["ARMOR"]) then
			CharStats_fullvals["ARMOR"] = 2 * CharStats_fullvals["AGI"] + CharStats_fullvals["ARMOR"];
		else
			CharStats_fullvals["ARMOR"] = 2 * CharStats_fullvals["AGI"];
		end
		if(CharStats_fullvals["ENARMOR"]) then
			CharStats_fullvals["ARMOR"] = CharStats_fullvals["ENARMOR"] + CharStats_fullvals["ARMOR"];
		end
	end

	local value = 0;

	local levelmod = level;
	if(level > 59) then
		levelmod = levelmod + (4.5 * (levelmod - 59))
	end
	value = 0.1 * CharStats_fullvals["ARMOR"] / ( 8.5 * levelmod + 40);
	value = 100 * value / (1 + value);
	if(value > 75) then
		value = 75
	end
	CharStats_fullvals["DAMAGEREDUCE"] = format("%.2f",value);

	-- RESILIENCE
	value = 0
	if(CharStats_fullvals["RESILIENCE"]) then
		
	end

	-- AP(Attack Power)
	value = 0;
    	if(class == "DRUID") then
		value = 2 * CharStats_fullvals["STR"] - 20;
	elseif (class == "MAGE" or class == "PRIEST" or class == "WARLOCK") then
		value = CharStats_fullvals["STR"] - 10;
	elseif (class == "HUNTER" or class == "ROGUE") then
		value = level * 2 + CharStats_fullvals["STR"] + CharStats_fullvals["AGI"] - 20;
	elseif (class == "WARRIOR" or class == "PALADIN") then
		value = level * 3 + CharStats_fullvals["STR"] * 2 - 20;
	elseif (class == "SHAMAN") then
		value = level * 2 + CharStats_fullvals["STR"] * 2 - 20;
	end

	if(CharStats_fullvals["ATTACKPOWER"]) then
		CharStats_fullvals["ATTACKPOWER"] = value + CharStats_fullvals["ATTACKPOWER"];
	else
		CharStats_fullvals["ATTACKPOWER"] = value;
	end

	if(class == "DRUID") then
		if(not CharStats_fullvals["BEARAP"]) then
			CharStats_fullvals["BEARAP"] = CharStats_fullvals["ATTACKPOWER"] + (level * 3);
		else
			CharStats_fullvals["BEARAP"] = CharStats_fullvals["BEARAP"] + CharStats_fullvals["ATTACKPOWER"] + (level * 3);
		end
		if(not CharStats_fullvals["CATAP"]) then
			CharStats_fullvals["CATAP"] = CharStats_fullvals["ATTACKPOWER"] + (level * 2) + CharStats_fullvals["AGI"];
		else
			CharStats_fullvals["CATAP"] = CharStats_fullvals["CATAP"] + CharStats_fullvals["ATTACKPOWER"] + (level * 2) + CharStats_fullvals["AGI"];
		end
	else
		CharStats_fullvals["CATAP"] = 0;
		CharStats_fullvals["BEARAP"] = 0;
	end

	if(CharStats_fullvals["ATTACKPOWERUNDEAD"]) then
		CharStats_fullvals["ATTACKPOWERUNDEAD"] = CharStats_fullvals["ATTACKPOWER"] + CharStats_fullvals["ATTACKPOWERUNDEAD"];
	end

	-- RAP(Ranged Attack Power)
	value = CharStats_fullvals["AGI"];
	if (class == "HUNTER") then
		value = value + (level - 5) * 2 ;
	elseif (class == "WARRIOR" or class == "ROGUE") then
		value = value + level - 10;
	else 
		value = 0;
	end

	CharStats_fullvals["RANGEDATTACKPOWER"] = value + (bonuses["RANGEDATTACKPOWER"] or 0) + (bonuses["ATTACKPOWER"] or 0);

	if (class == "HUNTER" or class == "WARRIOR" or class == "ROGUE") then
	else
		-- ignore the other classes' ranged attack power.
		CharStats_fullvals["RANGEDATTACKPOWER"] = 0;
	end

	-- Parry
	value = 0;
	if (class == "DRUID" or class == "MAGE" or class == "PRIEST" or class == "WARLOCK" or class == "SHAMAN") then
		value = 0;
	else
		-- because the Talent, this value is not accu. :(
		value = 5 + 0.04 * (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]);
		if(bonuses["PARRY"]) then
			value = value + bonuses["PARRY"];
		end
	end
	CharStats_fullvals["PARRY"] = value;

	-- Block
	value = 0;
	if (class == "DRUID" or class == "MAGE" or class == "PRIEST" or class == "WARLOCK" or class == "SHAMAN") then
		value = 0;
	else
		if (CharStats_fullvals["BLOCK"]) then
			value = CharStats_fullvals["BLOCK"] + (CharStats_fullvals["STR"] / 20 - 1);
		end
	end
	CharStats_fullvals["BLOCK"] = value;

	-- To Block
	value = 0;
	if (class == "DRUID" or class == "MAGE" or class == "PRIEST" or class == "WARLOCK" or class == "SHAMAN") then
		value = 0;
	else
		if (CharStats_fullvals["TOBLOCK"]) then
			value = CharStats_fullvals["TOBLOCK"] + (CharStats_fullvals["DEFENSE"] - CharStats_basevals["DEFENSE"]) * 0.04;
		end
	end
	CharStats_fullvals["TOBLOCK"] = value;
	
	-- Dodge
	value = (StatCompare_GetDodgeFromAgi(CharStats_fullvals["AGI"], class) + StatCompare_GetBaseDodge(class));
	value = (bonuses["DODGE"] or 0) + value;

	if (race == "NightElf") then
		value = value + 1;
	end
	if(val ~= 0) then
		CharStats_fullvals["DODGE"] = value;
	else
		CharStats_fullvals["DODGE"] = 0;
	end

	-- Stealth Skill
	value = 0;
	-- for a 70 lvl user
	value = 350;
	if(bonuses["STEALTH"]) then
		value = value + bonuses["STEALTH"];
	end
	if(race == "NightElf") then
		value = value + 5;
	end

	if(class == "DRUID" or class == "ROGUE") then
		CharStats_fullvals["STEALTH"] = value;
	end

	-- Melee Critical Chance
	value = StatCompare_GetCritFromAgi(CharStats_fullvals["AGI"], class, level);
	if(class == "DRUID") then
		value = value + 0.9;
	elseif(class == "PALADIN") then
		value = value + 0.7;
	elseif(class == "WARLOCK") then
		value = value + 2;
	elseif(class == "PRIEST" or class == "MAGE") then
		value = value + 3;
	elseif(class == "SHAMAN") then
		value = value + 1.7;
	end

	if(bonuses["CRIT"]) then
		value = value + bonuses["CRIT"];
	end

	if(val ~= 0) then
		CharStats_fullvals["CRIT"] = value;
	else
		CharStats_fullvals["CRIT"] = 0;
	end

	-- Spell Critical Chance
	value = 0;
	if(class == "ROGUE") then
		value = 0;
	elseif(class == "WARRIOR") then
		value = 0;
	else
		value = StatCompare_GetSpellCritFromInt(CharStats_fullvals["INT"], class, level);
	end

	if(bonuses["SPELLCRIT"]) then
		value = value + bonuses["SPELLCRIT"];
	end

	if(value ~= 0) then
		CharStats_fullvals["SPELLCRIT"] = value;
	else
		CharStats_fullvals["SPELLCRIT"] = 0;
	end
	
	-- HASTESPELL Chance
	value = 0;
	if(class == "ROGUE") then
		value = 0;
	elseif(class == "WARRIOR") then
		value = 0;
	end

	if(bonuses["HASTESPELL"]) then
		value = value + bonuses["HASTESPELL"];
	end

	if(value ~= 0) then
		CharStats_fullvals["HASTESPELL"] = value;
	else
		CharStats_fullvals["HASTESPELL"] = 0;
	end
	
		-- HASTEMelee Chance
	value = 0;
	if(bonuses["HASTEMELEE"]) then
		value = value + bonuses["HASTEMELEE"];
	end

	if(value ~= 0) then
		CharStats_fullvals["HASTEMELEE"] = value;
	else
		CharStats_fullvals["HASTEMELEE"] = 0;
	end
	
	-- Mana regen from spirit
	if(class == "DRUID") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 4.5 + 15;
	elseif(class == "PRIEST") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] * ( CharStats_fullvals["INT"] ^ 0.5 ) * 0.00932715221261 * 5;
	elseif(class == "HUNTER") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 15;
	elseif(class == "MAGE") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 4 + 12.5;
	elseif(class == "PALADIN") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 15;
	elseif(class == "SHAMAN") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 17;
	elseif(class == "WARLOCK") then
		CharStats_fullvals["MANAREGSPI"] = CharStats_fullvals["SPI"] / 5 + 15;
	end

	-- Do not display defense if it is 350(70*5)
	if( CharStats_fullvals["DEFENSE"] == 350) then
		CharStats_fullvals["DEFENSE"] = 0;
	end

	if( CharStats_fullvals["DMGUNDEAD"] ) then
		if( CharStats_fullvals["DMG"] ) then
			CharStats_fullvals["DMGUNDEAD"] = CharStats_fullvals["DMGUNDEAD"] + CharStats_fullvals["DMG"];
		end
	end
	-- Do not want to show the Heal/Damage value
	CharStats_fullvals["HEAL"] = 0;
	CharStats_fullvals["DMG"] = 0;

	--[[ Add Druid/Priest tolents benifit for MANAREGEN/5s
	if( class == "DRUID") then
		if(StatCompare_SpellStats_CheckTalents) then
			local tolents = 0;
			if( sunit == "player" ) then
				tolents = StatCompare_SpellStats_CheckTalents(SC_TALENT_INTENSITY);
			end
			if(bonuses["MANAREGCOMBAT"]) then
				tolents = tolents + bonuses["MANAREGCOMBAT"]/100;
			end
			if(tolents > 0) then
				CharStats_fullvals["MANAREG"] = (CharStats_fullvals["MANAREG"] or 0)+ CharStats_fullvals["MANAREGSPI"] * tolents * 2.5;
				CharStats_fullvals["MANAREG"] = math.floor(CharStats_fullvals["MANAREG"]);
			end
		end
	elseif( class == "PRIEST") then
		if(StatCompare_SpellStats_CheckTalents) then
			local tolents = 0;
			if( sunit == "player" ) then
				tolents = StatCompare_SpellStats_CheckTalents(SC_TALENT_MEDITATION);
			end

			if(bonuses["MANAREGCOMBAT"]) then
				tolents = tolents + bonuses["MANAREGCOMBAT"]/100;
			end
			if(tolents > 0) then
				CharStats_fullvals["MANAREG"] = (CharStats_fullvals["MANAREG"] or 0) +CharStats_fullvals["MANAREGSPI"] * tolents * 2.5;
				CharStats_fullvals["MANAREG"] = math.floor(CharStats_fullvals["MANAREG"]);
			end
		end
	else
		CharStats_fullvals["MANAREG"] = 0;
	end
	]]--
end

function StatCompare_BaseCharStat(unit)
	local basestats = {};

	local sunit;
	local found = false;

	if(unit) then
		sunit = unit;
	else
		sunit = "target";
	end

	if ( not UnitIsPlayer(sunit)) then
		return nil;
	end

	local level = UnitLevel(sunit);
	if (UnitLevel(sunit) ~= 70) then
		return nil;
	end


	local _, race = UnitRace(sunit);
	local _, class = UnitClass(sunit);
	for i=1, getn(CharStats_base) do
		if(CharStats_base[i].race == race and CharStats_base[i].class == class) then
			basestats["STR"] = CharStats_base[i].str;
			basestats["AGI"] = CharStats_base[i].agi;
			basestats["STA"] = CharStats_base[i].sta;
			basestats["SPI"] = CharStats_base[i].spi;
			basestats["INT"] = CharStats_base[i].int;
			basestats["ARCANERES"] = CharStats_base[i].ar;
			basestats["FIRERES"]   = CharStats_base[i].fr;
			basestats["NATURERES"] = CharStats_base[i].nr;
			basestats["FROSTRES"] = CharStats_base[i].ir;
			basestats["SHADOWRES"] = CharStats_base[i].sr;
			basestats["HEALTH"] = CharStats_base[i].health;
			basestats["MANA"] = CharStats_base[i].mana;
			found = true;
			break;
		end
	end

	return basestats;
end