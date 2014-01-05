# ECShodanClient
## TODO: Add a link to documentation

To visit the official Shodan API documentation go here:

[http://docs.shodanhq.com](http://docs.shodanhq.com)

## Usage

Before you can use this Objective-C library to connect to the SHODAN API, you need to have an API key [from SHODAN](http://www.shodanhq.com/api_doc).

Create and initialize an instance of the WebAPI class:

```objective-c
#import "ECShodanClient.h"

WebAPI* api = [[ECShodanClient alloc] initWithAPIKey:@"Your API Key"];
```

Print a list of cisco-ios devices:

```objective-c
NSDictionary* result = [api search:@"cisco"];
int i = 0;
for (id __strong host in [result objectForKey:@"matches"]) {
    host = [[result objectForKey:@"matches"] objectAtIndex:i];
    i++;
    NSLog(@"%@", [host objectForKey:@"ip"]);
}
```

Grab all information SHODAN has on a specific ip (4.59.125.121):

```objective-c
NSDictionary* host = [api host:@"4.59.125.121"];
NSLog(@"%@", host);
```
