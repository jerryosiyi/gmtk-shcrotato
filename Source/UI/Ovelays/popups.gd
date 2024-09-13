extends Control


func UpgradePopup(upgrade: UpgradeBase):
	%UpgradePopup.popup()
	%UpgradeName.text = upgrade.name
	%UpgradeValue.text = upgrade.description

func HideUpgradePopup():
	%UpgradePopup.hide()
