-- AtlasLoot loot tables frFR locale file
-- NOTE: THIS FILE IS AUTO-GENERATED BY A TOOL, ANY MANUALLY CHANGE MIGHT BE OVERWRITTEN.
-- $Id: WorldPvP.fr.lua 257 2008-07-16 15:36:58Z kurax $

if GetLocale() == "frFR" then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootWorldPvPItems"][category] or #AtlasLoot_Data["AtlasLootWorldPvPItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootWorldPvPItems"][category][i][3] = data[i] end end data = nil end
Process("Hellfire",22,{"=q3=Bague du vainqueur","=q3=Olivine barbelée","=q3=Grenat sanguin puissant","","","=q1=Faveur du bastion de l'Honneur","=q1=Marque du bastion de l'Honneur","","","","","","","","","=q3=Diadème du vainqueur","=q3=Olivine entaillée","=q3=Grenat sanguin sobre","","","=q1=Faveur de Thrallmar","=q1=Marque de Thrallmar"})
Process("Nagrand1",29,{"=q4=Rênes de talbuk de monte sombre","=q4=Pierre d'aube mystique sublime","=q3=Jambières de hiérophante","=q3=Jambières de traquerêve","=q3=Jambières de traqueur des ombres","=q3=Garde-jambes de tireur d'élite","=q3=Jambières de Brise-orage","=q3=Cuissards de vengeur","=q3=Jambières de tueur","","=q3=Dessin : Pierre d'aube mystique","","","=q2=Gage de bataille de Halaa","","=q4=Rênes de talbuk de guerre sombre","=q3=Sac halaani","=q3=Echarpe de hiérophante","=q3=Echarpe de traquerêve","=q3=Echarpe de traqueur des ombres","=q3=Ceinture de tireur d'élite","=q3=Ceinturon de Brise-orage","=q3=Sangle de vengeur","=q3=Sangle de tueur","","=q3=Dessin : Talasite stable","=q1=Recette : Elixir peau-de-fer","","=q2=Gage de recherche de Halaa"})
Process("Nagrand2",22,{"=q3=Trait de rasoir halaani","=q1=Whisky halaani","","","=q3=Coeur de Don Amancio","=q2=Claymore halaani","=q2=Lames vengeresses","","","","","","","","","=q3=Trait sinistre halaani","","","","=q3=Coeur de don Rodrigue","=q2=Claymore arkadienne","=q2=Le petit affûté"})
Process("Terokkar",25,{"=q4=Bague de l'exorciste","=q3=Diamant brûlétoile de rapidité","=q3=Chaperon d'exorciste en tisse-effroi","=q3=Casque d'exorciste en peau de dragon","=q3=Casque d'exorciste en peau de wyrm","=q3=Casque d'exorciste riveté","=q3=Casque d'exorciste lamellaire","=q3=Casque d'exorciste en écailles","","=q1=Potion de soins auchenaï","","=q1=Eclat d'esprit","","","","=q4=Sceau de l'exorciste","=q3=Diamant brûlevent de rapidité","=q3=Chaperon d'exorciste en soie","=q3=Casque d'exorciste en cuir","=q3=Casque d'exorciste en anneaux","=q3=Casque d'exorciste en mailles","=q3=Casque d'exorciste en plaques","","","=q1=Potion de mana auchenaï"})
Process("Zangarmarsh",22,{"=q3=Idole de sauvagerie","=q3=Totem d'impact","=q3=Marque de défiance","=q3=Tranchant fatal","=q3=Bâtonnet incendique","","=q1=Marque du bastion de l'Honneur","","","","","","","","","=q3=Libram de zèle","=q3=Marque de conquête","=q3=Marque de justification","=q3=Crève-cible","","","=q1=Marque de Thrallmar"})
end