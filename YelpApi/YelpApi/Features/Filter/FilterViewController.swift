//
//  FilterViewController.swift
//  YelpApi
//
//  Created by Huy Lam on 22/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

typealias Filter = (searchTerm: String, location: String, category: CategoryFilter, sorting: RequestSorting?)

class FilterViewController: UIViewController {
  private var viewModel = FilterViewModel()
  private let disposeBag = DisposeBag()
  @IBOutlet weak var searchTermTextField: UITextField!
  @IBOutlet weak var locationTextField: UITextField!
  @IBOutlet weak var categorySegment: UISegmentedControl!
  @IBOutlet weak var sortingSegment: UISegmentedControl!
  var applyNewFilter: ((Filter) -> Void)?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchTermTextField
      .rx
      .text
      .subscribe(onNext: { [weak self] newValue in
        self?.viewModel.onSearchTermChanged(newValue ?? "")
      })
      .disposed(by: disposeBag)
    
    locationTextField
      .rx
      .text
      .subscribe(onNext: { [weak self] newValue in
        self?.viewModel.onLocationChanged(newValue ?? "")
      })
      .disposed(by: disposeBag)
    
    categorySegment
      .rx
      .value
      .subscribe(onNext: { [weak self] newValue in
        switch newValue {
        case 0:
          self?.viewModel.onCategoryChanged(.football)
        case 1:
          self?.viewModel.onCategoryChanged(.surfing)
        case 2:
          self?.viewModel.onCategoryChanged(.fencing)
        default:
          self?.viewModel.onCategoryChanged(.all)
        }
      })
      .disposed(by: disposeBag)
    
    sortingSegment
      .rx
      .value
      .subscribe(onNext: { [weak self] newValue in
        switch newValue {
        case 0:
          self?.viewModel.onSortingChanged(.rating)
        case 1:
          self?.viewModel.onSortingChanged(.distance)
        default:
          self?.viewModel.onSortingChanged(nil)
        }
      })
      .disposed(by: disposeBag)
  }
  
  @IBAction func applyButtonDidTapped() {
    let filter = (
      searchTerm: (try? viewModel.searchTerm.value()) ?? "",
      location: (try? viewModel.location.value()) ?? "",
      category: (try? viewModel.category.value()) ?? .all,
      sorting: try? viewModel.sorting.value()
    )
    applyNewFilter?(filter)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelButtonDidTapped() {
    dismiss(animated: true, completion: nil)
  }
}
