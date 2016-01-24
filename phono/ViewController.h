//
//  ViewController.h
//  phono
//
//  Created by Junyu Wang on 1/22/16.
//  Copyright © 2016 junyuwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TGCameraViewController/TGCameraViewController.h>

@interface ViewController : UIViewController <TGCameraDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, copy) UIImage *photo;

@end

