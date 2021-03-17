#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PromotedLoggerModule, NSObject)

#pragma mark - Starting new sessions
RCT_EXTERN_METHOD(startSessionAndLogUserWithID:(NSString *)userID)

RCT_EXTERN_METHOD(startSessionAndLogSignedOutUser)

#pragma mark - Impressions
RCT_EXTERN_METHOD(logImpressionWithContent:(nullable NSDictionary *)content)

#pragma mark - Clicks
RCT_EXTERN_METHOD(logClickToLikeContent:(nullable NSDictionary *)content didLike:(BOOL)didLike)

RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName)

RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName forContent:(nullable NSDictionary *)content)

RCT_EXTERN_METHOD(logClickToSignUpWithUserID:(NSString *)userID)

RCT_EXTERN_METHOD(logClickToPurchaseItem:(nullable NSDictionary *)item)

RCT_EXTERN_METHOD(logClickWithActionName:(NSString *)action)

RCT_EXTERN_METHOD(logClickWithActionName:(NSString *)action content:(nullable NSDictionary *)properties)

#pragma mark - Views
RCT_EXTERN_METHOD(logViewWithScreenName:(NSString *)screenName)

#pragma mark - ImpressionLogger
RCT_EXTERN_METHOD(collectionViewDidLoadWithItems:(NSArray<NSDictionary *> *)items collectionViewName:(NSString *)collectionViewName)

RCT_EXTERN_METHOD(collectionViewDidChangeWithVisibleRows:(NSArray<NSNumber *> *)visibleRows collectionViewName:(NSString *)collectionViewName)

#pragma mark - ScrollTracker

@end
