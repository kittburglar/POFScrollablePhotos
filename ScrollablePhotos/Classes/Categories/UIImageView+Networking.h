//
//  UIImageView+Networking.h
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-02-04.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Networking)
-(void)fetchImageFromURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
