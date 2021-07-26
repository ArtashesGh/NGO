//
//  OrderViewController.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/9/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import PassKit

protocol OrderDisplayLogic: class
{
    func displaySomething(isUserOrder:Bool, orderId:String)
    func displayGetSuccess(dispelyedOrderElements:[OrderDispleyElement])
    func displeySaveOrderSuccess()
    func displayPaymentSucces()
    func displayError()
    func showLoader()
    func hideLoader()
}

class OrderViewController: UIViewController, OrderDisplayLogic
{
    var interactor: OrderBusinessLogic?
    var router: (NSObjectProtocol & OrderRoutingLogic & OrderDataPassing)?
    

    @IBOutlet weak var applePaybackView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alertImageView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertBackView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var applePayButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var paymentRequest = PKPaymentRequest()
    let paymentNetwork = [PKPaymentNetwork.amex, .visa, .masterCard, .discover]
    private var paymentRequestString: String = ""
    
    var isUserOrder: Bool = false
    var orderId: String = ""
    
    var dispelyedData : [OrderDispleyElement] = []
    var dispelyedSavedData : [OrderDispleyElement] = []
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = OrderInteractor()
        let presenter = OrderPresenter()
        let router = OrderRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        alertBackView.addGestureRecognizer(tap)
        var button: UIButton?

            button = PKPaymentButton(paymentButtonType: .buy, paymentButtonStyle: .black)
            button?.addTarget(self, action:#selector(applePayButtonTapped(sender:)), for: .touchUpInside)

        if let applePayButton = button {
            let constraints = [
                applePayButton.centerXAnchor.constraint(equalTo: applePaybackView.centerXAnchor),
                applePayButton.centerYAnchor.constraint(equalTo: applePaybackView.centerYAnchor)
            ]
            applePayButton.translatesAutoresizingMaskIntoConstraints = false
            applePaybackView.addSubview(applePayButton)
            NSLayoutConstraint.activate(constraints)
        }

        
        doSomething()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
//        let paymentButton = PKPaymentButton(paymentButtonType: .inStore, paymentButtonStyle: .whiteOutline)
//
//        paymentButton.widthAnchor.constraint(equalToConstant: applePaybackView.frame.size.width).isActive = true
//
//        paymentButton.heightAnchor.constraint(equalToConstant: applePaybackView.frame.size.height).isActive = true
////        paymentButton.translatesAutoresizingMaskIntoConstraints = false
//        paymentButton.addTarget(self, action: #selector(applePayButtonTapped(sender:)), for: .touchUpInside)
//
//        applePaybackView.addSubview(paymentButton)
//        backView.roundCorners(corners: .topRight, radius: 50)
//        payButton.roundCorners(corners:[.topLeft, .bottomLeft], radius: 20.0)
////        applePaybackView.roundCorners(corners:[.topLeft, .bottomLeft], radius: 20.0)
    }
    
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = Order.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(isUserOrder:Bool, orderId:String)
    {
        self.isUserOrder = isUserOrder
        self.orderId = orderId
        if self.isUserOrder {
            interactor?.doGetUserOrder(orderID: self.orderId)
            payButton.setTitle("Оплатить услугу", for: .normal)
            return
        }
        interactor?.doGetOneOrder(orderID: self.orderId)
        payButton.setTitle("Заказ услуги", for: .normal)
    }
    
    func displayGetSuccess(dispelyedOrderElements:[OrderDispleyElement]) {
        DispatchQueue.main.async {
            
            let displeyElementDocButton = OrderDispleyElement(cellType: .docsButton)
            self.dispelyedData = dispelyedOrderElements
            self.nameLabel.text = self.dispelyedData.first?.title ?? ""
            self.priceLabel.text = (self.dispelyedData.first?.subTitle ?? "") + " ₽"
            self.dispelyedSavedData = dispelyedOrderElements
            if !self.isUserOrder {
                self.dispelyedData.append(displeyElementDocButton)
            }
           
            self.tableView.reloadData()
        }
    }
    
    func displeySaveOrderSuccess() {
        DispatchQueue.main.async {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[0], animated: true)
        }
    }
    
    func displayError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Ошибка", message: "", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Hide & Show Loader
    
    func showLoader() {
        view.showLoader()
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.view.removeLoader()
        }
    }
    
    @objc private func applePayButtonTapped(sender: UIButton) {
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetwork) {
            
            let formatter = NumberFormatter()
            formatter.generatesDecimalNumbers = true
            let decimalNumber:NSDecimalNumber = formatter.number(from: self.dispelyedData.first?.subTitle ?? "") as? NSDecimalNumber ?? 0
            paymentRequest.currencyCode = "RUB"
            paymentRequest.countryCode = "RU"
            paymentRequest.merchantIdentifier = "merchant.com.era.firstngo"
            paymentRequest.supportedNetworks = paymentNetwork
            paymentRequest.merchantCapabilities = .capability3DS
            var summaryItems = [PKPaymentSummaryItem]()
            summaryItems.append(PKPaymentSummaryItem(label: self.dispelyedData.first?.title ?? "", amount: decimalNumber))
            summaryItems.append(PKPaymentSummaryItem(label: "1stNGOLAB", amount: decimalNumber))
            paymentRequest.paymentSummaryItems = summaryItems
            let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            applePayVC?.delegate = self
            present(applePayVC!, animated: true, completion: nil)
        }
    }
    @IBAction func applePayButtonAction(_ sender: Any) {
       
    }
    
    @IBAction func payButtonAction(_ sender: Any) {
        if !isUserOrder {
            var docIdElement : [String:Any]?
            var docIds: [[String:Any]]?
            for dispElem in self.dispelyedSavedData {
                if dispElem.cellType == .docs {
                    docIdElement = ["docIds":dispElem.docId ?? 0]
                    docIds?.append(docIdElement ?? [:])
                }
                
            }
            interactor?.doOrderCreate(productID: self.orderId, docsIds: docIds ?? [])
        } else {
            showApplePayAlert()
        }
    }
    
    func showApplePayAlert()  {
        
        alertBackView.isHidden = false
        alertImageView.isHidden = false
        self.bottomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideApplePayAlert()  {
        alertBackView.isHidden = true
        alertImageView.isHidden = true
        self.bottomConstraint.constant = -230
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        hideApplePayAlert()
    }
    
    func itemToSell(shipping: Double) -> [PKPaymentSummaryItem] {
        let totalPrice = PKPaymentSummaryItem(label: "Итог", amount: NSDecimalNumber(value: shipping))
        return [totalPrice]
    }
    
    func displayPaymentSucces() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "", message: "Спасибо Ваша оплата принята, с Вами свяжется наш менеджер.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "ОК", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                   self.navigationController!.popToViewController(viewControllers[0], animated: true)
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func chatButtonAction(_ sender: Any) {
        router?.routeToChat()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension OrderViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dispelyedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dispElement = dispelyedData[indexPath.row]
        switch dispElement.cellType {
        case .name:
            let cell = tableView.dequeueReusableCell(withIdentifier:"OrderNameTableViewCell") as! OrderNameTableViewCell
            cell.nameLabel.text = dispElement.title
            cell.priceLAbel.text = dispElement.subTitle + " ₽"
            return cell
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier:"OrderTypeTableViewCell") as! OrderTypeTableViewCell
            cell.typeNameLabel.textInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
            cell.typeNameLabel.layer.cornerRadius = 9
            cell.typeNameLabel.clipsToBounds = true
            switch dispElement.title {
            case "COMPLETE":
                cell.typeNameLabel.text = "Выполнена"
                cell.typeNameLabel.backgroundColor = Constants.Colors.orderGreenColor
            case "INPROGRESS":
                cell.typeNameLabel.text = "В процессе выполнения"
                cell.typeNameLabel.backgroundColor = Constants.Colors.orderSirenColor
            case "NOTPAID":
                cell.typeNameLabel.text = "Не оплачено"
                cell.typeNameLabel.backgroundColor = Constants.Colors.orderRedColor
            case "PAID":
                cell.typeNameLabel.text = "Оплачено, готово к отправке"
                cell.typeNameLabel.backgroundColor = Constants.Colors.orderBlueColor
            case "REVISION":
                cell.typeNameLabel.text = "На доработке"
                cell.typeNameLabel.backgroundColor = Constants.Colors.orderGreyColor
                
            default:
                print(dispElement.title ?? "")
            }
            return cell
        case .desc:
            let cell = tableView.dequeueReusableCell(withIdentifier:"OrderDescriptionTableViewCell") as! OrderDescriptionTableViewCell
            cell.desLabel.text = dispElement.title
            return cell
        case .docs:
            let cell = tableView.dequeueReusableCell(withIdentifier:"OrderDocInfoTableViewCell") as! OrderDocInfoTableViewCell
            cell.nameLabel.text = dispElement.title
            cell.dateLabel.text = dispElement.subTitle
            return cell
        case .docsButton:
            let cell = tableView.dequeueReusableCell(withIdentifier:"OrderDocumentTableViewCell") as! OrderDocumentTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier:"OrderNameTableViewCell") as! OrderNameTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dispElement = dispelyedData[indexPath.row]
        switch dispElement.cellType {
        case .docsButton:
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                print("Button capture")
                
                imagePicker.delegate = self
                imagePicker.sourceType = .savedPhotosAlbum
                imagePicker.allowsEditing = false
                
                present(imagePicker, animated: true, completion: nil)
            }
        default:
            
            print("test")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dispElement = dispelyedData[indexPath.row]
        switch dispElement.cellType {
        case .name:
            return 60
        case .status:
            return 20
        case .desc:
            return estimatedHeightOfLabel(text: dispElement.title ?? "", leading: 50.0) + 30
        case .docs:
            return 60
        case .docsButton:
            return 66
        default:
            return 60
        }
        
    }
}

extension OrderViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
                   
               })
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        interactor?.doUploadImage(image: image, displeyElements: dispelyedSavedData)
    }
    
}

extension OrderViewController: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
        if !paymentRequestString.isEmpty {
            hideApplePayAlert()
            interactor?.doPayment(orderId: self.orderId, paymentData: paymentRequestString)
            paymentRequestString = ""
        }
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        let token = payment.token
        let paymentData = token.paymentData
        let b64TokenStr = paymentData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        paymentRequestString = b64TokenStr
        completion(.success)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didSelect shippingMethod: PKShippingMethod, completion: @escaping (PKPaymentAuthorizationStatus, [PKPaymentSummaryItem]) -> Void) {
        completion(.success, itemToSell(shipping: Double(truncating: shippingMethod.amount)))
    }
}
