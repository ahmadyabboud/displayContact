

import UIKit
import Contacts
import CoreData

class ViewController: UIViewController {
    lazy var contactsCollectionView: ContactCollectionView = {
        let launcher = ContactCollectionView()
        launcher.viewController = self
        return launcher
    }()

    @IBOutlet weak var showButton: UIButton!
    @IBAction func showContact(_ sender: Any) {
          contactsCollectionView.showContacts()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
      //   fetchContact()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        contactsCollectionView.fetchContact()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    

}

