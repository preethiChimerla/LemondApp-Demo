//
//  LanguageSelection.swift
//  LeMond Cycling
//
//  Created by Nicolas Wegener on 6/19/15.
//  Copyright (c) 2015 LeMond. All rights reserved.
//

import Foundation
import UIKit

class LanguageController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    var cs = StoreUserDefaults()

    var saveLanguageDelegate: SettingsLanguageProtocol?
    
    let LanguageData = [
            "en": "English",
        
        
            "zh-cn": "简体中文 - Chinese Simplified (PRC)",
            "fr": "Français - French (Standard)",
//            "it": "Italiano - Italian (Standard)",
//            "el": "ελληνικά - Greek",
            "nl": "Nederlands - Dutch (Standard)",
//            "pt": "Portuguese (Portugal)",
//            "ko": "한국어 - Korean",
//            "no": "Norwegian (Nynorsk)",
//            "ar-eg": "أربيك - Arabic (Egypt)",
//            "th": "ภาษาไทย - Thai",
//            "en-gb": "English (United Kingdom)",
//            "en-ca": "English (Canada)",
//            "en-ie": "English (Ireland)",
//            "es-mx": "Spanish (Mexico)",
//            "af": "Afrikaans",
//            "sq": "Albanian",
//            "ar-sa": "Arabic (Saudi Arabia)",
//            "ar-iq": "Arabic (Iraq)",
//            "ar-ly": "Arabic (Libya)",
//            "ar-dz": "Arabic (Algeria)",
//            "ar-ma": "Arabic (Morocco)",
//            "ar-tn": "Arabic (Tunisia)",
//            "ar-om": "Arabic (Oman)",
//            "ar-ye": "Arabic (Yemen)",
//            "ar-sy": "Arabic (Syria)",
//            "ar-jo": "Arabic (Jordan)",
//            "ar-lb": "Arabic (Lebanon)",
//            "ar-kw": "Arabic (Kuwait)",
//            "ar-ae": "Arabic (U.A.E.)",
//            "ar-bh": "Arabic (Bahrain)",
//            "ar-qa": "Arabic (Qatar)",
//            "eu": "Basque",
//            "bg": "Bulgarian",
//            "be": "Belarusian",
//            "ca": "Catalan",
//            "zh-hk": "Chinese (Hong Kong SAR)",
//            "zh-sg": "Chinese (Singapore)",
//            "hr": "Croatian",
//            "cs": "Czech",
//            "da": "Danish",
//            "nl-be": "Dutch (Belgium)",
//            "en-au": "English (Australia)",
//            "en-nz": "English (New Zealand)",
//            "en-za": "English (South Africa)",
//            "en-jm": "English (Jamaica)",
//            "en-bz": "English (Belize)",
//            "en-tt": "English (Trinidad)",
//            "et": "Estonian",
//            "fo": "Faeroese",
//            "fa": "Farsi",
//            "fi": "Finnish",
//            "fr-be": "French (Belgium)",
//            "fr-ca": "French (Canada)",
//            "fr-ch": "French (Switzerland)",
//            "fr-lu": "French (Luxembourg)",
//            "gd": "Gaelic (Scotland)",
//            "ga": "Irish",
//            "de": "German (Standard)",
//            "de-ch": "German (Switzerland)",
//            "de-at": "German (Austria)",
//            "de-lu": "German (Luxembourg)",
//            "de-li": "German (Liechtenstein)",
//            "he": "Hebrew",
//            "hi": "Hindi",
//            "hu": "Hungarian",
//            "is": "Icelandic",
//            "id": "Indonesian",
//            "it-ch": "Italian (Switzerland)",
//            "lv": "Latvian",
//            "lt": "Lithuanian",
//            "mk": "Macedonian (FYROM)",
//            "ms": "Malaysian",
//            "mt": "Maltese",
//            "pl": "Polish",
//            "pt-br": "Portuguese (Brazil)",
//            "rm": "Rhaeto-Romanic",
//            "ro": "Romanian",
//            "ro-mo": "Romanian (Republic of Moldova)",
//            "ru-mo": "Russian (Republic of Moldova)",
//            "sz": "Sami (Lappish)",
//            "sr": "Serbian (Latin)",
//            "sk": "Slovak",
//            "sl": "Slovenian",
//            "sb": "Sorbian",
//            "es-gt": "Spanish (Guatemala)",
//            "es-cr": "Spanish (Costa Rica)",
//            "es-pa": "Spanish (Panama)",
//            "es-do": "Spanish (Dominican Republic)",
//            "es-ve": "Spanish (Venezuela)",
//            "es-co": "Spanish (Colombia)",
//            "es-pe": "Spanish (Peru)",
//            "es-ar": "Spanish (Argentina)",
//            "es-ec": "Spanish (Ecuador)",
//            "es-cl": "Spanish (Chile)",
//            "es-uy": "Spanish (Uruguay)",
//            "es-py": "Spanish (Paraguay)",
//            "es-bo": "Spanish (Bolivia)",
//            "es-sv": "Spanish (El Salvador)",
//            "es-hn": "Spanish (Honduras)",
//            "es-ni": "Spanish (Nicaragua)",
//            "es-pr": "Spanish (Puerto Rico)",
//            "sx": "Sutu",
//            "sv": "Swedish",
//            "sv-fi": "Swedish (Finland)",
//            "ts": "Tsonga",
//            "tn": "Tswana",
//            "tr": "Turkish",
//            "uk": "Ukrainian",
//            "ur": "Urdu",
//            "ve": "Venda",
//            "vi": "Vietnamese",
//            "xh": "Xhosa",
//            "ji": "Yiddish",
//            "zu": "Zulu"
    ]

    @IBOutlet var Language: UIPickerView!


    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {

        return 1

    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // Identifying pickerviews with their tag values
        if (pickerView.tag == 0) {
            return LanguageData.count
        } else {
            return 0
        }
    }

    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if (pickerView.tag == 0) {
            var c = 0
            for (languageCode, languageName) in LanguageData {
                if (c == row) {
                    return LanguageData[languageCode]
                }
                c++
            }
        }
        return ""
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        var c = 0
        for (languageCode, languageName) in LanguageData {
            if (c == row) {
                // Store the Language Name & Code
                cs.LanguageCode = languageCode
                cs.LanguageName = LanguageData[languageCode]
                let sample = LanguageData[languageCode]!
                saveLanguageDelegate?.upadteLanguage(sample)
                
            }
            c++
        }
       
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Language.dataSource = self
        Language.delegate = self
        
        
        let ln =  cs.LanguageName
        var pickerRow = 0
        var s = 0
        for (languageCode, languageName) in LanguageData {
            if (s == pickerRow) {
                if (LanguageData[languageCode] == ln) {
                    pickerRow = s
                    break
                }
                
            }
            s++
            pickerRow++
            
        }
        
        Language.selectRow(pickerRow, inComponent: 0 , animated: true)
        self.view.addSubview(Language)
    
    }
    
}