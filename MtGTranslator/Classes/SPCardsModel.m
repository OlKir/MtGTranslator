//
//  SPCardsModel.m
//  MtGTranslator
//
//  Created by Oleksii on 19/03/16.
//  Copyright © 2016 SilyaProduct. All rights reserved.
//

#import "SPCardsModel.h"

#define SP_MTG_SET_FILE_NAME        @"mtg_set_configuration"
#define SP_MTG_SET_FILE_FORMAT      @"csv"
#define SP_CSV_SEPARATOR            @","

@implementation SPCardsModel

- (void)loadSets
{
    NSString* path = [[NSBundle mainBundle] pathForResource:SP_MTG_SET_FILE_NAME
                                                     ofType:SP_MTG_SET_FILE_FORMAT];
    if ( ! path ) {
        NSLog(@"Configuration file not found!");
        return;
    }
    
    // read the file contents, see below
    NSString *linesString = [NSString stringWithContentsOfFile:path
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
    NSArray *lines = [linesString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *allSets = [NSMutableArray array];
    
    BOOL isFirst = YES;
    for ( NSString *line in lines ) {
        if ( isFirst || [line length] == 0) {
            isFirst = NO; // ignore the header line
            continue;
        }
        
        NSArray *csvValues = [line componentsSeparatedByString:SP_CSV_SEPARATOR];
        
        if ( [csvValues count] < 3 ) {
            NSLog(@"inconsistent state of set config: %@.%@", SP_MTG_SET_FILE_NAME, SP_MTG_SET_FILE_FORMAT);
            continue;
        }
        
        SPMtgSet *mtgSet = [[SPMtgSet alloc] init];
        mtgSet.setImageName = csvValues[0];
        mtgSet.setCode = csvValues[1];
        mtgSet.setName = csvValues[2];
        
        [allSets addObject:mtgSet];
    }
    
    self.sets = [NSArray arrayWithArray:allSets];

}

- (NSString *)urlForCard:(NSString *)cardNumber fromSet:(NSString *)setCode
{
    return [NSString stringWithFormat:@"http://magiccards.info/scans/en/%@/%@.jpg",setCode,cardNumber];
}

- (NSString *)mtgSetCodeForIndex:(NSInteger)index
{
    SPMtgSet *selectedSet = [self.sets objectAtIndex:index];
    return selectedSet.setCode;
}

@end
