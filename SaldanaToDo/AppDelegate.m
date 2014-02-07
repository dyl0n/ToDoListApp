//
//  AppDelegate.m
//  SaldanaToDo
//
//  Created by Dylan Saldana on 2/6/14. Finished at 6:43 PM.
//  Student-id: z1684805
//  Copyright (c) 2014 Dyl0n. All rights reserved.
//
//  This is a simple to-do list app. You can enter the item you want to do and it will store it for you even if you press the home button and go back to it. It uses an array to store the to-do list of items.

#import "AppDelegate.h"

// Helper function to fetch the path to our to-do data stored on disk.
NSString *docPath()
{
    NSArray *pathlist =
    NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask,
                                        YES);
    return [[pathlist objectAtIndex:0]
            stringByAppendingPathComponent:@"data.td"];
}

@implementation AppDelegate

// Function that shows visual items, creates an array and displays items to the user
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions: (NSDictionary *)launchOptions
{
    // Load an existing to-do dataset from an array store on disk.
    NSArray *plist = [NSArray arrayWithContentsOfFile:docPath()];
    if (plist)
    {
        // if there was a dataset available, copy it into our instance variable.
        tasksArray = [plist mutableCopy];
    } else {
        // Otherwise, just create an empty one to get us started.
        tasksArray = [[NSMutableArray alloc] init];
    }
    
    // Is tasks empty?
    if ([tasksArray count] == 0)
    {
        [tasksArray addObject:@"Walk the dog"];
        [tasksArray addObject:@"Play super mario"];
        [tasksArray addObject:@"Do iOS homework"];
        [tasksArray addObject:@"Watch Doctor Who?"];
    }
    // Next, we create and configure UIWindow instance.
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    UIWindow *theWindow = [[UIWindow alloc] initWithFrame:windowFrame];
    [self setWindow:theWindow];
    // Define the frame rectangles of the three UI elements
    // CGRectMake() creates a CGRect from (x,y) width, height)
    CGRect tableFrame = CGRectMake(20, 80, 320, 380);
    CGRect fieldFrame = CGRectMake(20, 40, 200, 31);
    CGRect buttonFrame = CGRectMake(228, 40, 72, 31);
    // Create and configure the table view
    taskTable = [[UITableView alloc] initWithFrame:tableFrame
                                             style:UITableViewStylePlain];
    [taskTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    // Make this object the table view's datasource
    [taskTable setDataSource:self];
    // Next, create and configure the textfield where new tasks will be typed
    taskField = [[UITextField alloc] initWithFrame:fieldFrame];
    [taskField setBorderStyle:UITextBorderStyleRoundedRect];
    [taskField setPlaceholder:@"Type a task, tap Insert"];
    // Next, create and configure a rounded rect Insert button
    insertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [insertButton setFrame:buttonFrame];
    // Buttons behave using a target/action callback
    // Configure the Insert button's action to call this object's
    // -addTask: method
    [insertButton addTarget:self
                     action:@selector(addTask:)
           forControlEvents:UIControlEventTouchUpInside];
    // Give the button a title
    [insertButton setTitle:@"Insert" forState:UIControlStateNormal];
    // Add our three UI elements to the window
    [[self window] addSubview:taskTable];
    [[self window] addSubview:taskField];
    [[self window] addSubview:insertButton];
    // Finalize the window and put it on the screen
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    return YES;
}

#pragma mark -- Table View management
// Implementing two required methods for the UITableViewDataSource Protocol
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    //Because this table view only has one section, the number of rows in
    // it = number of task items.
    return [tasksArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    // To improve performance, we configure cells in memory that have scrolled
    // off the screen and hand them back with new contents instead of always
    // creating new cells.
    // First, we check to see if there's a cell available for reuse.
    UITableViewCell *c = [taskTable dequeueReusableCellWithIdentifier:@"cell"];
    if (!c) {
        c = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:@"cell"];
    }
    //Then we (re)configure the cell based on the model object, tasks array
    NSString *item = [tasksArray objectAtIndex:[indexPath row]];
    [[c textLabel] setText:item];
    //Hand back to the table view the properly configured cell.
    return c;
}

// Funcion to add a task to the to-do list
- (void)addTask:(id)send {
    // Get to-do item
    NSString *t = [taskField text];
    // Quit here if taskField is empty
    if ([t isEqualToString:@""]) {
        return; }
    // Otherwise, add to-do item to our working array
    [tasksArray addObject:t];
    //Refresh the table so that the new item shows up
    [taskTable reloadData];
    //Clear out the text field
    [taskField setText:@""];
    //Dismiss the keyboard
    [taskField resignFirstResponder];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // Save our taskArray to disk
    [tasksArray writeToFile:docPath() atomically:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // Save our taskArray to disk
    [tasksArray writeToFile:docPath() atomically:YES];
}

@end
