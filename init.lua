dofile_once( "mods/blood_hurts/config.lua" )

local function pauseRisk()
	for _,player in ipairs(EntityGetWithTag("player_unit")) do
		local pos_x, pos_y = EntityGetTransform(player)
		local stats=EntityGetComponent(player,"DamageModelComponent")[1]
		local max_hp=ComponentGetValue2(stats,"max_hp")

		if math.random() < pause_death_chance or ModSettingGet("blood_hurts.dunk_mode") then
			EntityInflictDamage(player, max_hp, "NONE", "Time resumed, but you weren't so lucky.", "FROZEN", 0, 0, player, pos_x, pos_y, 0)
		end
	end
end

local was_paused = false
function OnWorldPreUpdate()
	if was_paused then
		was_paused = false
		pauseRisk()
	end

	for _,player in ipairs(EntityGetWithTag("player_unit")) do
		local pos_x, pos_y = EntityGetTransform(player)
		local stats=EntityGetComponent(player,"DamageModelComponent")[1]
		local max_hp=ComponentGetValue2(stats,"max_hp")

		local wallet = EntityGetFirstComponent(EntityGetWithTag( "player_unit" )[1], "WalletComponent")
		local cGold = ComponentGetValue2(wallet, "money")

		if (cGold >= max_gold_allowed) or (cGold > 1 and ModSettingGet("blood_hurts.dunk_mode")) then
            EntityInflictDamage(player, max_hp, "NONE", "Greed is the enemy of a balanced mind.", "CONVERT_TO_MATERIAL", 0, 0, player, pos_x, pos_y, 0)
		end
	end
end

function OnPlayerSpawned(player_id)
	print(tostring(ModSettingGet("blood_hurts.dunk_mode")))
	if GameHasFlagRun("blood_to_deathium_init") then
		return
	end
	GameAddFlagRun("blood_to_deathium_init")
	ConvertMaterialEverywhere(CellFactory_GetType("blood"), CellFactory_GetType("just_death"))
end

function OnPausePreUpdate()
	was_paused = true
end