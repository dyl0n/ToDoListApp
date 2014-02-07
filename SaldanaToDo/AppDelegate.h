//
//  AppDelegate.h
//  SaldanaToDo
//
//  Created by Dylan Saldana on 2/6/14. Finished at 6:43 PM.
//  Student-id: z1684805
//  Copyright (c) 2014 Dyl0n. All rights reserved.
//
//  This is a simple to-do list app. You can enter the item you want to do and it will store it for you even if you press the home button and go back to it. It uses an array to store the to-do list of items.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasksArray;
}

- (void)addTask:(id)send;
@property (strong, nonatomic) UIWindow *window;

@end
