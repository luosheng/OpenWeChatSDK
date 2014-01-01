#import "WXApiObject.h"

@interface WXMediaMessage ()

- (NSDictionary *)infoDictionary;

@end

@interface WXMediaObject ()

- (WXMediaType)mediaType;
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
	info[@"objectType"] = @([self.mediaObject mediaType]);
	[info addEntriesFromDictionary:[self.mediaObject infoDictionary]];
	return info;
}

@end


@implementation WXMediaObject

+ (instancetype)object {
	return [[self alloc] init];
}

- (WXMediaType)mediaType {
	return WXMediaTypeNone;
}

- (NSDictionary *)infoDictionary {
	return nil;
}

@end

@implementation WXImageObject

- (WXMediaType)mediaType {
	return WXMediaTypeImage;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"fileData": self.imageData,
					 };
}

@end

@implementation WXMusicObject

- (WXMediaType)mediaType {
	return WXMediaTypeMusic;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"mediaDataUrl": self.musicDataUrl,
					 @"mediaUrl": self.musicUrl,
					 };
}

@end

@implementation WXVideoObject

- (WXMediaType)mediaType {
	return WXMediaTypeVideo;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"mediaUrl": self.videoUrl,
					 };
}

@end

@implementation WXWebpageObject

- (WXMediaType)mediaType {
	return WXMediaTypeWeb;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"mediaUrl": self.webpageUrl,
					 };
}

@end

@implementation WXAppExtendObject

- (WXMediaType)mediaType {
	return WXMediaTypeApp;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"extInfo": self.extInfo,
					 @"mediaUrl": self.url,
					 @"fileData": self.fileData,
					 };
}

@end

@implementation WXEmoticonObject

- (WXMediaType)mediaType {
	return WXMediaTypeEmotion;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"fileData": self.emoticonData,
					 };
}

@end

@implementation WXFileObject

- (WXMediaType)mediaType {
	return WXMediaTypeFile;
}

- (NSDictionary *)infoDictionary {
	return @{
					 @"fileExt": self.fileExtension,
					 @"fileData": self.fileData,
					 @"objectType": @6,
					 };
}

@end
