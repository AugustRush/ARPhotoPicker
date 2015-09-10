//
//  ViewController.m
//  ARPhotoPickerExample
//
//  Created by August on 15/9/9.
//  Copyright (c) 2015年 August. All rights reserved.
//

#import "ViewController.h"
#import "ARPhotoPicker.h"

@interface ViewController ()<ARPhotoPickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)presentButtonClicked:(id)sender {
    
    ARPhotoPickerController *picker = [[ARPhotoPickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)photoPickerControllerDidCancel:(ARPhotoPickerController *)picker {
    NSLog(@"picker did cancel is %@",picker);
}

- (void)photoPickerController:(ARPhotoPickerController *)picker didPickingMediaWithAsset:(PHAsset *)asset {
    [asset requestOriginalImageCompletion:^(UIImage *image, NSDictionary *info) {
        self.imageView.image = image;
        NSLog(@"info is %@",info);
    }];
}

- (void)photoPickerController:(ARPhotoPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSLog(@"finish media info is %@", info);
}

@end
