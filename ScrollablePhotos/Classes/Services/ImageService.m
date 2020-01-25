//
//  ImageService.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "ImageService.h"

static NSString *const kBaseURL = @"http://jsonplaceholder.typicode.com";

@implementation ImageService

+ (instancetype)sharedInstance {
    static ImageService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

@end
