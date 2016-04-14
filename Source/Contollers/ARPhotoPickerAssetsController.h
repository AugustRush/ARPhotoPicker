//
//  ARPhotoPickerAssetsController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const ARPhotoPickerAssetsControllerDismissNotification;
FOUNDATION_EXPORT NSString * const ARPhotoPickerAssetsControllerSelectAssetNotification;

@class PHAssetCollection;

@interface ARPhotoPickerAssetsController : UICollectionViewController

@property (nonatomic, assign) BOOL allowsMultipleSelection; // default is YES
@property (nonatomic, assign) NSUInteger canSelectPhotosMaxCount; // default is 9

- (instancetype)initWithAssetsCollection:(PHAssetCollection *)collection NS_DESIGNATED_INITIALIZER;

// depecated
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
