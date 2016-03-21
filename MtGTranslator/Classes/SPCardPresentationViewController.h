//
//  SPCardPresentationViewController.h
//  MtGTranslator
//
//  Created by Oleksii on 19/03/16.
//  Copyright © 2016 SilyaProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCardPresentationViewController : UIViewController

@property (strong, nonatomic) NSString *imageUrl;

@property (weak, nonatomic) IBOutlet UIImageView *cardImage;

@property (weak, nonatomic) IBOutlet UIView *errorMessage;
@end
