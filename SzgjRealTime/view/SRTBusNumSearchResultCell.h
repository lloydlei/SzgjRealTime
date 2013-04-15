//
//  SRTBusNumSearchResultCell.h
//  SzgjRealTime
//
//  Created by user on 13-4-5.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTBusNumSearchResultCell : UITableViewCell
@property (retain, nonatomic)  UILabel *labelLineNumber;
@property (retain, nonatomic)  UILabel *labelRunTime;
@property (retain, nonatomic)  UILabel *labelStartStation;
@property (retain, nonatomic)  UILabel *labelEndStation;
@property (retain, nonatomic)  UILabel *labelLineGuid;
@property (retain, nonatomic)  UILabel *labelTotalStation;

@end
