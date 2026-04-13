extends Panel
# Dit script bestuurt de shop:
# - Speler kan upgrades kopen
# - Green Tea ontgrendelen
# - Klanten meer geduld geven
# - Munten aftrekken via het Economy-systeem


# STATUS VAN UPGRADES

var green_tea_unlocked := false
# Houdt bij of Green Tea al is ontgrendeld

var speed_upgraded := false
# Houdt bij of de speed/geduld-upgrade al is gekocht


# GREEN TEA UPGRADE

func _on_unlock_green_tea_pressed():
	# Als Green Tea al ontgrendeld is, doe niets
	if green_tea_unlocked:
		return

	# Controleer of de speler genoeg munten heeft
	if Economy.coins >= 20:
		# Trek munten af
		Economy.add_coins(-20)

		# Zet upgrade actief
		green_tea_unlocked = true

		# Pas de knoptekst aan
		$VBoxContainer/UnlockGreenTea.text = "Green Tea Unlocked"
	else:
		# Niet genoeg munten
		$VBoxContainer/UnlockGreenTea.text = "Not enough coins"


# SPEED / GEDULD UPGRADE

func _on_speed_upgrade_button_pressed():
	# Als de upgrade al gekocht is, doe niets
	if speed_upgraded:
		return

	# Controleer of de speler genoeg munten heeft
	if Economy.coins >= 30:
		# Trek munten af
		Economy.add_coins(-30)

		# Zet upgrade actief
		speed_upgraded = true

		# Pas de upgrade toe op alle klanten
		get_tree().call_group("customer", "apply_speed_upgrade")

		# Pas de knoptekst aan
		$VBoxContainer/SpeedUpgradeButton.text = "Speed Upgraded"
	else:
		# Niet genoeg munten
		$VBoxContainer/SpeedUpgradeButton.text = "Not enough coins"


# SHOP SLUITEN

func _on_close_button_pressed():
	# Verberg het shoppaneel
	visible = false
