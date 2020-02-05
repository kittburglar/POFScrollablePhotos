//
//  ViewController.m
//  ScrollablePhotos
//
//  Created by Kittiphong Xayasane on 2020-01-25.
//  Copyright © 2020 Kittiphong Xayasane. All rights reserved.
//

#import "ViewController.h"
#import "NetworkService.h"
#import "ImageManager.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "UIImageView+Networking.h"

static NSString *const kBaseURL = @"http://jsonplaceholder.typicode.com";
static NSString *const kPhotoPath = @"photos";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
    @property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
    @property (strong, nonatomic) IBOutlet UIButton *shuffleButton;

@end

@implementation ViewController

#pragma mark Initialization

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedFetchingPhotoInfo) name:@"kNotificationFinishedFetchingPhotoInfo" object:nil];
    
    [[NetworkService sharedInstance] requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kBaseURL, kPhotoPath]] completionHandler:^(NSData * _Nonnull data, NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
        NSArray *photoArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        for (NSDictionary *photoDict in photoArray) {
            Photo *photo = [[Photo alloc] initWithJSONDict:photoDict];
            [[ImageManager sharedInstance] addPhoto:photo];
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationFinishedFetchingPhotoInfo" object:nil];
    }];
}

- (void)setupCollectionView {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"PhotoCell"];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:layout];
}

- (void)finishedFetchingPhotoInfo {
    //download images?
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

#pragma mark UICollectionViewDelegate Methods

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Photo *photo = [[[ImageManager sharedInstance] photos] objectAtIndex:[indexPath row]];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [photo title]];
    
    // Lazy loading the imageview's image from image url
    UIImage *photoImage = [self getImageFromCacheWithFilename:[photo identifier]];
    if (photoImage) {
        cell.imageView.image = photoImage;
    } else {
        [cell.imageView fetchImageFromURL:[NSURL URLWithString:[photo urlString]] cacheWithFileName:[photo identifier]];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[ImageManager sharedInstance] photos] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}

#pragma mark ImageHelper

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


#pragma mark Buttons

- (IBAction)shuffleTapped:(UIButton *)sender {
    ImageManager *imageManager = [ImageManager sharedInstance];
    [imageManager reorder:[[imageManager photos] count]];
    [self.collectionView reloadData];
}

- (IBAction)removeTapped:(UIButton *)sender {
    [self.collectionView performBatchUpdates:^{
        NSArray *removedPhotosIndexPaths = [[ImageManager sharedInstance] removeTitlesWithString:@[@"b", @"d"]];
        [self.collectionView deleteItemsAtIndexPaths:removedPhotosIndexPaths];
    } completion:nil];
}

@end
