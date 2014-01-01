#import "WXApi.h"

@implementation WXApi

static NSString *WXAppID = nil;
static NSString *WXAppDescription = nil;

static NSString *const WXAppURL = @"weixin://";
static NSString *const WXAppAPIURL = @"wechat://";
static NSString *const WXAppInstallURLString = @"http://itunes.apple.com/cn/app/id414478124?mt=8";
static NSString *const WXAPIVersion = @"1.4.2";

+ (BOOL)registerApp:(NSString *)appid {
	return [self registerApp:appid withDescription:nil];
}

+ (BOOL)registerApp:(NSString *)appid withDescription:(NSString *)appdesc {
	WXAppID = appid;
	WXAppDescription = appdesc;
	return YES;
}

+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id<WXApiDelegate>)delegate {
	NSData *data = [[UIPasteboard generalPasteboard] dataForPasteboardType:@"content"];
	NSDictionary *dict = [NSPropertyListSerialization propertyListWithData:data options:0 format:0 error:0];
	NSDictionary *info = [dict objectForKey:WXAppID];
	
	NSLog(@"%@", info);

	NSUInteger command = [info[@"command"] integerValue];
	if (command == 2020) {
		SendMessageToWXResp *response = [[SendMessageToWXResp alloc] init];
		response.errCode = [info[@"result"] intValue];
		
		if ([delegate respondsToSelector:@selector(onResp:)]) {
			[delegate onResp:response];
		}
	} else if (command == 1010) {
		ShowMessageFromWXReq *request = [[ShowMessageFromWXReq alloc] init];
		WXMediaMessage *message = [WXMediaMessage message];
		message.title = info[@"title"];
		message.description = info[@"description"];
		message.thumbData = info[@"thumbData"];
		message.mediaObject = [WXMediaObject objectFromInfoDictionary:info];
		request.message = message;
		
		if ([delegate respondsToSelector:@selector(onReq:)]) {
			[delegate onReq:request];
		}
	}
	
	return NO;
}

+ (BOOL)isWXAppInstalled {
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:WXAppURL]];
}

+ (BOOL)isWXAppSupportApi {
	return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:WXAppAPIURL]];;
}

+ (NSString *)getWXAppInstallUrl {
	return WXAppInstallURLString;
}

+ (NSString *)getApiVersion {
	return WXAPIVersion;
}

+ (BOOL)openWXApp {
	return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:WXAppURL]];
}

+ (BOOL)sendReq:(BaseReq*)req {
	NSDictionary *basicInfo = @{
															@"result": @"1",
															@"returnFromApp": @"0",
															@"sdkver": WXAPIVersion
															};
	NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary:basicInfo];
	[info addEntriesFromDictionary:[req infoDictionary]];
	[[UIPasteboard generalPasteboard] setValue:@{WXAppID: [info copy]} forPasteboardType:@"content"];
	
	NSString *URLString = [NSString stringWithFormat:@"%@app/%@/sendreq/?", WXAppURL, WXAppID];
	return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
}

+ (BOOL)sendResp:(BaseResp*)resp {
	return NO;
}

@end