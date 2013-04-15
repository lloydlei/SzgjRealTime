//
//  SRTStation.m
//  SzgjRealTime
//
//  Created by user on 13-4-7.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "SRTStation.h"

@implementation SRTStation
@synthesize standCode;
@synthesize standName;
@synthesize road;
@synthesize area;
@synthesize bus;
@synthesize trend;

/* This code has been added to support encoding and decoding my objects */

-(void)encodeWithCoder:(NSCoder *)encoder
{
    //Encode the properties of the object
    [encoder encodeObject:self.standCode forKey:@"standCode"];
    [encoder encodeObject:self.standName forKey:@"standName"];
    [encoder encodeObject:self.road forKey:@"road"];
    [encoder encodeObject:self.area forKey:@"area"];
    [encoder encodeObject:self.bus forKey:@"bus"];
    [encoder encodeObject:self.trend forKey:@"trend"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if ( self)
    {
        //decode the properties
        self.standCode = [decoder decodeObjectForKey:@"standCode"];
        self.standName = [decoder decodeObjectForKey:@"standName"];
        self.road = [decoder decodeObjectForKey:@"road"];
        self.area = [decoder decodeObjectForKey:@"area"];
        self.bus = [decoder decodeObjectForKey:@"bus"];
        self.trend = [decoder decodeObjectForKey:@"trend"];
        
        
        
    }
    return self;
}
-(NSString*)description {
    return [[[NSString alloc]initWithFormat:@"standCode:%@ standName:%@ road:%@ area:%@ bus:%@ trend=%@", self.standCode, self.standName,self.road,self.area,self.bus ,self.trend]autorelease];
}

@end
