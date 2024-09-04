//
//  HomeView.swift
//  SmartUsageTool
//
//  Created by Serhii Molodets on 21.03.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var dayPrice = String(format: "%.4f", UserDefaults.dayPrice)
    @State private var nightPrice = String(format: "%.4f", UserDefaults.nightPrice)
	@State private var currencyCode = UserDefaults.currency
    @ObservedObject var viewModel = HomeViewModel()
	
	
    @Query private var items: [RoomModel]
	@Environment(\.modelContext) private var modelContext
	
    @State private var isPresentedNewRoom = false
    @State private var isNightPrice = UserDefaults.isNightPrice
    private var totalCost: Double {
        let sum = items.reduce(0.0) { $0 + $1.expenses }
        return sum
    }

    let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]
    
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
				.onAppear {
					dayPrice = String(format: "%.4f", UserDefaults.dayPrice)
					nightPrice = String(format: "%.4f", UserDefaults.nightPrice)
					isNightPrice = UserDefaults.isNightPrice
					currencyCode = UserDefaults.currency
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
							NavigationLink {
								MainSettingsView()
							} label: {
								Image(systemName: "gearshape.fill")
							}
						}
					}
				}
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

private extension HomeView {
    var contentView: some View {
        VStack {
            headerView
            collectionView
			Spacer()
        }
        .sheet(isPresented: $isPresentedNewRoom) {
            NewRoom(isPresented: $isPresentedNewRoom)
        }
        
    }
    
    var headerView: some View {
        VStack(alignment: .leading, spacing: 20) {
            
			HStack {
				Text(Localize.totalCost)
					.font(.system(.headline, design: .rounded, weight: .regular))
				
				Text(totalCost, format: .currency(code: currencyCode))
					.font(.system(.headline, design: .monospaced, weight: .regular))
			}
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
				}
				.textFieldStyle(PlainTextFieldStyle())
				.keyboardType(.decimalPad)
				.padding(10)
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(.white)
				)
				
				
				Text("\(Locale(identifier: Locale.identifier(fromComponents: [NSLocale.Key.currencyCode.rawValue: currencyCode])).currencySymbol ?? "$")" + Localize.wattPerHour)
					.font(.system(.body, design: .default, weight: .regular))
					.padding(10)
					.background(
						RoundedRectangle(cornerRadius: 10)
							.fill(.white)
					)
            }
        }
        .padding()
        .background(Color.background)
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
                }
            }
            .padding(10)
        }
		.padding(.horizontal, 20)
    }
    
}

#Preview {
    HomeView()
}
