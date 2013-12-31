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

@end
