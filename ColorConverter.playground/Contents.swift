import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        guard hex.hasPrefix("#") && (hex.count == 9 || hex.count == 7) else { return nil }
        var hexa = hex

        if hex.count == 7 {
            hexa += "FF"
        }

        let start = hexa.index(hexa.startIndex, offsetBy: 1)
        let hexColor = String(hexa[start...])
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        guard scanner.scanHexInt64(&hexNumber) == true else { return nil }

        let r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
        let g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
        let b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
        let a = CGFloat(hexNumber & 0x000000ff) / 255

        self.init(red: r, green: g, blue: b, alpha: a)
    }

    var rgbaBase255: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red * 255, green * 255, blue * 255, alpha)
    }
    
    
    var rgbaBase1: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red.roundDecimals(), green.roundDecimals(), blue.roundDecimals(), alpha.roundDecimals())
    }

    var hexString: String {
        let rgba = rgbaBase255

        var color = String(
            format: "#%02lX%02lX%02lX",
            lroundf(Float(rgba.red)),
            lroundf(Float(rgba.green)),
            lroundf(Float(rgba.blue))
        )
        if rgba.alpha < 1 {
            color += String(format: "%02lX", lroundf(Float(rgba.alpha)))
        }
        return color
    }
}

extension CGFloat {
    mutating func roundDecimals(_ decimals: Int = 2) -> CGFloat {
        let d = pow(10.0, CGFloat(decimals))
        return CGFloat((self*d).rounded()/d)
    }
}
