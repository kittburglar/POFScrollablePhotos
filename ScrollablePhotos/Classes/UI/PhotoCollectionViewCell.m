//
//  PhotoCollectionViewCell.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.transform = CGAffineTransformMakeRotation(M_PI / 4);

    self.baseView.backgroundColor = [UIColor clearColor];
    self.baseView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.baseView.layer.shadowOffset = CGSizeMake(3, 3);

    self.borderView.layer.cornerRadius = 10.0f;
    self.borderView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.borderView.layer.borderWidth = 5.0f;
    self.borderView.layer.masksToBounds = YES;
}

@end
