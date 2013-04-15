//
//  SRTFavoritorViewController.h
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTFavoriteViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain,nonatomic) NSArray *stationFavor;

@property (retain,nonatomic) NSArray *lineFavor;

@property (assign ,nonatomic)BOOL isLine;

@property (retain, nonatomic) IBOutlet UITableView *favoriteTableView;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segControl;

@end
