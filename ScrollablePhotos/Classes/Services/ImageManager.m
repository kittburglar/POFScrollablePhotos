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

// Randomizing the list of photos
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

// Removing photos from list that match the title
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

// Gets image from cache if it exists
- (UIImage *)getImageFromCacheWithFilename:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    NSError *err = nil;
    NSData *data = [NSData dataWithContentsOfFile:filePath
                                        options:NSDataReadingUncached
                                          error:&err];

    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"Getting image with named: %@ at filePath: %@ ... %@", fileName, filePath, image ? @"Success! File exists in cache!" : @"File doesn't exist in cache yet!");
    return image;
}

@end
