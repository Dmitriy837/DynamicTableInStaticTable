//
//  UKMainViewController.m
//  tryTableInTable
//
//  Created by Dmytro on 4/5/16.
//  Copyright © 2016 Uklon. All rights reserved.
//

#import "UKMainViewController.h"
#import "UKOuterTableViewController.h"

@implementation UKMainViewController
{
    UKOuterTableViewController *tableVC;
    __weak IBOutlet UIButton *button;
}

- (void)viewDidLoad
{
    tableVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UKOuterTableViewController"];
    [self addChildViewController:tableVC];
    [self.view addSubview:tableVC.view];
    tableVC.view.translatesAutoresizingMaskIntoConstraints = NO;
    [tableVC didMoveToParentViewController:self];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[table]-[button]" options:0 metrics:nil views:@{@"table":tableVC.view, @"button":button}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[table]|" options:0 metrics:nil views:@{@"table":tableVC.view}]];
}

- (IBAction)printNumbers
{
    [tableVC printNumbers];
}

@end
