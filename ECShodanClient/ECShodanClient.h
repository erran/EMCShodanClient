//
//  ECShodanClient.h
//  Erran Carey
//
//  Created by Erran Carey on 1/4/14.
//  Copyright (c) 2012-2014 Erran Carey. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 A ECShodanClient object interfaces with the ShodanHQ site.
 */
@interface ECShodanClient : NSObject

/**
 The API key to use as the 'key' parameter.
 */
@property (strong, nonatomic) NSString *apiKey;

/**
 */
@property (strong, nonatomic) NSString *baseURL;

/**
 Stores the JSON results form the Shodan API.
 */
@property (strong, nonatomic) NSDictionary *results;

/**
 The request paremeters compiled as a query string.
 */
@property (strong, nonatomic) NSString *queryString;

/**
 A dictionary to store request parameters
 */
@property (strong, nonatomic) NSDictionary *requestParameters;

/**
 @param key The API key to initalize the API object with.
 @return ECShodanClient
 */
- (id)initWithAPIKey:(NSString *)key;

/**
 @param key The API key to initalize the API object with.
 */
- (void)setAPIKey:(NSString *)key;

/**
 Sends a request to ShodanHQ based on the function.

 @param function The type of request to send to ShodanHQ.
 */
- (void)request:(NSString *)function;

/**
 View the current API key's plan, add-ons, and credits.

 @return A NSDictionary with the keys: "unlocked_left", "telnet", "plan", "https", and "unlocked".
 */
- (NSDictionary *)info;

///-----------------------------------
/// @name Miscellaneous Search Methods
///-----------------------------------

/**
 Retrieves the count of results for a given query.

 [todo] - Fix the @return value.

 @param query The query to request a count for.
 @return A NSDictionary with the count as the first value.
 */
- (NSDictionary *)count:(NSString *)query;

/**
 Get all the available information on a host in the SHODAN database

 @param hostname The ip of a host to lookup.
 @return A NSDictionary with the keys: "ip", "longitude", "latitude", "hostnames", "country_code", "country", "country_name", and "data".
 */
- (NSDictionary *)host:(NSString *)hostname;

/**
 Return a list of the countries and cities found for a given search query.

 @param query The query to retrieve location information for.
 @return A NSDictionary with the keys: "cities" and "countries".
 */
- (NSDictionary *)locations:(NSString *)query;

///---------------------
/// @name Search Methods
///---------------------

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @return A NSDictionary with the keys: "cities", "countries", "matches", and "total".
 @see method search:page:limit:offset:
 */
- (NSDictionary *)search:(NSString *)query;

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param pageNumber The page number for results.
 @return A NSDictionary with the keys: "cities", "countries", "matches", and "total".
 @see method search:page:limit:offset:
 */
- (NSDictionary *)search:(NSString *)query
                    page:(int)pageNumber;

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param pageNumber The page number for results.
 @param perPage The results to display per page.
 @return A NSDictionary with the keys: "cities", "countries", "matches", and "total".
 @see method search:page:limit:offset:
 */
- (NSDictionary *)search:(NSString *)query
                    page:(int)pageNumber
                   limit:(int)perPage;

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param pageNumber The page number for results.
 @param perPage The results to display per page.
 @param pageOffset The result number to begin searching from.
 @return A NSDictionary with the keys: "cities", "countries", "matches", and "total".
 @see method search:page:limit:offset:
 */
- (NSDictionary *)search:(NSString *)query
                    page:(int)pageNumber
                   limit:(int)perPage
                  offset:(int)pageOffset;

@end
