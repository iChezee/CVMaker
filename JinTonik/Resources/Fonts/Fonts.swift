// swiftlint:disable all

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

internal typealias Font = FontConvertible.Font

// MARK: - Fonts
internal enum Fonts {
    enum WorkSans {
  static let bold700 = FontConvertible(name: "WorkSans-Bold", family: "Work Sans", path: "Bold.ttf")
  static let medium500 = FontConvertible(name: "WorkSans-Medium", family: "Work Sans", path: "Medium.ttf")
  static let regular400 = FontConvertible(name: "WorkSans-Regular", family: "Work Sans", path: "Regular.ttf")
  static let semiBold600 = FontConvertible(name: "WorkSans-SemiBold", family: "Work Sans", path: "SemiBold.ttf")
  static let all: [FontConvertible] = [bold700, medium500, regular400, semiBold600]
  static func registerAllCustomFonts() {
    all.forEach { $0.register() }
  }
  }
}
// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  #if os(macOS)
  internal typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Font = UIFont
  #endif

  func with(size: CGFloat) -> SwiftUI.Font {
    return SwiftUI.Font.custom(self, size: UIDevice.current.userInterfaceIdiom == .pad ? size * 2 : size)
  }

  internal func register() {
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate func registerIfNeeded() {
    if !UIFont.fontNames(forFamilyName: family).contains(name) {
      register()
    }
  }

  fileprivate var url: URL? {
    return BundleToken.bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension FontConvertible.Font {
  convenience init?(font: FontConvertible, size: CGFloat) {
    font.registerIfNeeded()
    self.init(name: font.name, size: size)
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Font {
  static func custom(_ font: FontConvertible, size: CGFloat) -> SwiftUI.Font {
    font.registerIfNeeded()
    return custom(font.name, size: size)
  }
    
    static func bold(_ size: CGFloat) -> SwiftUI.Font {
        let font = Fonts.WorkSans.bold700
        font.registerIfNeeded()
        return custom(font.name, size: size)
    }
    
    static func medium(_ size: CGFloat) -> SwiftUI.Font {
        let font = Fonts.WorkSans.medium500
        font.registerIfNeeded()
        return custom(font.name, size: size)
    }
    
    static func regular(_ size: CGFloat) -> SwiftUI.Font {
        let font = Fonts.WorkSans.regular400
        font.registerIfNeeded()
        return custom(font.name, size: size)
    }
    
    static func semibold(_ size: CGFloat) -> SwiftUI.Font {
        let font = Fonts.WorkSans.semiBold600
        font.registerIfNeeded()
        return custom(font.name, size: size)
    }
}

#endif

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable all
