//
//  Photo.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "Photo.h"

@implementation Photo
    - (instancetype)initWithJSONDict:(NSDictionary *)jsonDict {
        if (self = [super init]) {
            self.albumID = [NSString stringWithFormat:@"%@", jsonDict[@"albumId"]];
            self.identifier = [NSString stringWithFormat:@"%@", jsonDict[@"id"]];
            self.thumbnailUrl = [NSString stringWithFormat:@"%@", jsonDict[@"thumbnailUrl"]];
            self.title = [NSString stringWithFormat:@"%@", jsonDict[@"title"]];
            self.urlString = [NSString stringWithFormat:@"%@", jsonDict[@"url"]];
        }
        return self;
    }
@end
