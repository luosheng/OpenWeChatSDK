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
	if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
		// 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
		NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
		NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		alert.tag = 1000;
		[alert show];
	} else if ([req isKindOfClass:[ShowMessageFromWXReq class]]) {
		ShowMessageFromWXReq *temp = (ShowMessageFromWXReq *)req;
		WXMediaMessage *msg = temp.message;
		
		//显示微信传过来的内容
		WXAppExtendObject *obj = (WXAppExtendObject *)msg.mediaObject;
		
		NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
		NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned int)msg.thumbData.length];
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	} else if ([req isKindOfClass:[LaunchFromWXReq class]]) {
		//从微信启动App
		NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
		NSString *strMsg = @"这是从微信启动的消息";
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
		[alert show];
	}
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
