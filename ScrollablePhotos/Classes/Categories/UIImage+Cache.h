//
//  UIImage+Cache.h
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-02-05.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Cache)
- (void)saveToDisk:(NSString *)fileName;
- (UIImage *)getImageFromCache:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
