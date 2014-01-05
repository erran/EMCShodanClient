//
//  ECShodanClient.m
//

#import "api.h"

/**
 A ECShodanClient object interfaces with the ShodanHQ site.
 */
@implementation ECShodanClient

@synthesize apiKey;
@synthesize baseURL;
@synthesize requestArguments;
@synthesize results;
@synthesize requestParams;

/**
 @param key The API key to initalize the API object with.
 @returns self
 */
-(id)initWithAPIKey:(NSString*)key {
	if (self = [super init]) {
		apiKey = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
		baseURL = @"http://www.shodanhq.com/api/";
	}
	return self;
}

/**
 @param key The API key to initalize the API object with.
 */
-(void)setAPIKey:(NSString*)key {
	apiKey = key;
}

/**
 Sends a request to ShodanHQ based on the function.

 @param function The type of request to send to ShodanHQ.
 */
-(void)request:(NSString*)function {
	requestParams = [NSMutableDictionary dictionaryWithObjectsAndKeys:baseURL,@"baseURL",[function stringByAppendingFormat:@"?"],@"function",[NSString stringWithFormat:@"key=%@",apiKey],@"apiKey",nil];
	NSURL* url = nil;
	NSString* url_string = @"";

// [review] - in iOS 5 and OS X 10.7 the NSDictionary ordering was different for each platform
#ifdef TARGET_OS_IPHONE
	url_string = [url_string stringByAppendingFormat:@"%@",baseURL];
	url_string = [url_string stringByAppendingFormat:@"%@",[function stringByAppendingFormat:@"?"]];
	url_string = [url_string stringByAppendingFormat:@"%@",[NSString stringWithFormat:@"key=%@",apiKey]];
#else
	for (id key in requestParams){
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
	if(!searchResults){
		results = nil;
	}
	else{
		results = [NSJSONSerialization JSONObjectWithData:searchResults options:kNilOptions error:&error];
	}
}

/**
 Retrieves the count of results for a given query.

 [todo] - Fix the @returns value.

 @param query The query to request a count for.
 @returns A NSDictionary with the count as the first value.
 */
-(NSDictionary*)count:(NSString*)query {
	requestArguments = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self request:@"count"];
	return results;
}

/**
 Get all the available information on a host in the SHODAN database

 @param hostname The ip of a host to lookup.
 @returns A NSDictionary with the keys: "ip", "longitude", "latitude", "hostnames", "country_code", "country", "country_name", and "data".
 */
-(NSDictionary*)host:(NSString*)hostname
{
	requestArguments = [hostname stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self request:@"host"];
	return results;
}

/**
 View the current API key's plan, add-ons, and credits.

 @returns A NSDictionary with the keys: "unlocked_left", "telnet", "plan", "https", and "unlocked".
 */
-(NSDictionary*)info {
	[self request:@"info"];
	return results;
}

/**
 Return a list of the countries and cities found for a given search query.

 @param query The query to retrieve location information for.
 @returns A NSDictionary with the keys: "cities" and "countries".
 */
-(NSDictionary*)locations:(NSString*)query {
	requestArguments = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	[self request:@"locations"];
	return results;
}

/** @name Search methods */

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param pageNumber The page number for results.
 @param perPage The results to display per page.
 @param pageOffset The result number to begin searching from.
 @returns A NSDictionary with the keys: "cities", "countries", "matches", and "total".
 */
-(NSDictionary*)search:(NSString*)query page:(int)pageNumber limit:(int)perPage offset:(int)pageOffset {
	query = [query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	
	requestArguments = [query stringByAppendingString:[NSString stringWithFormat:@"&p=%i&l=%i&o=%i",pageNumber,perPage,pageOffset]];
	[self request:@"search"];
	return results;
}

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @see method search:page:limit:offset:
 @returns A NSDictionary (NSJSONSerialization) of the result.
 */
-(NSDictionary*)search:(NSString*)query {
	[self search:query page:1 limit:100 offset:0];
	return results;
}

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param pageNumber The page number for results.
 @returns A NSDictionary (NSJSONSerialization) of the result.
 */
-(NSDictionary*)search:(NSString*)query page:(int)pageNumber {
	[self search:query page:pageNumber limit:100 offset:0];
	return results;
}

/**
 Search the SHODAN database.

 @param query The query to search ShodanHQ for.
 @param pageNumber The page number for results.
 @param perPage The results to display per page.
 @returns A NSDictionary (NSJSONSerialization) of the result.
 */
-(NSDictionary*)search:(NSString*)query page:(int)pageNumber limit:(int)perPage {
	[self search:query page:pageNumber limit:perPage offset:0];
	return results;
}

@end
