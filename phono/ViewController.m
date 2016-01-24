//
//  ViewController.m
//  phono
//
//  Created by Junyu Wang on 1/22/16.
//  Copyright © 2016 junyuwang. All rights reserved.
//

#import "ViewController.h"
#import <evernote-cloud-sdk-ios/ENSDK.h>
#import <ChameleonFramework/Chameleon.h>
#import <TGCameraViewController/TGCameraViewController.h>
#import "ImageProcessViewController.h"


@interface ViewController ()


@end

@implementation ViewController

@synthesize photo;

#pragma mark - view controller lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"load first controller");
    
    // Do any additional setup after loading the view, typically from a nib.
    CGRect cameraButtonFrame = CGRectMake(self.view.center.x - 75, self.view.center.y - 75, 150, 150);
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:cameraButtonFrame];
    
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"camera_button"] forState:UIControlStateNormal];
    cameraButton.layer.cornerRadius = 150/2.0f;
    
    [cameraButton addTarget:self
                     action:@selector(cameraButtonPressed)
           forControlEvents:UIControlEventTouchUpInside];
    
    cameraButton.layer.borderWidth = 4.0;
    [cameraButton.layer setBorderColor:[FlatGray CGColor]];
    
    [self.view addSubview:cameraButton];
    [self.view setBackgroundColor:FlatWhite];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ImageProcessViewController *ipv = (ImageProcessViewController*) segue.destinationViewController;
    ipv.photoToProcess = photo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - outlets function

- (void)cameraButtonPressed {
    UIAlertController *choiceAlert = [UIAlertController alertControllerWithTitle:@"Action"
                                                                         message:@"Please choose one of the following"
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *chooseFromCameraRollAction = [UIAlertAction actionWithTitle:@"Choose from camera roll"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            //open image picker
                                                            NSLog(@"choose from camera");
                                                            [self chooseExistingPhotoTapped];
                                                        }];
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"Take a photo"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * _Nonnull action) {
                                                                //segue to the camera view
                                                                NSLog(@"take a photo");
                                                                if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                    // show alert if device has no camera
                                                                    UIAlertController *noCameraAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                                                                                     message:@"Device has no camera"
                                                                                                                                              preferredStyle:UIAlertControllerStyleAlert];
                                                                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                                                                       style:UIAlertActionStyleDefault
                                                                                                                     handler:nil];
                                                                    [noCameraAlertController addAction:okAction];
                                                                    [self presentViewController:noCameraAlertController
                                                                                       animated:YES
                                                                                     completion:nil];
                                                                    
                                                                }else {
                                                                    [self takePhotoTapped];
                                                                }
                                                            }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             //cancel selection
                                                         }];
    [choiceAlert addAction:chooseFromCameraRollAction];
    [choiceAlert addAction:takePhotoAction];
    [choiceAlert addAction:cancelAction];
    
    [self presentViewController:choiceAlert
                       animated:YES
                     completion:nil];
}


#pragma mark - camera features -- take picture

- (void)takePhotoTapped {
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
}


- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    photo = image;
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"pop_from_view_to_image_process_view"
                                  sender:self];
    }];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    photo = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - camera feature -- select from album


- (void)chooseExistingPhotoTapped {
    UIImagePickerController *pickerController =
    [TGAlbum imagePickerControllerWithDelegate:self];
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    photo = [TGAlbum imageWithMediaInfo:info];
    [self dismissViewControllerAnimated:NO
                             completion:^{
                                 [self performSegueWithIdentifier:@"pop_from_view_to_image_process_view" sender:self];
                             }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
