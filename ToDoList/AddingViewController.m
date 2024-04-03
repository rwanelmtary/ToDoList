//
//  AddingViewController.m
//  ToDoList
//
//  Created by rwan elmtary on 02/04/2024.
//

#import "AddingViewController.h"
#import "Model.h"
#import "DetailsViewController.h"

@interface AddingViewController ()

@end

@implementation AddingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)add_in_Table:(id)sender {
    
    NSDate *current = [NSDate date];
    NSDateFormatter *formate = [NSDateFormatter new];
    [formate setDateFormat:@"YYY-MM-dd-HH"];
    NSString *date_Str = [formate stringFromDate:current];
    
    //first creat dict
    NSDictionary *dict = @{
        @"name" : self.adding_Name.text,
        @"desc" : self.adding_desc.text,
        @"time" : date_Str,
        @"pir"  : @(self.piriority.selectedSegmentIndex)
    };
    
    //retrive from user default
    NSMutableArray *tasks =[[[NSUserDefaults standardUserDefaults]objectForKey:@"tasks"]mutableCopy];
    if (!tasks) {
           tasks = [NSMutableArray array];
       }
    // add tasks
    [tasks addObject:dict];
    
    //save the update
    [[NSUserDefaults standardUserDefaults]setObject:tasks forKey:@"tasks"];
    [[NSUserDefaults standardUserDefaults ]synchronize];
    
    // Remove the same object from the tasks array
//       NSInteger indexToRemove = -1;
//       for (NSInteger i = 0; i < _progressarr.count; i++) {
//           NSDictionary *progressDict = _progress[i];
//           if ([progressDict isEqualToDictionary:dict]) {
//               indexToRemove = i;
//               break;
//           }
//       }
//       if (indexToRemove != -1) {
//           [_progress removeObjectAtIndex:indexToRemove];
//       }
     Model *model = [Model new];
    model.name = self.adding_Name.text;
    model.desc = self.adding_desc.text;
    model.time = date_Str;
    model.pir = self.piriority.selectedSegmentIndex;
//    NSLog(@"%@",date_Str);
   [_p reload:model];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];


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
