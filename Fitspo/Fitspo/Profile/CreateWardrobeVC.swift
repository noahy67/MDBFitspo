//
//  CreateWardrobeVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/26/22.
//

import UIKit
import Firebase
import NotificationBannerSwift
import iOSDropDown


class CreateWardrobeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let storage = Storage.storage()
    
    var tempImage: UIImage? = nil
    
    var didTakePicture: Bool = false
    
    public var typeText: String = ""
    
    var colorText: String = ""
    
    var brandText: String = ""
    
    func setTypeText(vc: CreateWardrobeVC, new: String) {
        vc.typeText = new
    }
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Back ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .fitOrange
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let doneButton: LoadingButton = {
        let btn = LoadingButton()
        btn.layer.backgroundColor = UIColor.fitOrange.cgColor
        btn.setTitle(" Done ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.isUserInteractionEnabled = true
        
        
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    private let photoButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" Take Item Picture ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .fitOrange
        btn.layer.cornerRadius = 10
        btn.layer.shadowRadius = 10
        btn.layer.shadowColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 50

        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let tagTextField: AuthTextField = {
        let tf = AuthTextField(title: "Item name:")
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let profilePhotoTest: UIImageView = {
        let img = UIImageView()
        img.layer.borderColor = UIColor.fitOrange.cgColor
        img.layer.borderWidth = 5
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        img.layer.cornerRadius = 20
        img.sizeThatFits(CGSize.init(width: 150, height: 150))
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    public let typeDropDown: DropDown = {
        let dd = DropDown(frame: CGRect(x: 110, y: 140, width: 200, height: 60))
        dd.isSearchEnable = true
        dd.optionArray = ["Top", "Bottom", "Shoes", "Headwear", "Outerwear"]
        dd.cornerRadius = 10
        dd.selectedRowColor = .fitOrange
        dd.arrowColor = .fitOrange
        dd.rowHeight = 30
        dd.backgroundColor = UIColor(hex: "#f7f7f7")
        
        dd.didSelect { selectedText, index, id in
            print("This SelectedText is: \(selectedText)")
            
        }
        dd.translatesAutoresizingMaskIntoConstraints = false
        return dd
    }()

    
    public let typeDDLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .secondaryText
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13, weight: .semibold)
        lbl.text = "SELECT THE ITEM TYPE:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let brandDropDown: DropDown = {
        let dd = DropDown(frame: CGRect(x: 110, y: 140, width: 200, height: 60))
        dd.isSearchEnable = true
        dd.optionArray = ["Nike", "Louis Vuitton", "Hermes", "Gucci", "Zalando", "Adidas", "Tiffany & Co", "Zara", "H&M", "Cartier", "Lululemon", "Moncler", "Chanel", "Rolex", "Patek Philippe", "Prada", "Uniqlo", "Chow Tai Fook", "Swarovski", "Burberry", "Polo Ralph Lauren", "Tom Ford", "The North Face", "Levi’s", "Victoria’s Secret", "Next", "New Balance", "Michael Kors", "Skechers", "TJ Maxx", "ASOS", "Under Armour", "Coach", "Nordstrom", "C&A", "Chopard", "Dolce & Gabbana", "Christian Louboutin", "Omega", "Foot Locker Inc", "Ray Ban", "Macy’s", "Asics", "Vera Wang", "Dior", "Puma", "Steve Madden", "Brunello Cucinelli", "American Eagle Outfitters", "Armani", "Nine West", "Fendi", "Urban Outfitters", "Salvatore Ferragamo", "Hugo Boss", "Old Navy", "IWC Schaffhausen", "Primark", "Max Mara", "Manolo Blahnik", "Audemars Piguet", "Diesel", "Calvin Klein", "Net-a-Porter", "Furla", "GAP", "Longines", "Forever", "Stuart Weitzman", "Longchamp", "Sisley", "Lao Feng Xiang", "TOD’s", "Tissot", "Tommy Hilfiger", "Tory Burch", "Lacoste", "Topshop", "G-star", "Aldo", "Oakley", "Cole Haan", "Jimmy Choo", "Valentino", "Elie Taharie", "Jaeger-Le Coultre", "Fossil", "Vacheron Constantin", "Elie Saab", "Patagonia", "Bogner", "New Look", "Breguet", "ESCADA", "Tag Heuer", "Banana Republic", "Desigual", "Swatch", "Cavalli", "Ted Baker"]
        dd.cornerRadius = 10
        dd.selectedRowColor = .fitOrange
        dd.arrowColor = .fitOrange
        dd.rowHeight = 30
        dd.backgroundColor = UIColor(hex: "#f7f7f7")
        
        
        dd.translatesAutoresizingMaskIntoConstraints = false
        return dd
    }()
    
    private let brandDDLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .secondaryText
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13, weight: .semibold)
        lbl.text = "SELECT THE ITEM BRAND:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let colorDropDown: DropDown = {
        let dd = DropDown(frame: CGRect(x: 110, y: 140, width: 200, height: 60))
        dd.isSearchEnable = true
        dd.optionArray = ["White", "Yellow", "Blue", "Red", "Green", "Black", "Brown", "Azure", "Ivory", "Teal", "Silver", "Purple", "Navy blue", "Pea green", "Gray", "Orange", "Maroon", "Charcoal", "Aquamarine", "Coral", "Fuchsia", "Wheat", "Lime", "Crimson", "Khaki", "Hot pink", "Magenta", "Olden", "Plum", "Olive", "Cyan"]
        dd.cornerRadius = 10
        dd.selectedRowColor = .fitOrange
        dd.arrowColor = .fitOrange
        dd.rowHeight = 30
        dd.backgroundColor = UIColor(hex: "#f7f7f7")
        
        
        dd.translatesAutoresizingMaskIntoConstraints = false
        return dd
    }()
    
    private let colorDDLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .secondaryText
        lbl.numberOfLines = 1
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 13, weight: .semibold)
        lbl.text = "SELECT THE ITEM COLOR:"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let contentEdgeInset = UIEdgeInsets(top: 120, left: 40, bottom: 30, right: 40)
    private var bannerQueue = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = .systemBackground
        
        typeDropDown.didSelect { selectedText, index, id in
            print("VEWDIDLOAD: \(selectedText)")
            self.typeText = selectedText
        }
        
        brandDropDown.didSelect { selectedText, index, id in
            self.brandText = selectedText
        }
        
        colorDropDown.didSelect { selectedText, index, id in
            self.colorText = selectedText
        }
        
        buttonConstraints()
        stackConstraints()
        view.addSubview(profilePhotoTest)
        NSLayoutConstraint.activate([
            profilePhotoTest.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 50),
            profilePhotoTest.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: -75),
            profilePhotoTest.trailingAnchor.constraint(equalTo: profilePhotoTest.leadingAnchor, constant: 150),
            profilePhotoTest.bottomAnchor.constraint(equalTo: profilePhotoTest.topAnchor, constant: 150)
        ])
        
        view.addSubview(typeDDLabel)
        NSLayoutConstraint.activate([
            typeDDLabel.bottomAnchor.constraint(equalTo: typeDropDown.topAnchor, constant: -10),
            typeDDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentEdgeInset.left)
        ])
        view.addSubview(brandDDLabel)
        NSLayoutConstraint.activate([
            brandDDLabel.bottomAnchor.constraint(equalTo: brandDropDown.topAnchor, constant: -10),
            brandDDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentEdgeInset.left)
        ])
        view.addSubview(colorDDLabel)
        NSLayoutConstraint.activate([
            colorDDLabel.bottomAnchor.constraint(equalTo: colorDropDown.topAnchor, constant: -10),
            colorDDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: contentEdgeInset.left)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        doneButton.isUserInteractionEnabled = true
        doneButton.hideLoading()
        presentingViewController?.viewWillAppear(true)
    }
    
    private func buttonConstraints() {
        view.addSubview(backButton)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
            ])
        
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            ])
        
        backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        
        doneButton.addTarget(self, action: #selector(didTapDone(_:)), for: .touchUpInside)
    }
    
    private func stackConstraints() {
        view.addSubview(stack)
        stack.addArrangedSubview(tagTextField)
        stack.addArrangedSubview(typeDropDown)
        stack.addArrangedSubview(brandDropDown)
        stack.addArrangedSubview(colorDropDown)
        stack.addArrangedSubview(photoButton)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: contentEdgeInset.left),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -contentEdgeInset.right),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: 180)
        ])
        
        photoButton.addTarget(self, action: #selector(didTapPhotoButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapBackButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapDone(_ sender: UIButton) {
        
        doneButton.showLoading()
        sender.isUserInteractionEnabled = false
        
        guard let newTag = tagTextField.text else { return }
        
        if newTag == "" {
            self.showErrorBanner(withTitle: "No Item Name Added", subtitle: "Cannot create a wardrobe item without a name, please create one or click the back button")
            sender.isUserInteractionEnabled = true
            return
        }
        
        if didTakePicture == false {
            self.showErrorBanner(withTitle: "No Picture Added", subtitle: "Cannot create a wardrobe item without a picture, please select one or click the back button")
            sender.isUserInteractionEnabled = true
            return
        }
        
        let idd = UUID().uuidString
        
        guard let dude = AuthManager.shared.currentUser else { return }
        guard let dudeID = dude.uid else { return }
        
        var newWardrobe: WardrobeItem = WardrobeItem(creator: dudeID, tag: newTag, color: colorText, brand: brandText, type: typeText, itemURL: "", photoURL: "")
        
        if didTakePicture == true && tempImage != nil {
            
            guard let tempy = tempImage else { return }
            
            StorageManager.shared.uploadWardrobePicture(with: tempy, fileName: idd) { result in
                switch result {
                case .success(let downloadURL):
                    newWardrobe.photoURL = downloadURL
                    print(downloadURL)
                   
                    DatabaseRequest.shared.setWardrobeItem(newWardrobe) { (self.dismiss(animated: true, completion: nil)) }
                
                case .failure(let error):
                    print("Storage Manager Error \(error)")
                }
            }
        } else {
            DatabaseRequest.shared.setWardrobeItem(newWardrobe) { (self.dismiss(animated: true, completion: nil)) }
        }
    }
    
    @objc private func didTapPhotoButton(_ sender: UIButton) {
        presentPhotoActionSheet()
    }
    
    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default,
                                            handler: { [weak self] _ in
            
            self?.presentPhotoPicker()
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        profilePhotoTest.contentMode = .scaleAspectFit
        profilePhotoTest.image = image
        tempImage = image
        didTakePicture = true
        
        
        picker.dismiss(animated: true) { () }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    private func showErrorBanner(withTitle title: String, subtitle: String? = nil) {
        showBanner(withStyle: .warning, title: title, subtitle: subtitle)
    }
    
    private func showBanner(withStyle style: BannerStyle, title: String, subtitle: String?) {
        guard bannerQueue.numberOfBanners == 0 else { return }
        let banner = FloatingNotificationBanner(title: title, subtitle: subtitle,
                                                titleFont: .systemFont(ofSize: 17, weight: .medium),
                                                subtitleFont: .systemFont(ofSize: 14, weight: .regular),
                                                style: style)
        
        banner.show(bannerPosition: .top,
                    queue: bannerQueue,
                    edgeInsets: UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15),
                    cornerRadius: 10,
                    shadowColor: .primaryText,
                    shadowOpacity: 0.3,
                    shadowBlurRadius: 10)
        
    }

}
