//
//  SRTSecondViewController.h
//  SzgjRealTime
//
//  Created by user on 13-4-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTStationViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UISearchBar *stationSearchBar;
@property (retain, nonatomic) IBOutlet UITableView *stationTableView;
@property (assign,nonatomic) BOOL cellNibRegisted;
@property (retain, nonatomic) NSArray * stationSearchResultInfos;
@property (strong ,nonatomic) UIActivityIndicatorView * activityIndicator;

@property (strong ,nonatomic) UIView *opaqueView;


- (void) doStationSearch:(NSString *)stationName;

@end
