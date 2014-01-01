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
	WXMediaMessage *message = [WXMediaMessage message];
	message.title = @"一无所有";
	message.description = @"崔健";
	[message setThumbImage:[UIImage imageNamed:@"res3.jpg"]];
	WXMusicObject *ext = [WXMusicObject object];
	ext.musicUrl = @"http://y.qq.com/i/song.html#p=7B22736F6E675F4E616D65223A22E4B880E697A0E68980E69C89222C22736F6E675F5761704C69766555524C223A22687474703A2F2F74736D7573696334382E74632E71712E636F6D2F586B30305156342F4141414130414141414E5430577532394D7A59344D7A63774D4C6735586A4C517747335A50676F47443864704151526643473444442F4E653765776B617A733D2F31303130333334372E6D34613F7569643D3233343734363930373526616D703B63743D3026616D703B636869643D30222C22736F6E675F5769666955524C223A22687474703A2F2F73747265616D31342E71716D757369632E71712E636F6D2F33303130333334372E6D7033222C226E657454797065223A2277696669222C22736F6E675F416C62756D223A22E4B880E697A0E68980E69C89222C22736F6E675F4944223A3130333334372C22736F6E675F54797065223A312C22736F6E675F53696E676572223A22E5B494E581A5222C22736F6E675F576170446F776E4C6F616455524C223A22687474703A2F2F74736D757369633132382E74632E71712E636F6D2F586C464E4D313574414141416A41414141477A4C36445039536A457A525467304E7A38774E446E752B6473483833344843756B5041576B6D48316C4A434E626F4D34394E4E7A754450444A647A7A45304F513D3D2F33303130333334372E6D70333F7569643D3233343734363930373526616D703B63743D3026616D703B636869643D3026616D703B73747265616D5F706F733D35227D";
	ext.musicDataUrl = @"http://stream20.qqmusic.qq.com/32464723.mp3";
	
	message.mediaObject = ext;
	
	SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
	req.bText = NO;
	req.message = message;
	req.scene = self.scene;
	
	[WXApi sendReq:req];
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
