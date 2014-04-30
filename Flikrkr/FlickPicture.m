//
//  FlickPicture.m
//  Flikrkr
//
//  Created by etudiant on 30/04/2014.
//  Copyright (c) 2014 Oui. All rights reserved.
//

#import "FlickPicture.h"

#define kFlickrAPIKey @"045f3e02082b7820ff89bb17c38f1e5d"

@implementation FlickPicture

- (NSURL *)url
{
    NSString * urlString = [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@.jpg", self.farm.intValue, self.server, self.pictureId, self.secret];
    return [NSURL URLWithString:urlString];
}

+ (NSArray *)picturesAroundLocation:(FlickLocation)location
{
    NSString * urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%f&lon=%f&radius=%i&format=json&nojsoncallback=1",kFlickrAPIKey, location.latitude, location.longitude, location.radius];
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray * pictures = [NSMutableArray arrayWithCapacity:[jsonData[@"photos"][@"photo"] count]];
    for (NSDictionary * currentPicture in jsonData[@"photos"][@"photo"]) {
        FlickPicture * picture = [[FlickPicture alloc] init];
        picture.pictureId = currentPicture[@"id"];
        picture.server = currentPicture[@"server"];
        picture.secret = currentPicture[@"secret"];
        picture.farm = currentPicture[@"farm"];
        picture.title = currentPicture[@"title"];
        
        [pictures addObject:picture];
    }
    return [NSArray arrayWithArray:pictures];
}
@end
