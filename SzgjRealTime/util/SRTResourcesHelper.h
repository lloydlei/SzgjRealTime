//
//  SRTResourcesHelper.h
//
//  Created by leilei on 12-05-20.
//  Copyright (c) 2012年 snda. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SRTResourcesHelper : NSObject

+ (NSString *) sandboxDocumentDir;

+ (NSString *) sandboxTmpDir;

+ (NSString *) sandboxCachesDir;

+ (NSString *) sandboxHomeDir;

+ (void) bindPlist:(NSString *) plistFileName;


@end
