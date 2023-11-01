extends Node

var save_file_path = "user://save/"
var save_file_name = "SaveData.tres"


var tempMoney = 0

var data = SaveData.new()
var temp = SaveData.new()
# ~~ MAIN VIARIABLES ~~

var fun = 0
var varMainValue = 1
var varSaveTime = 120
@onready var pgbGuestHappiness = $pgbGuestHappiness
@onready var lblGuestHappiness = $pgbGuestHappiness/lblGuestHappiness
@onready var lblMainMoney = $btnMain/lblMainMoney
@onready var lblOutput = $lblOutput

var justLoaded = false

# ~~~~~~~~~~~~~~~~~~~~~
#
# ~~ GENERATOR VARIABLES ~~

# Snack Stand

var varSnackStandFunFact = 50
@onready var btnSnackStand = $btnSnackStand
@onready var lblSnackStand = $btnSnackStand/lblSnackStand

# Toilet
var varToiletFunFact = 0
@onready var btnToilet = $btnToilet
@onready var lblToilet = $btnToilet/lblToilet

# Camera
var varCameraFunFact = 1000
@onready var btnCamera = $btnCamera
@onready var lblCamera = $btnCamera/lblCamera

# Small Attraction
var varSmallAttractionFunFact = 5000
@onready var btnSmallAttraction = $btnSmallAttraction
@onready var lblSmallAttraction = $btnSmallAttraction/lblSmallAttraction

# Large Attraction
var varLargeAttractionFunFact = 10000
@onready var btnLargeAttraction = $btnLargeAttraction
@onready var lblLargeAttraction = $btnLargeAttraction/lblLargeAttraction

# Wooden Coaster

var varWoodenCoasterFunFact = 10000
@onready var btnWoodenCoaster = $btnWoodenCoaster
@onready var lblWoodenCoaster = $btnWoodenCoaster/lblWoodenCoaster

# Steel Coaster

var varSteelCoasterFunFact = 10000
@onready var btnSteelCoaster = $btnSteelCoaster
@onready var lblSteelCoaster = $btnSteelCoaster/lblSteelCoaster

# ~~~~~~~~~~~~~~~~~~~~~

# Initialization
func _ready():
	lblSnackStand.set_text("[b]SNACK STAND [/b][font_size=14]\nCost: " 
	+ str(data.varSnackStandCost) + "\nCurrently Owned: " + str(data.varSnackStandOwned) 
	+ "\nProduction rate: $" + str(data.varSnackStandValue) 
	+ "/s[/font_size]")
	
	verify_save_directory(save_file_path)

func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

# Per Frame Updates
func _process(_delta):
	
# UNLOCKERS
	
	#Toilet Unlocker
	if data.totalMoney >= 100 and data.money >= 90 and not data.boolToiletVisible:
		data.boolToiletVisible = true
		update_labels()
	
	#Camera Unlocker
	if data.totalMoney >= 500 and data.money >= 400 and not data.boolCameraVisible:
		data.boolCameraVisible = true
		update_labels()
	
	#Small Attraction Unlocker
	if data.totalMoney >= 5000 and data.money >= 4000 and not data.boolSmallAttractionVisible:
		data.boolSmallAttractionVisible = true
		update_labels()
	
	#Large Attrcation Unlocker
	if data.totalMoney >= 10000 and data.money >= 9000 and not data.boolLargeAttractionVisible:
		data.boolLargeAttractionVisible = true
		update_labels()
	
	#Wooden Coaster Unlocker
	if data.totalMoney >= 50000 and data.money >= 40000 and not data.boolWoodenCoasterVisible:
		data.boolWoodenCoasterVisible = true
		update_labels()
	
	#Steel Coaster Unlocker
	if data.totalMoney >= 100000 and data.money >= 90000 and not data.boolSteelCoasterVisible:
		data.boolSteelCoasterVisible = true
		update_labels()


# ~~ BUTTON SPECIFIC UPDATES ~~
#
# Main Button Money Updater
func _on_btn_main_button_down():
	data.money += (1 * varMainValue)
	data.totalMoney += (1 * varMainValue)
	update_labels()

	# Snack Stand Button Updater
func _on_btn_snack_stand_button_down():
	if data.money >= data.varSnackStandCost:
		data.money -= data.varSnackStandCost
		data.varSnackStandValue += .1
		data.varSnackStandOwned +=1
		data.varSnackStandCost = round(data.varSnackStandCostBase * 
		pow(1.2, data.varSnackStandOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

	# Toilet Button Updater
func _on_btn_toilet_button_down():
	if data.money >= data.varToiletCost:
		data.money -= data.varToiletCost
		data.varToiletValue += .5
		data.varToiletOwned += 1
		data.varToiletCost = round(data.varToiletCostBase * 
		pow(1.2, data.varToiletOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

	#Camera Button Updater
func _on_btn_camera_button_down():
	if data.money >= data.varCameraCost:
		data.money -= data.varCameraCost
		data.varCameraValue += 5
		data.varCameraOwned += 1
		data.varCameraCost = round(data.varCameraCostBase * 
		pow(1.2, data.varCameraOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

	#Small Attraction Button Updater
func _on_btn_small_attraction_button_down():
	if data.money >= data.varSmallAttractionCost:
		data.money -= data.varSmallAttractionCost
		data.varSmallAttractionValue += 10
		data.varSmallAttractionOwned += 1
		data.varSmallAttractionCost = round(data.varSmallAttractionCostBase * 
		pow(1.2, data.varSmallAttractionOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

	#Large Attraction Button Updater
func _on_btn_large_attraction_button_down():
	if data.money >= data.varLargeAttractionCost:
		data.money -= data.varLargeAttractionCost
		data.varLargeAttractionValue += 50
		data.varLargeAttractionOwned += 1
		data.varLargeAttractionCost = round(data.varLargeAttractionCostBase * 
		pow(1.2, data.varLargeAttractionOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

	#Wooden Coaster Button Updater
func _on_btn_wooden_coaster_button_down():
	if data.money >= data.varWoodenCoasterCost:
		data.money -= data.varWoodenCoasterCost
		data.varWoodenCoasterValue += 100
		data.varWoodenCoasterOwned += 1
		data.varWoodenCoasterCost = round(data.varLargeAttractionCostBase * 
		pow(1.2, data.varWoodenCoasterOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

	#Steel Coaster Button Updater
func _on_btn_steel_coaster_button_down():
	if data.money >= data.varSteelCoasterCost:
		data.money -= data.varSteelCoasterCost
		data.varSteelCoasterValue += 500
		data.varSteelCoasterOwned += 1
		data.varSteelCoasterCost = round(100000 * pow(1.2, data.varSteelCoasterOwned))
		data.varTimeSinceLastAddition = 0
		update_labels()

# ~~~~~~~~~~~~~~~~~~~~~~	

# Timer
func _game_tick(multiplier : int):
	
	tempMoney = (data.varSnackStandValue + data.varToiletValue + data.varCameraValue 
	+ data.varSmallAttractionValue + data.varLargeAttractionValue + data.varWoodenCoasterValue
	+ data.varSteelCoasterValue)
	
	tempMoney *= multiplier
	
	tempMoney = snapped(tempMoney +(tempMoney * data.varGuestMultiplier),0.1)
	
	data.money += tempMoney
	data.totalMoney += tempMoney
	
	data.varTimeSinceLastAddition += 1
	
	if varSaveTime == 0:
		_save()
		varSaveTime = 120
	else:
		varSaveTime -= 1
	
	update_labels()
	guest_calculation()

func _save():
	data.dtUnixTimeOfExport = roundi(Time.get_unix_time_from_system())
	ResourceSaver.save(data, save_file_path + save_file_name)

func _load():
	if ResourceLoader.exists(save_file_path + save_file_name):
		temp = ResourceLoader.load((save_file_path + save_file_name)).duplicate(false)
		if temp.export_file_version == data.export_file_version:
			data = temp
			lblOutput.text = "[b][font_size=13][/font_size][/b]"
			
			var sec_since_save = (roundi(Time.get_unix_time_from_system())
			- data.dtUnixTimeOfExport)
			_game_tick(roundi(sec_since_save)/100000)
		else:
			lblOutput.text = "[b][font_size=13]Unable to load, Unsupported Save Version[/font_size][/b]"
	else:
		lblOutput.text = "[b][font_size=13]No Save File to load[/font_size][/b]"
	

func update_labels():
	lblMainMoney.set_text("[center][font_size=30]Money: $ " + str( snapped(data.money, 0.01)) 
	+ "[/font_size]\nRate: " + str(tempMoney) + "/s[/center]")
	
	lblSnackStand.set_text("[b]SNACK STAND [/b][font_size=14]\nCost: " 
	+ str(data.varSnackStandCost) + "\nCurrently Owned: " + str(data.varSnackStandOwned) 
	+ "\nProduction rate: $" + str(data.varSnackStandValue) 
	+ "/s[/font_size]")
	
	if data.boolToiletVisible:
		btnToilet.disabled = false
		data.varToiletCost = round(100 * pow(1.2, data.varToiletOwned))
		lblToilet.set_text("[b]TOILETS [/b][font_size=14]\nCost: " 
		+ str(data.varToiletCost) + "\nCurrently Owned: " + str(data.varToiletOwned) 
		+ "\nProduction rate: $" + str(data.varToiletValue) 
		+ "/s[/font_size]")
	
	if data.boolCameraVisible:
		btnCamera.disabled = false
		lblCamera.set_text("[b]PHOTO BOOTH [/b][font_size=14]\nCost: " 
		+ str(data.varCameraCost) + "\nCurrently Owned: " + str(data.varCameraOwned) 
		+ "\nProduction rate: $" + str(data.varCameraValue) 
		+ "/s[/font_size]")
	
	if data.boolSmallAttractionVisible:
		btnSmallAttraction.disabled = false
		data.varSmallAttractionCost = round(1500 * pow(1.2, data.varSmallAttractionOwned))
		lblSmallAttraction.set_text("[b]KIDS RIDE [/b][font_size=14]\nCost: " 
		+ str(data.varSmallAttractionCost) + "\nCurrently Owned: " + str(data.varSmallAttractionOwned) 
		+ "\nProduction rate: $" + str(data.varSmallAttractionValue) 
		+ "/s[/font_size]")
	
	if data.boolLargeAttractionVisible:
		btnLargeAttraction.disabled = false
		lblLargeAttraction.set_text("[b]THRILL RIDE [/b][font_size=14]\nCost: " 
		+ str(data.varLargeAttractionCost) + "\nCurrently Owned: " + str(data.varLargeAttractionOwned) 
		+ "\nProduction rate: $" + str(data.varLargeAttractionValue) 
		+ "/s[/font_size]")
	
	if data.boolWoodenCoasterVisible:
		btnWoodenCoaster.disabled = false
		lblWoodenCoaster.set_text("[b]WOODEN COASTER [/b][font_size=14]\nCost: " 
		+ str(data.varWoodenCoasterCost) + "\nCurrently Owned: " + str(data.varWoodenCoasterOwned) 
		+ "\nProduction rate: $" + str(data.varWoodenCoasterValue) 
		+ "/s[/font_size]")
	
	if data.boolSteelCoasterVisible:
		btnSteelCoaster.disabled = false
		lblSteelCoaster.set_text("[b]Steel COASTER [/b][font_size=14]\nCost: " 
		+ str(data.varSteelCoasterCost) + "\nCurrently Owned: " + str(data.varSteelCoasterOwned) 
		+ "\nProduction rate: $" + str(data.varSteelCoasterValue) 
		+ "/s[/font_size]")

func guest_calculation():
	data.varGuestHardCap = ((data.varSnackStandGuest * data.varSnackStandOwned) 
	+ (data.varToiletGuest * data.varToiletOwned) 
	+ (data.varCameraGuest * data.varCameraOwned)
	+ (data.varSmallAttractionGuest * data.varSmallAttractionOwned)
	+ (data.varLargeAttractionGuest * data.varLargeAttractionOwned)
	+ (data.varWoodenCoasterGuest * data.varWoodenCoasterOwned)
	+ (data.varSteelCoasterGuest * data.varSteelCoasterOwned))
	
	data.varGuestLimit = data.varGuestHardCap - (0.1 * data.varGuestHardCap)
	
	data.varGuestRate = ((data.varSnackStandGuestRate * data.varSnackStandOwned) 
	+ (data.varToiletGuestRate * data.varToiletOwned) 
	+ (data.varCameraGuestRate * data.varCameraOwned)
	+ (data.varSmallAttractionGuestRate * data.varSmallAttractionOwned)
	+ (data.varLargeAttractionGuestRate * data.varLargeAttractionOwned)
	+ (data.varWoodenCoasterGuestRate * data.varWoodenCoasterOwned)
	+ (data.varSteelCoasterGuestRate * data.varSteelCoasterOwned))
	if data.varGuestRate < 100:
		data.varGuestRate = 5
	
	if data.varGuests < data.varGuestLimit:
		data.varGuests += randi_range(0,data.varGuestRate)
	elif data.varGuests < data.varGuestHardCap:
		data.varGuests += randi_range(0,(roundi(data.varGuestRate * 0.6))) * randi_range(0,1) 
		if data.varGuests > data.varGuestHardCap: 
			data.varGuests = data.varGuestHardCap
	if data.varGuests > 1000:
		data.varGuestMultiplier = snapped(data.varGuests / 5000,0.01)
	else:
		data.varGuestMultiplier = 0
	pgbGuestHappiness.max_value = data.varGuestHardCap
	pgbGuestHappiness.value = data.varGuests
	lblGuestHappiness.text = ("[center] [b]Guests:  [/b][font_size=14] " + str(round(data.varGuests)) 
	+ "/" + str(data.varGuestHardCap) + "[/font_size][/center]")


func _timer_out():
	_game_tick(1)
