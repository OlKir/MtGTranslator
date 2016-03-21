//
//  SPCardPresentationViewController.m
//  MtGTranslator
//
//  Created by Oleksii on 19/03/16.
//  Copyright © 2016 SilyaProduct. All rights reserved.
//

#import "SPCardPresentationViewController.h"

@interface SPCardPresentationViewController ()

@end

@implementation SPCardPresentationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.errorMessage.hidden = YES;
    
    if ([self.imageUrl length] < 1) {
        return;
    }
    __weak SPCardPresentationViewController *weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc] initWithData:data];
        
        [weakSelf showImage:img];
    });
    
    
}

- (void)showImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^ {
        if (image) {
            self.cardImage.image = image;
        } else {
            self.errorMessage.hidden = NO;
        }
    });
}

- (IBAction)closeController:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
