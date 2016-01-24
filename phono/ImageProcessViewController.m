//
//  ImageProcessViewController.m
//  phono
//
//  Created by Junyu Wang on 1/23/16.
//  Copyright © 2016 junyuwang. All rights reserved.
//

#import "ImageProcessViewController.h"

@interface ImageProcessViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *photoContainer;

@end

@implementation ImageProcessViewController

@synthesize photoToProcess;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoContainer.image = self.photoToProcess;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
