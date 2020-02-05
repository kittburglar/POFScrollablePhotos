//
//  ImageManager.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "ImageManager.h"
#import "NetworkService.h"

static NSString *const kBaseURL = @"http://jsonplaceholder.typicode.com";

@implementation ImageManager

+ (instancetype)sharedInstance {
    static ImageManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    if (self = [super init]) {
        self.photos = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addPhoto:(Photo *)photo {
    [self.photos addObject:photo];
}

- (void)downloadPhotoWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL: url];
        if ( data == nil )
            return;
        dispatch_async(dispatch_get_main_queue(), ^{
            // WARNING: is the cell still using the same data by this point??
//            cell.image = [UIImage imageWithData: data];
            
            //Cache images;
            
        });
    });
}

//Randomizing the list
- (void)reorder:(NSInteger)shuffleCount {
    if (!shuffleCount) {
        return;
    }
    NSInteger randomInteger = arc4random_uniform((int)[[self photos] count]);
    Photo *photo = [self.photos objectAtIndex:randomInteger];
    [self.photos removeObjectAtIndex:randomInteger];

    randomInteger = arc4random_uniform((int)[[self photos] count]);
    [self.photos insertObject:photo atIndex:randomInteger];

    return [self reorder:shuffleCount-1];
}

// Removing items from list with title match
- (NSArray *)removeTitlesWithString:(NSArray *)removeStrings {
    NSMutableArray *retVal = [NSMutableArray array];

    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < [[self photos] count]; i++) {
        Photo *photo = [[self photos] objectAtIndex:i];
        for (NSString *removeStr in removeStrings) {
            if ([[photo title] containsString:removeStr]) {
                [indexSet addIndex:i];
                [retVal addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                break;
            }
        }
    }

    NSLog(@"Number of photos before removal: %lu", (unsigned long)[[self photos] count]);
    [[self photos] removeObjectsAtIndexes:indexSet];
    NSLog(@"Number of photos after removal: %lu", (unsigned long)[[self photos] count]);

    return [retVal copy];
}

@end
