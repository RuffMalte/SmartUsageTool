//
//  GermanArticles.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 16.09.24.
//

import Foundation

extension ArticleModel {
	static let germanArticles: [ArticleModel] = [
		ArticleModel(
			source: "Verbraucherzentrale",
			author: "Verbraucherzentrale",
			title: "Strom sparen im Haushalt: Einfache Tipps",
			desc: "Praktische Ratschläge zur Reduzierung des Stromverbrauchs im Haushalt, von der Küche bis zum Homeoffice.",
			url: URL(string: "https://www.verbraucherzentrale.de/wissen/energie/strom-sparen/strom-sparen-im-haushalt-einfache-tipps-10734")!,
			urlToImage: URL(string: "https://www.verbraucherzentrale.de/sites/default/files/styles/article_full_image_desktop/public/2023-08/piggy-bank-4757810_1280.png?itok=F1z2ukC4")!
		),
		
		ArticleModel(
			source: "powernewz",
			author: "powernewz Redaktion",
			title: "18 Tipps zum Energiesparen im Haushalt",
			desc: "Umfassende Liste von Energiespartipps für verschiedene Bereiche des Haushalts, vom Bad bis zur Heizung.",
			url: URL(string: "https://www.powernewz.ch/rubriken/energie-sparen/tipps-energiesparen-im-haushalt/")!,
			urlToImage: URL(string: "https://www.powernewz.ch/wp-content/uploads/2020/03/powernewz_Energiesparen_Kueche-1024x683.jpg")!
		),
		
		ArticleModel(
			source: "GASAG",
			author: "GASAG",
			title: "30 Energiespartipps für den Haushalt",
			desc: "Praktische Tipps zum Energiesparen in verschiedenen Bereichen des Haushalts, vom Waschen bis zum Heizen.",
			url: URL(string: "https://www.gasag.de/magazin/energiesparen/energiespartipps/")!,
			urlToImage: URL(string: "https://www.gasag.de/assets/dokumente/magazin/erneuerbare-energien/energiespartipps-haushalt-erw_hero_lg.webp")!
		),
		
		ArticleModel(
			source: "WWF Deutschland",
			author: "WWF",
			title: "Strom sparen im Haushalt",
			desc: "Tipps zum Energiesparen in der Küche, bei Großgeräten und im Alltag, mit Fokus auf Umweltschutz.",
			url: URL(string: "https://www.wwf.de/aktiv-werden/tipps-fuer-den-alltag/energie-sparen-und-ressourcen-schonen/strom-sparen-im-haushalt")!,
			urlToImage: URL(string: "https://www.wwf.de/fileadmin/_processed_/0/c/csm_energie-sparen-kochen-topf-deckel-1224249122-c-nerudol-istock-gettyimagesplus_42d9234031.jpg")!
		),
		
		ArticleModel(
			source: "Vattenfall",
			author: "Vattenfall",
			title: "Energiesparen im Haushalt: 23 effektive Spartipps",
			desc: "Umfassende Sammlung von Energiespartipps für verschiedene Bereiche des Haushalts, einschließlich Wohnzimmer und Büro.",
			url: URL(string: "https://www.vattenfall.de/infowelt-energie/energie-sparen/energiespartipps-fuer-den-haushalt")!,
			urlToImage: URL(string: "https://assets.vattenfall.de/binaries/content/gallery/commercialweb/privatkunden/jumbotron/infowelt-energie/vattenfall-gluehlampe-frau.jpg/vattenfall-gluehlampe-frau.jpg/cascata%3AjumboMD")!
		)
	]
	
}
