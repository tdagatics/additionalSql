//
//  HomeModel.m
//  additionalSql
//
//  Created by Anthony Dagati on 10/29/14.
//  Copyright (c) 2014 Black Rail Capital. All rights reserved.
//

#import "HomeModel.h"
#import "Location.h"

@interface HomeModel()
{
    NSMutableData *_downloadedData;
}

@end


@implementation HomeModel

-(void)downloadItems
{
    // Download the json file
    NSURL *jsonFileURL = [NSURL URLWithString:@"http://gtvinyl.com/service.php"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileURL];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_locations = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through the Json objects, create question objects and add them to our questions array
    
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its proprs to JsonElement properties
        Location *newLocation = [[Location alloc] init];
        newLocation.name = jsonElement[@"Name"];
        newLocation.address = jsonElement[@"Address"];
        newLocation.latitude = jsonElement[@"Latitude"];
        newLocation.longitude = jsonElement[@"Longitude"];
        
        // Add this question to the locations array
        [_locations addObject:newLocation];
    }
    
    // Ready to notidy delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_locations];
    }
    
}













































@end
