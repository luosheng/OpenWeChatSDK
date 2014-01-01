//
//  LSAppDelegate.m
//  Example
//
//  Created by Luo Sheng on 13-12-31.
//  Copyright (c) 2013年 Luo Sheng. All rights reserved.
//

#import "LSAppDelegate.h"

@implementation LSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.
	[WXApi registerApp:@"wxd930ea5d5a258f4f" withDescription:@"demo 2.0"];
	return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
	NSLog(@"url %@ isSuc %d", url, isSuc == YES ? 1 : 0);
	return isSuc;
}

#pragma mark - WXApi delegate methods

- (void)onReq:(BaseReq *)req {
	
}

- (void)onResp:(BaseResp *)resp {
	if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
		NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
		NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
}

@end
