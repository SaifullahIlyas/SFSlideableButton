# SFSlideableButton
### What SFSlideableButton is?
EasyPaymentKit is a customisable payment Accept Method comes with pre define UI to accept credit, debit card and  Bank Account.
### How To Use SFSlideableButton?
  EasyPaymentKit is Availble through cocoapod
  Add pod in pod file by coping following line 
     
     pod 'SFSlideableButton' 
  Run the following command to use library
    
     pod install
  if your project dont hold pod file then create pod file by pod init
   You can also intregrate manually by adding Source file to your Project
   
 ### Sample Use 
 Add following piece of code in your view controller to show Credit or Debit card View
        
        let viewController = SFCardVC.init()
        viewController.theme.SFControllerPresentation = .full
        viewController.theme.isNegetiveButtonVisible = false
               viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
        
   make your you added you payment gateway public key to add Card by 
   
        SFConfiguartion.shared.publicKey = "YOUR_PUBLIC_KEY"
        
   Conforms your ViewController to <b>SFPaymentInfoAble</b>
   sample methods are 
   
         func didCardCreated(with info: SFCardInfo) {
  
        
        
    }
    
    func didErrorWhileGeneratingToken(reason error: String) {
 
    }
    
        
 #### Demo 
 
 <iframe width="300" height="440"
src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/SFSlideableButton/Screen%20Recording%202020-10-26%20at%209.20.05%20PM.mov">
</iframe>
 


