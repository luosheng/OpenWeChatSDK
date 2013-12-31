#import "WXApi.h"

@implementation WXApi

+ (BOOL)registerApp:(NSString *)appid {
	return NO;
}

+ (BOOL)registerApp:(NSString *)appid withDescription:(NSString *)appdesc {
	return NO;
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