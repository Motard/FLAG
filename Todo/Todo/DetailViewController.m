//
//  DetailViewController.m
//  Todo
//
//  Created by Formando FLAG on 10/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "DetailViewController.h"
#import "TodoEntity.h"
#import "AppDelegate.h"


@interface DetailViewController ()

@property (nonatomic,strong) NSManagedObjectContext * managedObjectContext;

@end




@implementation DetailViewController


-(void)viewDidLoad
{
    //aceder ao appDelegate que já esta instanciado
    //ou seja não é feito alloc init, usamos uma instancia ja criada.
    //Isto tem o nome de Singleton
    AppDelegate * appDelegate = [UIApplication sharedApplication].delegate;
    
    //E agora dizemos que o managedObjectContext desta classe é igual ao managedObjectContext da appDelegate
    self.managedObjectContext = appDelegate.managedObjectContext;
}

//botao para adicionar nova tarefa
- (IBAction)adicionarButtonTapped:(id)sender
{
    //Criar um objecto do tipo TodoEntity
    TodoEntity * novaEntrada = [NSEntityDescription insertNewObjectForEntityForName:@"TodoEntity" inManagedObjectContext:self.managedObjectContext];
    
   
    
    
    //converter a data de NSString para Date
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-mm-dd"];
    
    //Passar os valores dos input fields para o ibjecto do tipo TodoEntity
    novaEntrada.descricao = self.descricaoLabel.text;
    novaEntrada.nota = self.notasLabel.text;
    novaEntrada.data = [df dateFromString:self.dataLabel.text];
    
    NSError * error;
    
    //Guardar no managedObjectContext caso não exista erro
    if(![self.managedObjectContext save:&error])
    {
        NSLog(@"ERRO!! %@",[error localizedDescription]);
    }
    
    
    
    

}

@end
