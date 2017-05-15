# ac-final-assessment

Task 4 : 6 custom UICollectionView Cell

* Answer:SixCustomCollectionViewCell
* Idea:<br>(1)cell size:利用view.frame.width & view.frame.height平分6個cell的大小，並且塞入各cell要顯示的文字內容以及顯示格式。以及修改cell間的間隔、邊界<br>(2)cell 1:於didSelectItemAt內的[0,0]項目，加入產生alert view的程式片段<br>(3)cell 2:於didSelectItemAt內的[0,1]項目，加入利用布林值判斷，使cell背景顏色變換的程式片段<br>(4)cell 3:於didSelectItemAt內的[0,2]項目，加入計步功能程式片段<br>(5)cell 4:於didSelectItemAt內的[0,3]項目，加入利用openURL開啟設定功能<br>(6)cell 5:於didSelectItemAt內的[0,4]項目，加入利用Google map app開啟導航至特定地點功能<br>(7)cell 6:於didSelectItemAt內的[0,5]項目，import MessageUI以及MFMailComposeViewController
實作寄信頁面功能<br>     
* Reference:<br>(計步)http://www.hangge.com/blog/cache/detail_1547.html<br>(設定)http://cms.35g.tw/coding/ios8-openurl-uiapplicationopensettingsurlstring/<br>(導航)https://developers.google.com/maps/documentation/ios-sdk/urlscheme?hl=zh-tw<br>(寄信)https://developer.apple.com/reference/messageui/mfmailcomposeviewcontroller

* Note:<br>(1)原先有設計畫面翻轉樣式，但會導致顏色變換的cell位置跑掉，待解<br>(2)計步功能因為機型限制，無法在iPhone5C上使用此功能<br>(3)開啟設定功能，因為此範例沒有使用到需要使用者同意的權限，所以在設定頁面沒有這個APP的相關設定內容，在開啟設定頁面時看起來會像crash，若此時點擊設定頁面再回到APP進行該操作，則可正常開啟設定頁面。參考網站:http://stackoverflow.com/questions/39792745/ios-10-open-settings-crash<br>(4)寄信功能驗證需登入信箱帳號，才可正常使用

