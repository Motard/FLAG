//
//  ListaUtilizadoresViewController.m
//  iEscola
//
//  Created by Paulo Martins on 03/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ListaUtilizadoresViewController.h"

@interface ListaUtilizadoresViewController ()

@property (nonatomic) NSMutableArray* utilizadoresArr;

@end

@implementation ListaUtilizadoresViewController

//Instanciar o UtilizadoresArr
-(NSMutableArray*) utilizadoresArr
{
    if(!_utilizadoresArr)
    {
        _utilizadoresArr = [[NSMutableArray alloc]init];
        NSLog(@"Lazy instantiation utilizadoresArray");
    }
    return _utilizadoresArr;
}

//este metodo corre sempre antes de a view ser apresentada 
-(void)viewWillAppear:(BOOL)animated
{
    //Faz o refresh da tabela
    [[self tableView] reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    NSLog(@"initWithStyle");
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.utilizadoresArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    Utilizadores * obj = [self.utilizadoresArr objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = obj.nomeUtilizador;
    
    //cria um botão no fim da row
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    // Configure the cell...
    //cell.textLabel.text = [self.contactosOrdenados objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/




#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //Isto passa o utilizadoresArr da ListaUtilizadores para o utilizadoresArr da AddUtilizadores
    if ([segue.identifier isEqual:@"segueAdicionar"])
    {
        AddUtilizadorViewController * view =[segue destinationViewController];
        
        view.utilizadoresArr=self.utilizadoresArr;
    }
    
}


//este metodo é chamado quando uma row é clicada
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Utilizadores * obj = [self.utilizadoresArr objectAtIndex:indexPath.row];
    
    DetailUtilizadorViewController * view = [self.storyboard instantiateViewControllerWithIdentifier:@"Detail"];
    
    [self.navigationController pushViewController:view animated:YES];
    
    view.utilizadorObj = obj;
}

@end
