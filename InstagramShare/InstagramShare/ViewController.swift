
import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet var CurrentImgView: UIImageView!
    
    var imageKitty: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageKitty = UIImage(named: "Kitty.jpeg")!
        CurrentImgView.image = imageKitty
    }
    
    @IBAction func ButtonPressed(_ sender: Any) {
        //firstSolutionOption()
        //secondSolutionOption_image()
        //secondSolutionOption_video()
    }
    
    //share to post or stories and save
    func firstSolutionOption_image() {
        UIImageWriteToSavedPhotosAlbum(imageKitty, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if error != nil {
                print(error)
            }

            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)

            if let lastAsset = fetchResult.firstObject as? PHAsset {

               let url = URL(string: "instagram://library?LocalIdentifier=\(lastAsset.localIdentifier)")!
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Instagram is not installed", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }

            }
    }

    //share img to stories
    func secondSolutionOption_image() {
        if let urlScheme = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                let imageData: Data = imageKitty.pngData()!
                let items = [["com.instagram.sharedSticker.backgroundImage": imageData]]
                let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                UIPasteboard.general.setItems(items, options: pasteboardOptions)
                UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
            }
        }
    }
    
    //share video to stories
    func secondSolutionOption_video() {
        if let urlScheme = URL(string: "instagram-stories://share") {
            if UIApplication.shared.canOpenURL(urlScheme) {
                guard let urlString = Bundle.main.path(forResource: "hyperlapse", ofType: "mov") else { return }
                let urlVideo = URL(fileURLWithPath: urlString)
                
                let videoData:Data?
                
                do {
                    try videoData = Data(contentsOf: urlVideo)
                    let items = [["com.instagram.sharedSticker.backgroundVideo": videoData]]
                    let pasteboardOptions = [UIPasteboard.OptionsKey.expirationDate: Date().addingTimeInterval(60*5)]
                    UIPasteboard.general.setItems(items, options: pasteboardOptions)
                    UIApplication.shared.open(urlScheme, options: [:], completionHandler: nil)
                }
                catch { print("Cannot open \(urlVideo)") }
            }
        }
    }
}



