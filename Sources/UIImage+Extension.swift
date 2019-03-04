// Copyright © 2016-19 JABT Labs Inc.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        let vertical = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: size.height)
        if #available(iOS 10.0, *) {
            return UIGraphicsImageRenderer(size: size).image { _ in
                let ctx = UIGraphicsGetCurrentContext()
                ctx?.saveGState()
                ctx?.concatenate(vertical)
                draw(in: rect)
                ctx?.restoreGState()
                UIGraphicsEndImageContext()
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.saveGState()
            ctx?.concatenate(vertical)
            draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: size.width, height: size.height)))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            ctx?.restoreGState()
            return newImage
        }
    }
}
