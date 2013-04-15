//
//  SRTFirstViewController.m
//  SzgjRealTime
//
//  Created by user on 13-4-3.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SRTBusNumViewController.h"

#import "SRTBusNumSearchResultCell.h"
#import "SRTBusNumDetailViewController.h"
#import "SRTCacheHelper.h"
#import "SRTNetworkHelper.h"
#import "SRTHttpHelper.h"

#define kSRTCacheBusLineSearchReaultKeyPre    @"busLineSearch"

@implementation SRTBusNumViewController
@synthesize trainNumSearchBar;
@synthesize trainNumResultTableView;
@synthesize lineNumSearchResults;
@synthesize cellNibRegistered;
@synthesize opaqueView,activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"车次查询", @"车次查询");
        self.tabBarItem.image = [UIImage imageNamed:@"tab_line"];
        cellNibRegistered = NO;
    }
    return self;
}

#pragma mark - Do search

- (void) doTrainNumSearch:(NSString *)trainNum
{
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSArray * cacheResults = [SRTCacheHelper getJKArrayForKey:[NSString stringWithFormat:@"%@-%@",kSRTCacheBusLineSearchReaultKeyPre,trainNum]];
    
    if (cacheResults == nil && [cacheResults count ] == 0 ) {
        NSString* strUrl= [NSString stringWithFormat:@"%@?lineNumber=%@",kSRTHttpBusLineSearchUrl, trainNum ]; 
        self.lineNumSearchResults = [SRTHttpHelper getJSONData:strUrl];
        if (lineNumSearchResults == nil || [lineNumSearchResults count] == 0) {
           self.lineNumSearchResults = cacheResults;
        }else{
            [SRTCacheHelper cacheJKArray:lineNumSearchResults forKey:[NSString stringWithFormat:@"%@-%@",kSRTCacheBusLineSearchReaultKeyPre,trainNum]];
        }
    }else{
        self.lineNumSearchResults = cacheResults;
    }  
    


    NSLog(@"lineNumSearchResults count =%d", [lineNumSearchResults count]);
    
    [trainNumResultTableView reloadData];
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
    
    return [lineNumSearchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"SRTBusNumSearchResultCell";
    //注册tableViewCell到tableView
    /*  //for __IPHONE_5_0 
    if (!cellNibRegistered) {
        UINib *nib = [UINib nibWithNibName:@"SRTBusNumSearchResultCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier];
        cellNibRegistered = YES;
    }
    */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        /* //no reuse the cell
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"SRTTrainNumResultCell" owner:self options:nil];
        
        for (UIView *view in views) {
            if([view isKindOfClass:[UITableViewCell class]])
            {
                cell = (SRTTrainNumResultCell *)view;
                
                NSString *key = [[NSString alloc] initWithFormat:@"%d",indexPath.row + 1];
                UIImageView *bv = (UIImageView *)[cell viewWithTag:1];
                
                [bv setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",key]]];
                UILabel * label = (UILabel *)[cell viewWithTag:2];
                

                
                
            }
            break;
        }
        */
        cell = [[[SRTBusNumSearchResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

    }else{
        // reuse
    }
    
    SRTBusNumSearchResultCell *__cell = (SRTBusNumSearchResultCell *)cell;
    id  __lineNumberResult = [ lineNumSearchResults objectAtIndex:indexPath.row ] ;
    [__cell.labelLineNumber setText: [__lineNumberResult objectForKey:@"lineNumber"]];
    [__cell.labelLineGuid setText: [__lineNumberResult objectForKey:@"lineGuid"]];
    [__cell.labelStartStation setText: [__lineNumberResult objectForKey:@"startStation"]];
    [__cell.labelEndStation setText: [__lineNumberResult objectForKey:@"endStation"]];
    [__cell.labelTotalStation setText: [NSString stringWithFormat:@"%d",[__lineNumberResult objectForKey:@"totalStation"]]];
    [__cell.labelRunTime setText:[NSString stringWithFormat:@"首末班时间: %@",[__lineNumberResult objectForKey:@"runTime"]]];
 
    cell.accessoryType =UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SRTBusNumDetailViewController *__sdvctrl = [[[SRTBusNumDetailViewController alloc] initWithNibName:@"SRTBusNumDetailViewController" bundle:nil] autorelease]; 
    id  __lineNumberResult = [ lineNumSearchResults objectAtIndex:indexPath.row ] ;
    [__sdvctrl setLineGuid: [__lineNumberResult objectForKey:@"lineGuid"]];
    __sdvctrl.navigationItem.title = [__lineNumberResult objectForKey:@"lineNumber"];
    
    SRTBusLine * sbl = [[ SRTBusLine alloc ] init];
    [sbl setLineNumber: [__lineNumberResult objectForKey:@"lineNumber"]];
    [sbl setLineGuid:[__lineNumberResult objectForKey:@"lineGuid"]];
    [sbl setStartStation: [__lineNumberResult objectForKey:@"startStation"]];
    [sbl setEndStation: [__lineNumberResult objectForKey:@"endStation"]];
    [sbl setTotalStation: (int)[__lineNumberResult objectForKey:@"totalStation"]];
    [sbl setRunTime: [__lineNumberResult objectForKey:@"runTime"]];
     
    [__sdvctrl setBusLine:sbl];
    [sbl release];
    
    
    [self.navigationController pushViewController:__sdvctrl animated:YES];
    //[self.navigationController setNavigationBarHidden:FALSE];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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
    
    if(searchBar.text && searchBar.text.length >0){
        
        self.opaqueView.hidden  = NO ;
        [self.activityIndicator startAnimating];
        
        [self performSelectorInBackground:@selector(doTrainNumSearch:) withObject:searchBar.text];
        
    }
    
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
    // set searchBar delegate
    trainNumSearchBar.delegate = self ;
    for(id cc in [trainNumSearchBar subviews]){  
        if([cc isKindOfClass:[UIButton class]]){  
            UIButton *btn = (UIButton *)cc;  
            [btn setTitle:@"取消"  forState:UIControlStateNormal];  
        }  
    } 
    trainNumResultTableView.dataSource = self;
    trainNumResultTableView.delegate = self;
    
    lineNumSearchResults = [[NSArray alloc ] init] ;
    
    //opaqueview 用以做UIActivityIndicatorView的容器view
    
    self.opaqueView = [[ UIView   alloc]  initWithFrame: CGRectMake(0 ,  44 ,  320 ,   323)];
    
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
    [self setTrainNumSearchBar:nil];
    [self setTrainNumResultTableView:nil];
    [self setLineNumSearchResults:nil];
    
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
    [trainNumSearchBar release];
    [trainNumResultTableView release];
    [lineNumSearchResults release];
    
    [opaqueView release];
    [activityIndicator release];
    [super dealloc];
}
@end
