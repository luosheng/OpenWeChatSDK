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
		_actions = @[[NSValue valueWithPointer:@selector(sendTextContent)]];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_sceneSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"会话", @"朋友圈", @"收藏"]];
	_sceneSegmentedControl.selectedSegmentIndex = 0;
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

#pragma mark - WeChat API actions

- (void)sendTextContent {
	SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
	req.text = @"人文的东西并不是体现在你看得到的方面，它更多的体现在你看不到的那些方面，它会影响每一个功能，这才是最本质的。但是，对这点可能很多人没有思考过，以为人文的东西就是我们搞一个很小清新的图片什么的。”综合来看，人文的东西其实是贯穿整个产品的脉络，或者说是它的灵魂所在。";
	req.bText = YES;
	
	[WXApi sendReq:req];
}

@end
