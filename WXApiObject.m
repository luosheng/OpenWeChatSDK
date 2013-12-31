#import "WXApiObject.h"

@implementation BaseReq

- (NSDictionary *)infoDictionary {
	return nil;
}

@end

@implementation BaseResp
@end

@implementation SendMessageToWXReq

- (NSDictionary *)infoDictionary {
	return @{
					 @"command": @1020,
					 @"title": self.text,
					 @"scene": @(self.scene),
					 };
}

@end

@implementation SendMessageToWXResp
@end

@implementation GetMessageFromWXReq
@end

@implementation GetMessageFromWXResp
@end

@implementation ShowMessageFromWXReq
@end

@implementation ShowMessageFromWXResp
@end

@implementation LaunchFromWXReq
@end

@implementation WXMediaMessage
@end

@implementation WXImageObject
@end

@implementation WXMusicObject
@end

@implementation WXVideoObject
@end

@implementation WXWebpageObject
@end

@implementation WXAppExtendObject
@end

@implementation WXEmoticonObject
@end

@implementation WXFileObject
@end
