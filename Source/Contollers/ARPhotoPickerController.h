//
//  ARPhotoPickerController.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ARPhotoPickerControllerDelegate;

@interface ARPhotoPickerController : UINavigationController

@property (nonatomic, assign) BOOL autoPushToUserPhotoLibrary;// default is YES
@property (nonatomic, weak) id<UINavigationControllerDelegate,ARPhotoPickerControllerDelegate> delegate;

- (instancetype)init NS_DESIGNATED_INITIALIZER;

@end


@protocol ARPhotoPickerControllerDelegate <NSObject>

@end