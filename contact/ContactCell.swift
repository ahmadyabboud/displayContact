

import UIKit
import Contacts
class ContactCell :UICollectionViewCell
{
    override var isHighlighted: Bool
        {
        didSet{
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        
    }
    var contact:contact?
    {
        didSet{
            if let name = contact?.familyName , let givenName = contact?.givenName
            {
                nameLable.text = "\(name)  \(givenName)"
            }
           imageView.image = contact?.image
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView()
    {
        
        addSubview(firstView)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: firstView)
        addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: firstView)
        firstView.addSubview(nameLable)

       firstView.addConstraintsWithFormat(format: "H:|-60-[v0]|", views: nameLable)
       firstView.addConstraintsWithFormat(format: "V:[v0(40)]", views: nameLable)
       firstView.addSubview(imageView)
       firstView.addConstraintsWithFormat(format: "H:|-10-[v0(40)]", views: imageView)
       firstView.addConstraintsWithFormat(format: "V:[v0(40)]", views: imageView)
       firstView.addConstraints([NSLayoutConstraint(item: imageView , attribute: .centerY, relatedBy: .equal, toItem: firstView, attribute: .centerY, multiplier: 1, constant: 0)])
         firstView.addConstraints([NSLayoutConstraint(item: nameLable , attribute: .centerY, relatedBy: .equal, toItem: firstView, attribute: .centerY, multiplier: 1, constant: 0)])
    }
   
    let imageView :UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20 
        image.layer.masksToBounds = true
        image.image = UIImage(named : "user")
        return image
    }()
    let nameLable :UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "name"
        label.textColor = UIColor.white
        return label
    }()
   
    let firstView:UIView = {
        let view = UIView()
        view.backgroundColor =   .gray
        return view
    }()
   
}

