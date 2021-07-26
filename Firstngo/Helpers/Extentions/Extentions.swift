//
//  Extentions.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

//MARK: -  Detect ios device type extensions

public enum Model : String {
    case simulator = "simulator/sandbox",
    iPhone4        = "iPhone 4",
    iPhone4S       = "iPhone 4S",
    iPhone5        = "iPhone 5",
    iPhone5S       = "iPhone 5S",
    iPhone5C       = "iPhone 5C",
    iPhone6        = "iPhone 6",
    iPhone6Plus    = "iPhone 6 Plus",
    iPhone6S       = "iPhone 6S",
    iPhone6SPlus   = "iPhone 6S Plus",
    iPhone7        = "iPhone 7",
    iPhone7Plus    = "iPhone 7 Plus",
    iPhoneSE       = "iPhone SE",
    iPhone8        = "iPhone 8",
    iPhone8Plus    = "iPhone 8 Plus",
    iPhoneX        = "iPhone X",
    iPhoneXS       = "iPhone XS",
    iPhoneXSMax    = "iPhone XS Max",
    iPhoneXR       = "iPhone XR",
    iPhone11       = "iPhone 11",
    iPhone11Pro    = "iPhone 11 Pro",
    iPhone11ProMax = "iPhone 11 Pro Max",
    unrecognized   = "?unrecognized?"
}

public extension UIDevice {
    
    var type: Model {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafeMutablePointer(to: &systemInfo.machine) {
            ptr in String(cString: UnsafeRawPointer(ptr).assumingMemoryBound(to: CChar.self))
        }
        let modelMap : [ String : Model ] = [
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            
            "iPhone7,2" : .iPhone6,
            "iPhone7,1" : .iPhone6Plus,
            
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6SPlus,
            
            "iPhone8,4" : .iPhoneSE,
            
            "iPhone9,1" : .iPhone7,
            "iPhone9,3" : .iPhone7,
            "iPhone9,2" : .iPhone7Plus,
            "iPhone9,4" : .iPhone7Plus,
            
            "iPhone10,1" : .iPhone8,
            "iPhone10,4" : .iPhone8,
            "iPhone10,2" : .iPhone8Plus,
            "iPhone10,5" : .iPhone8Plus,
            
            "iPhone10,3": .iPhoneX,
            "iPhone10,6": .iPhoneX,
            
            "iPhone11,2": .iPhoneXS,
            "iPhone11,4": .iPhoneXSMax,
            "iPhone11,6": .iPhoneXSMax,
            "iPhone11,8": .iPhoneXR,
            
            "iPhone12,1":.iPhone11,
            "iPhone12,3":.iPhone11Pro,
            "iPhone12,5":.iPhone11ProMax
        ]
        
        if let model = modelMap[ String( modelCode)] {
            return model
        }
        
        return .unrecognized
    }
    
}

//MARK: - Loader view

let spinner = Constants.Storyboards.alertStoryboard.instantiateViewController(withIdentifier: "LoadingViewController") as! LoadingViewController
let loadingView = spinner.view
public extension UIView {
    func showLoader() {
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(loadingView!)
    }

    func removeLoader() {
        loadingView!.removeFromSuperview()
    }

    func animate(show: Bool, duration: TimeInterval, completion: @escaping ((Bool) -> Void) = {_ in }) {
        if show {
            alpha = 0.0
            isHidden = false
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1.0
            }, completion: { (finished) in
                completion(finished)
            })
            return
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        }, completion: { (finished) in
            self.isHidden = true
            completion(finished)
        })
    }
}

//MARK: - Strings

extension String {
    
    init(htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }
}
extension NSDate {
    //NSString to NSDate
    convenience
    init(dateString:String) {
        self.init()
        let nsDateFormatter = DateFormatter()
        nsDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    }

    //NSDate to time string
    func getTime() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "ru_RU")
        timeFormatter.dateFormat = "HH.mm"
        //Can also set the default styles for date or time using .timeStyle or .dateStyle
        return timeFormatter.string(from: self as Date)
    }

    //NSDate to date string
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMM. yyyy г."
        return dateFormatter.string(from: self as Date)
    }

    //NSDate to String
    func getString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self as Date)
    }
}

//MARK: - ScrollView

extension UIScrollView {
    func adjustContentOffsetTo(_ view: UIView, topInset: CGFloat = 20) {
        let potentialOffset = view.convert(CGPoint(x: view.frame.minX, y: view.frame.minY - topInset), to: self).y
        let maxOffset = contentSize.height + contentInset.top + contentInset.bottom - frame.height
        let finalOffset = max(min(potentialOffset, maxOffset), 0)
        DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: finalOffset), animated: true)
        }
    }
}

//MARK: - View
extension UIView {

    @discardableResult
    func applyGradient(colours: [UIColor], startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}


extension UITableView {

    func scrollToBottom(){

       DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    func scrollToTop() {

        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}

//MARK: - Array
extension Array {
    
    mutating func remove(at indexs: [Int]) {
        guard !isEmpty else { return }
        let newIndexs = Set(indexs).sorted(by: >)
        newIndexs.forEach {
            guard $0 < count, $0 >= 0 else { return }
            remove(at: $0)
        }
    }
    
}

//MARK: - ViewController

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func estimatedHeightOfLabel(text: String, leading:CGFloat ) -> CGFloat {
        
        let size = CGSize(width: view.frame.width - leading, height: 1000)
        
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: Constants.Roboto.regular, size: 13) ]
        
        let rectangleHeight = String(text).boundingRect(with: size, options: options, attributes: attributes as [NSAttributedString.Key : Any], context: nil).height
        
        return rectangleHeight
    }
}

//MARK: - Button

extension UIButton {
    
    func activationState(active: Bool)  {
        var bgColor = UIColor(red:206.0/255.0, green:205.0/255.0, blue:210.0/255.0, alpha:1)
        let textColor = UIColor.white
        if active {
            bgColor = UIColor(red:255.0/255.0, green:131.0/255.0, blue:21.0/255.0, alpha:1)
        }
        backgroundColor = bgColor
        setTitleColor(textColor, for: .normal)
        isEnabled = active
    }
    
}

//MARK: - URL

extension URL {
    /// Returns a new URL by adding the query items, or nil if the URL doesn't support it.
    /// URL must conform to RFC 3986.
    func appending(_ queryItems: [URLQueryItem]) -> URL? {
        guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            // URL is not conforming to RFC 3986 (maybe it is only conforming to RFC 1808, RFC 1738, and RFC 2732)
            return nil
        }
        // append the query items to the existing ones
        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItems

        // return the url from new url components
        return urlComponents.url
    }
}

