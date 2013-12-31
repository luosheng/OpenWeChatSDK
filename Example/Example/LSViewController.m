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

@end

@implementation LSViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_sceneSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"会话", @"朋友圈", @"收藏"]];
	_sceneSegmentedControl.selectedSegmentIndex = 0;
	self.navigationItem.titleView = _sceneSegmentedControl;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
