//
//  ViewController.m
//  phono
//
//  Created by Junyu Wang on 1/22/16.
//  Copyright © 2016 junyuwang. All rights reserved.
//

#import "ViewController.h"
#import <evernote-cloud-sdk-ios/ENSDK.h>
#import <HTPressableButton/HTPressableButton.h>
#import <ChameleonFramework/Chameleon.h>

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect cameraButtonFrame = CGRectMake(self.view.center.x - 75, self.view.center.y - 75, 150, 150);
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:cameraButtonFrame];
    
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_button"] forState:UIControlStateNormal];
    cameraButton.layer.cornerRadius = 150/2.0f;
    
    [cameraButton addTarget:self
                     action:@selector(cameraButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:cameraButton];
    [self.view setBackgroundColor:FlatWhite];
}


- (void)cameraButtonPressed {
    UIAlertController *choiceAlert = [UIAlertController alertControllerWithTitle:@"Action"
                                                                         message:@"Please choose one of the following"
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *chooseFromCameraRollAction = [UIAlertAction actionWithTitle:@"Choose from camera roll"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            //open image picker
                                                            NSLog(@"choose from camera");
                                                        }];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take a photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                //segue to the camera view
                                                                NSLog(@"take a photo");
                                                                [self performSegueWithIdentifier:@"view_to_camera_view_segue"
                                                                                          sender:self];
                                                            }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             //cancel selection
                                                             [self dismissViewControllerAnimated:YES
                                                                                      completion:nil];
                                                         }];
    [choiceAlert addAction:chooseFromCameraRollAction];
    [choiceAlert addAction:takePhotoAction];
    [choiceAlert addAction:cancelAction];
    
    [self presentViewController:choiceAlert
                       animated:YES
                     completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
