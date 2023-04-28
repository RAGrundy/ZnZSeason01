function OnTake_AntiVirus(_player)
	print("OnTake_AntiVirus - Taking Antivirus");

	local bodyDamage = _player:getBodyDamage();
	if bodyDamage:IsInfected() == true then
		print("OnTake_AntiVirus - Host is infected");

		local bodyParts = bodyDamage:getBodyParts();
		for i = 0, bodyParts:size() - 1 do
			local bodyPart = bodyParts:get(i);
			if bodyPart:IsInfected() == true then
				print("OnTake_AntiVirus - " .. tostring(bodyPart) .. " is infected");
				bodyPart:SetInfected(false);
				print("OnTake_AntiVirus - Infection Removed from " .. tostring(bodyPart));
			end
		end

		bodyDamage:setInfected(false);
		bodyDamage:setInfectionMortalityDuration(-1);
		bodyDamage:setInfectionTime(-1);
		bodyDamage:setInfectionLevel(0);
		print("OnTake_AntiVirus - Infection Removed from main host");

		if bodyDamage:IsInfected() == false then
			print("Infection Removed from host");
		end
	end
end
