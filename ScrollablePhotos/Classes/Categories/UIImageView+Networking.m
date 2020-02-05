//
//  UIImageView+Networking.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-02-04.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "UIImageView+Networking.h"

@implementation UIImageView (Networking)

-(void)fetchImageFromURL:(NSURL *)url cacheWithFileName:(NSString *)fileName {
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error Fetching Image From URL" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *acceptAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:acceptAction];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
            });
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = [UIImage imageWithData:data];
            [self saveToDiskWithFilename:fileName];
        });
    }] resume];
}

- (void)saveToDiskWithFilename:(NSString *)fileName {
    // Create path.
    NSError *err = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:fileName];
    
    // Save image.
    NSLog(@"Saving image with named: %@ at filePath: %@", fileName, filePath);
    [UIImagePNGRepresentation(self.image) writeToFile:filePath atomically:YES];
}

@end
