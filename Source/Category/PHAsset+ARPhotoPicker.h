//
//  PHAsset+ARPhotoPicker.h
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (ARPhotoPicker)

- (void)requestOriginalImageCompletion:(void(^)(UIImage *image, NSDictionary *info))completion;
- (void)requestImageWithSize:(CGSize)size completion:(void(^)(UIImage *image, NSDictionary *info))completion;

@end
