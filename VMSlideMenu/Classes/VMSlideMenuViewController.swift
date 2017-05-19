
import Foundation

@objc public class VMSlideMenuViewController: UIViewController {
    
    // MARK: Properties
    
    let tabs: [MenuTab]
    
    var backgroundColor: UIColor {
        return UIColor.blue // TODO
    }
    
    lazy var tabsCollectionView: UICollectionView = {
        let tabLayout = UICollectionViewFlowLayout()
        tabLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: tabLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.autoresizesSubviews = true
        collectionView.backgroundColor = self.backgroundColor
        collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: TabCollectionViewCell.identifier)

        return collectionView
    }()
    
    lazy var optionsCollectionView: UICollectionView = {
        let optionsLayout = UICollectionViewFlowLayout()
        optionsLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: optionsLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.bounces = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        collectionView.autoresizesSubviews = true
        collectionView.backgroundColor = UIColor.white
        collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        
        return collectionView
    }()
    
    public var height: CGFloat = 44
    
    
    // MARK: - Initialization
 
    public init(withTabs tabs: [MenuTab]) {
        self.tabs = tabs
 
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Lifecycle
    
    public override func viewDidLoad() {
        configureView()
    }
    
    
    func configureView() {
        
        navigationController?.hidesBarsOnSwipe = false
    
        view.addSubview(tabsCollectionView)
        view.addSubview(optionsCollectionView)
        
        tabsCollectionView.selectItem(at: IndexPath(item: 0, section:0), animated: true, scrollPosition: .left)
        
        // Constraints
        let views = ["tabsCollectionView": tabsCollectionView, "optionsCollectionView": optionsCollectionView]
        let metrics = ["margin": 10, "menuHeight": height]
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[tabsCollectionView]|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[optionsCollectionView]|", options: [], metrics: metrics, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[tabsCollectionView(==menuHeight)][optionsCollectionView]|", options: [], metrics: metrics, views: views))
    }
}

extension VMSlideMenuViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == tabsCollectionView {
            
            guard let selectedTabIndexPath = tabsCollectionView.indexPathsForSelectedItems?.first else { return }
            optionsCollectionView.scrollToItem(at: selectedTabIndexPath, at: .left, animated: true)
        }
    }
}

extension VMSlideMenuViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == tabsCollectionView {
            return tabs.count
        } else {
            let selectedTabIndex = tabsCollectionView.indexPathsForSelectedItems?.first?.row ?? 0
            return tabs[selectedTabIndex].options.count
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tabsCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabCollectionViewCell.identifier, for: indexPath) as! TabCollectionViewCell
            
            cell.summary = tabs[indexPath.row].summary
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectionCollectionViewCell.identifier, for: indexPath) as! SectionCollectionViewCell
            
            // TODO
            
            return cell
        }
    }
}

extension VMSlideMenuViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tabsCollectionView {
            
            let width = collectionView.bounds.width / CGFloat(tabs.count)
        
            return CGSize(width: width, height: height)
            
        } else {
            
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension VMSlideMenuViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
//        guard !tabsCollectionView.isUserInteractionEnabled else { return }
        
//        let offsetX = scrollView.contentOffset.x
//        let currentIndexPath = tabsCollectionView.indexPathsForSelectedItems?.first
        
        
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard scrollView != optionsCollectionView else { return }
        
        let pageWidth = scrollView.bounds.width
        let x = scrollView.contentOffset.x
        let page = Int(floor((x - (pageWidth / 2)) / pageWidth) + 1)
        
        let indexPath = IndexPath(item: page, section: 0)
        
        tabsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        tabsCollectionView.isUserInteractionEnabled = true
    }
}
