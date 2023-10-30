//
//  ViewController.swift
//  HealthMonitor
//
//  Created by Muhammad Shaheer Attiq on 25/09/23.
//


import UIKit
import ResearchKit
import HealthKit

class ViewController: UIViewController {
    
    @IBOutlet weak var consentButton: UIButton! // Connect this outlet to your button in the storyboard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showConsentForm(_ sender: UIButton) {
        // Create the consent document
        let consentDocument = createConsentDocument()
        
        // Create a consent review step with a signature
        let signature = consentDocument.signatures?.first as? ORKConsentSignature
        let consentReviewStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
        consentReviewStep.text = "Review the consent document"
        consentReviewStep.reasonForConsent = "Consent to participate in the study"
        
        // Completion Step
        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
        completionStep.title = "Welcome"
        completionStep.text = "Thank you for joining this study."
        
        // Create an ordered task with the consent review step and completion step
        let task = ORKOrderedTask(identifier: "ConsentTask", steps: [consentReviewStep, completionStep])
        
        // Present the ResearchKit task view controller
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        taskViewController.delegate = self // Set the delegate to handle task events
        present(taskViewController, animated: true, completion: nil)
    }
}

extension ViewController: ORKTaskViewControllerDelegate {
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        if reason == .completed {
            // User completed the consent process
            // You can capture the consent status and signature here
        } else {
            // User canceled or encountered an error
        }
        
        // Dismiss the task view controller
        taskViewController.dismiss(animated: true, completion: nil)
    }
}

//import UIKit
//import ResearchKit
//import HealthKit
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var consentButton: UIButton! // Connect this outlet to your button in the storyboard
//
//    // Declare the HealthKit store
//    let healthStore = HKHealthStore()
//    
//    // Declare the stepCount variable at the class level
//    let stepCount = HKObjectType.quantityType(forIdentifier: .stepCount)!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        // Request HealthKit authorization when needed
//        requestHealthKitAuthorization()
//    }
//
//    @IBAction func showConsentForm(_ sender: UIButton) {
//        // Create the consent document
//        let consentDocument = createConsentDocument()
//
//        // Create a consent review step with a signature
//        let signature = consentDocument.signatures?.first as? ORKConsentSignature
//        let consentReviewStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: signature, in: consentDocument)
//        consentReviewStep.text = "Review the consent document"
//        consentReviewStep.reasonForConsent = "Consent to participate in the study"
//
//        // Completion Step
//        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
//        completionStep.title = "Welcome"
//        completionStep.text = "Thank you for joining this study."
//
//        // Create an ordered task with the consent review step and completion step
//        let task = ORKOrderedTask(identifier: "ConsentTask", steps: [consentReviewStep, completionStep])
//
//        // Present the ResearchKit task view controller
//        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
//        taskViewController.delegate = self // Set the delegate to handle task events
//        present(taskViewController, animated: true, completion: nil)
//    }
//
//    func requestHealthKitAuthorization() {
//        // No need to declare stepCount here since it's now a class-level variable
//
//        healthStore.requestAuthorization(toShare: nil, read: [stepCount]) { (success, error) in
//            if success {
//                // Authorization granted, you can now access step count data
//                // You can start collecting health data here
//
//                // Call the function to fetch step count data
//                self.fetchStepCountData()
//            } else if let error = error {
//                // Handle the error
//                print("HealthKit authorization request error: \(error.localizedDescription)")
//            }
//        }
//    }
//
//    func fetchStepCountData() {
//        let calendar = Calendar.current
//        let now = Date()
//        let startDate = calendar.startOfDay(for: now)
//        let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
//
//        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
//
//        let query = HKSampleQuery(sampleType: stepCount, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, results, error) in
//            if let samples = results as? [HKQuantitySample] {
//                for sample in samples {
//                    let stepCount = sample.quantity.doubleValue(for: HKUnit.count())
//                    print("Step count: \(stepCount)")
//                    // Process and store the data as needed
//                }
//            } else {
//                // Handle the error
//                if let error = error {
//                    print("HealthKit query error: \(error.localizedDescription)")
//                }
//            }
//        }
//
//        healthStore.execute(query)
//    }
//}
//
//extension ViewController: ORKTaskViewControllerDelegate {
//    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
//        if reason == .completed {
//            // User completed the consent process
//            // You can capture the consent status and signature here
//        } else {
//            // User canceled or encountered an error
//        }
//
//        // Dismiss the task view controller
//        taskViewController.dismiss(animated: true, completion: nil)
//    }
//}




