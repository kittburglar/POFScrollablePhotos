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

static NSString *const kBaseURL = @"http://jsonplaceholder.typicode.com";
static NSString *const kPhotoPath = @"photos";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
    @property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

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
    NSLog(@"finished fetching photo info %@", [[ImageManager sharedInstance] photos]);
//    [self.collectionView reloadData];
    //download images?
}

#pragma mark UICollectionViewDelegate Methods

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    Photo *photo = [[[ImageManager sharedInstance] photos] objectAtIndex:indexPath.row];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", photo.title];
//    cell.titleLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[[ImageManager sharedInstance] photos] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}

@end
