import Foundation
import PromotedAIMetricsSDK

@objc(PromotedLogger)
public class PromotedLoggerReactNativeModule: NSObject, InternalLogger {
  
  private var metricsLogger: MetricsLogger {
    return MetricsLoggerService.sharedService.metricsLogger
  }

  // MARK: - Starting new sessions
  @objc(startSessionAndLogUserWithID:)
  public func startSessionAndLogUser(userID: String) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.startSessionAndLogUser(userID: userID)
    })
  }
  
  @objc public func startSessionAndLogSignedOutUser() {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.startSessionAndLogSignedOutUser()
    })
  }
  
  // MARK: - Impressions
  /// Logs impression of item with given ID. **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc func logImpression(itemID: String) {
    logImpression(item: Item(itemID: itemID))
  }
  
  @objc public func logImpression(item: Item) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logImpression(item: item)
    })
  }
  
  // MARK: - Clicks
  /// Logs like for item with given ID. **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc(logClickToLikeItemID:didLike:)
  public func logClickToLike(itemID: String, didLike: Bool) {
    logClickToLike(item: Item(itemID: itemID), didLike: didLike)
  }
  
  public func logClickToLike(item: Item, didLike: Bool) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToLike(item: item, didLike: didLike)
    })
  }
  
  public func logClickToShow(viewController: ViewControllerType) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToShow(viewController: viewController)
    })
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
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToShow(viewController: viewController,
                                        forItem: item)
    })
  }
  
  public func logClickToShow(screenName: String) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToShow(screenName: screenName)
    })
  }
  
  /// Logs click to show a screen for item with given ID.
  /// **React Native-only.**
  // TODO(yu-hong): Track more data for conversions.
  @objc(logClickToShowScreenName:forItemID:)
  public func logClickToShow(screenName: String, forItemID itemID: String) {
    logClickToShow(screenName: screenName, forItem: Item(itemID: itemID))
  }
  
  public func logClickToShow(screenName: String, forItem item: Item) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToShow(screenName: screenName, forItem: item)
    })
  }
  
  public func logClickToSignUp(userID: String) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToSignUp(userID: userID)
    })
  }
  
  @objc(logClickToPurchaseItemID:)
  public func logClickToPurchase(itemID: String) {
    logClickToPurchase(item: Item(itemID: itemID))
  }
  
  public func logClickToPurchase(item: Item) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logClickToPurchase(item: item)
    })
  }
  
  /// **React Native-only**
  @objc public func logClick(action: String, properties: [String: AnyObject]?) {
    print("************************************")
    print("**** \(action)")
    if let properties = properties {
      for (k, v) in properties {
        print("**** \(k): \(v) \(String(describing: type(of: v)))")
      }
    } else {
      print("**** properties are nil")
    }
  }
  
  // MARK: - Views
  public func logView(viewController: ViewControllerType) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logView(viewController: viewController)
    })
  }
  
  public func logView(viewController: ViewControllerType,
                      useCase: UseCase) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logView(viewController: viewController,
                                 useCase: useCase)
    })
  }
  
  public func logView(screenName: String) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logView(screenName: screenName)
    })
  }
  
  public func logView(screenName: String, useCase: UseCase) {
    DispatchQueue.main.async(execute: {
      self.metricsLogger.logView(screenName: screenName, useCase: useCase)
    })
  }
}
