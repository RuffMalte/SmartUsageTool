//
//  HomeView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
	@State private var dayPrice = String(format: "%.5f", UserDefaults.dayPrice)
	@State private var nightPrice = String(format: "%.5f", UserDefaults.nightPrice)
	@State private var currencyCode = UserDefaults.currency
	@State private var useDailyFetching = UserDefaults.useDailyFetching
	
	@EnvironmentObject private var viewModel: ElectricityPriceController
	
	@Query private var items: [RoomModel]
	@Environment(\.modelContext) private var modelContext
	
	@State private var isPresentedNewRoom = false
	@State private var isNightPrice = UserDefaults.isNightPrice
	private var totalCost: Double {
		var sum = 0.0
		switch selectedTimeRange {
		case .daily:
			sum = items.reduce(0.0) { $0 + $1.dailyExpenses}
		case .monthly:
			sum = items.reduce(0.0) { $0 + $1.monthlyExpenses}
		case .yearly:
			sum = items.reduce(0.0) { $0 + $1.yearlyExpenses}
		case nil:
			sum = items.reduce(0.0) { $0 + $1.dailyExpenses}
		}
		return sum
	}
	
	@State private var selectedTimeRange: TimePeriod?
	
	let columns = [
		GridItem(.flexible(), spacing: 10),
		GridItem(.flexible(), spacing: 10)
	]
	
	@State private var isPresentedCurrencySelectionSettings = false
	
	var body: some View {
		NavigationView {
			contentView
				.onTapGesture {
					hideKeyboard()
				}
				.onChange(of: dayPrice) { oldValue, newValue in
					UserDefaults.setDay(price: Double(newValue) ?? 0)
				}
				.onChange(of: nightPrice) { oldValue, newValue in
					UserDefaults.setNight(price: Double(newValue) ?? 0)
				}
				.onChange(of: currencyCode, { oldValue, newValue in
					currencyCode = newValue
				})
				.onAppear {
					dayPrice = String(format: "%.5f", UserDefaults.dayPrice)
					nightPrice = String(format: "%.5f", UserDefaults.nightPrice)
					isNightPrice = UserDefaults.isNightPrice
					currencyCode = UserDefaults.currency
					useDailyFetching = UserDefaults.useDailyFetching
					selectedTimeRange = UserDefaults.selectedTimePeriod
				}
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItem(placement: .principal) {
						HStack {
							Text(Localize.myHome)
								.font(.system(.title3, design: .default, weight: .bold))
							Spacer()
						}
					}
					ToolbarItem(placement: .primaryAction) {
						HStack {
							Button(action: { isPresentedNewRoom.toggle() }) {
								Image(systemName: "plus")
							}
							.popoverTip(AddNewRoomTip())
							
							Menu {
								Picker(selection: $selectedTimeRange) {
									ForEach(TimePeriod.allCases, id: \.self) { time in
										Label(time.localizedString, systemImage: time.icon)
											.tag(time)
									}
								} label: {
									Label(Localize.timeRange, systemImage: "clock")
								}
								.pickerStyle(.menu)
								.onChange(of: selectedTimeRange) { oldValue, newValue in
									if let new = newValue {
										UserDefaults.setSelectedTimePeriod(new)
									}
								}
								
								
							} label: {
								Image(systemName: "ellipsis.circle")
							}

							
							NavigationLink {
								MainSettingsView()
							} label: {
								Image(systemName: "gearshape.fill")
							}
							.popoverTip(SettingsTip())
						}
					}
				}
		}
	}
	
	private func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
	
	@State private var currentTime = Date()
	@State private var lastFetchTime: Date?
	let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
}

private extension HomeView {
	var contentView: some View {
		VStack {
			headerView
			collectionView
			Spacer()
		}
		.sheet(isPresented: $isPresentedNewRoom) {
			ModifyRoomSheetView(room: RoomModel.new, isNewRoom: true)
		}
		.sheet(isPresented: $isPresentedCurrencySelectionSettings) {
			CurrencySelectionPickerView(useCompactView: true) { code in
				withAnimation(.snappy) {
					UserDefaults.setCurrency(code)
					currencyCode = code
					playNotificationHaptic(.success)
				}
			}
			.presentationDetents([.fraction(0.3), .medium])
		}
		.onReceive(timer) { _ in
			currentTime = Date()
			if UserDefaults.useDailyFetching {
				checkAndFetch()
			}
		}
		.onAppear {
			if UserDefaults.useDailyFetching {	
				checkAndFetch()
			}
		}
	}
	
	func checkAndFetch() {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.minute], from: currentTime)
		
		if let lastFetch = lastFetchTime,
		   currentTime.timeIntervalSince(lastFetch) >= 3600,
		   components.minute == 1 {
			fetchData()
		} else if lastFetchTime == nil {
			fetchData()
		}
	}
	
	func fetchData() {
		viewModel.fetchCurrentPrice()
		print("Fetching data at \(currentTime)")
		lastFetchTime = currentTime
	}
	
	
	var headerView: some View {
		VStack(alignment: .leading, spacing: 20) {
			
			HStack {
				
				Text(Localize.totalCost)
					.font(.system(.headline, design: .rounded, weight: .regular))
				
				Text(totalCost, format: .currency(code: currencyCode))
					.font(.system(.headline, design: .monospaced, weight: .regular))
				
				if let selectedTimeRangeIcon = selectedTimeRange?.icon {
					Spacer()
					
					Image(systemName: selectedTimeRangeIcon)
						.foregroundStyle(.primary)
						.font(.subheadline)
				}
			}
			.popoverTip(DailyCostTip())

			HStack(alignment: .bottom) {
				HStack {
					VStack(alignment: .leading) {
						HStack {
							VStack(alignment: .center) {
								HStack {
									if isNightPrice {
										Label(Localize.day, systemImage: "sun.max")
											.font(.system(.footnote, design: .rounded, weight: .light))
										Spacer()
									}
								}
								TextField("0,00", text: $dayPrice)
									.font(.system(.body, design: .monospaced, weight: .regular))
							}
							Spacer()
							VStack(alignment: .center) {
								if isNightPrice {
									VStack {
										HStack {
											Label(Localize.night, systemImage: "moon.stars")
												.font(.system(.footnote, design: .rounded, weight: .light))
											Spacer()
										}
										TextField("0,00", text: $nightPrice)
											.font(.system(.body, design: .monospaced, weight: .regular))
									}
								}
							}
						}
					}
					if useDailyFetching {
						Image(systemName: "globe")
							.foregroundStyle(.secondary)
							.popoverTip(isFetchingLivePricesTip())
					}
				}
				.textFieldStyle(PlainTextFieldStyle())
				.keyboardType(.decimalPad)
				.padding(10)
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(.windowBackground)
				)
				
				
				Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])).currencySymbol ?? "$")" + Localize.wattPerHour)
					.font(.system(.body, design: .default, weight: .regular))
					.padding(10)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(.windowBackground)
					)
					.onTapGesture {
						isPresentedCurrencySelectionSettings.toggle()
					}
					.popoverTip(currentPricePerKwhTip())
			}
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 20)
				.ignoresSafeArea()
				.foregroundStyle(Color.background)
				.shadow(radius: 10)
		}
	}
	
	var collectionView: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 20) {
				ForEach(items) { room in
					NavigationLink {
						RoomView(room: room, isNightPrice: $isNightPrice)
					} label: {
						RoomItemListView(room: room)
					}
					.buttonStyle(.plain)
				}
			}
			.padding(10)
		}
		.padding(.horizontal, 20)
	}
	
}

#Preview {
	HomeView()
		.withEnvironmentObjects()
}
