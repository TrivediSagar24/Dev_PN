
#import "AFHTTPSessionManager.h"

@interface AFAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;
typedef void (^APIRequestBlock)(BOOL success, id result, NSError *error);

@end
