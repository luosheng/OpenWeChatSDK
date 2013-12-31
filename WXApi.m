#import "WXApi.h"

@implementation WXApi

static NSString *WXAppID = nil;
static NSString *WXAppDescription = nil;

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
	return NO;
}

+ (BOOL)isWXAppSupportApi {
	return NO;
}

+ (NSString *)getWXAppInstallUrl {
	return nil;
}

+ (NSString *)getApiVersion {
	return nil;
}

+ (BOOL)openWXApp {
	return NO;
}

+ (BOOL)sendReq:(BaseReq*)req {
	return NO;
}

+ (BOOL)sendResp:(BaseResp*)resp {
	return NO;
}

@end