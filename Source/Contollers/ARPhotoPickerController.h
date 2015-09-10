//
//  ARPhotoPickerController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const ARPhotoPickerAssetsControllerDismissNotification;
FOUNDATION_EXTERN NSString * const ARPhotoPickerAssetsControllerSelectAssetNotification;

@protocol ARPhotoPickerControllerDelegate;

@class PHAsset;
@interface ARPhotoPickerController : UINavigationController

@property (nonatomic, assign) BOOL autoPushToUserPhotoLibrary;// default is YES
@property (nonatomic, assign) BOOL allowsMultipleSelection; // default is YES
@property (nonatomic, weak) id<UINavigationControllerDelegate,ARPhotoPickerControllerDelegate> delegate;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end


@protocol ARPhotoPickerControllerDelegate <NSObject>

@required
- (void)photoPickerControllerDidCancel:(ARPhotoPickerController *)picker;
- (void)photoPickerController:(ARPhotoPickerController *)picker didPickingMediaWithAsset:(PHAsset *)asset;
- (void)photoPickerController:(ARPhotoPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;

@end