# SFSlideableButton
### What SFSlideableButton is?
SFSlideableButton is a slideable button to make sure user not perform the action accidentaly. .
### How To Integrate SFSlideableButton?
  SFSlideableButton is Availble through cocoapod
  Add pod in pod file by coping following line 
     
     pod 'SFSlideableButton' 
  Run the following command to use library
    
     pod install
  if your project dont hold pod file then create pod file by pod init
   You can also intregrate manually by adding Source file to your Project
   
 ### Sample Usage
 Add button through interface builder or progragramatically. 
 Assign  <b>SFSlideableButton</b> class to your button  in identity inspector in case of interface builder.
 create outlet of FSlideableButton in case of IB 
 Get Button slides callback either by Delegate <br>
 Conform your button to  <b>SFSlideableButtonDelegate</b> and implement the method 
         
         func didButtonSlides(sender:UIView){}
  
  finally  assign your viewcontoller or custom view to SFSlideableButtonDelegate
   
       yourButton.delegate = self
    
  or By closure way 
       
        yourButton.didButtonSlides = {
            // Implementation goes here
        }
  
       
 
  
  
 #### Customiseable Properties
 
   <table style="width:400%">
  <tr>
    <th>Property</th>
    <th>Description</th>
    <th>Availalbe through IB</th>
  </tr>
  <tr>
    <td>slideTitle</td>
    <td>Title of the button i.e "slide to action"</td>
    <td>YES</td>
  </tr>
  <tr>
    <td>slideTitleColor</td>
    <td>Button text color i.e .white</td>
    <td>NO</td>
  </tr>
  <tr>
    <td>slideImage</td>
    <td>image on the left slide of slide button which start sliding</td>
    <td>NO</td>
  </tr>
  <tr>
    <td>slideButtonFont</td>
    <td>font of the button title</td>
    <td>NO</td>
  </tr>
  <tr>
    <td>roundCornerRadius</td>
    <td>Corner radius of the button i.e 5</td>
    <td>NO</td>
  </tr>
</table>
        
 #### Demo 
 
 <img width="293.76" height="620.16"
src="https://github.com/SaifullahIlyas/OutPutFiles/blob/master/SFSlideableButton/ezgif.com-gif-maker.gif">
</img>
 


