//
//  SRTToolbar.m
//  SzgjRealTime
//
//  Created by user on 13-4-11.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTToolbar.h"

@implementation SRTToolbar

- (void)drawRect:(CGRect)rect {  
    // do nothing   
}  

- (id)initWithFrame:(CGRect)aRect {  
    if ((self = [super initWithFrame:aRect])) {  
        self.opaque = NO;  
        self.backgroundColor = [UIColor clearColor];  
        self.clearsContextBeforeDrawing = YES;  
    }  
    return self;  
}  


@end
