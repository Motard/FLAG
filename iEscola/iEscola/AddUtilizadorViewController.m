//
//  AddUtilizadorViewController.m
//  iEscola
//
//  Created by Paulo Martins on 03/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "AddUtilizadorViewController.h"

@interface AddUtilizadorViewController ()


@end



@implementation AddUtilizadorViewController

-(id)init{
    NSLog(@"init");
    self=[super init];
    if(self)
    {
        self.utilizadoresArr = [[NSMutableArray alloc]init];
        NSLog(@"Lazy instantiation utilizadoresArray");
    }
    
    return self;
}
//Instanciar o UtilizadoresArr
//-(NSMutableArray*) utilizadoresArr
//{
//    if(!_utilizadoresArr)
//    {
//        _utilizadoresArr = [[NSMutableArray alloc]init];
//        NSLog(@"Lazy instantiation utilizadoresArray");
//    }
//    return _utilizadoresArr;
//}

- (IBAction)submeterUtilizador {
    
    //Variável do metodo
    Utilizadores* utilizadorObj;
    //NSMutableArray* utilizadoresArrLocal;
    //utilizadoresArrLocal = [ListaUtilizadoresViewController utilizadoresArr];
    ListaUtilizadoresViewController *arr;
    
//    if(arr.utilizadoresArr==Nil)
//    {
//        arr.utilizadoresArr = [[NSMutableArray alloc]init];
//        NSLog(@"Lazy instantiation utilizadoresArray");
//    }
    
    int xpto = [self.utilizadoresArr count];
    NSLog(@"%d",xpto);
    
    //Instanciar um utilizadorObj
    utilizadorObj = [[Utilizadores alloc]init];
    
    //Remover o teclado depois de introduzir
    [self.tfNrUtilizador resignFirstResponder];
    [self.tfNomeUtilizador resignFirstResponder];
    [self.tfTipoUtilizador resignFirstResponder];
    [self.tfCursoUtilizador resignFirstResponder];
    [self.tfPassword resignFirstResponder];
    
    //Ver se já existe utilizador com o numero introduzido
    for (Utilizadores* obj in arr.utilizadoresArr)
    {
        NSString* aux = [NSString stringWithFormat:@"%d",obj.nrUtilizador];
        if([aux isEqualToString:self.tfNrUtilizador.text])
        {
            self.lAviso.text = @"Numero já existe";
            self.tfNrUtilizador.text = @"";
            return;
        }
    }
    
    //Obter os valores que estão nos Text Fields
    if([self.tfNrUtilizador.text length] == 0)
    {
        self.lAviso.text=@"Introduza o nr do utilizador";
        return;
    }
    
    if([self.tfNomeUtilizador.text length] == 0)
    {
        self.lAviso.text=@"Introduza o nome do utilizador";
        return;
    }
    
    if([self.tfTipoUtilizador.text length] == 0)
    {
        self.lAviso.text=@"Introduza o tipo do utilizador";
        return;
    }
    
    if([self.tfCursoUtilizador.text length] == 0)
    {
        self.lAviso.text=@"Introduza o curso do utilizador";
        return;
    }
    
    if([self.tfPassword.text length] == 0)
    {
        self.lAviso.text=@"Introduza a password do utilizador";
        return;
    }
    
    //Indicar que os valores foram bem intoduzidos
    self.lAviso.text = @"Introdução bem sucedida";
    
    //Passar os valores das Text Fields para os atributos do utilizadorObj
    utilizadorObj.nrUtilizador = [self.tfNrUtilizador.text integerValue];
    utilizadorObj.nomeUtilizador = self.tfNomeUtilizador.text;
    utilizadorObj.tipoUtilizador = [self.tfTipoUtilizador.text integerValue];
    utilizadorObj.curso = self.tfCursoUtilizador.text;
    utilizadorObj.password = self.tfPassword.text;
    
    //Acrescentar este utilizadorObj aos UtilizadoresArr
    [self.utilizadoresArr addObject:utilizadorObj];
    
    //Voltar para a ListaUtilizadoresView
    //[self.navigationController popViewControllerAnimated:YES];
}
@end
