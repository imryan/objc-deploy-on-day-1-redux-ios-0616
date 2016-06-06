//
//  FISComputerPlayer.m
//  DeployOnDay1Redux
//
//  Created by Timothy Clem on 9/22/15.
//  Copyright © 2015 The Flatiron School. All rights reserved.
//

#import "FISComputerPlayer.h"

@implementation FISComputerPlayer

+ (BOOL)isEnabled {
    return YES;
}

- (FISTicTacToePosition)nextPlay {
    NSUInteger col = arc4random_uniform(3);
    NSUInteger row = arc4random_uniform(3);
    
    while (![self.game canPlayAtColumn:col row:row]) {
        col = arc4random_uniform(3);
        row = arc4random_uniform(3);
    }
    
    return FISTicTacToePositionMake(col, row);
}

@end
