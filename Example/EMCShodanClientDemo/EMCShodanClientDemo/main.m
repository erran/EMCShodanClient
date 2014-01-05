//
//  main.m
//  EMCShodanClientDemo
//
//  Created by Erran Carey on 1/5/14.
//  Copyright (c) 2014 Erran Carey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCShodanClient.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *apiKey = [[[NSProcessInfo processInfo] environment] objectForKey:@"SHODAN_API_KEY"];

        EMCShodanClient *client = [[EMCShodanClient alloc] initWithAPIKey:apiKey];

        NSLog(@"client info: %@", [client info]);

/*
        NSDictionary* result = [client search:@"cisco" page:0 limit:100];

        int i = 0;
        for (id __strong host in [result objectForKey:@"matches"]) {
            host = [[result objectForKey:@"matches"] objectAtIndex:i];
            i++;
            NSLog(@"%@",[host objectForKey:@"ip"]);
        }
*/

        // Subsequent requests should all fail given a bad API key
        client.apiKey = @"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
        NSLog(@"failed client info: %@", [client info]);
    }
    return 0;
}
