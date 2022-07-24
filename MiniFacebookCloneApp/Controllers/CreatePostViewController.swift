import UIKit

class CreatePostViewController: UIViewController {
 let createViewModelObj = ViewModel()
 @IBOutlet weak var createPost: UITextField!
 override func viewDidLoad() {
  super.viewDidLoad()
   createViewModelObj.getUserIdInfo()
 }
 @IBAction func Submit() {
     self.createPost.text = ""
  print("you are clicked")
  createViewModelObj.PrintResponse(postData: createPost.text ?? "") {result in
   let data = Data(result.utf8)

   let model = try? JSONDecoder().decode(Welcome.self, from: data)
   DispatchQueue.main.async {
     print(model?.message)
       let homeviewVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
       self.navigationController?.pushViewController(homeviewVC, animated: true)
   }
      
  }
 }
}
