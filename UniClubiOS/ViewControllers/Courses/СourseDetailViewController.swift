//
//  СourseDetailViewController.swift
//  UniClubiOS
//
//  Created by Daniyar on 11/15/20.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class СourseDetailViewController: UIViewController {
    lazy var courseView = СourseDetailView(withBar: true)
    lazy var viewModel = CourseDetailViewModel()
    lazy var disposeBag = DisposeBag()
    var courseId: Int?
    var course: CourseFull? {
        didSet {
            courseView.course = course
            if course?.images?.isEmpty ?? true {
                let imageView: UIImageView = {
                    let view = UIImageView()
                    view.image = UIImage(named: "image")?.withRenderingMode(.alwaysTemplate)
                    view.tintColor = .customDarkBlue
                    return view
                }()
                courseView.sliderContainer.insertSubview(imageView, aboveSubview: courseView.imageSlider)
                imageView.snp.makeConstraints({
                    $0.center.equalToSuperview()
                    $0.size.equalTo(StaticSize.size(100))
                })
                courseView.imageSlider.isHidden = true
            } else {
                indicatorView = {
                    let view = IndicatorView(number: course?.images?.count ?? 0)
                    return view
                }()
                courseView.sliderContainer.insertSubview(indicatorView!, belowSubview: courseView.pagesView)
                indicatorView?.snp.makeConstraints({
                    $0.bottom.equalToSuperview().offset(StaticSize.size(-12))
                    $0.height.equalTo(StaticSize.size(8))
                    $0.width.equalTo(
                        (CGFloat(course?.images?.count ?? 0) * StaticSize.size(8)) +
                        ((CGFloat(course?.images?.count ?? 0) - 1) * StaticSize.size(10))
                    )
                    $0.centerX.equalToSuperview()
                })
            }
            courseView.pagesLabel.text = "1/\(course?.images?.count ?? 1)"
            courseView.pagesView.isHidden = course?.images?.isEmpty ?? true
            courseView.titleLabel.text = course?.name ?? ""
            courseView.descriptionView.text.text = course?.description ?? ""
            courseView.imageSlider.reloadData()
            courseView.aboutClubView.text.text = course?.user?.profile?.aboutClub
            courseView.contactsView.text.text = course?.user?.profile?.contacts
            
            selectedTimes = AppShared.sharedInstance.cart.items?.filter({ item in
                course?.weekdays?.contains(where: { weekday in
                    weekday.lessonTimes?.contains(where: { time in
                        time.id == item.time?.id
                    }) ?? false
                }) ?? false
            }).map({
                $0.time
            }) as? [LessonTime]
            
            hadSelectedOnStart = !(selectedTimes?.isEmpty ?? true)
            buttonState = !(selectedTimes?.isEmpty ?? true) ?
                .changeSchedule :
                .chooseSchedule
            
            if course?.user?.profile?.websiteUrl == nil {
                courseView.siteButton.disable(color: .white)
            }
        }
    }
    var indicatorView: IndicatorView? 
    var currentPage = 0 {
        didSet {
            if let count = course?.images?.count{
                courseView.setNumber(number: currentPage + 1, total: count)
                indicatorView?.setCurrent(index: currentPage)
            }
        }
    }
    var selectedTimes: [LessonTime]? {
        didSet {
            courseView.scheduleButton.title.text = selectedTimes?.isEmpty ?? true ?
                                                        "Выбрать расписание" :
                                                        "Изменить расписание"
            var text = ""
            for (index, time) in (selectedTimes ?? []).enumerated() {
                let weekday = WeekDays(rawValue: course?.weekdays?.first(where: { weekday in
                    weekday.lessonTimes?.contains(where: { time_ in
                        time.id == time_.id
                    }) ?? false
                })?.day ?? 0)
                text.append("\(weekday?.nameShort ?? "") (\(time.fromTime?.getRange(end: 5) ?? ""))")
                if index != (selectedTimes?.count ?? 0) - 1 {
                    text.append(", ")
                }
            }
            courseView.scheduleButton.subtitle.text = text
        }
    }
    var hadSelectedOnStart: Bool?
    var hadSelectedOnEnd: Bool?
    var buttonState: DetailButtonStates = .chooseSchedule {
        didSet {
            courseView.bottomButton.setTitle(buttonState.rawValue, for: .normal)
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = courseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        courseView.imageSlider.delegate = self
        courseView.imageSlider.dataSource = self
        
        courseView.scheduleButton.addTarget(self, action: #selector(openSchedule), for: .touchUpInside)
        courseView.bottomButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        courseView.siteButton.addTarget(self, action: #selector(openSite), for: .touchUpInside)
        courseView.ratingButton.addTarget(self, action: #selector(openRatings), for: .touchUpInside)
        courseView.chatButton.addTarget(self, action: #selector(openChat), for: .touchUpInside)
        
        bind()
        
        if let id = courseId {
            viewModel.getCourse(id: id)
        }
    }
    
    func bind() {
        viewModel.course.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.course = object
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func openImageSlider(_ button: UIButton) {
        let vc = ImageSliderViewController()
        vc.imageUrls = course?.images
        vc.currentPage = button.tag
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openSchedule() {
        let vc = ScheduleViewController()
        vc.course = course
        vc.superVc = self
        present(vc, animated: true, completion: nil)
    }
    
    @objc func buttonTapped() {
        if buttonState == .chooseSchedule || buttonState == .changeSchedule {
            openSchedule()
        } else {
            AppShared.sharedInstance.cart.clear(courseId: course?.id)
            for time in selectedTimes ?? [] {
                let cartItem = CartItem(time: time, image: course?.images?.first, name: course?.name, courseId: course?.id)
                AppShared.sharedInstance.cart.add(cartItem: cartItem)
            }
            navigationController?.popViewController(animated: true)
            if !(AppShared.sharedInstance.cart.items?.isEmpty ?? true) {
                UIApplication.topViewController()?.present(CartViewController(), animated: true, completion: nil)
            }
        }
    }
    
    @objc func openSite() {
        guard let url = URL(string: course?.user?.profile?.websiteUrl ?? ""), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openRatings() {
        guard let id = course?.id, let url = URL(string: "tg://resolve?domain=UniClub_reviews_bot?start=\(id)"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func openChat() {
        guard let url = URL(string: "tg://resolve?domain=uniclub_chat"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}

extension СourseDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return course?.images?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseImagesDetailCell.reuseIdentifier, for: indexPath) as! CourseImagesDetailCell
        if let imageUrl = course?.images?[indexPath.item] {
            cell.imageView.kf.setImage(with: URL(string: imageUrl))
            cell.button.tag = indexPath.row
            cell.button.addTarget(self, action: #selector(openImageSlider(_:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = courseView.imageSlider.frame.size.width
        let currentPage = (courseView.imageSlider.contentOffset.x / pageWidth)
        self.currentPage = Int(currentPage)
    }
}

