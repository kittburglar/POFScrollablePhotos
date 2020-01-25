//
//  ViewController.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "ImageService.h"
#import "Photo.h"

static NSString *const kBaseURL = @"http://jsonplaceholder.typicode.com";
static NSString *const kPhotoPath = @"photos";

@interface ViewController ()
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NetworkService sharedInstance] requestWithURL:[NSString stringWithFormat:@"%@/%@", kBaseURL, kPhotoPath] completionHandler:^(NSData * _Nonnull data, NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
        NSArray *photoArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"Array is: %@", photoArray);
        for (NSDictionary *photoDict in photoArray) {
            Photo *photo = [[Photo alloc] initWithJSONDict:photoDict];
            NSLog(@"Photo is: %@", photo);
        }
    }];
}


@end
