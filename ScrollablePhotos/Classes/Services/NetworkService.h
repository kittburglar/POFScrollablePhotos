//
//  NetworkService.h
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkService : NSObject <NSURLConnectionDelegate>
    + (instancetype)sharedInstance;
    - (void)requestWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) completionHandler;
@end

NS_ASSUME_NONNULL_END
