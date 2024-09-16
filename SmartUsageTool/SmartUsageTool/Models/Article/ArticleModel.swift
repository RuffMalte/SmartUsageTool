//
//  ArticleModel.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 16.09.24.
//

import Foundation
import SwiftData

@Model
class ArticleModel: Identifiable {
	var id: UUID
	var source: String
	var author: String
	
	var title: String
	var desc: String
	
	var url: URL
	var urlToImage: URL
		
	init(id: UUID = UUID(), source: String, author: String, title: String, desc: String, url: URL, urlToImage: URL) {
		self.id = id
		self.source = source
		self.author = author
		self.title = title
		self.desc = desc
		self.url = url
		self.urlToImage = urlToImage
	}
}
