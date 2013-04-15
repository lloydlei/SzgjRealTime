//
//  SRTResourcesHelper.m
//
//  Created by leilei on 12-05-20.
//  Copyright (c) 2012年 snda. All rights reserved.
//


#import "SRTResourcesHelper.h"

static NSString *RESOURCES_DIR=@"Resouces";

@implementation SRTResourcesHelper

+ (void) bindPlist:(NSString *) plistFileName{

    BOOL success = YES;
    NSString *_v_resDirPath =[[self sandboxDocumentDir] stringByAppendingPathComponent:RESOURCES_DIR];
    NSFileManager *_v_fm =[NSFileManager defaultManager];
    if (![_v_fm fileExistsAtPath : _v_resDirPath] ) {
        [_v_fm createDirectoryAtPath:_v_resDirPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSError * _v_err;
    NSString *_v_plistFilePath =[_v_resDirPath stringByAppendingPathComponent:plistFileName];
  
    NSString *_v_resPlistPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:plistFileName];
    if (![_v_fm fileExistsAtPath:_v_plistFilePath]) {
        success = [_v_fm copyItemAtPath:_v_resPlistPath toPath:_v_plistFilePath error:&_v_err];
    }  
    
    if (!success) {

        NSLog(@"Failed to create writable plist file with message '%@'.", [_v_err localizedDescription]);		
    }

}



+ (NSString *) sandboxDocumentDir{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);   
    return [paths objectAtIndex:0];
    
}

+ (NSString *) sandboxTmpDir{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
    
}

+ (NSString *) sandboxCachesDir{
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory , NSUserDomainMask, YES);   
    return [paths objectAtIndex:0];
}

+ (NSString *) sandboxHomeDir{
    return NSHomeDirectory();
}
@end
