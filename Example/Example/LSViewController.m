//
//  LSViewController.m
//  Example
//
//  Created by Luo Sheng on 13-12-31.
//  Copyright (c) 2013年 Luo Sheng. All rights reserved.
//

#import "LSViewController.h"

@interface LSViewController ()

@property (nonatomic, readonly) UISegmentedControl *sceneSegmentedControl;
@property (nonatomic, readonly) NSArray *items;
@property (nonatomic, readonly) NSArray *actions;
@property (nonatomic, assign) NSUInteger scene;

@end

@implementation LSViewController

static NSString *const LSCellIdentifier = @"Cell";

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		_items = @[@"发送 Text 消息给微信",
							 @"发送 Photo 消息给微信",
							 @"发送 Link 消息给微信",
							 @"发送 Music 消息给微信",
							 @"发送 Video 消息给微信",
							 @"发送 App 消息给微信",
							 @"发送非 gif 表情给微信",
							 @"发送 gif 表情给微信",
							 ];
		_actions = @[[NSValue valueWithPointer:@selector(sendTextContent)],
								 [NSValue valueWithPointer:@selector(sendImageContent)],
								 [NSValue valueWithPointer:@selector(sendLinkContent)],
								 [NSValue valueWithPointer:@selector(sendMusicContent)],
								 [NSValue valueWithPointer:@selector(sendVideoContent)],
								 [NSValue valueWithPointer:@selector(sendAppContent)],
								 [NSValue valueWithPointer:@selector(sendNonGifContent)],
								 [NSValue valueWithPointer:@selector(sendGifContent)]];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_sceneSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"会话", @"朋友圈", @"收藏"]];
	_sceneSegmentedControl.selectedSegmentIndex = 0;
	[_sceneSegmentedControl addTarget:self action:@selector(sceneChanged:) forControlEvents:UIControlEventValueChanged];
	self.navigationItem.titleView = _sceneSegmentedControl;
	
	[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:LSCellIdentifier];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LSCellIdentifier forIndexPath:indexPath];
	
	NSString *text = self.items[indexPath.row];
	cell.textLabel.text = text;
	
	return cell;
}

#pragma mark - UITableView delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger index = indexPath.row > self.actions.count - 1 ? 0 : indexPath.row;
	NSValue *value = self.actions[index];
	SEL selector = [value pointerValue];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
	[self performSelector:selector];
#pragma clang diagnostic pop
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISegmentedControl actions

- (void)sceneChanged:(id)sender {
	self.scene = self.sceneSegmentedControl.selectedSegmentIndex;
}

#pragma mark - WeChat API actions

- (void)sendTextContent {
	SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
	req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
	req.bText = YES;
	req.scene = self.scene;
	
	[WXApi sendReq:req];
}

- (void)sendImageContent {
	WXMediaMessage *message = [WXMediaMessage message];
	
	[message setThumbImage:[UIImage imageNamed:@"res5thumb"]];
	
	WXImageObject *ext = [WXImageObject object];
	UIImage* image = [UIImage imageNamed:@"res5.jpg"];
	ext.imageData = UIImagePNGRepresentation(image);
	
	message.mediaObject = ext;
	
	SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
	req.bText = NO;
	req.message = message;
	req.scene = self.scene;
	
	[WXApi sendReq:req];
}

- (void)sendLinkContent {
	WXMediaMessage *message = [WXMediaMessage message];
	message.title = @"专访张小龙：产品之上的世界观";
	message.description = @"微信的平台化发展方向是否真的会让这个原本简洁的产品变得臃肿？在国际化发展方向上，微信面临的问题真的是文化差异壁垒吗？腾讯高级副总裁、微信产品负责人张小龙给出了自己的回复。";
	[message setThumbImage:[UIImage imageNamed:@"res2.png"]];
	
	WXWebpageObject *ext = [WXWebpageObject object];
	ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
	
	message.mediaObject = ext;
	
	SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
	req.bText = NO;
	req.message = message;
	req.scene = self.scene;
	
	[WXApi sendReq:req];
}

- (void)sendMusicContent {
	
}

- (void)sendVideoContent {
	
}

- (void)sendAppContent {
	
}

- (void)sendNonGifContent {
	
}

- (void)sendGifContent {
	
}

@end
