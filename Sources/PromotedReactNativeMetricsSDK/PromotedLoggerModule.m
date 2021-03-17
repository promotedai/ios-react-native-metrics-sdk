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

@end
