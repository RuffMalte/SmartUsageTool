//
//  ContactMeView.swift
//  SmartUsageTool
//
//  Created by Malte Ruff on 18.09.24.
//


import SwiftUI
import MessageUI

struct ContactUsView: View {
	@State private var showMailView = false
	@State private var mailResult: Result<MFMailComposeResult, Error>? = nil
	
	var body: some View {
		VStack {
			Button(action: {
				self.showMailView = true
			}) {
				SettingsItemListView(
					icon: "questionmark.bubble.fill",
					iconBackground: .purple,
					title: Localize.feedback
				)
			}
			.disabled(!MailView.canSendMail())
		}
		.sheet(isPresented: $showMailView) {
			MailView(result: self.$mailResult, configure: { mailComposeVC in
				let device = UIDevice.current
				let systemVersion = device.systemVersion
				let deviceModel = device.model
				let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
				
				let messageBody = """
				
				
				---
				App Version: \(appVersion)
				Device: \(deviceModel)
				iOS Version: \(systemVersion)
				"""
				
				mailComposeVC.setToRecipients(["SmartUsageToolFeedback@malteruff.com"])
				mailComposeVC.setSubject("SmartUsageTool Support")
				mailComposeVC.setMessageBody(messageBody, isHTML: false)
			})
		}
	}
}

struct MailView: UIViewControllerRepresentable {
	@Environment(\.presentationMode) var presentation
	@Binding var result: Result<MFMailComposeResult, Error>?
	var configure: ((MFMailComposeViewController) -> Void)?
	
	class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
		@Binding var presentation: PresentationMode
		@Binding var result: Result<MFMailComposeResult, Error>?
		
		init(presentation: Binding<PresentationMode>, result: Binding<Result<MFMailComposeResult, Error>?>) {
			_presentation = presentation
			_result = result
		}
		
		func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
			defer { $presentation.wrappedValue.dismiss() }
			if let error = error {
				self.result = .failure(error)
			} else {
				self.result = .success(result)
			}
		}
	}
	
	func makeCoordinator() -> Coordinator {
		return Coordinator(presentation: presentation, result: $result)
	}
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
		let vc = MFMailComposeViewController()
		vc.mailComposeDelegate = context.coordinator
		configure?(vc)
		return vc
	}
	
	func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {}
	
	static func canSendMail() -> Bool {
		return MFMailComposeViewController.canSendMail()
	}
}


#Preview {
    ContactUsView()
}
