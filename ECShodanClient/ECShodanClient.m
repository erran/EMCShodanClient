//
//  ECShodanClient.h
//  Erran Carey
//
//  Created by Erran Carey on 1/4/14.
//  Copyright (c) 2012-2014 Erran Carey. All rights reserved.
//

#import "ECShodanClient.h"

@implementation ECShodanClient

@synthesize apiKey;
@synthesize baseURL;
@synthesize results;
@synthesize requestArguments;
@synthesize requestParams;

#pragma mark -

/**
 @param key The API key to initalize the API object with.
 @returns self
 */
- (id)initWithAPIKey:(NSString *)key {
    self = [super init];
    if (self) {
        apiKey = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        baseURL = @"http://www.shodanhq.com/api/";
    }

    return self;
}

/**
 @param key The API key to initalize the API object with.
 */
- (void)setAPIKey:(NSString *)key {
    apiKey = key;
}

#pragma mark -

/**
 Sends a request to ShodanHQ based on the function.

 @param function The type of request to send to ShodanHQ.
 */
- (void)request:(NSString *)function {
    requestParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:baseURL,@"baseURL",[function stringByAppendingFormat:@"?"],@"function",[NSString stringWithFormat:@"key=%@",apiKey],@"apiKey",nil];
    NSURL* url = nil;
    NSString* url_string = @"";

// [review] - in iOS 5 and OS X 10.7 the NSDictionary ordering was different for each platform
#ifdef TARGET_OS_IPHONE
    url_string = [url_string stringByAppendingFormat:@"%@",baseURL];
    url_string = [url_string stringByAppendingFormat:@"%@",[function stringByAppendingFormat:@"?"]];
    url_string = [url_string stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"key=%@",apiKey]];
#else
    for (id key in requestParams) {
        url_string = [url_string stringByAppendingFormat:@"%@",[requestParams objectForKey:key]];
    }
#endif

    if ([function isEqualToString:@"count"]) {
        url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&q=%@",requestArguments]];
    }
    else if ([function isEqualToString:@"host"]) {
        url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&ip=%@",requestArguments]];
    }
    else if ([function isEqualToString:@"info"]) {
        url = [NSURL URLWithString:url_string];
    }
    else if ([function isEqualToString:@"locations"]) {
        url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&q=%@",requestArguments]];
    }
    else if ([function isEqualToString:@"search"]) {
        url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&q=%@",requestArguments]];
    }

    NSError* error;
    NSData* searchResults = [NSData dataWithContentsOfURL:url];
    if(!searchResults) {
        results = nil;
    }
    else{
        results = [NSJSONSerialization JSONObjectWithData:searchResults options:kNilOptions error:&error];
    }
}

- (NSDictionary *)host:(NSString *)hostname
{
    requestArguments = [hostname stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self request:@"host"];
    return results;
}

#pragma mark -
#pragma mark Miscellaneous Search Methods
#pragma mark -

- (NSDictionary *)count:(NSString *)query {
    requestArguments = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self request:@"count"];
    return results;
}

- (NSDictionary *)info {
    [self request:@"info"];
    return results;
}

- (NSDictionary *)locations:(NSString *)query {
    requestArguments = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self request:@"locations"];
    return results;
}

#pragma mark -
#pragma mark Search Methods
#pragma mark -

- (NSDictionary *)search:(NSString *)query page:(int)pageNumber limit:(int)perPage offset:(int)pageOffset {
    query = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];

    requestArguments = [query stringByAppendingString:[NSString stringWithFormat:@"&p=%i&l=%i&o=%i",pageNumber,perPage,pageOffset]];
    [self request:@"search"];
    return results;
}

- (NSDictionary *)search:(NSString *)query {
    [self search:query page:1 limit:100 offset:0];
    return results;
}

- (NSDictionary *)search:(NSString *)query page:(int)pageNumber {
    [self search:query page:pageNumber limit:100 offset:0];
    return results;
}

- (NSDictionary *)search:(NSString *)query page:(int)pageNumber limit:(int)perPage {
    [self search:query page:pageNumber limit:perPage offset:0];
    return results;
}

@end
