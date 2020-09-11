
import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet var CurrentImgView: UIImageView!
    
    var image: UIImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        image = UIImage(named: "Kitty.jpeg")!
        CurrentImgView.image = image
    }
    
    @IBAction func ButtonPressed(_ sender: Any) {
        postImageToInstagram(image: image)
    }
    
    func postImageToInstagram(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
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
                print("123: \(lastAsset.localIdentifier)")

                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Instagram is not installed", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }

            }
    }

}

