import Foundation
import PromotedAIMetricsSDK

// MARK: -
/**
 `MetricsLogger` methods packaged as a module. Has all the same methods
 as `MetricsLogger`, but delegates those methods to an instance of the
 logger.
 */
@objc(PromotedLoggerModule)
public class PromotedLoggerModule: NSObject {
  
  public static let defaultNameKeys = ["name"]
  public static let defaultContentIDKeys = ["content_id", "contentId", "_id"]
  public static let defaultInsertionIDKeys = ["insertion_id", "insertionId"]
  
  public typealias ReactNativeDictionary = [String: Any]
  
  /// List of keys for content name as used in
  /// `Content(properties:contentIDKeys:insertionIDKeys:)`.
  private let nameKeys: [String]
  
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
  
  private var nameToImpressionLogger: [String: ImpressionLogger]
  private var nameToScrollTracker: [String: ScrollTracker]
  
  public init(metricsLoggerService: MetricsLoggerService,
              nameKeys: [String]? = defaultNameKeys,
              contentIDKeys: [String]? = defaultContentIDKeys,
              insertionIDKeys: [String]? = defaultInsertionIDKeys) {
    self.service = metricsLoggerService
    self.nameKeys = nameKeys!
    self.contentIDKeys = contentIDKeys!
    self.insertionIDKeys = insertionIDKeys!
    self.nameToImpressionLogger = [:]
    self.nameToScrollTracker = [:]
  }

  @objc public var methodQueue: DispatchQueue {
    return DispatchQueue.main
  }
  
  @objc public static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  private func contentFor(_ dictionary: ReactNativeDictionary?) -> Content {
    return Content(properties: dictionary,
                   nameKeys: nameKeys,
                   contentIDKeys: contentIDKeys,
                   insertionIDKeys: insertionIDKeys)
  }
  
  private func sectionedContentFor(_ content: [[ReactNativeDictionary]])
      -> [[Content]] {
    let convertedContent = content.map { section -> [Content] in
      section.map { dict -> Content in contentFor(dict) }
    }
    return convertedContent
  }
}

public extension PromotedLoggerModule {
  // MARK: - Starting new sessions
  @objc(startSessionAndLogUserWithID:)
  func startSessionAndLogUser(userID: String) {
    self.metricsLogger.startSessionAndLogUser(userID: userID)
  }
  
  @objc func startSessionAndLogSignedOutUser() {
    self.metricsLogger.startSessionAndLogSignedOutUser()
  }
  
  // MARK: - Impressions
  @objc func logImpression(content: ReactNativeDictionary?) {
    self.metricsLogger.logImpression(content: contentFor(content))
  }
  
  // MARK: - Clicks
  @objc(logClickToLikeContent:didLike:)
  func logClickToLike(content: ReactNativeDictionary?, didLike: Bool) {
    self.metricsLogger.logClickToLike(content: contentFor(content), didLike: didLike)
  }
  
  @objc(logClickToShowScreenName:)
  func logClickToShow(screenName: String) {
    self.metricsLogger.logClickToShow(screenName: screenName)
  }
  
  @objc(logClickToShowScreenName:forContent:)
  func logClickToShow(screenName: String,
                             forContent content: ReactNativeDictionary?) {
    self.metricsLogger.logClickToShow(screenName: screenName,
                                      forContent: contentFor(content))
  }
  
  @objc func logClickToSignUp(userID: String) {
    self.metricsLogger.logClickToSignUp(userID: userID)
  }
    
  @objc(logClickToPurchaseItem:)
  func logClickToPurchase(item: ReactNativeDictionary?) {
    let item = Item(properties: item,
                    nameKeys: nameKeys,
                    contentIDKeys: contentIDKeys,
                    insertionIDKeys: insertionIDKeys)
    self.metricsLogger.logClickToPurchase(item: item)
  }
  
  @objc func logClick(actionName: String) {
    self.metricsLogger.logClick(actionName: actionName)
  }
  
  @objc func logClick(actionName: String, content: ReactNativeDictionary?) {
    self.metricsLogger.logClick(actionName: actionName, content: contentFor(content))
  }
  
  // MARK: - Views
  @objc func logView(screenName: String) {
    self.metricsLogger.logView(screenName: screenName)
  }
  
  @objc func logView(screenName: String, useCase: UseCase) {
    self.metricsLogger.logView(screenName: screenName, useCase: useCase)
  }
}

// MARK: - ImpressionLogger
public extension PromotedLoggerModule {
  @objc(collectionViewDidLoad:collectionViewName:)
  func collectionViewDidLoad(sectionedContent: [[ReactNativeDictionary]],
                             collectionViewName: String) {
    let convertedContent = sectionedContentFor(sectionedContent)
    let logger = service.impressionLogger(sectionedContent: convertedContent)
    nameToImpressionLogger[collectionViewName] = logger
  }

  @objc(collectionViewDidChange:collectionViewName:)
  func collectionViewDidChange(visibleIndexes: [[Int]], collectionViewName: String) {
    guard let logger = nameToImpressionLogger[collectionViewName] else { return }
    let paths = visibleIndexes.map { i -> IndexPath in IndexPath(indexes: i) }
    logger.collectionViewDidChangeVisibleContent(atIndexes: paths)
  }
  
  @objc(collectionViewDidUnmount:)
  func collectionViewDidUnmount(name: String) {
    nameToImpressionLogger.removeValue(forKey: name)
  }
}

// MARK: - ScrollTracker
public extension PromotedLoggerModule {
  @objc(scrollViewDidLoad:scrollViewName:)
  func scrollViewDidLoad(sectionedContent: [[ReactNativeDictionary]],
                         scrollViewName: String) {
    var tracker: ScrollTracker? = nameToScrollTracker[scrollViewName]
    if tracker == nil {
      tracker = service.scrollTracker()
      nameToScrollTracker[scrollViewName] = tracker
      print("***** created tracker named \(scrollViewName)")
    }
    let existingContent = tracker!.sectionedContent
    if !isReactNativeContent(sectionedContent, equalTo: existingContent) {
      let convertedContent = sectionedContentFor(sectionedContent)
      tracker!.sectionedContent = convertedContent
      print("***** setting tracker named \(scrollViewName) content \(convertedContent)")
    } else {
      print("***** re-using content for tracker named \(scrollViewName)")
    }
  }
  
  @objc(scrollViewDidLayout:scrollViewName:)
  func scrollViewDidLayout(frame: [NSNumber], scrollViewName: String) {
    guard let tracker = nameToScrollTracker[scrollViewName] else { return }
    print("***** tracker named \(scrollViewName) origin \(frame)")
    tracker.offset = CGPoint(x: frame[0].doubleValue, y: frame[1].doubleValue)
  }
  
  private func isReactNativeContent(_ reactNativeContent: [[ReactNativeDictionary]],
                                    equalTo sectionedContent: [[Content]]) -> Bool {
    if reactNativeContent.count != sectionedContent.count { return false }
    for (i, reactNativeSection) in reactNativeContent.enumerated() {
      let section = sectionedContent[i]
      if reactNativeSection.count != section.count { return false }
      for (j, reactNativeItem) in reactNativeSection.enumerated() {
        let item = section[j]
        let reactNativeID = reactNativeItem.firstValueFromKeysInArray(contentIDKeys)
        if reactNativeID != item.contentID {
          return false
        }
      }
    }
    return true
  }
  
  @objc(scrollViewDidScrollTo:scrollViewName:)
  func scrollViewDidScroll(toViewport viewport: [NSNumber], scrollViewName: String) {
    guard let tracker = nameToScrollTracker[scrollViewName] else { return }
    let viewportRect = CGRect(array: viewport)
    tracker.viewport = viewportRect
    print("***** tracker named \(scrollViewName) scrolled to \(viewportRect)")
  }
  
  @objc(scrollViewContentDidUpdateFrame:content:scrollViewName:)
  func scrollViewContentDidUpdate(frame: [NSNumber],
                                  content contentDict: ReactNativeDictionary,
                                  scrollViewName: String) {
    guard let tracker = nameToScrollTracker[scrollViewName] else { return }
    let frameRect = CGRect(array: frame)
    let content = contentFor(contentDict)
    tracker.setFrame(frameRect, forContent: content)
    print("***** tracker named \(scrollViewName) item \(content.name!) frame \(frameRect)")
  }
  
  @objc(scrollViewDidUnmount:)
  func scrollViewDidUnmount(name: String) {
    nameToScrollTracker.removeValue(forKey: name)
  }
}

extension CGRect {
  init(array: [NSNumber]) {
    assert(array.count == 4)
    self.init(x: array[0].doubleValue, y: array[1].doubleValue,
              width: array[2].doubleValue, height: array[3].doubleValue)
  }
}
