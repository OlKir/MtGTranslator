//
//  SPCardsModel.h
//  MtGTranslator
//
//  Created by Oleksii on 19/03/16.
//  Copyright © 2016 SilyaProduct. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPMtgSet.h"

@interface SPCardsModel : NSObject

@property (strong,nonatomic) NSArray<SPMtgSet *> *sets;

- (void)loadSets;

- (NSString *)mtgSetCodeForIndex:(NSInteger)index;

- (NSString *)urlForCard:(NSString *)cardNumber fromSet:(NSString *)setCode;

@end
