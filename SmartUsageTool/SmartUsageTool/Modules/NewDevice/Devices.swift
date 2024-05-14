//
//  Devices.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 17.04.2024.
//

import Foundation

enum Device: String, CaseIterable {
    case other = "Other"
    case spaceHeater = "Space Heater"
    case heatPump = "Heat Pump"
    case portableHeater = "Portable Heater"
    case waterHeater = "Water Heater"
    case dishWasher = "Dish Washer"
    case refrigerator = "Refrigerator"
    case clothesWasher = "Clothes Washer"
    case clothesDryer = "Clothes Dryer"
    case roomAC = "Room AC"
    case centralAC = "Central AC"
    case coffeeMaker = "Coffee Maker"
    case electricRadiator = "Electric Radiator"
    case humidifier = "Humidifier"
    case waterCooler = "Water Cooler"
    case lighting = "Lighting"
    case furnaceFan = "Furnace Fan"
    case fan = "Fan"
    case iron = "Iron"
    case toaster = "Toaster"
    case computer = "Computer"
    case vacuumCleaner = "Vacuum Cleaner"
    case tV = "TV"
    case hairDryer = "Hair Dryer"
    case handDrill = "Hand Drill"
    case waterPump = "Water Pump"
    case blender = "Blender"
    case electricStove = "Electric Stove"
    case poolPump = "Pool Pump"
    case electricVehicle = "Electric Vehicle"
    case microwaveOven = "Microwave Oven"
    case riceCooker = "Rice Cooker"
    case electricKettle = "Electric Kettle"
    case oven = "Oven"
    
    var localizedName: String {
         switch self {
         case .other:
             return Localize.other
         case .spaceHeater:
             return Localize.spaceHeater
         case .heatPump:
             return Localize.heatPump
         case .portableHeater:
             return Localize.portableHeater
         case .waterHeater:
             return Localize.waterHeater
         case .dishWasher:
             return Localize.dishWasher
         case .refrigerator:
             return Localize.refrigerator
         case .clothesWasher:
             return Localize.clothesWasher
         case .clothesDryer:
             return Localize.clothesDryer
         case .roomAC:
             return Localize.roomAC
         case .centralAC:
             return Localize.centralAC
         case .coffeeMaker:
             return Localize.coffeeMaker
         case .electricRadiator:
             return Localize.electricRadiator
         case .humidifier:
             return Localize.humidifier
         case .waterCooler:
             return Localize.waterCooler
         case .lighting:
             return Localize.lighting
         case .furnaceFan:
             return Localize.furnaceFan
         case .fan:
             return Localize.fan
         case .iron:
             return Localize.iron
         case .toaster:
             return Localize.toaster
         case .computer:
             return Localize.computer
         case .vacuumCleaner:
             return Localize.vacuumCleaner
         case .tV:
             return Localize.tV
         case .hairDryer:
             return Localize.hairDryer
         case .handDrill:
             return Localize.handDrill
         case .waterPump:
             return Localize.waterPump
         case .blender:
             return Localize.blender
         case .electricStove:
             return Localize.electricStove
         case .poolPump:
             return Localize.poolPump
         case .electricVehicle:
             return Localize.electricVehicle
         case .microwaveOven:
             return Localize.microwaveOven
         case .riceCooker:
             return Localize.riceCooker
         case .electricKettle:
             return Localize.electricKettle
         case .oven:
             return Localize.oven
         }
     }
}
