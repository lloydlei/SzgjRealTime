//
//  SRTFavoriteHelper.m
//  SzgjRealTime
//
//  Created by user on 13-4-8.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTFavoriteHelper.h"
#import "SRTResourcesHelper.h"
#import "SRTBusLine.h"
#import "SRTStation.h"


#define kSRTStationFavorFileName @"stationFavor"
#define kSRTLineFavorFileName    @"lineFavor"
#define kSRTCustomerFileName    @"customer"
@implementation SRTFavoriteHelper
+ (NSArray *) getLineFavorFromFile {
    
    NSArray *array = [ NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@",[SRTResourcesHelper sandboxDocumentDir], kSRTLineFavorFileName]];
    NSLog(@"sandboxDocumentDir=%@ \nlineFavor=%@",[SRTResourcesHelper sandboxDocumentDir],array);
    return array;    
}

+ (NSArray *) getStationFavorFromFile {
    NSLog(@"sandboxDocumentDir=%@",[SRTResourcesHelper sandboxDocumentDir]);
    NSArray *array = [ NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@",[SRTResourcesHelper sandboxDocumentDir], kSRTStationFavorFileName]];
    return array;
    
}

+ (void)saveLineFavorToFile:(SRTBusLine *)line{
  
    
    NSLog(@" save line id=%@,name=%@",line.lineGuid,line.lineNumber);
    NSMutableArray *ba = [[NSMutableArray alloc] init];
    [ba addObject:line];
    //[ba addObjectsFromArray:[SRTFavoriteHelper getLineFavorite]];
    NSArray * array = [NSArray arrayWithArray:ba];
    
    

    [NSKeyedArchiver archiveRootObject:array toFile:[NSString stringWithFormat:@"%@/%@",[SRTResourcesHelper sandboxDocumentDir], kSRTLineFavorFileName]];
    
    printf("Save: \n %s \n ", [[ba description] cStringUsingEncoding:NSUTF8StringEncoding]);
    
    [ba release];
}

+ (void)saveStationFavorToFile:(SRTStation *)station{
    NSLog(@" save station id=%@,name=%@",station.standCode,station.standName);
    NSMutableArray *ba = [[NSMutableArray alloc] init];
    [ba addObject:station];
    
    [ba addObjectsFromArray:[SRTFavoriteHelper getStationFavorFromFile]];
    
    
    [NSKeyedArchiver archiveRootObject:ba toFile:[NSString stringWithFormat:@"%@/%@",[SRTResourcesHelper sandboxDocumentDir], kSRTStationFavorFileName]];
    
    printf("Save: \n %s \n ", [[ba description] cStringUsingEncoding:NSUTF8StringEncoding]);
    
    
    
}

+ (void)saveLineFavorToNSUserDefaults:(SRTBusLine *)line{
 
    NSMutableArray *ba = [[NSMutableArray alloc] init];
    NSArray *olds = [SRTFavoriteHelper getLineFavorFromNSUserDefaults];
    
    if (olds != nil && [olds count] >0) {
        BOOL exist = NO;
        for (SRTBusLine * sb in olds) {
            if([sb.lineGuid isEqualToString:line.lineGuid]){
                exist = YES;
            }
        }
        if (!exist) {
            [ba addObject:line];
            [ba addObjectsFromArray:olds];
            NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:ba];
            [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey: kSRTLineFavorFileName];
            printf("Save: \n %s \n ", [[ba description] cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }else{
        [ba addObject:line];
        NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:ba];
        [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey: kSRTLineFavorFileName];
        printf("Save: \n %s \n ", [[ba description] cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    
    [ba release];
    
}

+ (NSArray *)getLineFavorFromNSUserDefaults{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSData *myDecodedObject = [prefs objectForKey:kSRTLineFavorFileName] ;
    
    return (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];

}

+ (void)saveStationFavorToNSUserDefaults:(SRTStation *)station{
    
    NSMutableArray *ba = [[NSMutableArray alloc] init];
    NSArray *olds = [SRTFavoriteHelper getStationFavorFromNSUserDefaults];
    
    if (olds != nil && [olds count] >0) {
        BOOL exist = NO;
        for (SRTStation * st in olds) {
            if([st.standCode isEqualToString:station.standCode]){
                exist = YES;
            }
        }
        if (!exist) {
            [ba addObject:station];
            [ba addObjectsFromArray:olds];
            NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:ba];
            [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey: kSRTStationFavorFileName];
            printf("Save: \n %s \n ", [[ba description] cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }else{
        [ba addObject:station];
        NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:ba];
        [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey: kSRTStationFavorFileName];
        printf("Save: \n %s \n ", [[ba description] cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    [ba release];
    
}

+ (NSArray *)getStationFavorFromNSUserDefaults{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSData *myDecodedObject = [prefs objectForKey:kSRTStationFavorFileName] ;
    return (NSArray*)[NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    
}


+ (void)saveCustomeObject:(CustomObject *)c{
    NSArray *array = [NSArray arrayWithObject: c ];
    [NSKeyedArchiver archiveRootObject:array toFile:[NSString stringWithFormat:@"%@/%@",[SRTResourcesHelper sandboxDocumentDir], kSRTCustomerFileName]];
    
    printf("Save: \n %s \n ", [[array description] cStringUsingEncoding:NSUTF8StringEncoding]);
}
+ (NSArray *) getCustomerObject{
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@",[SRTResourcesHelper sandboxDocumentDir], kSRTCustomerFileName]];
    printf("Load: \n %s \n ", [[array description] cStringUsingEncoding:NSUTF8StringEncoding]);
    return array;
}


@end
