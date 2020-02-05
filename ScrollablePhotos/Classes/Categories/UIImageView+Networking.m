//
//  UIImageView+Networking.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-02-04.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "UIImageView+Networking.h"

@implementation UIImageView (Networking)

-(void)fetchImageFromURL:(NSURL *)url {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = [UIImage imageWithData:data];
        });
    }] resume];
}

@end
