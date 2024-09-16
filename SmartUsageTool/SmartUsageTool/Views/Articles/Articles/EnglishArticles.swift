//
//  EnglishArticles.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 16.09.24.
//

import Foundation

extension ArticleModel {
	static let englishArticles: [ArticleModel] = [
		ArticleModel(
			source: "Nature",
			author: "Various",
			title: "Time series of useful energy consumption patterns for heat, cold, mechanical energy, information and communication, and light",
			desc: "This dataset provides comprehensive data on useful energy consumption patterns for heat, cold, mechanical energy, information and communication, and light in high spatial and temporal resolution across different sectors. It aims to support energy system modeling and analysis of future energy scenarios.",
			url: URL(string: "https://www.nature.com/articles/s41597-021-00907-w")!,
			urlToImage: URL(string: "https://media.springernature.com/m685/springer-static/image/art%3A10.1038%2Fs41597-021-00907-w/MediaObjects/41597_2021_907_Fig1_HTML.png")!
		),
		
		ArticleModel(
			source: "ScienceDirect",
			author: "Kaur Ramanpreet, Gabrijelčič Dušan",
			title: "Behavior segmentation of electricity consumption patterns: A cluster analytical approach",
			desc: "This study applies cluster analysis techniques to segment electricity consumption behaviors and patterns. It aims to identify distinct consumer groups to enable more targeted energy management strategies and policies.",
			url: URL(string: "https://www.sciencedirect.com/science/article/pii/S0950705122006153")!,
			urlToImage: URL(string: "https://ars.els-cdn.com/content/image/1-s2.0-S0950705122006153-gr1.jpg")!
		),
		
		ArticleModel(
			source: "MDPI",
			author: "Various",
			title: "Energy-Consumption Pattern-Detecting Technique for Household Appliances for Smart Home Platform",
			desc: "This paper presents a technique for detecting energy consumption patterns of household appliances in smart home environments. The method aims to enable more accurate disaggregation of appliance-level energy use to support energy efficiency efforts.",
			url: URL(string: "https://www.mdpi.com/1996-1073/16/2/824")!,
			urlToImage: URL(string: "https://www.mdpi.com/energies/energies-16-00824/article_deploy/html/images/energies-16-00824-g006.png")!
		),
		
		ArticleModel(
			source: "Energy, Sustainability and Society",
			author: "Dar-Mousa, R.N., Makhamreh, Z.",
			title: "Analysis of the pattern of energy consumptions",
			desc: "This case study analyzes energy consumption patterns in Amman, Jordan to examine their impact on urban environmental sustainability. It investigates spatial and socioeconomic factors influencing electricity use to inform sustainable urban energy policies.",
			url: URL(string: "https://energsustainsoc.biomedcentral.com/articles/10.1186/s13705-019-0197-0")!,
			urlToImage: URL(string: "https://media.springernature.com/lw685/springer-static/image/art%3A10.1186%2Fs13705-019-0197-0/MediaObjects/13705_2019_197_Fig5_HTML.png")!
		)
	]
}
