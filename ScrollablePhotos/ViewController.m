//
//  ViewController.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "ImageManager.h"
#import "Photo.h"

static NSString *const kBaseURL = @"http://jsonplaceholder.typicode.com";
static NSString *const kPhotoPath = @"photos";

@interface ViewController ()
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedFetchingPhotoInfo) name:@"kNotificationFinishedFetchingPhotoInfo" object:nil];
    
    [[NetworkService sharedInstance] requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kBaseURL, kPhotoPath]] completionHandler:^(NSData * _Nonnull data, NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
        NSArray *photoArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        for (NSDictionary *photoDict in photoArray) {
            Photo *photo = [[Photo alloc] initWithJSONDict:photoDict];
            [[ImageManager sharedInstance] addPhoto:photo];
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationFinishedFetchingPhotoInfo" object:nil];
    }];
}

- (void)finishedFetchingPhotoInfo {
    NSLog(@"finished fetching photo info %@", [[ImageManager sharedInstance] photos]);

    //download images?
}


@end
