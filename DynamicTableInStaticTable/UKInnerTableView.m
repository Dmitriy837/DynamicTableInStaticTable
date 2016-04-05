//
//  UKSmallTableView.m
//  tryTableInTable
//
//  Created by Dmytro on 4/5/16.
//  Copyright © 2016 Uklon. All rights reserved.
//

#import "UKInnerTableView.h"
#import "BVReorderTableView.h"

@implementation UKDummyModel : NSObject
+ (instancetype)modelWithText:(NSString*)text
{
    UKDummyModel *instance = [UKDummyModel new];
    instance.text = text;
    return instance;
}
@end

@interface UKInnerTableView()<UITableViewDataSource, UITableViewDelegate, ReorderTableViewDelegate>
@property (nonatomic, weak) BVReorderTableView *tableView;
@end

@implementation UKInnerTableView
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        BVReorderTableView *tableView = [[BVReorderTableView alloc] init];
        [self addSubview:tableView];
        self.tableView = tableView;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
        self.tableView.scrollEnabled = NO;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    }
    return self;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.delegate.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.delegate.models[indexPath.row] text];
    cell.contentView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.delegate.models.count inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.delegate addNewModel];
    [tableView endUpdates];
}

#pragma mark Reordering

- (id)saveObjectAndInsertBlankRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [self.delegate.models objectAtIndex:indexPath.row];
    [self.delegate.models replaceObjectAtIndex:indexPath.row withObject:[UKDummyModel modelWithText:@""]];
    return object;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    id object = [self.delegate.models objectAtIndex:fromIndexPath.row];
    [self.delegate.models removeObjectAtIndex:fromIndexPath.row];
    [self.delegate.models insertObject:object atIndex:toIndexPath.row];
}

- (void)finishReorderingWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath; {
    [self.delegate.models replaceObjectAtIndex:indexPath.row withObject:object];
}

@end
