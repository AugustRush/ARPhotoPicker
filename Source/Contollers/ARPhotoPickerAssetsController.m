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
#import "ARPhotoPickerMacros.h"
#import "ARPhotoPickerAssetsToolBar.h"
#import "ARPhotoPickerPreviewController.h"
#import <EasyLayout.h>

NSString * const reuseIdentifier = @"ARPhotoPickerAssetCell";
NSString * const footerReuseIdemtifier = @"ARPhotoPickerAssetsFooterView";

NSString * const ARPhotoPickerAssetsControllerDismissNotification = @"ARPhotoPickerAssetsControllerDismissNotification";
NSString * const ARPhotoPickerAssetsControllerSelectAssetNotification = @"ARPhotoPickerAssetsControllerSelectAssetNotification";

@interface ARPhotoPickerAssetsController ()

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) PHAssetCollection *assetsCollection;
@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) ARPhotoPickerAssetsToolBar *bottomBar;

@end

@implementation ARPhotoPickerAssetsController

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
        _canSelectPhotosMaxCount = 9;
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
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 50, 0);
    
    [self.collectionView registerNib:[UINib nibWithNibName:reuseIdentifier bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:footerReuseIdemtifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerReuseIdemtifier];
    
    _bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"ARPhotoPickerAssetsToolBar" owner:nil options:nil] lastObject];
    [_bottomBar.leftButton setTitle:ARPPLocalString(@"preview") forState:UIControlStateNormal];
    [_bottomBar.rightButton setTitle:ARPPLocalString(@"send") forState:UIControlStateNormal];
    [_bottomBar.leftButton addTarget:self action:@selector(previewItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBar.rightButton addTarget:self action:@selector(sendItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_bottomBar];
    
    //layout
    [_bottomBar makeConstraints:^(ELConstraintsMaker *make) {
        make.combination(@[ELCLeft,ELCRight,ELCBottom])
            .equalTo(@0);
        make.ELHeight.equalTo(@44);
        make.ELWidth.greaterThanOrEqualTo(@60);
    }];
    [_bottomBar setNumber:0];
}

#pragma mark - custom event methods

- (void)cancelItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ARPhotoPickerAssetsControllerDismissNotification object:nil];
    }];
}

- (void)previewItemClicked:(id)sender {
    
    NSMutableArray *assets = [NSMutableArray array];
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL *stop) {
        if (obj.row - 1 < self.fetchResult.count) {
            PHAsset *asset = [self.fetchResult objectAtIndex:obj.row - 1];
            [assets addObject:asset];
        }
    }];
    
    ARPhotoPickerPreviewController *previewController = [[ARPhotoPickerPreviewController alloc] initWithAssets:assets];
    [self.navigationController showViewController:previewController sender:self];
}

- (void)sendItemClicked:(id)sender {

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ARPhotoPickerAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"camera_shot"];
        cell.checkmarkImageView.hidden = YES;
    }else{
        PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row - 1];
        [cell configurationWithAsset:asset showCheckmark:self.collectionView.allowsMultipleSelection];
    }
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
    if (indexPath.row > 0) {
        
        NSUInteger hasSelectCount = [[self.collectionView indexPathsForSelectedItems] count];
        if (hasSelectCount > self.canSelectPhotosMaxCount) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }else{
            [self.bottomBar setNumber:hasSelectCount];
            PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row - 1];
            [[NSNotificationCenter defaultCenter] postNotificationName:ARPhotoPickerAssetsControllerSelectAssetNotification object:asset];
        }
    }else{
    //take photo
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger hasSelectCount = [[self.collectionView indexPathsForSelectedItems] count];
    [self.bottomBar setNumber:hasSelectCount];
}

@end
