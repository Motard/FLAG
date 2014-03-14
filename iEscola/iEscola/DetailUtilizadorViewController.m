//
//  DetailUtilizadorViewController.m
//  iEscola
//
//  Created by Formando FLAG on 05/03/14.
//  Copyright (c) 2014 Paulo Martins. All rights reserved.
//

#import "DetailUtilizadorViewController.h"
//Para os mails
#import <MessageUI/MessageUI.h>

@interface DetailUtilizadorViewController ()


@end

@implementation DetailUtilizadorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//metodo que corre antes da view aparecer
-(void)viewWillAppear:(BOOL)animated
{
    self.lNrUtilizador.text = [NSString  stringWithFormat:@"%d",self.utilizadorObj.nrUtilizador];
    self.lNomeUtilizador.text = self.utilizadorObj.nomeUtilizador;
    
    if (self.utilizadorObj.tipoUtilizador == 0)
        self.ivTipoUtilizador.image = [UIImage imageNamed:@"student"];
    else
        self.ivTipoUtilizador.image = [UIImage imageNamed:@"professor.jpeg"];
    
    self.lCursoUtilizador.text = self.utilizadorObj.curso;
    self.lPasswordUtilizador.text = self.utilizadorObj.password;
}

- (IBAction)EnviarEmail:(id)sender
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc]init];
        
        mail.mailComposeDelegate = self;
        
        
        NSArray *paraLista = [NSArray arrayWithObjects:@"ola@ola.com",@"exemplo@exemplo.com",nil];
        
        [mail setToRecipients:paraLista];
        
        [mail setSubject:@"Isto é o assunto"];
        
        [mail setMessageBody:@"Isto é o corpo do mail" isHTML:NO];
        
        [self presentViewController:mail animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alerta = [[UIAlertView alloc]
                               initWithTitle:@"Erro" message:@"Oh tu não tens conta de mail!!!" delegate:Nil cancelButtonTitle:@"yaya" otherButtonTitles: nil];
        
        [alerta show];
    }
}

//Este metodo é chamada quando o utilizador clicar no ok ou cancel na view enviar mail
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultCancelled)
    {
        NSLog(@"Cancelou o mail");
    }
    
    if(result == MFMailComposeResultSent)
    {
        NSLog(@"Enviou com sucesso");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
