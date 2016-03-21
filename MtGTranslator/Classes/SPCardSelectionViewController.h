//
//  SPCardSelectionViewController.h
//  MtGTranslator
//
//  Created by Oleksii on 19/03/16.
//  Copyright © 2016 SilyaProduct. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPCardSelectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *setTableView;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UIButton *showCardButton;
@property (weak, nonatomic) IBOutlet UIImageView *selectedSet;

@end
