//
//  MediaListViewController.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//

import UIKit
import SnapKit
import RxCocoa

fileprivate enum FileConstants {
    static let cellMarginSpacing: CGFloat = 24
    static let cellSizeRatio: CGFloat = 1.5
    static let loadMoreThreshold: CGFloat = 160
}

// MARK: - Type Aliases
typealias MovieListViewController = MediaListViewController<Movie, MovieDetails>
typealias TvShowListViewController = MediaListViewController<TvShow, TvShowDetails>

class MediaListViewController<Item: MediaItem, Details: MediaItemDetails>: BaseViewController, UICollectionViewDelegateFlowLayout, ScrollableViewController, UIScrollViewDelegate {
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemPurple
        return refreshControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.refreshControl = refreshControl
        return scrollView
    }()
    
    private lazy var scrollContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var horizontalMenuView: HorizontalMenuView = {
        HorizontalMenuView()
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = SelfSizedCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelection = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.register(MediaListCell.self)
        return collectionView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .systemPurple
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.frame.width - FileConstants.cellMarginSpacing * 3
        let itemWidth = availableWidth / 2
        let itemHeight = itemWidth * FileConstants.cellSizeRatio
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: FileConstants.cellMarginSpacing, bottom: 0, right: FileConstants.cellMarginSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        FileConstants.cellMarginSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        FileConstants.cellMarginSpacing
    }
    
    // MARK: - ScrollableViewController
    func scrollToTop() {
        let topOffset = CGPoint(x: 0, y: -scrollView.adjustedContentInset.top)
        scrollView.setContentOffset(topOffset, animated: true)
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        checkForInfiniteScroll()
    }
}

// MARK: - Private Methods
extension MediaListViewController {
    private func setupBindings() {
        guard let specificViewModel = viewModel as? MediaListViewModel<Item, Details> else { return }
        let viewModelInput = specificViewModel.input as! MediaListViewModelInput<Item>
        let viewModelOutput = specificViewModel.output as! MediaListViewModelOutput<Item, Details>
        
        refreshControl.rx.controlEvent(.valueChanged)
            .do(onNext: { _ in
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            })
            .bind(to: viewModelInput.refreshTrigger)
            .disposed(by: disposeBag)
        
        horizontalMenuView.genreSelected
            .do(onNext: { _ in
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            })
            .bind(to: viewModelInput.genreSelected)
            .disposed(by: disposeBag)
        
        viewModelOutput.genresDataSource
            .asDriver(onErrorJustReturn: [])
                .drive(onNext: horizontalMenuView.configureButtons)
                .disposed(by: disposeBag)
        
        viewModelOutput.itemsWithDetailsDataSource
            .asDriver(onErrorJustReturn: [])
            .drive(collectionView.rx.items(
                cellIdentifier: MediaListCell.reuseIdentifier,
                cellType: MediaListCell.self
            )) { index, itemWithDetails, cell in
                cell.configure(item: itemWithDetails.item)
                cell.configure(details: itemWithDetails.details)
                if itemWithDetails.details == nil {
                    viewModelInput.fetchItemDetails.onNext(itemWithDetails.item)
                }
            }
            .disposed(by: disposeBag)
        
        viewModelOutput.isLoading
            .asDriver(onErrorJustReturn: false)
            .flatMapLatest { isLoading in
                if isLoading {
                    return Driver.just(isLoading)
                } else {
                    return Driver.just(isLoading).delay(.milliseconds(500))
                }
            }
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading {
                    self.loadingIndicator.startAnimating()
                } else {
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        scrollView.addSubview(scrollContainerView)
        scrollContainerView.addSubview(horizontalMenuView)
        scrollContainerView.addSubview(collectionView)
        scrollContainerView.addSubview(loadingIndicator)
        view.addSubview(scrollView)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        horizontalMenuView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(horizontalMenuView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(24)
            $0.bottom.equalToSuperview().offset(-32).priority(.high)
        }
    }
    
    private func checkForInfiniteScroll() {
        guard let specificViewModel = viewModel as? MediaListViewModel<Item, Details> else { return }
        let viewModelInput = specificViewModel.input as! MediaListViewModelInput<Item>
        let scrollView = self.scrollView
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.height
        let scrollOffset = scrollView.contentOffset.y
        if scrollOffset + scrollViewHeight >= contentHeight - FileConstants.loadMoreThreshold {
            viewModelInput.loadNextPageTrigger.onNext(())
        }
    }
}
