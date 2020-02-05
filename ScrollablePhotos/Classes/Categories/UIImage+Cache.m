//
//  UIImage+Cache.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-02-05.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "UIImage+Cache.h"

@implementation UIImage (Cache)
- (void)saveToDisk:(NSString *)fileName {
    // Create path.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];

    // Save image.
    [UIImagePNGRepresentation(self) writeToFile:filePath atomically:YES];
}



//- (UIImage *)getImageFromCache:(NSString *)fileName {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
//    NSError *err = nil;
//    NSData *data = [NSData dataWithContentsOfFile:filePath
//                                        options:NSDataReadingUncached
//                                          error:&err];
//    return [UIImage imageWithData:data];
//}

@end
