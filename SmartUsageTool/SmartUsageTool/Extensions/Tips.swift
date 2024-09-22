//
//  Tips.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//

import Foundation
import TipKit

struct AddNewRoomTip: Tip {
	var title: Text {
		Text(Localize.addNewRoom)
	}
	
	var message: Text? {
		Text(Localize.addNewRoomMessage)
	}
	
	var image: Image? {
		Image(systemName: "house")
	}
}

struct SettingsTip: Tip {
	var title: Text {
		Text(Localize.settings)
	}
	
	var message: Text? {
		Text(Localize.settingsMessage)
	}
	
	var image: Image? {
		Image(systemName: "gear")
	}
}

struct DailyCostTip: Tip {
	var title: Text {
		Text(Localize.dailyCost)
	}
	
	var message: Text? {
		Text(Localize.dailyCostMessage)
	}
	
	var image: Image? {
		Image(systemName: "dollarsign.circle")
	}
}

struct isFetchingLivePricesTip: Tip {
	var title: Text {
		Text(Localize.fetchingLivePrices)
	}
	
	var message: Text? {
		Text(Localize.fetchingLivePricesMessage)
	}
	
	var image: Image? {
		Image(systemName: "arrow.clockwise")
	}
}

struct currentPricePerKwhTip: Tip {
	var title: Text {
		Text(Localize.currentPricePerKwh)
	}
	
	var message: Text? {
		Text(Localize.currentPricePerKwhMessage)
	}
	
	var image: Image? {
		Image(systemName: "bolt")
	}
}

struct AddNewDeviceTip: Tip {
	var title: Text {
		Text(Localize.addNewDevice)
	}
	
	var message: Text? {
		Text(Localize.addNewDeviceMessage)
	}
	
	var image: Image? {
		Image(systemName: "plus")
	}
}

struct EditRoomTip: Tip {
	var title: Text {
		Text(Localize.editRoom)
	}
	
	var message: Text? {
		Text(Localize.editRoomMessage)
	}
	
	var image: Image? {
		Image(systemName: "pencil")
	}
}

struct ToggleDeviceStateTip: Tip {
	var title: Text {
		Text(Localize.toggleDeviceState)
	}
	
	var message: Text? {
		Text(Localize.toggleDeviceStateMessage)
	}
	
	var image: Image? {
		Image(systemName: "power")
	}
}

struct CurrentEnergyPriceTip: Tip {
	var title: Text {
		Text(Localize.currentEnergyPrice)
	}
	
	var message: Text? {
		Text(Localize.currentEnergyPriceMessage)
	}
	
	var image: Image? {
		Image(systemName: "bolt")
	}
}

struct CurrentDevicePricesTip: Tip {
	var title: Text {
		Text(Localize.currentDevicePrices)
	}
	
	var message: Text? {
		Text(Localize.currentDevicePricesMessage)
	}
	
	var image: Image? {
		Image(systemName: "dollarsign.circle")
	}
}

struct selectedTimeRangeHighAndLowTip : Tip {
	var title: Text {
		Text(Localize.selectedTimeRangeHighAndLow)
	}
	
	var message: Text? {
		Text(Localize.selectedTimeRangeHighAndLowMessage)
	}
	
	var image: Image? {
		Image(systemName: "arrow.up.arrow.down")
	}
}

struct ChangeArticleLanguageTip: Tip {
	var title: Text {
		Text(Localize.changeArticleLanguage)
	}
	
	var message: Text? {
		Text(Localize.changeArticleLanguageMessage)
	}
	
	var image: Image? {
		Image(systemName: "textformat")
	}
}

struct getMoreStatistics: Tip {
	var title: Text {
		Text(Localize.getMoreStats)
	}
	
	var message: Text? {
		Text(Localize.getMoreStatsInTheSettingsAndGetYourOwnAPIkey)
	}
	
	var image: Image? {
		Image(systemName: "chart.bar")
	}
}
