#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(PromotedLogger, NSObject)

RCT_EXTERN_METHOD(startSessionAndLogUserWithID:(NSString *)userID)

RCT_EXTERN_METHOD(startSessionAndLogSignedOutUser)

RCT_EXTERN_METHOD(logImpressionWithItemID:(NSString *)itemID)

RCT_EXTERN_METHOD(logClickToLikeItemID:(NSString *)itemID didLike:(BOOL)didLike)

RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName)

RCT_EXTERN_METHOD(logClickToShowScreenName:(NSString *)screenName forItemID:(NSString *)itemID)

RCT_EXTERN_METHOD(logClickToSignUpWithUserID:(NSString *)userID)

RCT_EXTERN_METHOD(logClickToPurchaseItemID:(NSString *)itemID)

RCT_EXTERN_METHOD(logClickWithAction:(NSString *)action properties:(nullable NSDictionary<NSString *, id> *)properties)

RCT_EXTERN_METHOD(logViewWithScreenName:(NSString *)screenName)

@end
