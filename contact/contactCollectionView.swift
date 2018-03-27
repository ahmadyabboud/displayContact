
import UIKit
import Contacts
class contact{
    var givenName:String = ""
    var familyName:String = ""
    var image:UIImage = UIImage(named : "user")!
    var numbers = [number]()
    var emails = [email]()
    
}
class number
{
    var number:String = ""
    var description:String = ""
    init(num:String,desc:String) {
        number = num
        description = desc
    }
}
class email
{
    var email:String = ""
    var description:String = ""
    init(ema:String,desc:String) {
        email = ema
        description = desc
    }
}
class ContactCollectionView : NSObject,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    
    var contacts = [contact]()
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContactCell.self, forCellWithReuseIdentifier: "cellId")
     
      
    }
    var blackView = UIView()
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1)
        return cv
    }()
    var viewController:ViewController?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ContactCell
        cell.contact = contacts[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select contact \(contacts[indexPath.item].givenName)")
    }
    
  
   
    @objc func showContacts()
    {
        if let window = UIApplication.shared.keyWindow
        {
          
            (viewController)?.view.addSubview(blackView)
            blackView.addSubview(collectionView)
            let y = (viewController?.showButton.frame.maxY)! + 20
            blackView.frame = CGRect(x: 0, y: y, width: window.frame.width, height: 0)
             self.collectionView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: 0)
             UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.frame.size.height = window.frame.height - y
                self.collectionView.frame.size.height = window.frame.height - y
                
            }, completion: {
                (value: Bool) in
              
            })
            
        }
    }
    func fetchContact()
    {
      //  print("fetch Contact")
        let store = CNContactStore()
        store.requestAccess(for: .contacts) { (granted, error) in
            if error != nil
            {
              //  print("Faild to request access to the contact")
                return
            }
            if granted
            {
               // print(" access granted")
                DispatchQueue.main.async {
                    let keys = [CNContactImageDataKey,CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey,CNContactEmailAddressesKey]
                    let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                    do {
                        try store.enumerateContacts(with: request, usingBlock: { (contactt, stopTheEnum) in
                            var newCont:contact = contact()
                            newCont.givenName = contactt.givenName
                            newCont.familyName = contactt.familyName
                            if let img = contactt.imageData
                            {
                                newCont.image = UIImage(data : img)!
                            }
                            for cont in contactt.phoneNumbers
                            {
                              
                                
                                newCont.numbers.append(number(num: cont.value.stringValue, desc: cont.label!))
                                
                            }
                            for mail in contactt.emailAddresses
                            {
                               
                                newCont.emails.append(email(ema: mail.value as String, desc: mail.label!))
                                
                            }
                          
                          self.contacts.append(newCont)
                        })
                        
                    } catch{
                        print("faild to enumerate Contacts")
                    }
              
                
                }
              
            }
            else
            {
                print(" access denied")
            }
            
        }
       
      
    }
}

