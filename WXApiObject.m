#import "WXApiObject.h"

@interface WXMediaMessage ()

- (NSDictionary *)infoDictionary;

@end

@interface WXMediaObject ()

- (NSDictionary *)infoDictionary;

@end

@implementation BaseReq

- (NSDictionary *)infoDictionary {
	return nil;
}

@end

@implementation BaseResp
@end

@implementation SendMessageToWXReq

- (NSDictionary *)infoDictionary {
	NSMutableDictionary *info = [NSMutableDictionary dictionary];
	info[@"scene"] = @(self.scene);
	if (self.bText) {
		info[@"command"] = @1020;
		info[@"title"] = self.text;
	} else {
		info[@"command"] = @1010;
		[info addEntriesFromDictionary:[self.message infoDictionary]];
	}
	return info;
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

+ (instancetype)message {
	return [[self alloc] init];
}

- (void)setThumbImage:(UIImage *)image {
	// TODO: thumb image manipulations
	self.thumbData = UIImageJPEGRepresentation(image, 0.85);
}

- (NSDictionary *)infoDictionary {
	NSMutableDictionary *info = [NSMutableDictionary dictionary];
	if (self.thumbData) info[@"thumbData"] = self.thumbData;
	if (self.title) info[@"title"] = self.title;
	if (self.description) info[@"description"] = self.description;
	[info addEntriesFromDictionary:[self.mediaObject infoDictionary]];
	return info;
}

@end


@implementation WXMediaObject

+ (instancetype)object {
	return [[self alloc] init];
}

- (NSDictionary *)infoDictionary {
	return nil;
}

@end

@implementation WXImageObject

- (NSDictionary *)infoDictionary {
	return @{
					 @"fileData": self.imageData,
					 @"objectType": @2,
					 };
}

@end

@implementation WXMusicObject
@end

@implementation WXVideoObject
@end

@implementation WXWebpageObject

- (NSDictionary *)infoDictionary {
	return @{
					 @"mediaUrl": self.webpageUrl,
					 @"objectType": @5,
					 };
}

@end

@implementation WXAppExtendObject
@end

@implementation WXEmoticonObject
@end

@implementation WXFileObject
@end
