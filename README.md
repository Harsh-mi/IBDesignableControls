#IBDesignableControls

* This package is available from iOS 13 and contains the UIView extension that provides you the proeprties of the UIControls directly from the storyboard once you install this package.
* For usage you need to take any UIControl element like UILabel, UIButton, UIImageView, etc. and check the Attributed inspector.

#Below are the properties to access directly from Storyboard

![Screenshot 2024-09-11 at 4 49 21 PM](https://github.com/user-attachments/assets/55a21537-fc1a-4e72-bee2-c09a1bef8bbf)

##Border properties:
- Border color
- Border width

##Corner radius properties:
 - Corner radius
 - Only top corner radius
 - Only left corner radius
 - Only right corner radius
 - Only bottom corner radius

* **Here if you can set either full conrner radius or just top, right, left and bottom corner radius at a time if you set both then it will take full corner radius value by default.**

##Shadow Properties:
 - Shadow color
 - Shadow radius
 - Shadow opacity
 - Shadow offset
 - Only top shadow
 - Only bottom shadow
  
* **Here if you can set either full shadow, only top or only bottom shadow.**
  - To set only top shadow you need to change value of shadow top property to **'on'** and same way you need to change value of shadow bottom property to **'on'** for only bottom shadow.
  
Here is an example of setting only top shadow property:

![Screenshot 2024-09-11 at 5 02 33 PM](https://github.com/user-attachments/assets/f37f16f6-d400-42cc-ab40-77c6d61c21ac)
