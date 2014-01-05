//
//  ECShodanClient.h
//

#import <Foundation/Foundation.h>

@interface ECShodanClient : NSObject

@property (strong, nonatomic) NSString* apiKey;
@property (strong, nonatomic) NSString* baseURL;
@property (strong, nonatomic) NSString* requestArguments;
@property (strong, nonatomic) NSDictionary* results;
@property (strong, nonatomic) NSDictionary* requestParams;

-(id)initWithAPIKey:(NSString*)key;

-(void)setAPIKey:(NSString*)key;

-(void)request:(NSString*)function;

-(NSDictionary*)info;
-(NSDictionary*)host:(NSString*)hostname;
-(NSDictionary*)locations:(NSString*)query;
-(NSDictionary*)search:(NSString*)query;
-(NSDictionary*)search:(NSString*)query page:(int)pageNumber;
-(NSDictionary*)search:(NSString*)query page:(int)pageNumber limit:(int)perPage;
-(NSDictionary*)search:(NSString*)query page:(int)pageNumber limit:(int)perPage offset:(int)pageOffset;

@end
