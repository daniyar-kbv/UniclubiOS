//
//  СourseDetailView.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/15/20.
//

import Foundation
import UIKit
import SnapKit

class СourseDetailView: BaseView {
    var course: CourseFull? {
        didSet {
            setUp()
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInsetAdjustmentBehavior = .never
        view.bounces = false
        view.showsVerticalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Global.safeAreaBottom() + StaticSize.buttonHeight + StaticSize.size(30), right: 0)
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [containerView])
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    lazy var sliderContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var imageSlider: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true
        view.register(CourseImagesDetailCell.self, forCellWithReuseIdentifier: CourseImagesDetailCell.reuseIdentifier)
        view.backgroundColor = .customBackround
        return view
    }()
    
    lazy var pagesView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = StaticSize.size(3)
        return view
    }()
    
    lazy var pagesLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(10), weight: .regular)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .ptSans(ofSize: StaticSize.size(22), weight: .bold)
        label.textColor = .customDarkBlue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var scheduleButton: CustomButtonDetail = {
        let view = CustomButtonDetail()
        view.backgroundColor = .white
        view.title.text = "Выбрать расписание"
        view.stack.spacing = 0
        return view
    }()
    
    lazy var rightArrow: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "arrowRight")
        return view
    }()
    
    lazy var descriptionView: DescriptionView = {
        let view = DescriptionView()
        view.titleLabel.text = "Описание"
        return view
    }()
    
    lazy var aboutClubView: DescriptionView = {
        let view = DescriptionView()
        view.titleLabel.text = "О клубе"
        return view
    }()
    
    lazy var contactsView: DescriptionView = {
        let view = DescriptionView()
        view.titleLabel.text = "Контактная информация"
        return view
    }()
    
    lazy var descriptionStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [descriptionView])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.size(12)
        return view
    }()
    
    lazy var siteButton: CustomButtonDetail = {
        let view = CustomButtonDetail()
        view.backgroundColor = .white
        view.title.text = "Просмотреть сайт клуба"
        view.stack.spacing = 0
        return view
    }()
    
    lazy var ratingButton: CustomButtonDetail = {
        let view = CustomButtonDetail()
        view.title.text = "Посмотреть отзывы"
        view.leftImage.image = UIImage(named: "stars")?.withRenderingMode(.alwaysTemplate)
        view.leftImage.snp.makeConstraints({
            $0.size.equalTo(StaticSize.size(26))
        })
        return view
    }()
    
    lazy var chatButton: CustomButtonDetail = {
        let view = CustomButtonDetail()
        view.title.text = "Перейти в чат"
        view.backgroundColor = .white
        view.leftImage.image = UIImage(named: "chat")?.withRenderingMode(.alwaysTemplate)
        view.leftImage.snp.makeConstraints({
            $0.size.equalTo(StaticSize.size(26))
        })
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Выбрать расписание", for: .normal)
        return view
    }()
    
    lazy var reminderButton: ReminderButton = {
        let view = ReminderButton()
        return view
    }()
    
    lazy var topLine: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGray
        return view
    }()
    
    required init(withBar: Bool = true) {
        super.init(withBar: withBar)
        
        backgroundColor = .customBackround
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNumber(number: Int, total: Int) {
        pagesLabel.text = "\(number)/\(total)"
    }
    
    func setUp() {
        navigationBar.backgroundColor = .white
        
        addSubViews([reminderButton])

        reminderButton.snp.makeConstraints({
            $0.right.equalToSuperview()
            $0.top.equalTo(navigationBar)
            $0.size.equalTo(StaticSize.size(70))
        })
        
        navigationBar.addSubViews([topLine])

        topLine.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(1))
        })
        
        contentView.addSubViews([scrollView, bottomButton])
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true;
        scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true;
        scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true;
        scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true;

        scrollView.addSubview(stack)

        stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true;
        stack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true;
        stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true;
        stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true;
        stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true;
    
        scrollView.addSubViews([stack])
        
        containerView.addSubViews([sliderContainer, titleView, scheduleButton, descriptionStack, ratingButton, chatButton])
        
        sliderContainer.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(256))
        })
        
        sliderContainer.addSubViews([imageSlider, pagesView])
        
        imageSlider.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        pagesView.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.bottom.equalToSuperview().offset(-StaticSize.size(12))
        })
        
        pagesView.addSubViews([pagesLabel])
        
        pagesLabel.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(StaticSize.size(6))
        })
        
        titleView.snp.makeConstraints({
            $0.top.equalTo(imageSlider.snp.bottom)
            $0.left.right.equalToSuperview()
        })
        
        titleView.addSubViews([titleLabel])
        
        titleLabel.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(StaticSize.size(15))
        })
        
        scheduleButton.snp.makeConstraints({
            $0.top.equalTo(titleView.snp.bottom).offset(StaticSize.size(12))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(48))
        })
        
        descriptionStack.snp.makeConstraints({
            $0.top.equalTo(scheduleButton.snp.bottom).offset(StaticSize.size(12))
            $0.right.left.equalToSuperview()
        })
        
        if course?.user?.profile?.aboutClub != nil {
            descriptionStack.addArrangedSubview(aboutClubView)
        }
        
        if course?.user?.profile?.contacts != nil {
            descriptionStack.addArrangedSubview(contactsView)
        }
        
        if course?.user?.profile?.websiteUrl != nil {
            containerView.insertSubview(siteButton, aboveSubview: descriptionStack)
            
            siteButton.snp.makeConstraints({
                $0.top.equalTo(descriptionStack.snp.bottom).offset(StaticSize.size(32))
                $0.left.right.equalToSuperview()
                $0.height.equalTo(StaticSize.size(54))
            })
        }
        
        ratingButton.snp.makeConstraints({
            course?.user?.profile?.websiteUrl != nil ?
                $0.top.equalTo(siteButton.snp.bottom).offset(StaticSize.size(12)) :
                $0.top.equalTo(descriptionStack.snp.bottom).offset(StaticSize.size(32))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(54))
        })
        
        chatButton.snp.makeConstraints({
            $0.top.equalTo(ratingButton.snp.bottom).offset(StaticSize.size(12))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(54))
            $0.bottom.equalToSuperview().offset(StaticSize.size(-12))
        })
    }
}

            
