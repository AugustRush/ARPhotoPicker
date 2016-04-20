//
//  ARPhotoPickerAssetsController+ARPhotoPicker.m
//  ARPhotoPickerExample
//
//  Created by AugustRush on 4/20/16.
//  Copyright © 2016 August. All rights reserved.
//

#import "ARPhotoPickerAssetsController+ARPhotoPicker.h"
#import "ARPhotoPickerController.h"

@implementation ARPhotoPickerAssetsController (ARPhotoPicker)

- (ARPhotoPickerController *)photoPickerController {
    UINavigationController *controller = self.navigationController;
    if ([controller isKindOfClass:[ARPhotoPickerController class]]) {
        return (ARPhotoPickerController *)controller;
    }
    return nil;
}

@end
