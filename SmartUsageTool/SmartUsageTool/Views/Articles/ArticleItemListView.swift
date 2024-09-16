//
//  ArticleItemListView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 16.09.24.
//

import SwiftUI

struct ArticleItemListView: View {
	var article: ArticleModel
	
	var body: some View {
		GeometryReader { geometry in
			AsyncImage(url: article.urlToImage) { image in
				image
					.resizable()
					.aspectRatio(contentMode: .fill)
					.frame(width: geometry.size.width, height: geometry.size.height)
					.clipped()
			} placeholder: {
				HStack {
					Spacer()
					VStack(alignment: .center) {
						Spacer()
						Image("LaunchIcon")
							.resizable()
							.aspectRatio(contentMode: .fit)
							.frame(width: 100, height: 100)
							.overlay {
								ProgressView()
							}
						Spacer()
					}
					Spacer()
				}
				.frame(height: geometry.size.height / 1.5)
				
			}
			
			VStack {
				Spacer()
				LinearGradient(
					gradient: Gradient(colors: [.clear, .accentColor]),
					startPoint: .top,
					endPoint: .bottom
				)
				.frame(height: geometry.size.height / 2.3)
			}
			
			VStack(alignment: .leading) {
				Spacer()
				VStack(spacing: 10) {
					HStack {
						Text(article.title)
						Spacer()
						Link(destination: article.url, label: {
							Image(systemName: "link")
						})
					}
					.font(.system(.title3, design: .rounded, weight: .bold))
					.lineLimit(2)
					
					HStack {
						Label {
							Text(article.author)
						} icon: {
							Image(systemName: "person.fill")
						}
						Spacer()
						
						Label {
							Text(article.source)
						} icon: {
							Image(systemName: "newspaper.fill")
						}
					}
					.font(.system(.footnote, design: .rounded, weight: .medium))
					.lineLimit(2)
					
					ScrollView(.vertical) {
						Text(article.desc)
					}
					.frame(height: 80)
					.font(.system(.body, design: .default, weight: .regular))
					.padding(.top)
					
				}
				.frame(height: geometry.size.height / 2)
				.padding(.horizontal)
			}
		}
	}
}

#Preview {
	NavigationStack {
		TabView {
			ForEach(ArticleModel.germanArticles) { article in
				ArticleItemListView(article: article)
			}
		}
		.clipShape(RoundedRectangle(cornerRadius: 20))
		.padding()
		.tabViewStyle(.page)
		.indexViewStyle(.page(backgroundDisplayMode: .always))
	}
}
