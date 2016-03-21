//
//  SPCardSelectionViewController.m
//  MtGTranslator
//
//  Created by Oleksii on 19/03/16.
//  Copyright © 2016 SilyaProduct. All rights reserved.
//

#import "SPCardSelectionViewController.h"
#import "SPCardsModel.h"
#import "SPMtgSetTableViewCell.h"
#import "SPMtgSet.h"
#import "SPCardPresentationViewController.h"

#define SP_MTG_SET_CELL_ID  @"SPMtgSetCell"

@interface SPCardSelectionViewController ()

@property (strong, nonatomic) SPCardsModel *cards;
@property (strong, nonatomic) NSString *selectedSetCode;

@end

@implementation SPCardSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cards = [[SPCardsModel alloc] init];
    [self.cards loadSets];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cardNumber.text = @"";
    
    self.selectedSetCode = @"";
    [self checkInputForText:@""];
    self.selectedSet.image = [UIImage imageNamed:@"Undefined.png"];
    
    
    NSIndexPath *indexPath = self.setTableView.indexPathForSelectedRow;
    if (indexPath) {
        [self.setTableView deselectRowAtIndexPath:indexPath animated:animated];
    }
}

- (BOOL)checkInputForText:(NSString *)inputText
{
    BOOL inputCorrect = YES;
    
    if ([self.selectedSetCode length] < 1) {
        inputCorrect = NO;
    }
    
    if ([inputText integerValue] < 1 || [inputText integerValue] > 500) {
        inputCorrect = NO;
    }
   
    self.showCardButton.enabled = inputCorrect;
    self.showCardButton.alpha = self.showCardButton.enabled ? 1.0 : 0.5;
    
    return inputCorrect;
}

- (IBAction)showCard:(UIButton *)sender
{
    if ([self checkInputForText:self.cardNumber.text]) {
        [self performSegueWithIdentifier:@"showCard" sender:self];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SPCardPresentationViewController *nextController = segue.destinationViewController;
    nextController.imageUrl = [self.cards urlForCard:self.cardNumber.text
                                             fromSet:self.selectedSetCode];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if ([self checkInputForText:self.cardNumber.text]) {
        [self showCard:nil];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField * _Nonnull)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString * _Nonnull)string
{
    [self checkInputForText:[[textField text] stringByReplacingCharactersInRange:range withString:string]];
    
    return YES;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedSetCode = [self.cards mtgSetCodeForIndex:indexPath.item];
    
    SPMtgSet *currentSet = [self.cards.sets objectAtIndex:indexPath.item];
    
    self.selectedSet.image = [UIImage imageNamed:currentSet.setImageName];
    
    [self.cardNumber becomeFirstResponder];
    
    [self checkInputForText:self.cardNumber.text];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cards.sets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPMtgSetTableViewCell *cell = (SPMtgSetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:SP_MTG_SET_CELL_ID forIndexPath:indexPath];
    
    SPMtgSet *currentSet = [self.cards.sets objectAtIndex:indexPath.item];
    
    cell.setName.text = currentSet.setName;
    cell.setImage.image = [UIImage imageNamed:currentSet.setImageName];
    
    return cell;
    
}

@end
