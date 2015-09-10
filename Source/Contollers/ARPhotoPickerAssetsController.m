//
//  ARPhotoPickerAssetsController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ARPhotoPickerAssetsController.h"
#import "ARPhotoPickerAssetCell.h"
#import "ARPhotoPickerAssetsFooterView.h"
#import <Photos/Photos.h>

@interface ARPhotoPickerAssetsController ()

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) PHAssetCollection *assetsCollection;
@property (nonatomic, strong) PHFetchResult *fetchResult;

@end

@implementation ARPhotoPickerAssetsController

static NSString * const reuseIdentifier = @"ARPhotoPickerAssetCell";
static NSString * const footerReuseIdemtifier = @"ARPhotoPickerAssetsFooterView";

#pragma mark - lifeCycle methods

- (instancetype)initWithAssetsCollection:(PHAssetCollection *)collection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat mainScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    CGFloat width = mainScreenWidth / 4.0 - 1;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = 1;
    layout.footerReferenceSize = CGSizeMake(mainScreenWidth, 44);
    self = [super initWithCollectionViewLayout:layout];
    if (self) {
        _flowLayout = layout;
        _assetsCollection = collection;
        _allowsMultipleSelection = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setUp];
}

- (void)dealloc {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methdos

- (void)_setUp {

    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    // predicate
    fetchOptions.predicate = [NSPredicate predicateWithFormat: @"mediaType == %d", PHAssetMediaTypeImage];
    // sortDescriptors
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    self.fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetsCollection options:fetchOptions];
    
    self.collectionView.allowsMultipleSelection = self.allowsMultipleSelection;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
    
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:footerReuseIdemtifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdemtifier];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClicked:)];
    [self.navigationItem setRightBarButtonItem:cancelItem];
}

#pragma mark - custom event methods

- (void)cancelItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ARPhotoPickerAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    [cell configurationWithAsset:asset showCheckmark:self.collectionView.allowsMultipleSelection];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        ARPhotoPickerAssetsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerReuseIdemtifier forIndexPath:indexPath];
        [footerView configurationWithAssetsResult:self.fetchResult];
        return footerView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
