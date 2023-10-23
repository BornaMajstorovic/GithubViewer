import Foundation

@freestanding(expression)
public macro URL(_ stringLiteral: String) -> URL = #externalMacro(module: "URLMacroMacros", type: "URLMacro")
