//
//  Photo.h
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject
    @property (nonatomic, copy) NSString *albumID;
    @property (nonatomic, copy) NSString *identifier;
    @property (nonatomic, copy) NSString *thumbnailUrl;
    @property (nonatomic, copy) NSString *title;
    @property (nonatomic, copy) NSString *urlString;

    - (instancetype)initWithJSONDict:(NSDictionary *)jsonDict;
@end

NS_ASSUME_NONNULL_END
