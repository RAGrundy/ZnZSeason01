function OnEat_AntiVirus(food, player, percent)
	print("Taking Antivirus");

	local bodyDamage = player:getBodyDamage();
	if bodyDamage:IsInfected() == true then
		print("Host is infected");

		local bodyParts = bodyDamage:getBodyParts();
		for i = 0, bodyParts:size() - 1 do
			local bodyPart = bodyParts:get(i);
			if bodyPart:IsInfected() == true then
				print("Sub host is infected");
				print("Sub host is: " .. tostring(bodyPart));
				bodyPart:SetInfected(false);
				print("Infection Removed from sub host");
			end
		end

		bodyDamage:setInfected(false);
		bodyDamage:setInfectionMortalityDuration(-1);
		bodyDamage:setInfectionTime(-1);
		bodyDamage:setInfectionLevel(0);
		print("Infection Removed from main host");

		if bodyDamage:IsInfected() == false then
			print("Infection Removed from host");
		end
	end
end
