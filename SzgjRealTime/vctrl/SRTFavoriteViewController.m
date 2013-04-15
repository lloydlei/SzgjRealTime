//
//  SRTFavoritorViewController.m
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTFavoriteViewController.h"
#import "SRTFavoriteHelper.h"
#import "SRTBusNumSearchResultCell.h"
#import "SRTStationResultCell.h"
#import "SRTBusNumDetailViewController.h"
#import "SRTStationDetailViewController.h"
@implementation SRTFavoriteViewController
@synthesize stationFavor;
@synthesize lineFavor;
@synthesize isLine;
@synthesize favoriteTableView;
@synthesize segControl;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"收藏", @"收藏");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_favorite_icon"];
        self.isLine = FALSE;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLineFavor: [SRTFavoriteHelper getLineFavorFromNSUserDefaults]];
    [self setStationFavor:[SRTFavoriteHelper getStationFavorFromNSUserDefaults]];
    
    for (SRTBusLine * l in self.lineFavor) {
        NSLog(@"line code=%@",l.lineNumber);
    }
    
    self.favoriteTableView.delegate = self;
    self.favoriteTableView.dataSource =self;
    [segControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];  //添加委托方法
    
        


}

- (void)viewDidUnload
{
    [self setFavoriteTableView:nil];
    [self setSegControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	if (segControl ) {
        NSInteger index = segControl.selectedSegmentIndex;
        
        switch (index) {
                
            case 0:
                isLine = FALSE;
                [self setStationFavor:[SRTFavoriteHelper getStationFavorFromNSUserDefaults]];
                [favoriteTableView reloadData];
                
                break;
                
            case 1:
                isLine = TRUE;
                [self setLineFavor: [SRTFavoriteHelper getLineFavorFromNSUserDefaults]];
                [favoriteTableView reloadData];
                
                break;
                
                
            default:
                
                break;
                
        }

    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [favoriteTableView release];
    [segControl release];
    [super dealloc];
}

#pragma mark UISegmentedControl 
//具体seg委托方法实例   

-(void)segmentAction:(UISegmentedControl *)Seg {
    
    NSInteger index = Seg.selectedSegmentIndex;
    
    switch (index) {
            
        case 0:
            isLine = FALSE;
            [self setStationFavor:[SRTFavoriteHelper getStationFavorFromNSUserDefaults]];
            [favoriteTableView reloadData];
            
            break;
            
        case 1:
            isLine = TRUE;
            [self setLineFavor: [SRTFavoriteHelper getLineFavorFromNSUserDefaults]];
            [favoriteTableView reloadData];

            break;
            
            
        default:
            
            break;
            
    }
    
}

- (void) showFavor{
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(isLine)
        return [self.lineFavor count];
    return [self.stationFavor count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *lineCellIdentifier = @"lineCell";
    static NSString  *stationCellIdentifier=@"stationCell";
    UITableViewCell *cell;
    if (isLine) {
        cell = [tableView dequeueReusableCellWithIdentifier:lineCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[SRTBusNumSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lineCellIdentifier] autorelease];
            
        }else{
            // reuse
        }
        
        SRTBusNumSearchResultCell *__cell = (SRTBusNumSearchResultCell *)cell;
        SRTBusLine  *__lineNumberResult = (SRTBusLine *)[ lineFavor objectAtIndex:indexPath.row ] ;
        [__cell.labelLineNumber setText: __lineNumberResult.lineNumber ];
        [__cell.labelLineGuid setText: __lineNumberResult.lineGuid];
        [__cell.labelStartStation setText: __lineNumberResult.startStation];
        [__cell.labelEndStation setText: __lineNumberResult.endStation];
        [__cell.labelTotalStation setText: [NSString stringWithFormat:@"%d",__lineNumberResult.totalStation]];
        [__cell.labelRunTime setText:[NSString stringWithFormat:@"首末班时间: %@",__lineNumberResult.runTime ]];


    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:stationCellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[SRTStationResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stationCellIdentifier] autorelease];
            
        }else{
            // reuse
        }
        
        SRTStationResultCell *__cell = (SRTStationResultCell *)cell;
        SRTStation *  __stationResult = [ stationFavor objectAtIndex:indexPath.row ] ;
        [__cell.labelStandCode setText: __stationResult.standCode];
        [__cell.labelStandName setText: [NSString stringWithFormat:@" %@", __stationResult.standName]];
        [__cell.labelRoad setText: __stationResult.road];
        [__cell.labelTrend setText: __stationResult.trend];
        [__cell.labelArea setText: __stationResult.area];
        [__cell.labelBus setText:__stationResult.bus];

    }
         
        
    //cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (isLine) {
        SRTBusNumDetailViewController *__sdvctrl = [[[SRTBusNumDetailViewController alloc] initWithNibName:@"SRTBusNumDetailViewController" bundle:nil] autorelease]; 
        SRTBusLine  *__lineNumberResult = [ lineFavor objectAtIndex:indexPath.row ] ;
        [__sdvctrl setLineGuid: __lineNumberResult.lineGuid];
        __sdvctrl.navigationItem.title = __lineNumberResult.lineNumber;
        
        SRTBusLine * sbl = [[ SRTBusLine alloc ] init];
        
        [sbl setLineNumber: __lineNumberResult.lineNumber];
        [sbl setLineGuid:__lineNumberResult.lineGuid];
        [sbl setStartStation: __lineNumberResult.startStation];
        [sbl setEndStation: __lineNumberResult.endStation];
        [sbl setTotalStation: __lineNumberResult.totalStation];
        [sbl setRunTime: __lineNumberResult.runTime];
        
        [__sdvctrl setBusLine:sbl];
        [__sdvctrl setFromStationDetail:YES];
        [sbl release];
        [self.navigationController pushViewController:__sdvctrl animated:YES];

    }else{
        SRTStationDetailViewController *__sdvctrl = [[[SRTStationDetailViewController alloc] initWithNibName:@"SRTStationDetailViewController" bundle:nil] autorelease];
        
        SRTStation *  __stationResult = (SRTStation *)[ stationFavor objectAtIndex:indexPath.row ] ;
        NSLog(@"selected station=%@",__stationResult);
        [__sdvctrl setStandCode: __stationResult.standCode];
        __sdvctrl.navigationItem.title = __stationResult.standName;
        __sdvctrl.fromFavor = YES;
        [self.navigationController pushViewController:__sdvctrl animated:YES];

    }
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isLine) {
        return 100;
    }
    return 90;
}


@end
