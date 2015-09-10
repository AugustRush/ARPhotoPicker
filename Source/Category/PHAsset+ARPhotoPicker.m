//
//  PHAsset+ARPhotoPicker.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/10.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "PHAsset+ARPhotoPicker.h"

@implementation PHAsset (ARPhotoPicker)

- (void)requestOriginalImageCompletion:(void (^)(UIImage *, NSDictionary *))completion {
    [self requestImageWithSize:PHImageManagerMaximumSize completion:completion];
}

- (void)requestImageWithSize:(CGSize)size completion:(void (^)(UIImage *, NSDictionary *))completion {
    [[PHImageManager defaultManager] requestImageForAsset:self
                                               targetSize:size
                                              contentMode:PHImageContentModeDefault
                                                  options:nil
                                            resultHandler:^(UIImage *result, NSDictionary *info) {
                                                if (completion) {
                                                    completion(result,info);
                                                }
                                            }];
}

@end
