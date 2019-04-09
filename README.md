Marvel character deictionary
===

# Overivew  
This project is a visual dictionary of the mnarvel characters.  
You can find the pictures and descriptions of characters by searching the name of characters.  
Here is the demo.  
**Note:** Because of copyright, the background image on `SearchVC.swift` is changed to free image.  
<img src="https://user-images.githubusercontent.com/44053042/55775854-9a040780-5ad5-11e9-8d01-32517a18e2fa.gif" width="150">

# Requirement  
## Language  
This project is coded by Swift4 and Objcective-C(a little)

## Library  
I used these library,  
- Moya
- Kingfisher  

I installed these library with CocoaPods.  
And I used `CommonCrypto` to make hash(look `Bridging-Header.h`).

## Marvel Comic API Key (You must need)    
This project is use the official Marvel Comic API supported by MARVEL.  
To get these API key, you create the account and publish these key at  
https://developer.marvel.com

## Other  
I tested this project on iPhone XR, and work correctly.  
And if you want to change the background image on `SearchVC.swift`, you need to get another image.

# Usage
1. **Get your marvel comic api key.**  
Create your account and get the marvel comic API key at https://developer.marvel.com  
2. **Fix `Model.swift`.**  
Write your API key(public and private key) on  `Model.swift`,
