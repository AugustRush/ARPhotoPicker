//
//  ARPhotoPickerController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@protocol ARPhotoPickerGroupControllerDelegate;

@interface ARPhotoPickerGroupController : UITableViewController

@property (nonatomic, weak) id<ARPhotoPickerGroupControllerDelegate> delegate;
@property (nonatomic, assign) BOOL autoPushToUserPhotoLibrary; //will directly push to user's photos library
@property (nonatomic, assign) PHAssetCollectionType collectionType;
@property (nonatomic, assign) PHAssetCollectionSubtype collectionSubType;

@end


@protocol ARPhotoPickerGroupControllerDelegate <NSObject>

- (void)photoPickerGroupControllerDidCancel:(ARPhotoPickerGroupController *)controller;

@end