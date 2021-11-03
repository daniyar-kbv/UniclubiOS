//
//  CoursesListCell.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/11/20.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class CoursesListCell: UITableViewCell {
    static let reuseIdentifier = "CoursesListCell"
    
    var course: CourseShort? {
        didSet {
            if let image = course?.image {
                mainImage.kf.setImage(with: URL(string: image))
                mainImage.snp.remakeConstraints({
                    $0.edges.equalToSuperview()
                })
            } else {
                mainImage.image = UIImage(named: "image")?.withRenderingMode(.alwaysTemplate)
                mainImage.tintColor = .customDarkBlue
                mainImage.snp.remakeConstraints({
                    $0.center.equalToSuperview()
                    $0.size.equalTo(StaticSize.size(80))
                })
            }
            title.text = course?.name
            clubNameLabel.text = course?.user?.profile?.clubName
            subtitle.text = course?.shortDescription
        }
    }
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 4.0
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(10)
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var imageContainer: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .customBackround
        return view
    }()
    
    lazy var mainImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(20), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var clubNameLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(15), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(15), weight: .regular)
        label.textColor = .customDarkBlue
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var leftButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "stars"), for: .normal)
        view.setTitle("Посмотреть отзывы", for: .normal)
        view.setTitleColor(.customGreen, for: .normal)
        view.titleLabel?.font = .ptSans(ofSize: StaticSize.size(13), weight: .regular)
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: StaticSize.size(3.5))
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: StaticSize.size(3.5), bottom: 0, right: 0)
        view.addTarget(self, action: #selector(openRatings), for: .touchUpInside)
        return view
    }()
    
    lazy var rightButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = superview?.backgroundColor
        view.setImage(UIImage(named: "chat"), for: .normal)
        view.setTitle("Перейти в чат", for: .normal)
        view.setTitleColor(.customGreen, for: .normal)
        view.titleLabel?.font = .ptSans(ofSize: StaticSize.size(13), weight: .regular)
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: StaticSize.size(3.5))
        view.titleEdgeInsets = UIEdgeInsets(top: 0, left: StaticSize.size(3.5), bottom: 0, right: 0)
        view.addTarget(self, action: #selector(openChat), for: .touchUpInside)
        return view
    }()
    
    @objc func openRatings() {
        guard let id = course?.id, let url = URL(string: "tg://resolve?domain=UniClub_reviews_bot?start=\(id)"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openChat() {
        guard let url = URL(string: "tg://resolve?domain=uniclub_chat"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubview(shadowView)
        
        shadowView.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.size(16))
            $0.top.bottom.equalToSuperview().inset(StaticSize.size(8))
        })
        
        shadowView.addSubview(containerView)
        
        containerView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        containerView.addSubViews([imageContainer, title, clubNameLabel, subtitle, leftButton, rightButton])
        
        imageContainer.snp.makeConstraints({
            $0.top.right.left.equalToSuperview()
            $0.height.equalTo(StaticSize.size(124))
        })
        
        imageContainer.addSubview(mainImage)
        mainImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        title.snp.makeConstraints({
            $0.top.equalTo(imageContainer.snp.bottom).offset(StaticSize.size(3))
            $0.left.right.equalToSuperview().inset(StaticSize.size(12))
        })
        
        clubNameLabel.snp.makeConstraints({
            $0.top.equalTo(title.snp.bottom).offset(StaticSize.size(2))
            $0.left.right.equalToSuperview().inset(StaticSize.size(12))
        })
        
        subtitle.snp.makeConstraints({
            $0.top.equalTo(clubNameLabel.snp.bottom).offset(StaticSize.size(2))
            $0.left.right.equalToSuperview().inset(StaticSize.size(12))
        })
        
        leftButton.snp.makeConstraints({
            $0.width.equalTo(StaticSize.size(168))
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.height.equalTo(StaticSize.size(40))
        })
        
        rightButton.snp.makeConstraints({
            $0.width.equalTo(StaticSize.size(140))
            $0.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(40))
        })
    }
}
