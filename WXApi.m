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
	return NO;
}

+ (BOOL)sendResp:(BaseResp*)resp {
	return NO;
}

@end