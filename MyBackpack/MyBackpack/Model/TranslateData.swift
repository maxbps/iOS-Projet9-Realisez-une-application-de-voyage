import Foundation

// this is the structure of the response of translation.googleapi
struct TranslateData: Decodable {
    let data: TranslationData
}

struct TranslationData: Decodable {
    let translations: [TranslationText]
}

struct TranslationText: Decodable {
    let translatedText: String?
}
