//
//  SRTSecondViewController.m
//  SzgjRealTime
//
//  Created by user on 13-4-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SRTStationViewController.h"
#import "SRTStationResultCell.h"
#import "SRTStationDetailViewController.h"
#import "SRTBusNumSearchResultCell.h"
#import "SRTNetworkHelper.h"
#import "SRTHttpHelper.h"

@implementation SRTStationViewController
@synthesize stationSearchBar;
@synthesize stationTableView;
@synthesize cellNibRegisted;
@synthesize stationSearchResultInfos;
@synthesize opaqueView,activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"站台查询", @"站台查询");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_station"];
        self.cellNibRegisted = NO;
    }
    return self;
}


#pragma mark - Do search

- (void) doStationSearch:(NSString *)stationName
{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    NSString* strUrl= [NSString stringWithFormat:@"%@?stationName=%@",kSRTHttpStationSearchUrl, stationName ]; 
    self.stationSearchResultInfos = [SRTHttpHelper getJSONData:strUrl];
   
    [stationTableView reloadData];
    [self.activityIndicator stopAnimating];
    opaqueView.hidden = YES;
    [pool release];
    
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [stationSearchResultInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SRTStationResultCell";
    
    static int count = 0;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSLog(@"cell init count=%d",count++);
        cell = [[[SRTStationResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];


    }else{
        // reuse the cell
        NSLog(@"cell reuse count=%d",count--);
    }
    
    
    SRTStationResultCell *__cell = (SRTStationResultCell *)cell;
    id  __lineNumberResult = [ stationSearchResultInfos objectAtIndex:indexPath.row ] ;
    [__cell.labelStandCode setText: [__lineNumberResult objectForKey:@"standCode"]];
    [__cell.labelStandName setText: [NSString stringWithFormat:@" %@",[__lineNumberResult objectForKey:@"standName"]]];
    [__cell.labelRoad setText: [__lineNumberResult objectForKey:@"road"]];
    if ([__lineNumberResult objectForKey:@"trend"]) {
        [__cell.labelTrend setText: [NSString stringWithFormat:@"%@",[__lineNumberResult objectForKey:@"trend"]]];
    }
    
    [__cell.labelArea setText: [__lineNumberResult objectForKey:@"area"]];
    [__cell.labelBus setText:[__lineNumberResult objectForKey:@"bus"]];


    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRTStationDetailViewController *__sdvctrl = [[[SRTStationDetailViewController alloc] initWithNibName:@"SRTStationDetailViewController" bundle:nil] autorelease];
    
    id  __stationResult = [ stationSearchResultInfos objectAtIndex:indexPath.row ] ;
    [__sdvctrl setStandCode: [__stationResult objectForKey:@"standCode"]];
    SRTStation * st = [[SRTStation alloc ] init];
    
    st.standCode = [__stationResult objectForKey:@"standCode"];
    st.standName = [__stationResult objectForKey:@"standName"];
    st.road = [__stationResult objectForKey:@"road"];
    st.trend = [__stationResult objectForKey:@"trend"];
    st.area = [__stationResult objectForKey:@"area"];
    st.bus =[__stationResult objectForKey:@"bus"];
    __sdvctrl.station = st;
    
    __sdvctrl.navigationItem.title =  [__stationResult objectForKey:@"standName"];
    [self.navigationController pushViewController:__sdvctrl animated:YES];
    //[self.navigationController setNavigationBarHidden:FALSE];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


#pragma mark - UISearchBar Delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}                    
// return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}                    

// called when text starts editing
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

// return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

// called when text ends editing
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText

{
    
}  


// called before text changes

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    //searchBar.text = @"观前街";
    
    self.opaqueView.hidden  = NO ;
    [self.activityIndicator startAnimating];
    
    [self performSelectorInBackground:@selector(doStationSearch:) withObject:searchBar.text];

}
// called when keyboard search button pressed
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];

    
}

// called when bookmark button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    [searchBar resignFirstResponder];

}

							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    stationSearchBar.delegate = self;
    stationTableView.delegate = self;
    stationTableView.dataSource = self;
    
    for(id cc in [stationSearchBar subviews]){  
        if([cc isKindOfClass:[UIButton class]]){  
            UIButton *btn = (UIButton *)cc;  
            [btn setTitle:@"取消"  forState:UIControlStateNormal];  
        }  
    } 
    
    //opaqueview 用以做UIActivityIndicatorView的容器view
    
    self.opaqueView = [[ UIView   alloc]  initWithFrame: CGRectMake(0 ,  44 ,  320 ,   323 )];
    
    self.activityIndicator  = [[ UIActivityIndicatorView   alloc]  initWithFrame: CGRectMake( 140 ,  140 ,  50 ,50     )];
    [self.activityIndicator setBackgroundColor:[UIColor blackColor]];
    //[ self.activityIndicator  setCenter :  self.opaqueView.center ];
    [ self.activityIndicator  setAlpha: 0.81];
    self.activityIndicator.layer.cornerRadius = 3;
    self.activityIndicator.layer.masksToBounds = YES;
    //给图层添加一个有色边框
    //    self.activityIndicator.layer.borderWidth = 1;
    //    self.activityIndicator.layer.borderColor = [[UIColor colorWithRed:0.2 green:0.09 blue:0.07 alpha:1] CGColor];
    [ self.activityIndicator   setActivityIndicatorViewStyle: UIActivityIndicatorViewStyleWhiteLarge]; 
    
    [ self.opaqueView  setBackgroundColor:[ UIColor clearColor]];
    
    [ self.view  addSubview :  self.opaqueView];
    //    UILabel *_loading = [[[UILabel alloc] initWithFrame:CGRectMake(13, 65, 85, 30)] autorelease];
    //    [_loading setBackgroundColor:[UIColor clearColor]];
    //    [_loading setFont:[UIFont systemFontOfSize:16.0f]];
    //    [_loading setText:@"Loading..."];
    //    [_loading setTextColor:[UIColor whiteColor]];
    //    [self.activityIndicator addSubview:_loading];
    [ self.opaqueView  addSubview : self.activityIndicator];
    
    opaqueView.hidden = NO;
}

- (void)viewDidUnload
{
    [self setStationSearchBar:nil];
    [self setStationTableView:nil];
    
    [self setActivityIndicator:nil];
    [self setOpaqueView: nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    if (!self.navigationController.navigationBarHidden) {
//        [self.navigationController setNavigationBarHidden:TRUE];
//    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [stationSearchBar release];
    [stationTableView release];
    
    [opaqueView release];
    [activityIndicator release];
    [super dealloc];
}
@end
