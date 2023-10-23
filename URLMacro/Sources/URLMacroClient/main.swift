import Foundation
import URLMacro

let goodResult = #URL("https://www.google.com")

let end = ".com"
let badResult = #URL("https://www.google\(end)")

