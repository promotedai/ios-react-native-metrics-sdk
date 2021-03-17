import Foundation
import PromotedAIMetricsSDK

/**
 `MetricsLogger` methods packaged as a module. Has all the same methods
 as `MetricsLogger`, but delegates those methods to an instance of the
 logger.
 */
@objc(PromotedLoggerModule)
public class PromotedLoggerModule: NSObject {
  
  public typealias ReactNativeDictionary = [String: Any]
  
  /// List of keys for content IDs as used in
  /// `Content(properties:contentIDKeys:insertionIDKeys:)`.
  private let contentIDKeys: [String]

  /// List of keys for insertion IDs as used in
  /// `Content(properties:contentIDKeys:insertionIDKeys:)`.
  private let insertionIDKeys: [String]
  
  private let service: MetricsLoggerService

  private var metricsLogger: MetricsLogger {
    return service.metricsLogger
  }
  
  public init(metricsLoggerService: MetricsLoggerService,
              contentIDKeys: [String],
              insertionIDKeys: [String]) {
    self.service = metricsLoggerService
    self.contentIDKeys = contentIDKeys
    self.insertionIDKeys = insertionIDKeys
  }

  @objc public var methodQueue: DispatchQueue {
    return DispatchQueue.main
  }
  
  @objc public static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  private func contentFor(_ dictionary: ReactNativeDictionary?) -> Content {
    return Content(properties: dictionary,
                   contentIDKeys: contentIDKeys,
                   insertionIDKeys: insertionIDKeys)
  }

  // MARK: - Starting new sessions
  @objc(startSessionAndLogUserWithID:)
  public func startSessionAndLogUser(userID: String) {
    self.metricsLogger.startSessionAndLogUser(userID: userID)
  }
  
  @objc public func startSessionAndLogSignedOutUser() {
    self.metricsLogger.startSessionAndLogSignedOutUser()
  }
  
  // MARK: - Impressions
  @objc public func logImpression(content: ReactNativeDictionary?) {
    self.metricsLogger.logImpression(content: contentFor(content))
  }
  
  // MARK: - Clicks
  @objc(logClickToLikeContent:didLike:)
  public func logClickToLike(content: ReactNativeDictionary?, didLike: Bool) {
    self.metricsLogger.logClickToLike(content: contentFor(content), didLike: didLike)
  }
  
  @objc(logClickToShowScreenName:)
  public func logClickToShow(screenName: String) {
    self.metricsLogger.logClickToShow(screenName: screenName)
  }
  
  @objc(logClickToShowScreenName:forContent:)
  public func logClickToShow(screenName: String,
                             forContent content: ReactNativeDictionary?) {
    self.metricsLogger.logClickToShow(screenName: screenName,
                                      forContent: contentFor(content))
  }
  
  @objc public func logClickToSignUp(userID: String) {
    self.metricsLogger.logClickToSignUp(userID: userID)
  }
    
  @objc(logClickToPurchaseItem:)
  public func logClickToPurchase(item: ReactNativeDictionary?) {
    let item = Item(properties: item,
                    contentIDKeys: contentIDKeys,
                    insertionIDKeys: insertionIDKeys)
    self.metricsLogger.logClickToPurchase(item: item)
  }
  
  @objc public func logClick(actionName: String) {
    self.metricsLogger.logClick(actionName: actionName)
  }
  
  @objc public func logClick(actionName: String, content: ReactNativeDictionary?) {
    self.metricsLogger.logClick(actionName: actionName, content: contentFor(content))
  }
  
  // MARK: - Views
  @objc public func logView(screenName: String) {
    self.metricsLogger.logView(screenName: screenName)
  }
  
  @objc public func logView(screenName: String, useCase: UseCase) {
    self.metricsLogger.logView(screenName: screenName, useCase: useCase)
  }
  
  // MARK: - ImpressionLogger
  @objc public func collectionViewDidLoad(items: [ReactNativeDictionary],
                                          collectionViewName: String) {
    print("***** \(collectionViewName): \(items)")
  }

  @objc public func collectionViewDidChange(visibleRows: [Int],
                                            collectionViewName: String) {
    print("***** \(collectionViewName): \(visibleRows)")
  }
  
  // MARK: - ScrollTracker
  
}
