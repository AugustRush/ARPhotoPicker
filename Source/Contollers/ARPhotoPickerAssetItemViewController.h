//
//  ARPhotoPickerAssetItemViewController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/11.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAsset;

@interface ARPhotoPickerAssetItemViewController : UIViewController

@property (nonatomic, strong, readonly) PHAsset *asset;

- (instancetype)initWithAsset:(PHAsset *)asset;

@end
