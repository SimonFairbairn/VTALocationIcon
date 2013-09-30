//
//  VTALIViewController.m
//  VTALocationIcon
//
//  Created by Simon Fairbairn on 30/09/2013.
//  Copyright (c) 2013 Simon Fairbairn. All rights reserved.
//

#import "VTALIViewController.h"
#import "VTALILocationIconView.h"

@interface VTALIViewController ()

@property (nonatomic, weak) IBOutlet VTALILocationIconView *icon;

@end

@implementation VTALIViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

-(IBAction)animate:(UIButton *)sender {
    [self.icon animate];
}


@end
