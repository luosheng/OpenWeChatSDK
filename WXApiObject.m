#import "WXApiObject.h"

static NSString *const WXMediaObjectFileDataKey = @"fileData";
static NSString *const WXMediaObjectMediaUrlKey = @"mediaUrl";
static NSString *const WXMediaObjectMediaDataUrlKey = @"mediaDataUrl";
static NSString *const WXMediaObjectMediaLowBandUrlaKey = @"mediaLowBandUrl";
static NSString *const WXMediaObjectMediaLowBandDataUrlKey = @"mediaLowBandDataUrl";
static NSString *const WXMediaObjectExtInfoKey = @"extInfo";
static NSString *const WXMediaObjectFileExtKey = @"fileExt";

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

+ (instancetype)objectFromInfoDictionary:(NSDictionary *)info {
	NSDictionary *mediaObjectMapping =
	@{
		@(WXMediaTypeNone): [self class],
		@(WXMediaTypeImage): [WXImageObject class],
		@(WXMediaTypeMusic): [WXMusicObject class],
		@(WXMediaTypeVideo): [WXVideoObject class],
		@(WXMediaTypeWeb): [WXWebpageObject class],
		@(WXMediaTypeFile): [WXFileObject class],
		@(WXMediaTypeApp): [WXAppExtendObject class],
		@(WXMediaTypeEmotion): [WXEmoticonObject class],
		};
	Class cls = mediaObjectMapping[@([info[@"objectType"] integerValue])];
	if (cls) {
		WXMediaObject *object = [[cls alloc] initWithInfoDictionary:info];
		return object;
	}
	return nil;
}

- (id)initWithInfoDictionary:(NSDictionary *)info {
	return [super init];
}

- (WXMediaType)mediaType {
	return WXMediaTypeNone;
}

- (NSDictionary *)infoDictionary {
	return nil;
}

@end

@implementation WXImageObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_imageData = info[WXMediaObjectFileDataKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeImage;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectFileDataKey: self.imageData,
					 };
}

@end

@implementation WXMusicObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_musicUrl = info[WXMediaObjectMediaUrlKey];
		_musicDataUrl = info[WXMediaObjectMediaDataUrlKey];
		_musicLowBandUrl = info[WXMediaObjectMediaLowBandUrlaKey];
		_musicLowBandDataUrl = info[WXMediaObjectMediaLowBandDataUrlKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeMusic;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectMediaDataUrlKey: self.musicDataUrl,
					 WXMediaObjectMediaUrlKey: self.musicUrl,
					 };
}

@end

@implementation WXVideoObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_videoUrl = info[WXMediaObjectMediaUrlKey];
		_videoLowBandUrl = info[WXMediaObjectMediaLowBandUrlaKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeVideo;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectMediaUrlKey: self.videoUrl,
					 };
}

@end

@implementation WXWebpageObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_webpageUrl = info[WXMediaObjectMediaUrlKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeWeb;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectMediaUrlKey: self.webpageUrl,
					 };
}

@end

@implementation WXAppExtendObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_extInfo = info[WXMediaObjectExtInfoKey];
		_url = info[WXMediaObjectMediaUrlKey];
		_fileData = info[WXMediaObjectFileDataKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeApp;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectExtInfoKey: self.extInfo,
					 WXMediaObjectMediaUrlKey: self.url,
					 WXMediaObjectFileDataKey: self.fileData,
					 };
}

@end

@implementation WXEmoticonObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_emoticonData = info[WXMediaObjectFileDataKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeEmotion;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectFileDataKey: self.emoticonData,
					 };
}

@end

@implementation WXFileObject

- (id)initWithInfoDictionary:(NSDictionary *)info {
	self = [super initWithInfoDictionary:info];
	if (self) {
		_fileExtension = info[WXMediaObjectFileExtKey];
		_fileData = info[WXMediaObjectFileDataKey];
	}
	return self;
}

- (WXMediaType)mediaType {
	return WXMediaTypeFile;
}

- (NSDictionary *)infoDictionary {
	return @{
					 WXMediaObjectFileExtKey: self.fileExtension,
					 WXMediaObjectFileDataKey: self.fileData,
					 };
}

@end
