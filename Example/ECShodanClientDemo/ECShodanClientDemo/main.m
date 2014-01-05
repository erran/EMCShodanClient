//
//  main.m
//  ECShodanClientDemo
//
//  Created by Erran Carey on 1/5/14.
//  Copyright (c) 2014 Erran Carey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECShodanClient.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *apiKey = [[[NSProcessInfo processInfo] environment] objectForKey:@"SHODAN_API_KEY"];

        ECShodanClient *client = [[ECShodanClient alloc] initWithAPIKey:apiKey];

        NSLog(@"client info: %@", [client info]);

        // Subsequent requests should all fail a bad API key
        client.apiKey = @"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        NSLog(@"failed client info: %@", [client info]);
    }
    return 0;
}