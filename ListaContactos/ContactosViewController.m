//
//  ContactosViewController.m
//  ListaContactos
//
//  Created by Formando FLAG on 28/02/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "ContactosViewController.h"
#import "ContactosCell.h"

@interface ContactosViewController ()

@property (nonatomic) NSArray * contactos;
@property (nonatomic) NSMutableArray * contactosOrdenados;

@end

@implementation ContactosViewController


//lazy instatiaction
-(NSArray * ) contactos
{
    if(_contactos == Nil)
    {
        _contactos = @[@"Ana", @"Maria", @"Joaquina", @"Teresa", @"Pedro", @"Nuno", @"Paulo", @"Fanny", @"Antonio", @"José", @"Sergio", @"Cajé", @"Xana", @"Karla", @"Vasco", @"Carlos", @"Rui",@"anita", @"Frank"];
    }
    return _contactos;
}

-(NSMutableArray *) contactosOrdenados
{
    if(_contactosOrdenados == Nil )
        _contactosOrdenados = [[NSMutableArray alloc]init];
    
    return _contactosOrdenados;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //Neste caso so temos uma section
    return 26;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    // Neste caso o numero de linhas é igual ao numero de posições do array
    int aux = [self.contactosOrdenados count];
    return aux;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"CellContactos";
    ContactosCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        // Relacionar o meu .xib com uma celula
        NSArray* aux = [[NSBundle mainBundle] loadNibNamed:@"ContactosCell" owner:nil options:nil];
        
        cell = [aux objectAtIndex:0];
    }
    
    //Chamar o metodo que cria um array com as posições correspondentes á letra
    [self criarNovoArrayContactos:indexPath.section];
    
    // Configure the cell...
    //cell.textLabel.text = [self.contactosOrdenados objectAtIndex:indexPath.row];
    
    // Configure the cell for my label
    cell.nomeLabel.text = [self.contactosOrdenados objectAtIndex:indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //Chamar o metodo para calcular o titulo de cada secção
    NSString * sectionTitle = [self criarNovoArrayContactos:section];
    
    return sectionTitle;
}

-(NSString *) criarNovoArrayContactos:(NSInteger) section
{
    
    //Obtem a letra de cada Section
    int asciiCode = 65 + section;
    NSString *sectionTitle = [NSString stringWithFormat:@"%c",asciiCode];


    //Se o contactosOrdenados existir apagar todos os valores
    self.contactosOrdenados = [[NSMutableArray alloc]init];
    
    //Percorrer todas as posições dos contactos e comparar a primeira letra com a sectionTitle
    //Se a primeira letra for igual á sectionTitle adicionar essa poição ao contactosOrdenados
    int nrPosicoes = [self.contactos count];
    for (int i=0; i<nrPosicoes; i++)
    {
        NSString * aux = [self.contactos objectAtIndex:i];
        if ([[aux uppercaseString] hasPrefix:sectionTitle])
        {
            [self.contactosOrdenados addObject:aux];
        }
    }
    
    return sectionTitle;

}
@end
