//
//  ConsentDocument.swift
//  HealthMonitor
//
//  Created by Muhammad Shaheer Attiq on 26/09/23.
//
import ResearchKit

import Foundation

func createConsentDocument() -> ORKConsentDocument {
    // Create a new consent document
    let consentDocument = ORKConsentDocument()
    
    // Set the title of the consent document
    consentDocument.title = "Study Consent Form"
    
    // Define the sections of the consent document
    let section1 = ORKConsentSection(type: .overview)
    section1.summary = "Study Overview"
    section1.content = "This study aims to collect health data from participants' Apple Watches to provide valuable insights for healthcare professionals."
    
    let section2 = ORKConsentSection(type: .dataGathering)
    section2.summary = "Data Collection"
    section2.content = "By participating, you agree to share health data including heart rate, steps, distance, sleep, and calories from your Apple Watch."
    
    // Add sections to the consent document
    consentDocument.sections = [section1, section2]
    
    // Define the signatures required
    let signature = ORKConsentSignature(forPersonWithTitle: "Participant", dateFormatString: nil, identifier: "ParticipantSignature")
    
    // Add the signature to the consent document
    consentDocument.signatures = [signature]
    
    return consentDocument
}
