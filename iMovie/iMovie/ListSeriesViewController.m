//
//  ListSeriesViewController.m
//  iMovie
//
//  Created by Formando FLAG on 11/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ListSeriesViewController.h"
#import "TVCell.h"

@interface ListSeriesViewController ()

//NSArray para guardar os dados que vem do servidor
@property (nonatomic) NSArray *dataSeries;

@end

@implementation ListSeriesViewController

//key para aceder ao API do service
static NSString *key = @"api_key=1cb69b37224ffe22ede288a758623051";
static NSString *baseURL = @"https://api.themoviedb.org/3/tv";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Criar a string de pedido ao servidor
    NSString *stringRequest = [NSString stringWithFormat:@"%@/popular?%@",baseURL,key];
    
    //Pasar a stringRequest do tipo String para um NSURL
    NSURL *url = [NSURL URLWithString:stringRequest];
    
    //Aceder a uma instancia running da session para efetuar a comunicação
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:Nil];
        
        
        //passar o o NSdictionary json para o meu array dataSeries
        self.dataSeries = [json objectForKey:@"results"];
        
        //code here isto é tipo uma classe anónima
        NSLog(@"%@",json);
        
        [self.tableView reloadData];
    }
    ] resume];
    
    NSLog(@"%@",stringRequest);
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [self.dataSeries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    TVCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TVCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSDictionary *serie = [self.dataSeries objectAtIndex:indexPath.row];
    
    
    //Ir buscar a imagem
    NSString *imageRequest = [NSString stringWithFormat:@"http://image.tmdb.org/t/p/w500%@",[serie objectForKey:@"poster_path"]];
    NSURL *url = [NSURL URLWithString:imageRequest];
    NSURLSession *session = [NSURLSession sharedSession];
    
    cell.imagemDownloadTask = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^
        {
            UIImage *image = [UIImage imageWithData:data];
            cell.imagemView.image = image;

        });
        
    }];
    
    
    [cell.imagemDownloadTask resume];
    
    cell.nomeLabel.text = [serie objectForKey:@"original_name"];
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
