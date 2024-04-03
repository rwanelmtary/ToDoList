//
//  DoneViewController.m
//  ToDoList
//
//  Created by rwan elmtary on 03/04/2024.
//

#import "DoneViewController.h"
#import "DetailsViewController.h"
#import "Model.h"
#import "ViewController.h"

@interface DoneViewController ()
@property NSMutableArray *filterd;
@property  NSInteger selectedSegmentIndex;

@property (weak, nonatomic) IBOutlet UITableView *doneTable;
@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *savedTasks = [[NSUserDefaults standardUserDefaults] objectForKey:@"done"];
        _data = [NSMutableArray array];
        for (NSDictionary *taskDict in savedTasks) {
            Model *model = [[Model alloc] init];
            model.name = taskDict[@"name"];
            model.desc = taskDict[@"desc"];
            model.time = taskDict[@"time"];
            model.pir = [taskDict[@"pir"] integerValue];
            [_data addObject:model];
            
            self.filterd = [NSMutableArray arrayWithArray:_data];
            self.selectedSegmentIndex = UISegmentedControlNoSegment;
        }
        
    self.doneTable.delegate = self;
       self.doneTable.dataSource = self;
   // _data = [NSMutableArray new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _filterd.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myDone" forIndexPath:indexPath];
    //Model *model = _data[indexPath.row];
    Model *model = _filterd[indexPath.row];

//    cell.textLabel.text = [[_data objectAtIndex:indexPath.row]name];
    cell.textLabel.text = model.name;


    return cell;
}
- (void)reload:(Model *)m{
    [_data addObject:m];
    [self updateFilteredData];
    [self.doneTable reloadData];

}
-(void)updateFilteredData {
    if (self.selectedSegmentIndex != UISegmentedControlNoSegment) {
        self.filterd = [NSMutableArray array];
        for (Model *task in _data) {
            if (task.pir == self.selectedSegmentIndex) {
                [self.filterd addObject:task];
            }
        }
    } else {
        self.filterd = [NSMutableArray arrayWithArray:_data];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    [details setModelObject:[_data objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:details animated:YES];


}
- (void)viewWillAppear:(BOOL)animated{
    [_doneTable reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *deletedTask;
        deletedTask = [
        self
        .filterd objectAtIndex:indexPath.row];
         if (indexPath.row < self.filterd.count) {
            deletedTask = [self.filterd objectAtIndex:indexPath.row];
            [self.filterd removeObjectAtIndex:indexPath.row];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // Update tasks in UserDefaults
        [self updateTasksInUserDefaults];
    }
}

//- (void)updateTasksInUserDefaults {
//    // Update tasks in UserDefaults
//    NSArray *tasksArray = [NSArray arrayWithArray:self.data];
//    [[NSUserDefaults standardUserDefaults] setObject:tasksArray forKey:@"tasks"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}
- (void)updateTasksInUserDefaults {
    NSMutableArray *tasksArray = [NSMutableArray array];
    for (Model *task in self.data) {
        // Check if any of the values are nil
        if (task.name && task.desc && task.time) {
            NSDictionary *taskDict = @{
                @"name": task.name,
                @"desc": task.desc,
                @"time": task.time,
                @"pir": @(task.pir)
            };
            [tasksArray addObject:taskDict];
        }
    }
    // Now that we have constructed the tasksArray, store it in UserDefaults
    [[NSUserDefaults standardUserDefaults] setObject:tasksArray forKey:@"progress"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)filter:(UISegmentedControl *)sender {
    self.selectedSegmentIndex = sender.selectedSegmentIndex;
    [self updateFilteredData];
    [self.doneTable reloadData];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
