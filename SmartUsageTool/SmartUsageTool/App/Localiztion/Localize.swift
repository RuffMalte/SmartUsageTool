//
//  Localize.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 14.05.2024.
//

import Foundation

struct Localize {
    // Home screen
    static let wattPerHour = NSLocalizedString("wattHour", comment: "")
    static let myHome = NSLocalizedString("myHome", comment: "")
    static let day = NSLocalizedString("day", comment: "")
    static let night = NSLocalizedString("night", comment: "")
    static let currency = NSLocalizedString("currency", comment: "")
    static let save = NSLocalizedString("save", comment: "")
    static let cancel = NSLocalizedString("cancel", comment: "")
	static let edit = NSLocalizedString("edit", comment: "")
    static let room = NSLocalizedString("room", comment: "")
    static let addRoom = NSLocalizedString("addRoom", comment: "")
    static let addDevice = NSLocalizedString("addDevice", comment: "")
    static let device = NSLocalizedString("device", comment: "")
    static let powerW = NSLocalizedString("powerW", comment: "")
    static let dailyUsage = NSLocalizedString("dailyUsage", comment: "")
    static let nightlyUsage = NSLocalizedString("nightlyUsage", comment: "")
    static let dailyUsageHours = NSLocalizedString("dailyUsageHours", comment: "")
    static let nightlyUsageHours = NSLocalizedString("nightlyUsageHours", comment: "")
    static let power = NSLocalizedString("power", comment: "")
    static let selectDevice = NSLocalizedString("selectDevice", comment: "")
    static let totalCost = NSLocalizedString("totalCost", comment: "")
    static let nightPricing = NSLocalizedString("nightPricing", comment: "")
    static let hrs = NSLocalizedString("hrs", comment: "")
	static let min = NSLocalizedString("min", comment: "")
    static let currencySymbol = NSLocalizedString("currencySymbol", comment: "")
    static let enterPower = NSLocalizedString("enterPower", comment: "")
    static let list = NSLocalizedString("list", comment: "")
    static let w = NSLocalizedString("w", comment: "")
    static let enterName = NSLocalizedString("enterName", comment: "")
    static let enterTime = NSLocalizedString("enterTime", comment: "")
    static let selectRoom = NSLocalizedString("selectRoom", comment: "")
    
    // Room localizations
    static let other = NSLocalizedString("Other", comment: "#bc-ignore!")
    static let livingRoom = NSLocalizedString("Livingroom", comment: "#bc-ignore!")
    static let kitchen = NSLocalizedString("Kitchen", comment: "#bc-ignore!")
    static let bedroom = NSLocalizedString("Bedroom", comment: "#bc-ignore!")
    static let bathroom = NSLocalizedString("Bathroom", comment: "#bc-ignore!")
    static let diningRoom = NSLocalizedString("Diningroom", comment: "#bc-ignore!")
    static let homeOffice = NSLocalizedString("Homeoffice", comment: "#bc-ignore!")
    static let laundryRoom = NSLocalizedString("Laundryroom", comment: "#bc-ignore!")
    static let garage = NSLocalizedString("Garage", comment: "#bc-ignore!")
    static let basement = NSLocalizedString("Basement", comment: "#bc-ignore!")
    static let attic = NSLocalizedString("Attic", comment: "#bc-ignore!")
    static let guestRoom = NSLocalizedString("Guestroom", comment: "#bc-ignore!")
    static let nursery = NSLocalizedString("Nursery", comment: "#bc-ignore!")
    static let playroom = NSLocalizedString("Playroom", comment: "#bc-ignore!")
    static let library = NSLocalizedString("Library", comment: "#bc-ignore!")
    static let studyRoom = NSLocalizedString("Studyroom", comment: "#bc-ignore!")
    static let conservatory = NSLocalizedString("Conservatory", comment: "#bc-ignore!")
    static let mudroom = NSLocalizedString("Mudroom", comment: "#bc-ignore!")
    static let sunroom = NSLocalizedString("Sunroom", comment: "#bc-ignore!")
    static let pantry = NSLocalizedString("Pantry", comment: "#bc-ignore!")
    static let hallway = NSLocalizedString("Hallway", comment: "#bc-ignore!")
    static let foyer = NSLocalizedString("Foyer", comment: "#bc-ignore!")
    static let den = NSLocalizedString("Den", comment: "#bc-ignore!")
    static let gym = NSLocalizedString("Gym", comment: "#bc-ignore!")
    static let homeTheater = NSLocalizedString("Hometheater", comment: "#bc-ignore!")
    static let workshop = NSLocalizedString("Workshop", comment: "#bc-ignore!")
    static let storageRoom = NSLocalizedString("Storageroom", comment: "#bc-ignore!")
    
    // Device localizations
    static let spaceHeater = NSLocalizedString("Space Heater", comment: "#bc-ignore!")
    static let heatPump = NSLocalizedString("Heat Pump", comment: "#bc-ignore!")
    static let portableHeater = NSLocalizedString("Portable Heater", comment: "#bc-ignore!")
    static let waterHeater = NSLocalizedString("Water Heater", comment: "#bc-ignore!")
    static let dishWasher = NSLocalizedString("Dish Washer", comment: "#bc-ignore!")
    static let refrigerator = NSLocalizedString("Refrigerator", comment: "#bc-ignore!")
    static let clothesWasher = NSLocalizedString("Clothes Washer", comment: "#bc-ignore!")
    static let clothesDryer = NSLocalizedString("Clothes Dryer", comment: "#bc-ignore!")
    static let roomAC = NSLocalizedString("Room AC", comment: "#bc-ignore!")
    static let centralAC = NSLocalizedString("Central AC", comment: "#bc-ignore!")
    static let coffeeMaker = NSLocalizedString("Coffee Maker", comment: "#bc-ignore!")
    static let electricRadiator = NSLocalizedString("Electric Radiator", comment: "#bc-ignore!")
    static let humidifier = NSLocalizedString("Humidifier", comment: "#bc-ignore!")
    static let waterCooler = NSLocalizedString("Water Cooler", comment: "#bc-ignore!")
    static let lighting = NSLocalizedString("Lighting", comment: "#bc-ignore!")
    static let furnaceFan = NSLocalizedString("Furnace Fan", comment: "#bc-ignore!")
    static let fan = NSLocalizedString("Fan", comment: "#bc-ignore!")
    static let iron = NSLocalizedString("Iron", comment: "#bc-ignore!")
    static let toaster = NSLocalizedString("Toaster", comment: "#bc-ignore!")
    static let computer = NSLocalizedString("Computer", comment: "#bc-ignore!")
    static let vacuumCleaner = NSLocalizedString("Vacuum Cleaner", comment: "#bc-ignore!")
    static let tV = NSLocalizedString("TV", comment: "#bc-ignore!")
    static let hairDryer = NSLocalizedString("Hair Dryer", comment: "#bc-ignore!")
    static let handDrill = NSLocalizedString("Hand Drill", comment: "#bc-ignore!")
    static let waterPump = NSLocalizedString("Water Pump", comment: "#bc-ignore!")
    static let blender = NSLocalizedString("Blender", comment: "#bc-ignore!")
    static let electricStove = NSLocalizedString("Electric Stove", comment: "#bc-ignore!")
    static let poolPump = NSLocalizedString("Pool Pump", comment: "#bc-ignore!")
    static let electricVehicle = NSLocalizedString("Electric Vehicle", comment: "#bc-ignore!")
    static let microwaveOven = NSLocalizedString("Microwave Oven", comment: "#bc-ignore!")
    static let riceCooker = NSLocalizedString("Rice Cooker", comment: "#bc-ignore!")
    static let electricKettle = NSLocalizedString("Electric Kettle", comment: "#bc-ignore!")
    static let oven = NSLocalizedString("Oven", comment: "#bc-ignore!")
	
	// UI
	static let delete = NSLocalizedString("delete", comment: "#bc-ignore!")
	static let canecl = NSLocalizedString("cancel", comment: "#bc-ignore!")
	static let areYouSure = NSLocalizedString("areYouSure", comment: "#bc-ignore!")
	static let turnOn = NSLocalizedString("turnOn", comment: "#bc-ignore!")
	static let turnOff = NSLocalizedString("turnOff", comment: "#bc-ignore!")
	static let deviceInfo = NSLocalizedString("deviceInfo", comment: "#bc-ignore!")
    static let settings = NSLocalizedString("settings", comment: "#bc-ignore!")
    static let appBy = NSLocalizedString("appBy", comment: "#bc-ignore!")
    static let appName = NSLocalizedString("appName", comment: "#bc-ignore!")
    static let appVersion = NSLocalizedString("appVersion", comment: "#bc-ignore!")
    static let appIcludedLibs = NSLocalizedString("appIcludedLibs", comment: "#bc-ignore!")
    static let about = NSLocalizedString("about", comment: "#bc-ignore!")
    static let regionSettings = NSLocalizedString("regionSettings", comment: "#bc-ignore!")
    static let nightlyUsageDescription = NSLocalizedString("nightlyUsageDescription", comment: "#bc-ignore!")
    
    static let searchCurrencies = NSLocalizedString("searchCurrencies", comment: "#bc-ignore!")
    static let currencyExplanation = NSLocalizedString("currencyExplanation", comment: "#bc-ignore!")

    static let priceFetchingSettings = NSLocalizedString("priceFetchingSettings", comment: "#bc-ignore!")
    static let useDailyFetching = NSLocalizedString("useDailyFetching", comment: "#bc-ignore!")
    static let useDailyFetchingDescription = NSLocalizedString("useDailyFetchingDescription", comment: "#bc-ignore!")
    static let selectCountry = NSLocalizedString("selectCountry", comment: "#bc-ignore!")
    static let forcePriceUpdate = NSLocalizedString("forcePriceUpdate", comment: "#bc-ignore!")
    static let none = NSLocalizedString("none", comment: "#bc-ignore!")

    static let nightPricingFetchingDescription = NSLocalizedString("nightPricingFetchingDescription", comment: "#bc-ignore!")
    static let nightStart = NSLocalizedString("nightStart", comment: "#bc-ignore!")
    static let nightEnd = NSLocalizedString("nightEnd", comment: "#bc-ignore!")
    static let nightPricingDescription = NSLocalizedString("nightPricingDescription", comment: "#bc-ignore!")

    static let appIncludedAPIs = NSLocalizedString("appIncludedAPIs", comment: "#bc-ignore!")
    static let energyChartsAPI = NSLocalizedString("energyChartsAPI", comment: "#bc-ignore!")

    static let summary = NSLocalizedString("summary", comment: "#bc-ignore!")
    static let electricityPrice = NSLocalizedString("electricityPrice", comment: "#bc-ignore!")
    static let latest = NSLocalizedString("latest", comment: "#bc-ignore!")
    static let devicePrices = NSLocalizedString("devicePrices", comment: "#bc-ignore!")
    static let showMoreData = NSLocalizedString("showMoreData", comment: "#bc-ignore!")
    static let range = NSLocalizedString("range", comment: "#bc-ignore!")
    static let devicePrice = NSLocalizedString("devicePrice", comment: "#bc-ignore!")

    static let week = NSLocalizedString("week", comment: "#bc-ignore!")
    static let month = NSLocalizedString("month", comment: "#bc-ignore!")
    static let year = NSLocalizedString("year", comment: "#bc-ignore!")

    static let articles = NSLocalizedString("articles", comment: "#bc-ignore!")

    static let feedback = NSLocalizedString("feedback", comment: "#bc-ignore!")
    static let dangerousSettings = NSLocalizedString("dangerousSettings", comment: "#bc-ignore!")
    static let deleteAllData = NSLocalizedString("deleteAllData", comment: "#bc-ignore!")
    static let deleteAllDevices = NSLocalizedString("deleteAllDevices", comment: "#bc-ignore!")
    static let deleteAllRoomAndDevices = NSLocalizedString("deleteAllRoomAndDevices", comment: "#bc-ignore!")

    static let onboarding = NSLocalizedString("onboarding", comment: "#bc-ignore!")
    static let finishOnboarding = NSLocalizedString("finishOnboarding", comment: "#bc-ignore!")


    static let resetAllTips = NSLocalizedString("resetAllTips", comment: "#bc-ignore!")

    static let addNewRoom = NSLocalizedString("addNewRoom", comment: "#bc-ignore!")
    static let addNewRoomMessage = NSLocalizedString("addNewRoomMessage", comment: "#bc-ignore!")
    static let settingsMessage = NSLocalizedString("settingsMessage", comment: "#bc-ignore!")
    static let dailyCost = NSLocalizedString("dailyCost", comment: "#bc-ignore!")
    static let dailyCostMessage = NSLocalizedString("dailyCostMessage", comment: "#bc-ignore!")
    static let fetchingLivePrices = NSLocalizedString("fetchingLivePrices", comment: "#bc-ignore!")
    static let fetchingLivePricesMessage = NSLocalizedString("fetchingLivePricesMessage", comment: "#bc-ignore!")
    static let currentPricePerKwh = NSLocalizedString("currentPricePerKwh", comment: "#bc-ignore!")
    static let currentPricePerKwhMessage = NSLocalizedString("currentPricePerKwhMessage", comment: "#bc-ignore!")
    static let addNewDevice = NSLocalizedString("addNewDevice", comment: "#bc-ignore!")
    static let addNewDeviceMessage = NSLocalizedString("addNewDeviceMessage", comment: "#bc-ignore!")
    static let editRoom = NSLocalizedString("editRoom", comment: "#bc-ignore!")
    static let editRoomMessage = NSLocalizedString("editRoomMessage", comment: "#bc-ignore!")
    static let toggleDeviceState = NSLocalizedString("toggleDeviceState", comment: "#bc-ignore!")
    static let toggleDeviceStateMessage = NSLocalizedString("toggleDeviceStateMessage", comment: "#bc-ignore!")
    static let currentEnergyPrice = NSLocalizedString("currentEnergyPrice", comment: "#bc-ignore!")
    static let currentEnergyPriceMessage = NSLocalizedString("currentEnergyPriceMessage", comment: "#bc-ignore!")
    static let currentDevicePrices = NSLocalizedString("currentDevicePrices", comment: "#bc-ignore!")
    static let currentDevicePricesMessage = NSLocalizedString("currentDevicePricesMessage", comment: "#bc-ignore!")
    static let selectedTimeRangeHighAndLow = NSLocalizedString("selectedTimeRangeHighAndLow", comment: "#bc-ignore!")
    static let selectedTimeRangeHighAndLowMessage = NSLocalizedString("selectedTimeRangeHighAndLowMessage", comment: "#bc-ignore!")
    static let changeArticleLanguage = NSLocalizedString("changeArticleLanguage", comment: "#bc-ignore!")
    static let changeArticleLanguageMessage = NSLocalizedString("changeArticleLanguageMessage", comment: "#bc-ignore!")

    static let daily = NSLocalizedString("daily", comment: "#bc-ignore!")
    static let monthly = NSLocalizedString("monthly", comment: "#bc-ignore!")
    static let yearly = NSLocalizedString("yearly", comment: "#bc-ignore!")

    static let timeRange = NSLocalizedString("timeRange", comment: "#bc-ignore!")
    static let contractMangement = NSLocalizedString("contractMangement", comment: "#bc-ignore!")
    static let alertOnContractEndTime = NSLocalizedString("alertOnContractEndTime", comment: "#bc-ignore!")
    static let selectDate = NSLocalizedString("selectDate", comment: "#bc-ignore!")
    static let alertOnContractEndTimeDescription = NSLocalizedString("alertOnContractEndTimeDescription", comment: "#bc-ignore!")
    static let yourContractEndsSoon = NSLocalizedString("yourContractEndsSoon", comment: "#bc-ignore!")
    static let yourContractEndsInTheNextFewDays = NSLocalizedString("yourContractEndsInTheNextFewDays", comment: "#bc-ignore!")

    static let introduction = NSLocalizedString("introduction", comment: "#bc-ignore!")
    static let energyUseTutorial = NSLocalizedString("energyUseTutorial", comment: "#bc-ignore!")
    static let energyUseCalculationDefinition = NSLocalizedString("energyUseCalculationDefinition", comment: "#bc-ignore!")
    static let energyUseCalculationDefinitionText = NSLocalizedString("energyUseCalculationDefinitionText", comment: "#bc-ignore!")
    static let energyMonitoringImportance = NSLocalizedString("energyMonitoringImportance", comment: "#bc-ignore!")
    static let energyMonitoringImportanceText = NSLocalizedString("energyMonitoringImportanceText", comment: "#bc-ignore!")
    static let understandingEnergyCosts = NSLocalizedString("understandingEnergyCosts", comment: "#bc-ignore!")
    static let understandingEnergyCostsText = NSLocalizedString("understandingEnergyCostsText", comment: "#bc-ignore!")
    static let factorsAffectingConsumption = NSLocalizedString("factorsAffectingConsumption", comment: "#bc-ignore!")
    static let factorsAffectingConsumptionText = NSLocalizedString("factorsAffectingConsumptionText", comment: "#bc-ignore!")
    static let calculatingEnergyCosts = NSLocalizedString("calculatingEnergyCosts", comment: "#bc-ignore!")
    static let calculatingEnergyCostsText = NSLocalizedString("calculatingEnergyCostsText", comment: "#bc-ignore!")
    static let tipsForReducingConsumption = NSLocalizedString("tipsForReducingConsumption", comment: "#bc-ignore!")
    static let tipsForReducingConsumptionText = NSLocalizedString("tipsForReducingConsumptionText", comment: "#bc-ignore!")

    static let Source = NSLocalizedString("Source", comment: "#bc-ignore!")
    static let moreInformation = NSLocalizedString("moreInformation", comment: "#bc-ignore!")
    static let statisticSettings = NSLocalizedString("statisticSettings", comment: "#bc-ignore!")

    static let EnergyMapsAPIKey = NSLocalizedString("EnergyMapsAPIKey", comment: "#bc-ignore!")
    static let EnterAPIKey = NSLocalizedString("EnterAPIKey", comment: "#bc-ignore!")
    static let apiTestResult = NSLocalizedString("apiTestResult", comment: "#bc-ignore!")
    static let apiTestSuccess = NSLocalizedString("apiTestSuccess", comment: "#bc-ignore!")
    static let apiTestFailed = NSLocalizedString("apiTestFailed", comment: "#bc-ignore!")
    static let ok = NSLocalizedString("ok", comment: "#bc-ignore!")
	static let whatIsAnAPIKey = NSLocalizedString("whatIsAnAPIKey", comment: "#bc-ignore!")
    static let getYourOwnAPIKey = NSLocalizedString("getYourOwnAPIKey", comment: "#bc-ignore!")

    static let devicesCarbonFootprint = NSLocalizedString("devicesCarbonFootprint", comment: "#bc-ignore!")
    static let deviceName = NSLocalizedString("deviceName", comment: "#bc-ignore!")

    static let info = NSLocalizedString("info", comment: "#bc-ignore!")
    static let UnderstandingYourCarbonFootprint = NSLocalizedString("UnderstandingYourCarbonFootprint", comment: "#bc-ignore!")

    static let getMoreStats = NSLocalizedString("getMoreStats", comment: "#bc-ignore!")
    static let getMoreStatsInTheSettingsAndGetYourOwnAPIkey = NSLocalizedString("getMoreStatsInTheSettingsAndGetYourOwnAPIkey", comment: "#bc-ignore!")

    static let mostExpensive = NSLocalizedString("mostExpensive", comment: "#bc-ignore!")
    static let mostExpensiveRooms = NSLocalizedString("mostExpensiveRooms", comment: "#bc-ignore!")
    static let rooms = NSLocalizedString("rooms", comment: "#bc-ignore!")
    static let wattageAndUseTime = NSLocalizedString("wattageAndUseTime", comment: "#bc-ignore!")
    static let howToGetWattageAndUseTime = NSLocalizedString("howToGetWattageAndUseTime", comment: "#bc-ignore!")

    static let projectedYearlyCost = NSLocalizedString("projectedYearlyCost", comment: "#bc-ignore!")
    static let allRooms = NSLocalizedString("allRooms", comment: "#bc-ignore!")
    static let monthlyCost = NSLocalizedString("monthlyCost", comment: "#bc-ignore!")
}

