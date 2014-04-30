//
//  FlickPicture.h
//  Flikrkr
//
//  Created by etudiant on 30/04/2014.
//  Copyright (c) 2014 Oui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct
{
    double latitude;
    double longitude;
    int radius;
}FlickLocation;

@interface FlickPicture : NSObject
@property (strong, nonatomic) NSString * pictureId;
@property (strong, nonatomic) NSNumber * farm;
@property (strong, nonatomic) NSString * server;
@property (strong, nonatomic) NSString * secret;
@property (strong, nonatomic) NSString * title;

- (NSURL*) url;

+ (NSArray*) picturesAroundLocation:(FlickLocation) location;
@end
