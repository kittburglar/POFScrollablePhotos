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
    self.titleLabel.text = @"HELLO";
    self.titleLabel.transform = CGAffineTransformMakeRotation(M_PI / 4);
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(0, 5);
    self.imageView.layer.shadowOpacity = 1;
    self.imageView.layer.shadowRadius = 5.0;
}

@end
