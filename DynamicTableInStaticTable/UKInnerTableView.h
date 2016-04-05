//
//  UKSmallTableView.h
//  tryTableInTable
//
//  Created by Dmytro on 4/5/16.
//  Copyright © 2016 Uklon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UKDummyModel : NSObject
@property (nonatomic, strong) NSString *text;
+ (instancetype)modelWithText:(NSString*)text;
@end

@protocol UKInnerTableViewDelegate <NSObject>
- (void)addNewModel;
- (NSMutableArray*)models;
@end

@interface UKInnerTableView : UITableViewCell
@property (nonatomic, weak) IBOutlet id<UKInnerTableViewDelegate> delegate;
@end
