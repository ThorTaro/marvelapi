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
This project is coded by Swift4 and Objcective-C(little a bit)

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
I tested this project on iPhone XR(iOS12.2), and work correctly.  
And if you want to change the background image on `SearchVC.swift`, you need to get another image.

# Set up
1. **Get your marvel comic api key.**  
Create your account and get the marvel comic API key at https://developer.marvel.com  
2. **Fix `Model.swift`.**  
Write your API key(public and private key),  
`static private let publicKey = ******` and  
`static private let privateKey = ******`  
on `pulic enum Model` of `Model.swift`.

# Usage  
**NOTE**  
To run this project on xcode, you should qiit xcode once and type `open marvelapi.xcworkspace` on your terminal.  
(Due to CocoaPods)
1. Input the word of some character name.  
For example, "spider", "spi".  
2. Push the Seatch button.  
If there is any characters that match the search word, you can find the character list with names and thumbnails of them.  
3. Push the thumbnals.
Tap some thumbnails, you can read description and their image.

# Licence  
MAEVEL has the copyright of these thumbnails, descriptions, names of characters and others(related by marvel).

# Author  
This project and this readme is written by ThorTaro.  
Sorry for my bad English.  
Thank you.
