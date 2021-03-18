#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PromotedLoggerModule, NSObject)

#pragma mark - Starting new sessions
RCT_EXTERN_METHOD(startSessionAndLogUserWithID:(NSString *)userID)

RCT_EXTERN_METHOD(startSessionAndLogSignedOutUser)

#pragma mark - Impressions
// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logImpressionWithContent:(nullable NSDictionary *)content)

#pragma mark - Clicks
// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickToLikeContent:(nullable NSDictionary *)content didLike:(BOOL)didLike)

RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName)

// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName forContent:(nullable NSDictionary *)content)

RCT_EXTERN_METHOD(logClickToSignUpWithUserID:(NSString *)userID)

// item is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickToPurchaseItem:(nullable NSDictionary *)item)

RCT_EXTERN_METHOD(logClickWithActionName:(NSString *)action)

// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickWithActionName:(NSString *)action content:(nullable NSDictionary *)properties)

#pragma mark - Views
RCT_EXTERN_METHOD(logViewWithScreenName:(NSString *)screenName)

#pragma mark - ImpressionLogger
// items is NSArray<NSArray<NSDictionary<String, id>>>
RCT_EXTERN_METHOD(collectionViewDidLoad:(NSArray *)items collectionViewName:(NSString *)collectionViewName)

// visibleIndexes is NSArray<NSArray<NSNumber>>
RCT_EXTERN_METHOD(collectionViewDidChange:(NSArray *)visibleIndexes collectionViewName:(NSString *)collectionViewName)

RCT_EXTERN_METHOD(collectionViewDidUnmount:(NSString *)name)

#pragma mark - ScrollTracker

/// Call this method when a scroll view you wish to track has loaded its
/// contents.
///
/// @param sectionedContent (NSArray<NSArray<NSDictionary<String, id>>>)
///        Array of sections for the data: [[item0, item1], [item2, ...]]
/// @param scrollViewName Identifier for scroll view to track.
RCT_EXTERN_METHOD(scrollViewDidLoad:(NSArray *)sectionedContent
                  scrollViewName:(NSString *)scrollViewName)

/// @param frame Relative to screen: `[x, y, width, height]`.
/// @param scrollViewName Identifier for scroll view to track.
RCT_EXTERN_METHOD(scrollViewDidLayout:(NSArray<NSNumber *> *)frame
                  scrollViewName:(NSString *)scrollViewName)

/// Call this method when the scroll view scrolls.
///
/// @param frame Relative to contents: `[x, y, width, height]`.
///        For a `NativeScrollEvent`, this corresponds to
///        `[contentOffset.x, contentOffset.y, layoutMeasurement.width,
///        layoutMeasurement.height]`.
/// @param scrollViewName Identifier for scroll view to track.
RCT_EXTERN_METHOD(scrollViewDidScrollTo:(NSArray<NSNumber *> *)viewport
                  scrollViewName:(NSString *)scrollViewName)

/// Call this method to indicate that a content view within the scroll view
/// has updated its position. At minimum should be invoked with `onLayout` of
/// the content view.
///
/// @param frame Relative to screen: `[x, y, width, height]`.
/// @param content (`NSDictionary<String, id>`) Represents a piece of content
///        (item or partner) to log.
/// @param scrollViewName Identifier for scroll view to track.
RCT_EXTERN_METHOD(scrollViewContentDidUpdateFrame:(NSArray<NSNumber *> *)frame
                  content:(nullable NSDictionary<NSString *, id> *)content
                  scrollViewName:(NSString *)scrollViewName)

///
/// @param scrollViewName Identifier for scroll view to track.
RCT_EXTERN_METHOD(scrollViewDidUnmount:(NSString *)scrollViewName)

@end
