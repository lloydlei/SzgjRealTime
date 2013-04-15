//
//  SRTStationDetailViewController.m
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SRTStationDetailViewController.h"
#import "SRTStationDetailCell.h"
#import "SRTBusNumDetailViewController.h"
#import "SRTFavoriteHelper.h"
#import "SRTStation.h"
#import "SRTToolbar.h"
#import "SRTNetworkHelper.h"
#import "SRTHttpHelper.h"


@implementation SRTStationDetailViewController
@synthesize stationDetailTableView;
@synthesize standCode;
@synthesize stationDetailInfos;
@synthesize opaqueView;
@synthesize activityIndicator;
@synthesize station;
@synthesize fromFavor;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.fromFavor = NO; 
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
    stationDetailTableView.delegate = self;
    stationDetailTableView.dataSource =self;
    
    if (self.fromFavor) {
        SRTToolbar* tools = [[SRTToolbar alloc] initWithFrame:CGRectMake(0, 0, 50, 44.01)];
        [tools setOpaque:NO];
        tools.backgroundColor = [UIColor clearColor];
        tools.clearsContextBeforeDrawing = YES;
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:1];
        
        // create a standard "add" button
        UIBarButtonItem* bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
        [buttons addObject:bi];
        [bi release];
        [tools setItems:buttons animated:NO];
        [buttons release];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
        [tools release];
    }else{
        SRTToolbar* tools = [[SRTToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 44.01)];
        [tools setOpaque:NO];
        tools.backgroundColor = [UIColor clearColor];
        tools.clearsContextBeforeDrawing = YES;
        // create the array to hold the buttons, which then gets added to the toolbar
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];

        // create a standard "add" button
        UIBarButtonItem* bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
        //[[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(config)];     
        //bi.style = UIBarButtonItemStyleBordered;
        [buttons addObject:bi];
        [bi release];

        bi = [[UIBarButtonItem alloc]
              initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(addFavorite)];
        bi.style = UIBarButtonItemStyleBordered;
        [buttons addObject:bi];
        [bi release];
        [tools setItems:buttons animated:NO];
        [buttons release];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
        [tools release];
    }

    
    
    
    //opaqueview 用以做UIActivityIndicatorView的容器view
    
    self.opaqueView = [[ UIView   alloc]  initWithFrame: CGRectMake(0 ,  0 ,  320 ,  596 )];
    
    self.activityIndicator  = [[ UIActivityIndicatorView   alloc]  initWithFrame: CGRectMake( 140 ,  140 ,  50 ,50   )];
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
    //UILabel *_loading = [[[UILabel alloc] initWithFrame:CGRectMake(13, 65, 85, 30)] autorelease];
    //[_loading setBackgroundColor:[UIColor clearColor]];
    //[_loading setFont:[UIFont systemFontOfSize:16.0f]];
    //[_loading setText:@"Loading..."];
    //[_loading setTextColor:[UIColor whiteColor]];
    //[self.activityIndicator addSubview:_loading];
    [ self.opaqueView  addSubview : self.activityIndicator];
    
}

- (void) viewWillAppear:(BOOL)animated{
            
}

- (void) viewDidAppear:(BOOL)animated{
    
    if (self.stationDetailInfos == nil || [stationDetailInfos count] == 0 ) {
        self.opaqueView.hidden  = NO ;
        [self.activityIndicator startAnimating];
        [self performSelectorInBackground:@selector(queryStationBus) withObject:nil];
    }
}


- (void) queryStationBus {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString* strUrl= [NSString stringWithFormat:@"%@?stationCode=%@",kSRTHttpStationBusUrl, self.standCode ]; 
    self.stationDetailInfos = [SRTHttpHelper getJSONData:strUrl];

    [stationDetailTableView reloadData];
    [self.activityIndicator stopAnimating];
    opaqueView.hidden = YES;
    [pool release];
    

}


- (void) addFavorite{
    [SRTFavoriteHelper saveStationFavorToNSUserDefaults:self.station];
    NSLog(@"NOW favoriteLine lineguid =%@" ,[SRTFavoriteHelper getStationFavorFromNSUserDefaults]);
    [SRTAppHelper alertMsg: [NSString stringWithFormat:@"收藏站台［%@］成功!",self.station.standName]];
}

- (void) refresh{
    self.opaqueView.hidden  = NO ;
    [self.activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(queryStationBus) withObject:nil];
    
}
- (void)viewDidUnload
{
    [self setStationDetailTableView:nil];
    [self setStationDetailInfos:nil];
    [self setActivityIndicator:nil];
    [self setOpaqueView: nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



#pragma mark -  UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Alert view clickedButtonAtIndex.....");
    [self.activityIndicator stopAnimating];
    
    self.opaqueView.hidden  = YES ;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [stationDetailInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"StationResultCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (!opaqueView.hidden) {
            opaqueView.hidden = YES;
        }
        cell = [[[SRTStationDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType =UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        // reuse the cell
    }
    SRTStationDetailCell *__cell = (SRTStationDetailCell *)cell;
    id  __lineNumberResult = [ stationDetailInfos objectAtIndex:indexPath.row ] ;
    [__cell.labelLineNumber setText: [__lineNumberResult objectForKey:@"lineNumber"]];
    [__cell.labelLineGuid setText: [__lineNumberResult objectForKey:@"lineGuid"]];
    NSObject *  __startStation = [__lineNumberResult objectForKey:@"startStation"];
    NSLog(@"__startStation=%@",__startStation);
    if(__startStation){
        [__cell.labelStartStation setText: [NSString stringWithFormat:@"%@",__startStation ]] ;
    }
    NSObject * __endStation = [__lineNumberResult objectForKey:@"endStation"];
    if (__endStation ) {
        [__cell.labelEndStation setText: [NSString stringWithFormat:@"%@",__endStation ]];
    }
    

    [__cell.labelStandNum setText:[NSString stringWithFormat:@"%@ 站",[__lineNumberResult objectForKey:@"standNum"]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SRTBusNumDetailViewController *__sdvctrl = [[[SRTBusNumDetailViewController alloc] initWithNibName:@"SRTBusNumDetailViewController" bundle:nil] autorelease]; 
    id  __lineNumberResult = [ stationDetailInfos objectAtIndex:indexPath.row ] ;
    [__sdvctrl setLineGuid: [__lineNumberResult objectForKey:@"lineGuid"]];
    __sdvctrl.navigationItem.title = [NSString stringWithFormat:@"%@" ,[__lineNumberResult objectForKey:@"lineNumber"]];
    
    SRTBusLine * sbl = [[ SRTBusLine alloc ] init];
    [sbl setLineNumber: [__lineNumberResult objectForKey:@"lineNumber"]];
    [sbl setLineGuid:[__lineNumberResult objectForKey:@"lineGuid"]];
    [sbl setStartStation: [__lineNumberResult objectForKey:@"startStation"]];
    [sbl setEndStation: [__lineNumberResult objectForKey:@"endStation"]];
    [sbl setTotalStation: (int)[__lineNumberResult objectForKey:@"totalStation"]];
    [sbl setRunTime: [__lineNumberResult objectForKey:@"runTime"]];
    
    [__sdvctrl setBusLine:sbl];
    [__sdvctrl setFromStationDetail:YES];
    [self.navigationController pushViewController:__sdvctrl animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [stationDetailTableView release];
    [stationDetailInfos release];
    [opaqueView release];
    [activityIndicator release];
    [super dealloc];
}
@end
