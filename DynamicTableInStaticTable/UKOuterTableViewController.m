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
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, weak) IBOutlet UKInnerTableView *innerTableView;
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

#pragma mark - UITableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1)
    {
        return 44.0 * self.models.count;
    }
    return 44.0f;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row == 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2)
    {
        [self.tableView beginUpdates];
        [self.innerTableView.tableView beginUpdates];
        [self.innerTableView.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.models.count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.models addObject:[UKDummyModel modelWithText:[NSString stringWithFormat:@"%ld", self.models.count]]];
        [self.innerTableView.tableView endUpdates];
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        cell.preservesSuperviewLayoutMargins = NO;
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}

#pragma mark - Action

- (NSString*)printNumbers
{
    return [[self.models valueForKey:@"text"] componentsJoinedByString:@", "];
}

@end
