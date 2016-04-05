//
//  UKOuterTableViewController.m
//  tryTableInTable
//
//  Created by Dmytro on 4/5/16.
//  Copyright © 2016 Uklon. All rights reserved.
//

#import "UKOuterTableViewController.h"
#import "UKInnerTableView.h"

@interface UKOuterTableViewController()<UKInnerTableViewDelegate>
@property (nonatomic, weak) IBOutlet UKInnerTableView *innerTableView;
@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation UKOuterTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.models = [NSMutableArray arrayWithObject:[UKDummyModel modelWithText:@"0"]];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return 44.0 * self.models.count;
    }
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)addNewModel
{
    [self.tableView beginUpdates];
    [self.models addObject:[UKDummyModel modelWithText:[NSString stringWithFormat:@"%ld", self.models.count]]];
    [self.tableView endUpdates];
}

- (void)printNumbers
{
    for (NSString *numberString in [self.models valueForKey:@"text"]) {
        NSLog(@"%@", numberString);
    }
}

@end
