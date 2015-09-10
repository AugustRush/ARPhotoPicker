//
//  ARPhotoPickerAssetsController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;

@interface ARPhotoPickerAssetsController : UICollectionViewController

@property (nonatomic, assign) BOOL allowsMultipleSelection; // default is YES

- (instancetype)initWithAssetsCollection:(PHAssetCollection *)collection NS_DESIGNATED_INITIALIZER;

@end
