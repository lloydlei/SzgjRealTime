//
//  SRTFirstViewController.h
//  SzgjRealTime
//
//  Created by user on 13-4-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTBusNumViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UISearchBar *trainNumSearchBar;
@property (retain, nonatomic) IBOutlet UITableView *trainNumResultTableView;

@property (retain ,nonatomic) NSArray *lineNumSearchResults;
@property (strong ,nonatomic) UIActivityIndicatorView * activityIndicator;

@property (strong ,nonatomic) UIView *opaqueView;

- (void) doTrainNumSearch:(NSString *)trainNum;
@property (assign,nonatomic) BOOL cellNibRegistered;
@end
