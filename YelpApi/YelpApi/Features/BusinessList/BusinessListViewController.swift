//
//  BusinessListViewController.swift
//  YelpApi
//
//  Created by Huy Lam on 22/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BusinessListViewController: UIViewController {
  private lazy var viewModel: BusinessListViewModel = {
    let viewModel = BusinessListViewModel()
    viewModel.businessService = BusinessServiceImp()
    return viewModel
  }()
  private var disposeBag = DisposeBag()
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var loadingView: UIActivityIndicatorView!
  let refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.tableFooterView = UIView()
    tableView.delegate = self
    tableView.dataSource = self
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    title = "Businesses Board"
    
    setupBinding()
  }
  
  func setupBinding() {
    viewModel.state
      .asDriver(onErrorJustReturn: .error(.custom(message: "Smthing went wrong")))
      .drive(onNext: { [weak self] state in
        self?.onStateChanged(state)
      })
      .disposed(by: disposeBag)
  }
  
  @objc private func refresh() {
    viewModel.onRefresh()
  }
  
  @IBAction func settingButtonDidTapped(_ sender: Any) {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let filterVC = storyBoard.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
    filterVC.applyNewFilter = { [weak self] filter in
      self?.tableView.setContentOffset(.zero, animated: true)
      self?.loadingView.startAnimating()
      self?.viewModel.onFilterChanged(newSearchTerm: filter.searchTerm,
                                      newCategory: filter.category,
                                      newLocation: filter.location,
                                      newSorting: filter.sorting)
    }
    present(filterVC, animated: true, completion: nil)
  }
  
  private func onStateChanged(_ newState: BusinessListViewModel.ViewStates) {
    switch newState {
    case .initial:
      loadingView.startAnimating()
      viewModel.onRefresh()
    case .loaded:
      loadingView.stopAnimating()
      refreshControl.endRefreshing()
      tableView.reloadData()
    case .loading:
      tableView.reloadData()
    case .error(let error):
      showAlert(with: error.localizedDescription)
    }
  }
  
  private func showAlert(with message: String) {
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
      self?.viewModel.onTapErrorCta()
      self?.dismiss(animated: true, completion: nil)
    }))
    present(alert, animated: true, completion: nil)
  }
}

extension BusinessListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let state = try? viewModel.state.value() else {
      return 0
    }
    switch (state) {
    case .initial:
      return 0
    case .loading:
      return viewModel.businessList.count + (viewModel.businessList.isEmpty ? 0 : 1)
    case let .loaded(canLoadMore) where canLoadMore:
      return viewModel.businessList.count + 1
    default:
      return viewModel.businessList.count
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row >= viewModel.businessList.count {
      let cell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell", for: indexPath) as! LoadMoreCell
      cell.loadingView.startAnimating()
      return cell
    }
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.textLabel?.text = viewModel.businessList[indexPath.row].name
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.row >= viewModel.businessList.count { return }
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyBoard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    vc.business = viewModel.businessList[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if cell.reuseIdentifier == "LoadMoreCell" {
      viewModel.onLoadmore()
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44.0
  }
}
