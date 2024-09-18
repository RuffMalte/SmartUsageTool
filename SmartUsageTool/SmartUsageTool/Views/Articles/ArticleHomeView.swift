//
//  ArticleHomeView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 16.09.24.
//

import SwiftUI

struct ArticleHomeView: View {
	
	@State var selectedArticles: [ArticleModel] = []
	
	var supportedLanguages = ["de", "en"]
	
    var body: some View {
		NavigationView {
			VStack {
				headerView
				TabView {
					ForEach(selectedArticles) { article in
						ArticleItemListView(article: article)
					}
					
				}
				.clipShape(RoundedRectangle(cornerRadius: 20))
				.padding()
				.tabViewStyle(.page)
				.indexViewStyle(.page(backgroundDisplayMode: .always))
				.toolbar {
					ToolbarItem(placement: .primaryAction) {
						Menu {
							Button {
								withAnimation {
									selectedArticles = ArticleModel.germanArticles
								}
							} label: {
								Text("Deutsch")
							}
							Button {
								withAnimation {
									selectedArticles = ArticleModel.englishArticles
								}
							} label: {
								Text("English")
							}
						} label: {
							Image(systemName: "globe")
						}
						.popoverTip(ChangeArticleLanguageTip())
					}
					
					ToolbarItem(placement: .primaryAction) {
						HStack {
							NavigationLink {
								MainSettingsView()
							} label: {
								Image(systemName: "gearshape.fill")
							}
						}
					}
				}
				.onAppear {
					let langStr = Locale.current.language.languageCode?.identifier
					if langStr == "de" {
						selectedArticles = ArticleModel.germanArticles
					} else if langStr == "en" {
						selectedArticles = ArticleModel.englishArticles
					} else {
						selectedArticles = ArticleModel.englishArticles
					}
				}
				Spacer()
			}
		}
		
    }
	
	var headerView: some View {
		HStack {
			Text(Localize.articles)
				.font(.system(.largeTitle, weight: .bold))
			
			Spacer()
		}
		.padding()
		.background(Color.background)
	}
	
}

#Preview {
    ArticleHomeView()
}
