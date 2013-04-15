 //
//  SRTTrainNumDetailViewController.m
//  SzgjRealTime
//
//  Created by user on 13-4-4.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SRTBusNumDetailViewController.h"
#import "SRTBusNumDetailCell.h"
#import "SRTBusLine.h"
#import "SRTFavoriteHelper.h"
#import "SRTToolbar.h"
#import "SRTNetworkHelper.h"
#import "SRTCacheHelper.h"
#import "SRTHttpHelper.h"

#define kSRTCacheBusLineInfoKeyPre            @"busLineInfo"

@implementation SRTBusNumDetailViewController
@synthesize busNumDetailTableView;
@synthesize cellNibRegisted ;
@synthesize lineNumDetail;
@synthesize lineGuid;
@synthesize opaqueView;
@synthesize activityIndicator;
@synthesize busLine;
@synthesize fromStationDetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        cellNibRegisted = FALSE;
        self.fromStationDetail= NO;
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
    busNumDetailTableView.delegate = self;
    busNumDetailTableView.dataSource =self;
    
   

    if (! self.fromStationDetail) {
        SRTToolbar* tools = [[SRTToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 44.01)];
        [tools setOpaque:NO];
        tools.backgroundColor = [UIColor clearColor];
        tools.clearsContextBeforeDrawing = YES;
        // create the array to hold the buttons, which then gets added to the toolbar
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
        
        // create a standard "add" button
        UIBarButtonItem* bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
        
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


    }else{
        SRTToolbar* tools = [[SRTToolbar alloc] initWithFrame:CGRectMake(0, 0, 50, 44.01)];
        [tools setOpaque:NO];
        tools.backgroundColor = [UIColor clearColor];
        tools.clearsContextBeforeDrawing = YES;
        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:1];
        UIBarButtonItem* bi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
        
        [buttons addObject:bi];
        [bi release];
        [tools setItems:buttons animated:NO];
        [buttons release];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
        [tools release];
    
    }
        
    
    
    
    
    //opaqueview 用以做UIActivityIndicatorView的容器view
    
    self.opaqueView = [[ UIView   alloc]  initWithFrame: CGRectMake(0 ,  0 ,  320 ,  596 )];
    
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
    
    
}

- (void)viewDidUnload
{
    [self setBusNumDetailTableView:nil];
    [self setLineNumDetail:nil];
    
    [self setActivityIndicator:nil];
    [self setOpaqueView: nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) viewWillAppear:(BOOL)animated{

}
- (void) viewDidAppear:(BOOL)animated{
    
    if (self.lineNumDetail == nil || [lineNumDetail count] == 0 ) {
        self.opaqueView.hidden  = NO ;
        [self.activityIndicator startAnimating];
        [self performSelectorInBackground:@selector(querySingleLine) withObject:nil];
    }

   
}



- (void) querySingleLine {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *key = [NSString stringWithFormat:@"%@-%@",kSRTCacheBusLineInfoKeyPre,self.lineGuid];
    
//    NSString* strUrl= [NSString stringWithFormat:@"%@?lineCode=%@",kSRTHttpBusLineDetailUrl,self.lineGuid]; 
//    
//    self.LineNumDetail = [SRTHttpHelper getJSONData:strUrl];
    NSArray * cacheResults = [SRTCacheHelper getJKArrayForKey:key];
    
    if (cacheResults == nil || [cacheResults count ] == 0 ) {
        
        NSString* strUrl= [NSString stringWithFormat:@"%@?lineCode=%@",kSRTHttpBusLineDetailUrl,self.lineGuid]; 
        
        self.lineNumDetail = [SRTHttpHelper getJSONData:strUrl];
        
        if (lineNumDetail != nil && [lineNumDetail count] > 0) {
            [SRTCacheHelper cacheJKArray:lineNumDetail forKey:key];
        }
        
    }else{
        if (cacheResults != nil && [cacheResults count] > 0) {
            for (id cr in cacheResults) {
                if ([cr objectForKey:@"time"]) {
                    [cr setObject:@"" forKey:@"time"];
                }
                
            }
            
        }
        
        self.lineNumDetail=cacheResults ; 
        
        NSString* strUrl= [NSString stringWithFormat:@"%@?lineCode=%@",kSRTHttpBusLineUpdateUrl,self.lineGuid]; 
        NSArray *runTimeArray = [SRTHttpHelper getJSONData:strUrl];
        NSString *rtCode ;
        NSString *lineStandCode;
        if (runTimeArray != nil && [runTimeArray count] > 0) {
            for (id rt  in runTimeArray) {
                rtCode = [NSString stringWithFormat:@"%@",[rt objectForKey:@"code"]];
                for (id line in self.lineNumDetail) {
                    lineStandCode = [NSString stringWithFormat:@"%@",[line objectForKey:@"standCode"]];
                    if ([rtCode isEqualToString:lineStandCode ]) {
                        NSLog(@"line old time=%@",[line objectForKey:@"time"]);
                        [line setObject: [rt objectForKey:@"value"] forKey:@"time"] ; 
                        NSLog(@"new old time=%@",[line objectForKey:@"time"]);
                    }
                }
            }
            
        }
    
        
    }

    
    NSLog(@"lineNumDetail=%@",lineNumDetail);
    [self.activityIndicator stopAnimating];
    opaqueView.hidden = YES; 
    [busNumDetailTableView reloadData];
    [pool release];
    

} 


- (void) addFavorite{

    [SRTFavoriteHelper saveLineFavorToNSUserDefaults:self.busLine];
    //NSLog(@"NOW favoriteLine lineguid =%@" ,[SRTFavoriteHelper getLineFavorFromNSUserDefaults]);
    [SRTAppHelper alertMsg: [NSString stringWithFormat:@"收藏车次［%@］成功!",self.busLine.lineNumber]];
    
}

- (void) refresh{
    self.opaqueView.hidden  = NO ;
    [self.activityIndicator startAnimating];
    [self performSelectorInBackground:@selector(querySingleLine) withObject:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [lineNumDetail count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SRTBusNumDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[SRTBusNumDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType =UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        // reuse the cell
    }
    
    SRTBusNumDetailCell *__cell = (SRTBusNumDetailCell *)cell;
    id  __lineNumberResult = [ lineNumDetail objectAtIndex:indexPath.row ] ;
    [__cell.labelEnterStationName setText: [__lineNumberResult objectForKey:@"standName"]];
    [__cell.labelStandCode setText: [__lineNumberResult objectForKey:@"standCode"]];
    [__cell.labelStationName setText: [__lineNumberResult objectForKey:@"standName"]];
    
    [__cell.labelEnterTime setText:[__lineNumberResult objectForKey:@"time"]];
    BOOL isEnter = [[__lineNumberResult objectForKey:@"time"] length ] > 0;
    
    [__cell.labelEnterStationName setHidden:!isEnter];
    [__cell.labelEnterTime setHidden:!isEnter];
    [__cell.labelPreTime setHidden:!isEnter];
    [__cell.currentTopImage setHidden:!isEnter];
    [__cell.currentBottomImage setHidden:!isEnter];
    [__cell.labelStationName setHidden:isEnter];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)dealloc {
    [busNumDetailTableView release];
    [lineNumDetail release];
    [opaqueView release];
    [activityIndicator release];
    [super dealloc];
}
@end
