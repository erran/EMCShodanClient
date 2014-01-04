//
//  ECShodanClient.m
//
//  Created by Erran Carey on 6/2/12.
//

#import "api.h"

/**
 A ECShodanClient object interfaces with the ShodanHQ site.
 */
@implementation ECShodanClient

@synthesize api_key;
@synthesize args;
@synthesize base_url;
@synthesize result;
@synthesize params;

/**
 @param apikey The API key to initalize the API object with.
 @returns self
 */
-(id)init_with_api_key:(NSString*)apikey
{
	if (self = [super init]){
		api_key = [apikey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		base_url = @"http://www.shodanhq.com/api/";
	}
	return self;
}

/**
 @param apikey The API key to initalize the API object with.
 */
-(void)set_api_key:(NSString*)apikey
{
	api_key = apikey;
}

/**
 Sends a request to ShodanHQ based on the function.

 @param function The type of request to send to ShodanHQ.
 */
-(void)request:(NSString*)function
{
	params = [NSMutableDictionary dictionaryWithObjectsAndKeys:base_url,@"base_url",[function stringByAppendingFormat:@"?"],@"function",[NSString stringWithFormat:@"key=%@",api_key],@"api_key",nil];
	NSURL* url = nil;
	NSString* url_string = @"";

#ifdef TARGET_OS_IPHONE
	url_string = [url_string stringByAppendingFormat:@"%@",base_url];
	url_string = [url_string stringByAppendingFormat:@"%@",[function stringByAppendingFormat:@"?"]];
	url_string = [url_string stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"key=%@",api_key]];
#else
	for (id key in params){
		url_string = [url_string stringByAppendingFormat:@"%@",[params objectForKey:key]];
	}
#endif
	
	if ([function isEqualToString:@"count"]) {
		url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&q=%@",args]];
	}
	else if ([function isEqualToString:@"host"]) {
		url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&ip=%@",args]];
	}
	else if ([function isEqualToString:@"info"]) {
		url = [NSURL URLWithString:url_string];
	}
	else if ([function isEqualToString:@"locations"]) {
		url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&q=%@",args]];
	}
	else if ([function isEqualToString:@"search"]) {
		url = [NSURL URLWithString:[url_string stringByAppendingFormat:@"&q=%@",args]];
	}
	
	NSError* error;
	NSData* searchResults = [NSData dataWithContentsOfURL:url];
	if(!searchResults){
		result = nil;
	}
	else{
		result = [NSJSONSerialization JSONObjectWithData:searchResults options:kNilOptions error:&error];
	}
}

/**
 Retrieves the count of results for a given query.

 [todo] - Fix the @returns value.

 @param query The query to request a count for.
 @returns A NSDictionary with the count as the first value.
 */
-(NSDictionary*)count:(NSString*)query
{
	args = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self request:@"count"];
	return result;
}

/**
 Get all the available information on a host in the SHODAN database

 @param ip The ip of a host to lookup.
 @returns A NSDictionary with the keys: "ip", "longitude", "latitude", "hostnames", "country_code", "country", "country_name", and "data".
 */
-(NSDictionary*)host:(NSString*)ip
{
	args = [ip stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self request:@"host"];
	return result;
}

/**
 View the current API key's plan, add-ons, and credits.

 @returns A NSDictionary with the keys: "unlocked_left", "telnet", "plan", "https", and "unlocked".
 */
-(NSDictionary*)info
{
	[self request:@"info"];
	return result;
}

/**
 Return a list of the countries and cities found for a given search query.

 @param query The query to retrieve location information for.
 @returns A NSDictionary with the keys: "cities" and "countries".
 */
-(NSDictionary*)locations:(NSString*)query
{
	args = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self request:@"locations"];
	return result;
}

/** @name Search methods */

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param page The page number for results.
 @param limit The results to display per page.
 @param offset The result number to begin searching from.
 @returns A NSDictionary with the keys: "cities", "countries", "matches", and "total".
 */
-(NSDictionary*)search:(NSString*)query page:(int)page limit:(int)limit offset:(int)offset
{
	query = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	
	args = [query stringByAppendingString:[NSString stringWithFormat:@"&p=%i&l=%i&o=%i",p,l,o]];
	[self request:@"search"];
	return result;
}

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @see method search:page:limit:offset:
 @returns A NSDictionary (NSJSONSerialization) of the result.
 */
-(NSDictionary*)search:(NSString*)query
{
	[self search:query page:1 limit:100 offset:0];
	return result;
}

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param page The page number for results.
 @returns A NSDictionary (NSJSONSerialization) of the result.
 */
-(NSDictionary*)search:(NSString*)query page:(int)page
{
	[self search:query page:p limit:100 offset:0];
	return result;
}

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param page The page number for results.
 @param limit The results to display per page.
 @returns A NSDictionary (NSJSONSerialization) of the result.
 */
-(NSDictionary*)search:(NSString*)query page:(int)page limit:(int)limit
{
	[self search:query page:p limit:l offset:0];
	return result;
}

@end

