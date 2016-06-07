//
//  FISTicTacToeGame.m
//  DeployOnDay1Redux
//
//  Created by Timothy Clem on 9/22/15.
//  Copyright © 2015 The Flatiron School. All rights reserved.
//

#import "FISTicTacToeGame.h"

@interface FISTicTacToeGame ()

@property (nonatomic, strong) NSMutableArray *board;

@end

@implementation FISTicTacToeGame

- (instancetype)init {
    self = [super init];
    if(self) {
        [self resetBoard];
    }

    return self;
}

- (void)saveScore:(NSString *)player score:(NSInteger)score {
    [[NSUserDefaults standardUserDefaults] setInteger:score forKey:[NSString stringWithFormat:@"%@WinCount", player]];
}

- (NSInteger)getScoreForPlayer:(NSString *)player {
    NSString *playerNameKey = [NSString stringWithFormat:@"%@WinCount", player];
    NSInteger score = 0;
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:playerNameKey]) {
        NSLog(@"Key for %@ doesn't exist! Assigning to 0...", playerNameKey);
    } else {
        score = [[NSUserDefaults standardUserDefaults] integerForKey:playerNameKey];
    }
    
    return score;
}

- (void)resetBoard {
    self.board = [NSMutableArray array];
    [self.board addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", nil]];
    [self.board addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", nil]];
    [self.board addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", nil]];
}

- (NSString *)playerAtColumn:(NSUInteger)column row:(NSUInteger)row {
    return self.board[column][row];
}

- (BOOL)canPlayAtColumn:(NSUInteger)column row:(NSUInteger)row {
    BOOL canPlay = NO;
    if ([self.board[column][row] isEqualToString:@""]) {
        canPlay = YES;
    }
    
    return canPlay;
}

- (void)playXAtColumn:(NSUInteger)column row:(NSUInteger)row {
    self.board[column][row] = @"X";
}

- (void)playOAtColumn:(NSUInteger)column row:(NSUInteger)row {
    self.board[column][row] = @"O";
}

- (NSString *)winningPlayer {
    NSString *winningPlayer = nil;
    NSArray *xWinning = @[@"X", @"X", @"X"];
    NSArray *oWinning = @[@"O", @"O", @"O"];
    
    for (NSUInteger i = 0; i < self.board.count; i++) {
        NSArray *col = self.board[i];
        NSArray *row = @[self.board[0][i], self.board[1][i], self.board[2][i]];
        
        if ([col isEqualToArray:xWinning] || [row isEqualToArray:xWinning]) {
            winningPlayer = @"X";
        } else if ([col isEqualToArray:oWinning] || [row isEqualToArray:oWinning]) {
            winningPlayer = @"O";
        }
    }
    
    NSString *middle = self.board[1][1];
    if ([self.board[0][0] isEqualToString:middle] && [self.board[2][2] isEqualToString:middle]) {
        winningPlayer = middle;
    } else if ([self.board[0][2] isEqualToString:middle] && [self.board[2][0] isEqualToString:middle]) {
        winningPlayer = middle;
    }
    
    return winningPlayer;
}

- (BOOL)isADraw {
    BOOL fullBoard = YES;
    for (NSArray *array in self.board) {
        for (NSString *move in array) {
            if ([move isEqualToString:@""]) {
                fullBoard = NO;
            }
        }
    }
    
    return fullBoard && ![self winningPlayer];
}

@end
