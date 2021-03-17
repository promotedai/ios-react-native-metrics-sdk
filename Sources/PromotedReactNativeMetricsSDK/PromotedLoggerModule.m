#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PromotedLoggerModule, NSObject)

#pragma mark - Starting new sessions
RCT_EXTERN_METHOD(startSessionAndLogUserWithID:(NSString *)userID)

RCT_EXTERN_METHOD(startSessionAndLogSignedOutUser)

#pragma mark - Impressions
RCT_EXTERN_METHOD(logImpressionWithContent:(nullable NSDictionary<NSString *, id> *)content)

#pragma mark - Clicks
// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickToLikeContent:(nullable NSDictionary<NSString *, id> *)content
                  didLike:(BOOL)didLike)

RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName)

// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName
                  forContent:(nullable NSDictionary<NSString *, id> *)content)

RCT_EXTERN_METHOD(logClickToSignUpWithUserID:(NSString *)userID)

// item is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickToPurchaseItem:(nullable NSDictionary<NSString *, id>  *)item)

RCT_EXTERN_METHOD(logClickWithActionName:(NSString *)action)

// content is NSDictionary<NSString, id>
RCT_EXTERN_METHOD(logClickWithActionName:(NSString *)action
                  content:(nullable NSDictionary<NSString *, id> *)properties)

#pragma mark - Views
RCT_EXTERN_METHOD(logViewWithScreenName:(NSString *)screenName)

#pragma mark - ImpressionLogger
// sectionedContent is NSArray<NSArray<NSDictionary<String, id>>>
RCT_EXTERN_METHOD(collectionViewDidLoad:(NSArray *)sectionedContent
                  collectionViewName:(NSString *)collectionViewName)

// visibleIndexes is NSArray<NSArray<NSNumber>>
RCT_EXTERN_METHOD(collectionViewDidChange:(NSArray *)visibleIndexes
                  collectionViewName:(NSString *)collectionViewName)

RCT_EXTERN_METHOD(collectionViewDidUnmount:(NSString *)name)

#pragma mark - ScrollTracker

// sectionedContent is NSArray<NSArray<NSDictionary<String, id>>>
RCT_EXTERN_METHOD(scrollViewDidLoad:(NSArray *)sectionedContent
                  scrollViewName:(NSString *)scrollViewName)

// viewport is NSArray<NSNumber>
RCT_EXTERN_METHOD(scrollViewDidUpdateViewport:(NSArray<NSNumber *> *)viewport
                  scrollViewName:(NSString *)scrollViewName)

// frame is NSArray<NSNumber>
// content is NSDictionary<String, id>
RCT_EXTERN_METHOD(scrollViewContentDidUpdateFrame:(NSArray<NSNumber *> *)frame
                  content:(nullable NSDictionary<NSString *, id> *)content
                  scrollViewName:(NSString *)scrollViewName)

@end
