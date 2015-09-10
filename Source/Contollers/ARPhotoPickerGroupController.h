//
//  ARPhotoPickerController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ARPhotoPickerGroupController : UITableViewController

@property (nonatomic, assign) PHAssetCollectionType collectionType;
@property (nonatomic, assign) PHAssetCollectionSubtype collectionSubType;

@end
