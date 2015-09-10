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

NSString * const reuseIdentifier = @"ARPhotoPickerAssetCell";
NSString * const footerReuseIdemtifier = @"ARPhotoPickerAssetsFooterView";

NSString * const ARPhotoPickerAssetsControllerDismissNotification = @"ARPhotoPickerAssetsControllerDismissNotification";
NSString * const ARPhotoPickerAssetsControllerSelectAssetNotification = @"ARPhotoPickerAssetsControllerSelectAssetNotification";

@interface ARPhotoPickerAssetsController ()

@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) PHAssetCollection *assetsCollection;
@property (nonatomic, strong) PHFetchResult *fetchResult;

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
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelItemClicked:)];
    [self.navigationItem setRightBarButtonItem:cancelItem];
    
    UIToolbar *bottomBar = [[UIToolbar alloc] init];
    bottomBar.barTintColor = [UIColor colorWithWhite:244/255.0 alpha:1];
    [self.view addSubview:bottomBar];
    
    UIBarButtonItem *previewItem = [[UIBarButtonItem alloc] initWithTitle:@"preview" style:UIBarButtonItemStylePlain target:self action:@selector(previewItemClicked:)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithTitle:@"send" style:UIBarButtonItemStylePlain target:self action:@selector(sendItemClicked:)];
    
    [bottomBar setItems:@[previewItem,flexItem,sendItem]];
    
    bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomBar
                                                         attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.view
                                                         attribute:NSLayoutAttributeLeft
                                                        multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomBar
                                                          attribute:NSLayoutAttributeRight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeRight
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomBar
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:0]];
    [bottomBar addConstraint:[NSLayoutConstraint constraintWithItem:bottomBar
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:44]];
}

#pragma mark - custom event methods

- (void)cancelItemClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:ARPhotoPickerAssetsControllerDismissNotification object:nil];
    }];
}

- (void)previewItemClicked:(id)sender {

}

- (void)sendItemClicked:(id)sender {

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
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:ARPhotoPickerAssetsControllerSelectAssetNotification object:asset];
}

@end
