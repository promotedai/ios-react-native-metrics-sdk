import Foundation
import PromotedAIMetricsSDK

/**
 `MetricsLogger` methods packaged as a module. Has all the same methods
 as `MetricsLogger`, but delegates those methods to an instance of the
 logger.
 */
@objc(PromotedLoggerModule)
public class PromotedLoggerModule: NSObject, InternalLogger {
  
  /// List of keys for item IDs as used in
  /// `Item(properties:itemIDKeys:insertionIDKeys:)`.
  private let itemIDKeys: [String]

  /// List of keys for insertion IDs as used in
  /// `Item(properties:itemIDKeys:insertionIDKeys:)`.
  private let insertionIDKeys: [String]
  
  private let service: MetricsLoggerService

  private var metricsLogger: MetricsLogger {
    return service.metricsLogger
  }
  
  public init(metricsLoggerService: MetricsLoggerService,
              itemIDKeys: [String],
              insertionIDKeys: [String]) {
    self.service = metricsLoggerService
    self.itemIDKeys = itemIDKeys
    self.insertionIDKeys = insertionIDKeys
  }

  @objc public var methodQueue: DispatchQueue {
    return DispatchQueue.main
  }
  
  @objc public static func requiresMainQueueSetup() -> Bool {
    return true
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
  /// Logs impression of item with given ID. **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc func logImpression(itemID: String) {
    logImpression(item: Item(itemID: itemID))
  }
  
  @objc public func logImpression(item: Item) {
    self.metricsLogger.logImpression(item: item)
  }
  
  // MARK: - Clicks
  /// Logs like for item with given ID. **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc(logClickToLikeItemID:didLike:)
  public func logClickToLike(itemID: String, didLike: Bool) {
    logClickToLike(item: Item(itemID: itemID), didLike: didLike)
  }
  
  public func logClickToLike(item: Item, didLike: Bool) {
    self.metricsLogger.logClickToLike(item: item, didLike: didLike)
  }
  
  public func logClickToShow(viewController: ViewControllerType) {
    self.metricsLogger.logClickToShow(viewController: viewController)
  }
  
  /// Logs click to show a view controller for item with given ID.
  /// **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc(logClickToShowViewController:forItemID:)
  public func logClickToShow(viewController: ViewControllerType,
                             forItemID itemID: String) {
    logClickToShow(viewController: viewController,
                   forItem: Item(itemID: itemID))
  }
  
  public func logClickToShow(viewController: ViewControllerType,
                             forItem item: Item) {
    self.metricsLogger.logClickToShow(viewController: viewController,
                                      forItem: item)
  }
  
  public func logClickToShow(screenName: String) {
    self.metricsLogger.logClickToShow(screenName: screenName)
  }
  
  /// Logs click to show a screen for item with given ID.
  /// **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc(logClickToShowScreenName:forItemID:)
  public func logClickToShow(screenName: String, forItemID itemID: String) {
    logClickToShow(screenName: screenName, forItem: Item(itemID: itemID))
  }
  
  public func logClickToShow(screenName: String, forItem item: Item) {
    self.metricsLogger.logClickToShow(screenName: screenName, forItem: item)
  }
  
  public func logClickToSignUp(userID: String) {
    self.metricsLogger.logClickToSignUp(userID: userID)
  }
  
  @objc(logClickToPurchaseItemID:)
  public func logClickToPurchase(itemID: String) {
    logClickToPurchase(item: Item(itemID: itemID))
  }
  
  public func logClickToPurchase(item: Item) {
    self.metricsLogger.logClickToPurchase(item: item)
  }
  
  public func logClick(actionName: String) {
    self.metricsLogger.logClick(actionName: actionName)
  }

  /// **React Native-only**
  @objc public func logClick(actionName: String, itemID: String) {
    logClick(actionName: actionName, item: Item(itemID: itemID))
  }
  
  public func logClick(actionName: String, item: Item) {
    self.metricsLogger.logClick(actionName: actionName, item: item)
  }
  
  /// Logs a click for the given action and properties. If `properties`
  /// represents a food item, then also logs data about the item.
  /// **React Native-only**
  @objc public func logClick(actionName: String, properties: [String: Any]?) {
    let item = Item(properties: properties,
                    itemIDKeys: itemIDKeys,
                    insertionIDKeys: insertionIDKeys)
    self.metricsLogger.logClick(actionName: actionName, item: item)
  }
  
  // MARK: - Views
  public func logView(viewController: ViewControllerType) {
    self.metricsLogger.logView(viewController: viewController)
  }
  
  public func logView(viewController: ViewControllerType,
                      useCase: UseCase) {
    self.metricsLogger.logView(viewController: viewController,
                               useCase: useCase)
  }
  
  public func logView(screenName: String) {
    self.metricsLogger.logView(screenName: screenName)
  }
  
  public func logView(screenName: String, useCase: UseCase) {
    self.metricsLogger.logView(screenName: screenName, useCase: useCase)
  }
}
