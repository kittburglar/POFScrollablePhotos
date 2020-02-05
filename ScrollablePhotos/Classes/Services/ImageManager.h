//
//  ImageManager.h
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageManager : NSObject
    @property (nonatomic, strong) NSMutableArray *photos;

    + (instancetype)sharedInstance;
    - (void)addPhoto:(Photo *)photo;
    - (void)reorder:(NSInteger)shuffleCount;
    - (NSArray *)removeTitlesWithString:(NSArray *)removeStrings;
    - (UIImage *)getImageFromCacheWithFilename:(NSString *)fileName;
@end

NS_ASSUME_NONNULL_END
